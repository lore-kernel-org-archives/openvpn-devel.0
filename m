Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B83C5DF81
	for <openvpn-devel@archiver.kernel.org>; Sun, 23 Aug 2026 19:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5rR8ZscrSbF3YykFjZA/FPhxZCdvrLz0eMiXL1CKEGU=; b=Tj6ivV0C2Vk15h2BEI2olHuBpu
	7b7OjFm9ojNhU+mDPhyT8MjT2N32nh7qIwP5Gh0XH1YQsnJ75XZzMe7ZsElLlmKpM0eUE+YhEkigS
	M8wrRWV1IXtSH8ZRkh/gebvJEhq0IEA9FNj2SbnEEMEdIMJvflIlJqgIrngavt5NYNNM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyDl2-0002PE-Ml;
	Sun, 23 Aug 2026 19:21:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyDl0-0002Ox-Q1
 for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 19:21:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Revvep8b075MIuAE393R5iQ9udm8GuSljB9NGVDNMwE=; b=i0Ha7nWx6NFXYChFxP+ptdP4DW
 g7oCDpzayrIMCAgyymLzzlqNdzR4RC8P2lma+XdXNX6RhKSqsbndCy3wEWM5EfrA/q/u4wuIHwYl7
 hiSmoWJE7jfhNfCGtip/t5WmLGicJEYGSaDl5kbF6jWEJroAqAYUQsWWBhANUX5riiS0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Revvep8b075MIuAE393R5iQ9udm8GuSljB9NGVDNMwE=; b=c
 NX1ACgt+kBb5GMX1XIWHfMw5jIwh6wkPy4q17+HUvkSU9exCWLkDFSwZ5Hk9Wwc/t4K0lV3iPs+hL
 blQhRo+mGUPdD+/G7N9zC4pVbZhRfFz+ydNIczcihRKY09qRzeIjSadfmpYLG+gGbGSUPufX4u6C3
 wRzQ5+HglU3KmVbk=;
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyDl0-0006hI-I9 for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 19:21:27 +0000
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6a156627e22so6907170a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 23 Aug 2026 12:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787512880; x=1788117680; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Revvep8b075MIuAE393R5iQ9udm8GuSljB9NGVDNMwE=;
 b=Y+XQZd2iars/qB70gPwtsk/jPuECgrSQaLxDALIAdYJ66OzyRgKLaVZkDjStP+3i4n
 G66mN8ve9dKPmXEteP7an/IeqtkYYvV5KUE24V7SwS1Gv8H5+RvN99qNSUoa4MMM72sm
 w05KzArO0CgQklAAwRbFjWtEj3fea0PjAVhLxj81JtIrkaXYe5k/9M5Yf5I0NX6/Vc2x
 e9Zdyz2rpdbBkjt13X3/+nMKCD2vKY2LW2VZiwAYY19mADEWAehrc01td8cZzAcOhtd4
 m/ckj5DkKPn/d4BAFkZW273kp6idPMLPz7cNobFk0ZXQHtgLLNRkacApv8/AERTZ9rcS
 wEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787512880; x=1788117680;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Revvep8b075MIuAE393R5iQ9udm8GuSljB9NGVDNMwE=;
 b=F2HGkxzcRTQav8Td3CnuyirTYChWeJr+exsnlNCDlPAKjG3cLYQd4G22f7MWSh/Ne6
 FH1ffnrltGG3Q7eLRIMGelwh0zlld4sHq+gGn4soeavzWJUSG2UEsHuHMRJ5yz629Hig
 176UwsGQFvbToi3w/d3BdOvZMyUWqZu2kbGXvKejaSY2g0DudpnQ0KxzUl0ED1QENdqF
 vnqOPFTCGmsVdMtCYayZLI4Nxo7zpcuu/6VmIJAn8if8P3Gpx7TChmClXD6Kte4FikyA
 NTogulVnVdCaynASdSK40n7lxvHJpR8gD7ADaXWSkuzhx5ZgyzT1OA8WP4Zug+qGC3Jf
 xp+g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHzMu8OE5BekT3NSvEKGBCHtp3gZ3N0WMUFRzQyc7MKqTIUstSjQEqv6irLn0nbC27VgpPMY83KnNeG+DN@lists.sourceforge.net
