Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE103C531D0
	for <openvpn-devel@archiver.kernel.org>; Sun, 26 Jul 2026 00:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=mrwSvWFUNBK7JpyiX7B4xYKDLMpl38nhj8EIZ5a4Qx4=; b=Q3MokbAtFvl+pY
	IN14z9/paBfUZ2uhCjAf7kwb3a4Sw7DgJJxpisxvQhODyPSINvAQVr7uUYp3QEWSIgAH3/iXjKzha
	DKS4e6FaJ4SEBAwvnerKF2DPFyRnhMcyYLcqxo3mTBJ9usffka+2D1iRtedkHgJClI1pr63f481vf
	Wqk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnmOX-0005hq-OG;
	Sun, 26 Jul 2026 00:07:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnmOR-0005h4-QN
 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 00:07:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/SrZwe6cvVW4AekuMWPKevDgcQNOuIxyBugGYbxIjhw=; b=eWzc0w4qk7d/2xe3Vpc5l0qGoO
 k25Ad0erneESA410rqVqU4q0pYT4p6VTWDk3WN0QKlUtfTzXjzCLIUrvKARZAwKSjMXTy+eVkiBD9
 sKowpWRUGogAmYGQkyTDqU4Pmb4x5vqdt1TWlGIs5AzJz+tzfepSxgNlvnE6pOEe9s/o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/SrZwe6cvVW4AekuMWPKevDgcQNOuIxyBugGYbxIjhw=; b=J
 jXXOb6E6jDtCx80FGWP+3szAA25DZ7Gym5bTmAS1RjCCn+g5l+x3RYTYc4pM9Oqr4OyoTRN1OBb/Z
 XlKo7lMh8KuQlvdtPtnVvtvpbs8wfL6l/o9EIBN7okgtIExy1H0w2l7PkJ4JzW/XmClo7Sbugh4O+
 pm8+G861YBJi0jgw=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnmOQ-0008Qo-31 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 00:06:59 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so1182653f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 17:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785024411; x=1785629211; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/SrZwe6cvVW4AekuMWPKevDgcQNOuIxyBugGYbxIjhw=;
 b=JMaVsLe1df5+5vXtgGg/HEYtPCT3zcD9wGPHylM8ZXlP8H+Pt2JKFb63iDiHyNfInA
 9pqzZivaJG7cp6m8MGMoVIR8dMYw4v+ZkAeu/ImlW+u9DDOT5QglhqUkel55NPfx1oQW
 YqY1dUfTk5Aacwyjn2Yw36eKE/wACP3M6kTHDjVHxRZHyZa4l/YX4xvnr0J3ocBoY7gr
 JzAJq4w+qchEpxTa1AqNzwkRKHAl/wD4FATVn+I8ilna3belGpfhpzZoqm8VPgRTcrrM
 YjlOmbKtz00eOD8mlaeXGWNT3klMZC9YLEQQrFrmAsAAPc+jLzfSY7OjhYCZdxChwGVS
 ifDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785024411; x=1785629211;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/SrZwe6cvVW4AekuMWPKevDgcQNOuIxyBugGYbxIjhw=;
 b=A7nFTC8zg2BY1OaC39FF96NBjbIK140KOqTNc4FQU/iOftUTl+qPn5L68vZZUadzLO
 uMLR/s9h0bHxfil9ERwostbh5QpJl6Olt6Jls/l/FvqGcrgyUNZVv+l8n/Xxc0Av40ZL
 JBYnr2rb4Dv0VyLGaMEcxTXRAd55m2+urzBZa1BQFxvDLTQAFMdjuaqkPEbZ20UtZ1Z3
 hJ2HKizX60yIwT/nVEW67AdBESVpUwMBobZuD3pTrFQhrHyR8r4i+9DnCWmLCcYRcOu2
 mBop5X5nQs2bXxEVlQehtEsJlVyGyUWRHaIsncIeRvfiJ68F5t+OTiS9cLn7IgydflDY
 LePQ==
