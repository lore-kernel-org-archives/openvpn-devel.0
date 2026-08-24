Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F5BC5DF94
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0CptREFhKzR3PCkleMOYMAP4ULGxyfDXpOuKSDf+PxM=; b=YTHuPk24PpmU9CtzNhManBcDMs
	fw7YHl3zENNCgtz2HN27Pgv/SHFbcZClhFsrv56ZzXskPR+qZIVU1o680tQ3oR+fUJRz5Sl4/JRs+
	ThmMvrH0NuqKrvgeJpnIyC07aVDKEDbamSGHkNpLeGVBwPMxR/uM5Qow2r9nMFkjqbpY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyUs0-0003d3-4O;
	Mon, 24 Aug 2026 13:37:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyUrz-0003cq-6G
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:37:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HL3OCdZgD17VNR7DRD4jEODeEPslI/uYKE0anZ0oj8k=; b=FvKC1d4x2plXScK+PdbZ1qrK86
 AET3KPy/zLFHg7PW5SyRh5aIpMG/Hwo302itrVlZWsziNmvnmOJefUpqefFJW8GQ0iA+h4g3R9z9n
 2sqhSSLAoAGf2C9o/MOQBfDUfWcGa9cIEbFdJWJUiD9MkO03amSrB+QvSuk+mj+Qw6a8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HL3OCdZgD17VNR7DRD4jEODeEPslI/uYKE0anZ0oj8k=; b=Q
 +q8/R/7lteDE82V2NnpfIii0iqT0lZQrEN6txXKVYi5hF5V6HoBirp3ZNp1Tx2odgkWUtzAZCUUxI
 wHUd/GydL9ejrpEvL3AiXokpaWyVOXyOy8HdnKKKCdo/LcwsO/3JbQ3fu2gYfBvLji7ayd7ponQU4
 1NYZlXFjr2UXaYT8=;
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyUrv-0000Gr-R4 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:37:47 +0000
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so394389766b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 06:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787578657; x=1788183457; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HL3OCdZgD17VNR7DRD4jEODeEPslI/uYKE0anZ0oj8k=;
 b=OGHXIR51mTsEYGRPAY6A5IemzRFB2VLK6hPAioQZzV4e1Efgcthwsatm1mat5nyC2R
 C8xm8rdUZe5oqNWJdCxY2fGR8aT2F+JxdVrVFkwskHJk6692p1yvSihH3Wyd6q46uwBp
 U6WgsYS9qPFIx2VTjoXlsIzsVhHzAqPGklDsDAGsT1neGMxuseoLtd6/mR+NpuvCufty
 0+xXnTNaLfFVEMD9HLQ3Fyua5bGfRFPy+EWem9W0SRRh0nGuFWgzCuV6XJ7EqO/Q9xF1
 1snPxHm0Gtie1op8+UEKNQiTHWK9c41Wo7F9Zmta6ngMbtMwXmtDo1aboOQlbJyJVucb
 qVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787578657; x=1788183457;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HL3OCdZgD17VNR7DRD4jEODeEPslI/uYKE0anZ0oj8k=;
 b=A2KCMO5DAIsftAam4ZFDuX4E86j+Eui/ttKDcGfTvGALufxHliGIBlrS/39enhPoqV
 xFVN7STVeysCOlzc3oBXrVSVo6aRvK5i0T7+mrCSVKbeOEjZ+b0I0MW4lB2JzQ+vTNRu
 aAOOxsiVrQYs2lsOgeCIGUHG9C9i2UnmRKgR9VBjVMOi60FYxKI021QTE+Ok/QovUpIi
 xTdRr4lLILwZNmeVGoLiv4amGPZFLzpVzewqrKICnckw1i16VFx5TtIUUaGxDBJAupOS
 OLTXgSj6gcIlxZTLAZvtv5ZL/SnC+xaDZHYBf/9gAjigv+iuvCU18V2aC6tN9GuMO/pG
 uGuQ==
X-Gm-Message-State: AFuF++nagA9NLC2BAj6GRO5HHuSo4dXP/RCxYIQU8WbPqnungFmeNcP0
 EFKYMFENm5BXJpHjpypn3Jo/8ic5Pmfb8S4pm4J8ezBUuqK3eWK2rIBJahjzKIth2hME8K86JAl
 PJUwb5FQSnDk18OlXM7JBc5eB/YSSVThQPgCgIO28uUd+YfnYh3SUuh8H8K4fxsoaBh/4L8hWTN
 QVlE+NTQ==
X-Gm-Gg: AR+sD11wVSuNwT5P6f6yXtY1c2efLnvZU/daml/lFL3olVHUyh0pMugP1NyDgngxBew
 K3NrCQ0Bdg0mz76g4Vm7j0FRhYnwl5LuxyKnpJZt9hPglfw6WX3vI+GOswYZtN6vd4Ij4MwfYV9
 +DrTKJBHpeQVwalY57hkbpNBbUM+rOn9CjcMv7ujnOmSwHij+4nBAf8ju7Ot7jYS5vv3l3NeQCs
 uklnWT5dSzfrsFIl+MxWsKzj/HCCExRLFzl+LNTUqSUJyflAIWdiGQSxOCsjajLrCxFK6erewJ4
 n0b2V0INuP1yS0+wrAbg8Ki/YpIit5kBBYRNeXhdWPUogwUWkopKpeq/G1uAAc/9wiLMZwXMqeX
 MartAH7BGitoVt4BvjuhHJ9Iz1AByM2Yrm/iv1gwM64s1GCMFKTmE4Ml35BXFT2s6BXiEynalZZ
 2Tn1xX2kyli5Zh8+UqvE58tKRpj5zZ62uIETKjDommelyfad10BJ610K/crAk6ZVPha+zNL/Mfn
 RFzjmnUj8JKGTg9h51GJDIogMfpl+Zxm5ac0ppHYamb96wbeepOT7LPAbuOQh5naKmI4xYOglu0
 IKzGvGpJ0oyraMTwjmRtbIvAlFW6mpwapyQsKXJrzQSR/7cJBuI=
X-Received: by 2002:a17:907:7b83:b0:c20:fe93:a86 with SMTP id
 a640c23a62f3a-c246a62b495mr3344345466b.18.1787578656838; 
 Mon, 24 Aug 2026 06:37:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606bd05sm1212133766b.2.2026.08.24.06.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:37:36 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 13:37:34 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
X-Gerrit-Change-Number: 1592
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1592?usp=email>
X-Gerrit-Commit: 22af3b07e55f081a8fcced4045acf7fc908f1bd3
In-Reply-To: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
References: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0NDUxMzgwMDAwLkk3OWIyZGM0YTU1MGIxYzUwNjhhNDU0MDc5NzZiMGRmYzJmNzY1YjMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <62ffed7c69b75707a3a215f661188b3c36d2d1be-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyUrv-0000Gr-R4
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
Content-Type: multipart/mixed; boundary="===============2361334048962334522=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2361334048962334522==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lzLBtS33zk8="; charset=UTF-8

--lzLBtS33zk8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, razvanc=2E

=
Hello plaisthos, razvanc, 

I'd like you to reexamine a change=2E Please vi=
sit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail

