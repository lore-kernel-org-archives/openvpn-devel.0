Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93294C5DF98
	for <openvpn-devel@archiver.kernel.org>; Sun, 23 Aug 2026 13:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YzM1jGtU1OAC/mpcDlS22mPDjiNT1e2uMGyeFLEt+nY=; b=GxYJZAuSSkEwrGoxJznJZuuT42
	n1nyX8e2iLfveuVk83797o1CMbn128VHoM5IQOlQtE7yuo8hNK1A3fyDrctm/E0eP9Qoo8gFdvs/Q
	unIqa4Ds7eo3iLJMBgyAcR7HocGVBHiAkKlAZT+AN7JM2CiMw19BSFctOHaaVpf705nQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wy8BR-00059q-6H;
	Sun, 23 Aug 2026 13:24:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wy8BQ-00059k-1g
 for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 13:24:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Xhl9SH68p5DvMMqIPwxd0mwugOHNgCzxovWODAWHFXw=; b=ZL+/qt3MaMR7HGTHO1m0BqS9ck
 yzv2l1lUhMWY55/ewoGRdbquDuRkni79RPRsMqJYHK4haeicTT5Hurigacv2emXjPP3jC5HqilkfT
 waToOCd7d6BuZExSaRSA9WXwSGEflZxb79ReNXKVUpHiIHTYfuTlsUPOAHJHFjgFDwHk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Xhl9SH68p5DvMMqIPwxd0mwugOHNgCzxovWODAWHFXw=; b=I
 RXXPgD81//W31Up+UD+adOopAqIg+wI7s6qKJuVCaV0vx6GhNrbY1GlfAeifGWbSS4k9jV5EKas91
 j3CrC8OXifI5Ug5YsBHWTg3l0cdmsu1mSp6wR9AG/OtYyEraa85Ma1gcxx0ZmTExsIch93NOAaTGx
 nM38V+GVl6PPafBc=;
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wy8BO-0005CF-Nw for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 13:24:19 +0000
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6a3efa2b38aso4735630a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 23 Aug 2026 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787491452; x=1788096252; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Xhl9SH68p5DvMMqIPwxd0mwugOHNgCzxovWODAWHFXw=;
 b=CBupPbTFQj50zfMZQHkqPLLeWIeC92wLiaTo5Hn1QfThqQsKAcvZpv2yU8a17bgH4w
 qbqlrrI3oXve9RKsggMKxJ+VUsK0urKmZkSKDyiTYyfYMbgLQnJb8E7qBDY+Ap9iE5lX
 cf9zLSMVDoPjqg3eN4fPOwb0wg6h4QjTGVA0XrNtHcNHVRkSDX0/feFi7A/w4TPop2T1
 tssFfVzuXLsI+oZoblNGqfHXl76IKHY5l2ralGgEinbooIzSQt5JkBCUN5++0FFmqPcr
 WprIqJPk4RGDOJWrDup/knrimLoVZoScyRqOhbZlknmFl+p/1iY/WPpXtvSuqb09jsdK
 +Kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787491452; x=1788096252;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Xhl9SH68p5DvMMqIPwxd0mwugOHNgCzxovWODAWHFXw=;
 b=ioBw2byT2J4wfLK0upgeGWl1mDugXxMGqlYHFwSY8QLNlDsWe8lD6PYRHEo396J/vT
 jk/N843wgG0JAL5dPMP8ZZ89838GPNT+RTPBJCptQ4LAoCqrbSy/EXEdz3AgXojVxHAm
 W4HnXUw2biXsHJ9F5givIdsSpUFiBqYjJUhJeI1C9egznSKh113P0K5cGbh9Bl0g91eA
 rD8Q1zLdvKvCbJnmrQmsi/MCpxgJsnxa6BLBcC7EraLGbNLsOPIlPHoomJrSbmjygE3d
 KW7K0tfsxCkgt5A1nDmWws3O6YJLuK3yQXkdVxQE9dw56Voo7gBhRNpT8eM6/xtl89Vp
 fQLw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRtClKL8L1MLEHqrTE06jzHvVJgt+Ik8W+h9x2OdRG1FXNpRlKoynTiNlutNIElKtDaLUX/rOGY2fU6dfT@lists.sourceforge.net
