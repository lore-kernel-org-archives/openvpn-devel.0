Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738ACC5DF81
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FjgPca+4VHrh8zRSFmWZWZSKrs/6MK00prJRxvfG7wk=; b=KkB1L68fVZFcUnBdsEeP6h9f4+
	5Y+X8j5hCUyN7F4rh7J3SqgmsjWLRq15dzT5FFVx4O4aVBmyBWyea19Ajf1dTembxNEYSyrXJOf2R
	bCXBI2FnPh2Ux/mRezMbmGDvc4/CB64rP5OhagdUlQcA7ilSVXLZAHXwv5aL+OCGpA9w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyWEh-0001Ug-Fk;
	Mon, 24 Aug 2026 15:05:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyWEf-0001Ua-P5
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:05:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/ilf2x/c6HV2E8/ibWPbEdBJ2OXJjC7LPDxbKsSMPj0=; b=OV9FWmq1dK4BKgZ61i/TFE4bK+
 TL/bctDe2yJtpTCY+LrGS6mSMWv1JxX2qadtzhTYSMe3amSwmI1VNLaWFTo5CnLcS8uf4DkpWxFmF
 Csqetdw0PKYrhSn2M+qG/DVtrDyAmuhuSMuukG8IuSottO2GMFBWTiQA8sSJ4gjuR2Wc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/ilf2x/c6HV2E8/ibWPbEdBJ2OXJjC7LPDxbKsSMPj0=; b=A
 p6ZnUfYL1Dh9AgCQIzU5ILRIYPKfwDKq0ev93UNqwCRmG5Zt262DP3MBXHzla9xo6ab5VGU7NcLWk
 qk9FScO7Xc2AIIwlsleJqXV18/t9kwSofSBBp5t3Y9oRWwxCuVUF8uFDSKVCxkhXVMOQwQvWmh+S4
 8WQgxOWaNCt/5Ns8=;
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyWEc-00046h-7C for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:05:18 +0000
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6a3819e8be8so7566409a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787583907; x=1788188707; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/ilf2x/c6HV2E8/ibWPbEdBJ2OXJjC7LPDxbKsSMPj0=;
 b=YKtx1+n3GzdcXCOWMV1AVabsdHUkIMmh5r+kCNsmr0OjAJDC472yBL4nRhzNhWv2Ky
 D2PFnDv8FH6YNn1ecz8G9S0OZ8kfNxynJ7APlkh4M5UYUFfQ1CTK2mU0n6BuJTIaivwF
 iRzGTeHlSFSJwauYTNMoEgEvQLs7yySIUsTnbylgcc9sNKx6ELE2AkUaqWBs4FctuOTl
 /IalRB8hu7kxgibTUCK1Y0vCN2k1BQ/NlWVhoGlDeKf2I4eceL/pFdRHlLKwL81tK60r
 ptGLVuh+Eks3ja0nOHSRH7SU+Qpgh4Qlkpr+txGb9gdhRAR/eI4M/PxXesK33GpVUusY
 O7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787583907; x=1788188707;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/ilf2x/c6HV2E8/ibWPbEdBJ2OXJjC7LPDxbKsSMPj0=;
 b=p0rgXDu7KdgkVFkJTP2gbfM/mWpYOQ71Py36mmv/8lLDxEv1fQ7u29Z/Djfo4TMmHn
 tOauFl+YLa81lW5QOlce37XY9Z/sj6ufHhjfCmqWxqOiY+WIkr3fd9no7O7wMftgfxHw
 4mR4MBWY4a3vBcv4B7pAvlhtcaCy9FgOhxnlx1fFNRvvV7byjbh0AWnr1eXSZaAZQZX4
 CBm/v6MYyfxD0vGrnl4yCZLqp9mNO9++bHnuFLrz3L3lP4+6fT+/uVQesS8s66Vju27p
 +Vy85bi/gBIAJ+/ri69c6Y4t+7Ssa+dThfubWYL4ONfY8N52TZopH+W81Kiw/qZ0rcK1
 Rtlw==
X-Gm-Message-State: AFuF++kL2719DS9cqaQrLKMiKNoSbVOhmf1dO0bzUoqhiq1svzPeTlGn
 Z6TRzf6t2xVgyzG9u4UypctNE4ryE/Og9iDugWzSjp0V84huHImF4SPgcK8YnU73KfIgBYvktdi
 ZepSNyZlYSoBHOPzx4ZuRmCVagOYyJCNVrNs0jt0GMqGcF4w2WxIslb2y7zCsSY9JvHj0
X-Gm-Gg: AR+sD11Fl6kuIIc3xhYUMXLWILfzliM+ui/Xsh+0H+/D9U4xgrf86yrvi4aqQUdmMcK
 m6B5hVANJ/2RT+mozmxV0HjVxnIIsX0RRkvMyon7D8okcwj3bmGaspn/xkd+1/aPf1LbwAZzYqv
 /MV9L5/7paI60qN1l31KR44BGPJEkI3LKJ4kuvE/1PbHdZBeM1kRDBXO/5GDWqulS23JTV/pzKv
 eD6ZPKLf+pbgXPrVvemPTtW3UIdO90C5tcIVlYZIzVdnV+/mxHBTa3vPtjGCEQdNwdxTLvcgC2l
 ItyZkf+DG+X/hSuBJSwzqNYbHNjD5fn+zq3ZxsMLvGh/fU1exzicZeKDjS49QpgK84riTjV80iV
 qj0lT+6CGXg0kguiWpW6GUWW78VPp+EhgesCcIBD4iMc2OC3rl0zveycvJKIFOpgJE4oMZT0w0x
 imMsQSreCb4ZQd22E/9bjrfXE/zSBfZTsBfUMRv3pFe4VK+ahH9EFACKLBoiBC51OIY9Z+lCyO3
 jqLeMCShRBCMNZsYN2r6Ed33Fk0ro/+dFOtW95XCzFTOW9xSrEFAk6NhplexBeXtiHcWpktgX6d
 yblIRAIeJ9lVp64eWxImOIunc2R74xUeQZbgdk6EZzRK0OhQkwM=
X-Received: by 2002:a05:6402:2187:b0:6a0:a46b:ad3c with SMTP id
 4fb4d7f45d1cf-6a430b6cfeamr24010002a12.1.1787583906856; 
 Mon, 24 Aug 2026 08:05:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e2d8ae9sm9386915a12.28.2026.08.24.08.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:05:06 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 15:05:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
X-Gerrit-Change-Number: 1592
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1592?usp=email>
X-Gerrit-Commit: f56747651fa06686bce6339595aa241adc83e990
In-Reply-To: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
References: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0NDUxMzgwMDAwLkk3OWIyZGM0YTU1MGIxYzUwNjhhNDU0MDc5NzZiMGRmYzJmNzY1YjMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8373a2759cdd887170946782276c7338aa815c3f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyWEc-00046h-7C
Subject: [Openvpn-devel] [M] Change in openvpn[master]: configure: Add
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
Content-Type: multipart/mixed; boundary="===============1988936415394348185=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1988936415394348185==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9J9LUJhfF34="; charset=UTF-8

--9J9LUJhfF34=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, razvanc, 

I'd like you to reexamine a change=2E Please visit

    =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail

to look at the =
new patch set (#5)=2E


Change subject: configure: Add --enable-code-covera=
ge
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

configure:=
 Add --enable-code-coverage

Can be used like this
=2E/configure --enable-c=
ode-coverage
make
make check
make code-coverage-capture

We heavily patch a=
x_code_coverage=2Em4, mostly to
achieve better compatibility with non-Linux=
 systems=2E
- Do not depend on autoconf-archive
- Do not depend on GNU make=

- Use more modern --coverage flag to better support
  different compilers
=

Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
Signed-off-by: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
---
M =2Egitignore
M Makefile=2Eam
M =
configure=2Eac
A lcovrc
M m4/ax_code_coverage=2Em4
M src/openvpn/Makefile=
=2Eam
6 files changed, 114 insertions(+), 43 deletions(-)


  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/92/1592/5

diff --git a=
/=2Egitignore b/=2Egitignore
index 04523af=2E=2E2749739 100644
--- a/=2Egit=
ignore
+++ b/=2Egitignore
@@ -1,5 +1,9 @@
 *=2E[oa]
 *=2El[oa]
+*=2Egcda
+*=
=2Egcno
+*-coverage/
+*-coverage=2Einfo
 *=2Edll
 *=2Eexe
 *=2Eexe=2E*
@@ -=
18,6 +22,7 @@
 Makefile
 Makefile=2Ein
 aclocal=2Em4
+aminclude_static=2Eam=

 autodefs=2Eh
 autom4te=2Ecache
 config=2Eguess
diff --git a/Makefile=2Eam=
 b/Makefile=2Eam
index feeaabb=2E=2E716b2df 100644
--- a/Makefile=2Eam
+++ =
b/Makefile=2Eam
@@ -22,6 +22,8 @@
 #  with this program; if not, see <https=
://www=2Egnu=2Eorg/licenses/>=2E
 #
 
+include $(top_srcdir)/aminclude_stat=
ic=2Eam
+
 ACLOCAL_AMFLAGS =3D -I m4
 
 MAINTAINERCLEANFILES =3D \
@@ -45,7=
 +47,8 @@
 	CMakeLists=2Etxt \
 	CMakePresets=2Ejson \
 	config=2Eh=2Ecmake=
=2Ein \
-	forked-test-driver
+	forked-test-driver \
+	lcovrc
 
 =2EPHONY: c=
onfig-version=2Eh doxygen
 
@@ -97,3 +100,7 @@
 	SOURCE_DIR=3D"$(abs_top_sr=
cdir)" \
 	INCLUDE_FLAGS=3D"$(LIBNL_GENL_CFLAGS)" \
 		"$(top_srcdir)/dev-t=
ools/run-cppcheck=2Esh"
+
+CODE_COVERAGE_LCOV_SHOPTS=3D--config-file $(srcd=
ir)/lcovrc
+clean-local: code-coverage-clean
+distclean-local: code-coverag=
e-dist-clean
diff --git a/configure=2Eac b/configure=2Eac
index 469a475=2E=
=2E6772beb 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -59,6 +59,8 =
@@
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS
 
+AX_CODE_COVERAGE
+
 AC_A=
RG_ENABLE(
 	[lzo],
 	[AS_HELP_STRING([--disable-lzo], [disable LZO compres=
sion support @<:@default=3Dyes@:>@])],
@@ -1236,6 +1238,11 @@
 	ACL_CHECK_A=
DD_COMPILE_FLAGS([-Wno-cast-function-type])
 fi
 
+# If coverage is enabled=
 remove -O arguments from CFLAGS
+if test "$enable_code_coverage" =3D "yes"=
; then
+   [CFLAGS=3D"`echo $CFLAGS | $SED -e 's/-O[a-z0-9]*//g'`"]
+fi
+
 =
if test "${enable_pedantic}" =3D "yes"; then
 	CFLAGS=3D"${CFLAGS} -pedanti=
c"
 	AC_DEFINE([PEDANTIC], [1], [Enable pedantic mode])
@@ -1355,10 +1362,1=
0 @@
 
 TEST_LDFLAGS=3D"${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LI=
BS} ${OPTIONAL_LIBCAPNG_LIBS}"
 TEST_LDFLAGS=3D"${TEST_LDFLAGS} ${OPTIONAL_=
LIBNL_GENL_LIBS}"
-TEST_LDFLAGS=3D"${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${C=
MOCKA_LIBS}"
+TEST_LDFLAGS=3D"${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA=
_LIBS} ${CODE_COVERAGE_LIBS}"
 TEST_CFLAGS=3D"${OPTIONAL_CRYPTO_CFLAGS} ${O=
PTIONAL_PKCS11_HELPER_CFLAGS} ${OPTIONAL_LIBCAPNG_CFLAGS}"
 TEST_CFLAGS=3D"=
${TEST_CFLAGS} ${OPTIONAL_LIBNL_GENL_CFLAGS} ${OPTIONAL_LZO_CFLAGS}"
-TEST_=
CFLAGS=3D"${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS}"
+TEST_C=
FLAGS=3D"${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS} ${CODE_CO=
VERAGE_CFLAGS}"
 
 AC_SUBST([TEST_LDFLAGS])
 AC_SUBST([TEST_CFLAGS])
diff -=
-git a/lcovrc b/lcovrc
new file mode 100644
index 0000000=2E=2Ef8b4138
--- =
/dev/null
+++ b/lcovrc
@@ -0,0 +1,2 @@
+geninfo_external =3D 1
+geninfo_une=
xecuted_blocks =3D 1
diff --git a/m4/ax_code_coverage=2Em4 b/m4/ax_code_cov=
erage=2Em4
index 216708a4=2E=2Ef156d4d 100644
--- a/m4/ax_code_coverage=2Em=
4
+++ b/m4/ax_code_coverage=2Em4
@@ -42,8 +42,8 @@
 #     clean-local: code=
-coverage-clean
 #     distclean-local: code-coverage-dist-clean
 #
-#   Th=
is results in a "check-code-coverage" rule being added to any
-#   Makefile=
=2Eam which do "include $(top_srcdir)/aminclude_static=2Eam"
+#   This resu=
lts in a "check-code-coverage" rule being added to the
+#   Makefile=2Eam w=
hich does "include $(top_srcdir)/aminclude_static=2Eam"
 #   (assuming the =
module has been configured with --enable-code-coverage)=2E
 #   Running `ma=
