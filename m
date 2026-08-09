Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BF0C5AD55
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 08:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xZjqKvZVXpITlA7gjMn1c8xEwQOCHZ7ZX0DU+PNxguU=; b=D6i5WPvIGIb4+G1fi4YmipVM7Q
	P+YJJiMierCCzJrVs4i44Oi4GV/XSW0XTJT2z+tO/Wf/iSdn1F8A5hmQpWZcGiLXxawo3MRLCvMX9
	X2kB/tRfeMOmNd0HDmNXe1HdYCX4jJhVqcEQLWzC4R3X8QHZkVwgMXcKI3+D2/2m8EKw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsyzG-0003eK-B9;
	Sun, 09 Aug 2026 08:34:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsyzF-0003dB-LV
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 08:34:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=RaWhgY6nHi560S54P6u5NNcwyfxEeno8zLXJGhuYexs=; b=VPGVQe3vxcfGsP4D5nSP+KQMaT
 Q0RuxElei89E2VyDKe65oacq2gU+/eU0vXQEdiMB8xvktQWlRnXnL0IQYppSCz32J4hajeoqB58OT
 bQdd6vFJAbrCxmkQNoCaDLcZPMKQef6TIleoLS6/LFHcVo8FIkH9EsCorelV6H2wOGwk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RaWhgY6nHi560S54P6u5NNcwyfxEeno8zLXJGhuYexs=; b=D
 L+3ao+Q22gyriyvK/31UbCmx31nKGkWlQ9HGKKO7yqjgjnxN+Ywok9xBEurZQESSR051fsZz9h9sw
 0zOClEN6xx2ahtfLHBq3zidbqsTFS4L1TXR0IjVoZEHNTeDuBvwBkWeSepNeZgtMK5Wm2eGUDT7eA
 t+NvT8mSw+S8A4q8=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsyz4-0001FI-2j for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 08:34:20 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-495635a85d2so8211015e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 09 Aug 2026 01:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786264451; x=1786869251; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RaWhgY6nHi560S54P6u5NNcwyfxEeno8zLXJGhuYexs=;
 b=Rf2rZslu+sUMcRJzrCD/7DGBJYXEtx0y20ZE1gHi5Xhj0QKKZ0txLhZ0x0cDwu9mLW
 GTPH1QNsyn7Y9FZuXp1kZ9zba59dNGtvciY+GCzDYzSSjsGS80i5kJSsch1E7Hp2cE5V
 1hTzJQZ/B1x0F4i0JEtTtVkcAk/Zw/vzwPAkFZj01KpS5y67VshNW3EQ4hceXFSDouqp
 HGTSvd8I+jI/dU2CqBKMHPzW7YqYgALlrkqfGdBpBZQ1tic/ub8516s63AJaZG6F6h1F
 87kk4OwPp1gl23C6BeKepF4wHX35L2lEKpQMZjhEZE7ah38SfmFc5RBb9YCWDBxl4q42
 +xOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786264451; x=1786869251;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RaWhgY6nHi560S54P6u5NNcwyfxEeno8zLXJGhuYexs=;
 b=mGfZLoL9zeaX4WD7Jbb2Gt1XiYmK9/QsPv4noyt0RDNiJVU1rCfbZbxr656ovTNqRn
 8KusE0LkAUkhYooXliS1WZ7R5waz6EZGGkA8/3mZbr4eq8tL882YT1GSL/yuvHrs9DMr
 xgJ2apl5knF589dHYqC1/0bufNIqYeQ64iUmQO3KMNqZ+ujuJ0gJqhRqNLqebfCL4/Nq
 vtmdoYU4QErLqvTEuAibbaBMlCmbVJlsNOWsgTpBLlJljXy7LujMKzDXNq5M3U6CoBO+
 HGvOd23l/93+ps6T/ZkXTKDOm1sN3TqRrfGDv+7mNQeoOdkF4vhZhxsD+9Rk5zH689r4
 sHVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqrWP3DhRICwDd1rd1a3IFeiVBZXovokRxSPMsUV2d578KRK12HMzFzxaYRVAF7SORr6EuVX3Nojj/zxV2V@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yzm7uckmJqE5kjy9Ys6skpKMZ4eYwHzJPszbHitmdes6zobWDEL
 +ygx2o+cEbvo9d8rKQCqAIl93CSuSU23zifUWx/JuFFsGF86uXApnlL/V2aSWuhav5N3u+t2uTU
 qKStIZpxujc5uySqUZg8KdD5rZ3acpF5s0zB7RgHfxg9kmllXAuZ+b0rBEHOq960yYLF/
X-Gm-Gg: AR+sD13WZt3eJBPjg+P9X1RbdETDjCRLV29ix6/ICKB+1hdzHVDH2r1NtXBYIBg9DMq
 ypsi09QQhAsaxyiD2f4Qe7xn2TJlTC9pNqG3Fn4ZJ9X7i4rETr4491s0NvVtP+/UNcQJswbgRCe
 837prkQ1c8CYpI3jfvcqv4Nu/R9xQvzfxCV5n6LyKFs9xwBZW5dWK1DrohrJN6suJZ9wxtpw8BK
 gFJ5Of2WoKGOmCRQkEBXNWIUkyITJp5c9iiL5kiMxZH7W1BVokU6dKMA3XbyBnjnm/ZvXt0gKQV
 gj2jbvHPvyZO/honCupFrDZ7nNxOrNuVjJAdJR3tOctjojmQNJZrzOtwXi8e+wHvGbtC921Pw37
 RG8kvvmppEekqei1Qe1O7zK2gJcdpq9NNOfgEzBGWRwBFjGER7uJSy7STLC+/Pg3ZRRBLuHrRJH
 WZBOHgk+EfsUUHR52dGDId3nZ8ASvxeA/713um1q4ivrB1yCt9CW8XRh9JMkzHm4qdFMhWBgEq3
 JXwnilWBlkKxHJh17bbuHlZ8T3fVFiR1t69FGM8RY9wwBe9MhcYlhzzI55OT1f+9NpbY6yZ1EwF
 QBdkbwBbabqGecytpfbdxooVH0uqhNHSCuUIg1IhOofE6Jhs+0E=
