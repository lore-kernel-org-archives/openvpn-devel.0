Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302DE606A327
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MDy9qeWE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kMG2nsBW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gDOBQb/S;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GSikCoaZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hi49tuWeGvcWJETL1sUmSrj1+4hoE9VCjlHGoHEixRI=; b=MDy9qeWEZPzFQrE5RPEe+pUuvp
	E9bbRPuUNHL67U2Bvi3TQv8ZkwNUg2JrIYzPgvTQ8nu0hLotC7pzHnoDI3g9WEsKEQTp/1TNFZuiV
	D+joQQvoblVncsDijKPMjtAX+2sbsgOzZtFv5/yYFmCgZas18ntkvW1RctCu+DCrpgKg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNri5-000000003b4-2LIc;
	Mon, 02 Nov 2026 13:04:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNri4-000000003aw-1JRR
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:04:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ph3pQI1sqgfV4D6oupFVBM5fU4e1hb5YgLkpG8n9Waw=; b=kMG2nsBW2KoM7ySJe5tFC9siU+
 Haxwp/b5lecmBXsVhOUs4QHbE/xh48cvP4b+nDSQm2t6O22TSg+sBmokDyNdpm4avE/ouO2JIWnno
 WdxN4aVxvVOvKVDDMUeaTZd3PWzhPcL6I19pmp6DKZmftQxaVLt11pfB2lD1f1nbOuH8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ph3pQI1sqgfV4D6oupFVBM5fU4e1hb5YgLkpG8n9Waw=; b=gDOBQb/S3h52hMvDsKpCuyZ6xM
 gPHLM4ve428iny1k2fWl5G7qvZJmhmXhjZ/Q3xKesREHm2FhGQsY0yV8f3Wo/+ZpSF31mDG70jDr8
 /luyRaekF8hXSoj1lpcgk1qBPB1l0WNwBUesIVut8hiOhDGlGo9s9NreftU/pDV089/U=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNri1-000000007vL-0tvp for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:04:24 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so1537348f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 05:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793624655; x=1794229455; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ph3pQI1sqgfV4D6oupFVBM5fU4e1hb5YgLkpG8n9Waw=;
 b=GSikCoaZamnieLqvx+9Jm0oC/sZY8CqVfLdGwmk0qKZUkduqjmNfX6JGkPIe9/iQhy
 e4H/A5pVqSZG18eaVWTRzN/N/dyYvLgx8McEbGczn68OiKB/uGfWhafjgMGxm2xiZXZJ
 5sxf/78zn0TbLbt1VBHz3pNo1w2cJsK8JH2VqxnGGSHby8uTsvAWytMCz6MoaskNl6fj
 9dQQ9GzmMQNfWgErhi70hozNN91QGkg9YS3g8E4CLCX21sAL26rq4de70nMkbOVH22aB
 yCiSU0wW304ZNk3RRiFa9AlS74f5wpGAtoLL5cZhi0NELWlXE2YX9Pmm/BYtgfJziIAE
 DAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793624655; x=1794229455;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ph3pQI1sqgfV4D6oupFVBM5fU4e1hb5YgLkpG8n9Waw=;
 b=1WpCcbZ317fykqEbwlsaPpQnC4ovzD4Lz7ErTbnHW8XGXyHDtTw7AgEJ0DJSAHWq5X
 eMinZhqXY+J5eD6Q8xX9k3BjYsh9oOgezhuMiEVNrVdZKZQcbGfExfgkHRccRjQ3m/rw
 2ebStDaEvNFHJ47TBjuxhPakM+VNB/vakq23HMQ//do1nCp86sP0f4o1EXnGimWym1+S
 6OLaiUV+LCqP9m28h8aYhw2mUzTjUXGmnFbU91ezkV5cnTf+ya5LI+zaTMhMU2h5VDln
 kazdGMkpWf0P4z6iYrkyFcnoddbW4p9fLRB+Pj6ndtUMlWhQnmMzExaeqnnJaI7XDSnW
 nHHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmAeCoTmiX/MZvZXO5fQcGPAzWvffeE/RcB+OLO5w+VlIP4gcS9aovuQ7EQPEHQDKL3wI4wQmzXU0a1aSz@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9Taskom9g6sjG5FouTrxc0z5EZ8k+Yt6RovF9/OZDYN2JDbYmn
 qR+oyRHm9rBXpS+/tDJtQuWFBruIJ9zROVf2GvYHYP2ZlwObxLnZkn1zvp5hcVUzI/ngfaOG5ln
 Ij3Rlq6bH++K/Qm6v5ADwal/aez7bVYUJ8wlxE4BKNt4u/r+Q2qpenUVXW8nTSpSoqSCyrWcCbr
 tC+WVI/A==
