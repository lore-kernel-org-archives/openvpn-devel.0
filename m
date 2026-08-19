Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6769EC5DF81
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ma8qHFOr3vT97+roNZbcjjeBaHvgX39wfJcWt9Y8+9g=; b=RSmyimCcQ6fra+7c3wMOrohhgj
	zEpyU5H3Kvi8uEklPrgLCsEisOmP1gEZu4/gfUzftvalAvc1b4uCgO3WAsdGV+/KEScMAVGbuVtcB
	dnK30OH8hA6QCGwAjsg/ZSS0YgpyDdyPHE/MoBYUiT0ZnysJ5WcKGaK9E5+qsSQPYw1k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwgYM-0001CC-LF;
	Wed, 19 Aug 2026 13:42:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwgYK-0001C0-Ur
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:41:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rdtKHBbH+DxAZwaMfFUjyG2HYwPsOB1FxWYY3Dh++aM=; b=klidjeX49GvWvo2buHaxySmqY6
 r+Nw7IwtBmNLrYP8oaArTO8WSEy+K3hpZ1hoGBl61MRgyNqvVLyDwEdspcAgMaphSnwxZeNcp3xTd
 cowZujVNJOlJ4xcoXjEwMNl5F+uzhuqtQdRyZWYjQQKdowcdUfGnhgG/xzV+xlUboJPA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rdtKHBbH+DxAZwaMfFUjyG2HYwPsOB1FxWYY3Dh++aM=; b=d
 NWZZbR23d8EJ94QALVq61xGCgT5lfH4I0oupvdqEvEacJWdVSJY+cFFg8jF4m0CPFBagzBIZ8PAyK
 qZPWcFYaJV5e+DY2gQG7v77wwAZO5vfV59NcuDNUNC8EBtAG/mtM/qGhC33b2pe2nhOCrz+AQEnRb
 yttPDtjedqd9OU8o=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwgYG-0001Ig-1j for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:41:58 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so9984855e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 06:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787146909; x=1787751709; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rdtKHBbH+DxAZwaMfFUjyG2HYwPsOB1FxWYY3Dh++aM=;
 b=KJFQAEVe7lgBHm00fBbgJtLyMtQKwK/CGG5x2tanKPUByWHkRtM71KbZo8/yaMxh2E
 5ArygfD9D7w+7nngf7SzbZPvIJkOmOIDdVberIzRiLwVhTospVeCFxHkbSeh+5JnAKEX
 PI1VXdB/cQeijrLOxnBRuQsF4n6k2HElpSFErrD5zsUkO9B3U1C6JycCe+2xNMZY5yqf
 W22JufDxhFNpzqfjvzFCHjlxOJeXPwonRLtMZ3lXdFgmb6GoUFg3FMczkClugZJDoDm5
 VsmAHnFXKIKwl04JXVIGD+rqb48+39XPuxXZW1z5+GCKRkSzGIT1lkTaX8k/qz1uDsIq
 TV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787146909; x=1787751709;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rdtKHBbH+DxAZwaMfFUjyG2HYwPsOB1FxWYY3Dh++aM=;
 b=K75pnTozjDYgBa7E2+igqfZMficVhm8+H+F+tj4+NiR+GPPdUT5EBjDiUI+50wMNgA
 ICG6ZkoqxLHvOLdCxooyIyQnuqBbvUFAu/EJguJomBc20txsw4Xg1LUtjDxGJ3sXSDPv
 UvWh4tHVmu2YVumE35ru0v3nJWjG3Oxk05AiNI7eAALr1ws8VHpJ2w+0hkXFcd1/GrCl
 hAoLmxbXqSBfxmWbGHxTy8nlnbVISEPjZx6/ADsyyQgVm3KqRxL3H1+d0oCzMtG4y9w/
 rlcM2b542sY2zOrv2BQrVzyQITMnSokLjq/wVK1X+3M0Wock2gLDA1XERh3QoAKV1koz
 ZtsQ==
X-Gm-Message-State: AOJu0Yys3OrjC8i7s/qqjvN60UC0XaH/yjq/u//Yzpwp0oGdWHNCqjXs
 wtCjTu74qmnjU+wk3kVilu7Z/b1ItFa9HA5D4F0vhyrM5kGLmEzv/xtaMa7jqBpeGTY6cWCR9iM
 D70qtle16wjIkR/j+yWe2GLowqIs043F4xh8AAiXvrYlq3F7k+sEQCQO5EWkiYamVct2TzL2sZJ
 mWLNAKBg==
