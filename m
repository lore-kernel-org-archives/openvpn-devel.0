Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85566C5DF8C
	for <openvpn-devel@archiver.kernel.org>; Sun, 23 Aug 2026 19:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RtgpGL9atkHn/9MF8bsHFmENvPa/Ov32+gvYXSaYPeE=; b=MjlZK5XL2FK1kvPSKb9kimBktF
	g1LBqzmrZ7UzQIE7NnSMcQo7EkKZ9UywfpfBhzv3iYrdATi0EbN0dqrElGvUbj7RNcJykJPahXTmV
	y80OrHPsRwFXcYOsIdzVgVmI40jXKC9V08B9Pzix0Q3UF5RGE1vYQspB7L5R/5HWVOIc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyDl4-00033x-FW;
	Sun, 23 Aug 2026 19:21:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyDl2-00033p-QY
 for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 19:21:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BliTAb6OsSXk+VVNNLHZlZNG9rGwjwvhQOpJHRwFc9k=; b=JcVS6TBVrRmp8Z30sMTc0/ajoS
 1TrTz9g2VW09TqpaVVCHwGi81H0ym/WwUZLSEdVNJyR4RwxO2CB8p07clFcDW7GLYezOMIY3Tm37l
 HxJFUeKBB05lB3Fhu9wYdSGaQSq/Ja7W7IPR2OZ0vbDJ0yawqZhkl7mUXFMweK2FnpB0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BliTAb6OsSXk+VVNNLHZlZNG9rGwjwvhQOpJHRwFc9k=; b=Y
 S7PDERoMZA/mYW2L+h5i8j22SuqeCF2MEfsF12ON2vICncC3/pITYoNyAAe/7eUqN2eqRnYQwzvys
 GWhDedjtlGE5izI3RzzlbNAxZsiAmYTrIFUBfN8m9csrdrx6lJvlMgrDzVMNQYmuOUSaga1wIufRp
 RuQ4Aoueu9G9R2wU=;