X-Gm-Gg: AYBFou0DB8eOdBITte6iFvejY8WGlT5HiirSl8S6/kBgouKKDqCY3MEaUdRG/jiEGrf
 jjeJ+i+RWx00YENtKeGOw+YMpDdfH01MTwTCYPMuq6BgsBrbJ1oDvJGLMQF57G6Z4ngttdryWE3
 I6+uElEi8rxPL9RTBljt592Q+aHFPeAuWY4lkJc9QFwK9v6Tbbmfk4PXBe6kUZ/lrMwzeYlPR10
 IPtvqryqYJVcDYTo+UXN0oqHp+AE6+MRZqjiJZzr5U/AT94HiiyHucCCIfHnWTIZOLSwxEV9mf+
 pNn2ipi8Olrfe4QpG0RV9+l1nAX7WnK7aoIXsSN6s0RP0HR0yezfvAfUL6pToF4sLgwKPR49eIA
 g4d5awa+9jCnaigpNu9yQg/XaFneHZ9o0+LGoU1GpHiUPP0DNQiOnMTmhESkVW5wqLH7KyQrErj
 3YfbbbLuxpVJw5mFXpK9KVapCAngx9hQVEF/FPFdFdI1tcg8VSkU6tPoYbhclZa3/kNogfdU4Dg
 RWyNCM/2LIKM6qNE8Ap5zOAsjxJP18DOA+BVLR0nFcyV7fCYkwyUC0FA3guMchoCskFjOpxI7sU
 eoP/V95bbq1xv4oal5+Y0TQwG+8wEANbKuYVIQpJEUIjgOqdNfmtdje6t42Oca842qKTtSZSr6L
 3PKGcyLyJUEffLBJ08Y/jiYazOb9qsrQ9sJWSmBxJlsed5J4zPmGhFqjkSbZq2PHckjY6Dyv/cZ
 HJXdZuoXZWcQgcpw==
X-Received: by 2002:a05:6000:2089:b0:48c:4f6f:62e3 with SMTP id
 ffacd0b85a97d-48e6e2eb736mr20584592f8f.18.1793624652957; 
 Mon, 02 Nov 2026 05:04:12 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8a84esm22070482f8f.39.2026.11.02.05.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:04:11 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 13:04:10 +0000
To: Laptops <jeff@incrediblybased.co>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icf890b018b9950c698e46cc44b39edaa0c6ec566
X-Gerrit-Change-Number: 2034
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2034?usp=email>
X-Gerrit-Commit: 16c3f4df69f51ffcf403527fbe0bc8c0bffd9417
In-Reply-To: <gerrit.1793032811000.Icf890b018b9950c698e46cc44b39edaa0c6ec566@gerrit.openvpn.net>
References: <gerrit.1793032811000.Icf890b018b9950c698e46cc44b39edaa0c6ec566@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDMyODExMDAwLkljZjg5MGIwMThiOTk1MGM2OThlNDZjYzQ0YjM5ZWRhYTBjNmVjNTY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <afdbbb7d5c647bf58743758235c753b8b9017c12-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNri1-000000007vL-0tvp
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 jeff@incrediblybased.co
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6622834027834366541=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6622834027834366541==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lNVeZvBaTgk="; charset=UTF-8

--lNVeZvBaTgk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2034?usp=3Demail )

Change subject: buffer: restructure some lo=
ops and assignments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

buffer: restructure some loops and assignments

Small cleanups in b=
uffer=2Ec that do not change behaviour, in preparation
for building it with=
 -fbounds-safety:

- alloc_buf(), alloc_buf_gc(), clone_buf(): assign buf=
=2Edata before
  buf=2Ecapacity and drop the redundant casts of the allocat=
or result
- free_buf_gc(): compare the entry address arithmetically instead=
 of
  stepping a struct gc_entry pointer past its object
- buf_printf(): bo=
und the length of the written string by the capacity
  passed to vsnprintf(=
)
- string_array_len(), print_argv(), string_class(), string_substitute():
=
  walk NUL-terminated strings and arrays by advancing the pointer
- string_=
mod(): write through a separate output pointer
- string_alloc_buf(): use a =
temporary for the copied string
- buf_parse(): check for an empty line with=
out strlen()

Change-Id: Icf890b018b9950c698e46cc44b39edaa0c6ec566
Signed-o=
ff-by: Jeff Bindel <jeff@incrediblybased=2Eco>
Acked-by: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2034
Message-Id: <20261027130252=2E2457-1-gert@greenie=2Emuc=2Ede>
UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg40197=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
=
M src/openvpn/buffer=2Ec
1 file changed, 26 insertions(+), 34 deletions(-)
=




diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index c683=
f8e=2E=2E8813fa5 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buff=
er=2Ec
@@ -66,8 +66,8 @@
     {
         buf_size_error(size);
     }
-    =
buf=2Ecapacity =3D (int)size;
     buf=2Edata =3D calloc(1, size);
+    buf=
=2Ecapacity =3D (int)size;
     check_malloc_return(buf=2Edata);
 
     ret=
urn buf;
@@ -83,8 +83,8 @@
     {
         buf_size_error(size);
     }
+  =
  buf=2Edata =3D gc_malloc(size, false, gc);
     buf=2Ecapacity =3D (int)s=