X-Gm-Message-State: AFuF++nw6TVc3Tyfl0VubeErf2LF/T4ikiH6WtGaM7Z2GqUsYXCSYUiH
 DYNCanETpSxdg3PlHXwf+3j1aRvtR/V7o+dH3MKwTXwkt/addP+zcdAJOTJ2qKwd08Rw6cWm4Gs
 Qn8ObXkbioyqjrLcm7QjqEUKt2Kw3z8y0oZopsbP0uKJlev6xd3nKenStHeh5r2680dhp
X-Gm-Gg: AR+sD10kVRWoupYN6MbBDPsLly3EbDZNUrgX8ATmXtoOA5E2TFlqkuYf4UKy3HZgFy4
 olt9syo30C5Ca42xEb7tdItaleq4tKDwyQm78BpsmA9fZgdZqK1MWDjCO8bgR0crN25vZcmJTnq
 VsUWo9JgS9oKnLKXjDxJIDv8cua64ZHtp+JRmqncnb8KwL8RyhqYtHbxsUO/qMIwMetF+SLu+py
 N9QEdd4J5w4GfWmrmn1xFjOgUc8drtdJLgEhe/eBxO7dA9vMSj3uMwZTYzEg7y/hxe8Br3v/Tig
 qraei/wsIfHHLOd3h2JYgXD9sxUkDjhNFXB0eFDbb4ON1zTMobZapmVZApQF51PUGYJyZ27BaNA
 21h8sWRLDg4M2UoVSrbhp81nWgzhkf8YqemoNHhP1lGvFFI68NxfdxQ2IRnWRLza/8oIYWvgt90
 vcSeUJsK5fIbkLlTMb/D1EOmpgk147WehZhFyRJbvEuSBc1VoVlMItdaLoFiPxey3m6zg4TP1D9
 49E1H8JSOlDahXEwjB0ghjzd5eIYpA8HlWB4/zFrSzTRs48rrvSJuMSTgEZ3M4GtRxPYGbda5cl
 u7x8ng7/ciKnz+k0odO7yfebQkVFnJnVdyGTa5Kj4s2UjZEpiC49
X-Received: by 2002:a17:907:c50a:b0:c21:1b58:fa96 with SMTP id
 a640c23a62f3a-c246a39f3a8mr2188227766b.3.1787491451991; 
 Sun, 23 Aug 2026 06:24:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249685ef7bsm851539166b.52.2026.08.23.06.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 06:24:11 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 23 Aug 2026 13:24:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Icd53745b242e0ca2943863d5b274b2a13b4419bd
X-Gerrit-Change-Number: 1851
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1851?usp=email>
X-Gerrit-Commit: 9dd3b5c423fc8a8843390f50e84104bfdc777870
In-Reply-To: <gerrit.1787327336000.Icd53745b242e0ca2943863d5b274b2a13b4419bd@gerrit.openvpn.net>
References: <gerrit.1787327336000.Icd53745b242e0ca2943863d5b274b2a13b4419bd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkljZDUzNzQ1YjI0MmUwY2EyOTQzODYzZDViMjc0YjJhMTNiNDQxOWJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5e147af57968fa473370e645bbbfc89c4e318cdd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wy8BO-0005CF-Nw
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make
 pull_permission_mask return uint64_t
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0287505907162588343=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0287505907162588343==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="O6FxokUPeFk="; charset=UTF-8

--O6FxokUPeFk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

plaisthos has uploaded =
a new patch set (#3)=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851?us=
p=3Demail )


Change subject: Make pull_permission_mask return uint64_t
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make pull_permis=
sion_mask return uint64_t

Commit 91fd9614 already changed most of the inst=
ances for the
option flag to uint64_t but forgot to also adjust
pull_permis=
sion_mask and OPT_P_DEFAULT=2E

Change-Id: Icd53745b242e0ca2943863d5b274b2a=
13b4419bd
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvp=
n/init=2Ec
M src/openvpn/init=2Eh
M src/openvpn/options=2Eh
M src/openvpn/p=
ush_util=2Ec
M tests/unit_tests/openvpn/test_push_update_msg=2Ec
5 files ch=
anged, 13 insertions(+), 13 deletions(-)


  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/51/1851/3

diff --git a/src/openvpn/init=
=2Ec b/src/openvpn/init=2Ec
index fa62cdd=2E=2E66bae34 100644
--- a/src/ope=
nvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2514,13 +2514,13 @@
 /*
  * Th=
ese are the option categories which will be accepted by pull=2E
  */
