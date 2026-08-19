Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAEAC5DF87
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0IApmSmqIjVEZOsqlbf/XK33miOhfRHKB9qOnGWNvvU=; b=JdqNVrcaRT1cVju4w5RrB4AmYR
	YTJTiiD1s9WDZzeFj/849UCe5fMKKdldWvsNoAwS1m02B/vvosOUVRPkY7jr3xeiHdTSjDTXOyIdE
	iM9BpYUeLkwJsdebwKy4sdkglYR1BEHrV/uWdrKZErJyd7zW8ImMsoPyV9/Fd5ET864I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwe44-00030w-Le;
	Wed, 19 Aug 2026 11:02:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwe43-00030m-On
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 11:02:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NmLrwP9Vb2NgTHumQfqIGLolrACX688EV5ADnvI/8xQ=; b=cL8ptFT23Sken0BmuW+WKlrgxW
 41rq2fCckyh7hmnCvYB3q2wptToA+v/Bvx0XOe5SqFS1meVy0ghjajJWGuvbdWelHsFX3XQvUlRWj
 4bio8Ne8vJDMh8XaQqFOwnaDz4w4/WWUObxHbG8FUSQ/iR+7+ecHXpaKeORyXFebpIKw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NmLrwP9Vb2NgTHumQfqIGLolrACX688EV5ADnvI/8xQ=; b=f
 XU1Ce28AXUZEy3D4REWpd8vFV6zXPDGkGv9lLxJuKIyKTWpEVm0v9ENGhQcpCfV/xlOGIzfBArjHV
 gsikonzG+40rbDDvl1Bc8utSLHRmxKQbzQ58RQXBFTFZsh1pFVPR3w0/9LXyej70n06Ythe6ayzfw
 DYiDJLUQLTB+2/7M=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwe42-00023y-DP for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 11:02:36 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-499ae1c6471so2212565e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 04:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787137348; x=1787742148; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NmLrwP9Vb2NgTHumQfqIGLolrACX688EV5ADnvI/8xQ=;
 b=TDHeKvf3Xn6Z0CPgNMfVo6IJ7Zw0wldlIpdmfEmcaVUk8+u3tM7wNB2zxfa39miifF
 O9Pj2b+kh46OwzarvQH62vypNecpFhgiVRSTRdtHADg6JvJOH0ngTUjOinoKz8fgQvfQ
 M7e4gN/HjcvMDnXL20Em4DHMYjPGf7M2H3WubZQJIzeNDFapI7ogMxdwlVz7UZ+Nkg+e
 pLWm3iPKXUP/A0GLhMTVtisdEtBcfwi3slaH5WuXwjMi8Y8y7cZlumhwa8db97yBZmyp
 +OPxsliHmZV65oTxr/1ftgOZE4Wa9IyjwLKOfbmkpjDFQZV10pCQLk4D2wHalMZapKlR
 aZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787137348; x=1787742148;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NmLrwP9Vb2NgTHumQfqIGLolrACX688EV5ADnvI/8xQ=;
 b=EbcsNQm8iHJmpI1pyrWrjuBvVCYDHWYc0J+0xsoeZx+lNmo/ALoJ/ozn9JiMpWnE1c
 ES/O0DPx184f5b1oYb6mu+2XcPYFEYnqvgJFXaP8zHKSoSPb8BSRz/DhGzTl0/StzjWR
 IERVFn4b+baW7DCHyUQ3fo+WzpmaWW70BEU7Jfsb4ML3muOuZ0oYAarr1PiwI44/qkIJ
 Syct3GR0pkVO13k0piOuxz+AsIhxJFAePngtlLuXDG+SrWyXBYrl3uweiBBLeEmDB0FA
 Yj4AVREU+L7IE13uIVGxijDz7OmCkr4qU9kPE2+NQ/JSGG6aoIcF7MepuRlpTtuFuXIT
 1XKA==
X-Gm-Message-State: AOJu0YzbyTVzBGwSOSOmv9Qx7VRWf9P3N1keA8PI0TtiaAJ+JuS2Di+C
 MMm5dcoxbohsJxo2sj62AzbAQ/axzuE6gViLudPcnn3Xf45cWKSUq5ZExJU9gi1DpiHcKH2KJFT
 oKvD+tADQWZVsv7V/HMoL137sIPbaNIIOeSuHSM1qNvFDX4iOQ9PT0xcJ2bn3clEHGUHJ
