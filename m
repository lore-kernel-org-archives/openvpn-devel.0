Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC1C606A31D
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=i/4+TwWb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JlNJ2tEb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TidjM8Mm;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RVfKKLp8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=uFmufEdQF/lwUgGom8RQy2jWFDq0TRoZI7t8d4uYeR4=; b=i/4+TwWbrWVpgMewL/8XHeL+FR
	JACvg3rIkSsJ/47sGc1DAUSvT7bZ6RjbcvztUHMcMjGX7L/eDd/m8jVjg9ifxMAzQZHVCA3bR0f/I
	ej4cCfLsQUt+Kg8nxtyZWuK5QvoVfCZGhzvkwc47/Apn7aTDBvy2HTI6OrBUaUM0LOoc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLNkI-000000004xG-254E;
	Mon, 26 Oct 2026 16:40:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLNkH-000000004x9-0WuG
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 16:40:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ytWqFmw2oYjPdDu3vOZRQoXbM+n0OWBkGxbmKMXf/fU=; b=JlNJ2tEbnY8qXvacKK13H71kmo
 u7OdGf39skmUkppDDIrzuHv2ZtWNtXBpXPLfkMVocIjyYmFiZcsdwnH3JL6XRbe8F86qVJYmteFgp
 LC1dskLpeOLgkJce/3JDfXWqrODTaYMQHV4E7arNd1Bq2XTfXsrTy3Pxrr00pdi5HBZQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ytWqFmw2oYjPdDu3vOZRQoXbM+n0OWBkGxbmKMXf/fU=; b=TidjM8MmUm8bU4FYWOLNXyfRA4
 58sy15L7MGVJeemEJFPz6IppIJvd9HKcnRH6PVYJ9PBv9aJuEn2jKY5HDAMd7Y0/n72ZllWVw9PLX
 nL+tVS3F5khqNVMjSQQx0Z2cSl8OwROf4So4qfkP6L3ZYghbWH7gK2QLvdJJAqV5wdlc=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLNkF-000000005ed-1lCh for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 16:40:25 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso2918577f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793032817; x=1793637617; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ytWqFmw2oYjPdDu3vOZRQoXbM+n0OWBkGxbmKMXf/fU=;
 b=RVfKKLp8CfQEnOK+Wc1seQF/6z1aU2l/sW7+UkUMrXsJ7///wceHhdZ6bLU0w23itC
 Cwe5sFPI4jOErHxlLLkqjjcFDRgtNILez0kG+YGry5Auw8cPFAUTVS9/AHQotgU5pJ8D
 EUfkiPlUm7UDkUGNv5Vd1SSWr+cJFk9/o1qfhUjSV8rE1LKH27Y5TGJIgcQX4kGBlSBC
 cXgoJNCx9MMk7nLU5xoPKD06YlBwixHrHuSDkYeYpkV7bQvlBK7tUEFnyMHCsHDqZOF6
 wh+2af7HTmeuomF5K3NUgVG3dd5nJr5AaSlU83hWlMfh1tE8VWLuztlGE/8mEsN8GAZr
 9tXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793032817; x=1793637617;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ytWqFmw2oYjPdDu3vOZRQoXbM+n0OWBkGxbmKMXf/fU=;
 b=2zdP6JkQ3nsCWdWyjCotfrpJn2JpfTsjO4ZOSgVOWiok31nJMLK4dmAO7Z+3l8tLjU
 9rIKa8phmDa4mDeQ39gxaSIOmnWI22kWzxOtlUNT52IQyk1+KLYtQYf3uD/GCE6ve0Af
 8VwlIpW6RCbrs2hv2v+uPdUtUtVY7Il5JR7q64VvEZPUCci6k6chijlkobH9NJCKCw2r
 ZrdOypgMSpKUw95M+XT5d5meYl7YzYUSWPY8gOyf9AepEBDlEiqvws1RpUbvj+Rz5YjG
 5L8efTdwZLTwjyK3x9UE02JCaVN6qnlRaPKI9DBXB1hW8kUx9kYr7FlZMkgGH4Lp4Xxx
 O+Ew==