ke check-code-coverage` in that directory will run the
 #   module's test s=
uite (`make check`) and build a code coverage report
@@ -76,10 +76,51 @@
 
=
 #serial 37
 
+dnl Local modifications compared to the autoconf-archive ver=
sion:
+dnl
+dnl  - AX_ADD_AM_MACRO_STATIC (from autoconf-archive) is replac=
ed by a
+dnl    minimal local equivalent, OPENVPN_ADD_AM_MACRO_STATIC, so t=
hat we do
+dnl    not depend on autoconf-archive being installed=2E
+dnl  -=
 The generated rules no longer require GNU make=2E  The AX_CHECK_GNU_MAKE
+=
dnl    check is gone (which also removed the last autoconf-archive
+dnl    =
dependency) and the GNU make specific constructs in the rules were
+dnl    =
replaced:
+dnl      * the "ifeq ($(abs_builddir), $(abs_top_builddir))" gua=
rd is gone,
+dnl        aminclude_static=2Eam may only be included by the t=
op level
+dnl        Makefile=2Eam now (which is the only place it was ever=
 included
+dnl        from in this project),
+dnl      * $(addprefix =2E=2E=
=2E) and $(if =2E=2E=2E) are replaced by shell code inside
+dnl        the =
recipes,
+dnl      * $(call =2E=2E=2E)/$(subst =2E=2E=2E) for the lcov test=
 name is replaced by
+dnl        CODE_COVERAGE_TEST_NAME, computed at confi=
gure time,
+dnl      * "find =2E=2E=2E -delete" is replaced by "find =2E=2E=
=2E -exec rm -f {} +"=2E
+dnl    The only remaining non-POSIX construct is =
the nested variable
+dnl    expansion used for the silent rules ($(foo_$(V)=
)), which is the same
+dnl    idiom automake itself uses for AM_V_at and fr=
iends and which is
+dnl    understood by BSD make as well=2E
+
+AC_DEFUN([O=
PENVPN_PRINT_TO_FILE],[
+m4_esyscmd(
+[
+printf "%s" "$2" > "$1"
+])
+])
+
=
+AC_DEFUN([OPENVPN_ADD_AM_MACRO_STATIC],[
+  OPENVPN_PRINT_TO_FILE([aminclu=
de_static=2Eam],[$1])
+])
+
 m4_define(_AX_CODE_COVERAGE_RULES,[
-AX_ADD_AM=
_MACRO_STATIC([
+OPENVPN_ADD_AM_MACRO_STATIC([
+# This file was generated b=
y ax_code_coverage
 # Code coverage
 #
+# This file must only be included b=
y the top level Makefile=2Eam: the rules
+# below always report on the comp=
lete build tree=2E
+#
+# The rules avoid GNU make specific syntax so that t=
hey also work with
+# other make implementations, e=2Eg=2E BSD make=2E
+#
 =
# Optional:
 #  - CODE_COVERAGE_DIRECTORY: Top-level directory for code cov=
erage reporting=2E
 #    Multiple directories may be specified, separated b=
y whitespace=2E
@@ -90,51 +131,51 @@
 #  - CODE_COVERAGE_OUTPUT_DIRECTORY: =
Directory for generated code coverage
 #    reports to be created=2E (Defau=
lt:
 #    \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage)
+#  - CODE_COVERAG=
E_TEST_NAME: Test name to record in the =2Einfo file=2E  It is
+#    comput=
ed by configure (\$(PACKAGE_NAME)-\$(PACKAGE_VERSION), with dashes
+#    an=
d dots replaced by underscores) and can be overridden by defining it
+#    =
in Makefile=2Eam=2E
 #  - CODE_COVERAGE_BRANCH_COVERAGE: Set to 1 to enforc=
e branch coverage,
 #    set to 0 to disable it and leave empty to stay wit=
h the default=2E
-#    (Default: empty)
+#    The corresponding --rc option=
 is passed to lcov and genhtml in
+#    addition to the options below=2E (D=
efault: empty)
 #  - CODE_COVERAGE_LCOV_SHOPTS_DEFAULT: Extra options share=
d between both lcov
-#    instances=2E (Default: based on $CODE_COVERAGE_BR=
ANCH_COVERAGE)
+#    instances=2E (Default: empty)
 #  - CODE_COVERAGE_LCOV=
_SHOPTS: Extra options to shared between both lcov
-#    instances=2E (Defa=
ult: $CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)
+#    instances=2E (Default: \$COD=
E_COVERAGE_LCOV_SHOPTS_DEFAULT)
 #  - CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH: =
--gcov-tool pathtogcov
 #  - CODE_COVERAGE_LCOV_OPTIONS_DEFAULT: Extra opti=
ons to pass to the
-#    collecting lcov instance=2E (Default: $CODE_COVERA=
GE_LCOV_OPTIONS_GCOVPATH)
+#    collecting lcov instance=2E (Default: \$COD=
E_COVERAGE_LCOV_OPTIONS_GCOVPATH)
 #  - CODE_COVERAGE_LCOV_OPTIONS: Extra o=
ptions to pass to the collecting lcov
-#    instance=2E (Default: $CODE_COV=
ERAGE_LCOV_OPTIONS_DEFAULT)
+#    instance=2E (Default: \$CODE_COVERAGE_LCO=
V_OPTIONS_DEFAULT)
 #  - CODE_COVERAGE_LCOV_RMOPTS_DEFAULT: Extra options t=
o pass to the filtering
 #    lcov instance=2E (Default: empty)
-#  - CODE_=
COVERAGE_LCOV_RMOPTS: Extra options to pass to the filtering lcov
-#    ins=
tance=2E (Default: $CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)
+#  - CODE_COVERAGE_=
LCOV_RMOPTS: Extra options to pass to the filtering
+#    lcov instance=2E =
(Default: \$CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)
 #  - CODE_COVERAGE_GENHTML_=
OPTIONS_DEFAULT: Extra options to pass to the
-#    genhtml instance=2E (De=
fault: based on $CODE_COVERAGE_BRANCH_COVERAGE)
+#    genhtml instance=2E (=
Default: empty)
 #  - CODE_COVERAGE_GENHTML_OPTIONS: Extra options to pass =
to the genhtml
-#    instance=2E (Default: $CODE_COVERAGE_GENHTML_OPTIONS_D=
EFAULT)
+#    instance=2E (Default: \$CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT=
)
 #  - CODE_COVERAGE_IGNORE_PATTERN: Extra glob pattern of files to ignore=

 #
 # The generated report will be titled using the \$(PACKAGE_NAME) and
 =
# \$(PACKAGE_VERSION)=2E In order to add the current git hash to the title,=

 # use the git-version-gen script, available online=2E
 # Optional variabl=
es
-# run only on top dir
 if CODE_COVERAGE_ENABLED
- ifeq (\$(abs_builddir=
), \$(abs_top_builddir))
 CODE_COVERAGE_DIRECTORY ?=3D \$(top_builddir)
 CO=
DE_COVERAGE_OUTPUT_FILE ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage=
=2Einfo
 CODE_COVERAGE_OUTPUT_DIRECTORY ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VE=
RSION)-coverage
 
 CODE_COVERAGE_BRANCH_COVERAGE ?=3D
-CODE_COVERAGE_LCOV_S=
HOPTS_DEFAULT ?=3D \$(if \$(CODE_COVERAGE_BRANCH_COVERAGE),\
---rc lcov_bra=
nch_coverage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE))
+CODE_COVERAGE_LCOV_SHOPT=
S_DEFAULT ?=3D
 CODE_COVERAGE_LCOV_SHOPTS ?=3D \$(CODE_COVERAGE_LCOV_SHOPTS=
_DEFAULT)
 CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH ?=3D --gcov-tool \"\$(GCOV)\=
"
 CODE_COVERAGE_LCOV_OPTIONS_DEFAULT ?=3D \$(CODE_COVERAGE_LCOV_OPTIONS_GC=
OVPATH)
 CODE_COVERAGE_LCOV_OPTIONS ?=3D \$(CODE_COVERAGE_LCOV_OPTIONS_DEFA=
ULT)
 CODE_COVERAGE_LCOV_RMOPTS_DEFAULT ?=3D
 CODE_COVERAGE_LCOV_RMOPTS ?=
=3D \$(CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)
-CODE_COVERAGE_GENHTML_OPTIONS_DE=
FAULT ?=3D\
-\$(if \$(CODE_COVERAGE_BRANCH_COVERAGE),\
---rc genhtml_branch=
_coverage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE))
+CODE_COVERAGE_GENHTML_OPTIO=
NS_DEFAULT ?=3D
 CODE_COVERAGE_GENHTML_OPTIONS ?=3D \$(CODE_COVERAGE_GENHTM=
L_OPTIONS_DEFAULT)
 CODE_COVERAGE_IGNORE_PATTERN ?=3D
 
@@ -152,8 +193,15 @=
@
 code_coverage_quiet_ =3D \$(code_coverage_quiet_\$(AM_DEFAULT_VERBOSITY)=
)
 code_coverage_quiet_0 =3D --quiet
 
-# sanitizes the test-name: replaces=
 with underscores: dashes and dots
-code_coverage_sanitize =3D \$(subst -,_=
,\$(subst =2E,_,\$(1)))
+# Shell fragments used by the recipes below=2E  Th=
ey are portable
+# replacements for the GNU make functions \$(addprefix =2E=
=2E=2E) and \$(if =2E=2E=2E):
+# code_coverage_dirs_opt sets \$cc_dirs to a=
 list of --directory options,
+# code_coverage_prefix_opt sets \$cc_prefix =
to a list of --prefix options and
+# code_coverage_*_branch_opt set \$cc_br=
anch to the branch coverage option=2E
+code_coverage_dirs_opt =3D cc_dirs=
=3D; for cc_dir in \$(CODE_COVERAGE_DIRECTORY); do cc_dirs=3D\"\$\$cc_dirs =
--directory \$\$cc_dir\"; done
+code_coverage_prefix_opt =3D cc_prefix=3D; =
for cc_dir in \$(CODE_COVERAGE_DIRECTORY); do cc_prefix=3D\"\$\$cc_prefix -=
-prefix \$\$cc_dir\"; done
+code_coverage_lcov_branch_opt =3D cc_branch=3D;=
 test -z \"\$(CODE_COVERAGE_BRANCH_COVERAGE)\" || cc_branch=3D\"--rc lcov_b=
ranch_coverage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE)\"
+code_coverage_genhtml=
_branch_opt =3D cc_branch=3D; test -z \"\$(CODE_COVERAGE_BRANCH_COVERAGE)\"=
 || cc_branch=3D\"--rc genhtml_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_CO=
VERAGE)\"
 
 # Use recursive makes in order to ignore errors during check
 =
check-code-coverage:
@@ -162,29 +210,26 @@
 
 # Capture code coverage data
=
 code-coverage-capture: code-coverage-capture-hook
-	\$(code_coverage_v_lco=
v_cap)\$(LCOV) \$(code_coverage_quiet) \$(addprefix --directory ,\$(CODE_CO=
VERAGE_DIRECTORY)) --capture --output-file \"\$(CODE_COVERAGE_OUTPUT_FILE)=
=2Etmp\" --test-name \"\$(call code_coverage_sanitize,\$(PACKAGE_NAME)-\$(P=
ACKAGE_VERSION))\" --no-checksum --compat-libtool \$(CODE_COVERAGE_LCOV_SHO=
PTS) \$(CODE_COVERAGE_LCOV_OPTIONS)
-	\$(code_coverage_v_lcov_ign)\$(LCOV) =
\$(code_coverage_quiet) \$(addprefix --directory ,\$(CODE_COVERAGE_DIRECTOR=
Y)) --remove \"\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\" \$(CODE_COVERAGE_IGNOR=
E_PATTERN) --output-file \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \$(CODE_COVERAGE=
_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_RMOPTS)
+	\$(code_coverage_v_lcov_cap)\=
$(code_coverage_dirs_opt); \\
+	\$(code_coverage_lcov_branch_opt); \\
+	\$(=
LCOV) \$(code_coverage_quiet) \$\$cc_dirs --capture --output-file \"\$(CODE=
_COVERAGE_OUTPUT_FILE)=2Etmp\" --test-name \"\$(CODE_COVERAGE_TEST_NAME)\" =
--no-checksum --compat-libtool \$\$cc_branch \$(CODE_COVERAGE_LCOV_SHOPTS) =
\$(CODE_COVERAGE_LCOV_OPTIONS)
+	\$(code_coverage_v_lcov_ign)\$(code_covera=
ge_dirs_opt); \\
+	\$(code_coverage_lcov_branch_opt); \\
+	\$(LCOV) \$(code=
_coverage_quiet) \$\$cc_dirs --remove \"\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp=
\" \$(CODE_COVERAGE_IGNORE_PATTERN) --output-file \"\$(CODE_COVERAGE_OUTPUT=
_FILE)\" \$\$cc_branch \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_=
RMOPTS)
 	-@rm -f \"\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\"
-	\$(code_coverag=
e_v_genhtml)LANG=3DC \$(GENHTML) \$(code_coverage_quiet) \$(addprefix --pre=
fix ,\$(CODE_COVERAGE_DIRECTORY)) --output-directory \"\$(CODE_COVERAGE_OUT=
PUT_DIRECTORY)\" --title \"\$(PACKAGE_NAME)-\$(PACKAGE_VERSION) Code Covera=
ge\" --legend --show-details \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \$(CODE_COVE=
RAGE_GENHTML_OPTIONS)
+	\$(code_coverage_v_genhtml)\$(code_coverage_prefix_=
opt); \\
+	\$(code_coverage_genhtml_branch_opt); \\
+	LANG=3DC \$(GENHTML) =
\$(code_coverage_quiet) \$\$cc_prefix --output-directory \"\$(CODE_COVERAGE=
_OUTPUT_DIRECTORY)\" --title \"\$(PACKAGE_NAME)-\$(PACKAGE_VERSION) Code Co=
verage\" --legend --show-details \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \$\$cc_b=
ranch \$(CODE_COVERAGE_GENHTML_OPTIONS)
 	@echo \"file://\$(abs_builddir)/\=
$(CODE_COVERAGE_OUTPUT_DIRECTORY)/index=2Ehtml\"
 
 code-coverage-clean:
 	=
-\$(LCOV) --directory \$(top_builddir) -z
 	-rm -rf \"\$(CODE_COVERAGE_OUTP=
UT_FILE)\" \"\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\" \"\$(CODE_COVERAGE_OUTPU=
T_DIRECTORY)\"
-	-find =2E \\( -name \"*=2Egcda\" -o -name \"*=2Egcno\" -o =
-name \"*=2Egcov\" \\) -delete
+	-find =2E \\( -name \"*=2Egcda\" -o -name =
\"*=2Egcno\" -o -name \"*=2Egcov\" \\) -exec rm -f '{}' +
 
 code-coverage-=
dist-clean:
 
 A][M_DISTCHECK_CONFIGURE_FLAGS :=3D \$(A][M_DISTCHECK_CONFIG=
URE_FLAGS) --disable-code-coverage
- else # ifneq (\$(abs_builddir), \$(abs=
_top_builddir))
-check-code-coverage:
-
-code-coverage-capture: code-covera=
ge-capture-hook
-
-code-coverage-clean:
-
-code-coverage-dist-clean:
- endi=
f # ifeq (\$(abs_builddir), \$(abs_top_builddir))
 else #! CODE_COVERAGE_EN=
ABLED
 # Use recursive makes in order to ignore errors during check
 check-=
code-coverage:
@@ -206,8 +251,7 @@
 ])
 
 AC_DEFUN([_AX_CODE_COVERAGE_ENABL=
ED],[
-	AX_CHECK_GNU_MAKE([],[AC_MSG_ERROR([not using GNU make that is need=
ed for coverage])])
-	AC_REQUIRE([AX_ADD_AM_MACRO_STATIC])
+	AC_REQUIRE([OP=
ENVPN_ADD_AM_MACRO_STATIC])
 	# check for gcov
 	AC_CHECK_TOOL([GCOV],
 		 =
 [$_AX_CODE_COVERAGE_GCOV_PROG_WITH],
@@ -232,13 +276,12 @@
 		AC_MSG_ERROR=
([Could not find genhtml from the lcov package])
 	])
 
-	AC_CHECK_LIB([gco=
v], [_gcov_init], [CODE_COVERAGE_LIBS=3D"-lgcov"], [CODE_COVERAGE_LIBS=3D""=
])
-
 	dnl Build the code coverage flags
 	dnl Define CODE_COVERAGE_LDFLAGS=
 for backwards compatibility
 	CODE_COVERAGE_CPPFLAGS=3D"-DNDEBUG"
-	CODE_C=
OVERAGE_CFLAGS=3D"-O0 -g -fprofile-arcs -ftest-coverage"
-	CODE_COVERAGE_CX=
XFLAGS=3D"-O0 -g -fprofile-arcs -ftest-coverage"
+	CODE_COVERAGE_CFLAGS=3D"=
-O0 -g --coverage"
+	CODE_COVERAGE_CXXFLAGS=3D"-O0 -g --coverage"
+	CODE_CO=
VERAGE_LIBS=3D"--coverage"
 
 	AC_SUBST([CODE_COVERAGE_CPPFLAGS])
 	AC_SUBS=
T([CODE_COVERAGE_CFLAGS])
@@ -265,6 +308,10 @@
 	AC_SUBST([CODE_COVERAGE_EN=
ABLED], [$enable_code_coverage])
 	AC_MSG_RESULT($enable_code_coverage)
 
+=
	dnl The lcov test name must not contain dashes or dots
+	CODE_COVERAGE_TES=
T_NAME=3D`echo "$PACKAGE_NAME-$PACKAGE_VERSION" | tr '=2E-' '__'`
+	AC_SUBS=
T([CODE_COVERAGE_TEST_NAME])
+
 	AS_IF([ test "x$enable_code_coverage" =3D =
xyes ], [
 		_AX_CODE_COVERAGE_ENABLED
 	      ])
diff --git a/src/openvpn/=
Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 7fd12b4=2E=2E488d0a5 100644=

--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -31,9 +=
31,12 @@
 	$(OPTIONAL_SYSTEMD_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) =
\
 	$(OPTIONAL_INOTIFY_CFLAGS) \
+	$(CODE_COVERAGE_CFLAGS) \
 	-DPLUGIN_LIB=
DIR=3D\"${plugindir}\" \
 	-DDEFAULT_DNS_UPDOWN=3D\"${scriptdir}/dns-updown=
\"
 
+AM_LDFLAGS =3D $(CODE_COVERAGE_LIBS)
+
 if WIN32
 # we want unicode e=
ntry point but not the macro
 AM_CFLAGS +=3D -municode -UUNICODE

-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I79b2dc4a550b1c5068a45407=
976b0dfc2f765b33
Gerrit-Change-Number: 1592
Gerrit-PatchSet: 5
Gerrit-Owner=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld=
 <frank@lichtenheld=2Ecom>

--9J9LUJhfF34=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #5</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">configure: Add --enable-code-coverage<br><br>Can be used like t=
his<br>=2E/configure --enable-code-coverage<br>make<br>make check<br>make c=
ode-coverage-capture<br><br>We heavily patch ax_code_coverage=2Em4, mostly =
to<br>achieve better compatibility with non-Linux systems=2E<br>- Do not de=
pend on autoconf-archive<br>- Do not depend on GNU make<br>- Use more moder=
n --coverage flag to better support<br>  different compilers<br><br>Change-=
Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33<br>Signed-off-by: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M =2Egitignore<br>M Makefi=
le=2Eam<br>M configure=2Eac<br>A lcovrc<br>M m4/ax_code_coverage=2Em4<br>M =
src/openvpn/Makefile=2Eam<br>6 files changed, 114 insertions(+), 43 deletio=
ns(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/92/1592/5</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/=2Egitignore b/=2Egit=
ignore</span><br><span>index 04523af=2E=2E2749739 100644</span><br><span>--=
- a/=2Egitignore</span><br><span>+++ b/=2Egitignore</span><br><span>@@ -1,5=
 +1,9 @@</span><br><span> *=2E[oa]</span><br><span> *=2El[oa]</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+*=2Egcda</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+*=2Egcno</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+*-coverage/</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+*-coverage=2Einfo</span><br><span> *=2Edll</span><br><span> *=
=2Eexe</span><br><span> *=2Eexe=2E*</span><br><span>@@ -18,6 +22,7 @@</span=
><br><span> Makefile</span><br><span> Makefile=2Ein</span><br><span> acloca=
l=2Em4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+aminclude_sta=
tic=2Eam</span><br><span> autodefs=2Eh</span><br><span> autom4te=2Ecache</s=
pan><br><span> config=2Eguess</span><br><span>diff --git a/Makefile=2Eam b/=
Makefile=2Eam</span><br><span>index feeaabb=2E=2E716b2df 100644</span><br><=
span>--- a/Makefile=2Eam</span><br><span>+++ b/Makefile=2Eam</span><br><spa=
n>@@ -22,6 +22,8 @@</span><br><span> #  with this program; if not, see &lt;=
https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span> #</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+include $(top_src=
dir)/aminclude_static=2Eam</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> ACLOCAL_AMFLAGS =3D -I m4</span><br><span> </span>=
<br><span> MAINTAINERCLEANFILES =3D \</span><br><span>@@ -45,7 +47,8 @@</sp=
an><br><span> 	CMakeLists=2Etxt \</span><br><span> 	CMakePresets=2Ejson \</=
span><br><span> 	config=2Eh=2Ecmake=2Ein \</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	forked-test-driver</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	forked-test-driver \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	lcovrc</span><br><span> </span><br><span> =2EPHONY:=
 config-version=2Eh doxygen</span><br><span> </span><br><span>@@ -97,3 +100=
,7 @@</span><br><span> 	SOURCE_DIR=3D&quot;$(abs_top_srcdir)&quot; \</span>=
<br><span> 	INCLUDE_FLAGS=3D&quot;$(LIBNL_GENL_CFLAGS)&quot; \</span><br><s=
pan> 		&quot;$(top_srcdir)/dev-tools/run-cppcheck=2Esh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+CODE_COVERAGE_LCOV_SHOPTS=3D--config-file $(srcdir)/l=
covrc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+clean-local: c=
ode-coverage-clean</span><br><span style=3D"color: hsl(120, 100%, 40%);">+d=
istclean-local: code-coverage-dist-clean</span><br><span>diff --git a/confi=
gure=2Eac b/configure=2Eac</span><br><span>index 469a475=2E=2E6772beb 10064=
4</span><br><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac=
</span><br><span>@@ -59,6 +59,8 @@</span><br><span> AC_CANONICAL_HOST</span=
><br><span> AC_USE_SYSTEM_EXTENSIONS</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+AX_CODE_COVERAGE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> AC_ARG_ENABLE(</span><b=
r><span> 	[lzo],</span><br><span> 	[AS_HELP_STRING([--disable-lzo], [disabl=
e LZO compression support @&lt;:@default=3Dyes@:&gt;@])],</span><br><span>@=
@ -1236,6 +1238,11 @@</span><br><span> 	ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-c=
ast-function-type])</span><br><span> fi</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# If coverage is enabled remove -O ar=
guments from CFLAGS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
if test &quot;$enable_code_coverage&quot; =3D &quot;yes&quot;; then</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+   [CFLAGS=3D&quot;`echo $C=
FLAGS | $SED -e &#39;s/-O[a-z0-9]*//g&#39;`&quot;]</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> if test &quot;${enable_pedantic}&quot; =3D =
&quot;yes&quot;; then</span><br><span> 	CFLAGS=3D&quot;${CFLAGS} -pedantic&=
quot;</span><br><span> 	AC_DEFINE([PEDANTIC], [1], [Enable pedantic mode])<=
/span><br><span>@@ -1355,10 +1362,10 @@</span><br><span> </span><br><span> =
TEST_LDFLAGS=3D&quot;${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS}=
 ${OPTIONAL_LIBCAPNG_LIBS}&quot;</span><br><span> TEST_LDFLAGS=3D&quot;${TE=
ST_LDFLAGS} ${OPTIONAL_LIBNL_GENL_LIBS}&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-TEST_LDFLAGS=3D&quot;${TEST_LDFLAGS} ${OPTIONAL_LZO=
_LIBS} ${CMOCKA_LIBS}&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+TEST_LDFLAGS=3D&quot;${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_=
LIBS} ${CODE_COVERAGE_LIBS}&quot;</span><br><span> TEST_CFLAGS=3D&quot;${OP=
TIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS} ${OPTIONAL_LIBCAPNG_=
CFLAGS}&quot;</span><br><span> TEST_CFLAGS=3D&quot;${TEST_CFLAGS} ${OPTIONA=
L_LIBNL_GENL_CFLAGS} ${OPTIONAL_LZO_CFLAGS}&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-TEST_CFLAGS=3D&quot;${TEST_CFLAGS} -I\$(top_src=
dir)/include ${CMOCKA_CFLAGS}&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+TEST_CFLAGS=3D&quot;${TEST_CFLAGS} -I\$(top_srcdir)/include=
 ${CMOCKA_CFLAGS} ${CODE_COVERAGE_CFLAGS}&quot;</span><br><span> </span><br=