to loo=
k at the new patch set (#4)=2E


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

We heavil=
y patch ax_code_coverage=2Em4, mostly to
achieve better compatibility with =
non-Linux systems=2E
- Do not depend on autoconf-archive
- Do not depend on=
 GNU make
- Use more modern --coverage flag to better support
  different c=
ompilers

Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
Signed-off-b=
y: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M =2Egitignore
M Makefil=
e=2Eam
M configure=2Eac
A lcovrc
M m4/ax_code_coverage=2Em4
M src/openvpn/M=
akefile=2Eam
6 files changed, 112 insertions(+), 43 deletions(-)


  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/92/1592/4

diff =
--git a/=2Egitignore b/=2Egitignore
index 04523af=2E=2Ee25e591 100644
--- a=
/=2Egitignore
+++ b/=2Egitignore
@@ -1,5 +1,7 @@
 *=2E[oa]
 *=2El[oa]
+*=2E=
gcda
+*=2Egcno
 *=2Edll
 *=2Eexe
 *=2Eexe=2E*
@@ -18,6 +20,7 @@
 Makefile
 =
Makefile=2Ein
 aclocal=2Em4
+aminclude_static=2Eam
 autodefs=2Eh
 autom4te=
=2Ecache
 config=2Eguess
diff --git a/Makefile=2Eam b/Makefile=2Eam
index f=
eeaabb=2E=2E716b2df 100644
--- a/Makefile=2Eam
+++ b/Makefile=2Eam
@@ -22,6=
 +22,8 @@
 #  with this program; if not, see <https://www=2Egnu=2Eorg/licen=
ses/>=2E
 #
 
+include $(top_srcdir)/aminclude_static=2Eam
+
 ACLOCAL_AMFLA=
GS =3D -I m4
 
 MAINTAINERCLEANFILES =3D \
@@ -45,7 +47,8 @@
 	CMakeLists=
=2Etxt \
 	CMakePresets=2Ejson \
 	config=2Eh=2Ecmake=2Ein \
-	forked-test-=
driver
+	forked-test-driver \
+	lcovrc
 
 =2EPHONY: config-version=2Eh doxy=
gen
 
@@ -97,3 +100,7 @@
 	SOURCE_DIR=3D"$(abs_top_srcdir)" \
 	INCLUDE_FLA=
GS=3D"$(LIBNL_GENL_CFLAGS)" \
 		"$(top_srcdir)/dev-tools/run-cppcheck=2Esh=
"
+
+CODE_COVERAGE_LCOV_SHOPTS=3D--config-file $(srcdir)/lcovrc
+clean-loca=
l: code-coverage-clean
+distclean-local: code-coverage-dist-clean
diff --gi=
t a/configure=2Eac b/configure=2Eac
index 469a475=2E=2Ebb9fd16 100644
--- a=
/configure=2Eac
+++ b/configure=2Eac
@@ -59,6 +59,8 @@
 AC_CANONICAL_HOST
 =
AC_USE_SYSTEM_EXTENSIONS
 
+AX_CODE_COVERAGE
+
 AC_ARG_ENABLE(
 	[lzo],
 	[=
AS_HELP_STRING([--disable-lzo], [disable LZO compression support @<:@defaul=
t=3Dyes@:>@])],
@@ -1236,6 +1238,11 @@
 	ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-=
cast-function-type])
 fi
 
