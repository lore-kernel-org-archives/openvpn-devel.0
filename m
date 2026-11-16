Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A00606A32A
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Zmeiz1+S;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hr0OAwWj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hz7ef1La;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fmHxcNj1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=x5ZcecuTJIG1y0NqHOEKseiaCY696iH4ZkEBP+Uvkvc=; b=Zmeiz1+SlgiDOg3zAMTjIBY2Xg
	2hXkPHUiYxHho2yRc7M04uQxfaB/eOK6eeKQbNyE8kpl5NQIeqsba1FoiX2W5Zb1vMhxr28dX9czC
	PLzjlhzno55wdNHwDa/jE2//DHHMjjl6af6gknViQsjizNc4s3li4BNGCv0Fi9CowFQA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSwUC-0000000014F-0sLT;
	Mon, 16 Nov 2026 13:11:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSwUB-00000000149-1jH0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 13:11:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qwfsMM2sSvghxV/PEPfyHLPOaUc87V3080RzxAEaQTM=; b=hr0OAwWjfkyuP1giEZ2bXcwugb
 03pOz4oHBYHPFudGE0oeB9FhWN8SvH79b3c+8XRqexh1I8CDle2ZrFihJ7LJpB9hkulih+irKRt3R
 l8US/D45cMxUsbrxbNko29vB6Lem+bPM4rRXU5pJaNox1maLvO0+K7RKCFd5lUKpQVfg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qwfsMM2sSvghxV/PEPfyHLPOaUc87V3080RzxAEaQTM=; b=hz7ef1LaGU2qakY1QAkdOyACX/
 ptnAgI6tlFkZxGfZrajFfeAnJ9Hwt8W8MmcrFi/H/GNVkdmU/ICPippFkT2ozE9UrizPl4rqLWxpV
 9XXpoTO/JUX//7ge3PTPFbR788rM8u7AvgIcWYTimu2UiWjCArPPrynbE9u6WZsj4VpE=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSwU7-000000004YX-19VA for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 13:11:03 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so9892485e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 05:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794834653; x=1795439453; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qwfsMM2sSvghxV/PEPfyHLPOaUc87V3080RzxAEaQTM=;
 b=fmHxcNj1Ab3d6FXfGv2y4dbnlLTvw3DyX4rLn1Z/GMi+nqYBHFbw57dwUmUUAyxY+I
 v9cs0ytAfyn9loTU4q+G0uuRPUS3zRazvx32Za9Mf9QGe1gSjG6Xaez5Cug+Ns0sdIk2
 4xrR9DCdip86a0TtHU65wDcWQdP/xJDx2ASUlh77T+/jVQ8SNEzv9lYkc36gzhwLeihC
 tX45hzEA1AQJhj0Yyg1QuawsnlSE36xaD4pzsQVrYBFHk8MRNMDkTdayx+OXEWbj2IDY
 aityII5GJfCL6R2iPnoQrOnKoXqIkujTc5lIkXDU/2CKMfTYvLf9Coo0eccoZXAziTbD
 cM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794834653; x=1795439453;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qwfsMM2sSvghxV/PEPfyHLPOaUc87V3080RzxAEaQTM=;
 b=OGwD9JLwEpXx3Kjc6Jwe8TCHtnIJK/W/kSVryESReytOoi8igAGSKZNyo7R8SuoUHh
 7wusXGEveBYkcvubAzBDcSTd74uz2lcaXUm1XxbUMAJwP8woaAL4n+bbM2H/LKen+hP4
 /aSkfHhdlKmxjeP+0/Va9g7PlYj81eAWf9yxc+hISm+9enaoojCnWfXm+d5GfiQPHaZl
 /oyCzVR3kKlr/UGEOD+0B3/joLFT3KyeFgkih72LiAhYU6+XTOJqSc9tFfEwi8yKU4DL
 WXZVC80/A6itub0Plwvr/UMkS53FK/GfdSKyeJs6Njv/vkCYadwB807a8gxcZeVFNi1y
 nz1A==
X-Gm-Message-State: APuU4Z9O+8KPDURssQ7ZFsxAdvXTr1p7Gc7w68fEZpH5VDX6hxGfskx/
 cvqUJXYIszHMIK8mo5tSQFRhSXWfQCp66rxDng4Rtv84zgOk7HZrAAuGzWv8dA1J3817asj4QJR
 YJ3k797i8YxvCMCvE0Ehd6vmWtbfLh5PTvyvUNINLKBLm9DSNzTqkzPNjqHcR9UHMyjyrV1shD8
 WYg9JXPw==
