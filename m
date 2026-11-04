Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139F3606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Quezjfia;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ODwAvnul;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Cl7g06Tg;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WS1OSnC7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tmBfPnkCwvoI4cdngY7Noo7L8gEvUplpS93bNa6vZic=; b=QuezjfiadlkToeBsV41XcFUWrY
	RrZpr9DHrNjKrJK4CO+UTJ6ctUt3sJAQSsySTWOkyLlakX1/hIzTsO/3gTmT0zgzEx5iJSkU+1YyY
	LJFPhvH30K4CeAwTICan5tg3p92+DkNMjlT6gwc4zUgPL22+b5Ahx0VkMPQddC9UWh7s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOc01-000000002VH-1hm4;
	Wed, 04 Nov 2026 14:30:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOc00-000000002V5-0CHO
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 14:30:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d57FY9MFSKANnVTqh8cpL2VAJZyz3TYP5MGcEmV+WDY=; b=ODwAvnul80QZemQyueAPhy4GZo
 IQmEzx/lmlhIjhGQDoZnV8hDthyyChHaByu0LNzNw/QwEinvirlg37dzeQts6KFEh4mI5BPbbUlWy
 G13poQpBns+3Iyt67UoOg3nAsXjQjJLX06HPAa8lx1ZL93LHkXlTwBKecCbIOyy1emJU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d57FY9MFSKANnVTqh8cpL2VAJZyz3TYP5MGcEmV+WDY=; b=Cl7g06TghKnoNqGtL15lnGtJBa
 lWKEcAVM2dOg0D6qx+j1NdXcYQilS3dXTzx+GyoP2l0bSV+7KwxENwqz7ZYVD6jBR3SvtNfF3owQz
 K8U+7hRiWny5X+s0QeMfoZQ2bZaSNJRq+55Frsa0IQ6HvXGZ1PunsGmVqIeurLdosmKU=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xObzw-0000000035Y-3eR1 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 14:29:59 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso5925085e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 06:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793802590; x=1794407390; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=d57FY9MFSKANnVTqh8cpL2VAJZyz3TYP5MGcEmV+WDY=;
 b=WS1OSnC7vDOxBoTRHnJPvlnBQPe7DrD3ho09z90EEOcYP0+VxZsClR9tgnAzGkwDe0
 jVD2/TSjUQGxzqJvKKDgYSMh0oW5L9mH12Y5aGeceUBz63EQEZEu6YG4qOtbmaeefBNl
 Z+ER6UZ/Qm1KXtVy1cUKS82yB38r1WkOiN6xrUFKHb7FpRDd6tzZ0HJbYBIDnOrT9USU
 ui7ub5Y/gElkmA8fb4BpAGQBefdUThzAFR/VuqG7kZFRfNAtx79cgGrHLI15umbFRg+q
 ELyQ33snbJKWV1SCgwVxKR+qQY5zXLuCjrjglewd6D0ETuymUY01lUcH4sfDLJ+lRcy6
 7ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793802590; x=1794407390;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=d57FY9MFSKANnVTqh8cpL2VAJZyz3TYP5MGcEmV+WDY=;
 b=teV/t25Q7ogeRI5W3YW8HkeCW5u8MC66lfVKBLo+p2PhhcJXu4xWUfemwT29/GlI4K
 iJdi/mMkMo7a0fsesMP4YdsD8ZGm4aTfHZddssPvYMGIFokPwdJDLXF4HURPY87gQJKv
 xyM+C3vB3NUDN89O4IPoONziMDBTuEKDyl7BOXtFtiLvwUdQ28kJtPD3o6gMwOeX7MiX
 u7y7F1Mkf/81YCVEwJ7N9yTte4sPwcTl3vfZS8SF09ACLCTo2dQBWAQqnAuE8pa1Uw9O
 PCtqhso2X99EM8EBAIYSwDEWvfLy2z30IVEEbNy3dApnv15RC6eMLlzu8v4f76FjBc+l
 +gIA==
