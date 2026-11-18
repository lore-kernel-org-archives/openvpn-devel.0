Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1CF606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FMO5IsBk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KTsIqAcF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bSnnU5Kp;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Y8jYZkSD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/MX1jfj3vDJ/tE2/70y5jnNK+FmabzFEd+ObONmGXhs=; b=FMO5IsBkAA0GzIT5AEVfJ3WdjE
	rUFrbj6yXZWXwQiQlYnORbaif9Ja9H/kNIJ6rlyuoHS+Mq9AZAbFZoJw9FwEgLK5d9K1j1f2tAPuY
	ZuCd9p/0wf34ekwYmFVy5UrkUi5GeBcsdoheg2sfbjd4OaseDF9z1zMnrJNNkdfSBhKQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTj8D-0000000036m-1oQ1;
	Wed, 18 Nov 2026 17:07:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTj7i-0000000036G-0aMm
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:07:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qNkckLUZzC79MxK7pLFzaNbEw3OV6NfYLQYQl6gVaDY=; b=KTsIqAcFi9BbBrc6pWXln34Jdi
 gHbXTpttAeCNcKjxXQrH0Jep/WCd12xcAQP2hgW3qE8bTP9vnLCD9hlzlzNcoiKBXbvxxWP9ADzqa
 PUIzPXYoVJjdUcS7wI96WuRkJIkEjqIaPqp/jloC5XjQXFNKPSkPPrI7CGNUJ2375/zY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qNkckLUZzC79MxK7pLFzaNbEw3OV6NfYLQYQl6gVaDY=; b=bSnnU5KpZBdwDNNT5IDP2Ik8cX
 TG6JazQFgY87jr7Ulp/0LDs7rVuSBfSKhM2AeEVUC5azj/0pa01aJF8ZIecv+2BsUsc/oV9i2mKov
 YBdBguIty8dImcVPpJhT/7hUylw5doTbaLs/1nBceeEZDjeG7Fg3xQIYFFVo/cWS2QfQ=;
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTj7e-000000006rK-1H1z for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:07:06 +0000
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c50d3ac6b51so2443266b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 09:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795021615; x=1795626415; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qNkckLUZzC79MxK7pLFzaNbEw3OV6NfYLQYQl6gVaDY=;
 b=Y8jYZkSDbUkn5JKUjEAs2DZu7WhP3W48kFOeeZ95g3hCvhSWOf8MUcrhuCk3FVBNuo
 4FvkwYdQ+ggeM3aVQ1iV+JhFRaQ3yXNTcppsXbn9naHzG5wNGupYOtAV97DV75tk6ul7
 GglIP1U90Z76WrD6BXlqye5++13DVAHDcMgRYSawbOebMerYwHRhOKm+ZDYwrCr3AmZ3
 XGSUsGAbfI0bT4J7BdFnB3ggA/ByD3NB7HgDsSiroHevHz8aufdxlwI4SvJeGrGYmOaR
 ppOHOmaa+FIEGAVCr3/XeXT/P6eLAPm8okCH52eNT3koe/BAfY146IhVnjoWT5XFJugy
 bLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795021615; x=1795626415;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qNkckLUZzC79MxK7pLFzaNbEw3OV6NfYLQYQl6gVaDY=;
 b=FtxdaROSV5maVrnmHYSAVC4gX1xpzVuOw2WqMbP9WGOVV+odTiEfoj1e0UE9j0zhka
 x6lwOrTfNbvfdQ282FBDa2z1FPCKjShnJXjnqYvryuW1fVmp5soIgu+Fug8QTHdei1lL
 nVXUXT4RNmjOEXuGG2F7UyYHkyRcgQoRw9d10cyILZd+Xph2nIj+Ske4yLyk0y3kolML
 DqjVScyTomJ476NErY9E8LZvb++uI2r9Qt0sRNW9IdsjBOqTmFtpUES64RGuMD/OMw3W
 Qr480rs1rYjGHnV8/KWywK1s/+dhj+cBiqVhNyLbOlqQgdeYB9dhFVWttnNF/8WNNxJf
 Hcjg==