X-Gm-Message-State: AFq9FYL1d/F757XTMP0lb+CTDdcLO+zQuZRO74ua7hj8uVOKBVSw3mwl
 /SVsOg8rPnuweo38Og/cw3IyZg53afZ9C231wL5/Ik1zHLyhUqYdoij9dhJ8ub/qrCouSFwFDoa
 0vqZW4t9wYX9JZqu2NlSh2tvcEZHF16D7G8qT4X+2ilFQR60nXmc6FEb1O/6vGsjGcPVmDELG08
 p5IouBLw==
X-Gm-Gg: AYBFou1gqgZvB6+C+pb8wz8eg9Q7TixvhdNaxdi0fGr/1rQM4McJQ5uRAB6rYCDtkfI
 lDVTx4+GGUf13y8Vbk3baqR/Q7HULfBZTHBC3sHFss11L4tfDNtsGMYKUdSrQh0LM+NIZaOfX6v
 njgTwgi/if5kgLiKjSRpvSXf9qwBGlfFiBZTrqpTWVW9/Lf1dsGqr51ntzuePY3D8jTnxoZ9ZKB
 PBez3efkIpsg2JPrNkq5SlDIqbGd2nz2f4m7KQ/8jhWakaeN/ItC2hoBcSArbeZWU8LJ1OyFF9r
 utEaXzoyTDDoL1oVCJO5TFExHVgYjy4jgbQcvr0uPE2d4uGNwbejaRzqqdbQBhZLv+txYjURmyq
 NhDZcxUoFheb73TG58wanemnamW3HIQKEbt7ovPbwj449fsIXKoOW7XhynBaZsPkL3fONB8wXvX
 RoESaU5DADwqWuKlX3fnHN+d03CQCsCtDHAttFuJUGTfRaOuVLOxKOtGfZyYFOaQcbOT5WctCwZ
 7LeMivWKne7pARcQiBupAFPl7QwJryxO1pBHC5LO80Y4YSns6w11OnhFT8P/35b8Oy1L0iRV4Zq
 r5ywfHnoxqlD2Gv55sYYU7o2gk+db+9+XTmC7k2Y7uJBLgNXwoD7eZHnJmuMiYwMovTr79iOG3J
 h01fvySWv78ttDscJUDmANTfsTaA+AMpmK4r8PHGAbHo=
X-Received: by 2002:a5d:5f03:0:b0:487:219e:5e20 with SMTP id
 ffacd0b85a97d-48e3eb9b3b9mr13827226f8f.51.1793032816575; 
 Mon, 26 Oct 2026 09:40:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e412cc164sm16274036f8f.7.2026.10.26.09.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 09:40:16 -0700 (PDT)
X-Google-Original-From: "Laptops (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 16:40:15 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icf890b018b9950c698e46cc44b39edaa0c6ec566
X-Gerrit-Change-Number: 2034
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2034?usp=email>
X-Gerrit-Commit: 8a522b832d47a21474e5f06da900e418d050f33f
References: <gerrit.1793032811000.Icf890b018b9950c698e46cc44b39edaa0c6ec566@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDMyODExMDAwLkljZjg5MGIwMThiOTk1MGM2OThlNDZjYzQ0YjM5ZWRhYTBjNmVjNTY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <47e333aac487794609c00b79c965585a5ba1a08f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLNkF-000000005ed-1lCh
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: restructure
 some loops and assignments
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Laptops \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: jeff@incrediblybased.co, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Laptops \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1375374957921800853=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1375374957921800853==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WD0vfqXA7UA="; charset=UTF-8

--WD0vfqXA7UA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2034?usp=3Demail

to review the following change=2E
=


Change subject: buffer: restructure some loops and assignments
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: restructure so=
me loops and assignments

Small cleanups in buffer=2Ec that do not change b=
ehaviour, in preparation
for building it with -fbounds-safety:

- alloc_buf=
(), alloc_buf_gc(), clone_buf(): assign buf=2Edata before
  buf=2Ecapacity =