X-Gm-Gg: AR+sD13HZvmRW5qw8l881al4CSkkMCWAWYsPHY5xt1zQLPXxMfRj2Rf6gCQTcy4szbG
 oC/6YaV3jM/LlzEaoT5xScL5k1AlEtg9BzG/TqUzxgcRRX7/JSp5DII992IPgUPiWEUtP07JAPy
 60k1DBWfQeu5LnETInW4V28PU94F4lr4BLgeqh210LqaUYnBWydAcg1Y+3Vl7yd/UHYuDu+CylI
 3NJkiLx/5zHre6+3pjRGoEbhbLmjB7H9IJXS/29EcpO6UQIYbaq3tSxyT4NM2PYAH2neAbSly3W
 ye1cF1YN50DBnp30RKUsOsUIoYmGJzeX8O6/bvjTIumHTh3l/MLTh5f0ADcODO4W/6jHU5e5zmh
 W4W3/p5z8PpMojWEDEK+EREz8VEbmzv7yTFaPKor6wk89FBSdkN6OqhuE0uC1p8ppFqrrx3J6XN
 b5Hn2eye15JRcFGjODzLRFfACLzFe/bs11LB9fhzVbwwC6i6TnHKE2MJRlTuhB3HZ1y1ytKFJ/T
 mxj38XRBqgjdIbanCQpOSRWaFZQB0MxgM+wi/3imTCLmgsl+sLbVJ+gbPUCC6Vi1W934Z4mXp9n
 i87vd9eQ+yFSGhp0qvRWPqikN0aTWPu06AF238HbRNcqaWwWivQ=
X-Received: by 2002:a05:600c:8b27:b0:499:7024:9d4a with SMTP id
 5b1f17b1804b1-499aa16a958mr77940015e9.8.1787137347680; 
 Wed, 19 Aug 2026 04:02:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9dffa59sm73114535e9.3.2026.08.19.04.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 04:02:26 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 11:02:20 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
X-Gerrit-Change-Number: 1592
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1592?usp=email>
X-Gerrit-Commit: 236ef06899a977a8ddfeae8cd02ba71bb0b5e5cf
In-Reply-To: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
References: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0NDUxMzgwMDAwLkk3OWIyZGM0YTU1MGIxYzUwNjhhNDU0MDc5NzZiMGRmYzJmNzY1YjMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b153b559d3c632f6dab307c09926a6704e15fada-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwe42-00023y-DP
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
Content-Type: multipart/mixed; boundary="===============6950261950537036302=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6950261950537036302==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nP0sb/wLcTw="; charset=UTF-8

--nP0sb/wLcTw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, razvanc=2E

=
Hello plaisthos, razvanc, 

I'd like you to reexamine a change=2E Please vi=
sit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail

to loo=
k at the new patch set (#2)=2E

The following approvals got outdated and we=
re removed:
Code-Review+2 by razvanc


Change subject: configure: Add --ena=
ble-code-coverage
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

configure: Add --enable-code-coverage

Can be used like this
=2E/confi=
gure --enable-code-coverage
make
make check
make code-coverage-capture

Cha=
nge-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
Signed-off-by: Frank Lich=
tenheld <frank@lichtenheld=2Ecom>
---
M =2Egitignore
M Makefile=2Eam
M conf=
igure=2Eac
A lcovrc
M m4/ax_code_coverage=2Em4
M src/openvpn/Makefile=2Eam
=
6 files changed, 28 insertions(+), 7 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/92/1592/2

diff --git a/=2Egiti=
gnore b/=2Egitignore
index 04523af=2E=2Ee25e591 100644
--- a/=2Egitignore
+=
++ b/=2Egitignore
@@ -1,5 +1,7 @@
 *=2E[oa]
 *=2El[oa]
+*=2Egcda
+*=2Egcno
=
 *=2Edll
 *=2Eexe
 *=2Eexe=2E*
@@ -18,6 +20,7 @@
 Makefile
 Makefile=2Ein
 =
aclocal=2Em4
+aminclude_static=2Eam
 autodefs=2Eh
 autom4te=2Ecache
 config=
=2Eguess
diff --git a/Makefile=2Eam b/Makefile=2Eam
index feeaabb=2E=2E716b=
2df 100644
--- a/Makefile=2Eam
+++ b/Makefile=2Eam
@@ -22,6 +22,8 @@
 #  wi=
th this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
 #
 
+i=
nclude $(top_srcdir)/aminclude_static=2Eam
+
 ACLOCAL_AMFLAGS =3D -I m4
 
 =
MAINTAINERCLEANFILES =3D \
@@ -45,7 +47,8 @@
 	CMakeLists=2Etxt \
 	CMakePr=
esets=2Ejson \
 	config=2Eh=2Ecmake=2Ein \
-	forked-test-driver
+	forked-te=
st-driver \
+	lcovrc
 
 =2EPHONY: config-version=2Eh doxygen
 
@@ -97,3 +10=
0,7 @@
 	SOURCE_DIR=3D"$(abs_top_srcdir)" \
 	INCLUDE_FLAGS=3D"$(LIBNL_GENL=
_CFLAGS)" \
 		"$(top_srcdir)/dev-tools/run-cppcheck=2Esh"
+
+CODE_COVERAGE=
_LCOV_SHOPTS=3D--config-file $(srcdir)/lcovrc
+clean-local: code-coverage-c=
lean
+distclean-local: code-coverage-dist-clean
diff --git a/configure=2Eac=
 b/configure=2Eac
index 469a475=2E=2Ebb9fd16 100644
--- a/configure=2Eac
++=
+ b/configure=2Eac
@@ -59,6 +59,8 @@
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTE=
NSIONS
 
+AX_CODE_COVERAGE
+
 AC_ARG_ENABLE(
 	[lzo],
 	[AS_HELP_STRING([--=
disable-lzo], [disable LZO compression support @<:@default=3Dyes@:>@])],
@@=
 -1236,6 +1238,11 @@
 	ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-cast-function-type=
])
 fi
 
+# If coverage is enabled remove -O arguments from CFLAGS
+if test=
 "$enable_code_coverage" =3D "yes"; then
