Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC744C5AC80
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 08:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oPXAI6daySAE0yt/Rs+p6OyabEMmw2kSoJKWz6a2Xzk=; b=LvxPaRNAyjtYmE8d6mJMx7Ebb0
	a9M+M77stRHklc6Ra+PJi1LbeuAhEHh6d8JMiyyIM34NsehqcbewY0GhoZpOtMwuXkt+NBZOHV1WR
	bdep9L58E7AlsaShgf+I3gMcdCzUT+wQkd/YmCHW5EB6ZPwITJzjMitU2M/jP5IfaVGw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsyzZ-00008N-UV;
	Sun, 09 Aug 2026 08:34:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsyzI-0008Ko-Tp
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 08:34:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=uvNtUt+nVp+rkbuRE5jm+sZD0W8b5pV9XxX3PsJhaGQ=; b=CkuTNGmtZF4dF4YrpT6OdEiyql
 DbeFbPP6O2HCZ++kLDsXSFHjrvtoViPDbDpcwJzUCdJf57xSvY+RR/XC4kRn1AO+R3Q6sUOPSIc63
 rnrI5aW5oQxWO0aVjp/HdHAD0J+TEFDFKB5IKDnpl5flkYnZjWOLXA+umYlIig/vWz8s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uvNtUt+nVp+rkbuRE5jm+sZD0W8b5pV9XxX3PsJhaGQ=; b=X
 hJPjPeChXX1xrEXQVpO1Jxkm1qX14M6QmxUyNtb5SUkw0zw2/zb58eZcUxjJiCz7NpTLPMUTVV40E
 L7ywkLkBayi5wWSxD0+1j0h0gH8Zxus5gUlxJlpxYRn576M4w9cRTl55eluQUMItUx/6khicfUE0m
 WqLyJIH/qnCdZfOY=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsyz5-0002Hd-T9 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 08:34:18 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so10710575e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 09 Aug 2026 01:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786264450; x=1786869250; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uvNtUt+nVp+rkbuRE5jm+sZD0W8b5pV9XxX3PsJhaGQ=;
 b=My5XckmWw99JjUs+YJzhxS45u5pP69D6tekM+FP0KrROeXbreiZ6DVMXCTyZTE0y7m
 TxhgdSwSvM7vOl3L8gthe9nCnIK+ECCLB+NuEaW2tfiDtzkriHkfeAyEIWOLqjdoUMlB
 8CaGiyCAXsMTllYJPUDpANKOvV22KYeahW1wwjHW5Cp3BUiQHXeJfHahU+pD5WmN++8t
 zTE60ci7JNoPtOUwhWwtaGlKSqcSXWyWwd0sTQQYVnDSfRltAwWc30JtjEJtpi/kwtH2
 Oqsz/d+/FbltAmNE2mjL4/eVlzN81fIrrOzNgPtvHC9DiOvpSM5dbvgp2HMKdCH80wG/
 riLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786264450; x=1786869250;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uvNtUt+nVp+rkbuRE5jm+sZD0W8b5pV9XxX3PsJhaGQ=;
 b=IQfRGV/gxjG8itBK9PS7HVuAnltG+zC3MZ0Nv3XMHGtXwBgS6JjH/DCjbk/wfQQLDa
 s0792QL4f4r56Gl4cKw9eOUq06vGI7PtejlKGFxg4oh8YjJ1YrMJCgXxSNF53f/jaOoH
 uUFo8/W1dHiXzztMSzkDt8pXmhcX0Lj+Tb9CJWAMkQaGwaxtHhbupVggdSkAbe6dCoB4
 DE097cV0bzTAe56FdkkhojqEJWSw7MCCTXX6cJvMhI3uzoyF6N8KPKyfpBSbUxMbdm4B
 qUH3W6EGYZ4laE8/7j/2aAmMwL+yWEyQdQ8rvSJx8jw/StbXtNAPMShS1KW/WOli2CVo
 pq6A==
X-Gm-Message-State: AOJu0Yx95IuGCcr8nnDTTEDTYPv1m0Nl1DsRQlPNwlIfPjXMLUy1abRK
 uc5KvlQe+LEQ7vx99qGsvji6OXMLYib+9/FIm37FUxnpnXPwNr4X/0JcCpUWFNDqo4nJlRK4jXI
 +Zq3hBu4wIosb3zqGtw84E4xBUC5+3fUisdfLC8d4cDKO1/Q+qZw5SRjeAPlPwjX496G6
X-Gm-Gg: AR+sD111aal4YUqzXKVuEb2l0stBlKImdEzguphQ94MgoZmyomNHRUaaCR9DV8KYdDj
 kqKOU3dLClbeRvPQwbKqxOGur5PPmNj7ViBv5dmLsmX2SWe8p+lVMb192+Hm2gKNOVS4FrsxjLK
 2ezjWaFku7eYTnCAIQOOpfv0wNESEmd8nq2OC4ZyP+TtC9lfqIE66PwO3tn1uOHLte1qe453JJn
 VXDY9kVfIYc3MrqBYWOq6dE/SFw/MHERHmwjiVNst53rfIXpx/1YOU8iP3oURJXRih8Ek+2nuY/
 DhCkKq+NYRDiN9q/8B6DCd0tVTk1YGWFwPfxaNa0TUTiRhjfjWpDBHOevWBUpdVqrY4EBU3LP8Z
 KJ25m5+SB6kPyetHOVRyGbZfBWekyOh+wI0IViZQHm90noTENQgL5ZI4JDr6RM6JN4niUAKLAOu
 NA7XoBGr/flLaXieU05rmhJR+wGU9iXqa4slBkvkSARrcVC9tTHMvQJA5eVCoSCOkNVRNOq1Fsz
 b1+8wDM+P4/aTLgaXILG4tTcRetzBcIh+IkDVPfQ5Jcdmc1ZfJ7Y5g3lFj9WHytbR245OPjh93T
 Oj5yxxs4LFrtk6XeC1HX+mTlv71I1pTpCYAX3eWA7M9j8JcDFmE=