and drop the redundant casts of the allocator result
- free_buf_gc(): compa=
re the entry address arithmetically instead of
  stepping a struct gc_entry=
 pointer past its object
- buf_printf(): bound the length of the written st=
ring by the capacity
  passed to vsnprintf()
- string_array_len(), print_ar=
gv(), string_class(), string_substitute():
  walk NUL-terminated strings an=
d arrays by advancing the pointer
- string_mod(): write through a separate =
output pointer
- string_alloc_buf(): use a temporary for the copied string
=
- buf_parse(): check for an empty line without strlen()

Change-Id: Icf890b=
018b9950c698e46cc44b39edaa0c6ec566
Signed-off-by: Jeff Bindel <jeff@incredi=
blybased=2Eco>
---
M src/openvpn/buffer=2Ec
1 file changed, 26 insertions(+=
), 34 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/34/2034/1

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/=
buffer=2Ec
index c683f8e=2E=2E8813fa5 100644
--- a/src/openvpn/buffer=2Ec
+=
++ b/src/openvpn/buffer=2Ec
@@ -66,8 +66,8 @@
     {
         buf_size_erro=
r(size);
     }
-    buf=2Ecapacity =3D (int)size;
     buf=2Edata =3D call=
oc(1, size);
+    buf=2Ecapacity =3D (int)size;
     check_malloc_return(bu=
f=2Edata);
 
     return buf;
@@ -83,8 +83,8 @@
     {
         buf_size_er=
ror(size);
     }
+    buf=2Edata =3D gc_malloc(size, false, gc);
     buf=