X-Received: by 2002:a05:600c:19d2:b0:496:bbce:fc with SMTP id
 5b1f17b1804b1-4994e7c10c6mr452032895e9.12.1786264450835; 
 Sun, 09 Aug 2026 01:34:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995919df87sm231418275e9.6.2026.08.09.01.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 01:34:10 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 9 Aug 2026 08:34:09 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I4920318ac537064508eee3ca449d48de76c2ea5d
X-Gerrit-Change-Number: 1582
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1582?usp=email>
X-Gerrit-Commit: 1219685ad8eda403d1b9afcf630f3c8b09f2c347
In-Reply-To: <gerrit.1773842036000.I4920318ac537064508eee3ca449d48de76c2ea5d@gerrit.openvpn.net>
References: <gerrit.1773842036000.I4920318ac537064508eee3ca449d48de76c2ea5d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczODQyMDM2MDAwLkk0OTIwMzE4YWM1MzcwNjQ1MDhlZWUzY2E0NDlkNDhkZTc2YzJlYTVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <86ba9a4f869dcb27ea8c661d252688e92e41ad11-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsyz4-0001FI-2j
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove
 --with-mem-check=dmalloc
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3402479193285002167=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3402479193285002167==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rVERIP/b4x0="; charset=UTF-8

--rVERIP/b4x0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1582?usp=3Demail )

Change subject: Remove --with-mem-check=3Ddmalloc
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove --with=
-mem-check=3Ddmalloc

This code hasn't compiled for years and noone complai=
ned=2E
We generally use ASAN instead=2E

So remove the dead code=2E

v2: Th=
e first version of this change tried to fix the
    code=2E v2 instead remo=
ves it=2E

Change-Id: I4920318ac537064508eee3ca449d48de76c2ea5d
Signed-off-=
by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1582
Message-Id: <20260807131539=2E53877-1-frank@lichtenheld=2Ecom>
UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg38208=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
=
M CMakeLists=2Etxt
M config=2Eh=2Ecmake=2Ein
M configure=2Eac
M src/openvpn=
/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/crypto_backend=2Eh
M src=
/openvpn/crypto_mbedtls_legacy=2Ec
M src/openvpn/crypto_openssl=2Ec
M src/o=
penvpn/init=2Ec
M src/openvpn/memdbg=2Eh
10 files changed, 5 insertions(+),=
 225 deletions(-)




diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
inde=
x aabbcb6=2E=2E643dec6 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt=

@@ -260,7 +260,6 @@
 
 check_include_files(arpa/inet=2Eh HAVE_ARPA_INET_H)=

 check_include_files(dlfcn=2Eh HAVE_DLFCN_H)
-check_include_files(dmalloc=
=2Eh HAVE_DMALLOC_H)
 check_include_files(fcntl=2Eh HAVE_FCNTL_H)
 check_in=
clude_files(err=2Eh HAVE_ERR_H)
 check_include_files(netdb=2Eh HAVE_NETDB_H=
)
diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index 34f2=
89d=2E=2Ec3bb5a5 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecm=
ake=2Ein
@@ -96,9 +96,6 @@
 /* Define to 1 if you have the <dlfcn=2Eh> head=
er file=2E */
 #cmakedefine HAVE_DLFCN_H
 
-/* Define to 1 if you have the =
<dmalloc=2Eh> header file=2E */
-#cmakedefine HAVE_DMALLOC_H
-
 /* Define t=
o 1 if you have the `dup' function=2E */
 #cmakedefine HAVE_DUP
 
diff --gi=
t a/configure=2Eac b/configure=2Eac
index 1aec805=2E=2E469a475 100644
--- a=
/configure=2Eac
+++ b/configure=2Eac
@@ -245,10 +245,10 @@
 
 AC_ARG_WITH(
=
 	[mem-check],
-	[AS_HELP_STRING([--with-mem-check=3DTYPE], [build with deb=
ug memory checking, TYPE=3Dno|dmalloc|valgrind|ssl @<:@default=3Dno@:>@])],=

+	[AS_HELP_STRING([--with-mem-check=3DTYPE], [build with debug memory chec=
king, TYPE=3Dno|valgrind|ssl @<:@default=3Dno@:>@])],
 	[
 		case "${withva=
l}" in
-			dmalloc|valgrind|ssl|no) ;;
+			valgrind|ssl|no) ;;
 			*) AC_MS=
G_ERROR([bad value ${withval} for --mem-check]) ;;
 		esac
 	],
@@ -652,25 =
+652,6 @@
 			[AC_MSG_ERROR([valgrind headers not found=2E])]
 		)
 		;;
-	=
dmalloc)
-		AC_CHECK_HEADERS(
-			[dmalloc=2Eh],
-			[AC_CHECK_LIB(
-				[d=
malloc],
-				[malloc],
-				[
-					LIBS=3D"${LIBS} -ldmalloc"
-					AC_DE=
FINE(
-						[DMALLOC],
-						[1],
-						[Use dmalloc memory debugging li=
brary]
-					)
-				],
-				[AC_MSG_ERROR([dmalloc library not found=2E])]
=
-			)],
-			[AC_MSG_ERROR([dmalloc headers not found=2E])]
-		)
-		;;
 	ssl=
)
 		AC_CHECK_LIB(
 			[ssl],
diff --git a/src/openvpn/buffer=2Ec b/src/ope=
nvpn/buffer=2Ec
index 922238d=2E=2Ef14caa2 100644
--- a/src/openvpn/buffer=
=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -57,11 +57,7 @@
 }
 
 struct buffer
-#=
ifdef DMALLOC
-alloc_buf_debug(size_t size, const char *file, int line)
-#e=
lse
 alloc_buf(size_t size)
-#endif
 {
     struct buffer buf;
     CLEAR(b=
uf);
@@ -71,22 +67,14 @@
         buf_size_error(size);
     }
     buf=2Ec=
