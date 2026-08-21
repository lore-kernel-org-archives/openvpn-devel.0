Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D1AC5DF8C
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 20:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GPxuLIhLveJIibaQ4cBrqSeWS5YbZhXtD50oTFN0KIM=; b=P2+Hq+nC8wUjjwVXigCnYoNPYd
	FGCKhAPHsXslco2sJOwuHMFyH80YN/N+XQcA2zAqd7MW25p8a7TWbFMVfTP4X8F8ORnek04cdVrdB
	RFS6kL7TM43Re+TFnpIhyEPKQdgYZJmqwb9lv+C6LQJftl1X1XV1syIAbijgIVYNXR3c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxWCY-0000vv-CY;
	Fri, 21 Aug 2026 20:50:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxWCH-0000vd-E1
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 20:50:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UwQ/Qe9AUtLxopqWQTYBK9Lfvhu8Tb4xV7RFTHgmxVI=; b=EFV3MaECGcRUMndNkFfWgRN6bD
 m8MTBczGh8eCOeDmSfhT2arxqFxmaf9VqvMTtRGVkwORsKXq3TvD+zb6JFhbV/uE0eYZ2GaRjYDXY
 iIJr0vqIcTWPy9Lnz2oUZPILJcgyQMFg/w6r+dSVoiDC6TpcUXJerMkYYceDkOetXnlw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UwQ/Qe9AUtLxopqWQTYBK9Lfvhu8Tb4xV7RFTHgmxVI=; b=A
 iofMKmelISLMuQjW+JdpGR2Rfx4qhtAQhArHdu6mIcgFBS66v5jpGfK5f3Vs3QHVEnhkDF/vVjOVL
 q+wpD8aRLGLqou5Lxj/jXaJG2pcL1UG6LYZUFnjojD372XK7pbR11y7RdxdwPJIvCDg3dgS/pqYN4
 g0Q0WpRjwyVXWb3M=;
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxWC9-00052i-W9 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 20:50:35 +0000
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6a1a546a6bbso2774266a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 13:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787345427; x=1787950227; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UwQ/Qe9AUtLxopqWQTYBK9Lfvhu8Tb4xV7RFTHgmxVI=;
 b=McRYWqa7CLqSEsDYuvs//TojtQx0weKJlFZoViZyEmOgOsMatc4EvtNy+l1a0aN4nW
 +iJpjr/ISV/1avhgupxRRC000HfBkH+zG9jt/+qiBgMDTU1QdK3FhLOEDRNhklxczTef
 efHYFBPBkYRvzl6zQ04nxni1zpCqHOUb/xTQ1gzgrCix7mjR3405aSuNGDOQ2D2wxTTA
 pOPlhNyeROaisktfojfswClvToQimAnUy70UDHU+kr6JX2vGqGlC2XW/IA8yD9HZwKSL
 ru0hxGFtF5xiiUUL0LUoP7kO9bGV9MA3FSxej6paH3jONb+NeVnEkVNGsvJdR9zFvHhJ
 fMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787345427; x=1787950227;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UwQ/Qe9AUtLxopqWQTYBK9Lfvhu8Tb4xV7RFTHgmxVI=;
 b=Oy4SrAkYn5CD1J07Tu2WBg8vj4GmKzUwVUhhtNi207TUqToMjXh1t5URC2fReIVbRj
 NCoFUdG9qH2S+FDueqschHzTIpB7BgSIOHVg0JKIoQLZemtE1TB38TajeUIMnI5F0fnj
 Z+O0AFBxyxLRiJGqLu1MCeiEuOOYABmO3QyH+mbUUFt1tTwCbK9Ef3D+wrgkaV8JUgBC
 779bTRgQTE+6WtEMcLjg4a81fDl9RfWQ/8FP9pkxIQwqVSAbZM29H6V8zVb3rKqUDfSu
 wvkOZu6eYqZTByVUEXg1Az2FYBB11rOOZKquQmD4WEhkZ1sGFLnMaq/Oh5+RsAYw1HB8
 Kwng==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZAz0WFU62BfbR0mgkTuFMKCraWV/dcIBGTGB3aITE5k94E46Yq+FVTccX11t+DwguZl4cnKnObjmdhGt0@lists.sourceforge.net