X-Gm-Message-State: APuU4Z99Ke4Nbzfl4T/wMesExGDNWA7U+WLrWLjPrrnoFbwmPwnLfBDV
 jwHRkXBlv5v/nbZVGahWm9Amki5zvSrBB+XDBKbD7sVoofwXKXaKTY5djslSt8n2ZPOwPXLXTWS
 2vtFaTHpTZy05gf4SWRKAWDAESFXTVfexlcNMt8k+FCpILt+t+Pvf8/IUd364Y5lC0OurTamrJY
 oqb1vYDA==
X-Gm-Gg: AYBFou23MzoWKcECakNEYOOmFeQumhzqSapVcbbRHnBZogk4dWFAIwB4PJF8OyN/YvD
 FgB8kQDgM0el37jOng5nypbTpNEu5UO9dk156JG27J7VwGVwAEI23xE5DsR0vspcrjxzTinSXMA
 MOjKbwvgtKJFFVGEwu8bCpH+gDDCTpGfd9ffhO48sp2cTJD9El/TriA1+AXPlqvyaGcVBZ5xzcZ
 tSDbcbq/lCvmkv3CC7+gx1bSqbmuy48Uvxnf9x6RncFiUe/zHzejfD1/1cWSMydiizNmmNG3x9r
 kCq9KJYBVBG1BYWfjIilvT9Mx5//ouaVb4VyB0gqBwtPxQ/EOk8XeKajpTpWWrcsUIRi8ltnCMI
 4NyVnRuMlEvQ/G+z+sKUWBKOFYtFvpmY9HNzRll6wLy57U40wqXiLL+Ktjrw8PrNvZGb4jGS+6p
 F03abjj126bkCW9S78yAF3B+S72VKDdH9UwmBMfIRvM1GmVvhQdfJZU+NfXX55IbAPpayQ27aAt
 S+W6RyEm8Df+POS9bRruT5uzx5RqeLg20w7kvkjS7fPyOigFPbrZOFcy2gAcS6hB+RuVxkMk4kV
 mrDPeG3KrGlddZFd3w6d+/F4tgnZ1i9R7Z1IUd64OJeRXY5sjPSgZ/RpNn6TByrGTJnFAXEhfgX
 lwcUu+exEaMbZib5WFHMRzW2pl6exhHBcPQpDU6MJzhg+eWc9STI3icJ0xBoi05efUSJzlbqAer
 fXrsAwEij1yr7DWw==
X-Received: by 2002:a05:600c:6087:b0:49f:f099:6fb1 with SMTP id
 5b1f17b1804b1-4ac17753befmr364113555e9.15.1793802589914; 
 Wed, 04 Nov 2026 06:29:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43c748105sm56113135e9.6.2026.11.04.06.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 06:29:49 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 14:29:40 +0000
To: Ralf Lici <ralf@mandelbit.com>,
	Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 32
X-Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
X-Gerrit-Change-Number: 1749
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1749?usp=email>
X-Gerrit-Commit: 0200c99493db3dbf9e8a7c15c90fbaf7b6e956e5
In-Reply-To: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
References: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk3ZDg1NDZkYTllZjA2YzIyMjZlYTc3ZTQ2MWY5NTUwZDI0ODk0YzYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <41ee4f9a422246ac1c2c909c7e57581fdee99db8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xObzw-0000000035Y-3eR1
Subject: [Openvpn-devel] [M] Change in openvpn[master]: init: Extract
 init_tls_wrap_ctx() control-channel wrap helper
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6115988221412935015=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6115988221412935015==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+lJ7WIBpUxs="; charset=UTF-8

--+lJ7WIBpUxs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Lev Stipakov, Ralf Lici=
=2E

Hello Arne Schwabe, Ralf Lici, 

I'd like you to reexamine a change=2E=
 Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Dem=
ail