-unsig=
ned int
+uint64_t
 pull_permission_mask(const struct context *c)
 {
-    un=
signed int flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_=
SOCKFLAGS
-                         | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_T=
IMER | OPT_P_COMP | OPT_P_PERSIST
-                         | OPT_P_MESSAGE=
S | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-                 =
        | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU;
+    uint64_t flags =
=3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
+      =
               | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | O=
PT_P_PERSIST
+                     | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY=
 | OPT_P_ECHO | OPT_P_PULL_MODE
+                     | OPT_P_PEER_ID | OPT=
_P_NCP | OPT_P_PUSH_MTU;
 
     if (!c->options=2Eroute_nopull)
     {
diff=
 --git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh
index 9d5050d=2E=2Ece8=
f74e 100644
--- a/src/openvpn/init=2Eh
+++ b/src/openvpn/init=2Eh
@@ -89,7 =
+89,7 @@
  */
 bool do_update(struct context *c, uint64_t option_types_foun=
d);
 
-unsigned int pull_permission_mask(const struct context *c);
+uint64_=
t pull_permission_mask(const struct context *c);
 
 const char *format_comm=
on_name(struct context *c, struct gc_arena *gc);
 
diff --git a/src/openvpn=
/options=2Eh b/src/openvpn/options=2Eh
index c23d0b3=2E=2Ef472676 100644
--=
- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -761,7 +761,7 =
@@
 #define OPT_P_PUSH_MTU        (1u << 30)
 #define OPT_P_ROUTE_TABLE    =
 (1u << 31)
 
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE))
=
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID =
| 0x0ull))
 
 #define PULL_DEFINED(opt) ((opt)->pull)
 
diff --git a/src/op=
envpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index c927f26=2E=2Efcc5411 =
100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -=
185,7 +185,7 @@
          */
         struct buffer tmp_msg =3D e->buf;
   =
      buf_string_compare_advance(&tmp_msg, push_update_cmd);