apacity =3D (int)size;
-#ifdef DMALLOC
-    buf=2Edata =3D openvpn_dmalloc(=
file, line, size);
-#else
     buf=2Edata =3D calloc(1, size);
-#endif
    =
 check_malloc_return(buf=2Edata);
 
     return buf;
 }
 
 struct buffer
-#=
ifdef DMALLOC
-alloc_buf_gc_debug(size_t size, struct gc_arena *gc, const c=
har *file, int line)
-#else
 alloc_buf_gc(size_t size, struct gc_arena *gc)=

-#endif
 {
     struct buffer buf;
     CLEAR(buf);
@@ -96,11 +84,7 @@
   =
      buf_size_error(size);
     }
     buf=2Ecapacity =3D (int)size;
-#ifd=
ef DMALLOC
-    buf=2Edata =3D (uint8_t *)gc_malloc_debug(size, false, gc, =
file, line);
-#else
     buf=2Edata =3D (uint8_t *)gc_malloc(size, false, g=
c);
-#endif
     if (size)
     {
         *buf=2Edata =3D 0;
@@ -109,7 +93=
,7 @@
 }
 
 struct buffer
-#ifdef DMALLOC
+#ifdef BUF_INIT_TRACKING
 clone_=
buf_debug(const struct buffer *buf, const char *file, int line)
 #else
 clo=
ne_buf(const struct buffer *buf)
@@ -123,11 +107,7 @@
     ret=2Edebug_file=
 =3D buf->debug_file;
     ret=2Edebug_line =3D buf->debug_line;
 #endif
-#=
ifdef DMALLOC
-    ret=2Edata =3D (uint8_t *)openvpn_dmalloc(file, line, bu=
f->capacity);
-#else
     ret=2Edata =3D (uint8_t *)malloc(buf->capacity);
=
-#endif
     check_malloc_return(ret=2Edata);
     memcpy(BPTR(&ret), BPTR(=
buf), BLENZ(buf));
     return ret;
@@ -335,21 +315,13 @@
  */
 
 void *
-#=
ifdef DMALLOC
-gc_malloc_debug(size_t size, bool clear, struct gc_arena *a,=
 const char *file, int line)