X-Gm-Gg: AR+sD13Pe02wcPB9EPFmfhCIQcMUFwTMdYwBid/fHkWAfD9xt0i6OgiGGqeQ1VdAKkm
 rOha5zuoVWnXC01/PVmKZrrvQRPaTJ9qeAkhQVqWPQsAvi44Ir0DCzwKmAqFNC30PVgHSI5Ud2l
 2XUjeDq+zBn6tQPcIx0r/+SDs8NKn+Ta8hjGCYvWO3TI1wScWIiULMFVvm1mRIznK0MlIFQUMsA
 gVi48qfh8vCg2pQiBS/Cph2uSrgSRGtddw7rKVEp1EGLEsAQuD4/88qQUXoOBWNPQuzQs8G2jip
 jju0O1UKsUGPxdn+IGOfg2uwDk4vIAlH95qZqoJUfPKOEgOK2LriG4b3pi5/eGxtsGAJko3W7Pq
 iKv9S+LbhKPpXmS9eANTQs+vSG24IfjqqpyniDtbnoexWPrmHmEh7a/58pvGfHZsbayuDkq2Iow
 ovrVzxp7qO5bQjN5NKoDyM8hzGNOVOa67K1Hu7t/QVOT355QBipY4/aXw2C8eInxsJYGoe7hP8X
 g91MvDseK0NYX8lkf5e32OW1nhpFgzzTicSFwuF8uxPnX9Qo1fumFzKen2W5E0+UjG7SizenMT2
 MdCwd0j+poPSOMHTUU7YHVELIMYUxFGzjw7IwubRTfC++e0ewFs=
X-Received: by 2002:a05:600c:4e01:b0:493:e365:ace9 with SMTP id
 5b1f17b1804b1-499aa1d0747mr96472905e9.11.1787146909384; 
 Wed, 19 Aug 2026 06:41:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa17f202sm58208725e9.13.2026.08.19.06.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:41:48 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 13:41:46 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
X-Gerrit-Change-Number: 1592
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1592?usp=email>
X-Gerrit-Commit: b29e5e6d76dcc8a609c89d4bca070bf85ed902ee
In-Reply-To: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
References: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0NDUxMzgwMDAwLkk3OWIyZGM0YTU1MGIxYzUwNjhhNDU0MDc5NzZiMGRmYzJmNzY1YjMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f7ff372647f64bb68d1d58762a458ddeecbbede5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwgYG-0001Ig-1j
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Add
 --enable-code-coverage
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3353809168824659943=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3353809168824659943==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fYR9Q7Kr40w="; charset=UTF-8

--fYR9Q7Kr40w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, razvanc=2E

=
Hello plaisthos, razvanc, 

I'd like you to reexamine a change=2E Please vi=
sit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail

to loo=
k at the new patch set (#3)=2E


Change subject: configure: Add --enable-co=
de-coverage
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

c=
onfigure: Add --enable-code-coverage

Can be used like this
=2E/configure -=
-enable-code-coverage
make
make check
make code-coverage-capture

Note that=
 we patch ax_code_coverage=2Em4 to not incur
a dependency on autoconf-archi=
ve for a few lines of
trivial code=2E

Change-Id: I79b2dc4a550b1c5068a45407=
976b0dfc2f765b33
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

---
M =2Egitignore
M Makefile=2Eam
M configure=2Eac
A lcovrc
M m4/ax_code_=
coverage=2Em4
M src/openvpn/Makefile=2Eam
6 files changed, 41 insertions(+)=
, 8 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/92/1592/3

diff --git a/=2Egitignore b/=2Egitignore
index 04523a=
f=2E=2Ee25e591 100644
--- a/=2Egitignore
+++ b/=2Egitignore
@@ -1,5 +1,7 @@=

 *=2E[oa]
 *=2El[oa]
+*=2Egcda
+*=2Egcno
 *=2Edll
 *=2Eexe
 *=2Eexe=2E*
@@=
 -18,6 +20,7 @@
 Makefile
 Makefile=2Ein
 aclocal=2Em4
+aminclude_static=2E=
am
 autodefs=2Eh
 autom4te=2Ecache
 config=2Eguess
diff --git a/Makefile=2E=
am b/Makefile=2Eam
index feeaabb=2E=2E716b2df 100644
--- a/Makefile=2Eam
++=
+ b/Makefile=2Eam
@@ -22,6 +22,8 @@
 #  with this program; if not, see <htt=
ps://www=2Egnu=2Eorg/licenses/>=2E
 #
 
+include $(top_srcdir)/aminclude_st=
atic=2Eam
+
 ACLOCAL_AMFLAGS =3D -I m4
 
 MAINTAINERCLEANFILES =3D \
@@ -45=
,7 +47,8 @@
 	CMakeLists=2Etxt \
 	CMakePresets=2Ejson \
 	config=2Eh=2Ecma=
ke=2Ein \
-	forked-test-driver
+	forked-test-driver \
+	lcovrc
 
 =2EPHONY:=
 config-version=2Eh doxygen
 
@@ -97,3 +100,7 @@
 	SOURCE_DIR=3D"$(abs_top_=
srcdir)" \
 	INCLUDE_FLAGS=3D"$(LIBNL_GENL_CFLAGS)" \
 		"$(top_srcdir)/dev=