to look at the new patch set (#32)=2E


Change subject: init: Extract =
init_tls_wrap_ctx() control-channel wrap helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

init: Extract init_tls_wrap_ctx() contro=
l-channel wrap helper

Factor the tls-auth/tls-crypt wrapping-context setup=
 out of
do_init_crypto_tls() into a reusable init_tls_wrap_ctx() helper, an=
d
expose it in init=2Eh together with do_init_tls_wrap_key(), which now
tak=
es the connection entry to read its keys from instead of using
options=2Ece=
=2E Both call sites pass &c->options=2Ece, so there is no behavior
change=
=2E

A planned server-probe feature will use the helper to build the wrappi=
ng
context before a connection exists, so that a probe can be wrapped with
=
tls-auth/tls-crypt like any other control packet=2E

Change-Id: I7d8546da9e=
f06c2226ea77e461f9550d24894c61
Signed-off-by: Lev Stipakov <lev@openvpn=2En=
et>
---
M src/openvpn/init=2Ec
M src/openvpn/init=2Eh
2 files changed, 79 i=
nsertions(+), 37 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/49/1749/32

diff --git a/src/openvpn/init=2Ec b/src=
/openvpn/init=2Ec
index ff3bfe5=2E=2Ebea8e60 100644
--- a/src/openvpn/init=
=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3097,13 +3097,13 @@
 /*
  * Initialize =
the tls-auth/crypt key context
  */
-static void
-do_init_tls_wrap_key(stru=
ct context *c)
+void
+do_init_tls_wrap_key(struct context *c, const struct =
connection_entry *ce)
 {
     const struct options *options =3D &c->options=
;
 
     /* TLS handshake authentication (--tls-auth) */
-    if (options->=
ce=2Etls_auth_file)
+    if (ce->tls_auth_file)
     {
         /* Initiali=
ze key_type for tls-auth with auth only */
         CLEAR(c->c1=2Eks=2Etls_=
auth_key_type);
@@ -3118,33 +3118,31 @@
         }
 
         crypto_read_o=
penvpn_key(&c->c1=2Eks=2Etls_auth_key_type, &c->c1=2Eks=2Etls_wrap_key,
-  =
                              options->ce=2Etls_auth_file, options->ce=2Etl=
s_auth_file_inline,
-                                options->ce=2Ekey_dire=
ction, "Control Channel Authentication",
-                                "=
tls-auth", &c->c1=2Eks=2Eoriginal_wrap_keydata);
+                         =
       ce->tls_auth_file, ce->tls_auth_file_inline, ce->key_direction,
+   =
                             "Control Channel Authentication", "tls-auth",
=
+                                &c->c1=2Eks=2Eoriginal_wrap_keydata);
    =
 }
 
     /* TLS handshake encryption+authentication (--tls-crypt) */
-    =
if (options->ce=2Etls_crypt_file)
+    if (ce->tls_crypt_file)
     {
     =
    tls_crypt_init_key(&c->c1=2Eks=2Etls_wrap_key, &c->c1=2Eks=2Eoriginal_w=
rap_keydata,
-                           options->ce=2Etls_crypt_file, opti=
ons->ce=2Etls_crypt_file_inline,
-                           options->tls_s=
erver);
+                           ce->tls_crypt_file, ce->tls_crypt_file_=
inline, options->tls_server);
     }
 
     /* tls-crypt with client-specif=
ic keys (--tls-crypt-v2) */
-    if (options->ce=2Etls_crypt_v2_file)
+    =
if (ce->tls_crypt_v2_file)
     {
         if (options->tls_server)
       =
  {
             tls_crypt_v2_init_server_key(&c->c1=2Eks=2Etls_crypt_v2_se=
rver_key, true,
-                                         options->ce=2Etls=
_crypt_v2_file,
-                                         options->ce=2Etls=
_crypt_v2_file_inline);
+                                         ce->tls_c=
rypt_v2_file, ce->tls_crypt_v2_file_inline);
         }
         else
     =
    {
             tls_crypt_v2_init_client_key(&c->c1=2Eks=2Etls_wrap_key,=
 &c->c1=2Eks=2Eoriginal_wrap_keydata,
-                                    =
     &c->c1=2Eks=2Etls_crypt_v2_wkc, options->ce=2Etls_crypt_v2_file,
-    =
                                     options->ce=2Etls_crypt_v2_file_inline=
);
+                                         &c->c1=2Eks=2Etls_crypt_v2_wkc=
, ce->tls_crypt_v2_file,
+                                         ce->tls_=
crypt_v2_file_inline);
         }
         /* We have to ensure that the lo=
aded tls-crypt key is small enough
          * to fit into the initial hard=
 reset v3 packet */