X-Gm-Message-State: AOJu0Yw1yLztX3gmtIgaEZ1VLzQzSvEOU4i+0ZMx4IrnlOYcdU6AdtcW
 H2hFIcWlJlZ7WKGU5SI56C/qBbMpxJIxR6ZgbFcQL21Vol53LVNJOml6UGYGURZW2UTOPsEgLew
 Cgbm8r+ZZLKUDdKr+tx+XZIuPbblu7TMUQvupAbDrzP+3AbAB/yOOlA5hygQiexBDiOquNxg57L
 TbQrh39w==
X-Gm-Gg: AR+sD10qdq0Y0jmcMrSH8+tyWi9j5JGD4JHLVZxYVhOIrGLPPFY7pSYLrtUJL736XSx
 rXs/kkyz9fz6URC61yHqXCPZJCO27qbYSFtnes8PEHm6gAeN/F0ArteVRkabsc/ghbbeWGvK4eN
 uD391OQHfpV7/4lGjMoIRsUi/7PWMuxQHAe8MkzzG2L8JAHlvEW33K9oo+IgZzFjEYIymNXH7dU
 FNgW2IUhfFgxX6NyFE6hNGNPHkBZhLX0WvVlxWl4ApoRMkhCrebKWtGrxKkuraHnO+63oiJ9pGU
 MPRKThZ+du4wV2bF0G1SSCy46q/v+vFr/bY5qkCYUCTCZrkqI8EPSiQ0z/DZ9ja0lAQwQEU5aUr
 McyhXyPMdnn+8nW4PXQwyfnJRH8d3f86rzpSkHzREHehL1AQUikJfy368JAeT4VLKhuRpdZe8z9
 rZ40LaBRSf4V2nTmkL3TgD3vY0QQnvxa8w/Zf95gl/tDm0FIU6KMsIX6/5Gz8jk1dND6Xh1xUDR
 C8hzvjs4hYFO3neoXyNB3vt/c+UmbH6UHCHWZUUscdkGfLelPKxJlQ5psF9G0i0DXKZ
X-Received: by 2002:a05:6000:4012:b0:47f:93e1:e7d0 with SMTP id
 ffacd0b85a97d-47f9fea2d2emr4263801f8f.36.1785024411306; 
 Sat, 25 Jul 2026 17:06:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85a2573csm35590327f8f.0.2026.07.25.17.06.50
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 17:06:50 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 26 Jul 2026 00:06:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I88143b503be3394b96639d0566d084a208f4770b
X-Gerrit-Change-Number: 1823
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1823?usp=email>
X-Gerrit-Commit: ae3cc40902aa03343b0c0a914d055ef3945ebd96
References: <gerrit.1785024389000.I88143b503be3394b96639d0566d084a208f4770b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MDI0Mzg5MDAwLkk4ODE0M2I1MDNiZTMzOTRiOTY2MzlkMDU2NmQwODRhMjA4ZjQ3NzBiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <21d0eabb6e3a0a124bbf7b985d9b9cb9c6dfbd3b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnmOQ-0008Qo-31
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: Add
 support for peer entries in config
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
Content-Type: multipart/mixed; boundary="===============4591240075615587431=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4591240075615587431==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eudFU8r1Q1c="; charset=UTF-8

--eudFU8r1Q1c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1823?usp=3Demail )


Change subject: multipeer: Add supp=
ort for peer entries in config
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

multipeer: Add support for peer entries in config

This=
 only adds support for parsing the peer section and the scaffolding
around =
it=2E

Change-Id: I88143b503be3394b96639d0566d084a208f4770b
Signed-off-by: =
Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/options=2Ec
M src/openv=
pn/options=2Eh
2 files changed, 80 insertions(+), 13 deletions(-)



  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/23/1823/1

dif=
f --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 629652e=
=2E=2E8ce86ba 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/option=
s=2Ec
@@ -922,6 +922,10 @@
     {
         CLEAR(*o->connection_list);
    =
 }