ize;
-    buf=2Edata =3D (uint8_t *)gc_malloc(size, false, gc);
     if (si=
ze)
     {
         *buf=2Edata =3D 0;
@@ -100,15 +100,15 @@
 #endif
 {
   =
  struct buffer ret;
+    ret=2Edata =3D malloc(buf->capacity);
     ret=2E=
capacity =3D buf->capacity;
+    check_malloc_return(ret=2Edata);
     ret=
=2Eoffset =3D buf->offset;
     ret=2Elen =3D buf->len;
 #ifdef BUF_INIT_TR=
ACKING
     ret=2Edebug_file =3D buf->debug_file;
     ret=2Edebug_line =3D=
 buf->debug_line;
 #endif
-    ret=2Edata =3D (uint8_t *)malloc(buf->capaci=
ty);
-    check_malloc_return(ret=2Edata);
     memcpy(BPTR(&ret), CBPTR(bu=
f), BLENZ(buf));
     return ret;
 }
@@ -182,7 +182,7 @@
         while (*e=
)
         {
             /* check if this object is the one we want to del=
ete */
-            if ((uint8_t *)(*e + 1) =3D=3D buf->data)
+            =
if ((uintptr_t)*e + sizeof(struct gc_entry) =3D=3D (uintptr_t)buf->data)
  =
           {
                 struct gc_entry *to_delete =3D *e;
 
@@ -238,=
7 +238,7 @@
             va_start(arglist, format);
             stat =3D v=
snprintf(ptr, cap, format, arglist);
             va_end(arglist);
-       =
     buf->len +=3D (int)strlen(ptr);
+            buf->len +=3D (int)strnle=
n(ptr, cap);
             if (stat >=3D 0 && stat < cap)
             {
   =
              ret =3D true;
@@ -607,7 +607,7 @@
 
         if (gc)
        =
 {
-            ret =3D (char *)gc_malloc(n, false, gc);
+            ret =
=3D gc_malloc(n, false, gc);
         }
         else
         {
@@ -648,7 =
+648,7 @@
     int i =3D 0;
     if (array)
     {
-        while (array[i]=
)
+        for (; *array; ++array)
         {
             ++i;
         }
=
@@ -661,13 +661,9 @@
 {
     struct buffer out =3D alloc_buf_gc(256, gc);
 =
    int i =3D 0;
-    for (;;)
+    for (; *p; ++p)
     {
-        const c=
har *cp =3D *p++;
-        if (!cp)
-        {
-            break;
-       =
 }
+        const char *cp =3D *p;
         if (i)
         {
             =
buf_printf(&out, " ");
@@ -695,7 +691,8 @@
 
     ASSERT(str);
 
-    buf_s=
et_read(&buf, (uint8_t *)string_alloc(str, gc), strlen(str) + 1);
+    cons=
t char *copy =3D string_alloc(str, gc);
+    buf_set_read(&buf, (const uint=
8_t *)copy, strlen(str) + 1);
 
     if (buf=2Elen > 0) /* Don't count trai=
ling '\0' as part of length */
     {
@@ -789,7 +786,7 @@
     } while (c);=

 
     line[size - 1] =3D '\0';
-    return !(eol && !strlen(line));
+    =
return !(eol && line[0] =3D=3D '\0');
 }
 
 /*
@@ -970,11 +967,10 @@
 bool
=
 string_class(const char *str, const unsigned int inclusive, const unsigned=
 int exclusive)
 {
-    char c;
     ASSERT(str);
-    while ((c =3D *str++=
))
+    for (; *str; ++str)
     {
-        if (!char_inc_exc(c, inclusive,=
 exclusive))
+        if (!char_inc_exc(*str, inclusive, exclusive))
      =
   {
             return false;
         }
@@ -990,11 +986,12 @@
 string_mo=
d(char *str, const unsigned int inclusive, const unsigned int exclusive,
  =
          const char replace)
 {
-    const char *in =3D str;
-    bool ret=
 =3D true;
-
     ASSERT(str);
 
+    char *out =3D str;
+    const char *i=
n =3D out;
+    bool ret =3D true;
+
     while (true)
     {
         char=
 c =3D *in++;
@@ -1007,12 +1004,12 @@
             }
             if (c)
  =
           {
-                *str++ =3D c;
+                *out++ =3D c;
=
             }
         }
         else
         {
-            *str =3D '\=
0';
+            *out =3D '\0';
             break;
         }
     }
@@ -1=
103,19 +1100,14 @@
 char *
 string_substitute(const char *src, char from, c=
har to, struct gc_arena *gc)
 {
-    char *ret =3D (char *)gc_malloc(strlen=
(src) + 1, true, gc);
+    char *ret =3D gc_malloc(strlen(src) + 1, true, g=
c);
     char *dest =3D ret;
-    char c;
 
-    do
+    for (; *src; ++src=
)
     {
-        c =3D *src++;
-        if (c =3D=3D from)
-        {
-   =
         c =3D to;
-        }
-        *dest++ =3D c;
-    } while (c);
+  =
      *dest++ =3D (*src =3D=3D from) ? to : *src;
+    }
+    *dest =3D '\0=
';
     return ret;
 }
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2034?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: Icf890b018b9950c698e46cc44b39edaa0c6ec566
Gerrit-Change-Number: 2034
G=
errit-PatchSet: 2
Gerrit-Owner: Laptops <jeff@incrediblybased=2Eco>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>

--lNVeZvBaTgk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2034?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">buffer: restructure some loops and=
 assignments<br><br>Small cleanups in buffer=2Ec that do not change behavio=
ur, in preparation<br>for building it with -fbounds-safety:<br><br>- alloc_=
buf(), alloc_buf_gc(), clone_buf(): assign buf=2Edata before<br>  buf=2Ecap=
acity and drop the redundant casts of the allocator result<br>- free_buf_gc=
(): compare the entry address arithmetically instead of<br>  stepping a str=
uct gc_entry pointer past its object<br>- buf_printf(): bound the length of=
 the written string by the capacity<br>  passed to vsnprintf()<br>- string_=
array_len(), print_argv(), string_class(), string_substitute():<br>  walk N=
UL-terminated strings and arrays by advancing the pointer<br>- string_mod()=
: write through a separate output pointer<br>- string_alloc_buf(): use a te=
mporary for the copied string<br>- buf_parse(): check for an empty line wit=
hout strlen()<br><br>Change-Id: Icf890b018b9950c698e46cc44b39edaa0c6ec566<b=
r>Signed-off-by: Jeff Bindel &lt;jeff@incrediblybased=2Eco&gt;<br>Acked-by:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2034<br>Message-Id: &lt;20261027130252=2E=
2457-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg40197=2Ehtml<br>Signed-off-by: =
Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/buffer=
=2Ec<br>1 file changed, 26 insertions(+), 34 deletions(-)<br><br></pre>
<pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><spa=
n>index c683f8e=2E=2E8813fa5 100644</span><br><span>--- a/src/openvpn/buffe=
r=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -66,8=
 +66,8 @@</span><br><span>     {</span><br><span>         buf_size_error(si=
ze);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    buf=2Ecapacity =3D (int)size;</span><br><span>     buf=2Edata =3D=
 calloc(1, size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  buf=2Ecapacity =3D (int)size;</span><br><span>     check_malloc_return(bu=
f=2Edata);</span><br><span> </span><br><span>     return buf;</span><br><sp=
an>@@ -83,8 +83,8 @@</span><br><span>     {</span><br><span>         buf_si=
ze_error(size);</span><br><span>     }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    buf=2Edata =3D gc_malloc(size, false, gc);</span><br=
><span>     buf=2Ecapacity =3D (int)size;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    buf=2Edata =3D (uint8_t *)gc_malloc(size, false, gc=
);</span><br><span>     if (size)</span><br><span>     {</span><br><span>  =
       *buf=2Edata =3D 0;</span><br><span>@@ -100,15 +100,15 @@</span><br><=
span> #endif</span><br><span> {</span><br><span>     struct buffer ret;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=2Edata =3D mall=
oc(buf-&gt;capacity);</span><br><span>     ret=2Ecapacity =3D buf-&gt;capac=
ity;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_mallo=
c_return(ret=2Edata);</span><br><span>     ret=2Eoffset =3D buf-&gt;offset;=
</span><br><span>     ret=2Elen =3D buf-&gt;len;</span><br><span> #ifdef BU=
F_INIT_TRACKING</span><br><span>     ret=2Edebug_file =3D buf-&gt;debug_fil=
e;</span><br><span>     ret=2Edebug_line =3D buf-&gt;debug_line;</span><br>=
<span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
=2Edata =3D (uint8_t *)malloc(buf-&gt;capacity);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    check_malloc_return(ret=2Edata);</span><br><=
span>     memcpy(BPTR(&amp;ret), CBPTR(buf), BLENZ(buf));</span><br><span> =
    return ret;</span><br><span> }</span><br><span>@@ -182,7 +182,7 @@</spa=
n><br><span>         while (*e)</span><br><span>         {</span><br><span>=
             /* check if this object is the one we want to delete */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            if ((uint8_t *)(=
*e + 1) =3D=3D buf-&gt;data)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if ((uintptr_t)*e + sizeof(struct gc_entry) =3D=3D (ui=
ntptr_t)buf-&gt;data)</span><br><span>             {</span><br><span>      =
           struct gc_entry *to_delete =3D *e;</span><br><span> </span><br><=
span>@@ -238,7 +238,7 @@</span><br><span>             va_start(arglist, for=
mat);</span><br><span>             stat =3D vsnprintf(ptr, cap, format, arg=
list);</span><br><span>             va_end(arglist);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            buf-&gt;len +=3D (int)strlen(pt=
r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf-=
&gt;len +=3D (int)strnlen(ptr, cap);</span><br><span>             if (stat =
&gt;=3D 0 &amp;&amp; stat &lt; cap)</span><br><span>             {</span><b=
r><span>                 ret =3D true;</span><br><span>@@ -607,7 +607,7 @@<=
/span><br><span> </span><br><span>         if (gc)</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret =3D=
 (char *)gc_malloc(n, false, gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            ret =3D gc_malloc(n, false, gc);</span><br><span>=
         }</span><br><span>         else</span><br><span>         {</span><=
br><span>@@ -648,7 +648,7 @@</span><br><span>     int i =3D 0;</span><br><s=
pan>     if (array)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        while (array[i])</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        for (; *array; ++array)</span><br><span> =
        {</span><br><span>             ++i;</span><br><span>         }</spa=
n><br><span>@@ -661,13 +661,9 @@</span><br><span> {</span><br><span>     st=
ruct buffer out =3D alloc_buf_gc(256, gc);</span><br><span>     int i =3D 0=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (;;)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    for (; *p; ++p)</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  const char *cp =3D *p++;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (!cp)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *cp =
=3D *p;</span><br><span>         if (i)</span><br><span>         {</span><b=
r><span>             buf_printf(&amp;out, &quot; &quot;);</span><br><span>@=
@ -695,7 +691,8 @@</span><br><span> </span><br><span>     ASSERT(str);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_=
set_read(&amp;buf, (uint8_t *)string_alloc(str, gc), strlen(str) + 1);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *copy =3D=
 string_alloc(str, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    buf_set_read(&amp;buf, (const uint8_t *)copy, strlen(str) + 1);</sp=
an><br><span> </span><br><span>     if (buf=2Elen &gt; 0) /* Don&#39;t coun=
t trailing &#39;\0&#39; as part of length */</span><br><span>     {</span><=
br><span>@@ -789,7 +786,7 @@</span><br><span>     } while (c);</span><br><s=
pan> </span><br><span>     line[size - 1] =3D &#39;\0&#39;;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return !(eol &amp;&amp; !strlen(l=
ine));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return !(=
eol &amp;&amp; line[0] =3D=3D &#39;\0&#39;);</span><br><span> }</span><br><=
span> </span><br><span> /*</span><br><span>@@ -970,11 +967,10 @@</span><br>=
<span> bool</span><br><span> string_class(const char *str, const unsigned i=
nt inclusive, const unsigned int exclusive)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    char c;</span><br><span>     A=
SSERT(str);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while =
((c =3D *str++))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (; *str; ++str)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (!char_inc_exc(c, inclusive, exclusive))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!char_inc=
_exc(*str, inclusive, exclusive))</span><br><span>         {</span><br><spa=
n>             return false;</span><br><span>         }</span><br><span>@@ =
-990,11 +986,12 @@</span><br><span> string_mod(char *str, const unsigned in=
t inclusive, const unsigned int exclusive,</span><br><span>            cons=
t char replace)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    const char *in =3D str;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    bool ret =3D true;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span>     ASSERT(str);</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *out =3D str;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *in =
=3D out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool re=
t =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>     while (true)</span><br><span>     {</span><br><span>         =
char c =3D *in++;</span><br><span>@@ -1007,12 +1004,12 @@</span><br><span> =
            }</span><br><span>             if (c)</span><br><span>         =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
*str++ =3D c;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          *out++ =3D c;</span><br><span>             }</span><br><span>    =
     }</span><br><span>         else</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            *str =3D &#39;\0&#39;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *out =
=3D &#39;\0&#39;;</span><br><span>             break;</span><br><span>     =
    }</span><br><span>     }</span><br><span>@@ -1103,19 +1100,14 @@</span>=
<br><span> char *</span><br><span> string_substitute(const char *src, char =
from, char to, struct gc_arena *gc)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    char *ret =3D (char *)gc_malloc(strlen=
(src) + 1, true, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    char *ret =3D gc_malloc(strlen(src) + 1, true, gc);</span><br><span> =
    char *dest =3D ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    char c;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (; *src; ++src)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        c =3D *src++;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (c =3D=3D from)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            c =3D to;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        *dest++ =3D c;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    } while (c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        *dest++ =3D (*src =3D=3D from) ? to : *src;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    *dest =3D &#39;\0&#39;;</span><br><span>     return=
 ret;</span><br><span> }</span><br></pre><p>To view, visit <a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2034?usp=3Demail">change 2034</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2034?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icf890b018=
b9950c698e46cc44b39edaa0c6ec566 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 2034 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 =
</div>
<div style=3D"display:none"> Gerrit-Owner: Laptops &lt;jeff@incredib=
lybased=2Eco&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--lNVeZvBaTgk=--


--===============6622834027834366541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6622834027834366541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6622834027834366541==--