X-Forwarded-Encrypted: i=1;
 AL+hErEMnCzuyOxbi3VjqYIWSQ4ZBnIVDHmG/0jVG2ar+jGzcgzLqVYz3KkhimHsNOx3DvCqR+Cl429ZSq+ninwI@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9DVvC5/jmf+EIWb9T5X1EDNPlNJB2gSkW+7Nx0TpD7mwQqk+JP
 XspkPklcxmfVAKwBQd3Iac6Gy8LzYHIdVx5YFh/VFB/JqbkUlJyjYvG1rGhLu1Sr03Oo6pWoWNt
 tEYJdL6MqcvocuxXfDZssZwGyYzbg3xNUiw3quj7luldZlAhFogR3Zs+XDdUX9+qSdC0p
X-Gm-Gg: AYBFou3sqkHEEoPZTcPKlfOfQlEugvm09UmJUG+l/gVW7L45oNl0lDKLJ78VrQ9aeTH
 BklpBiittWWxx/fD+BYhCabB+t8eIzeNY0zJzBtpF3vLcW748DXbCWwA/wrY9hfyAs+kIKsjBGj
 xjb/WEqFX3Rimvrm2Luy0desbF2RD7Wl4QyQKBrsE/14xTRKxiwNqxFgB8/RkNw6D/JOn9FRgJP
 +S+yqF38Hewx9bTIn33vjerhvAND7UzinGeNUJpXqLR/F7lKpQQXuRMY5mdmDflj6xztEbcCgxb
 A4OCnkoTCXZGzrIlmwczAGU2R1fy/NLa3UHKhiOXPfr99LePi/aDbvc/t749reJt8dFtYzmMfTJ
 wtBc3HtPkXjSHLNCSDV2W0LsEbENrF96c+Eq+Kl4TzSyPP2Tmt4n3uUbjApYcytpt4Mo+l1oz5M
 4vFNNPwfIR6QnC57SN8i+M2lDT/bW1IYMkaHv525f18sUWl1qxi++qQc8Pwb6sSMjRKNst7T1Bo
 y4+3tZ+6csAUmAytBKGxFeyfORmjzX3sjvZskFs67dmQmMtvpwqohv6Jnl8CnqJ64L4VKma+xO7
 l5VfxMDPpiMTAGxq4XdF7Jada1Fr5nj3+H4B2h4W2JaLhF6ri/7Y6yN/RVgZBsLHyewDG3cpMFq
 5n7e/JbKrwXen/Uj1y6rX+pzcUV8SkIHuCy8IbhQQxKehlWT+cLj+5r+G44U8vbk5m+trfrBDrl
 S9m+JSm+wudB/k2YA=
X-Received: by 2002:a17:907:3cd4:b0:c46:7de7:e41d with SMTP id
 a640c23a62f3a-c5126522746mr8307866b.18.1795021615136; 
 Wed, 18 Nov 2026 09:06:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a656c11643sm5701140f8f.49.2026.11.18.09.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:06:54 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 17:06:54 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3
X-Gerrit-Change-Number: 2196
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2196?usp=email>
X-Gerrit-Commit: ec5dd16a4a97622009da864f9f167a9667005cdd
In-Reply-To: <gerrit.1794834650000.Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3@gerrit.openvpn.net>
References: <gerrit.1794834650000.Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM0NjUwMDAwLkllYzg1ZDUzY2UxMDc2NjM5YmQ2Y2VhZjNiYTdkNTNjYzllNzlkN2EzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ef63b765d17f44e9e1ba6b2f3bcc8c6eb7cbacea-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTj7e-000000006rK-1H1z
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8796559065302353196=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8796559065302353196==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wRqMr4p0BMw="; charset=UTF-8

--wRqMr4p0BMw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2196?usp=3Demail )

Change subject: options: drop impossible ou=
t-of-memory branches
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

options: drop impossible out-of-memory branches

gc_realloc() abort=
s via check_malloc_return() and never returns NULL=2E
Remove the NULL handl=
ing from alloc_{local,connection,remote}_entry(),
their now unused msglevel=
 parameter, and the callers' checks=2E