+    if (o->peer_list)
+    {
+        CLEAR(*o->peer_list);
+    }
    =
 if (o->remote_list)
     {
         CLEAR(*o->remote_list);
@@ -1582,21 +1=
586,26 @@
 
 #ifndef ENABLE_SMALL
 static void
-show_connection_entry(const=
 struct connection_entry *o)
+show_local_list(const struct connection_entry=
 *e)
 {
     /* Display the global proto only in client mode or with no '--=
local'*/
-    if (o->local_list->len =3D=3D 1)
+    if (e->local_list->len =
=3D=3D 1)
     {
-        msg(D_SHOW_PARMS, "  proto =3D %s", proto2ascii(o=
->proto, o->af, false));
+        msg(D_SHOW_PARMS, "  proto =3D %s", proto=
2ascii(e->proto, e->af, false));
     }
 
     msg(D_SHOW_PARMS, "  Local S=
ockets:");
-    for (int i =3D 0; i < o->local_list->len; i++)
+    for (in=
t i =3D 0; i < e->local_list->len; i++)
     {
-        msg(D_SHOW_PARMS, "=
    [%s]:%s-%s", o->local_list->array[i]->local,
-            o->local_list=
->array[i]->port,
-            proto2ascii(o->local_list->array[i]->proto, =
o->af, false));
+        msg(D_SHOW_PARMS, "    [%s]:%s-%s", e->local_list-=
>array[i]->local,
+            e->local_list->array[i]->port,
+            =
proto2ascii(e->local_list->array[i]->proto, e->af, false));
     }
+}
+
+st=
atic void
+show_connection_entry(const struct connection_entry *o)
+{
     =
SHOW_STR(remote);
     SHOW_STR(remote_port);
     SHOW_BOOL(remote_float);=

@@ -1637,6 +1646,19 @@
     SHOW_STR_INLINE(tls_crypt_v2_file);
 }
 
+stat=
ic void
+show_peer_entries(const struct options *o)
+{
+    if (o->peer_lis=
t)
+    {
+        const struct connection_list *l =3D o->peer_list;
+     =
   for (int i =3D 0; i < l->len; ++i)
+        {
+            msg(D_SHOW_PA=
RMS, "Peer entry [%d]:", i);
+            show_connection_entry(l->array[i]=
);
+        }
+    }
+}
 
 static void
 show_connection_entries(const struc=
t options *o)
@@ -1648,12 +1670,14 @@
         for (i =3D 0; i < l->len; ++=
i)
         {
             msg(D_SHOW_PARMS, "Connection profiles [%d]:", i=
);
+            show_local_list(l->array[i]);
             show_connection_=
entry(l->array[i]);
         }
     }
     else
     {
         msg(D_SHOW_=
PARMS, "Connection profiles [default]:");
+        show_local_list(&o->ce);=

         show_connection_entry(&o->ce);
     }
     msg(D_SHOW_PARMS, "Con=
nection profiles END");
@@ -1702,6 +1726,7 @@
 
     SHOW_INT(connect_retry=
_max);
     show_connection_entries(o);
+    show_peer_entries(o);
 
     S=
HOW_BOOL(remote_random);
 
@@ -2079,20 +2104,20 @@
     return e;
 }
 
+
 s=
tatic struct connection_list *
-alloc_connection_list_if_undef(struct optio=
ns *options)
+alloc_connection_list_if_undef(struct options *options, struc=
t connection_list **connection_list)
 {
-    if (!options->connection_list)=

+    if (!*connection_list)
     {
-        ALLOC_OBJ_CLEAR_GC(options->co=
nnection_list, struct connection_list, &options->gc);
+        ALLOC_OBJ_CL=
EAR_GC(*connection_list, struct connection_list, &options->gc);
     }
-   =
 return options->connection_list;
+    return *connection_list;
 }
 
 stati=
c struct connection_entry *
-alloc_connection_entry(struct options *options=
, const msglvl_t msglevel)
+alloc_connection_list_entry(struct options *opt=
ions, struct connection_list *l, const msglvl_t msglevel)
 {
-    struct co=
nnection_list *l =3D alloc_connection_list_if_undef(options);
     struct c=
onnection_entry *e;
 
     if (l->len =3D=3D l->capacity)
@@ -2115,6 +2140,=
21 @@
     return e;
 }
 
+static struct connection_entry *
+alloc_connecti=
on_entry(struct options *options, const msglvl_t msglevel)
+{
+    struct c=
onnection_list *l =3D alloc_connection_list_if_undef(options, &options->con=
nection_list);
+    return alloc_connection_list_entry(options, l, msglevel=
);
+}
+
+static struct connection_entry *
+alloc_peer_entry(struct options =
*options, const msglvl_t msglevel)
+{
+    struct connection_list *l =3D al=
loc_connection_list_if_undef(options, &options->peer_list);
+    return all=
oc_connection_list_entry(options, l, msglevel);
+}
+
+
 static struct remot=
e_list *
 alloc_remote_list_if_undef(struct options *options)
 {
@@ -6065,6=
 +6105,31 @@
             uninit_options(&sub);
         }
     }
