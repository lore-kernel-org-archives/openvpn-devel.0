Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491F2606A329
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=T3RcmLMM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=G99BebB8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DBXd4qjX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=T2olL2Uv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=H0/wQPVkerXVyYHDUBxQSuf8VXVnt80SL71wuG0QlUk=; b=T3RcmLMMAKtncGZI+pQTCxKpbA
	78cSxmviSROoTR/Qnl0vFoBAaoSkJBKkE99GEjOznGZ0mionUjrsEbKu3MCr/L3X9vTsMXsq9Kzj8
	WfntZXgEEa426LhZy+1cacn11cpoKFxVyB/uiajl74A9lKNwoGpoYcVE27CtJCx4/DYc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSwiC-000000002L5-2VuU;
	Mon, 16 Nov 2026 13:25:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSwiB-000000002Kx-1kBK
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 13:25:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t9JGgH/JXUa/daTztdBB7OLQNn1bQtYngYD+oUGpoGw=; b=G99BebB8Em4yFlxs0LD8QVYcQ8
 jmo3tQ4ERIPSekcaFkoSKIJZnZPVtO2pcvPfHxpFX3GtVg2fBC5TPRZaglxT5dt6wge1WQVYASIRJ
 TmbKcFhRyzVyIK4ADqPsGWPbJdKdKSMxmmCTxAmKZPnwue0Dm7Dy1Kk8Ng8cp7Reqixs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t9JGgH/JXUa/daTztdBB7OLQNn1bQtYngYD+oUGpoGw=; b=DBXd4qjX+dpMs+8bZrbSe/GVHN
 xmqTt6tM60J05wLJXFqOfFt8iYpPdec1iMYGF48UiefiYXfA8V/Y8DRZWsT2KUJdQQuqrU93ewlfV
 NMA9nQAxCb1+dPywJboahIx4Fp7TXeRl1UUuLFKKgvGayPwRmIC91uFvKHx6Wx+0m00E=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSwi9-000000007IK-2RP0 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 13:25:31 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so1710497f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 05:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794835523; x=1795440323; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t9JGgH/JXUa/daTztdBB7OLQNn1bQtYngYD+oUGpoGw=;
 b=T2olL2Uvbg9ZjZnHPC5nBOQuQlmAlYmyJtDEAkp56F/ywa46+NFnsmcVkQty19Q0gl
 n8YxNkHSgqIdXR9L0B0aqSQl0lSMExX1RRwvdLof24pbvjJGn+lqtk/74gMdYFpDrqvc
 Y3llDG+zxeQ9QESlCUTq89QsGaPMk1A06AhglGtM13VVnE/mUz0si5q8GCXr096+DW0L
 ENfXwYH5E1CxkWL4YFODmwZFyC9z1u6zRb0J/14NH3htUBDmGW79Zthk4VNWgnQuxDp/
 7uKCCdUFZQWE0COVIT155VlJ1yE2TDuzjsotNjdrwJAO78J/ng/+I0VfhzF/MTMHkEDg
 OjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835523; x=1795440323;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=t9JGgH/JXUa/daTztdBB7OLQNn1bQtYngYD+oUGpoGw=;
 b=U2uHxFoJpVdUbufNL99vZ36z7UgWSY5bUG5z+re98ApDUD2J1HyCzOraubxHVtUeqz
 Qsohh8mYNK/T8cmf0d4Vg3Tf3rQ0BqYlNy8Fia9RLZFv8Ndtnvfwrfe2al+yiv/Q5Kle
 aDn8DK8pGuNUOtM+ZEE8ROt24L31L975W1v8S9f/gCd6mDOA/HzEynboEwnJg/Ur1iN5
 ASLp0D2YH+VE+pj+RoVqoSaHbuKeXQAJ52oZQ8Nek/iHgmxaLzEDroG5OweboxG3tXpY
 B8W0GMknf5VHgpo/HKJeROZeslHqCHyTxxA7jPNptHf75A7XMN8pETDKD3x8P+T2L9jI
 TVcg==