Change-Id: Iec85d53ce1076639bd6ceaf=
3ba7d53cc9e79d7a3
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Ac=
ked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2196
Message-Id: <20261117143617=2E25095-1-=
gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg41542=2Ehtml
Signed-off-by: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
---
M src/openvpn/options=2Ec
1 file changed, 12 ins=
ertions(+), 57 deletions(-)




diff --git a/src/openvpn/options=2Ec b/src/=
openvpn/options=2Ec
index 2181076=2E=2E947439d 100644
--- a/src/openvpn/opt=
ions=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1379,7 +1379,7 @@
 }
 
 static s=
truct local_entry *
-alloc_local_entry(struct connection_entry *ce, const m=
sglvl_t msglevel, struct gc_arena *gc)
+alloc_local_entry(struct connection=
_entry *ce, struct gc_arena *gc)
 {
     struct local_list *l =3D alloc_loc=
al_list_if_undef(ce, gc);
     struct local_entry *e;
@@ -1389,16 +1389,7 @=
@
         const int new_cap =3D l->capacity + 1;
         const size_t ele=
m_size =3D sizeof(*l->array);
 
-        struct local_entry **new_array =3D=
 gc_realloc(l->array, new_cap * elem_size, gc);
-        if (!new_array)
- =
       {
-            msg(msglevel,
-                "Unable to process mor=
e local options: out of memory=2E Number of entries =3D %d",
-             =
   l->len);
-            return NULL;
-        }
-
-        l->array =3D ne=
w_array;
+        l->array =3D gc_realloc(l->array, new_cap * elem_size, gc=
);
         l->capacity =3D new_cap;
     }
 
@@ -1420,7 +1411,7 @@
 }
 
 s=
tatic struct connection_entry *
-alloc_connection_entry(struct options *opt=
ions, const msglvl_t msglevel)
+alloc_connection_entry(struct options *opti=
ons)
 {
     struct connection_list *l =3D alloc_connection_list_if_undef(o=
ptions);
     struct connection_entry *e;
@@ -1428,16 +1419,7 @@
     if (l=
->len =3D=3D l->capacity)
     {
         int capacity =3D l->capacity + CO=
NNECTION_LIST_SIZE;
-        struct connection_entry **ce =3D
-            =
gc_realloc(l->array, capacity * sizeof(struct connection_entry *), &options=
->gc);
-        if (ce =3D=3D NULL)
-        {
-            msg(msglevel,
-=
                "Unable to process more connection options: out of memory=
=2E Number of entries =3D %d",
-                l->len);
-            retur=
n NULL;
-        }
-        l->array =3D ce;
+        l->array =3D gc_reall=
oc(l->array, capacity * sizeof(struct connection_entry *), &options->gc);
 =
        l->capacity =3D capacity;
     }
     ALLOC_OBJ_GC(e, struct connec=
tion_entry, &options->gc);
@@ -1456,7 +1438,7 @@
 }
 
 static struct remote=
_entry *
-alloc_remote_entry(struct options *options, const msglvl_t msglev=
el)
+alloc_remote_entry(struct options *options)
 {
     struct remote_list=
 *l =3D alloc_remote_list_if_undef(options);
     struct remote_entry *e;
@=
@ -1464,16 +1446,7 @@
     if (l->len =3D=3D l->capacity)
     {
         i=
nt capacity =3D l->capacity + CONNECTION_LIST_SIZE;
-        struct remote_=
entry **re =3D
-            gc_realloc(l->array, capacity * sizeof(struct r=
emote_entry *), &options->gc);
-        if (re =3D=3D NULL)
-        {
-   =
         msg(msglevel,
-                "Unable to process more remote opti=
ons: out of memory=2E Number of entries =3D %d",
-                l->len);
=
-            return NULL;
-        }
-        l->array =3D re;
+        l->=
array =3D gc_realloc(l->array, capacity * sizeof(struct remote_entry *), &o=
ptions->gc);
         l->capacity =3D capacity;
     }
     ALLOC_OBJ_GC(e,=
 struct remote_entry, &options->gc);
@@ -3071,20 +3044,16 @@
         {
   =
          const struct remote_entry *re =3D rl->array[i];
             stru=
ct connection_entry ce =3D o->ce;
-            struct connection_entry *ace=
;
 
             ASSERT(re->remote);
             connection_entry_load_re(=
&ce, re);
-            ace =3D alloc_connection_entry(o, M_USAGE);
-       =
     ASSERT(ace);
+            struct connection_entry *ace =3D alloc_conne=
ction_entry(o);
             *ace =3D ce;
         }
     }
     else if (!=
o->remote_list && !o->connection_list)
     {
-        struct connection_en=
try *ace;
-        ace =3D alloc_connection_entry(o, M_USAGE);
-        ASS=
ERT(ace);
+        struct connection_entry *ace =3D alloc_connection_entry(=
o);
         *ace =3D o->ce;
     }
 