@@ -3153,18 +3151,45 @@
         /* empty ACK/message i=
d, tls-crypt, Opcode, UDP, ipv6 */
         int required_size =3D 5 + wkc_l=
en + tls_crypt_buf_overhead() + 1 + 8 + 40;
 
-        if (required_size > =
c->options=2Ece=2Etls_mtu)
+        if (required_size > ce->tls_mtu)
      =
   {
             msg(M_WARN,
                 "ERROR: tls-crypt-v2 client =
key too large to work with "
                 "requested --max-packet-size =
%d, requires at least "
                 "--max-packet-size %d=2E Packets w=
ill ignore requested "
                 "maximum packet size",
-           =
     c->options=2Ece=2Etls_mtu, required_size);
+                ce->tls_mt=
u, required_size);
         }
     }
 }
 
+void
+init_tls_wrap_ctx(struct t=
ls_wrap_ctx *tls_wrap, const struct connection_entry *ce, bool tls_client,
=
+                  const struct key_schedule *ks, struct packet_id_persist =
*pid_persist)
+{
+    CLEAR(*tls_wrap);
+
+    /* TLS handshake authenticat=
ion (--tls-auth) */
+    if (ce->tls_auth_file)
+    {
+        tls_wrap->m=
ode =3D TLS_WRAP_AUTH;
+    }
+
+    /* TLS handshake encryption (--tls-cry=
pt) */
+    if (ce->tls_crypt_file || (ce->tls_crypt_v2_file && tls_client)=
)
+    {
+        tls_wrap->mode =3D TLS_WRAP_CRYPT;
+    }
+
+    if (tls_=
wrap->mode =3D=3D TLS_WRAP_AUTH || tls_wrap->mode =3D=3D TLS_WRAP_CRYPT)
+ =
   {
+        tls_wrap->opt=2Ekey_ctx_bi =3D ks->tls_wrap_key;
+        tls=
_wrap->opt=2Epid_persist =3D pid_persist;
+        tls_wrap->opt=2Eflags |=
=3D CO_PACKET_ID_LONG_FORM;
+        tls_wrap->original_wrap_keydata =3D ks=
->original_wrap_keydata;
+    }
+}
+
 /*
  * Initialize the persistent comp=
onent of OpenVPN's TLS mode,
  * which is preserved across SIGUSR1 resets=
=2E
@@ -3236,7 +3261,7 @@
         init_key_type(&c->c1=2Eks=2Ekey_type, ci=
phername, options->authname, true, warn);
 
         /* initialize tls-auth=
/crypt/crypt-v2 key */
-        do_init_tls_wrap_key(c);
+        do_init_t=
ls_wrap_key(c, &c->options=2Ece);
 
         /* initialise auth-token crypt=
o support */
         if (c->options=2Eauth_token_generate)
@@ -3261,7 +328=
6,7 @@
          * tls-auth/crypt key can be configured per connection bloc=
k, therefore
          * we must reload it as it may have changed
         =
 */
-        do_init_tls_wrap_key(c);
+        do_init_tls_wrap_key(c, &c->=
options=2Ece);
     }
 }
 
@@ -3439,25 +3464,9 @@
         to=2Eekm_size =
=3D 0;
     }
 