X-Gm-Message-State: APuU4Z8npqU0xKgncqg3XOrSyAkyJyVrJ1O1VvbIlMpsHRYKrxqnJo/p
 aBfySVOphcMZjS23dXkbBCqGM/YzNf5HK8nIPnVmzZj32jc8tMxZfruW/1yEH4EB2EBBzUvns2r
 HY7JH/aHz1Vj3qM/g/1e558B/oAwJZtluqJ3yRvP+dBDLuFh25bJN817tHkum37o5juXuEIeONL
 ZRt5jQSA==
X-Gm-Gg: AZFdTZdFdZtS8LOOMqX95gsTydAJBMNs5QYfj93poKDcda6j38KVlHpSQl10xXulCwI
 1rdA1p8ra3xGg5AuI+Rx/JSqO5kptlL+/5c09Cr1+s2/kexXubHQeaDLt0cYEQieNM3P35MJ/xk
 98Q4Mc80agQnLhvhyr7m+rq9YqBRGnbXzfk783FzlZBs8amSQ5kdVMpomda/wwZOJh8dAuKibh1
 kkwk7w/WsxWp2QWhAkd8m0eSun5KLEUQ35+aO6m1EaHSCCeiE6q/I9mhnoEpkGuA4MH8VeIWWV8
 v37UInM8oGkZFg/+XDR2VTNyEDtBI4ZSQGmCOMmZSWdBT/nmqQSO6J7b/0WnIWO1lICm6aj9Bck
 BqIaJs3L4+xSaJROoTrxQOuaYgstM3pNmLyolEjhJhxnRVKhDP0IsCfT6NRIitJTYZe0nETi6WS
 KLzQ2vvWtfUAZQOYJNWFi0UwMJd2x5+27AIF1TKwsaQYS92J5qCX5ngn8fFUH7ZitnUafvZvDuw
 ydRnbYXaKLbS3sdz1wyoOoMqv7z2eb5ZFar7TDzGAgTap18fiIW8/BuypswTTTSSCKKswhDK91p
 M2OrUp5fftAO1yO70pslAOuyRnshFReuGK0He+BtU3v2+lTpm6w8nCyQuIV1WN7RBoNaCRwnvcc
 HdkSWKF7q2uY2hFwvisYoSWe1rHI+Y+2rBu61Q4oWxxXdjRtXueBzH1o1ibK1qts8n1r8eioPU8
 oepiOTqn+zCpIsSZI=
X-Received: by 2002:a05:6000:610:b0:495:5c83:51b9 with SMTP id
 ffacd0b85a97d-49c7467a893mr24540680f8f.50.1794835522761; 
 Mon, 16 Nov 2026 05:25:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5fe370f8sm19976167f8f.27.2026.11.16.05.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:25:22 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 13:25:20 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3
X-Gerrit-Change-Number: 2196
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2196?usp=email>
X-Gerrit-Commit: 503782249ebd92a569c151d8e36a1b31813d3ceb
In-Reply-To: <gerrit.1794834650000.Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3@gerrit.openvpn.net>
References: <gerrit.1794834650000.Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM0NjUwMDAwLkllYzg1ZDUzY2UxMDc2NjM5YmQ2Y2VhZjNiYTdkNTNjYzllNzlkN2EzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <97415f4a0546dc9d4e000bda6892792f66dfe5a2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSwi9-000000007IK-2RP0
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
Content-Type: multipart/mixed; boundary="===============4531076817962196351=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4531076817962196351==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ibStR15O49A="; charset=UTF-8

--ibStR15O49A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2196?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: options: drop impossible out-of-memory branches
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: drop im=
possible out-of-memory branches

gc_realloc() aborts via check_malloc_retur=
n() and never returns NULL=2E
Remove the NULL handling from alloc_{local,co=
nnection,remote}_entry(),
their now unused msglevel parameter, and the call=
ers' checks=2E