@@ -3117,8 +3086,7 @@
     {
        =
 /* if no 'local' directive was specified, convert the global port
        =
  * setting to a listen entry */
-        struct local_entry *e =3D alloc_l=
ocal_entry(&o->ce, M_USAGE, &o->gc);
-        ASSERT(e);
+        struct lo=
cal_entry *e =3D alloc_local_entry(&o->ce, &o->gc);
         e->port =3D o-=
>ce=2Elocal_port;
         e->proto =3D o->ce=2Eproto;
     }
@@ -4464,12 +=
4432,9 @@
     }
     else if (streq(p[0], "local") && p[1] && !p[4])
     =
{
-        struct local_entry *e;
-
         VERIFY_PERMISSION(OPT_P_GENERA=
L | OPT_P_CONNECTION);
 
-        e =3D alloc_local_entry(&options->ce, M_U=
SAGE, &options->gc);
-        ASSERT(e);
+        struct local_entry *e =3D=
 alloc_local_entry(&options->ce, &options->gc);
 
         /* '*' is treate=
d as 'ask the system to get some socket',
          * therefore force bindi=
ng on a particular address only when
@@ -4500,7 +4465,6 @@
         if (is_=
inline)
         {
             struct options sub;
-            struct con=
nection_entry *e;
 
             init_options(&sub);
             sub=2Ece =
=3D options->ce;
@@ -4514,12 +4478,7 @@
                 goto err;
        =
     }
 
-            e =3D alloc_connection_entry(options, msglevel);
-   =
         if (!e)
-            {
-                uninit_options(&sub);
-   =
             goto err;
-            }
+            struct connection_entry =
*e =3D alloc_connection_entry(options);
             *e =3D sub=2Ece;
     =
        gc_transfer(&options->gc, &sub=2Egc);
             uninit_options(&=
sub);
@@ -4608,11 +4567,7 @@
         }
         if (permission_mask & OPT_=
P_GENERAL)
         {
-            struct remote_entry *e =3D alloc_remote_=
entry(options, msglevel);
-            if (!e)
-            {
-            =
    goto err;
-            }
+            struct remote_entry *e =3D alloc_=
remote_entry(options);
             *e =3D re;
         }
         else if =
(permission_mask & OPT_P_CONNECTION)

-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2196?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3
Gerrit-Change-Nu=
mber: 2196
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>

--wRqMr4p0BMw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2196?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">options: drop impossible out-of-me=
mory branches<br><br>gc_realloc() aborts via check_malloc_return() and neve=
r returns NULL=2E<br>Remove the NULL handling from alloc_{local,connection,=
remote}_entry(),<br>their now unused msglevel parameter, and the callers&#3=
9; checks=2E<br><br>Change-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3<br=
>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2196<br>Message-Id: &lt;20261117143617=2E2=
5095-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg41542=2Ehtml<br>Signed-off-by: =
Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/option=
s=2Ec<br>1 file changed, 12 insertions(+), 57 deletions(-)<br><br></pre>
<p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><=
span>index 2181076=2E=2E947439d 100644</span><br><span>--- a/src/openvpn/op=
tions=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ =
-1379,7 +1379,7 @@</span><br><span> }</span><br><span> </span><br><span> st=
atic struct local_entry *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-alloc_local_entry(struct connection_entry *ce, const msglvl_t msglevel,=
 struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+alloc_local_entry(struct connection_entry *ce, struct gc_arena *gc)</span=
><br><span> {</span><br><span>     struct local_list *l =3D alloc_local_lis=
t_if_undef(ce, gc);</span><br><span>     struct local_entry *e;</span><br><=
span>@@ -1389,16 +1389,7 @@</span><br><span>         const int new_cap =3D =
l-&gt;capacity + 1;</span><br><span>         const size_t elem_size =3D siz=
eof(*l-&gt;array);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        struct local_entry **new_array =3D gc_realloc(l-&gt;=
array, new_cap * elem_size, gc);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (!new_array)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            msg(msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                &quot;Unable to process more local options: out of mem=
ory=2E Number of entries =3D %d&quot;,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                l-&gt;len);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            return NULL;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 l-&gt;array =3D new_array;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        l-&gt;array =3D gc_realloc(l-&gt;array, new_cap * elem_size=
, gc);</span><br><span>         l-&gt;capacity =3D new_cap;</span><br><span=
>     }</span><br><span> </span><br><span>@@ -1420,7 +1411,7 @@</span><br><=
span> }</span><br><span> </span><br><span> static struct connection_entry *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-alloc_connection_entr=
y(struct options *options, const msglvl_t msglevel)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+alloc_connection_entry(struct options *op=
tions)</span><br><span> {</span><br><span>     struct connection_list *l =
=3D alloc_connection_list_if_undef(options);</span><br><span>     struct co=
nnection_entry *e;</span><br><span>@@ -1428,16 +1419,7 @@</span><br><span> =
    if (l-&gt;len =3D=3D l-&gt;capacity)</span><br><span>     {</span><br><=
span>         int capacity =3D l-&gt;capacity + CONNECTION_LIST_SIZE;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct connection_e=
ntry **ce =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    gc_realloc(l-&gt;array, capacity * sizeof(struct connection_entry *), &=
amp;options-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (ce =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     msg(msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             &quot;Unable to process more connection options: out of memory=
=2E Number of entries =3D %d&quot;,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                l-&gt;len);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            return NULL;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        l-&gt;array =3D ce;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        l-&gt;array =3D gc_realloc(l-&gt;array, capacity=
 * sizeof(struct connection_entry *), &amp;options-&gt;gc);</span><br><span=
>         l-&gt;capacity =3D capacity;</span><br><span>     }</span><br><sp=
an>     ALLOC_OBJ_GC(e, struct connection_entry, &amp;options-&gt;gc);</spa=
n><br><span>@@ -1456,7 +1438,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> static struct remote_entry *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-alloc_remote_entry(struct options *options, const msglv=
l_t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+alloc_=
remote_entry(struct options *options)</span><br><span> {</span><br><span>  =
   struct remote_list *l =3D alloc_remote_list_if_undef(options);</span><br=
><span>     struct remote_entry *e;</span><br><span>@@ -1464,16 +1446,7 @@<=
/span><br><span>     if (l-&gt;len =3D=3D l-&gt;capacity)</span><br><span> =
    {</span><br><span>         int capacity =3D l-&gt;capacity + CONNECTION=
_LIST_SIZE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        st=
ruct remote_entry **re =3D</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            gc_realloc(l-&gt;array, capacity * sizeof(struct remote_en=
try *), &amp;options-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (re =3D=3D NULL)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            msg(msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                &quot;Unable to process more remote options: out of m=
emory=2E Number of entries =3D %d&quot;,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                l-&gt;len);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            return NULL;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        l-&gt;array =3D re;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        l-&gt;array =3D gc_realloc(l-&gt;array, cap=
acity * sizeof(struct remote_entry *), &amp;options-&gt;gc);</span><br><spa=
n>         l-&gt;capacity =3D capacity;</span><br><span>     }</span><br><s=
pan>     ALLOC_OBJ_GC(e, struct remote_entry, &amp;options-&gt;gc);</span><=
br><span>@@ -3071,20 +3044,16 @@</span><br><span>         {</span><br><span=
>             const struct remote_entry *re =3D rl-&gt;array[i];</span><br>=
<span>             struct connection_entry ce =3D o-&gt;ce;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            struct connection_entry *=
ace;</span><br><span> </span><br><span>             ASSERT(re-&gt;remote);<=
/span><br><span>             connection_entry_load_re(&amp;ce, re);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            ace =3D alloc_con=
nection_entry(o, M_USAGE);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            ASSERT(ace);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            struct connection_entry *ace =3D alloc_connection_ent=
ry(o);</span><br><span>             *ace =3D ce;</span><br><span>         }=
</span><br><span>     }</span><br><span>     else if (!o-&gt;remote_list &a=
mp;&amp; !o-&gt;connection_list)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        struct connection_entry *ace;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        ace =3D alloc_con=
nection_entry(o, M_USAGE);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        ASSERT(ace);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct connection_entry *ace =3D alloc_connection_entry(o);</=
span><br><span>         *ace =3D o-&gt;ce;</span><br><span>     }</span><br=
><span> </span><br><span>@@ -3117,8 +3086,7 @@</span><br><span>     {</span=
><br><span>         /* if no &#39;local&#39; directive was specified, conve=
rt the global port</span><br><span>          * setting to a listen entry */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct local_=
entry *e =3D alloc_local_entry(&amp;o-&gt;ce, M_USAGE, &amp;o-&gt;gc);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(e);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        struct local_entry =
*e =3D alloc_local_entry(&amp;o-&gt;ce, &amp;o-&gt;gc);</span><br><span>   =
      e-&gt;port =3D o-&gt;ce=2Elocal_port;</span><br><span>         e-&gt;=
proto =3D o-&gt;ce=2Eproto;</span><br><span>     }</span><br><span>@@ -4464=
,12 +4432,9 @@</span><br><span>     }</span><br><span>     else if (streq(p=
[0], &quot;local&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct l=
ocal_entry *e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span>         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 e =3D alloc_local_entry(&amp;options-&gt;ce, M_USAGE, &amp;options-&gt;gc)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(e);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct local_=
entry *e =3D alloc_local_entry(&amp;options-&gt;ce, &amp;options-&gt;gc);</=
span><br><span> </span><br><span>         /* &#39;*&#39; is treated as &#39=
;ask the system to get some socket&#39;,</span><br><span>          * theref=
ore force binding on a particular address only when</span><br><span>@@ -450=
0,7 +4465,6 @@</span><br><span>         if (is_inline)</span><br><span>    =
     {</span><br><span>             struct options sub;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            struct connection_entry *e;</=
span><br><span> </span><br><span>             init_options(&amp;sub);</span=
><br><span>             sub=2Ece =3D options-&gt;ce;</span><br><span>@@ -45=
14,12 +4478,7 @@</span><br><span>                 goto err;</span><br><span=
>             }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            e =3D alloc_connection_entry(options, msglevel);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!e)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                uninit_options(&am=
p;sub);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  goto err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            stru=
ct connection_entry *e =3D alloc_connection_entry(options);</span><br><span=
>             *e =3D sub=2Ece;</span><br><span>             gc_transfer(&am=
p;options-&gt;gc, &amp;sub=2Egc);</span><br><span>             uninit_optio=
ns(&amp;sub);</span><br><span>@@ -4608,11 +4567,7 @@</span><br><span>      =
   }</span><br><span>         if (permission_mask &amp; OPT_P_GENERAL)</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            struct remote_entry *e =3D alloc_remote_entry(options, msgleve=
l);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!e=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                goto err;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            struct remote_entr=
y *e =3D alloc_remote_entry(options);</span><br><span>             *e =3D r=
e;</span><br><span>         }</span><br><span>         else if (permission_=
mask &amp; OPT_P_CONNECTION)</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Demail">change 2196</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iec85d5=
3ce1076639bd6ceaf3ba7d53cc9e79d7a3 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 2196 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Co=
jocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>

</body></html>
--wRqMr4p0BMw=--


--===============8796559065302353196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8796559065302353196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8796559065302353196==--