+    else=
 if (streq(p[0], "peer") && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_=
GENERAL | OPT_P_INLINE);
+        if (is_inline)
+        {
+            st=
ruct options sub;
+            struct connection_entry *e;
+            ini=
t_options(&sub);
+
+            read_config_string("[PEER-OPTIONS]", &sub, =
p[1], msglevel, OPT_P_CONNECTION,
+                               option_ty=
pes_found, es);
+
+            if (!sub=2Ece=2Eremote)
+            {
+    =
            msg(msglevel,
+                    "Each 'connection' block mus=
t contain exactly one 'remote' directive");
+                uninit_options=
(&sub);
+                goto err;
+            }
+            e =3D alloc_=
peer_entry(options, msglevel);
+            *e =3D sub=2Ece;
+            g=
c_transfer(&options->gc, &sub=2Egc);
+            uninit_options(&sub);
+  =
      }
+    }
     else if (streq(p[0], "ignore-unknown-option") && p[1])
=
     {
         int i;
diff --git a/src/openvpn/options=2Eh b/src/openvpn/o=
ptions=2Eh
index ffabba4=2E=2E353a9a4 100644
--- a/src/openvpn/options=2Eh
=
+++ b/src/openvpn/options=2Eh
@@ -293,6 +293,7 @@
     int connect_retry_ma=
x;
     struct connection_entry ce;
     struct connection_list *connection=
_list;
+    struct connection_list *peer_list;
 
     struct remote_list *r=
emote_list;
     /* Do not advance the connection or remote addr list */
@@=
 -758,6 +759,7 @@
 #define OPT_P_INLINE          (1u << 29)
 #define OPT_P_=
PUSH_MTU        (1u << 30)
 #define OPT_P_ROUTE_TABLE     (1u << 31)
+#defi=
ne OPT_P_PEER            (1u << 32)
 
 #define OPT_P_DEFAULT (~(OPT_P_INSTA=
NCE | OPT_P_PULL_MODE))
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1823?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I88143b503be3394b96639d0566d084a208f4770b
Gerrit-Change-Number: 1823=

Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--eudFU8r1Q1c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1823?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">multipeer: Add support for peer entries in config<br><br>This only=
 adds support for parsing the peer section and the scaffolding<br>around it=