-tools/run-cppcheck=2Esh"
+
+CODE_COVERAGE_LCOV_SHOPTS=3D--config-file $(sr=
cdir)/lcovrc
+clean-local: code-coverage-clean
+distclean-local: code-cover=
age-dist-clean
diff --git a/configure=2Eac b/configure=2Eac
index 469a475=
=2E=2Ebb9fd16 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -59,6 +59=
,8 @@
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS
 
+AX_CODE_COVERAGE
+
 A=
C_ARG_ENABLE(
 	[lzo],
 	[AS_HELP_STRING([--disable-lzo], [disable LZO comp=
ression support @<:@default=3Dyes@:>@])],
@@ -1236,6 +1238,11 @@
 	ACL_CHEC=
K_ADD_COMPILE_FLAGS([-Wno-cast-function-type])
 fi
 
+# If coverage is enab=
led remove -O arguments from CFLAGS
+if test "$enable_code_coverage" =3D "y=
es"; then
+   [CFLAGS=3D"`echo $CFLAGS | $SED -e 's/-O[s0-9]\\?//g'`"]
+fi
=
+
 if test "${enable_pedantic}" =3D "yes"; then
 	CFLAGS=3D"${CFLAGS} -peda=
ntic"
 	AC_DEFINE([PEDANTIC], [1], [Enable pedantic mode])
@@ -1355,10 +136=
2,10 @@
 
 TEST_LDFLAGS=3D"${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER=
_LIBS} ${OPTIONAL_LIBCAPNG_LIBS}"
 TEST_LDFLAGS=3D"${TEST_LDFLAGS} ${OPTION=
AL_LIBNL_GENL_LIBS}"
-TEST_LDFLAGS=3D"${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} =
${CMOCKA_LIBS}"
+TEST_LDFLAGS=3D"${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMO=
CKA_LIBS} ${CODE_COVERAGE_LIBS}"
 TEST_CFLAGS=3D"${OPTIONAL_CRYPTO_CFLAGS} =
${OPTIONAL_PKCS11_HELPER_CFLAGS} ${OPTIONAL_LIBCAPNG_CFLAGS}"
 TEST_CFLAGS=
=3D"${TEST_CFLAGS} ${OPTIONAL_LIBNL_GENL_CFLAGS} ${OPTIONAL_LZO_CFLAGS}"
-T=
EST_CFLAGS=3D"${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS}"
+TE=
ST_CFLAGS=3D"${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS} ${COD=
E_COVERAGE_CFLAGS}"
 
 AC_SUBST([TEST_LDFLAGS])
 AC_SUBST([TEST_CFLAGS])
di=
ff --git a/lcovrc b/lcovrc
new file mode 100644
index 0000000=2E=2E0e4ac46
=
--- /dev/null
+++ b/lcovrc
@@ -0,0 +1,2 @@
+geninfo_external =3D 0
+geninfo=
_unexecuted_blocks =3D 1
diff --git a/m4/ax_code_coverage=2Em4 b/m4/ax_code=
_coverage=2Em4
index 216708a4=2E=2E0b5b18b 100644
--- a/m4/ax_code_coverage=
=2Em4
+++ b/m4/ax_code_coverage=2Em4
@@ -76,8 +76,20 @@
 
 #serial 37
 