+# If coverage is enabled remove -O arguments fr=
om CFLAGS
+if test "$enable_code_coverage" =3D "yes"; then
+   [CFLAGS=3D"`=
echo $CFLAGS | $SED -e 's/-O[s0-9]\\?//g'`"]
+fi
+
 if test "${enable_pedan=
tic}" =3D "yes"; then
 	CFLAGS=3D"${CFLAGS} -pedantic"
 	AC_DEFINE([PEDANTI=
C], [1], [Enable pedantic mode])
@@ -1355,10 +1362,10 @@
 
 TEST_LDFLAGS=3D=
"${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${OPTIONAL_LIBCAPNG=
_LIBS}"
 TEST_LDFLAGS=3D"${TEST_LDFLAGS} ${OPTIONAL_LIBNL_GENL_LIBS}"
-TEST=
_LDFLAGS=3D"${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS}"
+TEST_LDFL=
AGS=3D"${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS} ${CODE_COVERAGE_=
LIBS}"
 TEST_CFLAGS=3D"${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_C=
FLAGS} ${OPTIONAL_LIBCAPNG_CFLAGS}"
 TEST_CFLAGS=3D"${TEST_CFLAGS} ${OPTION=
AL_LIBNL_GENL_CFLAGS} ${OPTIONAL_LZO_CFLAGS}"
-TEST_CFLAGS=3D"${TEST_CFLAGS=
} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS}"
+TEST_CFLAGS=3D"${TEST_CFLAGS}=
 -I\$(top_srcdir)/include ${CMOCKA_CFLAGS} ${CODE_COVERAGE_CFLAGS}"
 
 AC_S=
UBST([TEST_LDFLAGS])
 AC_SUBST([TEST_CFLAGS])
diff --git a/lcovrc b/lcovrc
=
new file mode 100644
index 0000000=2E=2Ef8b4138
--- /dev/null
+++ b/lcovrc
=
@@ -0,0 +1,2 @@
+geninfo_external =3D 1
+geninfo_unexecuted_blocks =3D 1
di=
ff --git a/m4/ax_code_coverage=2Em4 b/m4/ax_code_coverage=2Em4
index 216708=
a4=2E=2Ef156d4d 100644
--- a/m4/ax_code_coverage=2Em4
+++ b/m4/ax_code_cove=
rage=2Em4
@@ -42,8 +42,8 @@
 #     clean-local: code-coverage-clean
 #     =
distclean-local: code-coverage-dist-clean
 #
-#   This results in a "check-=
code-coverage" rule being added to any
-#   Makefile=2Eam which do "include=
 $(top_srcdir)/aminclude_static=2Eam"
+#   This results in a "check-code-co=
verage" rule being added to the
+#   Makefile=2Eam which does "include $(to=
p_srcdir)/aminclude_static=2Eam"
 #   (assuming the module has been configu=
red with --enable-code-coverage)=2E
 #   Running `make check-code-coverage`=
 in that directory will run the
 #   module's test suite (`make check`) and=
 build a code coverage report
@@ -76,10 +76,51 @@
 
 #serial 37
 
+dnl Loca=
l modifications compared to the autoconf-archive version:
+dnl
+dnl  - AX_A=
DD_AM_MACRO_STATIC (from autoconf-archive) is replaced by a
+dnl    minimal=
 local equivalent, OPENVPN_ADD_AM_MACRO_STATIC, so that we do
+dnl    not d=
epend on autoconf-archive being installed=2E
+dnl  - The generated rules no=
 longer require GNU make=2E  The AX_CHECK_GNU_MAKE
+dnl    check is gone (w=
hich also removed the last autoconf-archive
+dnl    dependency) and the GNU=
 make specific constructs in the rules were
+dnl    replaced:
+dnl      * t=
he "ifeq ($(abs_builddir), $(abs_top_builddir))" guard is gone,
+dnl       =
 aminclude_static=2Eam may only be included by the top level
+dnl        Ma=
kefile=2Eam now (which is the only place it was ever included
+dnl        f=
rom in this project),
+dnl      * $(addprefix =2E=2E=2E) and $(if =2E=2E=2E=
) are replaced by shell code inside
+dnl        the recipes,
+dnl      * $(=
call =2E=2E=2E)/$(subst =2E=2E=2E) for the lcov test name is replaced by
+d=
nl        CODE_COVERAGE_TEST_NAME, computed at configure time,
+dnl      * =
"find =2E=2E=2E -delete" is replaced by "find =2E=2E=2E -exec rm -f {} +"=
=2E
+dnl    The only remaining non-POSIX construct is the nested variable
+=
dnl    expansion used for the silent rules ($(foo_$(V))), which is the same=

+dnl    idiom automake itself uses for AM_V_at and friends and which is
+d=
nl    understood by BSD make as well=2E
+
+AC_DEFUN([OPENVPN_PRINT_TO_FILE]=
,[
+m4_esyscmd(
+[
+printf "%s" "$2" > "$1"
+])
+])
+
+AC_DEFUN([OPENVPN_AD=
D_AM_MACRO_STATIC],[
+  OPENVPN_PRINT_TO_FILE([aminclude_static=2Eam],[$1])=

+])
+
 m4_define(_AX_CODE_COVERAGE_RULES,[
-AX_ADD_AM_MACRO_STATIC([
+OPEN=
VPN_ADD_AM_MACRO_STATIC([
+# This file was generated by ax_code_coverage
 #=
 Code coverage
 #
+# This file must only be included by the top level Makef=
ile=2Eam: the rules
+# below always report on the complete build tree=2E
+#=

+# The rules avoid GNU make specific syntax so that they also work with
+#=
 other make implementations, e=2Eg=2E BSD make=2E
+#
 # Optional:
 #  - COD=
E_COVERAGE_DIRECTORY: Top-level directory for code coverage reporting=2E
 #=
    Multiple directories may be specified, separated by whitespace=2E
@@ -9=
0,51 +131,51 @@
 #  - CODE_COVERAGE_OUTPUT_DIRECTORY: Directory for generat=
ed code coverage
 #    reports to be created=2E (Default:
 #    \$(PACKAGE_=
NAME)-\$(PACKAGE_VERSION)-coverage)
+#  - CODE_COVERAGE_TEST_NAME: Test nam=
e to record in the =2Einfo file=2E  It is
+#    computed by configure (\$(P=
ACKAGE_NAME)-\$(PACKAGE_VERSION), with dashes
+#    and dots replaced by un=
derscores) and can be overridden by defining it
+#    in Makefile=2Eam=2E
 =
#  - CODE_COVERAGE_BRANCH_COVERAGE: Set to 1 to enforce branch coverage,
 #=
    set to 0 to disable it and leave empty to stay with the default=2E
-#  =
  (Default: empty)
+#    The corresponding --rc option is passed to lcov an=
d genhtml in
+#    addition to the options below=2E (Default: empty)
 #  - =
CODE_COVERAGE_LCOV_SHOPTS_DEFAULT: Extra options shared between both lcov
-=
#    instances=2E (Default: based on $CODE_COVERAGE_BRANCH_COVERAGE)
+#    =
instances=2E (Default: empty)
 #  - CODE_COVERAGE_LCOV_SHOPTS: Extra option=
s to shared between both lcov
-#    instances=2E (Default: $CODE_COVERAGE_L=
COV_SHOPTS_DEFAULT)
+#    instances=2E (Default: \$CODE_COVERAGE_LCOV_SHOPT=
S_DEFAULT)
 #  - CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH: --gcov-tool pathtogco=
v
 #  - CODE_COVERAGE_LCOV_OPTIONS_DEFAULT: Extra options to pass to the
-#=
    collecting lcov instance=2E (Default: $CODE_COVERAGE_LCOV_OPTIONS_GCOVP=
ATH)
+#    collecting lcov instance=2E (Default: \$CODE_COVERAGE_LCOV_OPTIO=
NS_GCOVPATH)
 #  - CODE_COVERAGE_LCOV_OPTIONS: Extra options to pass to the=
 collecting lcov
-#    instance=2E (Default: $CODE_COVERAGE_LCOV_OPTIONS_DE=
FAULT)
+#    instance=2E (Default: \$CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)
 #=
  - CODE_COVERAGE_LCOV_RMOPTS_DEFAULT: Extra options to pass to the filteri=
ng
 #    lcov instance=2E (Default: empty)
-#  - CODE_COVERAGE_LCOV_RMOPTS:=
 Extra options to pass to the filtering lcov
-#    instance=2E (Default: $C=
ODE_COVERAGE_LCOV_RMOPTS_DEFAULT)
+#  - CODE_COVERAGE_LCOV_RMOPTS: Extra op=
tions to pass to the filtering
+#    lcov instance=2E (Default: \$CODE_COVE=
RAGE_LCOV_RMOPTS_DEFAULT)
 #  - CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT: Extr=
a options to pass to the
-#    genhtml instance=2E (Default: based on $CODE=
_COVERAGE_BRANCH_COVERAGE)
+#    genhtml instance=2E (Default: empty)
 #  -=
 CODE_COVERAGE_GENHTML_OPTIONS: Extra options to pass to the genhtml
-#    =
instance=2E (Default: $CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)
+#    instanc=
e=2E (Default: \$CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)
 #  - CODE_COVERAGE=
_IGNORE_PATTERN: Extra glob pattern of files to ignore
 #
 # The generated =
report will be titled using the \$(PACKAGE_NAME) and
 # \$(PACKAGE_VERSION)=
=2E In order to add the current git hash to the title,
 # use the git-versi=
on-gen script, available online=2E
 # Optional variables
-# run only on top=
 dir
 if CODE_COVERAGE_ENABLED
- ifeq (\$(abs_builddir), \$(abs_top_builddi=
r))
 CODE_COVERAGE_DIRECTORY ?=3D \$(top_builddir)
 CODE_COVERAGE_OUTPUT_FI=
LE ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage=2Einfo
 CODE_COVERAGE=
_OUTPUT_DIRECTORY ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage
 
 COD=
E_COVERAGE_BRANCH_COVERAGE ?=3D
-CODE_COVERAGE_LCOV_SHOPTS_DEFAULT ?=3D \$(=
if \$(CODE_COVERAGE_BRANCH_COVERAGE),\
---rc lcov_branch_coverage=3D\$(CODE=
_COVERAGE_BRANCH_COVERAGE))
+CODE_COVERAGE_LCOV_SHOPTS_DEFAULT ?=3D
 CODE_C=
OVERAGE_LCOV_SHOPTS ?=3D \$(CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)
 CODE_COVERA=
GE_LCOV_OPTIONS_GCOVPATH ?=3D --gcov-tool \"\$(GCOV)\"
 CODE_COVERAGE_LCOV_=
OPTIONS_DEFAULT ?=3D \$(CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)
 CODE_COVERAGE=
_LCOV_OPTIONS ?=3D \$(CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)
 CODE_COVERAGE_LC=
OV_RMOPTS_DEFAULT ?=3D
 CODE_COVERAGE_LCOV_RMOPTS ?=3D \$(CODE_COVERAGE_LCO=
V_RMOPTS_DEFAULT)
-CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT ?=3D\
-\$(if \$(CO=
DE_COVERAGE_BRANCH_COVERAGE),\
---rc genhtml_branch_coverage=3D\$(CODE_COVE=
RAGE_BRANCH_COVERAGE))
+CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT ?=3D
 CODE_CO=
VERAGE_GENHTML_OPTIONS ?=3D \$(CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)
 CODE=
_COVERAGE_IGNORE_PATTERN ?=3D
 
@@ -152,8 +193,15 @@
 code_coverage_quiet_ =
=3D \$(code_coverage_quiet_\$(AM_DEFAULT_VERBOSITY))
 code_coverage_quiet_0=
 =3D --quiet
 
-# sanitizes the test-name: replaces with underscores: dashe=
s and dots
-code_coverage_sanitize =3D \$(subst -,_,\$(subst =2E,_,\$(1)))
=
+# Shell fragments used by the recipes below=2E  They are portable
+# repla=
cements for the GNU make functions \$(addprefix =2E=2E=2E) and \$(if =2E=2E=
=2E):
+# code_coverage_dirs_opt sets \$cc_dirs to a list of --directory opt=
ions,
+# code_coverage_prefix_opt sets \$cc_prefix to a list of --prefix op=
tions and
+# code_coverage_*_branch_opt set \$cc_branch to the branch cover=
age option=2E
+code_coverage_dirs_opt =3D cc_dirs=3D; for cc_dir in \$(CODE=
_COVERAGE_DIRECTORY); do cc_dirs=3D\"\$\$cc_dirs --directory \$\$cc_dir\"; =
done
+code_coverage_prefix_opt =3D cc_prefix=3D; for cc_dir in \$(CODE_COVE=
RAGE_DIRECTORY); do cc_prefix=3D\"\$\$cc_prefix --prefix \$\$cc_dir\"; done=

+code_coverage_lcov_branch_opt =3D cc_branch=3D; test -z \"\$(CODE_COVERAG=
E_BRANCH_COVERAGE)\" || cc_branch=3D\"--rc lcov_branch_coverage=3D\$(CODE_C=
OVERAGE_BRANCH_COVERAGE)\"
+code_coverage_genhtml_branch_opt =3D cc_branch=
=3D; test -z \"\$(CODE_COVERAGE_BRANCH_COVERAGE)\" || cc_branch=3D\"--rc ge=
nhtml_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE)\"
 
 # Use recurs=
ive makes in order to ignore errors during check
 check-code-coverage:
@@ -=
162,29 +210,26 @@
 
 # Capture code coverage data
 code-coverage-capture: c=
ode-coverage-capture-hook
-	\$(code_coverage_v_lcov_cap)\$(LCOV) \$(code_co=
verage_quiet) \$(addprefix --directory ,\$(CODE_COVERAGE_DIRECTORY)) --capt=
ure --output-file \"\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\" --test-name \"\$(=
call code_coverage_sanitize,\$(PACKAGE_NAME)-\$(PACKAGE_VERSION))\" --no-ch=
ecksum --compat-libtool \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV=
_OPTIONS)
-	\$(code_coverage_v_lcov_ign)\$(LCOV) \$(code_coverage_quiet) \$=
(addprefix --directory ,\$(CODE_COVERAGE_DIRECTORY)) --remove \"\$(CODE_COV=
ERAGE_OUTPUT_FILE)=2Etmp\" \$(CODE_COVERAGE_IGNORE_PATTERN) --output-file \=
"\$(CODE_COVERAGE_OUTPUT_FILE)\" \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVE=
RAGE_LCOV_RMOPTS)
+	\$(code_coverage_v_lcov_cap)\$(code_coverage_dirs_opt);=
 \\
+	\$(code_coverage_lcov_branch_opt); \\
+	\$(LCOV) \$(code_coverage_qui=
et) \$\$cc_dirs --capture --output-file \"\$(CODE_COVERAGE_OUTPUT_FILE)=2Et=
mp\" --test-name \"\$(CODE_COVERAGE_TEST_NAME)\" --no-checksum --compat-lib=
tool \$\$cc_branch \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_OPTI=
ONS)
+	\$(code_coverage_v_lcov_ign)\$(code_coverage_dirs_opt); \\
+	\$(code=
_coverage_lcov_branch_opt); \\
+	\$(LCOV) \$(code_coverage_quiet) \$\$cc_di=
rs --remove \"\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\" \$(CODE_COVERAGE_IGNORE=
_PATTERN) --output-file \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \$\$cc_branch \$(=
CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_RMOPTS)
 	-@rm -f \"\$(COD=
E_COVERAGE_OUTPUT_FILE)=2Etmp\"
-	\$(code_coverage_v_genhtml)LANG=3DC \$(GE=
NHTML) \$(code_coverage_quiet) \$(addprefix --prefix ,\$(CODE_COVERAGE_DIRE=
CTORY)) --output-directory \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\" --title \=
"\$(PACKAGE_NAME)-\$(PACKAGE_VERSION) Code Coverage\" --legend --show-detai=
ls \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \$(CODE_COVERAGE_GENHTML_OPTIONS)
+	\$=
(code_coverage_v_genhtml)\$(code_coverage_prefix_opt); \\
+	\$(code_coverag=
e_genhtml_branch_opt); \\
+	LANG=3DC \$(GENHTML) \$(code_coverage_quiet) \$=
\$cc_prefix --output-directory \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\" --tit=
le \"\$(PACKAGE_NAME)-\$(PACKAGE_VERSION) Code Coverage\" --legend --show-d=
etails \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \$\$cc_branch \$(CODE_COVERAGE_GEN=
HTML_OPTIONS)
 	@echo \"file://\$(abs_builddir)/\$(CODE_COVERAGE_OUTPUT_DIR=
ECTORY)/index=2Ehtml\"
 
 code-coverage-clean:
 	-\$(LCOV) --directory \$(t=
op_builddir) -z
 	-rm -rf \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \"\$(CODE_COVER=
AGE_OUTPUT_FILE)=2Etmp\" \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\"
-	-find =2E=
 \\( -name \"*=2Egcda\" -o -name \"*=2Egcno\" -o -name \"*=2Egcov\" \\) -de=
lete
+	-find =2E \\( -name \"*=2Egcda\" -o -name \"*=2Egcno\" -o -name \"*=
=2Egcov\" \\) -exec rm -f '{}' +
 
 code-coverage-dist-clean:
 
 A][M_DISTC=
HECK_CONFIGURE_FLAGS :=3D \$(A][M_DISTCHECK_CONFIGURE_FLAGS) --disable-code=
-coverage
- else # ifneq (\$(abs_builddir), \$(abs_top_builddir))
-check-co=
de-coverage:
-
-code-coverage-capture: code-coverage-capture-hook
-
-code-c=
overage-clean:
-
-code-coverage-dist-clean:
- endif # ifeq (\$(abs_builddir=
), \$(abs_top_builddir))
 else #! CODE_COVERAGE_ENABLED
 # Use recursive ma=
kes in order to ignore errors during check
 check-code-coverage:
@@ -206,8 =
+251,7 @@
 ])
 
 AC_DEFUN([_AX_CODE_COVERAGE_ENABLED],[
-	AX_CHECK_GNU_MAKE=
([],[AC_MSG_ERROR([not using GNU make that is needed for coverage])])
-	AC_=
REQUIRE([AX_ADD_AM_MACRO_STATIC])
+	AC_REQUIRE([OPENVPN_ADD_AM_MACRO_STATIC=
])
 	# check for gcov
 	AC_CHECK_TOOL([GCOV],
 		  [$_AX_CODE_COVERAGE_GCOV=
_PROG_WITH],
@@ -232,13 +276,12 @@
 		AC_MSG_ERROR([Could not find genhtml =
from the lcov package])
 	])
 
-	AC_CHECK_LIB([gcov], [_gcov_init], [CODE_C=
OVERAGE_LIBS=3D"-lgcov"], [CODE_COVERAGE_LIBS=3D""])
-
 	dnl Build the code=
 coverage flags
 	dnl Define CODE_COVERAGE_LDFLAGS for backwards compatibil=
ity
 	CODE_COVERAGE_CPPFLAGS=3D"-DNDEBUG"
-	CODE_COVERAGE_CFLAGS=3D"-O0 -g =
-fprofile-arcs -ftest-coverage"
-	CODE_COVERAGE_CXXFLAGS=3D"-O0 -g -fprofil=
e-arcs -ftest-coverage"
+	CODE_COVERAGE_CFLAGS=3D"-O0 -g --coverage"
+	CODE=
_COVERAGE_CXXFLAGS=3D"-O0 -g --coverage"
+	CODE_COVERAGE_LIBS=3D"--coverage=
"
 
 	AC_SUBST([CODE_COVERAGE_CPPFLAGS])
 	AC_SUBST([CODE_COVERAGE_CFLAGS])=

@@ -265,6 +308,10 @@
 	AC_SUBST([CODE_COVERAGE_ENABLED], [$enable_code_cov=
erage])
 	AC_MSG_RESULT($enable_code_coverage)
 
+	dnl The lcov test name m=
ust not contain dashes or dots
+	CODE_COVERAGE_TEST_NAME=3D`echo "$PACKAGE_=
NAME-$PACKAGE_VERSION" | tr '=2E-' '__'`
+	AC_SUBST([CODE_COVERAGE_TEST_NAM=
E])
+
 	AS_IF([ test "x$enable_code_coverage" =3D xyes ], [
 		_AX_CODE_COV=
ERAGE_ENABLED
 	      ])
diff --git a/src/openvpn/Makefile=2Eam b/src/openv=
pn/Makefile=2Eam
index 4220d07=2E=2E26eb36c 100644
--- a/src/openvpn/Makefi=
le=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -31,9 +31,12 @@
 	$(OPTIONAL_SYS=
TEMD_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \
 	$(OPTIONAL_INOTIFY_CF=
LAGS) \
+	$(CODE_COVERAGE_CFLAGS) \
 	-DPLUGIN_LIBDIR=3D\"${plugindir}\" \
=
 	-DDEFAULT_DNS_UPDOWN=3D\"${scriptdir}/dns-updown\"
 
+AM_LIBS =3D $(CODE_=
COVERAGE_LIBS)
+
 if WIN32
 # we want unicode entry point but not the macro=

 AM_CFLAGS +=3D -municode -UUNICODE

-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1592?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
Gerrit-Change=
-Number: 1592
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Attention: razvanc <razvanc@mailbox=2Eorg>

--lzLBtS33zk8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, razvanc=2E </p>
<p>flichtenh=
eld <strong>uploaded patch set #4</strong> to this change=2E</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail">View Change=
</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">configure: Add --enable-code-coverage<br><br>Can be u=
sed like this<br>=2E/configure --enable-code-coverage<br>make<br>make check=
<br>make code-coverage-capture<br><br>We heavily patch ax_code_coverage=2Em=
4, mostly to<br>achieve better compatibility with non-Linux systems=2E<br>-=
 Do not depend on autoconf-archive<br>- Do not depend on GNU make<br>- Use =
more modern --coverage flag to better support<br>  different compilers<br><=
br>Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M =2Egitignore<b=
r>M Makefile=2Eam<br>M configure=2Eac<br>A lcovrc<br>M m4/ax_code_coverage=
=2Em4<br>M src/openvpn/Makefile=2Eam<br>6 files changed, 112 insertions(+),=
 43 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/92/1592/4</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=2Egitigno=
re b/=2Egitignore</span><br><span>index 04523af=2E=2Ee25e591 100644</span><=
br><span>--- a/=2Egitignore</span><br><span>+++ b/=2Egitignore</span><br><s=
pan>@@ -1,5 +1,7 @@</span><br><span> *=2E[oa]</span><br><span> *=2El[oa]</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+*=2Egcda</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+*=2Egcno</span><br><span> *=2Edll=
</span><br><span> *=2Eexe</span><br><span> *=2Eexe=2E*</span><br><span>@@ -=
18,6 +20,7 @@</span><br><span> Makefile</span><br><span> Makefile=2Ein</spa=
n><br><span> aclocal=2Em4</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+aminclude_static=2Eam</span><br><span> autodefs=2Eh</span><br><span> =
autom4te=2Ecache</span><br><span> config=2Eguess</span><br><span>diff --git=
 a/Makefile=2Eam b/Makefile=2Eam</span><br><span>index feeaabb=2E=2E716b2df=
 100644</span><br><span>--- a/Makefile=2Eam</span><br><span>+++ b/Makefile=
=2Eam</span><br><span>@@ -22,6 +22,8 @@</span><br><span> #  with this progr=
am; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><spa=
n> #</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+include $(top_srcdir)/aminclude_static=2Eam</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> ACLOCAL_AMFLAGS =3D -I m4</spa=
n><br><span> </span><br><span> MAINTAINERCLEANFILES =3D \</span><br><span>@=
@ -45,7 +47,8 @@</span><br><span> 	CMakeLists=2Etxt \</span><br><span> 	CMa=
kePresets=2Ejson \</span><br><span> 	config=2Eh=2Ecmake=2Ein \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	forked-test-driver</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	forked-test-driver \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	lcovrc</span><br><span> </span>=
<br><span> =2EPHONY: config-version=2Eh doxygen</span><br><span> </span><br=
><span>@@ -97,3 +100,7 @@</span><br><span> 	SOURCE_DIR=3D&quot;$(abs_top_sr=
cdir)&quot; \</span><br><span> 	INCLUDE_FLAGS=3D&quot;$(LIBNL_GENL_CFLAGS)&=
quot; \</span><br><span> 		&quot;$(top_srcdir)/dev-tools/run-cppcheck=2Esh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_LCOV_SHOPTS=3D--con=
fig-file $(srcdir)/lcovrc</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+clean-local: code-coverage-clean</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+distclean-local: code-coverage-dist-clean</span><br><spa=
n>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>index 469a47=
5=2E=2Ebb9fd16 100644</span><br><span>--- a/configure=2Eac</span><br><span>=
+++ b/configure=2Eac</span><br><span>@@ -59,6 +59,8 @@</span><br><span> AC_=
CANONICAL_HOST</span><br><span> AC_USE_SYSTEM_EXTENSIONS</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+AX_CODE_COVERAGE</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> AC_AR=
G_ENABLE(</span><br><span> 	[lzo],</span><br><span> 	[AS_HELP_STRING([--dis=
able-lzo], [disable LZO compression support @&lt;:@default=3Dyes@:&gt;@])],=
</span><br><span>@@ -1236,6 +1238,11 @@</span><br><span> 	ACL_CHECK_ADD_COM=
PILE_FLAGS([-Wno-cast-function-type])</span><br><span> fi</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# If coverage is en=
abled remove -O arguments from CFLAGS</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+if test &quot;$enable_code_coverage&quot; =3D &quot;yes&q=
uot;; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   [CFLAG=
S=3D&quot;`echo $CFLAGS | $SED -e &#39;s/-O[s0-9]\\?//g&#39;`&quot;]</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> if test &quot;${enable_=
pedantic}&quot; =3D &quot;yes&quot;; then</span><br><span> 	CFLAGS=3D&quot;=
${CFLAGS} -pedantic&quot;</span><br><span> 	AC_DEFINE([PEDANTIC], [1], [Ena=
ble pedantic mode])</span><br><span>@@ -1355,10 +1362,10 @@</span><br><span=
> </span><br><span> TEST_LDFLAGS=3D&quot;${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL=
_PKCS11_HELPER_LIBS} ${OPTIONAL_LIBCAPNG_LIBS}&quot;</span><br><span> TEST_=
LDFLAGS=3D&quot;${TEST_LDFLAGS} ${OPTIONAL_LIBNL_GENL_LIBS}&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-TEST_LDFLAGS=3D&quot;${TEST_LDF=
LAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS}&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+TEST_LDFLAGS=3D&quot;${TEST_LDFLAGS} ${OPTIONAL=
_LZO_LIBS} ${CMOCKA_LIBS} ${CODE_COVERAGE_LIBS}&quot;</span><br><span> TEST=
_CFLAGS=3D&quot;${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS} =
${OPTIONAL_LIBCAPNG_CFLAGS}&quot;</span><br><span> TEST_CFLAGS=3D&quot;${TE=
ST_CFLAGS} ${OPTIONAL_LIBNL_GENL_CFLAGS} ${OPTIONAL_LZO_CFLAGS}&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_CFLAGS=3D&quot;${TEST_=
CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS}&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+TEST_CFLAGS=3D&quot;${TEST_CFLAGS} -I\$=
(top_srcdir)/include ${CMOCKA_CFLAGS} ${CODE_COVERAGE_CFLAGS}&quot;</span><=
br><span> </span><br><span> AC_SUBST([TEST_LDFLAGS])</span><br><span> AC_SU=
BST([TEST_CFLAGS])</span><br><span>diff --git a/lcovrc b/lcovrc</span><br><=
span>new file mode 100644</span><br><span>index 0000000=2E=2Ef8b4138</span>=
<br><span>--- /dev/null</span><br><span>+++ b/lcovrc</span><br><span>@@ -0,=
0 +1,2 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+geninfo_ex=
ternal =3D 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+geninfo=
_unexecuted_blocks =3D 1</span><br><span>diff --git a/m4/ax_code_coverage=
=2Em4 b/m4/ax_code_coverage=2Em4</span><br><span>index 216708a4=2E=2Ef156d4=
d 100644</span><br><span>--- a/m4/ax_code_coverage=2Em4</span><br><span>+++=
 b/m4/ax_code_coverage=2Em4</span><br><span>@@ -42,8 +42,8 @@</span><br><sp=
an> #     clean-local: code-coverage-clean</span><br><span> #     distclean=
-local: code-coverage-dist-clean</span><br><span> #</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#   This results in a &quot;check-code-cove=
rage&quot; rule being added to any</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#   Makefile=2Eam which do &quot;include $(top_srcdir)/aminclu=
de_static=2Eam&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#   This results in a &quot;check-code-coverage&quot; rule being added to =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   Makefile=2Ea=
m which does &quot;include $(top_srcdir)/aminclude_static=2Eam&quot;</span>=
<br><span> #   (assuming the module has been configured with --enable-code-=
coverage)=2E</span><br><span> #   Running `make check-code-coverage` in tha=
t directory will run the</span><br><span> #   module&#39;s test suite (`mak=
e check`) and build a code coverage report</span><br><span>@@ -76,10 +76,51=
 @@</span><br><span> </span><br><span> #serial 37</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+dnl Local modifications com=
pared to the autoconf-archive version:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+dnl</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+dnl  - AX_ADD_AM_MACRO_STATIC (from autoconf-archive) is replaced by a</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl    minimal local =
equivalent, OPENVPN_ADD_AM_MACRO_STATIC, so that we do</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+dnl    not depend on autoconf-archive be=
ing installed=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl=
  - The generated rules no longer require GNU make=2E  The AX_CHECK_GNU_MAK=
E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl    check is go=
ne (which also removed the last autoconf-archive</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+dnl    dependency) and the GNU make specific c=
onstructs in the rules were</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+dnl    replaced:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+dnl      * the &quot;ifeq ($(abs_builddir), $(abs_top_builddir))&quot;=
 guard is gone,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl =
       aminclude_static=2Eam may only be included by the top level</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+dnl        Makefile=2Eam now=
 (which is the only place it was ever included</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+dnl        from in this project),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+dnl      * $(addprefix =2E=2E=2E) =
and $(if =2E=2E=2E) are replaced by shell code inside</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dnl        the recipes,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+dnl      * $(call =2E=2E=2E)/$(subst =
=2E=2E=2E) for the lcov test name is replaced by</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+dnl        CODE_COVERAGE_TEST_NAME, computed a=
t configure time,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dn=
l      * &quot;find =2E=2E=2E -delete&quot; is replaced by &quot;find =2E=
=2E=2E -exec rm -f {} +&quot;=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+dnl    The only remaining non-POSIX construct is the nested va=
riable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl    expans=
ion used for the silent rules ($(foo_$(V))), which is the same</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+dnl    idiom automake itself use=
s for AM_V_at and friends and which is</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+dnl    understood by BSD make as well=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+AC_DEFUN([OPENVPN_PRINT_TO_FILE],[</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+m4_esyscmd(</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+[</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+printf &quot;%s&quot; &quot;$2&quot; &gt; &quot;$1&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+])</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_DEF=
UN([OPENVPN_ADD_AM_MACRO_STATIC],[</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  OPENVPN_PRINT_TO_FILE([aminclude_static=2Eam],[$1])</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> m4_define(_AX_CODE_COVE=
RAGE_RULES,[</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AX_ADD_AM=
_MACRO_STATIC([</span><br><span style=3D"color: hsl(120, 100%, 40%);">+OPEN=
VPN_ADD_AM_MACRO_STATIC([</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# This file was generated by ax_code_coverage</span><br><span> # Code=
 coverage</span><br><span> #</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# This file must only be included by the top level Makefile=2Eam: =
the rules</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# below al=
ways report on the complete build tree=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# The rules avoid GNU make specific syntax so that they also work with<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# other make impleme=
ntations, e=2Eg=2E BSD make=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#</span><br><span> # Optional:</span><br><span> #  - CODE_COVERA=
GE_DIRECTORY: Top-level directory for code coverage reporting=2E</span><br>=
<span> #    Multiple directories may be specified, separated by whitespace=
=2E</span><br><span>@@ -90,51 +131,51 @@</span><br><span> #  - CODE_COVERAG=
E_OUTPUT_DIRECTORY: Directory for generated code coverage</span><br><span> =
#    reports to be created=2E (Default:</span><br><span> #    \$(PACKAGE_NA=
ME)-\$(PACKAGE_VERSION)-coverage)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#  - CODE_COVERAGE_TEST_NAME: Test name to record in the =2Ei=
nfo file=2E  It is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
    computed by configure (\$(PACKAGE_NAME)-\$(PACKAGE_VERSION), with dashe=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    and dots repl=
aced by underscores) and can be overridden by defining it</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#    in Makefile=2Eam=2E</span><br><s=
pan> #  - CODE_COVERAGE_BRANCH_COVERAGE: Set to 1 to enforce branch coverag=
e,</span><br><span> #    set to 0 to disable it and leave empty to stay wit=
h the default=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#    =
(Default: empty)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  =
  The corresponding --rc option is passed to lcov and genhtml in</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#    addition to the options b=
elow=2E (Default: empty)</span><br><span> #  - CODE_COVERAGE_LCOV_SHOPTS_DE=
FAULT: Extra options shared between both lcov</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#    instances=2E (Default: based on $CODE_COVERAGE=
_BRANCH_COVERAGE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
   instances=2E (Default: empty)</span><br><span> #  - CODE_COVERAGE_LCOV_S=
HOPTS: Extra options to shared between both lcov</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#    instances=2E (Default: $CODE_COVERAGE_LCOV_=
SHOPTS_DEFAULT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   =
 instances=2E (Default: \$CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)</span><br><spa=
n> #  - CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH: --gcov-tool pathtogcov</span><=
br><span> #  - CODE_COVERAGE_LCOV_OPTIONS_DEFAULT: Extra options to pass to=
 the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#    collecting l=
cov instance=2E (Default: $CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#    collecting lcov instance=
=2E (Default: \$CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)</span><br><span> #  - =
CODE_COVERAGE_LCOV_OPTIONS: Extra options to pass to the collecting lcov</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#    instance=2E (Defaul=
t: $CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#    instance=2E (Default: \$CODE_COVERAGE_LCOV_OPTIONS=
_DEFAULT)</span><br><span> #  - CODE_COVERAGE_LCOV_RMOPTS_DEFAULT: Extra op=
tions to pass to the filtering</span><br><span> #    lcov instance=2E (Defa=
ult: empty)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  - CODE_=
COVERAGE_LCOV_RMOPTS: Extra options to pass to the filtering lcov</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#    instance=2E (Default: $COD=
E_COVERAGE_LCOV_RMOPTS_DEFAULT)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#  - CODE_COVERAGE_LCOV_RMOPTS: Extra options to pass to the fi=
ltering</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    lcov in=
stance=2E (Default: \$CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)</span><br><span> #=
  - CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT: Extra options to pass to the</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#    genhtml instance=2E =
(Default: based on $CODE_COVERAGE_BRANCH_COVERAGE)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#    genhtml instance=2E (Default: empty)</s=
pan><br><span> #  - CODE_COVERAGE_GENHTML_OPTIONS: Extra options to pass to=
 the genhtml</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#    inst=
ance=2E (Default: $CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#    instance=2E (Default: \$CODE_COV=
ERAGE_GENHTML_OPTIONS_DEFAULT)</span><br><span> #  - CODE_COVERAGE_IGNORE_P=
ATTERN: Extra glob pattern of files to ignore</span><br><span> #</span><br>=
<span> # The generated report will be titled using the \$(PACKAGE_NAME) and=
</span><br><span> # \$(PACKAGE_VERSION)=2E In order to add the current git =
hash to the title,</span><br><span> # use the git-version-gen script, avail=
able online=2E</span><br><span> # Optional variables</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# run only on top dir</span><br><span> if C=
ODE_COVERAGE_ENABLED</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
ifeq (\$(abs_builddir), \$(abs_top_builddir))</span><br><span> CODE_COVERAG=
E_DIRECTORY ?=3D \$(top_builddir)</span><br><span> CODE_COVERAGE_OUTPUT_FIL=
E ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage=2Einfo</span><br><span=
> CODE_COVERAGE_OUTPUT_DIRECTORY ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-=
coverage</span><br><span> </span><br><span> CODE_COVERAGE_BRANCH_COVERAGE ?=
=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-CODE_COVERAGE_LCOV=
_SHOPTS_DEFAULT ?=3D \$(if \$(CODE_COVERAGE_BRANCH_COVERAGE),\</span><br><s=
pan>---rc lcov_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_LCOV_SHOPTS_D=
EFAULT ?=3D</span><br><span> CODE_COVERAGE_LCOV_SHOPTS ?=3D \$(CODE_COVERAG=
E_LCOV_SHOPTS_DEFAULT)</span><br><span> CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH=
 ?=3D --gcov-tool \&quot;\$(GCOV)\&quot;</span><br><span> CODE_COVERAGE_LCO=
V_OPTIONS_DEFAULT ?=3D \$(CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)</span><br><s=
pan> CODE_COVERAGE_LCOV_OPTIONS ?=3D \$(CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)=
</span><br><span> CODE_COVERAGE_LCOV_RMOPTS_DEFAULT ?=3D</span><br><span> C=
ODE_COVERAGE_LCOV_RMOPTS ?=3D \$(CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-CODE_COVERAGE_GENHTML_OPTIONS=
_DEFAULT ?=3D\</span><br><span style=3D"color: hsl(0, 100%, 40%);">-\$(if \=
$(CODE_COVERAGE_BRANCH_COVERAGE),\</span><br><span>---rc genhtml_branch_cov=
erage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT ?=3D</span><br=
><span> CODE_COVERAGE_GENHTML_OPTIONS ?=3D \$(CODE_COVERAGE_GENHTML_OPTIONS=
_DEFAULT)</span><br><span> CODE_COVERAGE_IGNORE_PATTERN ?=3D</span><br><spa=
n> </span><br><span>@@ -152,8 +193,15 @@</span><br><span> code_coverage_qui=
et_ =3D \$(code_coverage_quiet_\$(AM_DEFAULT_VERBOSITY))</span><br><span> c=
ode_coverage_quiet_0 =3D --quiet</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-# sanitizes the test-name: replaces with under=
scores: dashes and dots</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-code_coverage_sanitize =3D \$(subst -,_,\$(subst =2E,_,\$(1)))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# Shell fragments used by the =
recipes below=2E  They are portable</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# replacements for the GNU make functions \$(addprefix =2E=
=2E=2E) and \$(if =2E=2E=2E):</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# code_coverage_dirs_opt sets \$cc_dirs to a list of --directory =
options,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# code_cove=
rage_prefix_opt sets \$cc_prefix to a list of --prefix options and</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# code_coverage_*_branch_opt=
 set \$cc_branch to the branch coverage option=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+code_coverage_dirs_opt =3D cc_dirs=3D; for cc=
_dir in \$(CODE_COVERAGE_DIRECTORY); do cc_dirs=3D\&quot;\$\$cc_dirs --dire=
ctory \$\$cc_dir\&quot;; done</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+code_coverage_prefix_opt =3D cc_prefix=3D; for cc_dir in \$(CODE_=
COVERAGE_DIRECTORY); do cc_prefix=3D\&quot;\$\$cc_prefix --prefix \$\$cc_di=
r\&quot;; done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code_=
coverage_lcov_branch_opt =3D cc_branch=3D; test -z \&quot;\$(CODE_COVERAGE_=
BRANCH_COVERAGE)\&quot; || cc_branch=3D\&quot;--rc lcov_branch_coverage=3D\=
$(CODE_COVERAGE_BRANCH_COVERAGE)\&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+code_coverage_genhtml_branch_opt =3D cc_branch=3D; test=
 -z \&quot;\$(CODE_COVERAGE_BRANCH_COVERAGE)\&quot; || cc_branch=3D\&quot;-=
-rc genhtml_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE)\&quot;</spa=
n><br><span> </span><br><span> # Use recursive makes in order to ignore err=
ors during check</span><br><span> check-code-coverage:</span><br><span>@@ -=
162,29 +210,26 @@</span><br><span> </span><br><span> # Capture code coverag=
e data</span><br><span> code-coverage-capture: code-coverage-capture-hook</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	\$(code_coverage_v_lco=
v_cap)\$(LCOV) \$(code_coverage_quiet) \$(addprefix --directory ,\$(CODE_CO=
VERAGE_DIRECTORY)) --capture --output-file \&quot;\$(CODE_COVERAGE_OUTPUT_F=
ILE)=2Etmp\&quot; --test-name \&quot;\$(call code_coverage_sanitize,\$(PACK=
AGE_NAME)-\$(PACKAGE_VERSION))\&quot; --no-checksum --compat-libtool \$(COD=
E_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_OPTIONS)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	\$(code_coverage_v_lcov_ign)\$(LCOV) \$(c=
ode_coverage_quiet) \$(addprefix --directory ,\$(CODE_COVERAGE_DIRECTORY)) =
--remove \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot; \$(CODE_COVERAGE=
_IGNORE_PATTERN) --output-file \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; =
\$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_RMOPTS)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	\$(code_coverage_v_lcov_cap)\$(cod=
e_coverage_dirs_opt); \\</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	\$(code_coverage_lcov_branch_opt); \\</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	\$(LCOV) \$(code_coverage_quiet) \$\$cc_dirs --cap=
ture --output-file \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot; --test=
-name \&quot;\$(CODE_COVERAGE_TEST_NAME)\&quot; --no-checksum --compat-libt=
ool \$\$cc_branch \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_OPTIO=
NS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	\$(code_coverag=
e_v_lcov_ign)\$(code_coverage_dirs_opt); \\</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	\$(code_coverage_lcov_branch_opt); \\</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	\$(LCOV) \$(code_coverage_quiet=
) \$\$cc_dirs --remove \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot; \$=
(CODE_COVERAGE_IGNORE_PATTERN) --output-file \&quot;\$(CODE_COVERAGE_OUTPUT=
_FILE)\&quot; \$\$cc_branch \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_=
LCOV_RMOPTS)</span><br><span> 	-@rm -f \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=
=2Etmp\&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	\$(code=
_coverage_v_genhtml)LANG=3DC \$(GENHTML) \$(code_coverage_quiet) \$(addpref=
ix --prefix ,\$(CODE_COVERAGE_DIRECTORY)) --output-directory \&quot;\$(CODE=
_COVERAGE_OUTPUT_DIRECTORY)\&quot; --title \&quot;\$(PACKAGE_NAME)-\$(PACKA=
GE_VERSION) Code Coverage\&quot; --legend --show-details \&quot;\$(CODE_COV=
ERAGE_OUTPUT_FILE)\&quot; \$(CODE_COVERAGE_GENHTML_OPTIONS)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	\$(code_coverage_v_genhtml)\$(code=
_coverage_prefix_opt); \\</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	\$(code_coverage_genhtml_branch_opt); \\</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	LANG=3DC \$(GENHTML) \$(code_coverage_quiet) \=
$\$cc_prefix --output-directory \&quot;\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\&=
quot; --title \&quot;\$(PACKAGE_NAME)-\$(PACKAGE_VERSION) Code Coverage\&qu=
ot; --legend --show-details \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \$\=
$cc_branch \$(CODE_COVERAGE_GENHTML_OPTIONS)</span><br><span> 	@echo \&quot=
;file://\$(abs_builddir)/\$(CODE_COVERAGE_OUTPUT_DIRECTORY)/index=2Ehtml\&q=
uot;</span><br><span> </span><br><span> code-coverage-clean:</span><br><spa=
n> 	-\$(LCOV) --directory \$(top_builddir) -z</span><br><span> 	-rm -rf \&q=
uot;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \&quot;\$(CODE_COVERAGE_OUTPUT_FIL=
E)=2Etmp\&quot; \&quot;\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	-find =2E \\( -name \&quot;*=2E=
gcda\&quot; -o -name \&quot;*=2Egcno\&quot; -o -name \&quot;*=2Egcov\&quot;=
 \\) -delete</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-find =
=2E \\( -name \&quot;*=2Egcda\&quot; -o -name \&quot;*=2Egcno\&quot; -o -na=
me \&quot;*=2Egcov\&quot; \\) -exec rm -f &#39;{}&#39; +</span><br><span> <=
/span><br><span> code-coverage-dist-clean:</span><br><span> </span><br><spa=
n> A][M_DISTCHECK_CONFIGURE_FLAGS :=3D \$(A][M_DISTCHECK_CONFIGURE_FLAGS) -=
-disable-code-coverage</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- else # ifneq (\$(abs_builddir), \$(abs_top_builddir))</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-check-code-coverage:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-code-coverage-capture: code-coverage-capture-hook</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-code-coverage-clean:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cod=
e-coverage-dist-clean:</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- endif # ifeq (\$(abs_builddir), \$(abs_top_builddir))</span><br><span> el=
se #! CODE_COVERAGE_ENABLED</span><br><span> # Use recursive makes in order=
 to ignore errors during check</span><br><span> check-code-coverage:</span>=
<br><span>@@ -206,8 +251,7 @@</span><br><span> ])</span><br><span> </span><=
br><span> AC_DEFUN([_AX_CODE_COVERAGE_ENABLED],[</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	AX_CHECK_GNU_MAKE([],[AC_MSG_ERROR([not using G=
NU make that is needed for coverage])])</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	AC_REQUIRE([AX_ADD_AM_MACRO_STATIC])</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	AC_REQUIRE([OPENVPN_ADD_AM_MACRO_STATI=
C])</span><br><span> 	# check for gcov</span><br><span> 	AC_CHECK_TOOL([GCO=
V],</span><br><span> 		  [$_AX_CODE_COVERAGE_GCOV_PROG_WITH],</span><br><sp=
an>@@ -232,13 +276,12 @@</span><br><span> 		AC_MSG_ERROR([Could not find ge=
nhtml from the lcov package])</span><br><span> 	])</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	AC_CHECK_LIB([gcov], [_gcov=
_init], [CODE_COVERAGE_LIBS=3D&quot;-lgcov&quot;], [CODE_COVERAGE_LIBS=3D&q=
uot;&quot;])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> 	dnl Build the code coverage flags</span><br><span> 	dnl Define CO=
DE_COVERAGE_LDFLAGS for backwards compatibility</span><br><span> 	CODE_COVE=
RAGE_CPPFLAGS=3D&quot;-DNDEBUG&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	CODE_COVERAGE_CFLAGS=3D&quot;-O0 -g -fprofile-arcs -ftest-c=
overage&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	CODE_CO=
VERAGE_CXXFLAGS=3D&quot;-O0 -g -fprofile-arcs -ftest-coverage&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	CODE_COVERAGE_CFLAGS=3D&qu=
ot;-O0 -g --coverage&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	CODE_COVERAGE_CXXFLAGS=3D&quot;-O0 -g --coverage&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	CODE_COVERAGE_LIBS=3D&quot;--co=
verage&quot;</span><br><span> </span><br><span> 	AC_SUBST([CODE_COVERAGE_CP=
PFLAGS])</span><br><span> 	AC_SUBST([CODE_COVERAGE_CFLAGS])</span><br><span=
>@@ -265,6 +308,10 @@</span><br><span> 	AC_SUBST([CODE_COVERAGE_ENABLED], [=
$enable_code_coverage])</span><br><span> 	AC_MSG_RESULT($enable_code_covera=
ge)</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	dnl The lcov test name must not contain dashes or dots</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	CODE_COVERAGE_TEST_NAME=3D`echo &quo=
t;$PACKAGE_NAME-$PACKAGE_VERSION&quot; | tr &#39;=2E-&#39; &#39;__&#39;`</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_SUBST([CODE_COVERA=
GE_TEST_NAME])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> 	AS_IF([ test &quot;x$enable_code_coverage&quot; =3D xyes ], [=
</span><br><span> 		_AX_CODE_COVERAGE_ENABLED</span><br><span> 	      ])</s=
pan><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=
=2Eam</span><br><span>index 4220d07=2E=2E26eb36c 100644</span><br><span>---=
 a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Ea=
m</span><br><span>@@ -31,9 +31,12 @@</span><br><span> 	$(OPTIONAL_SYSTEMD_C=
FLAGS) \</span><br><span> 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \</span><br><sp=
an> 	$(OPTIONAL_INOTIFY_CFLAGS) \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	$(CODE_COVERAGE_CFLAGS) \</span><br><span> 	-DPLUGIN_LIBDIR=
=3D\&quot;${plugindir}\&quot; \</span><br><span> 	-DDEFAULT_DNS_UPDOWN=3D\&=
quot;${scriptdir}/dns-updown\&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+AM_LIBS =3D $(CODE_COVERAGE_LIBS)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> if WIN32<=
/span><br><span> # we want unicode entry point but not the macro</span><br>=
<span> AM_CFLAGS +=3D -municode -UUNICODE</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592=
?usp=3Demail">change 1592</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1592?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchse=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1592 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerri=
t-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--lzLBtS33zk8=--


--===============2361334048962334522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2361334048962334522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2361334048962334522==--