Received: from mail-ej1-f51.google.com ([209.85.218.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyDkz-0002dB-4i for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 19:21:26 +0000
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c15f020a223so399538466b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 23 Aug 2026 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787512878; x=1788117678; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BliTAb6OsSXk+VVNNLHZlZNG9rGwjwvhQOpJHRwFc9k=;
 b=gPFJ1XNYLTzqT+Vxshl5/Qqsczih7B4XUfZaAv20d8SQNYGqS+rApahCnuR2WLlOZT
 JCmpv3IvMrcWNzKyxUxQjvlGzZBpYtHW0EJN45J6UMm7uNBB5B113n1EtU0dzD/beyIV
 /XZMHrfJXBMegJ6A7k5NPoY8xx1iNit1At+6mgN8elBb+Nx2yE3vxbNDPt/5p+a28sjj
 eKEZ4c0Hx//rBoMtc9XMPahSSP62TRj4kAOJ+yuF1f6P/lZPNrcCYRW+6Do695qM5q06
 VrBL+ka0uwBhh/G2FuPHwWQ2v7HJ2h1fkK51qo1/Hlo5Nvg4s46KjsJ043nERYRakrKp
 bplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787512878; x=1788117678;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BliTAb6OsSXk+VVNNLHZlZNG9rGwjwvhQOpJHRwFc9k=;
 b=ChXv/D9yPg+HO6X7CNaFr1XglVpdacqzCQhPec6vK+n2zKS1eVszfHnsgts/nG/Wfw
 RbC6O+I9csORkuUb8dT5JCen6Z0hLFLZ4ycovZy4lJ/zbLc8kdbU7XR0s7C6pmWkVHHk
 YTpWh7qGVT3uZyWKr5mi81EcwuDqRF5PUVysT1ByX8A1eERMc2rmOw5h8IsvhZUAo2uM
 XjbdCcFkS8LeLRk72I3mTEG094k9DRyB+4gw7fqxFoHby90JGXdh4N9QzUSN3yQ62rOU
 2MLhZPAKRAkOghFIi7Fi5C2hFRQfKuENkjGSg7rz0jyA4kUsZn6hwKEbN6CIY1HuiW1Y
 r4Pg==
X-Gm-Message-State: AFuF++kHuQsBibBxBjs7D3C80NaxQ0GvZQDmHIAnTLuSTDl7RcXMJV/I
 2qsaUw6NraadIxoTemKgYCotXAHHVmwk+MGMC+SU7WEq95CqKctY0BgrFRkJPMFKSezm7LKJK7u
 zr3qiP/zJn4+n2XtpzQ9H62AaLlWAlshGc9WigTG6Z/9cgYk6Q5YrBJckwZ8NyKk0ruFdWWmzs9
 14BoAhNg==
X-Gm-Gg: AR+sD13lDTJ+jcVzFQ90FwBDPOtuOKBDcLMt+QcsPMqiLDlcU9A2jkRVB70afWIsCEC
 9AvWPTIJeyEzRLB8jx+Y0TgoSrmyo1GkT9tin1tBIj+JrybqHIYPA82MPO1noJbqkn3c1mCCvwt
 J/IYTorDUeFV1cjStcbFUFygO9Jsq8ujXr9nGrJ2BOAYQAEn6BHgUzlFdcShahUDZQ/l5q5xwkc
 gweauhmCmpHh2zr/A1aLI302tTig5Dy4/YW5MaQgXaTAU0/MECZDIUnHPgy37/20Kh2xQwhD0Ee
 LrtEoHLpvbUfAaJJvd2djcT3jqR4HhONhq1Lu9rDdmJATVWvudXv3aNU0zMDG/L0SrQWTiCJX5F
 1pnfUZmsfAVTqRQISO9E1Tc7HRLe5PqtrAxjOdWRqnsLBdMR4pKbCLA0dMBKGWBq/hjyltXURqt
 y+lZV6Sb9lLV8/o87cQNeX/dntiYJKl8NEHRwh0nZ1Tx7STdL3lyTjL7mMXtsof65IJK3yYhZxe
 fdZb7QaGrxWmnPT7KgjE5oqkTqxAxN4BMn478fPMwHroHgYW/a2dMEmfkE9F1TcPGw6vFF2JL5g
 phB27Pk+u9jon8BBQdzZqzZPUInzyyw+4fANqZVX1fgMlvmBz8E=
X-Received: by 2002:a17:906:f588:b0:c24:c0f4:899d with SMTP id
 a640c23a62f3a-c24c0f48bd5mr184555666b.22.1787512878220; 
 Sun, 23 Aug 2026 12:21:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249685c573sm1092483566b.51.2026.08.23.12.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 12:21:17 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 23 Aug 2026 19:21:14 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Icd53745b242e0ca2943863d5b274b2a13b4419bd
X-Gerrit-Change-Number: 1851
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1851?usp=email>
X-Gerrit-Commit: be582b2d2688966335a6485479ce3b2cc4a19320
In-Reply-To: <gerrit.1787327336000.Icd53745b242e0ca2943863d5b274b2a13b4419bd@gerrit.openvpn.net>
References: <gerrit.1787327336000.Icd53745b242e0ca2943863d5b274b2a13b4419bd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkljZDUzNzQ1YjI0MmUwY2EyOTQzODYzZDViMjc0YjJhMTNiNDQxOWJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cb995898049d618003be98b7b3fc4ff5b49c9735-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyDkz-0002dB-4i
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6196438795376912922=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6196438795376912922==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FbG5WI50vTA="; charset=UTF-8

--FbG5WI50vTA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
razvanc


Change subject: Make pull_permission_mask return uint64_t
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make pull_permissio=
n_mask return uint64_t

Commit 91fd9614 already changed most of the instanc=
es for the
option flag to uint64_t but forgot to also adjust
pull_permissio=
n_mask and OPT_P_DEFAULT=2E

Change-Id: Icd53745b242e0ca2943863d5b274b2a13b=
4419bd
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Razvan Co=
jocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1851
Message-Id: <20260823145533=2E25183-1-gert@greenie=2Emuc=2E=
de>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38599=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/init=2Ec
M src/openvpn/init=2Eh
M src/openvpn/options=
=2Eh
M src/openvpn/push_util=2Ec
M tests/unit_tests/openvpn/test_push_updat=
e_msg=2Ec
5 files changed, 13 insertions(+), 13 deletions(-)


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/51/1851/5

diff --gi=
t a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index fa62cdd=2E=2E66bae34 =
100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2514,13 +2=
514,13 @@
 /*
  * These are the option categories which will be accepted by=
 pull=2E
  */
-unsigned int
+uint64_t
 pull_permission_mask(const struct co=
ntext *c)
 {
-    unsigned int flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OP=
T_P_SOCKBUF | OPT_P_SOCKFLAGS
-                         | OPT_P_SETENV | OP=
T_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
-                    =
     | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MOD=
E
-                         | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU;
+=
    uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_=
P_SOCKFLAGS
+                     | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIM=
ER | OPT_P_COMP | OPT_P_PERSIST
+                     | OPT_P_MESSAGES | OP=
T_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
+                     | =
OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU;
 
     if (!c->options=2Eroute_=
nopull)
     {
diff --git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh
ind=
ex 9d5050d=2E=2Ece8f74e 100644
--- a/src/openvpn/init=2Eh
+++ b/src/openvpn=
/init=2Eh
@@ -89,7 +89,7 @@
  */
 bool do_update(struct context *c, uint64_=
t option_types_found);
 
-unsigned int pull_permission_mask(const struct co=
ntext *c);
+uint64_t pull_permission_mask(const struct context *c);
 
 cons=
t char *format_common_name(struct context *c, struct gc_arena *gc);
 
diff =
--git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index c23d0b3=2E=
=2Ef472676 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=
=2Eh
@@ -761,7 +761,7 @@
 #define OPT_P_PUSH_MTU        (1u << 30)
 #define=
 OPT_P_ROUTE_TABLE     (1u << 31)
 
-#define OPT_P_DEFAULT (~(OPT_P_INSTANC=
E | OPT_P_PULL_MODE))
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL=
_MODE | OPT_P_PEER_ID | 0x0ull))
 
 #define PULL_DEFINED(opt) ((opt)->pull)=

 
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index=
 c927f26=2E=2Efcc5411 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/open=