=2E<br><br>Change-Id: I88143b503be3394b96639d0566d084a208f4770b<br>Signed-o=
ff-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/opti=
ons=2Ec<br>M src/openvpn/options=2Eh<br>2 files changed, 80 insertions(+), =
13 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/23/1823/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 629652e=2E=2E=
8ce86ba 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><spa=
n>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -922,6 +922,10 @@</span>=
<br><span>     {</span><br><span>         CLEAR(*o-&gt;connection_list);</s=
pan><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (o-&gt;peer_list)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
CLEAR(*o-&gt;peer_list);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span>     if (o-&gt;remote_list)</span><br><span>    =
 {</span><br><span>         CLEAR(*o-&gt;remote_list);</span><br><span>@@ -=
1582,21 +1586,26 @@</span><br><span> </span><br><span> #ifndef ENABLE_SMALL=
</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-show_connection_entry(const struct connection_entry *o)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+show_local_list(const struct co=
nnection_entry *e)</span><br><span> {</span><br><span>     /* Display the g=
lobal proto only in client mode or with no &#39;--local&#39;*/</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;local_list-&gt;len =
=3D=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (e-=
&gt;local_list-&gt;len =3D=3D 1)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        msg(D_SHOW_PARMS, &quot;  proto =
=3D %s&quot;, proto2ascii(o-&gt;proto, o-&gt;af, false));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(D_SHOW_PARMS, &quot;  pro=
to =3D %s&quot;, proto2ascii(e-&gt;proto, e-&gt;af, false));</span><br><spa=
n>     }</span><br><span> </span><br><span>     msg(D_SHOW_PARMS, &quot;  L=
ocal Sockets:&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    for (int i =3D 0; i &lt; o-&gt;local_list-&gt;len; i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; e-&gt;=
local_list-&gt;len; i++)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        msg(D_SHOW_PARMS, &quot;    [%s]:%s-%s&qu=
ot;, o-&gt;local_list-&gt;array[i]-&gt;local,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            o-&gt;local_list-&gt;array[i]-&gt;port,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            proto2asc=
ii(o-&gt;local_list-&gt;array[i]-&gt;proto, o-&gt;af, false));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(D_SHOW_PARMS, &quot;=
    [%s]:%s-%s&quot;, e-&gt;local_list-&gt;array[i]-&gt;local,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            e-&gt;local_list-&gt=
;array[i]-&gt;port,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            proto2ascii(e-&gt;local_list-&gt;array[i]-&gt;proto, e-&gt;af, =
false));</span><br><span>     }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+show_connection_entry(const struc=
t connection_entry *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span>     SHOW_STR(remote);</span><br><span>     SHOW_STR(r=
emote_port);</span><br><span>     SHOW_BOOL(remote_float);</span><br><span>=
@@ -1637,6 +1646,19 @@</span><br><span>     SHOW_STR_INLINE(tls_crypt_v2_fi=
le);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+show_peer_entries(const struct options *o)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (o-&gt;peer_list)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        const struct connection_list *l =3D o-&gt;peer_list;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0=
; i &lt; l-&gt;len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       msg(D_SHOW_PARMS, &quot;Peer entry [%d]:&quot;, i);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            show_connection_entry(l-=
&gt;array[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br=
><span> static void</span><br><span> show_connection_entries(const struct o=
ptions *o)</span><br><span>@@ -1648,12 +1670,14 @@</span><br><span>        =
 for (i =3D 0; i &lt; l-&gt;len; ++i)</span><br><span>         {</span><br>=
<span>             msg(D_SHOW_PARMS, &quot;Connection profiles [%d]:&quot;,=
 i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sho=
w_local_list(l-&gt;array[i]);</span><br><span>             show_connection_=
entry(l-&gt;array[i]);</span><br><span>         }</span><br><span>     }</s=
pan><br><span>     else</span><br><span>     {</span><br><span>         msg=
(D_SHOW_PARMS, &quot;Connection profiles [default]:&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        show_local_list(&amp;o-&gt;=
ce);</span><br><span>         show_connection_entry(&amp;o-&gt;ce);</span><=
br><span>     }</span><br><span>     msg(D_SHOW_PARMS, &quot;Connection pro=
files END&quot;);</span><br><span>@@ -1702,6 +1726,7 @@</span><br><span> </=
span><br><span>     SHOW_INT(connect_retry_max);</span><br><span>     show_=
connection_entries(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    show_peer_entries(o);</span><br><span> </span><br><span>     SHOW_BO=
OL(remote_random);</span><br><span> </span><br><span>@@ -2079,20 +2104,20 @=
@</span><br><span>     return e;</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static =
struct connection_list *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-alloc_connection_list_if_undef(struct options *options)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+alloc_connection_list_if_undef(struc=
t options *options, struct connection_list **connection_list)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!options=
-&gt;connection_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!*connection_list)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ALLOC_OBJ_CLEAR_GC(options-&gt;conn=
ection_list, struct connection_list, &amp;options-&gt;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        ALLOC_OBJ_CLEAR_GC(*connecti=
on_list, struct connection_list, &amp;options-&gt;gc);</span><br><span>    =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return options-=
&gt;connection_list;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return *connection_list;</span><br><span> }</span><br><span> </span><b=
r><span> static struct connection_entry *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-alloc_connection_entry(struct options *options, const m=
sglvl_t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+al=
loc_connection_list_entry(struct options *options, struct connection_list *=
l, const msglvl_t msglevel)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct connection_list *l =3D alloc_connection=
_list_if_undef(options);</span><br><span>     struct connection_entry *e;</=
span><br><span> </span><br><span>     if (l-&gt;len =3D=3D l-&gt;capacity)<=
/span><br><span>@@ -2115,6 +2140,21 @@</span><br><span>     return e;</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static struct connection_entry *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+alloc_connection_entry(struct options *options, co=
nst msglvl_t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct conn=
ection_list *l =3D alloc_connection_list_if_undef(options, &amp;options-&gt=
;connection_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return alloc_connection_list_entry(options, l, msglevel);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static struct connection_entry *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+alloc_peer_entry(struct options *options, const msglvl_t m=
sglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct connection_list *l=
 =3D alloc_connection_list_if_undef(options, &amp;options-&gt;peer_list);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return alloc_conn=
ection_list_entry(options, l, msglevel);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> static struct remote_list *</span><br><span> alloc_remote_list_if_undef(s=
truct options *options)</span><br><span> {</span><br><span>@@ -6065,6 +6105=
,31 @@</span><br><span>             uninit_options(&amp;sub);</span><br><sp=
an>         }</span><br><span>     }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else if (streq(p[0], &quot;peer&quot;) &amp;&amp; !p[2=
])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P=
_GENERAL | OPT_P_INLINE);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (is_inline)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           struct options sub;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            struct connection_entry *e;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            init_options(&amp;sub);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            read_config_string(&quot;[PEER-OPTI=
ONS]&quot;, &amp;sub, p[1], msglevel, OPT_P_CONNECTION,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                               option_t=
ypes_found, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!sub=
=2Ece=2Eremote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      msg(msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    &quot;Each &#39;connection&#39; block must contain exac=
tly one &#39;remote&#39; directive&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                uninit_options(&amp;sub);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                goto err;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            e =3D alloc_peer_e=
ntry(options, msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            *e =3D sub=2Ece;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            gc_transfer(&amp;options-&gt;gc, &amp;sub=2Egc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            uninit_o=
ptions(&amp;sub);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span>     else if (streq(p[0], &quot;ignore-unknown-option&quot;) &amp=
;&amp; p[1])</span><br><span>     {</span><br><span>         int i;</span><=
br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</sp=
an><br><span>index ffabba4=2E=2E353a9a4 100644</span><br><span>--- a/src/op=
envpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><=
span>@@ -293,6 +293,7 @@</span><br><span>     int connect_retry_max;</span>=
<br><span>     struct connection_entry ce;</span><br><span>     struct conn=
ection_list *connection_list;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct connection_list *peer_list;</span><br><span> </span><b=
r><span>     struct remote_list *remote_list;</span><br><span>     /* Do no=
t advance the connection or remote addr list */</span><br><span>@@ -758,6 +=
759,7 @@</span><br><span> #define OPT_P_INLINE          (1u &lt;&lt; 29)</s=
pan><br><span> #define OPT_P_PUSH_MTU        (1u &lt;&lt; 30)</span><br><sp=
an> #define OPT_P_ROUTE_TABLE     (1u &lt;&lt; 31)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define OPT_P_PEER            (1u &lt;&lt; 3=
2)</span><br><span> </span><br><span> #define OPT_P_DEFAULT (~(OPT_P_INSTAN=
CE | OPT_P_PULL_MODE))</span><br><span> </span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1823?=
usp=3Demail">change 1823</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1823?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I88143b503be3394b96639d0566d084a208f4770b </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1823 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--eudFU8r1Q1c=--


--===============4591240075615587431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4591240075615587431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4591240075615587431==--