Change-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3
Signed=
-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/options=
=2Ec
1 file changed, 12 insertions(+), 57 deletions(-)


  git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/96/2196/2

diff --git a/sr=
c/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 1d8bb2a=2E=2Ede6efdf =
100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1377=
,7 +1377,7 @@
 }
 
 static struct local_entry *
-alloc_local_entry(struct c=
onnection_entry *ce, const msglvl_t msglevel, struct gc_arena *gc)
+alloc_l=
ocal_entry(struct connection_entry *ce, struct gc_arena *gc)
 {
     struct=
 local_list *l =3D alloc_local_list_if_undef(ce, gc);
     struct local_ent=
ry *e;
@@ -1387,16 +1387,7 @@
         const int new_cap =3D l->capacity + =
1;
         const size_t elem_size =3D sizeof(*l->array);
 
-        struct=
 local_entry **new_array =3D gc_realloc(l->array, new_cap * elem_size, gc);=

-        if (!new_array)
-        {
-            msg(msglevel,
-          =
      "Unable to process more local options: out of memory=2E Number of ent=
ries =3D %d",
-                l->len);
-            return NULL;
-        =
}
-
-        l->array =3D new_array;
+        l->array =3D gc_realloc(l->ar=
ray, new_cap * elem_size, gc);
         l->capacity =3D new_cap;
     }
 
@=
@ -1418,7 +1409,7 @@
 }
 
 static struct connection_entry *
-alloc_connecti=
on_entry(struct options *options, const msglvl_t msglevel)
+alloc_connectio=
n_entry(struct options *options)
 {
     struct connection_list *l =3D allo=
c_connection_list_if_undef(options);
     struct connection_entry *e;
@@ -1=
426,16 +1417,7 @@
     if (l->len =3D=3D l->capacity)
     {
         int c=
apacity =3D l->capacity + CONNECTION_LIST_SIZE;
-        struct connection_=
entry **ce =3D
-            gc_realloc(l->array, capacity * sizeof(struct c=
onnection_entry *), &options->gc);
-        if (ce =3D=3D NULL)
-        {
=
-            msg(msglevel,
-                "Unable to process more connect=
ion options: out of memory=2E Number of entries =3D %d",
-                l=
->len);
-            return NULL;
-        }
-        l->array =3D ce;
+   =
     l->array =3D gc_realloc(l->array, capacity * sizeof(struct connection_=
entry *), &options->gc);
         l->capacity =3D capacity;
     }
     ALL=
OC_OBJ_GC(e, struct connection_entry, &options->gc);
@@ -1454,7 +1436,7 @@
=
 }
 
 static struct remote_entry *
-alloc_remote_entry(struct options *opti=
ons, const msglvl_t msglevel)
+alloc_remote_entry(struct options *options)
=
 {
     struct remote_list *l =3D alloc_remote_list_if_undef(options);
    =
 struct remote_entry *e;
@@ -1462,16 +1444,7 @@
     if (l->len =3D=3D l->c=
apacity)
     {
         int capacity =3D l->capacity + CONNECTION_LIST_SIZ=
E;
-        struct remote_entry **re =3D
-            gc_realloc(l->array, =
capacity * sizeof(struct remote_entry *), &options->gc);
-        if (re =
=3D=3D NULL)
-        {
-            msg(msglevel,
-                "Unable=
 to process more remote options: out of memory=2E Number of entries =3D %d"=
,
-                l->len);
-            return NULL;
-        }
-        l=
->array =3D re;
+        l->array =3D gc_realloc(l->array, capacity * sizeo=
f(struct remote_entry *), &options->gc);
         l->capacity =3D capacity;=

     }
     ALLOC_OBJ_GC(e, struct remote_entry, &options->gc);
@@ -3069,2=
0 +3042,16 @@
         {
             const struct remote_entry *re =3D rl-=
>array[i];
             struct connection_entry ce =3D o->ce;
-            =
struct connection_entry *ace;
 
             ASSERT(re->remote);
          =
   connection_entry_load_re(&ce, re);
-            ace =3D alloc_connection=
_entry(o, M_USAGE);
-            ASSERT(ace);
+            struct connectio=
n_entry *ace =3D alloc_connection_entry(o);
             *ace =3D ce;
     =
    }
     }
     else if (!o->remote_list && !o->connection_list)
     {
-=
        struct connection_entry *ace;
-        ace =3D alloc_connection_ent=
ry(o, M_USAGE);
-        ASSERT(ace);
+        struct connection_entry *ace=
 =3D alloc_connection_entry(o);
         *ace =3D o->ce;
     }
 