><span> AC_SUBST([TEST_LDFLAGS])</span><br><span> AC_SUBST([TEST_CFLAGS])</=
span><br><span>diff --git a/lcovrc b/lcovrc</span><br><span>new file mode 1=
00644</span><br><span>index 0000000=2E=2Ef8b4138</span><br><span>--- /dev/n=
ull</span><br><span>+++ b/lcovrc</span><br><span>@@ -0,0 +1,2 @@</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+geninfo_external =3D 1</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+geninfo_unexecuted_blocks =
=3D 1</span><br><span>diff --git a/m4/ax_code_coverage=2Em4 b/m4/ax_code_co=
verage=2Em4</span><br><span>index 216708a4=2E=2Ef156d4d 100644</span><br><s=
pan>--- a/m4/ax_code_coverage=2Em4</span><br><span>+++ b/m4/ax_code_coverag=
e=2Em4</span><br><span>@@ -42,8 +42,8 @@</span><br><span> #     clean-local=
: code-coverage-clean</span><br><span> #     distclean-local: code-coverage=
-dist-clean</span><br><span> #</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#   This results in a &quot;check-code-coverage&quot; rule being a=
dded to any</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#   Makefi=
le=2Eam which do &quot;include $(top_srcdir)/aminclude_static=2Eam&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#   This results in a =
&quot;check-code-coverage&quot; rule being added to the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#   Makefile=2Eam which does &quot;incl=
ude $(top_srcdir)/aminclude_static=2Eam&quot;</span><br><span> #   (assumin=
g the module has been configured with --enable-code-coverage)=2E</span><br>=
<span> #   Running `make check-code-coverage` in that directory will run th=
e</span><br><span> #   module&#39;s test suite (`make check`) and build a c=
ode coverage report</span><br><span>@@ -76,10 +76,51 @@</span><br><span> </=
span><br><span> #serial 37</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+dnl Local modifications compared to the autoconf-a=
rchive version:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl  - AX_ADD_AM_MAC=
RO_STATIC (from autoconf-archive) is replaced by a</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+dnl    minimal local equivalent, OPENVPN_ADD=
_AM_MACRO_STATIC, so that we do</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+dnl    not depend on autoconf-archive being installed=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+dnl  - The generated rules=
 no longer require GNU make=2E  The AX_CHECK_GNU_MAKE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dnl    check is gone (which also removed =
the last autoconf-archive</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+dnl    dependency) and the GNU make specific constructs in the rules =
were</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl    replaced=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl      * the &qu=
ot;ifeq ($(abs_builddir), $(abs_top_builddir))&quot; guard is gone,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+dnl        aminclude_static=
=2Eam may only be included by the top level</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+dnl        Makefile=2Eam now (which is the only pla=
ce it was ever included</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+dnl        from in this project),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dnl      * $(addprefix =2E=2E=2E) and $(if =2E=2E=2E) are=
 replaced by shell code inside</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+dnl        the recipes,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+dnl      * $(call =2E=2E=2E)/$(subst =2E=2E=2E) for the lcov=
 test name is replaced by</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+dnl        CODE_COVERAGE_TEST_NAME, computed at configure time,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl      * &quot;find =2E=