X-Gm-Gg: AYBFou2AiW5ghY2dMQs1x+vhssjrFN798onJlLSQVrMJKjDBmboR8sRZ55fRkSgDmrK
 jSKIH5k/Q6yM5pTSUxdMoTcQPoWwraAcLU3LCp83vpoXZOZ7eSsQy2u/rjzBnOYdDfewNHiwQ1C
 Ks/S89WLL1BrFYrL3VMOc77xUVtX2zG4NdlynnnnsHzHlXw5c31Ee1LM9U3k+jmijJcbINfAxiD
 BGCBD1fXPkP5wE9cRC5U3bIeq7u/0As66/XXVaNojeuZgd0T2bpLqEWpvW7Qx+RfZuORYWn8NGF
 cnkvGLv8owMaHciOQy+uDyKOrep2FuhfqtKCzo7FpGLRHuQUsWhqEFwmq9MY25WSrbtn00FmYlI
 Ydfp1hbTFLzgLYLn5Tva2jBKV2f5pmlk0l93nYFm0RnHYUE8Fh12v3UWUxPh5XiI4J7+zuo4vnT
 A3eDXEVk/xvXLw+GhtilfiIZ0NLZ0omKWztzdhjCcffFrPwQb2QvD5YhOjMsMbAVqscBgcGNm9Y
 DumWVJATD5Q5T+YGXsxCLiCAEIDJvryjgU528mv4HAEo0t6NCNNZtU9aHps35F9hlCSRHzKZcz8
 HSt1x89UQrGadOyTxDpTUw5LBEjbUjhxXcIjpC6YeQHd056D4pigfp7BdCQrOYKkFL9bWZaqfvj
 tRixz3keYOwkhwqAMQVo8+m/Gi4168E/UbZa1EVQ2rFrMtW7wrdvApRJ0fGZj86QapZf1rcT6De
 +WIEWOt3FlZ2Kbq1M=
X-Received: by 2002:a05:600c:34d6:b0:4a8:f2ad:a9e5 with SMTP id
 5b1f17b1804b1-4bb559f609cmr205863055e9.3.1794834652457; 
 Mon, 16 Nov 2026 05:10:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ac0e1esm261665465e9.3.2026.11.16.05.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:10:51 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 13:10:51 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3
X-Gerrit-Change-Number: 2196
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2196?usp=email>
X-Gerrit-Commit: 361eebdd53b6542dfbe737298db14e43e2950bd3
References: <gerrit.1794834650000.Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM0NjUwMDAwLkllYzg1ZDUzY2UxMDc2NjM5YmQ2Y2VhZjNiYTdkNTNjYzllNzlkN2EzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b005f51fba32f819eb0eeb26dedda0d2cc8213ec-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSwU7-000000004YX-19VA
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: drop
 impossible out-of-memory branches
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2726526901823814427=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2726526901823814427==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U9M+jNOHpD4="; charset=UTF-8

--U9M+jNOHpD4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2196?usp=3Demail

to review the following change=2E
=


Change subject: options: drop impossible out-of-memory branches
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: drop impossib=
le out-of-memory branches

gc_realloc() aborts via check_malloc_return() an=
d never returns NULL=2E
Remove the NULL handling from alloc_{local,connecti=
on,remote}_entry(),
their now unused msglevel parameter, and the callers' c=
hecks=2E

Change-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3
Signed-off-b=
y: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/options=2Ec
1 =
file changed, 12 insertions(+), 52 deletions(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/96/2196/1

diff --git a/src/ope=
nvpn/options=2Ec b/src/openvpn/options=2Ec
index 1d8bb2a=2E=2E67c91ab 10064=
4
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1377,7 +1=
377,7 @@
 }
 
 static struct local_entry *
-alloc_local_entry(struct connec=
tion_entry *ce, const msglvl_t msglevel, struct gc_arena *gc)
+alloc_local_=
entry(struct connection_entry *ce, struct gc_arena *gc)
 {
     struct loca=
l_list *l =3D alloc_local_list_if_undef(ce, gc);
     struct local_entry *e=
;
@@ -1387,16 +1387,7 @@
         const int new_cap =3D l->capacity + 1;
  =
       const size_t elem_size =3D sizeof(*l->array);
 
-        struct loca=
l_entry **new_array =3D gc_realloc(l->array, new_cap * elem_size, gc);
-   =
     if (!new_array)
-        {
-            msg(msglevel,
-               =
 "Unable to process more local options: out of memory=2E Number of entries =
=3D %d",
-                l->len);
-            return NULL;
-        }
-
-=
        l->array =3D new_array;
+        l->array =3D gc_realloc(l->array, =
new_cap * elem_size, gc);
         l->capacity =3D new_cap;
     }
 