+AC=
_DEFUN([OPENVPN_PRINT_TO_FILE],[
+m4_esyscmd(
+[
+printf "%s" "$2" > "$1"
+=
])
+])
+
+AC_DEFUN([OPENVPN_ADD_AM_MACRO_STATIC],[
+  OPENVPN_PRINT_TO_FILE=
([aminclude_static=2Eam],[$1])
+])
+
 m4_define(_AX_CODE_COVERAGE_RULES,[
-=
AX_ADD_AM_MACRO_STATIC([
+OPENVPN_ADD_AM_MACRO_STATIC([
+# This file was ge=
nerated by ax_code_coverage
 # Code coverage
 #
 # Optional:
@@ -232,13 +24=
4,12 @@
 		AC_MSG_ERROR([Could not find genhtml from the lcov package])
 	]=
)
 
-	AC_CHECK_LIB([gcov], [_gcov_init], [CODE_COVERAGE_LIBS=3D"-lgcov"], [=
CODE_COVERAGE_LIBS=3D""])
-
 	dnl Build the code coverage flags
 	dnl Defin=
e CODE_COVERAGE_LDFLAGS for backwards compatibility
 	CODE_COVERAGE_CPPFLAG=
S=3D"-DNDEBUG"
-	CODE_COVERAGE_CFLAGS=3D"-O0 -g -fprofile-arcs -ftest-cover=
age"
-	CODE_COVERAGE_CXXFLAGS=3D"-O0 -g -fprofile-arcs -ftest-coverage"
+	C=
ODE_COVERAGE_CFLAGS=3D"-O0 -g --coverage"
+	CODE_COVERAGE_CXXFLAGS=3D"-O0 -=
g --coverage"
+	CODE_COVERAGE_LIBS=3D"--coverage"
 
 	AC_SUBST([CODE_COVERA=
GE_CPPFLAGS])
 	AC_SUBST([CODE_COVERAGE_CFLAGS])
diff --git a/src/openvpn/M=
akefile=2Eam b/src/openvpn/Makefile=2Eam
index 4220d07=2E=2E26eb36c 100644
=
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -31,9 +3=
1,12 @@
 	$(OPTIONAL_SYSTEMD_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \=

 	$(OPTIONAL_INOTIFY_CFLAGS) \
+	$(CODE_COVERAGE_CFLAGS) \
 	-DPLUGIN_LIBD=
IR=3D\"${plugindir}\" \
 	-DDEFAULT_DNS_UPDOWN=3D\"${scriptdir}/dns-updown\=
"
 
+AM_LIBS =3D $(CODE_COVERAGE_LIBS)
+
 if WIN32
 # we want unicode entry=
 point but not the macro
 AM_CFLAGS +=3D -municode -UUNICODE

-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976b0d=
fc2f765b33
Gerrit-Change-Number: 1592
Gerrit-PatchSet: 3
Gerrit-Owner: flic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>

--fYR9Q7Kr40w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, razvanc=2E </p>
<p>flichtenh=
eld <strong>uploaded patch set #3</strong> to this change=2E</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail">View Change=
</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">configure: Add --enable-code-coverage<br><br>Can be u=
sed like this<br>=2E/configure --enable-code-coverage<br>make<br>make check=
<br>make code-coverage-capture<br><br>Note that we patch ax_code_coverage=
=2Em4 to not incur<br>a dependency on autoconf-archive for a few lines of<b=
r>trivial code=2E<br><br>Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b=
33<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>-=
--<br>M =2Egitignore<br>M Makefile=2Eam<br>M configure=2Eac<br>A lcovrc<br>=
M m4/ax_code_coverage=2Em4<br>M src/openvpn/Makefile=2Eam<br>6 files change=
d, 41 insertions(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/92/1592/3</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/=2Egitignore b/=2Egitignore</span><br><span>index 04523af=2E=2Ee25=
e591 100644</span><br><span>--- a/=2Egitignore</span><br><span>+++ b/=2Egit=
ignore</span><br><span>@@ -1,5 +1,7 @@</span><br><span> *=2E[oa]</span><br>=
<span> *=2El[oa]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+*=
=2Egcda</span><br><span style=3D"color: hsl(120, 100%, 40%);">+*=2Egcno</sp=
an><br><span> *=2Edll</span><br><span> *=2Eexe</span><br><span> *=2Eexe=2E*=
</span><br><span>@@ -18,6 +20,7 @@</span><br><span> Makefile</span><br><spa=
n> Makefile=2Ein</span><br><span> aclocal=2Em4</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+aminclude_static=2Eam</span><br><span> autodefs=
=2Eh</span><br><span> autom4te=2Ecache</span><br><span> config=2Eguess</spa=
n><br><span>diff --git a/Makefile=2Eam b/Makefile=2Eam</span><br><span>inde=
x feeaabb=2E=2E716b2df 100644</span><br><span>--- a/Makefile=2Eam</span><br=
><span>+++ b/Makefile=2Eam</span><br><span>@@ -22,6 +22,8 @@</span><br><spa=
n> #  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&=
gt;=2E</span><br><span> #</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+include $(top_srcdir)/aminclude_static=2Eam</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> ACLOCAL_A=
MFLAGS =3D -I m4</span><br><span> </span><br><span> MAINTAINERCLEANFILES =
=3D \</span><br><span>@@ -45,7 +47,8 @@</span><br><span> 	CMakeLists=2Etxt =
\</span><br><span> 	CMakePresets=2Ejson \</span><br><span> 	config=2Eh=2Ecm=
ake=2Ein \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	forked-tes=
t-driver</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	forked-tes=
t-driver \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	lcovrc</=
span><br><span> </span><br><span> =2EPHONY: config-version=2Eh doxygen</spa=
n><br><span> </span><br><span>@@ -97,3 +100,7 @@</span><br><span> 	SOURCE_D=
IR=3D&quot;$(abs_top_srcdir)&quot; \</span><br><span> 	INCLUDE_FLAGS=3D&quo=
t;$(LIBNL_GENL_CFLAGS)&quot; \</span><br><span> 		&quot;$(top_srcdir)/dev-t=
ools/run-cppcheck=2Esh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CODE_COVER=
AGE_LCOV_SHOPTS=3D--config-file $(srcdir)/lcovrc</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+clean-local: code-coverage-clean</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+distclean-local: code-coverage-di=
st-clean</span><br><span>diff --git a/configure=2Eac b/configure=2Eac</span=
><br><span>index 469a475=2E=2Ebb9fd16 100644</span><br><span>--- a/configur=
e=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -59,6 +59,8 =
@@</span><br><span> AC_CANONICAL_HOST</span><br><span> AC_USE_SYSTEM_EXTENS=
IONS</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+AX_CODE_COVERAGE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> AC_ARG_ENABLE(</span><br><span> 	[lzo],</span><br><span> =
	[AS_HELP_STRING([--disable-lzo], [disable LZO compression support @&lt;:@d=
efault=3Dyes@:&gt;@])],</span><br><span>@@ -1236,6 +1238,11 @@</span><br><s=
pan> 	ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-cast-function-type])</span><br><spa=
n> fi</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# If coverage is enabled remove -O arguments from CFLAGS</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+if test &quot;$enable_code_coverag=
e&quot; =3D &quot;yes&quot;; then</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+   [CFLAGS=3D&quot;`echo $CFLAGS | $SED -e &#39;s/-O[s0-9]\\?=
//g&#39;`&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> if=
 test &quot;${enable_pedantic}&quot; =3D &quot;yes&quot;; then</span><br><s=
pan> 	CFLAGS=3D&quot;${CFLAGS} -pedantic&quot;</span><br><span> 	AC_DEFINE(=
[PEDANTIC], [1], [Enable pedantic mode])</span><br><span>@@ -1355,10 +1362,=
10 @@</span><br><span> </span><br><span> TEST_LDFLAGS=3D&quot;${OPTIONAL_CR=
YPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${OPTIONAL_LIBCAPNG_LIBS}&quot;</=
span><br><span> TEST_LDFLAGS=3D&quot;${TEST_LDFLAGS} ${OPTIONAL_LIBNL_GENL_=
LIBS}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_LDFLA=
GS=3D&quot;${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS}&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_LDFLAGS=3D&quot;${TES=
T_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS} ${CODE_COVERAGE_LIBS}&quot;<=
/span><br><span> TEST_CFLAGS=3D&quot;${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_P=
KCS11_HELPER_CFLAGS} ${OPTIONAL_LIBCAPNG_CFLAGS}&quot;</span><br><span> TES=
T_CFLAGS=3D&quot;${TEST_CFLAGS} ${OPTIONAL_LIBNL_GENL_CFLAGS} ${OPTIONAL_LZ=
O_CFLAGS}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_C=
FLAGS=3D&quot;${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS}&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_CFLAGS=3D&quo=
t;${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS} ${CODE_COVERAGE_=
CFLAGS}&quot;</span><br><span> </span><br><span> AC_SUBST([TEST_LDFLAGS])</=
span><br><span> AC_SUBST([TEST_CFLAGS])</span><br><span>diff --git a/lcovrc=
 b/lcovrc</span><br><span>new file mode 100644</span><br><span>index 000000=
0=2E=2E0e4ac46</span><br><span>--- /dev/null</span><br><span>+++ b/lcovrc</=
span><br><span>@@ -0,0 +1,2 @@</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+geninfo_external =3D 0</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+geninfo_unexecuted_blocks =3D 1</span><br><span>diff --git a/=
m4/ax_code_coverage=2Em4 b/m4/ax_code_coverage=2Em4</span><br><span>index 2=
16708a4=2E=2E0b5b18b 100644</span><br><span>--- a/m4/ax_code_coverage=2Em4<=
/span><br><span>+++ b/m4/ax_code_coverage=2Em4</span><br><span>@@ -76,8 +76=
,20 @@</span><br><span> </span><br><span> #serial 37</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_DEFUN([OPENVPN_PRINT_=
TO_FILE],[</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m4_esyscm=
d(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+[</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+printf &quot;%s&quot; &quot;$2&quot=
; &gt; &quot;$1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+])</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+AC_DEFUN([OPENVPN_ADD_AM_MACRO_STATIC],[</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  OPENVPN_PRINT_TO_FILE([aminc=
lude_static=2Eam],[$1])</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> m4_define(_AX_CODE_COVERAGE_RULES,[</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-AX_ADD_AM_MACRO_STATIC([</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+OPENVPN_ADD_AM_MACRO_STATIC([</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# This file was generated by ax_code_cove=
rage</span><br><span> # Code coverage</span><br><span> #</span><br><span> #=
 Optional:</span><br><span>@@ -232,13 +244,12 @@</span><br><span> 		AC_MSG_=
ERROR([Could not find genhtml from the lcov package])</span><br><span> 	])<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AC_=
CHECK_LIB([gcov], [_gcov_init], [CODE_COVERAGE_LIBS=3D&quot;-lgcov&quot;], =
[CODE_COVERAGE_LIBS=3D&quot;&quot;])</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span> 	dnl Build the code coverage flags</span><=
br><span> 	dnl Define CODE_COVERAGE_LDFLAGS for backwards compatibility</sp=
an><br><span> 	CODE_COVERAGE_CPPFLAGS=3D&quot;-DNDEBUG&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	CODE_COVERAGE_CFLAGS=3D&quot;-O0 -g=
 -fprofile-arcs -ftest-coverage&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	CODE_COVERAGE_CXXFLAGS=3D&quot;-O0 -g -fprofile-arcs -ftes=
t-coverage&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	CO=
DE_COVERAGE_CFLAGS=3D&quot;-O0 -g --coverage&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	CODE_COVERAGE_CXXFLAGS=3D&quot;-O0 -g --cov=
erage&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	CODE_CO=
VERAGE_LIBS=3D&quot;--coverage&quot;</span><br><span> </span><br><span> 	AC=
_SUBST([CODE_COVERAGE_CPPFLAGS])</span><br><span> 	AC_SUBST([CODE_COVERAGE_=
CFLAGS])</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openv=
pn/Makefile=2Eam</span><br><span>index 4220d07=2E=2E26eb36c 100644</span><b=
r><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/M=
akefile=2Eam</span><br><span>@@ -31,9 +31,12 @@</span><br><span> 	$(OPTIONA=
L_SYSTEMD_CFLAGS) \</span><br><span> 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \</s=
pan><br><span> 	$(OPTIONAL_INOTIFY_CFLAGS) \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	$(CODE_COVERAGE_CFLAGS) \</span><br><span> 	-DPLU=
GIN_LIBDIR=3D\&quot;${plugindir}\&quot; \</span><br><span> 	-DDEFAULT_DNS_U=
PDOWN=3D\&quot;${scriptdir}/dns-updown\&quot;</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+AM_LIBS =3D $(CODE_COVERAGE_LIB=
S)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 if WIN32</span><br><span> # we want unicode entry point but not the macro<=
/span><br><span> AM_CFLAGS +=3D -municode -UUNICODE</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1592?usp=3Demail">change 1592</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1592?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1592 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--fYR9Q7Kr40w=--


--===============3353809168824659943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3353809168824659943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3353809168824659943==--