X-Received: by 2002:a05:600d:105:b0:495:52db:7e8 with SMTP id
 5b1f17b1804b1-4994e7e0d93mr318993475e9.19.1786264449507; 
 Sun, 09 Aug 2026 01:34:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48002145679sm20712077f8f.3.2026.08.09.01.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 01:34:09 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 9 Aug 2026 08:34:06 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I4920318ac537064508eee3ca449d48de76c2ea5d
X-Gerrit-Change-Number: 1582
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1582?usp=email>
X-Gerrit-Commit: 1219685ad8eda403d1b9afcf630f3c8b09f2c347
In-Reply-To: <gerrit.1773842036000.I4920318ac537064508eee3ca449d48de76c2ea5d@gerrit.openvpn.net>
References: <gerrit.1773842036000.I4920318ac537064508eee3ca449d48de76c2ea5d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczODQyMDM2MDAwLkk0OTIwMzE4YWM1MzcwNjQ1MDhlZWUzY2E0NDlkNDhkZTc2YzJlYTVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <86ba9a4f869dcb27ea8c661d252688e92e41ad11-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsyz5-0002Hd-T9
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1179275291541920351=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1179275291541920351==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HD3VoEukffc="; charset=UTF-8

--HD3VoEukffc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1582?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by plaisthos


Change subject: Remove --with-mem-check=3Ddmalloc
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove --with-mem-chec=
k=3Ddmalloc

This code hasn't compiled for years and noone complained=2E
We=
 generally use ASAN instead=2E

So remove the dead code=2E

v2: The first v=
ersion of this change tried to fix the
    code=2E v2 instead removes it=2E=


Change-Id: I4920318ac537064508eee3ca449d48de76c2ea5d
Signed-off-by: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1582=

Message-Id: <20260807131539=2E53877-1-frank@lichtenheld=2Ecom>
URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38208=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLi=
sts=2Etxt
M config=2Eh=2Ecmake=2Ein
M configure=2Eac
M src/openvpn/buffer=
=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/crypto_backend=2Eh
M src/openvp=
n/crypto_mbedtls_legacy=2Ec
M src/openvpn/crypto_openssl=2Ec
M src/openvpn/=
init=2Ec
M src/openvpn/memdbg=2Eh
10 files changed, 5 insertions(+), 225 de=
letions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/82/1582/3

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index aabb=
cb6=2E=2E643dec6 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -2=
60,7 +260,6 @@
 
 check_include_files(arpa/inet=2Eh HAVE_ARPA_INET_H)
 chec=
k_include_files(dlfcn=2Eh HAVE_DLFCN_H)
-check_include_files(dmalloc=2Eh HA=
VE_DMALLOC_H)
 check_include_files(fcntl=2Eh HAVE_FCNTL_H)
 check_include_f=
iles(err=2Eh HAVE_ERR_H)
 check_include_files(netdb=2Eh HAVE_NETDB_H)
diff =
--git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index 34f289d=2E=
=2Ec3bb5a5 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2E=
in
@@ -96,9 +96,6 @@
 /* Define to 1 if you have the <dlfcn=2Eh> header fil=
e=2E */
 #cmakedefine HAVE_DLFCN_H
 
-/* Define to 1 if you have the <dmall=
oc=2Eh> header file=2E */
-#cmakedefine HAVE_DMALLOC_H
-
 /* Define to 1 if=
 you have the `dup' function=2E */
 #cmakedefine HAVE_DUP
 
diff --git a/co=
nfigure=2Eac b/configure=2Eac
index 1aec805=2E=2E469a475 100644
--- a/confi=
gure=2Eac
+++ b/configure=2Eac
@@ -245,10 +245,10 @@
 
 AC_ARG_WITH(
 	[mem=
-check],
-	[AS_HELP_STRING([--with-mem-check=3DTYPE], [build with debug mem=
ory checking, TYPE=3Dno|dmalloc|valgrind|ssl @<:@default=3Dno@:>@])],
+	[AS=
_HELP_STRING([--with-mem-check=3DTYPE], [build with debug memory checking, =
TYPE=3Dno|valgrind|ssl @<:@default=3Dno@:>@])],
 	[
 		case "${withval}" in=

-			dmalloc|valgrind|ssl|no) ;;
+			valgrind|ssl|no) ;;
 			*) AC_MSG_ERRO=
R([bad value ${withval} for --mem-check]) ;;
 		esac
 	],
@@ -652,25 +652,6=
 @@
 			[AC_MSG_ERROR([valgrind headers not found=2E])]
 		)
 		;;
-	dmallo=
c)
-		AC_CHECK_HEADERS(
-			[dmalloc=2Eh],
-			[AC_CHECK_LIB(
-				[dmalloc=
],
-				[malloc],
-				[
-					LIBS=3D"${LIBS} -ldmalloc"
-					AC_DEFINE(
=
-						[DMALLOC],
-						[1],
-						[Use dmalloc memory debugging library]=

-					)
-				],
-				[AC_MSG_ERROR([dmalloc library not found=2E])]
-			)]=
,
-			[AC_MSG_ERROR([dmalloc headers not found=2E])]
-		)
-		;;
 	ssl)
 		A=
C_CHECK_LIB(
 			[ssl],
diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/b=
uffer=2Ec
index 922238d=2E=2Ef14caa2 100644
--- a/src/openvpn/buffer=2Ec
++=
+ b/src/openvpn/buffer=2Ec
@@ -57,11 +57,7 @@
 }
 
 struct buffer
-#ifdef D=
MALLOC
-alloc_buf_debug(size_t size, const char *file, int line)
-#else
 al=
loc_buf(size_t size)
-#endif
 {
     struct buffer buf;
     CLEAR(buf);
@@=
 -71,22 +67,14 @@
         buf_size_error(size);
     }
     buf=2Ecapacity=
 =3D (int)size;