vpn/push_util=2Ec
@@ -185,7 +185,7 @@
          */
         struct buffer t=
mp_msg =3D e->buf;
         buf_string_compare_advance(&tmp_msg, push_updat=
e_cmd);
-        unsigned int permission_mask =3D pull_permission_mask(c);
=
+        uint64_t permission_mask =3D pull_permission_mask(c);
         if =
(process_push_update(c, &o, permission_mask, &option_types_found, &tmp_msg,=
 true) =3D=3D PUSH_MSG_ERROR)
         {
             msg(M_WARN, "Failed t=
o process push update message sent to client ID: %u", c->c2=2Etls_multi->rx=
_peer_id);
diff --git a/tests/unit_tests/openvpn/test_push_update_msg=2Ec b=
/tests/unit_tests/openvpn/test_push_update_msg=2Ec
index 9cb791b=2E=2E26537=
49 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg=2Ec
+++ b/tes=
ts/unit_tests/openvpn/test_push_update_msg=2Ec
@@ -20,13 +20,13 @@
     msg=
(M_WARN, "Offending option received from server");
 }
 
-unsigned int
+uint=
64_t
 pull_permission_mask(const struct context *c)
 {
-    unsigned int fl=
ags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
-  =
                       | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_=
COMP | OPT_P_PERSIST
-                         | OPT_P_MESSAGES | OPT_P_EXP=
LICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-                         | OPT=
_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+   =
 uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_S=
OCKFLAGS
+                     | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER =
| OPT_P_COMP | OPT_P_PERSIST
+                     | OPT_P_MESSAGES | OPT_P=
_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
+                     | OPT=
_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
    =
 return flags;
 }
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1851?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Icd53745b242e0ca2943863d5b274b2a13b4419bd
Gerrit-Change-Number: 1851
Ger=
rit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>

--FbG5WI50vTA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">Make pull_permission_mask=
 return uint64_t<br><br>Commit 91fd9614 already changed most of the instanc=
