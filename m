Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B507C5AC7A
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vVhVyolAPkgfjrKbm6nUkaGOPzyiQz4gx2Wb5/RBVyY=; b=SuIny/87JHNJNgkHT/lXnxA9xr
	dKU32Lpkb5T2AZKz9tmMda49sTi4hKyYuRdjbs6MfnJfekoiJp/a9DXyfoiGRVxDpJWVIaWOVSxqN
	bFTCYTZUC+gatjb6VTJrmnLyg8q4LCAsb5efmxNbjOJRvIP0Wma4XgHe9b+IK4fC3W8E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsMMO-0003IQ-SO;
	Fri, 07 Aug 2026 15:19:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsMMN-0003IJ-3g
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:19:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ctRBsHQ/POUdAwqyeaj0WzQQJsF9ECH86mgRlsDEHaY=; b=ZL/9W9M1wkTxEBn53xVCQvjsIA
 yNCuQ/vKN1tCH+TOLjCOx2ntY7wy1PZJsNaWmxXNsEnbyHctBBiQXUNrLVWprIj0dV2PJUi3sAcxL
 B/czCf5QbB+NJfekjSEgWIofc99o7DqsCPbT4BEM4kVQZMGGb7UoqyiCeuvCC/zXbxvw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ctRBsHQ/POUdAwqyeaj0WzQQJsF9ECH86mgRlsDEHaY=; b=X
 qjBVQSf0wi9iVr/UMbUsxIqCpVnn+wdel21MGWPQ73jwkJR8TqMVK9eVlE3lwJFawYebEoTuEPvDD
 TviN45OJgAkHUNjd5Au5gr/fZtQ/cu/5KMQ9ryW/PA2NC8HAC+E3OKMgPonnX4B9ULYn1Y6duQ8na
 mvu3F1GKrfod8/Pk=;