X-Gm-Message-State: AFuF++lIEzwdY7qxHhMDOabE1TT6xwkJldDvqvpfD4p4W16aawHlBC2Y
 6l2S1UXwVW9eMr0EuAUmqJEQhHNXHvzQytPvolg4QWXukThPa+Xq5RfloVhwhlhLR1NxhIPl1YV
 5zzAQvU4EZ1jId6jNhQCZLwhv0sUq6g/L+FbA0nQL3z+IEDPgOMOCu/eq0dCSLYmNU3Jo
X-Gm-Gg: AR+sD12+m890NQyIZj6783U1p1bAnl6o7Yy57LoFWgRzONXTS25Cc1Yv7Q8sz4XTOGO
 fIbX9NWJiGM6bUw9rVZDb70W4GMWDrw3Lbw3LM9MMBmquc3iG6X5T8PbTWTmVw7LiQtdMzEY1jD
 nPh4TGktEUAQ30gx/Zz8ph8Cmypeja8RIpwPUDS7oH6cr911J0iqCHbiqUzNffNnhkD/90Nmqwl
 px1/VFSwhDkFpsqZJwJbiAUar/F5drJr5v4XARa9OBng0jnfB9hK7hYpebN2vk1aU987uSe52xZ
 GARbSbsta3jGKKci5nH9dbKa+yRuz9qdHkUa6j3LiV5GUYg0Vvki8NxD5Hx2mYDkHCmvOj0FbYs
 IgKCAnwi/q8sALlhQdJGzysekZBk2NlkgF8rESbA7Um59HfzSA35axkyE4o89aeLgZa4e1BRhh6
 be7smvFdlp+z6Pvs6as6Fp5UuX89GNzuAPMxRc9iedPlzdERaxqTYZHqaSLc0hqMoyKEJWBN9fk
 0289kSwno/9bjeZBMIz0wFIBOIdQInBnV0S8tHG3Fr+1V96cznFSMjx+ETYr0NXrM8GFk73UpnQ
 C4MP73gp/Xi90ExFrCeMXlwyfPMqLxRL0A1Az0U6g4Bc7b93Jq5NAH9SS1DO2w==
X-Received: by 2002:a05:6402:1f02:b0:6a1:28d8:2306 with SMTP id
 4fb4d7f45d1cf-6a42f0f7c19mr9987457a12.1.1787345427127; 
 Fri, 21 Aug 2026 13:50:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1780c9sm8031302a12.28.2026.08.21.13.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 13:50:26 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 20:50:16 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icd53745b242e0ca2943863d5b274b2a13b4419bd
X-Gerrit-Change-Number: 1851
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1851?usp=email>
X-Gerrit-Commit: 02d21cd4f9cfe177750c9738d2c666cce15fa89e
In-Reply-To: <gerrit.1787327336000.Icd53745b242e0ca2943863d5b274b2a13b4419bd@gerrit.openvpn.net>
References: <gerrit.1787327336000.Icd53745b242e0ca2943863d5b274b2a13b4419bd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkljZDUzNzQ1YjI0MmUwY2EyOTQzODYzZDViMjc0YjJhMTNiNDQxOWJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ef047db295d4088e3ec6cf35b131118789bd3cbb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxWC9-00052i-W9
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
Content-Type: multipart/mixed; boundary="===============5948602337060229929=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5948602337060229929==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fl51sIR2m10="; charset=UTF-8

--fl51sIR2m10=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

plaisthos has uploaded =
a new patch set (#2)=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851?us=
p=3Demail )


Change subject: Make pull_permission_mask return uint64_t
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make pull_permis=
sion_mask return uint64_t

Commit 91fd9614 already change most of the insta=
nces for the
option flag to uint64_t but forgot to also adjust
pull_permiss=
ion_mask=2E

Change-Id: Icd53745b242e0ca2943863d5b274b2a13b4419bd
Signed-of=
f-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/init=2Ec
M src/op=
envpn/init=2Eh
M src/openvpn/options=2Eh
M src/openvpn/push_util=2Ec
M test=
s/unit_tests/openvpn/test_push_update_msg=2Ec
5 files changed, 13 insertion=
s(+), 13 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/51/1851/2

diff --git a/src/openvpn/init=2Ec b/src/openvpn/=
init=2Ec
index fa62cdd=2E=2E66bae34 100644
--- a/src/openvpn/init=2Ec
+++ b=
/src/openvpn/init=2Ec
@@ -2514,13 +2514,13 @@
 /*
  * These are the option =
categories which will be accepted by pull=2E
  */
-unsigned int
+uint64_t
 =