-#ifdef DMALLOC
-    buf=2Edata =3D openvpn_dmalloc(file, l=
ine, size);
-#else
     buf=2Edata =3D calloc(1, size);
-#endif
     check_=
malloc_return(buf=2Edata);
 
     return buf;
 }
 
 struct buffer
-#ifdef D=
MALLOC
-alloc_buf_gc_debug(size_t size, struct gc_arena *gc, const char *fi=
le, int line)
-#else
 alloc_buf_gc(size_t size, struct gc_arena *gc)
-#endi=
f
 {
     struct buffer buf;
     CLEAR(buf);
@@ -96,11 +84,7 @@
         b=
uf_size_error(size);
     }
     buf=2Ecapacity =3D (int)size;
-#ifdef DMAL=
LOC
-    buf=2Edata =3D (uint8_t *)gc_malloc_debug(size, false, gc, file, l=
ine);
-#else
     buf=2Edata =3D (uint8_t *)gc_malloc(size, false, gc);
-#e=
ndif
     if (size)
     {
         *buf=2Edata =3D 0;
@@ -109,7 +93,7 @@
 =
}
 
 struct buffer
-#ifdef DMALLOC
+#ifdef BUF_INIT_TRACKING
 clone_buf_deb=
ug(const struct buffer *buf, const char *file, int line)
 #else
 clone_buf(=
const struct buffer *buf)
@@ -123,11 +107,7 @@
     ret=2Edebug_file =3D bu=
f->debug_file;
     ret=2Edebug_line =3D buf->debug_line;
 #endif
-#ifdef D=
MALLOC
-    ret=2Edata =3D (uint8_t *)openvpn_dmalloc(file, line, buf->capa=
city);
-#else
     ret=2Edata =3D (uint8_t *)malloc(buf->capacity);
-#endif=

     check_malloc_return(ret=2Edata);
     memcpy(BPTR(&ret), BPTR(buf), B=
LENZ(buf));
     return ret;
@@ -335,21 +315,13 @@
  */
 
 void *