-    /* TLS handshake authentication (--tls-auth) */
-    i=
f (options->ce=2Etls_auth_file)
-    {
-        to=2Etls_wrap=2Emode =3D TL=
S_WRAP_AUTH;
-    }
-
-    /* TLS handshake encryption (--tls-crypt) */
-  =
  if (options->ce=2Etls_crypt_file || (options->ce=2Etls_crypt_v2_file && o=
ptions->tls_client))
-    {
-        to=2Etls_wrap=2Emode =3D TLS_WRAP_CRYP=
T;
-    }
-
-    if (to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etls_=
wrap=2Emode =3D=3D TLS_WRAP_CRYPT)
-    {
-        to=2Etls_wrap=2Eopt=2Eke=
y_ctx_bi =3D c->c1=2Eks=2Etls_wrap_key;
-        to=2Etls_wrap=2Eopt=2Epid_=
persist =3D &c->c1=2Epid_persist;
-        to=2Etls_wrap=2Eopt=2Eflags |=3D=
 CO_PACKET_ID_LONG_FORM;
-        to=2Etls_wrap=2Eoriginal_wrap_keydata =3D=
 c->c1=2Eks=2Eoriginal_wrap_keydata;
-    }
+    /* Control-channel wrappin=
g (--tls-auth / --tls-crypt) */
+    init_tls_wrap_ctx(&to=2Etls_wrap, &c->=
options=2Ece, options->tls_client, &c->c1=2Eks,
+                      &c->=
c1=2Epid_persist);
 
     if (options->ce=2Etls_crypt_v2_file)
     {
diff =
--git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh
index c486158=2E=2E6783=
4a9 100644
--- a/src/openvpn/init=2Eh
+++ b/src/openvpn/init=2Eh
@@ -73,6 +=
73,39 @@
 
 void do_test_crypto(struct context *o);
 
+/**
+ * @brief Load =
the tls-auth/tls-crypt(-v2) key material into c->c1=2Eks=2E
+ *
+ * Reads t=
he key from the file configured on connection entry ce (--tls-auth,
+ * --t=
ls-crypt or --tls-crypt-v2); a no-op when none of them is set=2E May be
+ *=
 called more than once (the key can be configured per connection block, so =
it
+ * is reloaded for each connection)=2E
+ *
+ * @param c  The context wh=
ose c1=2Eks key schedule is populated=2E
+ * @param ce The connection entry=
 whose tls-wrap key file is loaded=2E
+ */
+void do_init_tls_wrap_key(struc=
t context *c, const struct connection_entry *ce);
+
+/**
+ * @brief Configu=
re a control-channel wrapping context from a connection entry
+ *        an=
d previously loaded tls-wrap key material=2E
+ *
+ * Sets tls_wrap to TLS_W=
RAP_AUTH (--tls-auth) or TLS_WRAP_CRYPT
+ * (--tls-crypt / client --tls-cry=
pt-v2) and installs the key context, or
+ * leaves it in TLS_WRAP_NONE when=
 neither is configured=2E The key material must
+ * already have been loade=
d with do_init_tls_wrap_key()=2E tls-crypt-v2 specifics
+ * (the wrapped cl=
ient key and the server key) are left to the caller=2E
+ *
+ * @param tls_w=
rap    The wrapping context to configure=2E
+ * @param ce          The conn=
ection entry selecting the wrapping mode=2E
+ * @param tls_client  Whether =
this is a TLS client (selects tls-crypt-v2 mode)=2E
+ * @param ks          =
Key schedule holding the loaded tls-wrap key material=2E
+ * @param pid_per=
sist Packet-id persistence object to attach to the context=2E
+ */
+void in=
it_tls_wrap_ctx(struct tls_wrap_ctx *tls_wrap, const struct connection_entr=
y *ce,
+                       bool tls_client, const struct key_schedule *=
ks,
+                       struct packet_id_persist *pid_persist);
+
 void=
 context_gc_free(struct context *c);
 
 bool do_up(struct context *c, bool =
pulled_options, uint64_t option_types_found);

-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
Ge=
rrit-Change-Number: 1749
Gerrit-PatchSet: 32
Gerrit-Owner: Lev Stipakov <ls=
tipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ralf Lici =
<ralf@mandelbit=2Ecom>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2Eco=
m>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--+lJ7WIBpUxs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Lev Stipakov, Ralf Lici=2E </p>
<p>Lev =
Stipakov <strong>uploaded patch set #32</strong> to this change=2E</p><p><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail">View =
Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">init: Extract init_tls_wrap_ctx() control-chann=
el wrap helper<br><br>Factor the tls-auth/tls-crypt wrapping-context setup =
out of<br>do_init_crypto_tls() into a reusable init_tls_wrap_ctx() helper, =
and<br>expose it in init=2Eh together with do_init_tls_wrap_key(), which no=
w<br>takes the connection entry to read its keys from instead of using<br>o=
ptions=2Ece=2E Both call sites pass &amp;c-&gt;options=2Ece, so there is no=
 behavior<br>change=2E<br><br>A planned server-probe feature will use the h=
elper to build the wrapping<br>context before a connection exists, so that =
a probe can be wrapped with<br>tls-auth/tls-crypt like any other control pa=
cket=2E<br><br>Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61<br>Sign=
ed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/i=
nit=2Ec<br>M src/openvpn/init=2Eh<br>2 files changed, 79 insertions(+), 37 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/49/1749/32</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/i=
nit=2Ec b/src/openvpn/init=2Ec</span><br><span>index ff3bfe5=2E=2Ebea8e60 1=
00644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/=
openvpn/init=2Ec</span><br><span>@@ -3097,13 +3097,13 @@</span><br><span> /=
*</span><br><span>  * Initialize the tls-auth/crypt key context</span><br><=
span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_init_tls_wrap_key(s=
truct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_init_tls_wrap_=
key(struct context *c, const struct connection_entry *ce)</span><br><span> =
{</span><br><span>     const struct options *options =3D &amp;c-&gt;options=
;</span><br><span> </span><br><span>     /* TLS handshake authentication (-=
-tls-auth) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
options-&gt;ce=2Etls_auth_file)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (ce-&gt;tls_auth_file)</span><br><span>     {</span><br>=
<span>         /* Initialize key_type for tls-auth with auth only */</span>=
<br><span>         CLEAR(c-&gt;c1=2Eks=2Etls_auth_key_type);</span><br><spa=
n>@@ -3118,33 +3118,31 @@</span><br><span>         }</span><br><span> </spa=
n><br><span>         crypto_read_openvpn_key(&amp;c-&gt;c1=2Eks=2Etls_auth_=
key_type, &amp;c-&gt;c1=2Eks=2Etls_wrap_key,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                options-&gt;ce=2Etls=
_auth_file, options-&gt;ce=2Etls_auth_file_inline,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                options-&gt;ce=
=2Ekey_direction, &quot;Control Channel Authentication&quot;,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                                &qu=
ot;tls-auth&quot;, &amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
 ce-&gt;tls_auth_file, ce-&gt;tls_auth_file_inline, ce-&gt;key_direction,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
           &quot;Control Channel Authentication&quot;, &quot;tls-auth&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
              &amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata);</span><br><span>=
     }</span><br><span> </span><br><span>     /* TLS handshake encryption+a=
uthentication (--tls-crypt) */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (options-&gt;ce=2Etls_crypt_file)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (ce-&gt;tls_crypt_file)</span><br><spa=
n>     {</span><br><span>         tls_crypt_init_key(&amp;c-&gt;c1=2Eks=2Et=
ls_wrap_key, &amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                           options-&gt;c=
e=2Etls_crypt_file, options-&gt;ce=2Etls_crypt_file_inline,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                           options-&g=
t;tls_server);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                      ce-&gt;tls_crypt_file, ce-&gt;tls_crypt_file_inline, =
options-&gt;tls_server);</span><br><span>     }</span><br><span> </span><br=
><span>     /* tls-crypt with client-specific keys (--tls-crypt-v2) */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;ce=2Et=
ls_crypt_v2_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (ce-&gt;tls_crypt_v2_file)</span><br><span>     {</span><br><span>    =
     if (options-&gt;tls_server)</span><br><span>         {</span><br><span=
>             tls_crypt_v2_init_server_key(&amp;c-&gt;c1=2Eks=2Etls_crypt_v=
2_server_key, true,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                                       options-&gt;ce=2Etls_crypt_v2_file,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
                   options-&gt;ce=2Etls_crypt_v2_file_inline);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
         ce-&gt;tls_crypt_v2_file, ce-&gt;tls_crypt_v2_file_inline);</span>=
<br><span>         }</span><br><span>         else</span><br><span>        =
 {</span><br><span>             tls_crypt_v2_init_client_key(&amp;c-&gt;c1=
=2Eks=2Etls_wrap_key, &amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
          &amp;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc, options-&gt;ce=2Etls_crypt=
_v2_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                             options-&gt;ce=2Etls_crypt_v2_file_inline);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
                   &amp;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc, ce-&gt;tls_crypt_=
v2_file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                              ce-&gt;tls_crypt_v2_file_inline);</span><br><=
span>         }</span><br><span>         /* We have to ensure that the load=
ed tls-crypt key is small enough</span><br><span>          * to fit into th=
e initial hard reset v3 packet */</span><br><span>@@ -3153,18 +3151,45 @@</=
span><br><span>         /* empty ACK/message id, tls-crypt, Opcode, UDP, ip=
v6 */</span><br><span>         int required_size =3D 5 + wkc_len + tls_cryp=
t_buf_overhead() + 1 + 8 + 40;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (required_size &gt; c-&gt;options=2Ec=
e=2Etls_mtu)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (required_size &gt; ce-&gt;tls_mtu)</span><br><span>         {</span><b=
r><span>             msg(M_WARN,</span><br><span>                 &quot;ERR=
OR: tls-crypt-v2 client key too large to work with &quot;</span><br><span> =
                &quot;requested --max-packet-size %d, requires at least &qu=
ot;</span><br><span>                 &quot;--max-packet-size %d=2E Packets =
will ignore requested &quot;</span><br><span>                 &quot;maximum=
 packet size&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              c-&gt;options=2Ece=2Etls_mtu, required_size);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                ce-&gt;tls_mtu, req=
uired_size);</span><br><span>         }</span><br><span>     }</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_tls_w=
rap_ctx(struct tls_wrap_ctx *tls_wrap, const struct connection_entry *ce, b=
ool tls_client,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
              const struct key_schedule *ks, struct packet_id_persist *pid_=
persist)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*tls_wrap);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* TLS handshake authentication (--tls-aut=
h) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt=
;tls_auth_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&=
gt;mode =3D TLS_WRAP_AUTH;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* TLS handshake encry=
ption (--tls-crypt) */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (ce-&gt;tls_crypt_file || (ce-&gt;tls_crypt_v2_file &amp;&amp; tl=
s_client))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&gt;mo=
de =3D TLS_WRAP_CRYPT;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (tls_wrap-&gt;mode =3D=
=3D TLS_WRAP_AUTH || tls_wrap-&gt;mode =3D=3D TLS_WRAP_CRYPT)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        tls_wrap-&gt;opt=2Ekey_ctx_bi =3D ks-&g=
t;tls_wrap_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    tls_wrap-&gt;opt=2Epid_persist =3D pid_persist;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&gt;opt=2Eflags |=3D CO_=
PACKET_ID_LONG_FORM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        tls_wrap-&gt;original_wrap_keydata =3D ks-&gt;original_wrap_keydat=
a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Initiali=
ze the persistent component of OpenVPN&#39;s TLS mode,</span><br><span>  * =
which is preserved across SIGUSR1 resets=2E</span><br><span>@@ -3236,7 +326=
1,7 @@</span><br><span>         init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type=
, ciphername, options-&gt;authname, true, warn);</span><br><span> </span><b=
r><span>         /* initialize tls-auth/crypt/crypt-v2 key */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        do_init_tls_wrap_key(c);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        do_init_tls_wr=
ap_key(c, &amp;c-&gt;options=2Ece);</span><br><span> </span><br><span>     =
    /* initialise auth-token crypto support */</span><br><span>         if =