=2Ecapacity =3D (int)size;
-    buf=2Edata =3D (uint8_t *)gc_malloc(size, f=
alse, gc);
     if (size)
     {
         *buf=2Edata =3D 0;
@@ -100,15 +10=
0,15 @@
 #endif
 {
     struct buffer ret;
+    ret=2Edata =3D malloc(buf->=
capacity);
     ret=2Ecapacity =3D buf->capacity;
+    check_malloc_return(=
ret=2Edata);
     ret=2Eoffset =3D buf->offset;
     ret=2Elen =3D buf->len=
;
 #ifdef BUF_INIT_TRACKING
     ret=2Edebug_file =3D buf->debug_file;
    =
 ret=2Edebug_line =3D buf->debug_line;
 #endif
-    ret=2Edata =3D (uint8_t=
 *)malloc(buf->capacity);
-    check_malloc_return(ret=2Edata);
     memcpy=
(BPTR(&ret), CBPTR(buf), BLENZ(buf));
     return ret;
 }
@@ -182,7 +182,7 =
@@
         while (*e)
         {
             /* check if this object is t=
he one we want to delete */
-            if ((uint8_t *)(*e + 1) =3D=3D buf=
->data)
+            if ((uintptr_t)*e + sizeof(struct gc_entry) =3D=3D (ui=
ntptr_t)buf->data)
             {
                 struct gc_entry *to_dele=
te =3D *e;
 
@@ -238,7 +238,7 @@
             va_start(arglist, format);
  =
           stat =3D vsnprintf(ptr, cap, format, arglist);
             va_e=
nd(arglist);
-            buf->len +=3D (int)strlen(ptr);
+            buf-=
>len +=3D (int)strnlen(ptr, cap);
             if (stat >=3D 0 && stat < ca=
p)
             {
                 ret =3D true;
@@ -607,7 +607,7 @@
 
    =
     if (gc)
         {
-            ret =3D (char *)gc_malloc(n, false, gc=
);
+            ret =3D gc_malloc(n, false, gc);
         }
         else
 =
        {
@@ -648,7 +648,7 @@
     int i =3D 0;
     if (array)
     {
-   =
     while (array[i])
+        for (; *array; ++array)
         {
         =
    ++i;
         }
@@ -661,13 +661,9 @@
 {
     struct buffer out =3D allo=
c_buf_gc(256, gc);
     int i =3D 0;
-    for (;;)
+    for (; *p; ++p)
   =
  {
-        const char *cp =3D *p++;
-        if (!cp)
-        {
-       =
     break;
-        }
+        const char *cp =3D *p;
         if (i)
    =
     {
             buf_printf(&out, " ");
@@ -695,7 +691,8 @@
 
     ASSER=
T(str);
 
-    buf_set_read(&buf, (uint8_t *)string_alloc(str, gc), strlen(=
str) + 1);
+    const char *copy =3D string_alloc(str, gc);
+    buf_set_re=
ad(&buf, (const uint8_t *)copy, strlen(str) + 1);
 
     if (buf=2Elen > 0)=
 /* Don't count trailing '\0' as part of length */
     {
@@ -789,7 +786,7 =
@@
     } while (c);
 
     line[size - 1] =3D '\0';
-    return !(eol && !=
strlen(line));
+    return !(eol && line[0] =3D=3D '\0');
 }
 
 /*
@@ -970,=
11 +967,10 @@
 bool
 string_class(const char *str, const unsigned int inclu=
sive, const unsigned int exclusive)
 {
-    char c;
     ASSERT(str);
-    =
while ((c =3D *str++))
+    for (; *str; ++str)
     {
-        if (!char_i=
nc_exc(c, inclusive, exclusive))
+        if (!char_inc_exc(*str, inclusive=
, exclusive))
         {
             return false;
         }
@@ -990,11 +=
986,12 @@
 string_mod(char *str, const unsigned int inclusive, const unsign=
ed int exclusive,
            const char replace)
 {
-    const char *in =
=3D str;
-    bool ret =3D true;
-
     ASSERT(str);
 
+    char *out =3D s=
tr;
+    const char *in =3D out;
+    bool ret =3D true;
+
     while (true=
)
     {
         char c =3D *in++;
@@ -1007,12 +1004,12 @@
             }
=
             if (c)
             {
-                *str++ =3D c;
+        =
        *out++ =3D c;
             }
         }
         else
         {
- =
           *str =3D '\0';
+            *out =3D '\0';
             break;
 =
        }
     }
@@ -1103,19 +1100,14 @@
 char *
 string_substitute(const c=
har *src, char from, char to, struct gc_arena *gc)
 {
-    char *ret =3D (c=
har *)gc_malloc(strlen(src) + 1, true, gc);
+    char *ret =3D gc_malloc(st=
rlen(src) + 1, true, gc);
     char *dest =3D ret;
-    char c;
 
-    do
+=
    for (; *src; ++src)
     {
-        c =3D *src++;
-        if (c =3D=3D=
 from)
-        {
-            c =3D to;
-        }
-        *dest++ =3D c;=

-    } while (c);
+        *dest++ =3D (*src =3D=3D from) ? to : *src;
+  =
  }
+    *dest =3D '\0';
     return ret;
 }
 

-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2034?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: Icf890b018b9950c698e46cc44b39edaa0c6ec566
Ger=
rit-Change-Number: 2034
Gerrit-PatchSet: 1
Gerrit-Owner: Laptops <jeff@incr=
ediblybased=2Eco>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--WD0vfqXA7UA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Laptops would like Arne Schwa=
be to <strong>review</strong> this change=2E
</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2034?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">buffer: restructure some loops and assignments<br><br>Small cleanups=
 in buffer=2Ec that do not change behaviour, in preparation<br>for building=
 it with -fbounds-safety:<br><br>- alloc_buf(), alloc_buf_gc(), clone_buf()=
: assign buf=2Edata before<br>  buf=2Ecapacity and drop the redundant casts=
 of the allocator result<br>- free_buf_gc(): compare the entry address arit=
hmetically instead of<br>  stepping a struct gc_entry pointer past its obje=
ct<br>- buf_printf(): bound the length of the written string by the capacit=
y<br>  passed to vsnprintf()<br>- string_array_len(), print_argv(), string_=
class(), string_substitute():<br>  walk NUL-terminated strings and arrays b=
y advancing the pointer<br>- string_mod(): write through a separate output =
pointer<br>- string_alloc_buf(): use a temporary for the copied string<br>-=
 buf_parse(): check for an empty line without strlen()<br><br>Change-Id: Ic=
f890b018b9950c698e46cc44b39edaa0c6ec566<br>Signed-off-by: Jeff Bindel &lt;j=
eff@incrediblybased=2Eco&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>1 file c=
hanged, 26 insertions(+), 34 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/34/2034/1</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><s=
pan>index c683f8e=2E=2E8813fa5 100644</span><br><span>--- a/src/openvpn/buf=
fer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -66=
,8 +66,8 @@</span><br><span>     {</span><br><span>         buf_size_error(=
size);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    buf=2Ecapacity =3D (int)size;</span><br><span>     buf=2Edata =
=3D calloc(1, size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    buf=2Ecapacity =3D (int)size;</span><br><span>     check_malloc_return=
(buf=2Edata);</span><br><span> </span><br><span>     return buf;</span><br>=
<span>@@ -83,8 +83,8 @@</span><br><span>     {</span><br><span>         buf=
_size_error(size);</span><br><span>     }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    buf=2Edata =3D gc_malloc(size, false, gc);</span>=
<br><span>     buf=2Ecapacity =3D (int)size;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    buf=2Edata =3D (uint8_t *)gc_malloc(size, false,=
 gc);</span><br><span>     if (size)</span><br><span>     {</span><br><span=
>         *buf=2Edata =3D 0;</span><br><span>@@ -100,15 +100,15 @@</span><b=
r><span> #endif</span><br><span> {</span><br><span>     struct buffer ret;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=2Edata =3D m=
alloc(buf-&gt;capacity);</span><br><span>     ret=2Ecapacity =3D buf-&gt;ca=
pacity;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_ma=
lloc_return(ret=2Edata);</span><br><span>     ret=2Eoffset =3D buf-&gt;offs=
et;</span><br><span>     ret=2Elen =3D buf-&gt;len;</span><br><span> #ifdef=
 BUF_INIT_TRACKING</span><br><span>     ret=2Edebug_file =3D buf-&gt;debug_=
file;</span><br><span>     ret=2Edebug_line =3D buf-&gt;debug_line;</span><=
br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
et=2Edata =3D (uint8_t *)malloc(buf-&gt;capacity);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    check_malloc_return(ret=2Edata);</span><br=
><span>     memcpy(BPTR(&amp;ret), CBPTR(buf), BLENZ(buf));</span><br><span=
>     return ret;</span><br><span> }</span><br><span>@@ -182,7 +182,7 @@</s=
pan><br><span>         while (*e)</span><br><span>         {</span><br><spa=
n>             /* check if this object is the one we want to delete */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            if ((uint8_t *=
)(*e + 1) =3D=3D buf-&gt;data)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if ((uintptr_t)*e + sizeof(struct gc_entry) =3D=3D (=
uintptr_t)buf-&gt;data)</span><br><span>             {</span><br><span>    =
             struct gc_entry *to_delete =3D *e;</span><br><span> </span><br=
><span>@@ -238,7 +238,7 @@</span><br><span>             va_start(arglist, f=
ormat);</span><br><span>             stat =3D vsnprintf(ptr, cap, format, a=
rglist);</span><br><span>             va_end(arglist);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            buf-&gt;len +=3D (int)strlen(p=
tr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf=
-&gt;len +=3D (int)strnlen(ptr, cap);</span><br><span>             if (stat=
 &gt;=3D 0 &amp;&amp; stat &lt; cap)</span><br><span>             {</span><=
br><span>                 ret =3D true;</span><br><span>@@ -607,7 +607,7 @@=
</span><br><span> </span><br><span>         if (gc)</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret =
=3D (char *)gc_malloc(n, false, gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            ret =3D gc_malloc(n, false, gc);</span><br><sp=
an>         }</span><br><span>         else</span><br><span>         {</spa=
n><br><span>@@ -648,7 +648,7 @@</span><br><span>     int i =3D 0;</span><br=
><span>     if (array)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        while (array[i])</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        for (; *array; ++array)</span><br><spa=
n>         {</span><br><span>             ++i;</span><br><span>         }</=
span><br><span>@@ -661,13 +661,9 @@</span><br><span> {</span><br><span>    =
 struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span>     int i =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (;;)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (; *p; ++p)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       const char *cp =3D *p++;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (!cp)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *=
cp =3D *p;</span><br><span>         if (i)</span><br><span>         {</span=
><br><span>             buf_printf(&amp;out, &quot; &quot;);</span><br><spa=
n>@@ -695,7 +691,8 @@</span><br><span> </span><br><span>     ASSERT(str);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    b=
uf_set_read(&amp;buf, (uint8_t *)string_alloc(str, gc), strlen(str) + 1);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *copy =
=3D string_alloc(str, gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    buf_set_read(&amp;buf, (const uint8_t *)copy, strlen(str) + 1);<=
/span><br><span> </span><br><span>     if (buf=2Elen &gt; 0) /* Don&#39;t c=
ount trailing &#39;\0&#39; as part of length */</span><br><span>     {</spa=
n><br><span>@@ -789,7 +786,7 @@</span><br><span>     } while (c);</span><br=
><span> </span><br><span>     line[size - 1] =3D &#39;\0&#39;;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    return !(eol &amp;&amp; !strle=
n(line));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 !(eol &amp;&amp; line[0] =3D=3D &#39;\0&#39;);</span><br><span> }</span><b=
r><span> </span><br><span> /*</span><br><span>@@ -970,11 +967,10 @@</span><=
br><span> bool</span><br><span> string_class(const char *str, const unsigne=
d int inclusive, const unsigned int exclusive)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    char c;</span><br><span>   =
  ASSERT(str);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    whi=
le ((c =3D *str++))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    for (; *str; ++str)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (!char_inc_exc(c, inclusive, exclusive)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!char_=
inc_exc(*str, inclusive, exclusive))</span><br><span>         {</span><br><=
span>             return false;</span><br><span>         }</span><br><span>=
@@ -990,11 +986,12 @@</span><br><span> string_mod(char *str, const unsigned=
 int inclusive, const unsigned int exclusive,</span><br><span>            c=
onst char replace)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    const char *in =3D str;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    bool ret =3D true;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(str);</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *out =3D s=
tr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *=
in =3D out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 ret =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>     while (true)</span><br><span>     {</span><br><span>      =
   char c =3D *in++;</span><br><span>@@ -1007,12 +1004,12 @@</span><br><spa=
n>             }</span><br><span>             if (c)</span><br><span>      =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   *str++ =3D c;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             *out++ =3D c;</span><br><span>             }</span><br><span> =
        }</span><br><span>         else</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            *str =3D &#39;\0&#=
39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *ou=
t =3D &#39;\0&#39;;</span><br><span>             break;</span><br><span>   =
      }</span><br><span>     }</span><br><span>@@ -1103,19 +1100,14 @@</spa=
n><br><span> char *</span><br><span> string_substitute(const char *src, cha=
r from, char to, struct gc_arena *gc)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    char *ret =3D (char *)gc_malloc(strl=
en(src) + 1, true, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    char *ret =3D gc_malloc(strlen(src) + 1, true, gc);</span><br><span=
>     char *dest =3D ret;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    char c;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   for (; *src; ++src)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        c =3D *src++;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (c =3D=3D from)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            c =3D to;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        *dest++ =3D c;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    } while (c);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        *dest++ =3D (*src =3D=3D from) ? to : *src;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    *dest =3D &#39;\0&#39;;</span><br><span>     retur=
n ret;</span><br><span> }</span><br></pre><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2034?usp=3Demail">change 2034</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2034?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icf890b=
018b9950c698e46cc44b39edaa0c6ec566 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 2034 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Laptops &lt;jeff@incre=
diblybased=2Eco&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--WD0vfqXA7UA=--


--===============1375374957921800853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1375374957921800853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1375374957921800853==--