pull_permission_mask(const struct context *c)
 {
-    unsigned int flags =
=3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
-      =
                   | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP=
 | OPT_P_PERSIST
-                         | OPT_P_MESSAGES | OPT_P_EXPLICI=
T_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-                         | OPT_P_P=
EER_ID | OPT_P_NCP | OPT_P_PUSH_MTU;
+    uint64_t flags =3D OPT_P_UP | OPT=
_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
+                     | O=
PT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
+    =
                 | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OP=
T_P_PULL_MODE
+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUS=
H_MTU;
 
     if (!c->options=2Eroute_nopull)
     {
diff --git a/src/openv=
pn/init=2Eh b/src/openvpn/init=2Eh
index 9d5050d=2E=2Ece8f74e 100644
--- a/=
src/openvpn/init=2Eh
+++ b/src/openvpn/init=2Eh
@@ -89,7 +89,7 @@
  */
 boo=
l do_update(struct context *c, uint64_t option_types_found);
 
-unsigned in=
t pull_permission_mask(const struct context *c);
+uint64_t pull_permission_=
mask(const struct context *c);
 
 const char *format_common_name(struct con=
text *c, struct gc_arena *gc);
 
diff --git a/src/openvpn/options=2Eh b/src=
/openvpn/options=2Eh
index 0fd505a=2E=2Ee93b05b 100644
--- a/src/openvpn/op=
tions=2Eh
+++ b/src/openvpn/options=2Eh
@@ -761,7 +761,7 @@
 #define OPT_P_=
PUSH_MTU        (1u << 30)
 #define OPT_P_ROUTE_TABLE     (1u << 31)
 
-#de=
fine OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE))
+#define OPT_P_DEF=
AULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))
 
 #def=
ine PULL_DEFINED(opt) ((opt)->pull)
 
diff --git a/src/openvpn/push_util=2E=
c b/src/openvpn/push_util=2Ec
index c927f26=2E=2Efcc5411 100644
--- a/src/o=
penvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -185,7 +185,7 @@
  =
        */
         struct buffer tmp_msg =3D e->buf;
         buf_string_c=