Received: from mail-ej1-f53.google.com ([209.85.218.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsMMO-0002MF-9U for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:19:47 +0000
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c20363107f4so361625466b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786115978; x=1786720778; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ctRBsHQ/POUdAwqyeaj0WzQQJsF9ECH86mgRlsDEHaY=;
 b=HYuZwW0xoo6CPE2OyQiL0mymeK70Ef07cqreHT1mcy0Kur/ej7rU34xMU6wrw3aZ9V
 a1YdFYe0Iz5bNjQpbIQXE+tIPSBL6TQci7hv9QMTspm3oyJBeZ5JPfCow4m26MFUe9n+
 +tl8oJl11xrhK+uo6lRa6uvf3o/WJOoHttcTxscJ6wdqroZaYNvbsGWq/OoFG9HWav67
 LYbmfPDZCW7CiEpW6FEuv080TT6lGFrz8xpJKxFs/8D8IYFct4oaPqNxxrW5fkLOYKyn
 /DKTX38EakquPdxyfXUQtU5/xWI0kxnTtZ89XCP4SJXBAMIDwYys+1Q5i166/jf/mw9h
 r6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786115978; x=1786720778;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ctRBsHQ/POUdAwqyeaj0WzQQJsF9ECH86mgRlsDEHaY=;
 b=I2JTmRW+m4z5vFtXqA+0nijWktq/YRSLgimdmMbS+TmdBgfO6loSlNpC0EPM13sj9H
 /T3jyReE140ru7a0tgb2gLVCLCzzgMoOB/XY2BOjxelJ9RxUOcSdk4GxnhS/AIil7XZl
 52iMhGGk0OME125rHY0rkcjgZLHABxCtvnjvLREfB+QGDyZ2122ivrTXz58LJYUbRGcb
 zeT7imBuTfHwccTP6MdYFSAEqf0jxluAu2ecEO7p/b+0XJt/veKKL3La3fyTG2I+Ua5e
 p2ugVJmPyTX0M5Z/ffvxxjCbE9kgCgbQ2Cgw/XPreflWz2LczDYWSRXqYltGbcHFGO/L
 cDcg==
X-Gm-Message-State: AOJu0YzRL9wfUQo4qilrcnkBQ6toeFuWddDCymvT6NrBITDnt79H1YxM
 nEs/1/iHgsC5NUoYniXbqk16mzzPXtW9X3B/cDKRsnSk856N8HBCgh176UlwI2QISrtkkpjudOb
 Ax0zsG7dXYUjfBNzMZWdp8OlPEiwm0859oWxiqQ3Jw4UmcVgkMMuxDhmcWkapmfHwAEWtSdI7XZ
 uXYvm02A==
X-Gm-Gg: AR+sD10AFHg53zYnMm09bsuhQPkzpaoIoo3lpOE3hD6rlhQmFmUxszLxwazOUMEMJ38
 7Skhm/j4Qh2LpACkxdsxuhSyq0xjwPAeQWC8U47ORpmF846yulTuKiU/pBf11IbRE46b9yHb4GC
 7UDoidzmQ1P9zbC2qlg+iyr5Thkm/C7IWF3gQRe+t9VN9se03XWY322mACEBIBwJ3OimzGkVGN3
 V1GcHY5oe6jMVbUIjToOgG/f3jtC3btZTbLPBo8laYxEhoXNj/9kKSkr3NDsEr8VPrR2ppCa7tF
 bpWKoMlMezmfkDTvN/211RwP3vipEFPnTTGRnVlZp4AaALofpJ6WOnOiJlBIo2Gwz1iKa+2v2lv
 ETPmJ8vYTsF5l794VJoEpg4Y4u1NN3WcPl8bK1+GjSg6sIu9+95FSVFmi/WQC5prl29SDYLmSh8
 DDGUiSxzyx7ikXILTahU7hveBnxxHGCeMt9V6a7kYRzexOQGMSCLLkDN9sStfxCUKCTyoVCuv/o
 voqnKI3HbV1TJlfslZgcWyeByPy93PO4LfvL0Sknyb528PajLbBlzCyThglQR8c9zrl+85C6rV2
 FN2L1/z9uSwCucjYP/Ay0ZtjARc/CPsfEATs4miYZMfkv4luRxQ=
X-Received: by 2002:a05:600c:1c25:b0:499:4e47:eaf2 with SMTP id
 5b1f17b1804b1-4994e79dbf0mr313186705e9.6.1786104846840; 
 Fri, 07 Aug 2026 05:14:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021e7b34sm4923671f8f.19.2026.08.07.05.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 05:14:06 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 7 Aug 2026 12:14:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I4920318ac537064508eee3ca449d48de76c2ea5d
X-Gerrit-Change-Number: 1582
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1582?usp=email>
X-Gerrit-Commit: 64bcf0ad06bbab1f862c749cb3b9947162f67291
In-Reply-To: <gerrit.1773842036000.I4920318ac537064508eee3ca449d48de76c2ea5d@gerrit.openvpn.net>
References: <gerrit.1773842036000.I4920318ac537064508eee3ca449d48de76c2ea5d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczODQyMDM2MDAwLkk0OTIwMzE4YWM1MzcwNjQ1MDhlZWUzY2E0NDlkNDhkZTc2YzJlYTVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1da2bf9bd742001515337346bab029fe758a10a8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsMMO-0002MF-9U
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8395038881426235085=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8395038881426235085==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="crOp4cVjNNA="; charset=UTF-8

--crOp4cVjNNA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello plaisthos, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1582?usp=3Demail

to look at the new patch set (#2)=
=2E


Change subject: Remove --with-mem-check=3Ddmalloc
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove --with-mem-check=3Ddmall=
oc

This code hasn't compiled for years and noone complained=2E
We generall=
y use ASAN instead=2E

So remove the dead code=2E

v2: The first version of=
 this change tried to fix the
    code=2E v2 instead removes it=2E

Change-=
Id: I4920318ac537064508eee3ca449d48de76c2ea5d
Signed-off-by: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
---
M CMakeLists=2Etxt
M config=2Eh=2Ecmake=
=2Ein
M configure=2Eac
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M =
src/openvpn/crypto_backend=2Eh
M src/openvpn/crypto_mbedtls_legacy=2Ec
M sr=
c/openvpn/crypto_openssl=2Ec
M src/openvpn/init=2Ec
M src/openvpn/memdbg=2E=
h
10 files changed, 5 insertions(+), 225 deletions(-)


  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/1582/2

diff --git a/CMa=
keLists=2Etxt b/CMakeLists=2Etxt
index 74c080e=2E=2E6b3b455 100644
--- a/CM=
akeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -260,7 +260,6 @@
 
 check_include_=
files(arpa/inet=2Eh HAVE_ARPA_INET_H)
 check_include_files(dlfcn=2Eh HAVE_D=
LFCN_H)
-check_include_files(dmalloc=2Eh HAVE_DMALLOC_H)
 check_include_fil=
es(fcntl=2Eh HAVE_FCNTL_H)
 check_include_files(err=2Eh HAVE_ERR_H)
 check_=
include_files(netdb=2Eh HAVE_NETDB_H)
diff --git a/config=2Eh=2Ecmake=2Ein =
b/config=2Eh=2Ecmake=2Ein
index 34f289d=2E=2Ec3bb5a5 100644
--- a/config=2E=
h=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -96,9 +96,6 @@
 /* Define t=
o 1 if you have the <dlfcn=2Eh> header file=2E */
 #cmakedefine HAVE_DLFCN_=
H
 
-/* Define to 1 if you have the <dmalloc=2Eh> header file=2E */
-#cmake=
define HAVE_DMALLOC_H
-
 /* Define to 1 if you have the `dup' function=2E *=
/
 #cmakedefine HAVE_DUP
 
diff --git a/configure=2Eac b/configure=2Eac
ind=
ex 1aec805=2E=2E469a475 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@=
 -245,10 +245,10 @@
 
 AC_ARG_WITH(
 	[mem-check],
-	[AS_HELP_STRING([--wit=
h-mem-check=3DTYPE], [build with debug memory checking, TYPE=3Dno|dmalloc|v=
algrind|ssl @<:@default=3Dno@:>@])],
+	[AS_HELP_STRING([--with-mem-check=3D=
TYPE], [build with debug memory checking, TYPE=3Dno|valgrind|ssl @<:@defaul=
t=3Dno@:>@])],
 	[
 		case "${withval}" in
-			dmalloc|valgrind|ssl|no) ;;
=
+			valgrind|ssl|no) ;;
 			*) AC_MSG_ERROR([bad value ${withval} for --mem=
-check]) ;;
 		esac
 	],
@@ -652,25 +652,6 @@
 			[AC_MSG_ERROR([valgrind h=
eaders not found=2E])]
 		)
 		;;
-	dmalloc)
-		AC_CHECK_HEADERS(
-			[dmal=
loc=2Eh],
-			[AC_CHECK_LIB(
-				[dmalloc],
-				[malloc],
-				[
-					LI=
BS=3D"${LIBS} -ldmalloc"
-					AC_DEFINE(
-						[DMALLOC],
-						[1],
-		=
				[Use dmalloc memory debugging library]
-					)
-				],
-				[AC_MSG_ERR=
OR([dmalloc library not found=2E])]
-			)],
-			[AC_MSG_ERROR([dmalloc head=
ers not found=2E])]
-		)
-		;;
 	ssl)
 		AC_CHECK_LIB(
 			[ssl],
diff --gi=
t a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 5f2b233=2E=2E23d7=
14d 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -57=
,11 +57,7 @@
 }
 
 struct buffer
-#ifdef DMALLOC
-alloc_buf_debug(size_t si=
ze, const char *file, int line)
-#else
 alloc_buf(size_t size)
-#endif
 {
 =
    struct buffer buf;
     CLEAR(buf);
@@ -71,22 +67,14 @@
         buf_si=
ze_error(size);
     }
     buf=2Ecapacity =3D (int)size;
-#ifdef DMALLOC
-=
    buf=2Edata =3D openvpn_dmalloc(file, line, size);
-#else
     buf=2Edat=
a =3D calloc(1, size);
-#endif
     check_malloc_return(buf=2Edata);
 
    =
 return buf;
 }
 
 struct buffer
-#ifdef DMALLOC
-alloc_buf_gc_debug(size_t=
 size, struct gc_arena *gc, const char *file, int line)
-#else
 alloc_buf_g=
c(size_t size, struct gc_arena *gc)
-#endif
 {
     struct buffer buf;
    =
 CLEAR(buf);
@@ -96,11 +84,7 @@
         buf_size_error(size);
     }
     =
buf=2Ecapacity =3D (int)size;
-#ifdef DMALLOC
-    buf=2Edata =3D (uint8_t =
*)gc_malloc_debug(size, false, gc, file, line);
-#else
     buf=2Edata =3D =
(uint8_t *)gc_malloc(size, false, gc);
-#endif
     if (size)
     {
      =
   *buf=2Edata =3D 0;
@@ -109,7 +93,7 @@
 }
 
 struct buffer
-#ifdef DMALLO=
C
+#ifdef BUF_INIT_TRACKING
 clone_buf_debug(const struct buffer *buf, cons=
t char *file, int line)
 #else
 clone_buf(const struct buffer *buf)
@@ -123=
,11 +107,7 @@
     ret=2Edebug_file =3D buf->debug_file;
     ret=2Edebug_l=
ine =3D buf->debug_line;
 #endif
-#ifdef DMALLOC
-    ret=2Edata =3D (uint8=
_t *)openvpn_dmalloc(file, line, buf->capacity);
-#else
     ret=2Edata =3D=
 (uint8_t *)malloc(buf->capacity);
-#endif
     check_malloc_return(ret=2Ed=
ata);
     memcpy(BPTR(&ret), BPTR(buf), BLENZ(buf));
     return ret;
@@ -=
335,21 +315,13 @@
  */
 
 void *
-#ifdef DMALLOC
-gc_malloc_debug(size_t si=
ze, bool clear, struct gc_arena *a, const char *file, int line)
-#else
 gc_=
malloc(size_t size, bool clear, struct gc_arena *a)
-#endif
 {
     void *r=
et;
     if (a)
     {
         struct gc_entry *e;
-#ifdef DMALLOC
-      =
  e =3D (struct gc_entry *)openvpn_dmalloc(file, line, size + sizeof(struct=
 gc_entry));
-#else
         e =3D (struct gc_entry *)malloc(size + sizeof(=
struct gc_entry));
-#endif
         check_malloc_return(e);
         ret =
=3D (char *)e + sizeof(struct gc_entry);
         e->next =3D a->list;
@@ -=
357,11 +329,7 @@
     }
     else
     {
-#ifdef DMALLOC
-        ret =3D o=
penvpn_dmalloc(file, line, size);
-#else
         ret =3D malloc(size);
-#e=
ndif
         check_malloc_return(ret);
     }
 #ifndef ZERO_BUFFER_ON_ALLO=
C
@@ -444,11 +412,7 @@
 {
     ASSERT(a);
     struct gc_entry_special *e;
=
-#ifdef DMALLOC
-    e =3D (struct gc_entry_special *)openvpn_dmalloc(file,=
 line, sizeof(struct gc_entry_special));
-#else
     e =3D (struct gc_entry=
_special *)malloc(sizeof(struct gc_entry_special));
-#endif
     check_mall=
oc_return(e);
     e->free_fnc =3D free_function;
     e->addr =3D addr;
@@=
 -647,11 +611,7 @@
  * Allocate a string
  */
 char *
-#ifdef DMALLOC
-stri=
ng_alloc_debug(const char *str, struct gc_arena *gc, const char *file, int =
line)
-#else
 string_alloc(const char *str, struct gc_arena *gc)
-#endif
 {=

     if (str)
     {
@@ -660,11 +620,7 @@
 
         if (gc)
         {
-#=
ifdef DMALLOC
-            ret =3D (char *)gc_malloc_debug(n, false, gc, fi=
le, line);
-#else
             ret =3D (char *)gc_malloc(n, false, gc);
-#e=
ndif
         }
         else
         {
@@ -672,11 +628,7 @@
             =
 * that the caller cleans up afterwards=2E  This is coherent with the
     =
         * earlier behaviour when gc_malloc() would be called with gc =3D=
=3D NULL
              */
-#ifdef DMALLOC
-            ret =3D openvpn_dmal=
loc(file, line, n);
-#else
             ret =3D calloc(1, n);
-#endif
     =
        check_malloc_return(ret);
         }
         memcpy(ret, str, n);
=
@@ -750,21 +702,13 @@
  * Allocate a string inside a buffer
  */
 struct bu=
ffer
-#ifdef DMALLOC
-string_alloc_buf_debug(const char *str, struct gc_are=
na *gc, const char *file, int line)
-#else
 string_alloc_buf(const char *st=
r, struct gc_arena *gc)
-#endif
 {
     struct buffer buf;
 
     ASSERT(st=
r);
 
-#ifdef DMALLOC
-    buf_set_read(&buf, (uint8_t *)string_alloc_debug=
(str, gc, file, line), strlen(str) + 1);
-#else
     buf_set_read(&buf, (ui=
nt8_t *)string_alloc(str, gc), strlen(str) + 1);
-#endif
 
     if (buf=2El=
en > 0) /* Don't count trailing '\0' as part of length */
     {
diff --git=
 a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 1db9367=2E=2E22e04=
5c 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -147=
,32 +147,6 @@
 
 void buf_size_error(const size_t size);
 
-/* for dmalloc =
debugging */
-
-#ifdef DMALLOC
-
-#define alloc_buf(size)               all=
oc_buf_debug(size, __FILE__, __LINE__)
-#define alloc_buf_gc(size, gc)     =
   alloc_buf_gc_debug(size, gc, __FILE__, __LINE__);
-#define clone_buf(buf=
)                clone_buf_debug(buf, __FILE__, __LINE__);
-#define gc_mall=
oc(size, clear, arena) gc_malloc_debug(size, clear, arena, __FILE__, __LINE=
__)
-#define string_alloc(str, gc)         string_alloc_debug(str, gc, __FI=
LE__, __LINE__)
-#define string_alloc_buf(str, gc)     string_alloc_buf_deb=
ug(str, gc, __FILE__, __LINE__)
-
-struct buffer alloc_buf_debug(size_t siz=
e, const char *file, int line);
-
-struct buffer alloc_buf_gc_debug(size_t =
size, struct gc_arena *gc, const char *file, int line);
-
-struct buffer cl=
one_buf_debug(const struct buffer *buf, const char *file, int line);
-
-voi=
d *gc_malloc_debug(size_t size, bool clear, struct gc_arena *a, const char =
*file, int line);
-
-char *string_alloc_debug(const char *str, struct gc_ar=
ena *gc, const char *file, int line);
-
-struct buffer string_alloc_buf_deb=
ug(const char *str, struct gc_arena *gc, const char *file,
-               =
                      int line);
-
-#else  /* ifdef DMALLOC */
-
 struct bu=
ffer alloc_buf(size_t size);
 
 struct buffer alloc_buf_gc(size_t size,
@@ =
-186,8 +160,6 @@
 
 struct buffer string_alloc_buf(const char *str, struct =
gc_arena *gc);
 
-#endif /* ifdef DMALLOC */
-
 void gc_addspecial(void *ad=
dr, void (*free_function)(void *), struct gc_arena *a);
 
 /**
diff --git a=
/src/openvpn/crypto_backend=2Eh b/src/openvpn/crypto_backend=2Eh
index b602=
ba1=2E=2E17085d6 100644
--- a/src/openvpn/crypto_backend=2Eh
+++ b/src/open=
vpn/crypto_backend=2Eh
@@ -102,16 +102,6 @@
  */
 void crypto_unload_provid=
er(const char *provname, provider_t *provider);
 
-#ifdef DMALLOC
-/*
- * O=
penSSL memory debugging=2E  If dmalloc debugging is enabled, tell
- * OpenS=
SL to use our private malloc/realloc/free functions so that
- * we can disp=
atch them to dmalloc=2E
- */
-void crypto_init_dmalloc(void);
-
-#endif /* =
DMALLOC */
-
 void show_available_ciphers(void);
 
 void show_available_dig=
ests(void);
diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvp=
n/crypto_mbedtls_legacy=2Ec
index debd53d=2E=2E9e47c26 100644
--- a/src/ope=
nvpn/crypto_mbedtls_legacy=2Ec
+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec
=
@@ -139,14 +139,6 @@
 }
 
 
-#ifdef DMALLOC
-void
-crypto_init_dmalloc(void=
)
-{
-    msg(M_ERR, "Error: dmalloc support is not available for mbed TLS=
=2E");
-}
-#endif /* DMALLOC */
-
 const cipher_name_pair cipher_name_trans=
lation_table[] =3D {
     { "BF-CBC", "BLOWFISH-CBC" },
     { "BF-CFB", "B=
LOWFISH-CFB64" },
diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn=
/crypto_openssl=2Ec
index fa9eb67=2E=2E1191f20 100644
--- a/src/openvpn/cry=
pto_openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -39,6 +39,7 @@
 #in=
clude "integer=2Eh"
 #include "crypto=2Eh"
 #include "crypto_backend=2Eh"
+=
#include "memdbg=2Eh"
 #include "openssl_compat=2Eh"
 
 #include <openssl/c=
onf=2Eh>
@@ -273,40 +274,6 @@
 }
 
 
-/*
- *
- * OpenSSL memory debugging=
=2E  If dmalloc debugging is enabled, tell
- * OpenSSL to use our private m=
alloc/realloc/free functions so that
- * we can dispatch them to dmalloc=2E=

- *
- */
-
-#ifdef DMALLOC
-static void *
-crypto_malloc(size_t size, cons=
t char *file, int line)
-{
-    return dmalloc_malloc(file, line, size, DMA=
LLOC_FUNC_MALLOC, 0, 0);
-}
-
-static void *
-crypto_realloc(void *ptr, siz=
e_t size, const char *file, int line)
-{
-    return dmalloc_realloc(file, =
line, ptr, size, DMALLOC_FUNC_REALLOC, 0);
-}
-
-static void
-crypto_free(v=
oid *ptr)
-{
-    dmalloc_free(__FILE__, __LINE__, ptr, DMALLOC_FUNC_FREE);=

-}
-
-void
-crypto_init_dmalloc(void)
-{
-    CRYPTO_set_mem_ex_functions(=
crypto_malloc, crypto_realloc, crypto_free);
-}
-#endif /* DMALLOC */
-
 co=
nst cipher_name_pair cipher_name_translation_table[] =3D {
     { "AES-128-=
GCM", "id-aes128-GCM" },
     { "AES-192-GCM", "id-aes192-GCM" },
diff --gi=
t a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 0236886=2E=2E893670f =
100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -838,11 +83=
8,6 @@
 bool
 init_static(void)
 {
-#if defined(DMALLOC)
-    crypto_init_d=
malloc();
-#endif
-
-
     /*
      * Initialize random number seed=2E  ran=
dom() is only used
      * when "weak" random numbers are acceptable=2E
dif=
f --git a/src/openvpn/memdbg=2Eh b/src/openvpn/memdbg=2Eh
index ea620c2=2E=
=2E1f94582 100644
--- a/src/openvpn/memdbg=2Eh
+++ b/src/openvpn/memdbg=2Eh=

@@ -43,67 +43,10 @@
  */
 
 #ifdef USE_VALGRIND
-
 #include <valgrind/memc=
heck=2Eh>
-
-#define VALGRIND_MAKE_READABLE(addr, len)
-
-#else /* ifdef US=
E_VALGRIND */
-
-#define VALGRIND_MAKE_READABLE(addr, len)
-
 #endif
 
-#if=
def DMALLOC /* see =2E/configure options to enable */
-
-/*
- * See =2E/con=
figure options to enable dmalloc
- * support for memory leak checking=2E
- =
*
- * The dmalloc package can be downloaded from:
- *
- *     https://dmall=
oc=2Ecom/
- *
- * When dmalloc is installed and enabled,
- * use this comma=
nd prior to running openvpn:
- *
- *    dmalloc -l dlog -i 100 low -p log-u=
nknown
- *
- * Also, put this in your =2Ebashrc file:
- *
- *    function d=
malloc { eval `command dmalloc -b $*`; }
- *
- * Or take a more low-level a=
pproach:
- *
- *    export DMALLOC_OPTIONS=3D"debug=3D0x4e48503,inter=3D100=
,log=3Ddlog"
- *
- *  NOTE: When building dmalloc you need to add something=

- *  like this to dmalloc's settings=2Eh -- it will allocate a static
- * =
 buffer to be used as the malloc arena:
- *
- *  #define INTERNAL_MEMORY_SP=
ACE (1024 * 1024 * 50)
- */
-
-#include <dmalloc=2Eh>
-
-#define openvpn_dm=
alloc(file, line, size) \
-    dmalloc_malloc((file), (line), (size), DMALL=
OC_FUNC_MALLOC, 0, 0)
-
-/*
- * This #define will put the line number of th=
e log
- * file position where leaked memory was allocated instead
- * of th=
e source code file and line number=2E  Make sure
- * to increase the size o=
f dmalloc's info tables,
- * (MEMORY_TABLE_SIZE in settings=2Eh)
- * otherw=
ise it might get overwhelmed by the large
- * number of unique file/line co=
mbinations=2E
- */
-#if 0
-#undef malloc
-#define malloc(size) openvpn_dmal=
loc("logfile", x_msg_line_num, (size))
-#endif
-
-#endif /* DMALLOC */
+#de=
fine VALGRIND_MAKE_READABLE(addr, len)
 
 /*
  * Force buffers to be zeroed=
 after allocation=2E

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1582?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I4920318ac537064508eee3ca449d48de76c2ea5d
Gerrit-Change-Number: 1582
Ge=
rrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <=
frank@lichtenheld=2Ecom>

--crOp4cVjNNA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>flichtenheld <strong>uploaded=
 patch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1582?usp=3Demail">View Change</a></p><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>Remove --with-mem-check=3Ddmalloc<br><br>This code hasn&#39;t compiled for=
 years and noone complained=2E<br>We generally use ASAN instead=2E<br><br>S=
o remove the dead code=2E<br><br>v2: The first version of this change tried=
 to fix the<br>    code=2E v2 instead removes it=2E<br><br>Change-Id: I4920=
318ac537064508eee3ca449d48de76c2ea5d<br>Signed-off-by: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M config=2Eh=
=2Ecmake=2Ein<br>M configure=2Eac<br>M src/openvpn/buffer=2Ec<br>M src/open=
vpn/buffer=2Eh<br>M src/openvpn/crypto_backend=2Eh<br>M src/openvpn/crypto_=
mbedtls_legacy=2Ec<br>M src/openvpn/crypto_openssl=2Ec<br>M src/openvpn/ini=
t=2Ec<br>M src/openvpn/memdbg=2Eh<br>10 files changed, 5 insertions(+), 225=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/82/1582/2</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2E=
txt b/CMakeLists=2Etxt</span><br><span>index 74c080e=2E=2E6b3b455 100644</s=
pan><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt=
</span><br><span>@@ -260,7 +260,6 @@</span><br><span> </span><br><span> che=
ck_include_files(arpa/inet=2Eh HAVE_ARPA_INET_H)</span><br><span> check_inc=
lude_files(dlfcn=2Eh HAVE_DLFCN_H)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-check_include_files(dmalloc=2Eh HAVE_DMALLOC_H)</span><br><spa=
n> check_include_files(fcntl=2Eh HAVE_FCNTL_H)</span><br><span> check_inclu=
de_files(err=2Eh HAVE_ERR_H)</span><br><span> check_include_files(netdb=2Eh=
 HAVE_NETDB_H)</span><br><span>diff --git a/config=2Eh=2Ecmake=2Ein b/confi=
g=2Eh=2Ecmake=2Ein</span><br><span>index 34f289d=2E=2Ec3bb5a5 100644</span>=
<br><span>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/config=2Eh=2E=
cmake=2Ein</span><br><span>@@ -96,9 +96,6 @@</span><br><span> /* Define to =
1 if you have the &lt;dlfcn=2Eh&gt; header file=2E */</span><br><span> #cma=
kedefine HAVE_DLFCN_H</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/* Define to 1 if you have the &lt;dmalloc=2Eh&gt; header=
 file=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#cmakedefi=
ne HAVE_DMALLOC_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> /* Define to 1 if you have the `dup&#39; function=2E */</span=
><br><span> #cmakedefine HAVE_DUP</span><br><span> </span><br><span>diff --=
git a/configure=2Eac b/configure=2Eac</span><br><span>index 1aec805=2E=2E46=
9a475 100644</span><br><span>--- a/configure=2Eac</span><br><span>+++ b/con=
figure=2Eac</span><br><span>@@ -245,10 +245,10 @@</span><br><span> </span><=
br><span> AC_ARG_WITH(</span><br><span> 	[mem-check],</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	[AS_HELP_STRING([--with-mem-check=3DTYPE],=
 [build with debug memory checking, TYPE=3Dno|dmalloc|valgrind|ssl @&lt;:@d=
efault=3Dno@:&gt;@])],</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	[AS_HELP_STRING([--with-mem-check=3DTYPE], [build with debug memory che=
cking, TYPE=3Dno|valgrind|ssl @&lt;:@default=3Dno@:&gt;@])],</span><br><spa=
n> 	[</span><br><span> 		case &quot;${withval}&quot; in</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-			dmalloc|valgrind|ssl|no) ;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+			valgrind|ssl|no) ;;</span><=
br><span> 			*) AC_MSG_ERROR([bad value ${withval} for --mem-check]) ;;</sp=
an><br><span> 		esac</span><br><span> 	],</span><br><span>@@ -652,25 +652,6=
 @@</span><br><span> 			[AC_MSG_ERROR([valgrind headers not found=2E])]</sp=
an><br><span> 		)</span><br><span> 		;;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	dmalloc)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-		AC_CHECK_HEADERS(</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-			[dmalloc=2Eh],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
			[AC_CHECK_LIB(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-				=
[dmalloc],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-				[malloc=
],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-				[</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-					LIBS=3D&quot;${LIBS} -ldmalloc=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-					AC_DEFINE(=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-						[DMALLOC],</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-						[1],</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-						[Use dmalloc memory debugging l=
ibrary]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-					)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-				],</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-				[AC_MSG_ERROR([dmalloc library not foun=
d=2E])]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			)],</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-			[AC_MSG_ERROR([dmalloc hea=
ders not found=2E])]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
	)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		;;</span><br><spa=
n> 	ssl)</span><br><span> 		AC_CHECK_LIB(</span><br><span> 			[ssl],</span>=
<br><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</spa=
n><br><span>index 5f2b233=2E=2E23d714d 100644</span><br><span>--- a/src/ope=
nvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><spa=
n>@@ -57,11 +57,7 @@</span><br><span> }</span><br><span> </span><br><span> =
struct buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef D=
MALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-alloc_buf_debug=
(size_t size, const char *file, int line)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#else</span><br><span> alloc_buf(size_t size)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> {</span=
><br><span>     struct buffer buf;</span><br><span>     CLEAR(buf);</span><=
br><span>@@ -71,22 +67,14 @@</span><br><span>         buf_size_error(size);=
</span><br><span>     }</span><br><span>     buf=2Ecapacity =3D (int)size;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    buf=2Edata =3D openvpn_dm=
alloc(file, line, size);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#else</span><br><span>     buf=2Edata =3D calloc(1, size);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     check_m=
alloc_return(buf=2Edata);</span><br><span> </span><br><span>     return buf=
;</span><br><span> }</span><br><span> </span><br><span> struct buffer</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-alloc_buf_gc_debug(size_t size, st=
ruct gc_arena *gc, const char *file, int line)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#else</span><br><span> alloc_buf_gc(size_t size, s=
truct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span> {</span><br><span>     struct buffer buf;</span><br><=
span>     CLEAR(buf);</span><br><span>@@ -96,11 +84,7 @@</span><br><span>  =
       buf_size_error(size);</span><br><span>     }</span><br><span>     bu=
f=2Ecapacity =3D (int)size;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#ifdef DMALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   buf=2Edata =3D (uint8_t *)gc_malloc_debug(size, false, gc, file, line);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span>=
     buf=2Edata =3D (uint8_t *)gc_malloc(size, false, gc);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     if (size)<=
/span><br><span>     {</span><br><span>         *buf=2Edata =3D 0;</span><b=
r><span>@@ -109,7 +93,7 @@</span><br><span> }</span><br><span> </span><br><=
span> struct buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
fdef DMALLOC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef =
BUF_INIT_TRACKING</span><br><span> clone_buf_debug(const struct buffer *buf=
, const char *file, int line)</span><br><span> #else</span><br><span> clone=
_buf(const struct buffer *buf)</span><br><span>@@ -123,11 +107,7 @@</span><=
br><span>     ret=2Edebug_file =3D buf-&gt;debug_file;</span><br><span>    =
 ret=2Edebug_line =3D buf-&gt;debug_line;</span><br><span> #endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ret=2Edata =3D (uint8_t *)openvpn_=
dmalloc(file, line, buf-&gt;capacity);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#else</span><br><span>     ret=2Edata =3D (uint8_t *)mallo=
c(buf-&gt;capacity);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span>     check_malloc_return(ret=2Edata);</span><br><span=
>     memcpy(BPTR(&amp;ret), BPTR(buf), BLENZ(buf));</span><br><span>     r=
eturn ret;</span><br><span>@@ -335,21 +315,13 @@</span><br><span>  */</span=
><br><span> </span><br><span> void *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-gc_malloc_debug(size_t size, bool clear, struct gc_arena *a, const =
char *file, int line)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#else</span><br><span> gc_malloc(size_t size, bool clear, struct gc_arena *=
a)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan> {</span><br><span>     void *ret;</span><br><span>     if (a)</span><b=
r><span>     {</span><br><span>         struct gc_entry *e;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        e =3D (struct gc_entry *)openvpn_dm=
alloc(file, line, size + sizeof(struct gc_entry));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#else</span><br><span>         e =3D (struct g=
c_entry *)malloc(size + sizeof(struct gc_entry));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span>         check_malloc_re=
turn(e);</span><br><span>         ret =3D (char *)e + sizeof(struct gc_entr=
y);</span><br><span>         e-&gt;next =3D a-&gt;list;</span><br><span>@@ =
-357,11 +329,7 @@</span><br><span>     }</span><br><span>     else</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef =
DMALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret =
=3D openvpn_dmalloc(file, line, size);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#else</span><br><span>         ret =3D malloc(size);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>    =
     check_malloc_return(ret);</span><br><span>     }</span><br><span> #ifn=
def ZERO_BUFFER_ON_ALLOC</span><br><span>@@ -444,11 +412,7 @@</span><br><sp=
an> {</span><br><span>     ASSERT(a);</span><br><span>     struct gc_entry_=
special *e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMA=
LLOC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e =3D (struct=
 gc_entry_special *)openvpn_dmalloc(file, line, sizeof(struct gc_entry_spec=
ial));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br=
><span>     e =3D (struct gc_entry_special *)malloc(sizeof(struct gc_entry_=
special));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span>     check_malloc_return(e);</span><br><span>     e-&gt;free_fn=
c =3D free_function;</span><br><span>     e-&gt;addr =3D addr;</span><br><s=
pan>@@ -647,11 +611,7 @@</span><br><span>  * Allocate a string</span><br><s=
pan>  */</span><br><span> char *</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-string_alloc_debug(const char *str, struct gc_arena *gc, const char *fi=
le, int line)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</s=
pan><br><span> string_alloc(const char *str, struct gc_arena *gc)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> {</span=
><br><span>     if (str)</span><br><span>     {</span><br><span>@@ -660,11 =
+620,7 @@</span><br><span> </span><br><span>         if (gc)</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DM=
ALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret =
=3D (char *)gc_malloc_debug(n, false, gc, file, line);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span>             ret =3D=
 (char *)gc_malloc(n, false, gc);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif</span><br><span>         }</span><br><span>         else=
</span><br><span>         {</span><br><span>@@ -672,11 +628,7 @@</span><br>=
<span>              * that the caller cleans up afterwards=2E  This is cohe=
rent with the</span><br><span>              * earlier behaviour when gc_mal=
loc() would be called with gc =3D=3D NULL</span><br><span>              */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            ret =3D openvpn_d=
malloc(file, line, n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#else</span><br><span>             ret =3D calloc(1, n);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>             che=
ck_malloc_return(ret);</span><br><span>         }</span><br><span>         =
memcpy(ret, str, n);</span><br><span>@@ -750,21 +702,13 @@</span><br><span>=
  * Allocate a string inside a buffer</span><br><span>  */</span><br><span>=
 struct buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef =
DMALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-string_alloc_b=
uf_debug(const char *str, struct gc_arena *gc, const char *file, int line)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span>=
 string_alloc_buf(const char *str, struct gc_arena *gc)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> {</span><br><span=
>     struct buffer buf;</span><br><span> </span><br><span>     ASSERT(str)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
fdef DMALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_s=
et_read(&amp;buf, (uint8_t *)string_alloc_debug(str, gc, file, line), strle=
n(str) + 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</sp=
an><br><span>     buf_set_read(&amp;buf, (uint8_t *)string_alloc(str, gc), =
strlen(str) + 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if</span><br><span> </span><br><span>     if (buf=2Elen &gt; 0) /* Don&#39;=
t count trailing &#39;\0&#39; as part of length */</span><br><span>     {</=
span><br><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh=
</span><br><span>index 1db9367=2E=2E22e045c 100644</span><br><span>--- a/sr=
c/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br=
><span>@@ -147,32 +147,6 @@</span><br><span> </span><br><span> void buf_siz=
e_error(const size_t size);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/* for dmalloc debugging */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define alloc_buf=
(size)               alloc_buf_debug(size, __FILE__, __LINE__)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define alloc_buf_gc(size, gc)    =
    alloc_buf_gc_debug(size, gc, __FILE__, __LINE__);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define clone_buf(buf)                clone=
_buf_debug(buf, __FILE__, __LINE__);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define gc_malloc(size, clear, arena) gc_malloc_debug(size, =
clear, arena, __FILE__, __LINE__)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define string_alloc(str, gc)         string_alloc_debug(str, g=
c, __FILE__, __LINE__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define string_alloc_buf(str, gc)     string_alloc_buf_debug(str, gc, __FI=
LE__, __LINE__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-struct buffer alloc_buf_deb=
ug(size_t size, const char *file, int line);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-struct buffer alloc_buf_gc_debug(size_t size, struct gc_arena *gc, const =
char *file, int line);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct buffer clone_=
buf_debug(const struct buffer *buf, const char *file, int line);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void *gc_malloc_debug(size_t size, bool clear, struct=
 gc_arena *a, const char *file, int line);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
char *string_alloc_debug(const char *str, struct gc_arena *gc, const char *=
file, int line);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-struct buffer string_alloc=
_buf_debug(const char *str, struct gc_arena *gc, const char *file,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
       int line);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* ifdef DMALLOC *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> st=
ruct buffer alloc_buf(size_t size);</span><br><span> </span><br><span> stru=
ct buffer alloc_buf_gc(size_t size,</span><br><span>@@ -186,8 +160,6 @@</sp=
an><br><span> </span><br><span> struct buffer string_alloc_buf(const char *=
str, struct gc_arena *gc);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif /* ifdef DMALLOC */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> void gc_addspecial(void *addr=
, void (*free_function)(void *), struct gc_arena *a);</span><br><span> </sp=
an><br><span> /**</span><br><span>diff --git a/src/openvpn/crypto_backend=
=2Eh b/src/openvpn/crypto_backend=2Eh</span><br><span>index b602ba1=2E=2E17=
085d6 100644</span><br><span>--- a/src/openvpn/crypto_backend=2Eh</span><br=
><span>+++ b/src/openvpn/crypto_backend=2Eh</span><br><span>@@ -102,16 +102=
,6 @@</span><br><span>  */</span><br><span> void crypto_unload_provider(con=
st char *provname, provider_t *provider);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * OpenSSL memory debugging=2E  If dmalloc debugging is enable=
d, tell</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * OpenSSL to =
use our private malloc/realloc/free functions so that</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * we can dispatch them to dmalloc=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void crypto_init_dmalloc(void);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif /* DMALLOC */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> void show_available_ciphers(void);</s=
pan><br><span> </span><br><span> void show_available_digests(void);</span><=
br><span>diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/c=
rypto_mbedtls_legacy=2Ec</span><br><span>index debd53d=2E=2E9e47c26 100644<=
/span><br><span>--- a/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span=
>+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>@@ -139,14 +13=
9,6 @@</span><br><span> }</span><br><span> </span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-crypto_init_dmalloc(void)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    msg(M_ERR, &quot;Error: dmalloc support is not available for mbed TLS=
=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* DMALLOC */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> const cipher_=
name_pair cipher_name_translation_table[] =3D {</span><br><span>     { &quo=
t;BF-CBC&quot;, &quot;BLOWFISH-CBC&quot; },</span><br><span>     { &quot;BF=
-CFB&quot;, &quot;BLOWFISH-CFB64&quot; },</span><br><span>diff --git a/src/=
openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><span=
>index fa9eb67=2E=2E1191f20 100644</span><br><span>--- a/src/openvpn/crypto=
_openssl=2Ec</span><br><span>+++ b/src/openvpn/crypto_openssl=2Ec</span><br=
><span>@@ -39,6 +39,7 @@</span><br><span> #include &quot;integer=2Eh&quot;<=
/span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span> #include =
&quot;crypto_backend=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;=
openssl_compat=2Eh&quot;</span><br><span> </span><br><span> #include &lt;op=
enssl/conf=2Eh&gt;</span><br><span>@@ -273,40 +274,6 @@</span><br><span> }<=
/span><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * OpenSSL memory debugg=
ing=2E  If dmalloc debugging is enabled, tell</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * OpenSSL to use our private malloc/realloc/free f=
unctions so that</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * we=
 can dispatch them to dmalloc=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static void *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-crypto_malloc(size_t size, const char *file, int line)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return dmalloc_malloc(file, line, size, DMALL=
OC_FUNC_MALLOC, 0, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static void *</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-crypto_realloc(void *ptr, size_t size, const cha=
r *file, int line)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return dmalloc_real=
loc(file, line, ptr, size, DMALLOC_FUNC_REALLOC, 0);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-crypto_free(void *p=
tr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    dmalloc_free(__FILE__, __LINE__, p=
tr, DMALLOC_FUNC_FREE);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-crypto_init_dmalloc(void)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    CRYPTO_set_mem_ex_functions(crypto_malloc, crypto_realloc, crypto_fr=
ee);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif /* DMALLOC */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> const cipher_name_pa=
ir cipher_name_translation_table[] =3D {</span><br><span>     { &quot;AES-1=
28-GCM&quot;, &quot;id-aes128-GCM&quot; },</span><br><span>     { &quot;AES=
-192-GCM&quot;, &quot;id-aes192-GCM&quot; },</span><br><span>diff --git a/s=
rc/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 0236886=2E=
=2E893670f 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><spa=
n>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -838,11 +838,6 @@</span><br=
><span> bool</span><br><span> init_static(void)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(DMALLOC)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    crypto_init_dmalloc();</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span>     /*</span><br><span>      * Initialize ra=
ndom number seed=2E  random() is only used</span><br><span>      * when &qu=
ot;weak&quot; random numbers are acceptable=2E</span><br><span>diff --git a=
/src/openvpn/memdbg=2Eh b/src/openvpn/memdbg=2Eh</span><br><span>index ea62=
0c2=2E=2E1f94582 100644</span><br><span>--- a/src/openvpn/memdbg=2Eh</span>=
<br><span>+++ b/src/openvpn/memdbg=2Eh</span><br><span>@@ -43,67 +43,10 @@<=
/span><br><span>  */</span><br><span> </span><br><span> #ifdef USE_VALGRIND=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #in=
clude &lt;valgrind/memcheck=2Eh&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 VALGRIND_MAKE_READABLE(addr, len)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else /*=
 ifdef USE_VALGRIND */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define VALGRIND_MAK=
E_READABLE(addr, len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> #endif</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#ifdef DMALLOC /* see =2E/configure options to enable =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * See =2E/configure options to enable dmalloc</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * support for memory leak checkin=
g=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * The dmalloc package can be downlo=
aded from:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *     https://dmalloc=2Ecom/<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * When dmalloc is installed and enabled,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * use this command p=
rior to running openvpn:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    dmalloc -l=
 dlog -i 100 low -p log-unknown</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Also, =
put this in your =2Ebashrc file:</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    fu=
nction dmalloc { eval `command dmalloc -b $*`; }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * Or take a more low-level approach:</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *    export DMALLOC_OPTIONS=3D&quot;debug=3D0x4e48503,inter=3D100,log=
=3Ddlog&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *  NOTE: When building dma=
lloc you need to add something</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *  like this to dmalloc&#39;s settings=2Eh -- it will allocate a =
static</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  buffer to b=
e used as the malloc arena:</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  #define I=
NTERNAL_MEMORY_SPACE (1024 * 1024 * 50)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;dmalloc=
=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define openvpn_dmalloc(file, line=
, size) \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmalloc_=
malloc((file), (line), (size), DMALLOC_FUNC_MALLOC, 0, 0)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * T=
his #define will put the line number of the log</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * file position where leaked memory was allocate=
d instead</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * of the so=
urce code file and line number=2E  Make sure</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * to increase the size of dmalloc&#39;s info tables=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * (MEMORY_TABLE_SIZ=
E in settings=2Eh)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
otherwise it might get overwhelmed by the large</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * number of unique file/line combinations=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if 0</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#undef malloc</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define malloc(size) openvpn_dmalloc(&quot;logfile&quot;, x_msg_lin=
e_num, (size))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* DMALLOC */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define VALGRIND_MAKE_READABLE(addr, len)=
</span><br><span> </span><br><span> /*</span><br><span>  * Force buffers to=
 be zeroed after allocation=2E</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1582?usp=3Demai=
l">change 1582</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/15=
82?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I4920318ac537064508eee3ca449d48de76c2ea5d </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1582 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--crOp4cVjNNA=--


--===============8395038881426235085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8395038881426235085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8395038881426235085==--