@@ -14=
18,7 +1409,7 @@
 }
 
 static struct connection_entry *
-alloc_connection_en=
try(struct options *options, const msglvl_t msglevel)
+alloc_connection_ent=
ry(struct options *options)
 {
     struct connection_list *l =3D alloc_con=
nection_list_if_undef(options);
     struct connection_entry *e;
@@ -1426,1=
6 +1417,7 @@
     if (l->len =3D=3D l->capacity)
     {
         int capaci=
ty =3D l->capacity + CONNECTION_LIST_SIZE;
-        struct connection_entry=
 **ce =3D
-            gc_realloc(l->array, capacity * sizeof(struct connec=
tion_entry *), &options->gc);
-        if (ce =3D=3D NULL)
-        {
-    =
        msg(msglevel,
-                "Unable to process more connection o=
ptions: out of memory=2E Number of entries =3D %d",
-                l->len=
);
-            return NULL;
-        }
-        l->array =3D ce;
+        =
l->array =3D gc_realloc(l->array, capacity * sizeof(struct connection_entry=
 *), &options->gc);
         l->capacity =3D capacity;
     }
     ALLOC_OB=
J_GC(e, struct connection_entry, &options->gc);
@@ -1454,7 +1436,7 @@
 }
 
=
 static struct remote_entry *
-alloc_remote_entry(struct options *options, =
const msglvl_t msglevel)
+alloc_remote_entry(struct options *options)
 {
  =
   struct remote_list *l =3D alloc_remote_list_if_undef(options);
     stru=
ct remote_entry *e;
@@ -1462,16 +1444,7 @@
     if (l->len =3D=3D l->capaci=
ty)
     {
         int capacity =3D l->capacity + CONNECTION_LIST_SIZE;
- =
       struct remote_entry **re =3D
-            gc_realloc(l->array, capac=
ity * sizeof(struct remote_entry *), &options->gc);
-        if (re =3D=3D =
NULL)
-        {
-            msg(msglevel,
-                "Unable to pro=
cess more remote options: out of memory=2E Number of entries =3D %d",
-    =
            l->len);
-            return NULL;
-        }
-        l->array=
 =3D re;
+        l->array =3D gc_realloc(l->array, capacity * sizeof(struc=
t remote_entry *), &options->gc);
         l->capacity =3D capacity;
     }=

     ALLOC_OBJ_GC(e, struct remote_entry, &options->gc);
@@ -3073,16 +3046=
,14 @@
 
             ASSERT(re->remote);
             connection_entry_loa=
d_re(&ce, re);
-            ace =3D alloc_connection_entry(o, M_USAGE);
-  =
          ASSERT(ace);
+            ace =3D alloc_connection_entry(o);
    =
         *ace =3D ce;
         }
     }
     else if (!o->remote_list && !o=
->connection_list)
     {
         struct connection_entry *ace;
-        a=
ce =3D alloc_connection_entry(o, M_USAGE);
-        ASSERT(ace);
+        a=
ce =3D alloc_connection_entry(o);
         *ace =3D o->ce;
     }
 
@@ -311=
5,8 +3086,7 @@
     {
         /* if no 'local' directive was specified, co=
nvert the global port
          * setting to a listen entry */
-        str=
uct local_entry *e =3D alloc_local_entry(&o->ce, M_USAGE, &o->gc);
-       =
 ASSERT(e);
+        struct local_entry *e =3D alloc_local_entry(&o->ce, &o=
->gc);
         e->port =3D o->ce=2Elocal_port;
         e->proto =3D o->ce=
=2Eproto;
     }
@@ -4490,8 +4460,7 @@
 
         VERIFY_PERMISSION(OPT_P_G=
ENERAL | OPT_P_CONNECTION);
 