ompare_advance(&tmp_msg, push_update_cmd);
-        unsigned int permission=
_mask =3D pull_permission_mask(c);
+        uint64_t permission_mask =3D pu=
ll_permission_mask(c);
         if (process_push_update(c, &o, permission_m=
ask, &option_types_found, &tmp_msg, true) =3D=3D PUSH_MSG_ERROR)
         {=

             msg(M_WARN, "Failed to process push update message sent to cl=
ient ID: %u", c->c2=2Etls_multi->rx_peer_id);
diff --git a/tests/unit_tests=
/openvpn/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/test_push_upda=
te_msg=2Ec
index 9cb791b=2E=2E2653749 100644
--- a/tests/unit_tests/openvpn=
/test_push_update_msg=2Ec
+++ b/tests/unit_tests/openvpn/test_push_update_m=
sg=2Ec
@@ -20,13 +20,13 @@
     msg(M_WARN, "Offending option received from=
 server");
 }
 
-unsigned int
+uint64_t
 pull_permission_mask(const struct =
context *c)
 {
-    unsigned int flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | =
OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
-                         | OPT_P_SETENV | =
OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
-                  =
       | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_M=
ODE
-                         | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU =
| OPT_P_ROUTE | OPT_P_DHCPDNS;
+    uint64_t flags =3D OPT_P_UP | OPT_P_ROU=
TE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
+                     | OPT_P_S=
ETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
+          =
           | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PU=
LL_MODE
+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU =
| OPT_P_ROUTE | OPT_P_DHCPDNS;
     return flags;
 }
 

-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: Icd53745b242e0ca2943863d5b274b2a13b44=
19bd
Gerrit-Change-Number: 1851
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--fl51sIR2m10=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1851?usp=3Demail">View Change</a></p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Make =
pull_permission_mask return uint64_t<br><br>Commit 91fd9614 already change =
most of the instances for the<br>option flag to uint64_t but forgot to also=
 adjust<br>pull_permission_mask=2E<br><br>Change-Id: Icd53745b242e0ca294386=
3d5b274b2a13b4419bd<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&g=
t;<br>---<br>M src/openvpn/init=2Ec<br>M src/openvpn/init=2Eh<br>M src/open=
vpn/options=2Eh<br>M src/openvpn/push_util=2Ec<br>M tests/unit_tests/openvp=
n/test_push_update_msg=2Ec<br>5 files changed, 13 insertions(+), 13 deletio=
ns(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/51/1851/2</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec =
b/src/openvpn/init=2Ec</span><br><span>index fa62cdd=2E=2E66bae34 100644</s=
pan><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/=
init=2Ec</span><br><span>@@ -2514,13 +2514,13 @@</span><br><span> /*</span>=
<br><span>  * These are the option categories which will be accepted by pul=
l=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uin=
t64_t</span><br><span> pull_permission_mask(const struct context *c)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsig=
ned int flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOC=
KFLAGS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
          | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_=
PERSIST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
           | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PU=
LL_MODE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
           | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    uint64_t flags =3D OPT_P_UP | OPT_=
P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                     | OPT_P_SETENV | OPT_P_SH=
APER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                     | OPT_P_MESSAGES | OPT_P_E=
XPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                     | OPT_P_PEER_ID | OPT_P_NCP =
| OPT_P_PUSH_MTU;</span><br><span> </span><br><span>     if (!c-&gt;options=
=2Eroute_nopull)</span><br><span>     {</span><br><span>diff --git a/src/op=
envpn/init=2Eh b/src/openvpn/init=2Eh</span><br><span>index 9d5050d=2E=2Ece=
8f74e 100644</span><br><span>--- a/src/openvpn/init=2Eh</span><br><span>+++=
 b/src/openvpn/init=2Eh</span><br><span>@@ -89,7 +89,7 @@</span><br><span> =
 */</span><br><span> bool do_update(struct context *c, uint64_t option_type=
s_found);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-unsigned int pull_permission_mask(const struct context *c);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+uint64_t pull_permission_mask=
(const struct context *c);</span><br><span> </span><br><span> const char *f=
ormat_common_name(struct context *c, struct gc_arena *gc);</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/option=
s=2Eh</span><br><span>index 0fd505a=2E=2Ee93b05b 100644</span><br><span>---=
 a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</s=
pan><br><span>@@ -761,7 +761,7 @@</span><br><span> #define OPT_P_PUSH_MTU  =
      (1u &lt;&lt; 30)</span><br><span> #define OPT_P_ROUTE_TABLE     (1u &=
lt;&lt; 31)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_DEFAULT (~(OP=
T_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))</span><br><span> =
</span><br><span> #define PULL_DEFINED(opt) ((opt)-&gt;pull)</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/pu=
sh_util=2Ec</span><br><span>index c927f26=2E=2Efcc5411 100644</span><br><sp=
an>--- a/src/openvpn/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_u=
til=2Ec</span><br><span>@@ -185,7 +185,7 @@</span><br><span>          */</s=
pan><br><span>         struct buffer tmp_msg =3D e-&gt;buf;</span><br><span=
>         buf_string_compare_advance(&amp;tmp_msg, push_update_cmd);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        unsigned int permiss=
ion_mask =3D pull_permission_mask(c);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        uint64_t permission_mask =3D pull_permission_mask=
(c);</span><br><span>         if (process_push_update(c, &amp;o, permission=
_mask, &amp;option_types_found, &amp;tmp_msg, true) =3D=3D PUSH_MSG_ERROR)<=
/span><br><span>         {</span><br><span>             msg(M_WARN, &quot;F=
ailed to process push update message sent to client ID: %u&quot;, c-&gt;c2=
=2Etls_multi-&gt;rx_peer_id);</span><br><span>diff --git a/tests/unit_tests=
/openvpn/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/test_push_upda=
te_msg=2Ec</span><br><span>index 9cb791b=2E=2E2653749 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><span>+=
++ b/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><span>@@ -=
20,13 +20,13 @@</span><br><span>     msg(M_WARN, &quot;Offending option rec=
eived from server&quot;);</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-unsigned int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><br><span> pull_permission=
_mask(const struct context *c)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    unsigned int flags =3D OPT_P_UP | OPT_P_ROU=
TE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                         | OPT_P_SETENV | OPT_P_SHAPE=
R | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                         | OPT_P_MESSAGES | OPT_P_EX=
PLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                         | OPT_P_PEER_ID | OPT_P_NCP=
 | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_=
EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                     | OPT_P_SETENV | OPT_P_SHAPER | O=
PT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                     | OPT_P_MESSAGES | OPT_P_EXPLICIT_=
NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_=
PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br><span>     return flags;<=
/span><br><span> }</span><br><span> </span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=
=3Demail">change 1851</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1851?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Icd53745b242e0ca2943863d5b274b2a13b4419bd </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1851 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--fl51sIR2m10=--


--===============5948602337060229929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5948602337060229929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5948602337060229929==--