+   [CFLAGS=3D"`echo $CFLAGS | $SE=
D -e 's/-O[s0-9]\\?//g'`"]
+fi
+
 if test "${enable_pedantic}" =3D "yes"; t=
hen
 	CFLAGS=3D"${CFLAGS} -pedantic"
 	AC_DEFINE([PEDANTIC], [1], [Enable p=
edantic mode])
@@ -1355,10 +1362,10 @@
 
 TEST_LDFLAGS=3D"${OPTIONAL_CRYPTO=
_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${OPTIONAL_LIBCAPNG_LIBS}"
 TEST_LDFL=
AGS=3D"${TEST_LDFLAGS} ${OPTIONAL_LIBNL_GENL_LIBS}"
-TEST_LDFLAGS=3D"${TEST=
_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS}"
+TEST_LDFLAGS=3D"${TEST_LDFL=
AGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS} ${CODE_COVERAGE_LIBS}"
 TEST_CFLAG=
S=3D"${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS} ${OPTIONAL_=
LIBCAPNG_CFLAGS}"
 TEST_CFLAGS=3D"${TEST_CFLAGS} ${OPTIONAL_LIBNL_GENL_CFLA=
GS} ${OPTIONAL_LZO_CFLAGS}"
-TEST_CFLAGS=3D"${TEST_CFLAGS} -I\$(top_srcdir)=
/include ${CMOCKA_CFLAGS}"
+TEST_CFLAGS=3D"${TEST_CFLAGS} -I\$(top_srcdir)/=
include ${CMOCKA_CFLAGS} ${CODE_COVERAGE_CFLAGS}"
 
 AC_SUBST([TEST_LDFLAGS=
])
 AC_SUBST([TEST_CFLAGS])
diff --git a/lcovrc b/lcovrc
new file mode 1006=
44
index 0000000=2E=2E0e4ac46
--- /dev/null
+++ b/lcovrc
@@ -0,0 +1,2 @@
+g=
eninfo_external =3D 0
+geninfo_unexecuted_blocks =3D 1
diff --git a/m4/ax_c=
ode_coverage=2Em4 b/m4/ax_code_coverage=2Em4
index 216708a4=2E=2E4a01ce6 10=
0644
--- a/m4/ax_code_coverage=2Em4
+++ b/m4/ax_code_coverage=2Em4
@@ -232,=
13 +232,12 @@
 		AC_MSG_ERROR([Could not find genhtml from the lcov package=
])
 	])
 
-	AC_CHECK_LIB([gcov], [_gcov_init], [CODE_COVERAGE_LIBS=3D"-lgco=
v"], [CODE_COVERAGE_LIBS=3D""])
-
 	dnl Build the code coverage flags
 	dnl=
 Define CODE_COVERAGE_LDFLAGS for backwards compatibility
 	CODE_COVERAGE_C=
PPFLAGS=3D"-DNDEBUG"
-	CODE_COVERAGE_CFLAGS=3D"-O0 -g -fprofile-arcs -ftest=
-coverage"
-	CODE_COVERAGE_CXXFLAGS=3D"-O0 -g -fprofile-arcs -ftest-coverag=
e"
+	CODE_COVERAGE_CFLAGS=3D"-O0 -g --coverage"
+	CODE_COVERAGE_CXXFLAGS=3D=
"-O0 -g --coverage"
+	CODE_COVERAGE_LIBS=3D"--coverage"
 
 	AC_SUBST([CODE_=
COVERAGE_CPPFLAGS])
 	AC_SUBST([CODE_COVERAGE_CFLAGS])
diff --git a/src/ope=
nvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 4220d07=2E=2E26eb36c 1=
00644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -3=
1,9 +31,12 @@
 	$(OPTIONAL_SYSTEMD_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFL=
AGS) \
 	$(OPTIONAL_INOTIFY_CFLAGS) \
+	$(CODE_COVERAGE_CFLAGS) \
 	-DPLUGI=
N_LIBDIR=3D\"${plugindir}\" \
 	-DDEFAULT_DNS_UPDOWN=3D\"${scriptdir}/dns-u=
pdown\"
 
+AM_LIBS =3D $(CODE_COVERAGE_LIBS)
+
 if WIN32
 # we want unicode=
 entry point but not the macro
 AM_CFLAGS +=3D -municode -UUNICODE

-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I79b2dc4a550b1c5068a45407=
976b0dfc2f765b33
Gerrit-Change-Number: 1592
Gerrit-PatchSet: 2
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
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg=
>

--nP0sb/wLcTw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, razvanc=2E </p>
<p>flichtenh=
eld <strong>uploaded patch set #2</strong> to this change=2E</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail">View Change=
</a></p><p>The following approvals got outdated and were removed:
Code-Revi=
ew+2 by razvanc</p><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">configure: Add --enable-code-coverage<br><=
br>Can be used like this<br>=2E/configure --enable-code-coverage<br>make<br=
>make check<br>make code-coverage-capture<br><br>Change-Id: I79b2dc4a550b1c=
5068a45407976b0dfc2f765b33<br>Signed-off-by: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt;<br>---<br>M =2Egitignore<br>M Makefile=2Eam<br>M config=
ure=2Eac<br>A lcovrc<br>M m4/ax_code_coverage=2Em4<br>M src/openvpn/Makefil=
e=2Eam<br>6 files changed, 28 insertions(+), 7 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/92/1592/2</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/=2Egitignore b/=2Egitignore</span><br><spa=
n>index 04523af=2E=2Ee25e591 100644</span><br><span>--- a/=2Egitignore</spa=
n><br><span>+++ b/=2Egitignore</span><br><span>@@ -1,5 +1,7 @@</span><br><s=
pan> *=2E[oa]</span><br><span> *=2El[oa]</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+*=2Egcda</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+*=2Egcno</span><br><span> *=2Edll</span><br><span> *=2Eexe</span>=
<br><span> *=2Eexe=2E*</span><br><span>@@ -18,6 +20,7 @@</span><br><span> M=
akefile</span><br><span> Makefile=2Ein</span><br><span> aclocal=2Em4</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+aminclude_static=2Eam</spa=
n><br><span> autodefs=2Eh</span><br><span> autom4te=2Ecache</span><br><span=
> config=2Eguess</span><br><span>diff --git a/Makefile=2Eam b/Makefile=2Eam=
</span><br><span>index feeaabb=2E=2E716b2df 100644</span><br><span>--- a/Ma=
kefile=2Eam</span><br><span>+++ b/Makefile=2Eam</span><br><span>@@ -22,6 +2=
2,8 @@</span><br><span> #  with this program; if not, see &lt;https://www=
=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span> #</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+include $(top_srcdir)/amincl=
ude_static=2Eam</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> ACLOCAL_AMFLAGS =3D -I m4</span><br><span> </span><br><span> =
MAINTAINERCLEANFILES =3D \</span><br><span>@@ -45,7 +47,8 @@</span><br><spa=
n> 	CMakeLists=2Etxt \</span><br><span> 	CMakePresets=2Ejson \</span><br><s=
pan> 	config=2Eh=2Ecmake=2Ein \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	forked-test-driver</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	forked-test-driver \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	lcovrc</span><br><span> </span><br><span> =2EPHONY: config-ver=
sion=2Eh doxygen</span><br><span> </span><br><span>@@ -97,3 +100,7 @@</span=
><br><span> 	SOURCE_DIR=3D&quot;$(abs_top_srcdir)&quot; \</span><br><span> =
	INCLUDE_FLAGS=3D&quot;$(LIBNL_GENL_CFLAGS)&quot; \</span><br><span> 		&quo=
t;$(top_srcdir)/dev-tools/run-cppcheck=2Esh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+CODE_COVERAGE_LCOV_SHOPTS=3D--config-file $(srcdir)/lcovrc</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+clean-local: code-coverag=
e-clean</span><br><span style=3D"color: hsl(120, 100%, 40%);">+distclean-lo=
cal: code-coverage-dist-clean</span><br><span>diff --git a/configure=2Eac b=
/configure=2Eac</span><br><span>index 469a475=2E=2Ebb9fd16 100644</span><br=
><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span><br>=
<span>@@ -59,6 +59,8 @@</span><br><span> AC_CANONICAL_HOST</span><br><span>=
 AC_USE_SYSTEM_EXTENSIONS</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+AX_CODE_COVERAGE</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> AC_ARG_ENABLE(</span><br><span> 	[lz=
o],</span><br><span> 	[AS_HELP_STRING([--disable-lzo], [disable LZO compres=
sion support @&lt;:@default=3Dyes@:&gt;@])],</span><br><span>@@ -1236,6 +12=
38,11 @@</span><br><span> 	ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-cast-function-=
type])</span><br><span> fi</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# If coverage is enabled remove -O arguments from =
CFLAGS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if test &quot=
;$enable_code_coverage&quot; =3D &quot;yes&quot;; then</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+   [CFLAGS=3D&quot;`echo $CFLAGS | $SED =
-e &#39;s/-O[s0-9]\\?//g&#39;`&quot;]</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> if test &quot;${enable_pedantic}&quot; =3D &quot;yes&quo=
t;; then</span><br><span> 	CFLAGS=3D&quot;${CFLAGS} -pedantic&quot;</span><=
br><span> 	AC_DEFINE([PEDANTIC], [1], [Enable pedantic mode])</span><br><sp=
an>@@ -1355,10 +1362,10 @@</span><br><span> </span><br><span> TEST_LDFLAGS=
=3D&quot;${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${OPTIONAL_=
LIBCAPNG_LIBS}&quot;</span><br><span> TEST_LDFLAGS=3D&quot;${TEST_LDFLAGS} =
${OPTIONAL_LIBNL_GENL_LIBS}&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-TEST_LDFLAGS=3D&quot;${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMO=
CKA_LIBS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST=
_LDFLAGS=3D&quot;${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS} ${CODE=
_COVERAGE_LIBS}&quot;</span><br><span> TEST_CFLAGS=3D&quot;${OPTIONAL_CRYPT=
O_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS} ${OPTIONAL_LIBCAPNG_CFLAGS}&quot=
;</span><br><span> TEST_CFLAGS=3D&quot;${TEST_CFLAGS} ${OPTIONAL_LIBNL_GENL=
_CFLAGS} ${OPTIONAL_LZO_CFLAGS}&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-TEST_CFLAGS=3D&quot;${TEST_CFLAGS} -I\$(top_srcdir)/include=
 ${CMOCKA_CFLAGS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+TEST_CFLAGS=3D&quot;${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CF=
LAGS} ${CODE_COVERAGE_CFLAGS}&quot;</span><br><span> </span><br><span> AC_S=
UBST([TEST_LDFLAGS])</span><br><span> AC_SUBST([TEST_CFLAGS])</span><br><sp=
an>diff --git a/lcovrc b/lcovrc</span><br><span>new file mode 100644</span>=
<br><span>index 0000000=2E=2E0e4ac46</span><br><span>--- /dev/null</span><b=
r><span>+++ b/lcovrc</span><br><span>@@ -0,0 +1,2 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+geninfo_external =3D 0</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+geninfo_unexecuted_blocks =3D 1</span>=
<br><span>diff --git a/m4/ax_code_coverage=2Em4 b/m4/ax_code_coverage=2Em4<=
/span><br><span>index 216708a4=2E=2E4a01ce6 100644</span><br><span>--- a/m4=
/ax_code_coverage=2Em4</span><br><span>+++ b/m4/ax_code_coverage=2Em4</span=
><br><span>@@ -232,13 +232,12 @@</span><br><span> 		AC_MSG_ERROR([Could not=
 find genhtml from the lcov package])</span><br><span> 	])</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AC_CHECK_LIB([gcov]=
, [_gcov_init], [CODE_COVERAGE_LIBS=3D&quot;-lgcov&quot;], [CODE_COVERAGE_L=
IBS=3D&quot;&quot;])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> 	dnl Build the code coverage flags</span><br><span> 	dnl D=
efine CODE_COVERAGE_LDFLAGS for backwards compatibility</span><br><span> 	C=
ODE_COVERAGE_CPPFLAGS=3D&quot;-DNDEBUG&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	CODE_COVERAGE_CFLAGS=3D&quot;-O0 -g -fprofile-arcs =
-ftest-coverage&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	CODE_COVERAGE_CXXFLAGS=3D&quot;-O0 -g -fprofile-arcs -ftest-coverage&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	CODE_COVERAGE_CFLA=
GS=3D&quot;-O0 -g --coverage&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	CODE_COVERAGE_CXXFLAGS=3D&quot;-O0 -g --coverage&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	CODE_COVERAGE_LIBS=3D&q=
uot;--coverage&quot;</span><br><span> </span><br><span> 	AC_SUBST([CODE_COV=
ERAGE_CPPFLAGS])</span><br><span> 	AC_SUBST([CODE_COVERAGE_CFLAGS])</span><=
br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam=
</span><br><span>index 4220d07=2E=2E26eb36c 100644</span><br><span>--- a/sr=
c/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</sp=
an><br><span>@@ -31,9 +31,12 @@</span><br><span> 	$(OPTIONAL_SYSTEMD_CFLAGS=
) \</span><br><span> 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \</span><br><span> 	=
$(OPTIONAL_INOTIFY_CFLAGS) \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	$(CODE_COVERAGE_CFLAGS) \</span><br><span> 	-DPLUGIN_LIBDIR=3D\&q=
uot;${plugindir}\&quot; \</span><br><span> 	-DDEFAULT_DNS_UPDOWN=3D\&quot;$=
{scriptdir}/dns-updown\&quot;</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+AM_LIBS =3D $(CODE_COVERAGE_LIBS)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> if WIN32</span>=
<br><span> # we want unicode entry point but not the macro</span><br><span>=
 AM_CFLAGS +=3D -municode -UUNICODE</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=
=3Demail">change 1592</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1592?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1592 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--nP0sb/wLcTw=--


--===============6950261950537036302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6950261950537036302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6950261950537036302==--

