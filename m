Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC93C5DF6A
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 20:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UvvyB4yT65brUWT5jBbo7j965QWwYsw4WIkynwD713Y=; b=fSs4utHQQUL9FaKNpffBpTHsJz
	pU3YeBBSmV0cllxLPKe0PlEW+rBNF/630rsXbilRKA4Wc7YCLa2695SspgTOtekfcLnrjD1mC+Hs6
	f04p6/GIdpiiaU9lA6YqGGUYsXWuiMw8G9cn1/r6sBGInabiIF+0+K/I6P3/SNKzeP9M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuyKu-0007YA-VL;
	Fri, 14 Aug 2026 20:17:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wuyKf-0007Wb-BB
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 20:16:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s4rFZLU8eIg7WQYdUSwG0kE/6UVluTdixC5Hd8+VNsc=; b=Q/D+CTLsN+caTbtaS+YmgWb9ZZ
 JdgkeFki3SBlgAvBsDU8phYdoN6O6ePcVlIEV98O6CE+KoaK2JMF4Rg4cXFYseuXRmwCN8apTyxu4
 RO+3zeYXa4xjUOHA6UCbHJKX9tzQgziXgdhf1zJSUMeySmi6kAk17UMaHQ75Amqgx2kE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=s4rFZLU8eIg7WQYdUSwG0kE/6UVluTdixC5Hd8+VNsc=; b=mxqKuh0w9uhsU0kAGzMCwhnrGQ
 jUy6EkdQ/VJEBiS0MaHlD46JfBlF7NIbAwQLm6RbWj8HHe08nLZCdCJhO3I1TXVCLshwPITPO+MGD
 JmK2bvj+OELfA0Aol7oUR1RvOJpWoHal++5gk1BUpYBq/dq8U5cuqUhRTJwQsZJJDXqY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuyKc-00041K-Rn for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 20:16:50 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67EKGUW8011170
 for <openvpn-devel@lists.sourceforge.net>; Fri, 14 Aug 2026 22:16:30 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67EKGUNT011169
 for openvpn-devel@lists.sourceforge.net; Fri, 14 Aug 2026 22:16:30 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 14 Aug 2026 22:16:20 +0200
Message-ID: <20260814201630.11152-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
References: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wuyKc-00041K-Rn
Subject: [Openvpn-devel] [PATCH v1] configure: Add --enable-code-coverage
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Frank Lichtenheld <frank@lichtenheld.com>

Can be used like this
./configure --enable-code-coverage
make
make check
make code-coverage-capture

Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1592
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1592
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/.gitignore b/.gitignore
index 04523af..e25e591 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,5 +1,7 @@
 *.[oa]
 *.l[oa]
+*.gcda
+*.gcno
 *.dll
 *.exe
 *.exe.*
@@ -18,6 +20,7 @@
 Makefile
 Makefile.in
 aclocal.m4
+aminclude_static.am
 autodefs.h
 autom4te.cache
 config.guess
diff --git a/Makefile.am b/Makefile.am
index 362ae96..4af5e7e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -22,6 +22,8 @@
 #  with this program; if not, see <https://www.gnu.org/licenses/>.
 #
 
+include $(top_srcdir)/aminclude_static.am
+
 ACLOCAL_AMFLAGS = -I m4
 
 MAINTAINERCLEANFILES = \
@@ -89,3 +91,7 @@
 
 doxygen:
 	$(MAKE) -C doc/doxygen doxygen
+
+CODE_COVERAGE_LCOV_SHOPTS=--config-file $(srcdir)/lcovrc
+clean-local: code-coverage-clean
+distclean-local: code-coverage-dist-clean
diff --git a/configure.ac b/configure.ac
index 5da877a..82d3bce 100644
--- a/configure.ac
+++ b/configure.ac
@@ -59,6 +59,8 @@
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS
 
+AX_CODE_COVERAGE
+
 AC_ARG_ENABLE(
 	[lzo],
 	[AS_HELP_STRING([--disable-lzo], [disable LZO compression support @<:@default=yes@:>@])],
@@ -1255,6 +1257,11 @@
 	ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-cast-function-type])
 fi
 
+# If coverage is enabled remove -O arguments from CFLAGS
+if test "$enable_code_coverage" = "yes"; then
+   [CFLAGS="`echo $CFLAGS | $SED -e 's/-O[s0-9]\\?//g'`"]
+fi
+
 if test "${enable_pedantic}" = "yes"; then
 	CFLAGS="${CFLAGS} -pedantic"
 	AC_DEFINE([PEDANTIC], [1], [Enable pedantic mode])
@@ -1374,10 +1381,10 @@
 
 TEST_LDFLAGS="${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${OPTIONAL_LIBCAPNG_LIBS}"
 TEST_LDFLAGS="${TEST_LDFLAGS} ${OPTIONAL_LIBNL_GENL_LIBS}"
-TEST_LDFLAGS="${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS}"
+TEST_LDFLAGS="${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS} ${CODE_COVERAGE_LIBS}"
 TEST_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS} ${OPTIONAL_LIBCAPNG_CFLAGS}"
 TEST_CFLAGS="${TEST_CFLAGS} ${OPTIONAL_LIBNL_GENL_CFLAGS} ${OPTIONAL_LZO_CFLAGS}"
-TEST_CFLAGS="${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS}"
+TEST_CFLAGS="${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS} ${CODE_COVERAGE_CFLAGS}"
 
 AC_SUBST([TEST_LDFLAGS])
 AC_SUBST([TEST_CFLAGS])
diff --git a/m4/ax_code_coverage.m4 b/m4/ax_code_coverage.m4
index 216708a4..4a01ce6 100644
--- a/m4/ax_code_coverage.m4
+++ b/m4/ax_code_coverage.m4
@@ -232,13 +232,12 @@
 		AC_MSG_ERROR([Could not find genhtml from the lcov package])
 	])
 
-	AC_CHECK_LIB([gcov], [_gcov_init], [CODE_COVERAGE_LIBS="-lgcov"], [CODE_COVERAGE_LIBS=""])
-
 	dnl Build the code coverage flags
 	dnl Define CODE_COVERAGE_LDFLAGS for backwards compatibility
 	CODE_COVERAGE_CPPFLAGS="-DNDEBUG"
-	CODE_COVERAGE_CFLAGS="-O0 -g -fprofile-arcs -ftest-coverage"
-	CODE_COVERAGE_CXXFLAGS="-O0 -g -fprofile-arcs -ftest-coverage"
+	CODE_COVERAGE_CFLAGS="-O0 -g --coverage"
+	CODE_COVERAGE_CXXFLAGS="-O0 -g --coverage"
+	CODE_COVERAGE_LIBS="--coverage"
 
 	AC_SUBST([CODE_COVERAGE_CPPFLAGS])
 	AC_SUBST([CODE_COVERAGE_CFLAGS])
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index ff8cc54..47a4926 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -31,9 +31,12 @@
 	$(OPTIONAL_SYSTEMD_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \
 	$(OPTIONAL_INOTIFY_CFLAGS) \
+	$(CODE_COVERAGE_CFLAGS) \
 	-DPLUGIN_LIBDIR=\"${plugindir}\" \
 	-DDEFAULT_DNS_UPDOWN=\"${scriptdir}/dns-updown\"
 
+AM_LIBS = $(CODE_COVERAGE_LIBS)
+
 if WIN32
 # we want unicode entry point but not the macro
 AM_CFLAGS += -municode -UUNICODE


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