-        unsig=
ned int permission_mask =3D pull_permission_mask(c);
+        uint64_t perm=
ission_mask =3D pull_permission_mask(c);
         if (process_push_update(c=
, &o, permission_mask, &option_types_found, &tmp_msg, true) =3D=3D PUSH_MSG=
_ERROR)
         {
             msg(M_WARN, "Failed to process push update =
message sent to client ID: %u", c->c2=2Etls_multi->rx_peer_id);
diff --git =
a/tests/unit_tests/openvpn/test_push_update_msg=2Ec b/tests/unit_tests/open=
vpn/test_push_update_msg=2Ec
index 9cb791b=2E=2E2653749 100644
--- a/tests/=
unit_tests/openvpn/test_push_update_msg=2Ec
+++ b/tests/unit_tests/openvpn/=
test_push_update_msg=2Ec
@@ -20,13 +20,13 @@
     msg(M_WARN, "Offending op=
tion received from server");
 }
 
-unsigned int
+uint64_t
 pull_permission_=
mask(const struct context *c)
 {
-    unsigned int flags =3D OPT_P_UP | OPT=
_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
-                        =
 | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
-=
                         | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_E=
CHO | OPT_P_PULL_MODE
-                         | OPT_P_PEER_ID | OPT_P_NCP=
 | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+    uint64_t flags =3D OP=
T_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
+            =
         | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_P=
ERSIST
+                     | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT=
_P_ECHO | OPT_P_PULL_MODE
+                     | OPT_P_PEER_ID | OPT_P_NCP=
 | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
     return flags;
 }
 

-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icd53745b242e0ca294=
3863d5b274b2a13b4419bd
Gerrit-Change-Number: 1851
Gerrit-PatchSet: 3
Gerrit=
-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--O6FxokUPeFk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1851?usp=3Demail">View Change</a></p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Make =
pull_permission_mask return uint64_t<br><br>Commit 91fd9614 already changed=
 most of the instances for the<br>option flag to uint64_t but forgot to als=
o adjust<br>pull_permission_mask and OPT_P_DEFAULT=2E<br><br>Change-Id: Icd=
53745b242e0ca2943863d5b274b2a13b4419bd<br>Signed-off-by: Arne Schwabe &lt;a=
rne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/init=2Ec<br>M src/openvpn/ini=
t=2Eh<br>M src/openvpn/options=2Eh<br>M src/openvpn/push_util=2Ec<br>M test=
s/unit_tests/openvpn/test_push_update_msg=2Ec<br>5 files changed, 13 insert=
ions(+), 13 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/51/1851/3</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index fa62cdd=
=2E=2E66bae34 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><=
span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -2514,13 +2514,13 @@</sp=
an><br><span> /*</span><br><span>  * These are the option categories which =
will be accepted by pull=2E</span><br><span>  */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-unsigned int</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+uint64_t</span><br><span> pull_permission_mask(const st=
ruct context *c)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    unsigned int flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OP=
T_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                         | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIME=
R | OPT_P_COMP | OPT_P_PERSIST</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                         | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY =
| OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                         | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_=
MTU;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t fl=
ags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                     | =
OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                     | O=
PT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                     | OPT=
_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU;</span><br><span> </span><br><span>=
     if (!c-&gt;options=2Eroute_nopull)</span><br><span>     {</span><br><s=
pan>diff --git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh</span><br><spa=
n>index 9d5050d=2E=2Ece8f74e 100644</span><br><span>--- a/src/openvpn/init=
=2Eh</span><br><span>+++ b/src/openvpn/init=2Eh</span><br><span>@@ -89,7 +8=
9,7 @@</span><br><span>  */</span><br><span> bool do_update(struct context =
*c, uint64_t option_types_found);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-unsigned int pull_permission_mask(const str=
uct context *c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uin=
t64_t pull_permission_mask(const struct context *c);</span><br><span> </spa=
n><br><span> const char *format_common_name(struct context *c, struct gc_ar=
ena *gc);</span><br><span> </span><br><span>diff --git a/src/openvpn/option=
s=2Eh b/src/openvpn/options=2Eh</span><br><span>index c23d0b3=2E=2Ef472676 =
100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/=
src/openvpn/options=2Eh</span><br><span>@@ -761,7 +761,7 @@</span><br><span=
> #define OPT_P_PUSH_MTU        (1u &lt;&lt; 30)</span><br><span> #define O=
PT_P_ROUTE_TABLE     (1u &lt;&lt; 31)</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE |=
 OPT_P_PULL_MODE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | =
0x0ull))</span><br><span> </span><br><span> #define PULL_DEFINED(opt) ((opt=
)-&gt;pull)</span><br><span> </span><br><span>diff --git a/src/openvpn/push=
_util=2Ec b/src/openvpn/push_util=2Ec</span><br><span>index c927f26=2E=2Efc=
c5411 100644</span><br><span>--- a/src/openvpn/push_util=2Ec</span><br><spa=
n>+++ b/src/openvpn/push_util=2Ec</span><br><span>@@ -185,7 +185,7 @@</span=
><br><span>          */</span><br><span>         struct buffer tmp_msg =3D =
e-&gt;buf;</span><br><span>         buf_string_compare_advance(&amp;tmp_msg=
, push_update_cmd);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      unsigned int permission_mask =3D pull_permission_mask(c);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        uint64_t permission_mas=
k =3D pull_permission_mask(c);</span><br><span>         if (process_push_up=
date(c, &amp;o, permission_mask, &amp;option_types_found, &amp;tmp_msg, tru=
e) =3D=3D PUSH_MSG_ERROR)</span><br><span>         {</span><br><span>      =
       msg(M_WARN, &quot;Failed to process push update message sent to clie=
nt ID: %u&quot;, c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/test_push_update_msg=2Ec b/tests/unit_tes=
ts/openvpn/test_push_update_msg=2Ec</span><br><span>index 9cb791b=2E=2E2653=
749 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_push_update_=
msg=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_push_update_msg=
=2Ec</span><br><span>@@ -20,13 +20,13 @@</span><br><span>     msg(M_WARN, &=
quot;Offending option received from server&quot;);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned =
int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><=
br><span> pull_permission_mask(const struct context *c)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int flags=
 =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                         | O=
PT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                         | =
OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                         | =
OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t flags =
=3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_=
P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P=
_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_P=
EER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</span><b=
r><span>     return flags;</span><br><span> }</span><br><span> </span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1851?usp=3Demail">change 1851</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: Icd53745b242e0ca2943863d5b=
274b2a13b4419bd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
851 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--O6FxokUPeFk=--


--===============0287505907162588343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0287505907162588343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0287505907162588343==--