-        e =3D alloc_local_entry(&options->ce=
, M_USAGE, &options->gc);
-        ASSERT(e);
+        e =3D alloc_local_en=
try(&options->ce, &options->gc);
 
         /* '*' is treated as 'ask the s=
ystem to get some socket',
          * therefore force binding on a particu=
lar address only when
@@ -4536,12 +4505,7 @@
                 goto err;
   =
          }
 
-            e =3D alloc_connection_entry(options, msglevel);=

-            if (!e)
-            {
-                uninit_options(&sub);=

-                goto err;
-            }
+            e =3D alloc_connect=
ion_entry(options);
             *e =3D sub=2Ece;
             gc_transfer(=
&options->gc, &sub=2Egc);
             uninit_options(&sub);
@@ -4630,11 +4=
594,7 @@
         }
         if (permission_mask & OPT_P_GENERAL)
         =
{
-            struct remote_entry *e =3D alloc_remote_entry(options, msgle=
vel);
-            if (!e)
-            {
-                goto err;
-     =
       }
+            struct remote_entry *e =3D alloc_remote_entry(options=
);
             *e =3D re;
         }
         else if (permission_mask & O=
PT_P_CONNECTION)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2196?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3
Gerrit-Change-Number: 2196
Gerrit=
-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>

--U9M+jNOHpD4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">options: drop impossible out-of-memory branches<br><br>=
gc_realloc() aborts via check_malloc_return() and never returns NULL=2E<br>=
Remove the NULL handling from alloc_{local,connection,remote}_entry(),<br>t=
heir now unused msglevel parameter, and the callers&#39; checks=2E<br><br>C=
hange-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3<br>Signed-off-by: Razva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/options=2E=
c<br>1 file changed, 12 insertions(+), 52 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/96/=
2196/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec</span><br><span>index 1d8bb2a=2E=2E67c91ab 100644</span><br><span>--- =
a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</sp=
an><br><span>@@ -1377,7 +1377,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> static struct local_entry *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-alloc_local_entry(struct connection_entry *ce, const ms=
glvl_t msglevel, struct gc_arena *gc)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+alloc_local_entry(struct connection_entry *ce, struct gc_=
arena *gc)</span><br><span> {</span><br><span>     struct local_list *l =3D=
 alloc_local_list_if_undef(ce, gc);</span><br><span>     struct local_entry=
 *e;</span><br><span>@@ -1387,16 +1387,7 @@</span><br><span>         const =
int new_cap =3D l-&gt;capacity + 1;</span><br><span>         const size_t e=
lem_size =3D sizeof(*l-&gt;array);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        struct local_entry **new_array =3D =
gc_realloc(l-&gt;array, new_cap * elem_size, gc);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (!new_array)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(msglevel,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                &quot;Unable to process more local =
options: out of memory=2E Number of entries =3D %d&quot;,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                l-&gt;len);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            return NULL;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        l-&gt;array =3D new_array;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        l-&gt;array =3D gc_realloc(l-&gt;array, =
new_cap * elem_size, gc);</span><br><span>         l-&gt;capacity =3D new_c=
ap;</span><br><span>     }</span><br><span> </span><br><span>@@ -1418,7 +14=
09,7 @@</span><br><span> }</span><br><span> </span><br><span> static struct=
 connection_entry *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-al=
loc_connection_entry(struct options *options, const msglvl_t msglevel)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+alloc_connection_entry(s=
truct options *options)</span><br><span> {</span><br><span>     struct conn=
ection_list *l =3D alloc_connection_list_if_undef(options);</span><br><span=
>     struct connection_entry *e;</span><br><span>@@ -1426,16 +1417,7 @@</s=
pan><br><span>     if (l-&gt;len =3D=3D l-&gt;capacity)</span><br><span>   =
  {</span><br><span>         int capacity =3D l-&gt;capacity + CONNECTION_L=
IST_SIZE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        stru=
ct connection_entry **ce =3D</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            gc_realloc(l-&gt;array, capacity * sizeof(struct connect=
ion_entry *), &amp;options-&gt;gc);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (ce =3D=3D NULL)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            msg(msglevel,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                &quot;Unable to process more connection options=
: out of memory=2E Number of entries =3D %d&quot;,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                l-&gt;len);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            return NULL;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        l-&gt;array =3D ce;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        l-&gt;array =3D gc_realloc(l-&gt;=
array, capacity * sizeof(struct connection_entry *), &amp;options-&gt;gc);<=
/span><br><span>         l-&gt;capacity =3D capacity;</span><br><span>     =
}</span><br><span>     ALLOC_OBJ_GC(e, struct connection_entry, &amp;option=
s-&gt;gc);</span><br><span>@@ -1454,7 +1436,7 @@</span><br><span> }</span><=
br><span> </span><br><span> static struct remote_entry *</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-alloc_remote_entry(struct options *optio=
ns, const msglvl_t msglevel)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+alloc_remote_entry(struct options *options)</span><br><span> {</sp=
an><br><span>     struct remote_list *l =3D alloc_remote_list_if_undef(opti=
ons);</span><br><span>     struct remote_entry *e;</span><br><span>@@ -1462=
,16 +1444,7 @@</span><br><span>     if (l-&gt;len =3D=3D l-&gt;capacity)</s=
pan><br><span>     {</span><br><span>         int capacity =3D l-&gt;capaci=
ty + CONNECTION_LIST_SIZE;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        struct remote_entry **re =3D</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            gc_realloc(l-&gt;array, capacity * sizeof(s=
truct remote_entry *), &amp;options-&gt;gc);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (re =3D=3D NULL)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            msg(msglevel,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                &quot;Unable to process more remote op=
tions: out of memory=2E Number of entries =3D %d&quot;,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                l-&gt;len);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            return NULL;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        l-&gt;array =3D re;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        l-&gt;array =3D gc_realloc(=
l-&gt;array, capacity * sizeof(struct remote_entry *), &amp;options-&gt;gc)=
;</span><br><span>         l-&gt;capacity =3D capacity;</span><br><span>   =
  }</span><br><span>     ALLOC_OBJ_GC(e, struct remote_entry, &amp;options-=
&gt;gc);</span><br><span>@@ -3073,16 +3046,14 @@</span><br><span> </span><b=
r><span>             ASSERT(re-&gt;remote);</span><br><span>             co=
nnection_entry_load_re(&amp;ce, re);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            ace =3D alloc_connection_entry(o, M_USAGE);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(ace);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ace =3D a=
lloc_connection_entry(o);</span><br><span>             *ace =3D ce;</span><=
br><span>         }</span><br><span>     }</span><br><span>     else if (!o=
-&gt;remote_list &amp;&amp; !o-&gt;connection_list)</span><br><span>     {<=
/span><br><span>         struct connection_entry *ace;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        ace =3D alloc_connection_entry(o, =
M_USAGE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSE=
RT(ace);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ace=
 =3D alloc_connection_entry(o);</span><br><span>         *ace =3D o-&gt;ce;=
</span><br><span>     }</span><br><span> </span><br><span>@@ -3115,8 +3086,=
7 @@</span><br><span>     {</span><br><span>         /* if no &#39;local&#3=
9; directive was specified, convert the global port</span><br><span>       =
   * setting to a listen entry */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        struct local_entry *e =3D alloc_local_entry(&amp;o-&gt;=
ce, M_USAGE, &amp;o-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        ASSERT(e);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct local_entry *e =3D alloc_local_entry(&amp;o-&gt;ce, &a=
mp;o-&gt;gc);</span><br><span>         e-&gt;port =3D o-&gt;ce=2Elocal_port=
;</span><br><span>         e-&gt;proto =3D o-&gt;ce=2Eproto;</span><br><spa=
n>     }</span><br><span>@@ -4490,8 +4460,7 @@</span><br><span> </span><br>=
<span>         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        e =
=3D alloc_local_entry(&amp;options-&gt;ce, M_USAGE, &amp;options-&gt;gc);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(e);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        e =3D alloc_loca=
l_entry(&amp;options-&gt;ce, &amp;options-&gt;gc);</span><br><span> </span>=
<br><span>         /* &#39;*&#39; is treated as &#39;ask the system to get =
some socket&#39;,</span><br><span>          * therefore force binding on a =
particular address only when</span><br><span>@@ -4536,12 +4505,7 @@</span><=
br><span>                 goto err;</span><br><span>             }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
e =3D alloc_connection_entry(options, msglevel);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            if (!e)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                uninit_options(&amp;sub);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                goto err;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            e =3D alloc_connection_entry=
(options);</span><br><span>             *e =3D sub=2Ece;</span><br><span>  =
           gc_transfer(&amp;options-&gt;gc, &amp;sub=2Egc);</span><br><span=
>             uninit_options(&amp;sub);</span><br><span>@@ -4630,11 +4594,7=
 @@</span><br><span>         }</span><br><span>         if (permission_mask=
 &amp; OPT_P_GENERAL)</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            struct remote_entry *e =3D alloc_rem=
ote_entry(options, msglevel);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            if (!e)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              goto err;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        struct remote_entry *e =3D alloc_remote_entry(options);</span><br><=
span>             *e =3D re;</span><br><span>         }</span><br><span>   =
      else if (permission_mask &amp; OPT_P_CONNECTION)</span><br></pre><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?us=
p=3Demail">change 2196</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2196?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2196 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--U9M+jNOHpD4=--


--===============2726526901823814427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2726526901823814427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2726526901823814427==--