X-Gm-Message-State: AFuF++ksyJc1KnuIqZlXgUjRHlV/meteQrWGVda0wRRdX7A7ugS22/pO
 VRUpxGXDvzS4dlLAo85z8W8GQq9LHcvNkE9QEFmmE+et6gv2pH7NvcjsCtX02XzreYvLyepxQ2/
 wD3Y1Z4b27vgZzsoZYsSVQ9i9A/xyFRBJRz4sRaDaQgG3JoZz0BE3a4YEeGBALZANS3Kg
X-Gm-Gg: AR+sD11gc78vAmOQR6peuVLNcyycfc0OXBAU2rJIELpHIFHgBmVA+V0zJqwnowno4dX
 oQSvJ+gWQthQCqoQ0nTsonjL5IX5eRIU3p0PSrpHkoorCqqdB/NtOj8Qrz8IT7knR/x7YM2sRTr
 XQ4wEWQCVq22gEDEh0QFQzTNP0haDxr2TOPjaIANOnIW5RaRQxZwdQB5U/02d7Gtz4Xigs6lm9p
 Q2kbNRWKgJ17yJmJ5MknVMeo/xVwM8ychhNzTS57DcNgQkjBHmgOiysXna0cZXGeBqQKt7bpwvy
 Bk4OwFneeE9Li7MGsR9c8c5MKP89hgTVfsR6Wuz/aSMKnSo973e607kNcVeoYqvRh4UADwuw0xK
 nAf1TL16z8gVbwFHAe4Ag3fmGt5rXmUP0bp73otTd7YD820NzrGSXipVDQybglu30oMwBR3C5m8
 j+suGCSfn3AARXsH3772cZBKXvJEeVP6uETU8zAUMAUVLIQY9Im5owTKxt12sSNTXH+g2Vs417H
 zktN/++7jU3o1pLeVDRMkTK+QlpHieJEo/HQaY7uilQQwUkjAv36GiYF+nPCd7+haBeUncyy33c
 olZlNgQjaftzxr13R4OorEuJ+nGBJ6O5r7NgrdByH/i16hHehFg=
X-Received: by 2002:a17:906:209c:b0:c24:bf32:dc57 with SMTP id
 a640c23a62f3a-c24bf32de4cmr170117766b.7.1787512879734; 
 Sun, 23 Aug 2026 12:21:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f64e0sm1151123066b.32.2026.08.23.12.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 12:21:19 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 23 Aug 2026 19:21:18 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Icd53745b242e0ca2943863d5b274b2a13b4419bd
X-Gerrit-Change-Number: 1851
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1851?usp=email>
X-Gerrit-Commit: be582b2d2688966335a6485479ce3b2cc4a19320
In-Reply-To: <gerrit.1787327336000.Icd53745b242e0ca2943863d5b274b2a13b4419bd@gerrit.openvpn.net>
References: <gerrit.1787327336000.Icd53745b242e0ca2943863d5b274b2a13b4419bd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkljZDUzNzQ1YjI0MmUwY2EyOTQzODYzZDViMjc0YjJhMTNiNDQxOWJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cb995898049d618003be98b7b3fc4ff5b49c9735-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyDl0-0006hI-I9
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
Content-Type: multipart/mixed; boundary="===============0077159523377583697=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0077159523377583697==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kHGT+btzSFA="; charset=UTF-8

--kHGT+btzSFA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1851?usp=3Demail )

Change subject: Make pull_permission_mask return ui=
nt64_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make=
 pull_permission_mask return uint64_t

Commit 91fd9614 already changed most=
 of the instances for the
option flag to uint64_t but forgot to also adjust=

pull_permission_mask and OPT_P_DEFAULT=2E

Change-Id: Icd53745b242e0ca2943=
863d5b274b2a13b4419bd
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acke=
d-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1851
Message-Id: <20260823145533=2E25183-1-gert@g=
reenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg38599=2Ehtml
Signed-off-by: Gert Doering <gert@gre=
enie=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
M src/openvpn/init=2Eh
M src/op=
envpn/options=2Eh
M src/openvpn/push_util=2Ec
M tests/unit_tests/openvpn/te=
st_push_update_msg=2Ec
5 files changed, 13 insertions(+), 13 deletions(-)

=



diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index fa62cdd=
=2E=2E66bae34 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
=
@@ -2514,13 +2514,13 @@
 /*
  * These are the option categories which will =
be accepted by pull=2E
  */