-#else
 gc_malloc(size_t size, bool clear, str=
uct gc_arena *a)
-#endif
 {
     void *ret;
     if (a)
     {
         str=
uct gc_entry *e;
-#ifdef DMALLOC
-        e =3D (struct gc_entry *)openvpn_=
dmalloc(file, line, size + sizeof(struct gc_entry));
-#else
         e =3D =
(struct gc_entry *)malloc(size + sizeof(struct gc_entry));
-#endif
        =
 check_malloc_return(e);
         ret =3D (char *)e + sizeof(struct gc_entr=
y);
         e->next =3D a->list;
@@ -357,11 +329,7 @@
     }
     else
   =
  {
-#ifdef DMALLOC
-        ret =3D openvpn_dmalloc(file, line, size);
-#e=
lse
         ret =3D malloc(size);
-#endif
         check_malloc_return(ret=
);
     }
 #ifndef ZERO_BUFFER_ON_ALLOC
@@ -444,11 +412,7 @@
 {
     ASSERT=
(a);
     struct gc_entry_special *e;
-#ifdef DMALLOC
-    e =3D (struct gc=
_entry_special *)openvpn_dmalloc(file, line, sizeof(struct gc_entry_special=
));
-#else
     e =3D (struct gc_entry_special *)malloc(sizeof(struct gc_en=
try_special));
-#endif
     check_malloc_return(e);
     e->free_fnc =3D fr=
ee_function;
     e->addr =3D addr;
@@ -649,11 +613,7 @@
  * Allocate a str=
ing
  */
 char *
-#ifdef DMALLOC
-string_alloc_debug(const char *str, struc=
t gc_arena *gc, const char *file, int line)
-#else
 string_alloc(const char=
 *str, struct gc_arena *gc)
-#endif
 {
     if (str)
     {
@@ -662,11 +622=
,7 @@
 
         if (gc)
         {
-#ifdef DMALLOC
-            ret =3D (c=
har *)gc_malloc_debug(n, false, gc, file, line);
-#else
             ret =
=3D (char *)gc_malloc(n, false, gc);
-#endif
         }
         else
     =
    {
@@ -674,11 +630,7 @@
              * that the caller cleans up afterw=
ards=2E  This is coherent with the
              * earlier behaviour when g=
c_malloc() would be called with gc =3D=3D NULL
              */
-#ifdef DMA=
LLOC
-            ret =3D openvpn_dmalloc(file, line, n);
-#else
          =
   ret =3D calloc(1, n);
-#endif
             check_malloc_return(ret);
   =
      }
         memcpy(ret, str, n);
@@ -752,21 +704,13 @@
  * Allocate a =
string inside a buffer
  */
 struct buffer
-#ifdef DMALLOC
-string_alloc_bu=
f_debug(const char *str, struct gc_arena *gc, const char *file, int line)
-=
#else
 string_alloc_buf(const char *str, struct gc_arena *gc)
-#endif
 {
  =
   struct buffer buf;
 
     ASSERT(str);
 
-#ifdef DMALLOC
-    buf_set_re=
ad(&buf, (uint8_t *)string_alloc_debug(str, gc, file, line), strlen(str) + =
1);
-#else
     buf_set_read(&buf, (uint8_t *)string_alloc(str, gc), strlen=
(str) + 1);
-#endif
 
     if (buf=2Elen > 0) /* Don't count trailing '\0' =
as part of length */
     {
diff --git a/src/openvpn/buffer=2Eh b/src/openv=
pn/buffer=2Eh
index 797bd08=2E=2E743c3f4 100644
--- a/src/openvpn/buffer=2E=
h
+++ b/src/openvpn/buffer=2Eh
@@ -147,32 +147,6 @@
 
 void buf_size_error(=
const size_t size);
 
-/* for dmalloc debugging */
-
-#ifdef DMALLOC
-
-#de=
fine alloc_buf(size)               alloc_buf_debug(size, __FILE__, __LINE__=
)
-#define alloc_buf_gc(size, gc)        alloc_buf_gc_debug(size, gc, __FIL=
E__, __LINE__);
-#define clone_buf(buf)                clone_buf_debug(buf,=
 __FILE__, __LINE__);
-#define gc_malloc(size, clear, arena) gc_malloc_debu=
g(size, clear, arena, __FILE__, __LINE__)
-#define string_alloc(str, gc)   =
      string_alloc_debug(str, gc, __FILE__, __LINE__)
-#define string_alloc=
_buf(str, gc)     string_alloc_buf_debug(str, gc, __FILE__, __LINE__)
-
-st=
ruct buffer alloc_buf_debug(size_t size, const char *file, int line);
-
-st=
ruct buffer alloc_buf_gc_debug(size_t size, struct gc_arena *gc, const char=
 *file, int line);
-
-struct buffer clone_buf_debug(const struct buffer *bu=
f, const char *file, int line);
-
-void *gc_malloc_debug(size_t size, bool =
clear, struct gc_arena *a, const char *file, int line);
-
-char *string_all=
oc_debug(const char *str, struct gc_arena *gc, const char *file, int line);=

-
-struct buffer string_alloc_buf_debug(const char *str, struct gc_arena *=
gc, const char *file,
-                                     int line);
-
-#=
else  /* ifdef DMALLOC */
-
 struct buffer alloc_buf(size_t size);
 
 struc=
t buffer alloc_buf_gc(size_t size,
@@ -186,8 +160,6 @@
 
 struct buffer str=
ing_alloc_buf(const char *str, struct gc_arena *gc);
 
-#endif /* ifdef DMA=
LLOC */
-
 void gc_addspecial(void *addr, void (*free_function)(void *), st=
ruct gc_arena *a);
 
 /**
diff --git a/src/openvpn/crypto_backend=2Eh b/src=
/openvpn/crypto_backend=2Eh
index b602ba1=2E=2E17085d6 100644
--- a/src/ope=
nvpn/crypto_backend=2Eh
+++ b/src/openvpn/crypto_backend=2Eh
@@ -102,16 +10=
2,6 @@
  */
 void crypto_unload_provider(const char *provname, provider_t *=
provider);
 
-#ifdef DMALLOC
-/*
- * OpenSSL memory debugging=2E  If dmallo=
c debugging is enabled, tell
- * OpenSSL to use our private malloc/realloc/=
free functions so that
- * we can dispatch them to dmalloc=2E
- */
-void cr=
ypto_init_dmalloc(void);
-
-#endif /* DMALLOC */
-
 void show_available_cip=
hers(void);
 
 void show_available_digests(void);
diff --git a/src/openvpn/=
crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec
index deb=
d53d=2E=2E9e47c26 100644
--- a/src/openvpn/crypto_mbedtls_legacy=2Ec
+++ b/=
src/openvpn/crypto_mbedtls_legacy=2Ec
@@ -139,14 +139,6 @@
 }
 
 
-#ifdef D=
MALLOC
-void
-crypto_init_dmalloc(void)
-{
-    msg(M_ERR, "Error: dmalloc =
support is not available for mbed TLS=2E");
-}
-#endif /* DMALLOC */
-
 con=
st cipher_name_pair cipher_name_translation_table[] =3D {
     { "BF-CBC", =
"BLOWFISH-CBC" },
     { "BF-CFB", "BLOWFISH-CFB64" },
diff --git a/src/ope=
nvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec
index fa9eb67=2E=
=2E1191f20 100644
--- a/src/openvpn/crypto_openssl=2Ec
+++ b/src/openvpn/cr=
ypto_openssl=2Ec
@@ -39,6 +39,7 @@
 #include "integer=2Eh"
 #include "crypt=
o=2Eh"
 #include "crypto_backend=2Eh"
+#include "memdbg=2Eh"
 #include "ope=
nssl_compat=2Eh"
 
 #include <openssl/conf=2Eh>
@@ -273,40 +274,6 @@
 }
 
 =

-/*
- *
- * OpenSSL memory debugging=2E  If dmalloc debugging is enabled, =
tell
- * OpenSSL to use our private malloc/realloc/free functions so that
-=
 * we can dispatch them to dmalloc=2E
- *
- */
-
-#ifdef DMALLOC
-static vo=
id *
-crypto_malloc(size_t size, const char *file, int line)
-{
-    return=
 dmalloc_malloc(file, line, size, DMALLOC_FUNC_MALLOC, 0, 0);
-}
-
-static =
void *
-crypto_realloc(void *ptr, size_t size, const char *file, int line)
=
-{
-    return dmalloc_realloc(file, line, ptr, size, DMALLOC_FUNC_REALLOC,=
 0);
-}
-
-static void
-crypto_free(void *ptr)
-{
-    dmalloc_free(__FILE_=
_, __LINE__, ptr, DMALLOC_FUNC_FREE);
-}
-
-void
-crypto_init_dmalloc(void)=

-{
-    CRYPTO_set_mem_ex_functions(crypto_malloc, crypto_realloc, crypto_=
free);
-}
-#endif /* DMALLOC */
-
 const cipher_name_pair cipher_name_trans=
lation_table[] =3D {
     { "AES-128-GCM", "id-aes128-GCM" },
     { "AES-1=
92-GCM", "id-aes192-GCM" },
diff --git a/src/openvpn/init=2Ec b/src/openvpn=
/init=2Ec
index 906a83c=2E=2E69d226d 100644
--- a/src/openvpn/init=2Ec
+++ =
b/src/openvpn/init=2Ec
@@ -838,11 +838,6 @@
 bool
 init_static(void)
 {
-#i=
f defined(DMALLOC)
-    crypto_init_dmalloc();
-#endif
-
-
     /*
      * =
Initialize random number seed=2E  random() is only used
      * when "weak"=
 random numbers are acceptable=2E
diff --git a/src/openvpn/memdbg=2Eh b/src=
/openvpn/memdbg=2Eh
index ea620c2=2E=2E1f94582 100644
--- a/src/openvpn/mem=
dbg=2Eh
+++ b/src/openvpn/memdbg=2Eh
@@ -43,67 +43,10 @@
  */
 
 #ifdef USE=
_VALGRIND
-
 #include <valgrind/memcheck=2Eh>
-
-#define VALGRIND_MAKE_READ=
ABLE(addr, len)
-
-#else /* ifdef USE_VALGRIND */
-
-#define VALGRIND_MAKE_=
READABLE(addr, len)
-
 #endif
 
-#ifdef DMALLOC /* see =2E/configure option=
s to enable */
-
-/*
- * See =2E/configure options to enable dmalloc
- * su=
pport for memory leak checking=2E
- *
- * The dmalloc package can be downlo=
aded from:
- *
- *     https://dmalloc=2Ecom/
- *
- * When dmalloc is insta=
lled and enabled,
- * use this command prior to running openvpn:
- *
- *   =
 dmalloc -l dlog -i 100 low -p log-unknown
- *
- * Also, put this in your =
=2Ebashrc file:
- *
- *    function dmalloc { eval `command dmalloc -b $*`;=
 }
- *
- * Or take a more low-level approach:
- *
- *    export DMALLOC_OPT=
IONS=3D"debug=3D0x4e48503,inter=3D100,log=3Ddlog"
- *
- *  NOTE: When build=
ing dmalloc you need to add something
- *  like this to dmalloc's settings=
=2Eh -- it will allocate a static
- *  buffer to be used as the malloc aren=
a:
- *
- *  #define INTERNAL_MEMORY_SPACE (1024 * 1024 * 50)
- */
-
-#inclu=
de <dmalloc=2Eh>
-
-#define openvpn_dmalloc(file, line, size) \
-    dmallo=
c_malloc((file), (line), (size), DMALLOC_FUNC_MALLOC, 0, 0)
-
-/*
- * This =
#define will put the line number of the log
- * file position where leaked =
memory was allocated instead
- * of the source code file and line number=2E=
  Make sure
- * to increase the size of dmalloc's info tables,
- * (MEMORY_=
TABLE_SIZE in settings=2Eh)
- * otherwise it might get overwhelmed by the l=
arge
- * number of unique file/line combinations=2E
- */
-#if 0
-#undef mal=
loc
-#define malloc(size) openvpn_dmalloc("logfile", x_msg_line_num, (size)=
)
-#endif
-
-#endif /* DMALLOC */
+#define VALGRIND_MAKE_READABLE(addr, len=
)
 
 /*
  * Force buffers to be zeroed after allocation=2E

-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1582?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I4920318ac537064508eee3ca449d48de76c2e=
a5d
Gerrit-Change-Number: 1582
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=


--rVERIP/b4x0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1582?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Remove --with-mem-check=3Ddmalloc<br><br>T=
his code hasn&#39;t compiled for years and noone complained=2E<br>We genera=
lly use ASAN instead=2E<br><br>So remove the dead code=2E<br><br>v2: The fi=
rst version of this change tried to fix the<br>    code=2E v2 instead remov=
es it=2E<br><br>Change-Id: I4920318ac537064508eee3ca449d48de76c2ea5d<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1582<br>Message-Id: &lt;20260807131539=2E538=
77-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg38208=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>=
M config=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M src/openvpn/buffer=2Ec<b=
r>M src/openvpn/buffer=2Eh<br>M src/openvpn/crypto_backend=2Eh<br>M src/ope=
nvpn/crypto_mbedtls_legacy=2Ec<br>M src/openvpn/crypto_openssl=2Ec<br>M src=
/openvpn/init=2Ec<br>M src/openvpn/memdbg=2Eh<br>10 files changed, 5 insert=
ions(+), 225 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/=
CMakeLists=2Etxt</span><br><span>index aabbcb6=2E=2E643dec6 100644</span><b=
r><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span=
><br><span>@@ -260,7 +260,6 @@</span><br><span> </span><br><span> check_inc=
lude_files(arpa/inet=2Eh HAVE_ARPA_INET_H)</span><br><span> check_include_f=
iles(dlfcn=2Eh HAVE_DLFCN_H)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-check_include_files(dmalloc=2Eh HAVE_DMALLOC_H)</span><br><span> che=
ck_include_files(fcntl=2Eh HAVE_FCNTL_H)</span><br><span> check_include_fil=
es(err=2Eh HAVE_ERR_H)</span><br><span> check_include_files(netdb=2Eh HAVE_=
NETDB_H)</span><br><span>diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=
=2Ecmake=2Ein</span><br><span>index 34f289d=2E=2Ec3bb5a5 100644</span><br><=
span>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=
=2Ein</span><br><span>@@ -96,9 +96,6 @@</span><br><span> /* Define to 1 if =
you have the &lt;dlfcn=2Eh&gt; header file=2E */</span><br><span> #cmakedef=
ine HAVE_DLFCN_H</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-/* Define to 1 if you have the &lt;dmalloc=2Eh&gt; header file=
=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#cmakedefine HA=
VE_DMALLOC_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> /* Define to 1 if you have the `dup&#39; function=2E */</span><br>=
<span> #cmakedefine HAVE_DUP</span><br><span> </span><br><span>diff --git a=
/configure=2Eac b/configure=2Eac</span><br><span>index 1aec805=2E=2E469a475=
 100644</span><br><span>--- a/configure=2Eac</span><br><span>+++ b/configur=
e=2Eac</span><br><span>@@ -245,10 +245,10 @@</span><br><span> </span><br><s=
pan> AC_ARG_WITH(</span><br><span> 	[mem-check],</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	[AS_HELP_STRING([--with-mem-check=3DTYPE], [bui=
ld with debug memory checking, TYPE=3Dno|dmalloc|valgrind|ssl @&lt;:@defaul=
t=3Dno@:&gt;@])],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	[=
AS_HELP_STRING([--with-mem-check=3DTYPE], [build with debug memory checking=
, TYPE=3Dno|valgrind|ssl @&lt;:@default=3Dno@:&gt;@])],</span><br><span> 	[=
</span><br><span> 		case &quot;${withval}&quot; in</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-			dmalloc|valgrind|ssl|no) ;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+			valgrind|ssl|no) ;;</span><br><s=
pan> 			*) AC_MSG_ERROR([bad value ${withval} for --mem-check]) ;;</span><b=
r><span> 		esac</span><br><span> 	],</span><br><span>@@ -652,25 +652,6 @@</=
span><br><span> 			[AC_MSG_ERROR([valgrind headers not found=2E])]</span><b=
r><span> 		)</span><br><span> 		;;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	dmalloc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-		AC_CHECK_HEADERS(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
		[dmalloc=2Eh],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			[A=
C_CHECK_LIB(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-				[dmal=
loc],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-				[malloc],</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-				[</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-					LIBS=3D&quot;${LIBS} -ldmalloc&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-					AC_DEFINE(</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-						[DMALLOC],</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-						[1],</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-						[Use dmalloc memory debugging librar=
y]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-					)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-				],</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-				[AC_MSG_ERROR([dmalloc library not found=2E])=
]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			)],</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-			[AC_MSG_ERROR([dmalloc headers n=
ot found=2E])]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-		;;</span><br><span> 	ss=
l)</span><br><span> 		AC_CHECK_LIB(</span><br><span> 			[ssl],</span><br><s=
pan>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br>=
<span>index 922238d=2E=2Ef14caa2 100644</span><br><span>--- a/src/openvpn/b=
uffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -=
57,11 +57,7 @@</span><br><span> }</span><br><span> </span><br><span> struct=
 buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-alloc_buf_debug(size_=
t size, const char *file, int line)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#else</span><br><span> alloc_buf(size_t size)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> {</span><br><=
span>     struct buffer buf;</span><br><span>     CLEAR(buf);</span><br><sp=
an>@@ -71,22 +67,14 @@</span><br><span>         buf_size_error(size);</span=
><br><span>     }</span><br><span>     buf=2Ecapacity =3D (int)size;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    buf=2Edata =3D openvpn_dmalloc(=
file, line, size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#el=
se</span><br><span>     buf=2Edata =3D calloc(1, size);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     check_malloc_=
return(buf=2Edata);</span><br><span> </span><br><span>     return buf;</spa=
n><br><span> }</span><br><span> </span><br><span> struct buffer</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-alloc_buf_gc_debug(size_t size, struct g=
c_arena *gc, const char *file, int line)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#else</span><br><span> alloc_buf_gc(size_t size, struct =
gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span> {</span><br><span>     struct buffer buf;</span><br><span> =
    CLEAR(buf);</span><br><span>@@ -96,11 +84,7 @@</span><br><span>        =
 buf_size_error(size);</span><br><span>     }</span><br><span>     buf=2Eca=
pacity =3D (int)size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#ifdef DMALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf=
=2Edata =3D (uint8_t *)gc_malloc_debug(size, false, gc, file, line);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span>     b=
uf=2Edata =3D (uint8_t *)gc_malloc(size, false, gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     if (size)</span=
><br><span>     {</span><br><span>         *buf=2Edata =3D 0;</span><br><sp=
an>@@ -109,7 +93,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 struct buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef =
DMALLOC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef BUF_I=
NIT_TRACKING</span><br><span> clone_buf_debug(const struct buffer *buf, con=
st char *file, int line)</span><br><span> #else</span><br><span> clone_buf(=
const struct buffer *buf)</span><br><span>@@ -123,11 +107,7 @@</span><br><s=
pan>     ret=2Edebug_file =3D buf-&gt;debug_file;</span><br><span>     ret=
=2Edebug_line =3D buf-&gt;debug_line;</span><br><span> #endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    ret=2Edata =3D (uint8_t *)openvpn_dmal=
loc(file, line, buf-&gt;capacity);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#else</span><br><span>     ret=2Edata =3D (uint8_t *)malloc(bu=
f-&gt;capacity);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f</span><br><span>     check_malloc_return(ret=2Edata);</span><br><span>   =
  memcpy(BPTR(&amp;ret), BPTR(buf), BLENZ(buf));</span><br><span>     retur=
n ret;</span><br><span>@@ -335,21 +315,13 @@</span><br><span>  */</span><br=
><span> </span><br><span> void *</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-gc_malloc_debug(size_t size, bool clear, struct gc_arena *a, const char=
 *file, int line)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#els=
e</span><br><span> gc_malloc(size_t size, bool clear, struct gc_arena *a)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>=
 {</span><br><span>     void *ret;</span><br><span>     if (a)</span><br><s=
pan>     {</span><br><span>         struct gc_entry *e;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        e =3D (struct gc_entry *)openvpn_dmalloc=
(file, line, size + sizeof(struct gc_entry));</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#else</span><br><span>         e =3D (struct gc_ent=
ry *)malloc(size + sizeof(struct gc_entry));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif</span><br><span>         check_malloc_return(=
e);</span><br><span>         ret =3D (char *)e + sizeof(struct gc_entry);</=
span><br><span>         e-&gt;next =3D a-&gt;list;</span><br><span>@@ -357,=
11 +329,7 @@</span><br><span>     }</span><br><span>     else</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALL=
OC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret =3D ope=
nvpn_dmalloc(file, line, size);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#else</span><br><span>         ret =3D malloc(size);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>         ch=
eck_malloc_return(ret);</span><br><span>     }</span><br><span> #ifndef ZER=
O_BUFFER_ON_ALLOC</span><br><span>@@ -444,11 +412,7 @@</span><br><span> {</=
span><br><span>     ASSERT(a);</span><br><span>     struct gc_entry_special=
 *e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    e =3D (struct gc_ent=
ry_special *)openvpn_dmalloc(file, line, sizeof(struct gc_entry_special));<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span>=
     e =3D (struct gc_entry_special *)malloc(sizeof(struct gc_entry_special=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><=
span>     check_malloc_return(e);</span><br><span>     e-&gt;free_fnc =3D f=
ree_function;</span><br><span>     e-&gt;addr =3D addr;</span><br><span>@@ =
-649,11 +613,7 @@</span><br><span>  * Allocate a string</span><br><span>  *=
/</span><br><span> char *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#ifdef DMALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-str=
ing_alloc_debug(const char *str, struct gc_arena *gc, const char *file, int=
 line)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br=
><span> string_alloc(const char *str, struct gc_arena *gc)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> {</span><br><s=
pan>     if (str)</span><br><span>     {</span><br><span>@@ -662,11 +622,7 =
@@</span><br><span> </span><br><span>         if (gc)</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret =3D (ch=
ar *)gc_malloc_debug(n, false, gc, file, line);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#else</span><br><span>             ret =3D (char =
*)gc_malloc(n, false, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span>         }</span><br><span>         else</span>=
<br><span>         {</span><br><span>@@ -674,11 +630,7 @@</span><br><span> =
             * that the caller cleans up afterwards=2E  This is coherent wi=
th the</span><br><span>              * earlier behaviour when gc_malloc() w=
ould be called with gc =3D=3D NULL</span><br><span>              */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            ret =3D openvpn_dmalloc(=
file, line, n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else<=
/span><br><span>             ret =3D calloc(1, n);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span>             check_mall=
oc_return(ret);</span><br><span>         }</span><br><span>         memcpy(=
ret, str, n);</span><br><span>@@ -752,21 +704,13 @@</span><br><span>  * All=
ocate a string inside a buffer</span><br><span>  */</span><br><span> struct=
 buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-string_alloc_buf_debu=
g(const char *str, struct gc_arena *gc, const char *file, int line)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span> string=
_alloc_buf(const char *str, struct gc_arena *gc)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif</span><br><span> {</span><br><span>     s=
truct buffer buf;</span><br><span> </span><br><span>     ASSERT(str);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DM=
ALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_set_read=
(&amp;buf, (uint8_t *)string_alloc_debug(str, gc, file, line), strlen(str) =
+ 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br>=
<span>     buf_set_read(&amp;buf, (uint8_t *)string_alloc(str, gc), strlen(=
str) + 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span> </span><br><span>     if (buf=2Elen &gt; 0) /* Don&#39;t count=
 trailing &#39;\0&#39; as part of length */</span><br><span>     {</span><b=
r><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span>=
<br><span>index 797bd08=2E=2E743c3f4 100644</span><br><span>--- a/src/openv=
pn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>=
@@ -147,32 +147,6 @@</span><br><span> </span><br><span> void buf_size_error=
(const size_t size);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/* for dmalloc debugging */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#ifdef DMALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define alloc_buf(size)   =
            alloc_buf_debug(size, __FILE__, __LINE__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define alloc_buf_gc(size, gc)        alloc=
_buf_gc_debug(size, gc, __FILE__, __LINE__);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define clone_buf(buf)                clone_buf_debu=
g(buf, __FILE__, __LINE__);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define gc_malloc(size, clear, arena) gc_malloc_debug(size, clear, ar=
ena, __FILE__, __LINE__)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define string_alloc(str, gc)         string_alloc_debug(str, gc, __FILE=
__, __LINE__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
string_alloc_buf(str, gc)     string_alloc_buf_debug(str, gc, __FILE__, __L=
INE__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-struct buffer alloc_buf_debug(size_t=
 size, const char *file, int line);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct =
buffer alloc_buf_gc_debug(size_t size, struct gc_arena *gc, const char *fil=
e, int line);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-struct buffer clone_buf_debug=
(const struct buffer *buf, const char *file, int line);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void *gc_malloc_debug(size_t size, bool clear, struct gc_arena=
 *a, const char *file, int line);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-char *str=
ing_alloc_debug(const char *str, struct gc_arena *gc, const char *file, int=
 line);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-struct buffer string_alloc_buf_debu=
g(const char *str, struct gc_arena *gc, const char *file,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                                     in=
t line);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#else  /* ifdef DMALLOC */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struct buff=
er alloc_buf(size_t size);</span><br><span> </span><br><span> struct buffer=
 alloc_buf_gc(size_t size,</span><br><span>@@ -186,8 +160,6 @@</span><br><s=
pan> </span><br><span> struct buffer string_alloc_buf(const char *str, stru=
ct gc_arena *gc);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif /* ifdef DMALLOC */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> void gc_addspecial(void *addr, void (*=
free_function)(void *), struct gc_arena *a);</span><br><span> </span><br><s=
pan> /**</span><br><span>diff --git a/src/openvpn/crypto_backend=2Eh b/src/=
openvpn/crypto_backend=2Eh</span><br><span>index b602ba1=2E=2E17085d6 10064=
4</span><br><span>--- a/src/openvpn/crypto_backend=2Eh</span><br><span>+++ =
b/src/openvpn/crypto_backend=2Eh</span><br><span>@@ -102,16 +102,6 @@</span=
><br><span>  */</span><br><span> void crypto_unload_provider(const char *pr=
ovname, provider_t *provider);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * OpenSSL memory debugging=2E  If dmalloc debugging is enabled, tell</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * OpenSSL to use our priv=
ate malloc/realloc/free functions so that</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * we can dispatch them to dmalloc=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-void crypto_init_dmalloc(void);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif /* DMALLOC */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> void show_available_ciphers(void);</span><br><span>=
 </span><br><span> void show_available_digests(void);</span><br><span>diff =
--git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_=
legacy=2Ec</span><br><span>index debd53d=2E=2E9e47c26 100644</span><br><spa=
n>--- a/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>+++ b/src/ope=
nvpn/crypto_mbedtls_legacy=2Ec</span><br><span>@@ -139,14 +139,6 @@</span><=
br><span> }</span><br><span> </span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-crypto_init_dmalloc(void)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_ERR,=
 &quot;Error: dmalloc support is not available for mbed TLS=2E&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif /* DMALLOC */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> const cipher_name_pair cipher=
_name_translation_table[] =3D {</span><br><span>     { &quot;BF-CBC&quot;, =
&quot;BLOWFISH-CBC&quot; },</span><br><span>     { &quot;BF-CFB&quot;, &quo=
t;BLOWFISH-CFB64&quot; },</span><br><span>diff --git a/src/openvpn/crypto_o=
penssl=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><span>index fa9eb67=
=2E=2E1191f20 100644</span><br><span>--- a/src/openvpn/crypto_openssl=2Ec</=
span><br><span>+++ b/src/openvpn/crypto_openssl=2Ec</span><br><span>@@ -39,=
6 +39,7 @@</span><br><span> #include &quot;integer=2Eh&quot;</span><br><spa=
n> #include &quot;crypto=2Eh&quot;</span><br><span> #include &quot;crypto_b=
ackend=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;openssl_compat=
=2Eh&quot;</span><br><span> </span><br><span> #include &lt;openssl/conf=2Eh=
&gt;</span><br><span>@@ -273,40 +274,6 @@</span><br><span> }</span><br><spa=
n> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * OpenSSL memory debugging=2E  If dma=
lloc debugging is enabled, tell</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * OpenSSL to use our private malloc/realloc/free functions so th=
at</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * we can dispatch =
them to dmalloc=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-static void *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-c=
rypto_malloc(size_t size, const char *file, int line)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return dmalloc_malloc(file, line, size, DMALLOC_FUNC_MALLOC=
, 0, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static void *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-crypto_realloc(void *ptr, size_t size, const char *file, int l=
ine)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return dmalloc_realloc(file, line=
, ptr, size, DMALLOC_FUNC_REALLOC, 0);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-crypto_free(void *ptr)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    dmalloc_free(__FILE__, __LINE__, ptr, DMALLOC_FUN=
C_FREE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-crypto_init_dmalloc(void)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CRYPTO_s=
et_mem_ex_functions(crypto_malloc, crypto_realloc, crypto_free);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif /* DMALLOC */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> const cipher_name_pair cipher_name_=
translation_table[] =3D {</span><br><span>     { &quot;AES-128-GCM&quot;, &=
quot;id-aes128-GCM&quot; },</span><br><span>     { &quot;AES-192-GCM&quot;,=
 &quot;id-aes192-GCM&quot; },</span><br><span>diff --git a/src/openvpn/init=
=2Ec b/src/openvpn/init=2Ec</span><br><span>index 906a83c=2E=2E69d226d 1006=
44</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/ope=
nvpn/init=2Ec</span><br><span>@@ -838,11 +838,6 @@</span><br><span> bool</s=
pan><br><span> init_static(void)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(DMALLOC)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    crypto_init_dmalloc();</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span>     /*</span><br><span>      * Initialize random number =
seed=2E  random() is only used</span><br><span>      * when &quot;weak&quot=
; random numbers are acceptable=2E</span><br><span>diff --git a/src/openvpn=
/memdbg=2Eh b/src/openvpn/memdbg=2Eh</span><br><span>index ea620c2=2E=2E1f9=
4582 100644</span><br><span>--- a/src/openvpn/memdbg=2Eh</span><br><span>++=
+ b/src/openvpn/memdbg=2Eh</span><br><span>@@ -43,67 +43,10 @@</span><br><s=
pan>  */</span><br><span> </span><br><span> #ifdef USE_VALGRIND</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #include &lt;va=
lgrind/memcheck=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define VALGRIND_MA=
KE_READABLE(addr, len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else /* ifdef USE_V=
ALGRIND */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define VALGRIND_MAKE_READABLE(a=
ddr, len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#ifdef DMALLOC /* see =2E/configure options to enable */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * See =2E/configure options to enable dmalloc</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * support for memory leak checking=2E</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * The dmalloc package can be downloaded from:</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *     https://dmalloc=2Ecom/</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * When dmalloc is installed and enabled,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * use this command prior to runn=
ing openvpn:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *    dmalloc -l dlog -i 100=
 low -p log-unknown</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Also, put this in =
your =2Ebashrc file:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    function dmall=
oc { eval `command dmalloc -b $*`; }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * O=
r take a more low-level approach:</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    e=
xport DMALLOC_OPTIONS=3D&quot;debug=3D0x4e48503,inter=3D100,log=3Ddlog&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *  NOTE: When building dmalloc you nee=
d to add something</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 like this to dmalloc&#39;s settings=2Eh -- it will allocate a static</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *  buffer to be used as th=
e malloc arena:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  #define INTERNAL_MEMO=
RY_SPACE (1024 * 1024 * 50)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;dmalloc=2Eh&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define openvpn_dmalloc(file, line, size) \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmalloc_malloc((file)=
, (line), (size), DMALLOC_FUNC_MALLOC, 0, 0)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This #define w=
ill put the line number of the log</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * file position where leaked memory was allocated instead</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * of the source code fil=
e and line number=2E  Make sure</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * to increase the size of dmalloc&#39;s info tables,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * (MEMORY_TABLE_SIZE in settings=
=2Eh)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * otherwise it =
might get overwhelmed by the large</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * number of unique file/line combinations=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if 0</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#undef malloc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne malloc(size) openvpn_dmalloc(&quot;logfile&quot;, x_msg_line_num, (size)=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif /* DMALLOC */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define VALGRIND_MAKE_READABLE(addr, len)</span><br><sp=
an> </span><br><span> /*</span><br><span>  * Force buffers to be zeroed aft=
er allocation=2E</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1582?usp=3Demail">change 1582=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1582?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I49203=
18ac537064508eee3ca449d48de76c2ea5d </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1582 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>

</body></html>
--rVERIP/b4x0=--


--===============3402479193285002167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3402479193285002167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3402479193285002167==--