es for the<br>option flag to uint64_t but forgot to also adjust<br>pull_per=
mission_mask and OPT_P_DEFAULT=2E<br><br>Change-Id: Icd53745b242e0ca2943863=
d5b274b2a13b4419bd<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt=
;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL:=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851<br>Message-Id: &lt;2026082=
3145533=2E25183-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38599=2Ehtml<br>Sign=
ed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/ope=
nvpn/init=2Ec<br>M src/openvpn/init=2Eh<br>M src/openvpn/options=2Eh<br>M s=
rc/openvpn/push_util=2Ec<br>M tests/unit_tests/openvpn/test_push_update_msg=
=2Ec<br>5 files changed, 13 insertions(+), 13 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/51/1851/5</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec=
</span><br><span>index fa62cdd=2E=2E66bae34 100644</span><br><span>--- a/sr=
c/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><sp=
an>@@ -2514,13 +2514,13 @@</span><br><span> /*</span><br><span>  * These ar=
e the option categories which will be accepted by pull=2E</span><br><span> =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned int</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><br><span>=
 pull_permission_mask(const struct context *c)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int flags =3D OPT_=
P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                         | OPT_P_SETE=
NV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                         | OPT_P_MES=
SAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                         | OPT_P_PEE=
R_ID | OPT_P_NCP | OPT_P_PUSH_MTU;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P=
_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                     | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | O=
PT_P_COMP | OPT_P_PERSIST</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                     | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P=
_ECHO | OPT_P_PULL_MODE</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU;</spa=
n><br><span> </span><br><span>     if (!c-&gt;options=2Eroute_nopull)</span=
><br><span>     {</span><br><span>diff --git a/src/openvpn/init=2Eh b/src/o=
penvpn/init=2Eh</span><br><span>index 9d5050d=2E=2Ece8f74e 100644</span><br=
><span>--- a/src/openvpn/init=2Eh</span><br><span>+++ b/src/openvpn/init=2E=
h</span><br><span>@@ -89,7 +89,7 @@</span><br><span>  */</span><br><span> b=
ool do_update(struct context *c, uint64_t option_types_found);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned int pul=
l_permission_mask(const struct context *c);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+uint64_t pull_permission_mask(const struct context =
*c);</span><br><span> </span><br><span> const char *format_common_name(stru=
ct context *c, struct gc_arena *gc);</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>=
index c23d0b3=2E=2Ef472676 100644</span><br><span>--- a/src/openvpn/options=
=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -761,=
7 +761,7 @@</span><br><span> #define OPT_P_PUSH_MTU        (1u &lt;&lt; 30)=
</span><br><span> #define OPT_P_ROUTE_TABLE     (1u &lt;&lt; 31)</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_=
DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_P=
ULL_MODE | OPT_P_PEER_ID | 0x0ull))</span><br><span> </span><br><span> #def=
ine PULL_DEFINED(opt) ((opt)-&gt;pull)</span><br><span> </span><br><span>di=
ff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec</span><br>=
<span>index c927f26=2E=2Efcc5411 100644</span><br><span>--- a/src/openvpn/p=
ush_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec</span><br><spa=
n>@@ -185,7 +185,7 @@</span><br><span>          */</span><br><span>        =
 struct buffer tmp_msg =3D e-&gt;buf;</span><br><span>         buf_string_c=
ompare_advance(&amp;tmp_msg, push_update_cmd);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        unsigned int permission_mask =3D pull_perm=
ission_mask(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    uint64_t permission_mask =3D pull_permission_mask(c);</span><br><span> =
        if (process_push_update(c, &amp;o, permission_mask, &amp;option_typ=
es_found, &amp;tmp_msg, true) =3D=3D PUSH_MSG_ERROR)</span><br><span>      =
   {</span><br><span>             msg(M_WARN, &quot;Failed to process push =
update message sent to client ID: %u&quot;, c-&gt;c2=2Etls_multi-&gt;rx_pee=
r_id);</span><br><span>diff --git a/tests/unit_tests/openvpn/test_push_upda=
te_msg=2Ec b/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><s=
pan>index 9cb791b=2E=2E2653749 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/test_push_update_msg=2Ec</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_push_update_msg=2Ec</span><br><span>@@ -20,13 +20,13 @@</span><=
br><span>     msg(M_WARN, &quot;Offending option received from server&quot;=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-unsigned int</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+uint64_t</span><br><span> pull_permission_mask(const struct cont=
ext *c)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    unsigned int flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKB=
UF | OPT_P_SOCKFLAGS</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                        | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P=
_COMP | OPT_P_PERSIST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                         | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_E=
CHO | OPT_P_PULL_MODE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                         | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT=
_P_ROUTE | OPT_P_DHCPDNS;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF =
| OPT_P_SOCKFLAGS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                   | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP=
 | OPT_P_PERSIST</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                  | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | O=
PT_P_PULL_MODE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE =
| OPT_P_DHCPDNS;</span><br><span>     return flags;</span><br><span> }</spa=
n><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=3Demail">change 1851</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic=
d53745b242e0ca2943863d5b274b2a13b4419bd </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1851 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--FbG5WI50vTA=--


--===============6196438795376912922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6196438795376912922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6196438795376912922==--