-#ifdef D=
MALLOC
-gc_malloc_debug(size_t size, bool clear, struct gc_arena *a, const =
char *file, int line)
-#else
 gc_malloc(size_t size, bool clear, struct gc_=
arena *a)
-#endif
 {
     void *ret;
     if (a)
     {
         struct gc_=
entry *e;
-#ifdef DMALLOC
-        e =3D (struct gc_entry *)openvpn_dmalloc=
(file, line, size + sizeof(struct gc_entry));
-#else
         e =3D (struct=
 gc_entry *)malloc(size + sizeof(struct gc_entry));
-#endif
         check_=
malloc_return(e);
         ret =3D (char *)e + sizeof(struct gc_entry);
   =
      e->next =3D a->list;
@@ -357,11 +329,7 @@
     }
     else
     {
-#i=
fdef DMALLOC
-        ret =3D openvpn_dmalloc(file, line, size);
-#else
   =
      ret =3D malloc(size);
-#endif
         check_malloc_return(ret);
    =
 }
 #ifndef ZERO_BUFFER_ON_ALLOC
@@ -444,11 +412,7 @@
 {
     ASSERT(a);
  =
   struct gc_entry_special *e;
-#ifdef DMALLOC
-    e =3D (struct gc_entry_=
special *)openvpn_dmalloc(file, line, sizeof(struct gc_entry_special));
-#e=
lse
     e =3D (struct gc_entry_special *)malloc(sizeof(struct gc_entry_spe=
cial));
-#endif
     check_malloc_return(e);
     e->free_fnc =3D free_func=
tion;
     e->addr =3D addr;
@@ -649,11 +613,7 @@
  * Allocate a string
  *=
/
 char *
-#ifdef DMALLOC
-string_alloc_debug(const char *str, struct gc_ar=
ena *gc, const char *file, int line)
-#else
 string_alloc(const char *str, =
struct gc_arena *gc)
-#endif
 {
     if (str)
     {
@@ -662,11 +622,7 @@
 =

         if (gc)
         {
-#ifdef DMALLOC
-            ret =3D (char *)g=
c_malloc_debug(n, false, gc, file, line);
-#else
             ret =3D (char=
 *)gc_malloc(n, false, gc);
-#endif
         }
         else
         {
@@ =
-674,11 +630,7 @@
              * that the caller cleans up afterwards=2E  =
This is coherent with the
              * earlier behaviour when gc_malloc(=
) would be called with gc =3D=3D NULL
              */
-#ifdef DMALLOC
-   =
         ret =3D openvpn_dmalloc(file, line, n);
-#else
             ret =
=3D calloc(1, n);
-#endif
             check_malloc_return(ret);
         }=

         memcpy(ret, str, n);
@@ -752,21 +704,13 @@
  * Allocate a string =
inside a buffer
  */
 struct buffer
-#ifdef DMALLOC
-string_alloc_buf_debug=
(const char *str, struct gc_arena *gc, const char *file, int line)
-#else
 =
string_alloc_buf(const char *str, struct gc_arena *gc)
-#endif
 {
     stru=
ct buffer buf;
 
     ASSERT(str);
 
-#ifdef DMALLOC
-    buf_set_read(&buf=
, (uint8_t *)string_alloc_debug(str, gc, file, line), strlen(str) + 1);
-#e=
lse
     buf_set_read(&buf, (uint8_t *)string_alloc(str, gc), strlen(str) +=
 1);
-#endif
 
     if (buf=2Elen > 0) /* Don't count trailing '\0' as part=
 of length */
     {
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buff=
er=2Eh
index 797bd08=2E=2E743c3f4 100644
--- a/src/openvpn/buffer=2Eh
+++ b=
/src/openvpn/buffer=2Eh
@@ -147,32 +147,6 @@
 
 void buf_size_error(const s=
ize_t size);
 
-/* for dmalloc debugging */
-
-#ifdef DMALLOC
-
-#define al=
loc_buf(size)               alloc_buf_debug(size, __FILE__, __LINE__)
-#def=
ine alloc_buf_gc(size, gc)        alloc_buf_gc_debug(size, gc, __FILE__, __=
LINE__);
-#define clone_buf(buf)                clone_buf_debug(buf, __FILE=
__, __LINE__);
-#define gc_malloc(size, clear, arena) gc_malloc_debug(size,=
 clear, arena, __FILE__, __LINE__)
-#define string_alloc(str, gc)         s=
tring_alloc_debug(str, gc, __FILE__, __LINE__)
-#define string_alloc_buf(st=
r, gc)     string_alloc_buf_debug(str, gc, __FILE__, __LINE__)
-
-struct bu=
ffer alloc_buf_debug(size_t size, const char *file, int line);
-
-struct bu=
ffer alloc_buf_gc_debug(size_t size, struct gc_arena *gc, const char *file,=
 int line);
-
-struct buffer clone_buf_debug(const struct buffer *buf, cons=
t char *file, int line);
-
-void *gc_malloc_debug(size_t size, bool clear, =
struct gc_arena *a, const char *file, int line);
-
-char *string_alloc_debu=
g(const char *str, struct gc_arena *gc, const char *file, int line);
-
-str=
uct buffer string_alloc_buf_debug(const char *str, struct gc_arena *gc, con=
st char *file,
-                                     int line);
-
-#else  /=
* ifdef DMALLOC */
-
 struct buffer alloc_buf(size_t size);
 
 struct buffe=
r alloc_buf_gc(size_t size,
@@ -186,8 +160,6 @@
 
 struct buffer string_all=
oc_buf(const char *str, struct gc_arena *gc);
 
-#endif /* ifdef DMALLOC */=

-
 void gc_addspecial(void *addr, void (*free_function)(void *), struct gc=
_arena *a);
 
 /**
diff --git a/src/openvpn/crypto_backend=2Eh b/src/openvp=
n/crypto_backend=2Eh
index b602ba1=2E=2E17085d6 100644
--- a/src/openvpn/cr=
ypto_backend=2Eh
+++ b/src/openvpn/crypto_backend=2Eh
@@ -102,16 +102,6 @@
=
  */
 void crypto_unload_provider(const char *provname, provider_t *provide=
r);
 
-#ifdef DMALLOC
-/*
- * OpenSSL memory debugging=2E  If dmalloc debug=
ging is enabled, tell
- * OpenSSL to use our private malloc/realloc/free fu=
nctions so that
- * we can dispatch them to dmalloc=2E
- */
-void crypto_in=
it_dmalloc(void);
-
-#endif /* DMALLOC */
-
 void show_available_ciphers(vo=
id);
 
 void show_available_digests(void);
diff --git a/src/openvpn/crypto_=
mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec
index debd53d=2E=
=2E9e47c26 100644
--- a/src/openvpn/crypto_mbedtls_legacy=2Ec
+++ b/src/ope=
nvpn/crypto_mbedtls_legacy=2Ec
@@ -139,14 +139,6 @@
 }
 
 
-#ifdef DMALLOC
=
-void
-crypto_init_dmalloc(void)
-{
-    msg(M_ERR, "Error: dmalloc support=
 is not available for mbed TLS=2E");
-}
-#endif /* DMALLOC */
-
 const ciph=
er_name_pair cipher_name_translation_table[] =3D {
     { "BF-CBC", "BLOWFI=
SH-CBC" },
     { "BF-CFB", "BLOWFISH-CFB64" },
diff --git a/src/openvpn/cr=
ypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec
index fa9eb67=2E=2E1191f2=
0 100644
--- a/src/openvpn/crypto_openssl=2Ec
+++ b/src/openvpn/crypto_open=
ssl=2Ec
@@ -39,6 +39,7 @@
 #include "integer=2Eh"
 #include "crypto=2Eh"
 #=
include "crypto_backend=2Eh"
+#include "memdbg=2Eh"
 #include "openssl_comp=
at=2Eh"
 
 #include <openssl/conf=2Eh>
@@ -273,40 +274,6 @@
 }
 
 
-/*
- *
=
- * OpenSSL memory debugging=2E  If dmalloc debugging is enabled, tell
- * =
OpenSSL to use our private malloc/realloc/free functions so that
- * we can=
 dispatch them to dmalloc=2E
- *
- */
-
-#ifdef DMALLOC
-static void *
-cry=
pto_malloc(size_t size, const char *file, int line)
-{
-    return dmalloc_=
malloc(file, line, size, DMALLOC_FUNC_MALLOC, 0, 0);
-}
-
-static void *
-c=
rypto_realloc(void *ptr, size_t size, const char *file, int line)
-{
-    r=
eturn dmalloc_realloc(file, line, ptr, size, DMALLOC_FUNC_REALLOC, 0);
-}
-=

-static void
-crypto_free(void *ptr)
-{
-    dmalloc_free(__FILE__, __LINE=
__, ptr, DMALLOC_FUNC_FREE);
-}
-
-void
-crypto_init_dmalloc(void)
-{
-    =
CRYPTO_set_mem_ex_functions(crypto_malloc, crypto_realloc, crypto_free);
-}=

-#endif /* DMALLOC */
-
 const cipher_name_pair cipher_name_translation_ta=
ble[] =3D {
     { "AES-128-GCM", "id-aes128-GCM" },
     { "AES-192-GCM", =
"id-aes192-GCM" },
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec=

index 906a83c=2E=2E69d226d 100644
--- a/src/openvpn/init=2Ec
+++ b/src/ope=
nvpn/init=2Ec
@@ -838,11 +838,6 @@
 bool
 init_static(void)
 {
-#if defined=
(DMALLOC)
-    crypto_init_dmalloc();
-#endif
-
-
     /*
      * Initializ=
e random number seed=2E  random() is only used
      * when "weak" random n=
umbers are acceptable=2E
diff --git a/src/openvpn/memdbg=2Eh b/src/openvpn/=
memdbg=2Eh
index ea620c2=2E=2E1f94582 100644
--- a/src/openvpn/memdbg=2Eh
+=
++ b/src/openvpn/memdbg=2Eh
@@ -43,67 +43,10 @@
  */
 
 #ifdef USE_VALGRIND=

-
 #include <valgrind/memcheck=2Eh>
-
-#define VALGRIND_MAKE_READABLE(addr=
, len)
-
-#else /* ifdef USE_VALGRIND */
-
-#define VALGRIND_MAKE_READABLE(=
addr, len)
-
 #endif
 
-#ifdef DMALLOC /* see =2E/configure options to enab=
le */
-
-/*
- * See =2E/configure options to enable dmalloc
- * support for=
 memory leak checking=2E
- *
- * The dmalloc package can be downloaded from=
:
- *
- *     https://dmalloc=2Ecom/
- *
- * When dmalloc is installed and =
enabled,
- * use this command prior to running openvpn:
- *
- *    dmalloc =
-l dlog -i 100 low -p log-unknown
- *
- * Also, put this in your =2Ebashrc =
file:
- *
- *    function dmalloc { eval `command dmalloc -b $*`; }
- *
- *=
 Or take a more low-level approach:
- *
- *    export DMALLOC_OPTIONS=3D"de=
bug=3D0x4e48503,inter=3D100,log=3Ddlog"
- *
- *  NOTE: When building dmallo=
c you need to add something
- *  like this to dmalloc's settings=2Eh -- it =
will allocate a static
- *  buffer to be used as the malloc arena:
- *
- * =
 #define INTERNAL_MEMORY_SPACE (1024 * 1024 * 50)
- */
-
-#include <dmalloc=
=2Eh>
-
-#define openvpn_dmalloc(file, line, size) \
-    dmalloc_malloc((f=
ile), (line), (size), DMALLOC_FUNC_MALLOC, 0, 0)
-
-/*
- * This #define wil=
l put the line number of the log
- * file position where leaked memory was =
allocated instead
- * of the source code file and line number=2E  Make sure=

- * to increase the size of dmalloc's info tables,
- * (MEMORY_TABLE_SIZE =
in settings=2Eh)
- * otherwise it might get overwhelmed by the large
- * nu=
mber of unique file/line combinations=2E
- */
-#if 0
-#undef malloc
-#defin=
e malloc(size) openvpn_dmalloc("logfile", x_msg_line_num, (size))
-#endif
-=

-#endif /* DMALLOC */
+#define VALGRIND_MAKE_READABLE(addr, len)
 
 /*
  *=
 Force buffers to be zeroed after allocation=2E

-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1582?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I4920318ac537064508eee3ca449d48de76c2ea5d
Ge=
rrit-Change-Number: 1582
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--HD3VoEukffc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1582?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">Remove --with-mem-chec=
k=3Ddmalloc<br><br>This code hasn&#39;t compiled for years and noone compla=
ined=2E<br>We generally use ASAN instead=2E<br><br>So remove the dead code=
=2E<br><br>v2: The first version of this change tried to fix the<br>    cod=
e=2E v2 instead removes it=2E<br><br>Change-Id: I4920318ac537064508eee3ca44=
9d48de76c2ea5d<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1582<br>Message-Id: &lt=
;20260807131539=2E53877-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38208=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M CMakeLists=2Etxt<br>M config=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M s=
rc/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/crypto_b=
ackend=2Eh<br>M src/openvpn/crypto_mbedtls_legacy=2Ec<br>M src/openvpn/cryp=
to_openssl=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/memdbg=2Eh<br>10 =
files changed, 5 insertions(+), 225 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/1582/3=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>i=
ndex aabbcb6=2E=2E643dec6 100644</span><br><span>--- a/CMakeLists=2Etxt</sp=
an><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -260,7 +260,6 @@</sp=
an><br><span> </span><br><span> check_include_files(arpa/inet=2Eh HAVE_ARPA=
_INET_H)</span><br><span> check_include_files(dlfcn=2Eh HAVE_DLFCN_H)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-check_include_files(dmalloc=
=2Eh HAVE_DMALLOC_H)</span><br><span> check_include_files(fcntl=2Eh HAVE_FC=
NTL_H)</span><br><span> check_include_files(err=2Eh HAVE_ERR_H)</span><br><=
span> check_include_files(netdb=2Eh HAVE_NETDB_H)</span><br><span>diff --gi=
t a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>index=
 34f289d=2E=2Ec3bb5a5 100644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein<=
/span><br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -96,9 +96,=
6 @@</span><br><span> /* Define to 1 if you have the &lt;dlfcn=2Eh&gt; head=
er file=2E */</span><br><span> #cmakedefine HAVE_DLFCN_H</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you =
have the &lt;dmalloc=2Eh&gt; header file=2E */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#cmakedefine HAVE_DMALLOC_H</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Define to 1 if you hav=
e the `dup&#39; function=2E */</span><br><span> #cmakedefine HAVE_DUP</span=
><br><span> </span><br><span>diff --git a/configure=2Eac b/configure=2Eac</=
span><br><span>index 1aec805=2E=2E469a475 100644</span><br><span>--- a/conf=
igure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -245,10 =
+245,10 @@</span><br><span> </span><br><span> AC_ARG_WITH(</span><br><span>=
 	[mem-check],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[AS_HE=
LP_STRING([--with-mem-check=3DTYPE], [build with debug memory checking, TYP=
E=3Dno|dmalloc|valgrind|ssl @&lt;:@default=3Dno@:&gt;@])],</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	[AS_HELP_STRING([--with-mem-check=
=3DTYPE], [build with debug memory checking, TYPE=3Dno|valgrind|ssl @&lt;:@=
default=3Dno@:&gt;@])],</span><br><span> 	[</span><br><span> 		case &quot;$=
{withval}&quot; in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			=
dmalloc|valgrind|ssl|no) ;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+			valgrind|ssl|no) ;;</span><br><span> 			*) AC_MSG_ERROR([bad val=
ue ${withval} for --mem-check]) ;;</span><br><span> 		esac</span><br><span>=
 	],</span><br><span>@@ -652,25 +652,6 @@</span><br><span> 			[AC_MSG_ERROR=
([valgrind headers not found=2E])]</span><br><span> 		)</span><br><span> 		=
;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	dmalloc)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-		AC_CHECK_HEADERS(</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-			[dmalloc=2Eh],</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-			[AC_CHECK_LIB(</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-				[dmalloc],</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-				[malloc],</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-				[</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-					LIBS=3D&quot;${LIBS} -ldmalloc&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-					AC_DEFINE(</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-						[DMALLOC],</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-						[1],</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-						[Use dmalloc memory debugging library]</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-					)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-				],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-				[A=
C_MSG_ERROR([dmalloc library not found=2E])]</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-			)],</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-			[AC_MSG_ERROR([dmalloc headers not found=2E])]</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-		)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-		;;</span><br><span> 	ssl)</span><br><span> 		AC_CHECK_L=
IB(</span><br><span> 			[ssl],</span><br><span>diff --git a/src/openvpn/buf=
fer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 922238d=2E=2Ef14caa2=
 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/=
src/openvpn/buffer=2Ec</span><br><span>@@ -57,11 +57,7 @@</span><br><span> =
}</span><br><span> </span><br><span> struct buffer</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-alloc_buf_debug(size_t size, const char *file, int li=
ne)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><s=
pan> alloc_buf(size_t size)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span> {</span><br><span>     struct buffer buf;</sp=
an><br><span>     CLEAR(buf);</span><br><span>@@ -71,22 +67,14 @@</span><br=
><span>         buf_size_error(size);</span><br><span>     }</span><br><spa=
n>     buf=2Ecapacity =3D (int)size;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    buf=2Edata =3D openvpn_dmalloc(file, line, size);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span>     buf=2Eda=
ta =3D calloc(1, size);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span>     check_malloc_return(buf=2Edata);</span><br><s=
pan> </span><br><span>     return buf;</span><br><span> }</span><br><span> =
</span><br><span> struct buffer</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#ifdef DMALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-alloc_buf_gc_debug(size_t size, struct gc_arena *gc, const char *file, i=
nt line)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><=
br><span> alloc_buf_gc(size_t size, struct gc_arena *gc)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> {</span><br><spa=
n>     struct buffer buf;</span><br><span>     CLEAR(buf);</span><br><span>=
@@ -96,11 +84,7 @@</span><br><span>         buf_size_error(size);</span><br=
><span>     }</span><br><span>     buf=2Ecapacity =3D (int)size;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    buf=2Edata =3D (uint8_t *)gc_malloc=
_debug(size, false, gc, file, line);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#else</span><br><span>     buf=2Edata =3D (uint8_t *)gc_mall=
oc(size, false, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span>     if (size)</span><br><span>     {</span><br><span=
>         *buf=2Edata =3D 0;</span><br><span>@@ -109,7 +93,7 @@</span><br><=
span> }</span><br><span> </span><br><span> struct buffer</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifdef BUF_INIT_TRACKING</span><br><span> clo=
ne_buf_debug(const struct buffer *buf, const char *file, int line)</span><b=
r><span> #else</span><br><span> clone_buf(const struct buffer *buf)</span><=
br><span>@@ -123,11 +107,7 @@</span><br><span>     ret=2Edebug_file =3D buf=
-&gt;debug_file;</span><br><span>     ret=2Edebug_line =3D buf-&gt;debug_li=
ne;</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#ifdef DMALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   ret=2Edata =3D (uint8_t *)openvpn_dmalloc(file, line, buf-&gt;capacity);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span=
>     ret=2Edata =3D (uint8_t *)malloc(buf-&gt;capacity);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     check_mallo=
c_return(ret=2Edata);</span><br><span>     memcpy(BPTR(&amp;ret), BPTR(buf)=
, BLENZ(buf));</span><br><span>     return ret;</span><br><span>@@ -335,21 =
+315,13 @@</span><br><span>  */</span><br><span> </span><br><span> void *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-gc_malloc_debug(size_t size, b=
ool clear, struct gc_arena *a, const char *file, int line)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span> gc_malloc(size_=
t size, bool clear, struct gc_arena *a)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span> {</span><br><span>     void *ret;=
</span><br><span>     if (a)</span><br><span>     {</span><br><span>       =
  struct gc_entry *e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#ifdef DMALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 e =3D (struct gc_entry *)openvpn_dmalloc(file, line, size + sizeof(struct =
gc_entry));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</spa=
n><br><span>         e =3D (struct gc_entry *)malloc(size + sizeof(struct g=
c_entry));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span>         check_malloc_return(e);</span><br><span>         ret =
=3D (char *)e + sizeof(struct gc_entry);</span><br><span>         e-&gt;nex=
t =3D a-&gt;list;</span><br><span>@@ -357,11 +329,7 @@</span><br><span>    =
 }</span><br><span>     else</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        ret =3D openvpn_dmalloc(file, line, size);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span=
>         ret =3D malloc(size);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span>         check_malloc_return(ret);</span><=
br><span>     }</span><br><span> #ifndef ZERO_BUFFER_ON_ALLOC</span><br><sp=
an>@@ -444,11 +412,7 @@</span><br><span> {</span><br><span>     ASSERT(a);<=
/span><br><span>     struct gc_entry_special *e;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    e =3D (struct gc_entry_special *)openvpn_dmalloc(fi=
le, line, sizeof(struct gc_entry_special));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#else</span><br><span>     e =3D (struct gc_entry_spe=
cial *)malloc(sizeof(struct gc_entry_special));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span>     check_malloc_return(e=
);</span><br><span>     e-&gt;free_fnc =3D free_function;</span><br><span> =
    e-&gt;addr =3D addr;</span><br><span>@@ -649,11 +613,7 @@</span><br><sp=
an>  * Allocate a string</span><br><span>  */</span><br><span> char *</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-string_alloc_debug(const char *str=
, struct gc_arena *gc, const char *file, int line)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#else</span><br><span> string_alloc(const char=
 *str, struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span> {</span><br><span>     if (str)</span><br><sp=
an>     {</span><br><span>@@ -662,11 +622,7 @@</span><br><span> </span><br>=
<span>         if (gc)</span><br><span>         {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            ret =3D (char *)gc_malloc_debug(n, false, =
gc, file, line);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else=
</span><br><span>             ret =3D (char *)gc_malloc(n, false, gc);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>   =
      }</span><br><span>         else</span><br><span>         {</span><br>=
<span>@@ -674,11 +630,7 @@</span><br><span>              * that the caller =
cleans up afterwards=2E  This is coherent with the</span><br><span>        =
      * earlier behaviour when gc_malloc() would be called with gc =3D=3D N=
ULL</span><br><span>              */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            ret =3D openvpn_dmalloc(file, line, n);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span>             re=
t =3D calloc(1, n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span>             check_malloc_return(ret);</span><br><span=
>         }</span><br><span>         memcpy(ret, str, n);</span><br><span>@=
@ -752,21 +704,13 @@</span><br><span>  * Allocate a string inside a buffer<=
/span><br><span>  */</span><br><span> struct buffer</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-string_alloc_buf_debug(const char *str, struct gc_=
arena *gc, const char *file, int line)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#else</span><br><span> string_alloc_buf(const char *str, s=
truct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span> {</span><br><span>     struct buffer buf;</span><br><=
span> </span><br><span>     ASSERT(str);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    buf_set_read(&amp;buf, (uint8_t *)strin=
g_alloc_debug(str, gc, file, line), strlen(str) + 1);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span>     buf_set_read(&am=
p;buf, (uint8_t *)string_alloc(str, gc), strlen(str) + 1);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> </span><br><sp=
an>     if (buf=2Elen &gt; 0) /* Don&#39;t count trailing &#39;\0&#39; as p=
art of length */</span><br><span>     {</span><br><span>diff --git a/src/op=
envpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index 797bd08=2E=
=2E743c3f4 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><s=
pan>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -147,32 +147,6 @@</span=
><br><span> </span><br><span> void buf_size_error(const size_t size);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* for dm=
alloc debugging */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define alloc_buf(size)               alloc_buf_debu=
g(size, __FILE__, __LINE__)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define alloc_buf_gc(size, gc)        alloc_buf_gc_debug(size, gc, __=
FILE__, __LINE__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#de=
fine clone_buf(buf)                clone_buf_debug(buf, __FILE__, __LINE__)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define gc_malloc(si=
ze, clear, arena) gc_malloc_debug(size, clear, arena, __FILE__, __LINE__)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define string_alloc(st=
r, gc)         string_alloc_debug(str, gc, __FILE__, __LINE__)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define string_alloc_buf(str, gc) =
    string_alloc_buf_debug(str, gc, __FILE__, __LINE__)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-struct buffer alloc_buf_debug(size_t size, const char *file, i=
nt line);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-struct buffer alloc_buf_gc_debug(=
size_t size, struct gc_arena *gc, const char *file, int line);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-struct buffer clone_buf_debug(const struct buffer *buf,=
 const char *file, int line);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void *gc_mall=
oc_debug(size_t size, bool clear, struct gc_arena *a, const char *file, int=
 line);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-char *string_alloc_debug(const char=
 *str, struct gc_arena *gc, const char *file, int line);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-struct buffer string_alloc_buf_debug(const char *str, struct =
gc_arena *gc, const char *file,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                     int line);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#else  /* ifdef DMALLOC */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> struct buffer alloc_buf(size_t size);=
</span><br><span> </span><br><span> struct buffer alloc_buf_gc(size_t size,=
</span><br><span>@@ -186,8 +160,6 @@</span><br><span> </span><br><span> str=
uct buffer string_alloc_buf(const char *str, struct gc_arena *gc);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if=
def DMALLOC */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> void gc_addspecial(void *addr, void (*free_function)(void *), st=
ruct gc_arena *a);</span><br><span> </span><br><span> /**</span><br><span>d=
iff --git a/src/openvpn/crypto_backend=2Eh b/src/openvpn/crypto_backend=2Eh=
</span><br><span>index b602ba1=2E=2E17085d6 100644</span><br><span>--- a/sr=
c/openvpn/crypto_backend=2Eh</span><br><span>+++ b/src/openvpn/crypto_backe=
nd=2Eh</span><br><span>@@ -102,16 +102,6 @@</span><br><span>  */</span><br>=
<span> void crypto_unload_provider(const char *provname, provider_t *provid=
er);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#ifdef DMALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * OpenSSL memory debuggi=
ng=2E  If dmalloc debugging is enabled, tell</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * OpenSSL to use our private malloc/realloc/free fu=
nctions so that</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * we =
can dispatch them to dmalloc=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void cry=
pto_init_dmalloc(void);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* DMALLOC *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> vo=
id show_available_ciphers(void);</span><br><span> </span><br><span> void sh=
ow_available_digests(void);</span><br><span>diff --git a/src/openvpn/crypto=
_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span=
>index debd53d=2E=2E9e47c26 100644</span><br><span>--- a/src/openvpn/crypto=
_mbedtls_legacy=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtls_legacy=
=2Ec</span><br><span>@@ -139,14 +139,6 @@</span><br><span> }</span><br><spa=
n> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#ifdef DMALLOC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-crypto_init_dmalloc(void=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    msg(M_ERR, &quot;Error: dmalloc supp=
ort is not available for mbed TLS=2E&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif /* DMALLOC */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> const cipher_name_pair cipher_name_translation_table[] =
=3D {</span><br><span>     { &quot;BF-CBC&quot;, &quot;BLOWFISH-CBC&quot; }=
,</span><br><span>     { &quot;BF-CFB&quot;, &quot;BLOWFISH-CFB64&quot; },<=
/span><br><span>diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/c=
rypto_openssl=2Ec</span><br><span>index fa9eb67=2E=2E1191f20 100644</span><=
br><span>--- a/src/openvpn/crypto_openssl=2Ec</span><br><span>+++ b/src/ope=
nvpn/crypto_openssl=2Ec</span><br><span>@@ -39,6 +39,7 @@</span><br><span> =
#include &quot;integer=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh=
&quot;</span><br><span> #include &quot;crypto_backend=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;memdbg=2Eh&quot;=
</span><br><span> #include &quot;openssl_compat=2Eh&quot;</span><br><span> =
</span><br><span> #include &lt;openssl/conf=2Eh&gt;</span><br><span>@@ -273=
,40 +274,6 @@</span><br><span> }</span><br><span> </span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * OpenSSL memory debugging=2E  If dmalloc debugging is enabled, t=
ell</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * OpenSSL to use =
our private malloc/realloc/free functions so that</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * we can dispatch them to dmalloc=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-crypto_malloc(size_t size, co=
nst char *file, int line)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return dmall=
oc_malloc(file, line, size, DMALLOC_FUNC_MALLOC, 0, 0);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
void *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-crypto_realloc(=
void *ptr, size_t size, const char *file, int line)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return dmalloc_realloc(file, line, ptr, size, DMALLOC_FUNC_=
REALLOC, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-crypto_free(void *ptr)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
dmalloc_free(__FILE__, __LINE__, ptr, DMALLOC_FUNC_FREE);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-crypto_init_dmalloc(vo=
id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    CRYPTO_set_mem_ex_functions(crypto=
_malloc, crypto_realloc, crypto_free);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif /* DMALLOC */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> const cipher_name_pair cipher_name_translation_table[] =3D {<=
/span><br><span>     { &quot;AES-128-GCM&quot;, &quot;id-aes128-GCM&quot; }=
,</span><br><span>     { &quot;AES-192-GCM&quot;, &quot;id-aes192-GCM&quot;=
 },</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2E=
c</span><br><span>index 906a83c=2E=2E69d226d 100644</span><br><span>--- a/s=
rc/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><s=
pan>@@ -838,11 +838,6 @@</span><br><span> bool</span><br><span> init_static=
(void)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if defined(DMALLOC)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    crypto_init_dmalloc();</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /*</sp=
an><br><span>      * Initialize random number seed=2E  random() is only use=
d</span><br><span>      * when &quot;weak&quot; random numbers are acceptab=
le=2E</span><br><span>diff --git a/src/openvpn/memdbg=2Eh b/src/openvpn/mem=
dbg=2Eh</span><br><span>index ea620c2=2E=2E1f94582 100644</span><br><span>-=
-- a/src/openvpn/memdbg=2Eh</span><br><span>+++ b/src/openvpn/memdbg=2Eh</s=
pan><br><span>@@ -43,67 +43,10 @@</span><br><span>  */</span><br><span> </s=
pan><br><span> #ifdef USE_VALGRIND</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> #include &lt;valgrind/memcheck=2Eh&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define VALGRIND_MAKE_READABLE(addr, len)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#else /* ifdef USE_VALGRIND */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define VALGRIND_MAKE_READABLE(addr, len)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC /* se=
e =2E/configure options to enable */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * See =2E/configure opti=
ons to enable dmalloc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * support for memory leak checking=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 The dmalloc package can be downloaded from:</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *     https://dmalloc=2Ecom/</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * When=
 dmalloc is installed and enabled,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * use this command prior to running openvpn:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *    dmalloc -l dlog -i 100 low -p log-unknown</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * Also, put this in your =2Ebashrc file:</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *    function dmalloc { eval `command dmalloc -b=
 $*`; }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * Or take a more low-level appro=
ach:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *    export DMALLOC_OPTIONS=3D&quot=
;debug=3D0x4e48503,inter=3D100,log=3Ddlog&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *  NOTE: When building dmalloc you need to add something</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *  like this to dmalloc&#39;s s=
ettings=2Eh -- it will allocate a static</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  buffer to be used as the malloc arena:</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *  #define INTERNAL_MEMORY_SPACE (1024 * 1024 * 50)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#include &lt;dmalloc=2Eh&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define openvpn_dmalloc(file, line, size) \</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    dmalloc_malloc((file), (line), (size), DMALLOC_FUN=
C_MALLOC, 0, 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * This #define will put the line number of th=
e log</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * file position=
 where leaked memory was allocated instead</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * of the source code file and line number=2E  Make su=
re</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * to increase the =
size of dmalloc&#39;s info tables,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * (MEMORY_TABLE_SIZE in settings=2Eh)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * otherwise it might get overwhelmed by th=
e large</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * number of u=
nique file/line combinations=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if 0</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#undef malloc</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define malloc(size) openvpn_dma=
lloc(&quot;logfile&quot;, x_msg_line_num, (size))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /=
* DMALLOC */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 VALGRIND_MAKE_READABLE(addr, len)</span><br><span> </span><br><span> /*</s=
pan><br><span>  * Force buffers to be zeroed after allocation=2E</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1582?usp=3Demail">change 1582</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1582?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I4920318ac537064508eee3ca4=
49d48de76c2ea5d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
582 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body=
></html>
--HD3VoEukffc=--


--===============1179275291541920351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1179275291541920351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1179275291541920351==--