(c-&gt;options=2Eauth_token_generate)</span><br><span>@@ -3261,7 +3286,7 @@=
</span><br><span>          * tls-auth/crypt key can be configured per conne=
ction block, therefore</span><br><span>          * we must reload it as it =
may have changed</span><br><span>          */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        do_init_tls_wrap_key(c);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        do_init_tls_wrap_key(c, &amp;c=
-&gt;options=2Ece);</span><br><span>     }</span><br><span> }</span><br><sp=
an> </span><br><span>@@ -3439,25 +3464,9 @@</span><br><span>         to=2Ee=
km_size =3D 0;</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* TLS handshake authentication (--tl=
s-auth) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (opt=
ions-&gt;ce=2Etls_auth_file)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        t=
o=2Etls_wrap=2Emode =3D TLS_WRAP_AUTH;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* TLS handshake=
 encryption (--tls-crypt) */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (options-&gt;ce=2Etls_crypt_file || (options-&gt;ce=2Etls_cry=
pt_v2_file &amp;&amp; options-&gt;tls_client))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        to=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =
=3D=3D TLS_WRAP_CRYPT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        to=2Etl=
s_wrap=2Eopt=2Ekey_ctx_bi =3D c-&gt;c1=2Eks=2Etls_wrap_key;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Eopt=2Epid_per=
sist =3D &amp;c-&gt;c1=2Epid_persist;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        to=2Etls_wrap=2Eopt=2Eflags |=3D CO_PACKET_ID_LONG_=
FORM;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls=
_wrap=2Eoriginal_wrap_keydata =3D c-&gt;c1=2Eks=2Eoriginal_wrap_keydata;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* Control-channel wrapping (--tls=
-auth / --tls-crypt) */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    init_tls_wrap_ctx(&amp;to=2Etls_wrap, &amp;c-&gt;options=2Ece, opti=
ons-&gt;tls_client, &amp;c-&gt;c1=2Eks,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                      &amp;c-&gt;c1=2Epid_persist);</sp=
an><br><span> </span><br><span>     if (options-&gt;ce=2Etls_crypt_v2_file)=
</span><br><span>     {</span><br><span>diff --git a/src/openvpn/init=2Eh b=
/src/openvpn/init=2Eh</span><br><span>index c486158=2E=2E67834a9 100644</sp=
an><br><span>--- a/src/openvpn/init=2Eh</span><br><span>+++ b/src/openvpn/i=
nit=2Eh</span><br><span>@@ -73,6 +73,39 @@</span><br><span> </span><br><spa=
n> void do_test_crypto(struct context *o);</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @brief Load the tls-auth/tls-crypt(-v2) key mat=
erial into c-&gt;c1=2Eks=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Reads =
the key from the file configured on connection entry ce (--tls-auth,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * --tls-crypt or --tls-cr=
ypt-v2); a no-op when none of them is set=2E May be</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * called more than once (the key can be =
configured per connection block, so it</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * is reloaded for each connection)=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param c  The context whose c1=2Eks key schedule is=
 populated=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram ce The connection entry whose tls-wrap key file is loaded=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void do_init_tls_wrap_key(struct context *c, c=
onst struct connection_entry *ce);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Configure =
a control-channel wrapping context from a connection entry</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *        and previously loaded tls-=
wrap key material=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sets tls_wrap=
 to TLS_WRAP_AUTH (--tls-auth) or TLS_WRAP_CRYPT</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * (--tls-crypt / client --tls-crypt-v2) and i=
nstalls the key context, or</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * leaves it in TLS_WRAP_NONE when neither is configured=2E The key=
 material must</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * al=
ready have been loaded with do_init_tls_wrap_key()=2E tls-crypt-v2 specific=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (the wrapped cl=
ient key and the server key) are left to the caller=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param tls_wrap    The wrapping context to configure=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ce    =
      The connection entry selecting the wrapping mode=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param tls_client  Whether this is=
 a TLS client (selects tls-crypt-v2 mode)=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param ks          Key schedule holding the loa=
ded tls-wrap key material=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param pid_persist Packet-id persistence object to attach to th=
e context=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void init_tls_wrap_ctx(=
struct tls_wrap_ctx *tls_wrap, const struct connection_entry *ce,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                       bool t=
ls_client, const struct key_schedule *ks,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                       struct packet_id_persist *pid_=
persist);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> void context_gc_free(struct context *c);</span><br><span> </span><b=
r><span> bool do_up(struct context *c, bool pulled_options, uint64_t option=
_types_found);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail">change 1749</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7d8546da9ef06c2=
226ea77e461f9550d24894c61 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1749 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 32 </div=
>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ralf=
 Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--+lJ7WIBpUxs=--


--===============6115988221412935015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6115988221412935015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6115988221412935015==--