-unsigned int
+uint64_t
 pull_permission_mask(c=
onst struct context *c)
 {
-    unsigned int flags =3D OPT_P_UP | OPT_P_ROU=
TE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
-                         | OPT=
_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
-      =
                   | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | =
OPT_P_PULL_MODE
-                         | OPT_P_PEER_ID | OPT_P_NCP | OPT=
_P_PUSH_MTU;
+    uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_=
SOCKBUF | OPT_P_SOCKFLAGS
+                     | OPT_P_SETENV | OPT_P_SHAP=
ER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
+                     | OPT_P=
_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
+         =
            | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU;
 
     if (!c->op=
tions=2Eroute_nopull)
     {
diff --git a/src/openvpn/init=2Eh b/src/openvp=
n/init=2Eh
index 9d5050d=2E=2Ece8f74e 100644
--- a/src/openvpn/init=2Eh
+++=
 b/src/openvpn/init=2Eh
@@ -89,7 +89,7 @@
  */
 bool do_update(struct conte=
xt *c, uint64_t option_types_found);
 
-unsigned int pull_permission_mask(c=
onst struct context *c);
+uint64_t pull_permission_mask(const struct contex=
t *c);
 
 const char *format_common_name(struct context *c, struct gc_arena=
 *gc);
 
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
ind=
ex c23d0b3=2E=2Ef472676 100644
--- a/src/openvpn/options=2Eh
+++ b/src/open=
vpn/options=2Eh
@@ -761,7 +761,7 @@
 #define OPT_P_PUSH_MTU        (1u << 3=
0)
 #define OPT_P_ROUTE_TABLE     (1u << 31)
 
-#define OPT_P_DEFAULT (~(OP=
T_P_INSTANCE | OPT_P_PULL_MODE))
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE |=
 OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))
 
 #define PULL_DEFINED(opt) ((=
opt)->pull)
 
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_uti=
l=2Ec
index c927f26=2E=2Efcc5411 100644
--- a/src/openvpn/push_util=2Ec
+++=
 b/src/openvpn/push_util=2Ec
@@ -185,7 +185,7 @@
          */
         stru=
ct buffer tmp_msg =3D e->buf;
         buf_string_compare_advance(&tmp_msg,=
 push_update_cmd);
-        unsigned int permission_mask =3D pull_permissio=
n_mask(c);
+        uint64_t permission_mask =3D pull_permission_mask(c);
 =
        if (process_push_update(c, &o, permission_mask, &option_types_found=
, &tmp_msg, true) =3D=3D PUSH_MSG_ERROR)
         {
             msg(M_WARN=
, "Failed to process push update message sent to client ID: %u", c->c2=2Etl=
s_multi->rx_peer_id);
diff --git a/tests/unit_tests/openvpn/test_push_updat=
e_msg=2Ec b/tests/unit_tests/openvpn/test_push_update_msg=2Ec
index 9cb791b=
=2E=2E2653749 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg=2E=
c
+++ b/tests/unit_tests/openvpn/test_push_update_msg=2Ec
@@ -20,13 +20,13 =
@@
     msg(M_WARN, "Offending option received from server");
 }
 
-unsigne=
d int
+uint64_t
 pull_permission_mask(const struct context *c)
 {
-    unsi=
gned int flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SO=
CKFLAGS
-                         | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIM=
ER | OPT_P_COMP | OPT_P_PERSIST
-                         | OPT_P_MESSAGES =
| OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-                   =
      | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DH=
CPDNS;
+    uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBU=
F | OPT_P_SOCKFLAGS
+                     | OPT_P_SETENV | OPT_P_SHAPER | O=
PT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
+                     | OPT_P_MESSA=
GES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
+               =
      | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DH=
CPDNS;
     return flags;
 }
 

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1851?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: Icd53745b242e0ca2943863d5b274b2a13b4419bd
Gerrit-Change-Number: 1=
851
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>

--kHGT+btzSFA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1851?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Make pull_permission_mask return uint64_t<=
br><br>Commit 91fd9614 already changed most of the instances for the<br>opt=
ion flag to uint64_t but forgot to also adjust<br>pull_permission_mask and =
OPT_P_DEFAULT=2E<br><br>Change-Id: Icd53745b242e0ca2943863d5b274b2a13b4419b=
d<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Ra=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1851<br>Message-Id: &lt;20260823145533=2E25183=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg38599=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/init=2Ec<b=
r>M src/openvpn/init=2Eh<br>M src/openvpn/options=2Eh<br>M src/openvpn/push=
_util=2Ec<br>M tests/unit_tests/openvpn/test_push_update_msg=2Ec<br>5 files=
 changed, 13 insertions(+), 13 deletions(-)<br><br></pre>
<pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/s=
rc/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index fa62cdd=2E=
=2E66bae34 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><spa=
n>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -2514,13 +2514,13 @@</span>=
<br><span> /*</span><br><span>  * These are the option categories which wil=
l be accepted by pull=2E</span><br><span>  */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-unsigned int</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+uint64_t</span><br><span> pull_permission_mask(const struc=
t context *c)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    unsigned int flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P=
_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                         | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER |=
 OPT_P_COMP | OPT_P_PERSIST</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                         | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | O=
PT_P_ECHO | OPT_P_PULL_MODE</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                         | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t flags=
 =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                     | OPT=
_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_=
P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_=
PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU;</span><br><span> </span><br><span>   =
  if (!c-&gt;options=2Eroute_nopull)</span><br><span>     {</span><br><span=
>diff --git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh</span><br><span>i=
ndex 9d5050d=2E=2Ece8f74e 100644</span><br><span>--- a/src/openvpn/init=2Eh=
</span><br><span>+++ b/src/openvpn/init=2Eh</span><br><span>@@ -89,7 +89,7 =
@@</span><br><span>  */</span><br><span> bool do_update(struct context *c, =
uint64_t option_types_found);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-unsigned int pull_permission_mask(const struct co=
ntext *c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint64_t =
pull_permission_mask(const struct context *c);</span><br><span> </span><br>=
<span> const char *format_common_name(struct context *c, struct gc_arena *g=
c);</span><br><span> </span><br><span>diff --git a/src/openvpn/options=2Eh =
b/src/openvpn/options=2Eh</span><br><span>index c23d0b3=2E=2Ef472676 100644=
</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/op=
envpn/options=2Eh</span><br><span>@@ -761,7 +761,7 @@</span><br><span> #def=
ine OPT_P_PUSH_MTU        (1u &lt;&lt; 30)</span><br><span> #define OPT_P_R=
OUTE_TABLE     (1u &lt;&lt; 31)</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P=
_PULL_MODE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull=
))</span><br><span> </span><br><span> #define PULL_DEFINED(opt) ((opt)-&gt;=
pull)</span><br><span> </span><br><span>diff --git a/src/openvpn/push_util=
=2Ec b/src/openvpn/push_util=2Ec</span><br><span>index c927f26=2E=2Efcc5411=
 100644</span><br><span>--- a/src/openvpn/push_util=2Ec</span><br><span>+++=
 b/src/openvpn/push_util=2Ec</span><br><span>@@ -185,7 +185,7 @@</span><br>=
<span>          */</span><br><span>         struct buffer tmp_msg =3D e-&gt=
;buf;</span><br><span>         buf_string_compare_advance(&amp;tmp_msg, pus=
h_update_cmd);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 unsigned int permission_mask =3D pull_permission_mask(c);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        uint64_t permission_mask =3D=
 pull_permission_mask(c);</span><br><span>         if (process_push_update(=
c, &amp;o, permission_mask, &amp;option_types_found, &amp;tmp_msg, true) =
=3D=3D PUSH_MSG_ERROR)</span><br><span>         {</span><br><span>         =
    msg(M_WARN, &quot;Failed to process push update message sent to client =
ID: %u&quot;, c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><span>diff --=
git a/tests/unit_tests/openvpn/test_push_update_msg=2Ec b/tests/unit_tests/=
openvpn/test_push_update_msg=2Ec</span><br><span>index 9cb791b=2E=2E2653749=
 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_push_update_msg=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_push_update_msg=2E=
c</span><br><span>@@ -20,13 +20,13 @@</span><br><span>     msg(M_WARN, &quo=
t;Offending option received from server&quot;);</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned int=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><br>=
<span> pull_permission_mask(const struct context *c)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int flags =
=3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                         | OP=
T_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                         | O=
PT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                         | O=
PT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t flags =3D=
 OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_S=
ETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_ME=
SSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_PEER=
_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br><=
span>     return flags;</span><br><span> }</span><br><span> </span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1851?usp=3Demail">change 1851</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: Icd53745b242e0ca2943863d5b274b2a13b4=
419bd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1851 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--kHGT+btzSFA=--


--===============0077159523377583697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0077159523377583697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0077159523377583697==--