@@ -3115,=
8 +3084,7 @@
     {
         /* if no 'local' directive was specified, conv=
ert the global port
          * setting to a listen entry */
-        struc=
t local_entry *e =3D alloc_local_entry(&o->ce, M_USAGE, &o->gc);
-        A=
SSERT(e);
+        struct local_entry *e =3D alloc_local_entry(&o->ce, &o->=
gc);
         e->port =3D o->ce=2Elocal_port;
         e->proto =3D o->ce=
=2Eproto;
     }
@@ -4486,12 +4454,9 @@
     }
     else if (streq(p[0], "l=
ocal") && p[1] && !p[4])
     {
-        struct local_entry *e;
-
         =
VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
 
-        e =3D alloc=
_local_entry(&options->ce, M_USAGE, &options->gc);
-        ASSERT(e);
+   =
     struct local_entry *e =3D alloc_local_entry(&options->ce, &options->gc=
);
 
         /* '*' is treated as 'ask the system to get some socket',
   =
       * therefore force binding on a particular address only when
@@ -4522=
,7 +4487,6 @@
         if (is_inline)
         {
             struct option=
s sub;
-            struct connection_entry *e;
 
             init_options=
(&sub);
             sub=2Ece =3D options->ce;
@@ -4536,12 +4500,7 @@
     =
            goto err;
             }
 
-            e =3D alloc_connection_=
entry(options, msglevel);
-            if (!e)
-            {
-            =
    uninit_options(&sub);
-                goto err;
-            }
+      =
      struct connection_entry *e =3D alloc_connection_entry(options);
     =
        *e =3D sub=2Ece;
             gc_transfer(&options->gc, &sub=2Egc);=

             uninit_options(&sub);
@@ -4630,11 +4589,7 @@
         }
     =
    if (permission_mask & OPT_P_GENERAL)
         {
-            struct rem=
ote_entry *e =3D alloc_remote_entry(options, msglevel);
-            if (!e=
)
-            {
-                goto err;
-            }
+            str=
uct remote_entry *e =3D alloc_remote_entry(options);
             *e =3D re=
;
         }
         else if (permission_mask & OPT_P_CONNECTION)

-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iec85d53ce1076639bd6cea=
f3ba7d53cc9e79d7a3
Gerrit-Change-Number: 2196
Gerrit-PatchSet: 2
Gerrit-Own=
er: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--ibStR15O49A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru <strong>=
uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">options: drop impossible out-of-memory branches<br><br>gc_realloc=
() aborts via check_malloc_return() and never returns NULL=2E<br>Remove the=
 NULL handling from alloc_{local,connection,remote}_entry(),<br>their now u=
nused msglevel parameter, and the callers&#39; checks=2E<br><br>Change-Id: =
Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3<br>Signed-off-by: Razvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/options=2Ec<br>1 fil=
e changed, 12 insertions(+), 57 deletions(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/96/2196/2</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><=
br><span>index 1d8bb2a=2E=2Ede6efdf 100644</span><br><span>--- a/src/openvp=
n/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span=
>@@ -1377,7 +1377,7 @@</span><br><span> }</span><br><span> </span><br><span=
> static struct local_entry *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-alloc_local_entry(struct connection_entry *ce, const msglvl_t msgle=
vel, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+alloc_local_entry(struct connection_entry *ce, struct gc_arena *gc)</=
span><br><span> {</span><br><span>     struct local_list *l =3D alloc_local=
_list_if_undef(ce, gc);</span><br><span>     struct local_entry *e;</span><=
br><span>@@ -1387,16 +1387,7 @@</span><br><span>         const int new_cap =
=3D l-&gt;capacity + 1;</span><br><span>         const size_t elem_size =3D=
 sizeof(*l-&gt;array);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        struct local_entry **new_array =3D gc_realloc(l-=
&gt;array, new_cap * elem_size, gc);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (!new_array)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            msg(msglevel,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                &quot;Unable to process more local options: out of=
 memory=2E Number of entries =3D %d&quot;,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                l-&gt;len);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            return NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       l-&gt;array =3D new_array;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        l-&gt;array =3D gc_realloc(l-&gt;array, new_cap * ele=
m_size, gc);</span><br><span>         l-&gt;capacity =3D new_cap;</span><br=
><span>     }</span><br><span> </span><br><span>@@ -1418,7 +1409,7 @@</span=
><br><span> }</span><br><span> </span><br><span> static struct connection_e=
ntry *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-alloc_connectio=
n_entry(struct options *options, const msglvl_t msglevel)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+alloc_connection_entry(struct options=
 *options)</span><br><span> {</span><br><span>     struct connection_list *=
l =3D alloc_connection_list_if_undef(options);</span><br><span>     struct =
connection_entry *e;</span><br><span>@@ -1426,16 +1417,7 @@</span><br><span=
>     if (l-&gt;len =3D=3D l-&gt;capacity)</span><br><span>     {</span><br=
><span>         int capacity =3D l-&gt;capacity + CONNECTION_LIST_SIZE;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct connection=
_entry **ce =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      gc_realloc(l-&gt;array, capacity * sizeof(struct connection_entry *),=
 &amp;options-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (ce =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       msg(msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               &quot;Unable to process more connection options: out of memo=
ry=2E Number of entries =3D %d&quot;,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                l-&gt;len);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            return NULL;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        l-&gt;array =3D ce;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        l-&gt;array =3D gc_realloc(l-&gt;array, capaci=
ty * sizeof(struct connection_entry *), &amp;options-&gt;gc);</span><br><sp=
an>         l-&gt;capacity =3D capacity;</span><br><span>     }</span><br><=
span>     ALLOC_OBJ_GC(e, struct connection_entry, &amp;options-&gt;gc);</s=
pan><br><span>@@ -1454,7 +1436,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> static struct remote_entry *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-alloc_remote_entry(struct options *options, const msg=
lvl_t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+allo=
c_remote_entry(struct options *options)</span><br><span> {</span><br><span>=
     struct remote_list *l =3D alloc_remote_list_if_undef(options);</span><=
br><span>     struct remote_entry *e;</span><br><span>@@ -1462,16 +1444,7 @=
@</span><br><span>     if (l-&gt;len =3D=3D l-&gt;capacity)</span><br><span=
>     {</span><br><span>         int capacity =3D l-&gt;capacity + CONNECTI=
ON_LIST_SIZE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
struct remote_entry **re =3D</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            gc_realloc(l-&gt;array, capacity * sizeof(struct remote_=
entry *), &amp;options-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (re =3D=3D NULL)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            msg(msglevel,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                &quot;Unable to process more remote options: out of=
 memory=2E Number of entries =3D %d&quot;,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                l-&gt;len);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            return NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        l-&gt;array =3D re;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        l-&gt;array =3D gc_realloc(l-&gt;array,=
 capacity * sizeof(struct remote_entry *), &amp;options-&gt;gc);</span><br>=
<span>         l-&gt;capacity =3D capacity;</span><br><span>     }</span><b=
r><span>     ALLOC_OBJ_GC(e, struct remote_entry, &amp;options-&gt;gc);</sp=
an><br><span>@@ -3069,20 +3042,16 @@</span><br><span>         {</span><br><=
span>             const struct remote_entry *re =3D rl-&gt;array[i];</span>=
<br><span>             struct connection_entry ce =3D o-&gt;ce;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            struct connection_ent=
ry *ace;</span><br><span> </span><br><span>             ASSERT(re-&gt;remot=
e);</span><br><span>             connection_entry_load_re(&amp;ce, re);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            ace =3D alloc=
_connection_entry(o, M_USAGE);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            ASSERT(ace);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            struct connection_entry *ace =3D alloc_connection=
_entry(o);</span><br><span>             *ace =3D ce;</span><br><span>      =
   }</span><br><span>     }</span><br><span>     else if (!o-&gt;remote_lis=
t &amp;&amp; !o-&gt;connection_list)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        struct connection_entry *ace;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ace =3D alloc=
_connection_entry(o, M_USAGE);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        ASSERT(ace);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct connection_entry *ace =3D alloc_connection_entry(o=
);</span><br><span>         *ace =3D o-&gt;ce;</span><br><span>     }</span=
><br><span> </span><br><span>@@ -3115,8 +3084,7 @@</span><br><span>     {</=
span><br><span>         /* if no &#39;local&#39; directive was specified, c=
onvert the global port</span><br><span>          * setting to a listen entr=
y */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct lo=
cal_entry *e =3D alloc_local_entry(&amp;o-&gt;ce, M_USAGE, &amp;o-&gt;gc);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(e);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct local_en=
try *e =3D alloc_local_entry(&amp;o-&gt;ce, &amp;o-&gt;gc);</span><br><span=
>         e-&gt;port =3D o-&gt;ce=2Elocal_port;</span><br><span>         e-=
&gt;proto =3D o-&gt;ce=2Eproto;</span><br><span>     }</span><br><span>@@ -=
4486,12 +4454,9 @@</span><br><span>     }</span><br><span>     else if (str=
eq(p[0], &quot;local&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        stru=
ct local_entry *e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     e =3D alloc_local_entry(&amp;options-&gt;ce, M_USAGE, &amp;options-&gt=
;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(e=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct lo=
cal_entry *e =3D alloc_local_entry(&amp;options-&gt;ce, &amp;options-&gt;gc=
);</span><br><span> </span><br><span>         /* &#39;*&#39; is treated as =
&#39;ask the system to get some socket&#39;,</span><br><span>          * th=
erefore force binding on a particular address only when</span><br><span>@@ =
-4522,7 +4487,6 @@</span><br><span>         if (is_inline)</span><br><span>=
         {</span><br><span>             struct options sub;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            struct connection_entry *=
e;</span><br><span> </span><br><span>             init_options(&amp;sub);</=
span><br><span>             sub=2Ece =3D options-&gt;ce;</span><br><span>@@=
 -4536,12 +4500,7 @@</span><br><span>                 goto err;</span><br><=
span>             }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            e =3D alloc_connection_entry(options, msglevel)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!e)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                uninit_options=
(&amp;sub);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      goto err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
struct connection_entry *e =3D alloc_connection_entry(options);</span><br><=
span>             *e =3D sub=2Ece;</span><br><span>             gc_transfer=
(&amp;options-&gt;gc, &amp;sub=2Egc);</span><br><span>             uninit_o=
ptions(&amp;sub);</span><br><span>@@ -4630,11 +4589,7 @@</span><br><span>  =
       }</span><br><span>         if (permission_mask &amp; OPT_P_GENERAL)<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            struct remote_entry *e =3D alloc_remote_entry(options, msg=
level);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if=
 (!e)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                goto err=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            struct remote_=
entry *e =3D alloc_remote_entry(options);</span><br><span>             *e =
=3D re;</span><br><span>         }</span><br><span>         else if (permis=
sion_mask &amp; OPT_P_CONNECTION)</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Demail">change 219=
6</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2196 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>

</body></html>
--ibStR15O49A=--


--===============4531076817962196351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4531076817962196351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4531076817962196351==--