=2E=2E -delete&quot; is replaced by &quot;find =2E=2E=2E -exec rm -f {} +&q=
uot;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl    The o=
nly remaining non-POSIX construct is the nested variable</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+dnl    expansion used for the silent r=
ules ($(foo_$(V))), which is the same</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dnl    idiom automake itself uses for AM_V_at and friends=
 and which is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl   =
 understood by BSD make as well=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_D=
EFUN([OPENVPN_PRINT_TO_FILE],[</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+m4_esyscmd(</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+[</span><br><span style=3D"color: hsl(120, 100%, 40%);">+printf &quot;%s=
&quot; &quot;$2&quot; &gt; &quot;$1&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+])</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+AC_DEFUN([OPENVPN_ADD_AM_MACRO_=
STATIC],[</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  OPENVPN_=
PRINT_TO_FILE([aminclude_static=2Eam],[$1])</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+])</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> m4_define(_AX_CODE_COVERAGE_RULES,[</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-AX_ADD_AM_MACRO_STATIC([</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+OPENVPN_ADD_AM_MACRO_STATIC([</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# This file was gener=
ated by ax_code_coverage</span><br><span> # Code coverage</span><br><span> =
#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# This file must o=
nly be included by the top level Makefile=2Eam: the rules</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# below always report on the complete=
 build tree=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# The rules avoid GNU m=
ake specific syntax so that they also work with</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# other make implementations, e=2Eg=2E BSD make=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><spa=
n> # Optional:</span><br><span> #  - CODE_COVERAGE_DIRECTORY: Top-level dir=
ectory for code coverage reporting=2E</span><br><span> #    Multiple direct=
ories may be specified, separated by whitespace=2E</span><br><span>@@ -90,5=
1 +131,51 @@</span><br><span> #  - CODE_COVERAGE_OUTPUT_DIRECTORY: Director=
y for generated code coverage</span><br><span> #    reports to be created=
=2E (Default:</span><br><span> #    \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-co=
verage)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_CO=
VERAGE_TEST_NAME: Test name to record in the =2Einfo file=2E  It is</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#    computed by configure =
(\$(PACKAGE_NAME)-\$(PACKAGE_VERSION), with dashes</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#    and dots replaced by underscores) and c=
an be overridden by defining it</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#    in Makefile=2Eam=2E</span><br><span> #  - CODE_COVERAGE_BR=
ANCH_COVERAGE: Set to 1 to enforce branch coverage,</span><br><span> #    s=
et to 0 to disable it and leave empty to stay with the default=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#    (Default: empty)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#    The corresponding --rc o=
ption is passed to lcov and genhtml in</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#    addition to the options below=2E (Default: empty)</=
span><br><span> #  - CODE_COVERAGE_LCOV_SHOPTS_DEFAULT: Extra options share=
d between both lcov</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# =
   instances=2E (Default: based on $CODE_COVERAGE_BRANCH_COVERAGE)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#    instances=2E (Default: =
empty)</span><br><span> #  - CODE_COVERAGE_LCOV_SHOPTS: Extra options to sh=
ared between both lcov</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#    instances=2E (Default: $CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#    instances=2E (Default: \$=
CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)</span><br><span> #  - CODE_COVERAGE_LCOV=
_OPTIONS_GCOVPATH: --gcov-tool pathtogcov</span><br><span> #  - CODE_COVERA=
GE_LCOV_OPTIONS_DEFAULT: Extra options to pass to the</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#    collecting lcov instance=2E (Default: =
$CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#    collecting lcov instance=2E (Default: \$CODE_COVERAG=
E_LCOV_OPTIONS_GCOVPATH)</span><br><span> #  - CODE_COVERAGE_LCOV_OPTIONS: =
Extra options to pass to the collecting lcov</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#    instance=2E (Default: $CODE_COVERAGE_LCOV_OPTIO=
NS_DEFAULT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    ins=
tance=2E (Default: \$CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)</span><br><span> #=
  - CODE_COVERAGE_LCOV_RMOPTS_DEFAULT: Extra options to pass to the filteri=
ng</span><br><span> #    lcov instance=2E (Default: empty)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#  - CODE_COVERAGE_LCOV_RMOPTS: Extra =
options to pass to the filtering lcov</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#    instance=2E (Default: $CODE_COVERAGE_LCOV_RMOPTS_DEFAU=
LT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERA=
GE_LCOV_RMOPTS: Extra options to pass to the filtering</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#    lcov instance=2E (Default: \$CODE_C=
OVERAGE_LCOV_RMOPTS_DEFAULT)</span><br><span> #  - CODE_COVERAGE_GENHTML_OP=
TIONS_DEFAULT: Extra options to pass to the</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#    genhtml instance=2E (Default: based on $CODE_COV=
ERAGE_BRANCH_COVERAGE)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#    genhtml instance=2E (Default: empty)</span><br><span> #  - CODE_COV=
ERAGE_GENHTML_OPTIONS: Extra options to pass to the genhtml</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#    instance=2E (Default: $CODE_COVE=
RAGE_GENHTML_OPTIONS_DEFAULT)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#    instance=2E (Default: \$CODE_COVERAGE_GENHTML_OPTIONS_DEFAUL=
T)</span><br><span> #  - CODE_COVERAGE_IGNORE_PATTERN: Extra glob pattern o=
f files to ignore</span><br><span> #</span><br><span> # The generated repor=
t will be titled using the \$(PACKAGE_NAME) and</span><br><span> # \$(PACKA=
GE_VERSION)=2E In order to add the current git hash to the title,</span><br=
><span> # use the git-version-gen script, available online=2E</span><br><sp=
an> # Optional variables</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-# run only on top dir</span><br><span> if CODE_COVERAGE_ENABLED</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- ifeq (\$(abs_builddir), \$(ab=
s_top_builddir))</span><br><span> CODE_COVERAGE_DIRECTORY ?=3D \$(top_build=
dir)</span><br><span> CODE_COVERAGE_OUTPUT_FILE ?=3D \$(PACKAGE_NAME)-\$(PA=
CKAGE_VERSION)-coverage=2Einfo</span><br><span> CODE_COVERAGE_OUTPUT_DIRECT=
ORY ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage</span><br><span> </s=
pan><br><span> CODE_COVERAGE_BRANCH_COVERAGE ?=3D</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-CODE_COVERAGE_LCOV_SHOPTS_DEFAULT ?=3D \$(if \$=
(CODE_COVERAGE_BRANCH_COVERAGE),\</span><br><span>---rc lcov_branch_coverag=
e=3D\$(CODE_COVERAGE_BRANCH_COVERAGE))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+CODE_COVERAGE_LCOV_SHOPTS_DEFAULT ?=3D</span><br><span> =
CODE_COVERAGE_LCOV_SHOPTS ?=3D \$(CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)</span>=
<br><span> CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH ?=3D --gcov-tool \&quot;\$(G=
COV)\&quot;</span><br><span> CODE_COVERAGE_LCOV_OPTIONS_DEFAULT ?=3D \$(COD=
E_COVERAGE_LCOV_OPTIONS_GCOVPATH)</span><br><span> CODE_COVERAGE_LCOV_OPTIO=
NS ?=3D \$(CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)</span><br><span> CODE_COVERA=
GE_LCOV_RMOPTS_DEFAULT ?=3D</span><br><span> CODE_COVERAGE_LCOV_RMOPTS ?=3D=
 \$(CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT ?=3D\</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-\$(if \$(CODE_COVERAGE_BRANCH_COVERA=
GE),\</span><br><span>---rc genhtml_branch_coverage=3D\$(CODE_COVERAGE_BRAN=
CH_COVERAGE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CODE_C=
OVERAGE_GENHTML_OPTIONS_DEFAULT ?=3D</span><br><span> CODE_COVERAGE_GENHTML=
_OPTIONS ?=3D \$(CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)</span><br><span> CO=
DE_COVERAGE_IGNORE_PATTERN ?=3D</span><br><span> </span><br><span>@@ -152,8=
 +193,15 @@</span><br><span> code_coverage_quiet_ =3D \$(code_coverage_quie=
t_\$(AM_DEFAULT_VERBOSITY))</span><br><span> code_coverage_quiet_0 =3D --qu=
iet</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
# sanitizes the test-name: replaces with underscores: dashes and dots</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-code_coverage_sanitize =3D =
\$(subst -,_,\$(subst =2E,_,\$(1)))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# Shell fragments used by the recipes below=2E  They are po=
rtable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# replacement=
s for the GNU make functions \$(addprefix =2E=2E=2E) and \$(if =2E=2E=2E):<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# code_coverage_dirs=
_opt sets \$cc_dirs to a list of --directory options,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# code_coverage_prefix_opt sets \$cc_pref=
ix to a list of --prefix options and</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# code_coverage_*_branch_opt set \$cc_branch to the branch=
 coverage option=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
code_coverage_dirs_opt =3D cc_dirs=3D; for cc_dir in \$(CODE_COVERAGE_DIREC=
TORY); do cc_dirs=3D\&quot;\$\$cc_dirs --directory \$\$cc_dir\&quot;; done<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+code_coverage_prefix=
_opt =3D cc_prefix=3D; for cc_dir in \$(CODE_COVERAGE_DIRECTORY); do cc_pre=
fix=3D\&quot;\$\$cc_prefix --prefix \$\$cc_dir\&quot;; done</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+code_coverage_lcov_branch_opt =3D c=
c_branch=3D; test -z \&quot;\$(CODE_COVERAGE_BRANCH_COVERAGE)\&quot; || cc_=
branch=3D\&quot;--rc lcov_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_COVERAG=
E)\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code_cover=
age_genhtml_branch_opt =3D cc_branch=3D; test -z \&quot;\$(CODE_COVERAGE_BR=
ANCH_COVERAGE)\&quot; || cc_branch=3D\&quot;--rc genhtml_branch_coverage=3D=
\$(CODE_COVERAGE_BRANCH_COVERAGE)\&quot;</span><br><span> </span><br><span>=
 # Use recursive makes in order to ignore errors during check</span><br><sp=
an> check-code-coverage:</span><br><span>@@ -162,29 +210,26 @@</span><br><s=
pan> </span><br><span> # Capture code coverage data</span><br><span> code-c=
overage-capture: code-coverage-capture-hook</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	\$(code_coverage_v_lcov_cap)\$(LCOV) \$(code_coverag=
e_quiet) \$(addprefix --directory ,\$(CODE_COVERAGE_DIRECTORY)) --capture -=
-output-file \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot; --test-name =
\&quot;\$(call code_coverage_sanitize,\$(PACKAGE_NAME)-\$(PACKAGE_VERSION))=
\&quot; --no-checksum --compat-libtool \$(CODE_COVERAGE_LCOV_SHOPTS) \$(COD=
E_COVERAGE_LCOV_OPTIONS)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	\$(code_coverage_v_lcov_ign)\$(LCOV) \$(code_coverage_quiet) \$(addpref=
ix --directory ,\$(CODE_COVERAGE_DIRECTORY)) --remove \&quot;\$(CODE_COVERA=
GE_OUTPUT_FILE)=2Etmp\&quot; \$(CODE_COVERAGE_IGNORE_PATTERN) --output-file=
 \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \$(CODE_COVERAGE_LCOV_SHOPTS) =
\$(CODE_COVERAGE_LCOV_RMOPTS)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	\$(code_coverage_v_lcov_cap)\$(code_coverage_dirs_opt); \\</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	\$(code_coverage_lcov_br=
anch_opt); \\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	\$(LC=
OV) \$(code_coverage_quiet) \$\$cc_dirs --capture --output-file \&quot;\$(C=
ODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot; --test-name \&quot;\$(CODE_COVERAGE_=
TEST_NAME)\&quot; --no-checksum --compat-libtool \$\$cc_branch \$(CODE_COVE=
RAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_OPTIONS)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	\$(code_coverage_v_lcov_ign)\$(code_coverage_=
dirs_opt); \\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	\$(co=
de_coverage_lcov_branch_opt); \\</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	\$(LCOV) \$(code_coverage_quiet) \$\$cc_dirs --remove \&quot;=
\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot; \$(CODE_COVERAGE_IGNORE_PATTERN)=
 --output-file \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \$\$cc_branch \$=
(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_RMOPTS)</span><br><span> =
	-@rm -f \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	\$(code_coverage_v_genhtml)LANG=3DC \=
$(GENHTML) \$(code_coverage_quiet) \$(addprefix --prefix ,\$(CODE_COVERAGE_=
DIRECTORY)) --output-directory \&quot;\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\&q=
uot; --title \&quot;\$(PACKAGE_NAME)-\$(PACKAGE_VERSION) Code Coverage\&quo=
t; --legend --show-details \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \$(C=
ODE_COVERAGE_GENHTML_OPTIONS)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	\$(code_coverage_v_genhtml)\$(code_coverage_prefix_opt); \\</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	\$(code_coverage_genhtm=
l_branch_opt); \\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	L=
ANG=3DC \$(GENHTML) \$(code_coverage_quiet) \$\$cc_prefix --output-director=
y \&quot;\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\&quot; --title \&quot;\$(PACKAG=
E_NAME)-\$(PACKAGE_VERSION) Code Coverage\&quot; --legend --show-details \&=
quot;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \$\$cc_branch \$(CODE_COVERAGE_GE=
NHTML_OPTIONS)</span><br><span> 	@echo \&quot;file://\$(abs_builddir)/\$(CO=
DE_COVERAGE_OUTPUT_DIRECTORY)/index=2Ehtml\&quot;</span><br><span> </span><=
br><span> code-coverage-clean:</span><br><span> 	-\$(LCOV) --directory \$(t=
op_builddir) -z</span><br><span> 	-rm -rf \&quot;\$(CODE_COVERAGE_OUTPUT_FI=
LE)\&quot; \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot; \&quot;\$(CODE=
_COVERAGE_OUTPUT_DIRECTORY)\&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	-find =2E \\( -name \&quot;*=2Egcda\&quot; -o -name \&quot;*=
=2Egcno\&quot; -o -name \&quot;*=2Egcov\&quot; \\) -delete</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	-find =2E \\( -name \&quot;*=2Egcda=
\&quot; -o -name \&quot;*=2Egcno\&quot; -o -name \&quot;*=2Egcov\&quot; \\)=
 -exec rm -f &#39;{}&#39; +</span><br><span> </span><br><span> code-coverag=
e-dist-clean:</span><br><span> </span><br><span> A][M_DISTCHECK_CONFIGURE_F=
LAGS :=3D \$(A][M_DISTCHECK_CONFIGURE_FLAGS) --disable-code-coverage</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- else # ifneq (\$(abs_buildd=
ir), \$(abs_top_builddir))</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-check-code-coverage:</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-code-coverage-cap=
ture: code-coverage-capture-hook</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-code-cover=
age-clean:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-code-coverage-dist-clean:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- endif # ifeq (\$(abs_buildd=
ir), \$(abs_top_builddir))</span><br><span> else #! CODE_COVERAGE_ENABLED</=
span><br><span> # Use recursive makes in order to ignore errors during chec=
k</span><br><span> check-code-coverage:</span><br><span>@@ -206,8 +251,7 @@=
</span><br><span> ])</span><br><span> </span><br><span> AC_DEFUN([_AX_CODE_=
COVERAGE_ENABLED],[</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	A=
X_CHECK_GNU_MAKE([],[AC_MSG_ERROR([not using GNU make that is needed for co=
verage])])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AC_REQUIRE=
([AX_ADD_AM_MACRO_STATIC])</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	AC_REQUIRE([OPENVPN_ADD_AM_MACRO_STATIC])</span><br><span> 	# check=
 for gcov</span><br><span> 	AC_CHECK_TOOL([GCOV],</span><br><span> 		  [$_A=
X_CODE_COVERAGE_GCOV_PROG_WITH],</span><br><span>@@ -232,13 +276,12 @@</spa=
n><br><span> 		AC_MSG_ERROR([Could not find genhtml from the lcov package])=
</span><br><span> 	])</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	AC_CHECK_LIB([gcov], [_gcov_init], [CODE_COVERAGE_LIBS=
=3D&quot;-lgcov&quot;], [CODE_COVERAGE_LIBS=3D&quot;&quot;])</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> 	dnl Build the cod=
e coverage flags</span><br><span> 	dnl Define CODE_COVERAGE_LDFLAGS for bac=
kwards compatibility</span><br><span> 	CODE_COVERAGE_CPPFLAGS=3D&quot;-DNDE=
BUG&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	CODE_COVERA=
GE_CFLAGS=3D&quot;-O0 -g -fprofile-arcs -ftest-coverage&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	CODE_COVERAGE_CXXFLAGS=3D&quot;-O0=
 -g -fprofile-arcs -ftest-coverage&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	CODE_COVERAGE_CFLAGS=3D&quot;-O0 -g --coverage&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	CODE_COVERAGE_CXXFL=
AGS=3D&quot;-O0 -g --coverage&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	CODE_COVERAGE_LIBS=3D&quot;--coverage&quot;</span><br><spa=
n> </span><br><span> 	AC_SUBST([CODE_COVERAGE_CPPFLAGS])</span><br><span> 	=
AC_SUBST([CODE_COVERAGE_CFLAGS])</span><br><span>@@ -265,6 +308,10 @@</span=
><br><span> 	AC_SUBST([CODE_COVERAGE_ENABLED], [$enable_code_coverage])</sp=
an><br><span> 	AC_MSG_RESULT($enable_code_coverage)</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	dnl The lcov test name m=
ust not contain dashes or dots</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	CODE_COVERAGE_TEST_NAME=3D`echo &quot;$PACKAGE_NAME-$PACKAGE_VE=
RSION&quot; | tr &#39;=2E-&#39; &#39;__&#39;`</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	AC_SUBST([CODE_COVERAGE_TEST_NAME])</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> 	AS_IF([ test =
&quot;x$enable_code_coverage&quot; =3D xyes ], [</span><br><span> 		_AX_COD=
E_COVERAGE_ENABLED</span><br><span> 	      ])</span><br><span>diff --git a/=
src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index=
 7fd12b4=2E=2E488d0a5 100644</span><br><span>--- a/src/openvpn/Makefile=2Ea=
m</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -31,9 =
+31,12 @@</span><br><span> 	$(OPTIONAL_SYSTEMD_CFLAGS) \</span><br><span> 	=
$(OPTIONAL_PKCS11_HELPER_CFLAGS) \</span><br><span> 	$(OPTIONAL_INOTIFY_CFL=
AGS) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(CODE_COVER=
AGE_CFLAGS) \</span><br><span> 	-DPLUGIN_LIBDIR=3D\&quot;${plugindir}\&quot=
; \</span><br><span> 	-DDEFAULT_DNS_UPDOWN=3D\&quot;${scriptdir}/dns-updown=
\&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+AM_LDFLAGS =3D $(CODE_COVERAGE_LIBS)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> if WIN32</span><br><span> # we wan=
t unicode entry point but not the macro</span><br><span> AM_CFLAGS +=3D -mu=
nicode -UUNICODE</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail">change 1592=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
79b2dc4a550b1c5068a45407976b0dfc2f765b33 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1592 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>

</body></html>
--9J9LUJhfF34=--


--===============1988936415394348185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1988936415394348185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1988936415394348185==--

