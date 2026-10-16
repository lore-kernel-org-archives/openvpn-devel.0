Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C6ACCA46C
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c/KVuunWVvEppZlNSkYqfAnrdMZpuy/WuaA55Cg2XvM=; b=J85y5R2lTvGwy0iTOiHJsOW8Bg
	iIoDVr68RC+EwLbJc1fh6QuL50GYsKRW/xZ75V/zFhbDhRdYXBwMq/CoD6lJqz8IyQQZ6mqKN2b4C
	hQC6ubFCeQJIBg7pd0mGuYh0d4Bky/HuQrF+9LwFh/rqk415o1kw/t6+4YA8QH4MCn5M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHjdx-0004YL-Jh;
	Fri, 16 Oct 2026 15:14:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHjdw-0004YF-M2
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 15:14:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3WUh+VSt6vORfu83mLDg5k2egXNoV2OzD7TKFRTRwos=; b=SWpchu/eicLSCmBbXhXqqFHeQZ
 4UgQq810n8aHWKqDW69TLg22T1KhDaUPPIUaw1E7LJsfP3uzAbKoDrsCCQydjKF70vIXBF915a84q
 j2h7xJ3bELm6yGuUGA2rFusfGVzae5VtC3z/JBsAraZIzROi+IyhRBJG08vhKzNb/05s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3WUh+VSt6vORfu83mLDg5k2egXNoV2OzD7TKFRTRwos=; b=B
 0ZjIIOdO1BeTO5dWLcvq85gb5oCEktOLPyoIFn/ZMS1q0R6d71kd5/I4pfagLhWK37ih8xbbqZZ7C
 DLdIBIIqh2lV/bs7Wqz2uJlCFWWWZiAm2I/AxEwtsovkm6nyyIEfWkBWhc+dWReL3/yslwpPAFLYB
 ufUc6/OjIj7/N2YA=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHjds-0000zD-Ag for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 15:14:49 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so1395803f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 16 Oct 2026 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792163678; x=1792768478; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3WUh+VSt6vORfu83mLDg5k2egXNoV2OzD7TKFRTRwos=;
 b=UhlPm7GB4xrOBevEJaGyo5SItAQ4Gtq3PLRgbpIBFQ7LzSVSA0PUdtW0JR2SYvqA1w
 CaNFlC5oR9EdEsVi6BqpVz99gM0m0peGskwnaNhQVgH18VYmkhkDsAAh9EBe3E+YLH/8
 rBgLfOInGzZal55adHyLe4Ss4BDIycZZ23HiCXe6C2umx0mz0mg9Kc/oA3NtBOuoFUAn
 yPa+TV1XFKsgp16YOieNQr1W71lr21J2ASdmboExABexvZzXJBY3FaXRuOqtQuKVEZFQ
 9ac/g3zJi5QRNCNQMMFBrgdEKK7gyG72q/PQHvPEg9S/5WIH8mLCEMS2Gu9FhRQ19yU/
 IZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792163678; x=1792768478;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3WUh+VSt6vORfu83mLDg5k2egXNoV2OzD7TKFRTRwos=;
 b=a+k6FWhOZf1ztL6CZeES+YGnNz/+ltozvPKS2GQOdGP26/YocFnYXslnvvheEw1nWF
 DsgZZEC9PFtOsqnPQVnYRzwr1TuNh0g82aj9lJyj+EEr/uYKWaw2y9vR/H/Q0NOiM7Zd
 JpRtUV7Eynl9WuiaIekwF8+LqIOauAasY2lPM1D6uOzCpm+K8+ps9cwvvk+Zo+WL9Ygy
 m8L9X+tp4izEiaFH8FWaw3shYPzyFpO5oDmlgkpecgO0Suue7v5+GrmkzNJufcVmrQ/f
 rI+nFFa1z8KQ+18Cwag/QV/ytLGyufTKQIe08UPlaGXJMZ1D18q1e290NXjFGzbFHPtx
 bonw==
X-Gm-Message-State: AFq9FYJiPriSIWvIK/c+7elynPwksR54wG7ArTzvUznH1w0i59kUDlrx
 zkwJElCvXKl+OxoywnTmXboznfszj7NgcKXIDyCXhY9TqD4V8tep/JlxvbTiFBoxQr0Kig6XJIj
 3iYeXvjRfoxFAi6IoKKpVEWCR5THAFPxUN6Wb5jE45fDp80rlT87uRiYG6LmQJI97ZAsJ
X-Gm-Gg: AYBFou370/wurLE1y/vQ1B60iicZ5bTgRj2JKBz8VL4PHgxz8xFoSdHKIJNfYLN9xD5
 j/6L/C/zsF83uXJGvo7yGOawUabolpZfr2cwm6HczmqZAb2rayXQ7Sm/tBc3LDieFPNkeq3YzXZ
 546wxHsbL3x249jcPXuZnFvwSskKPbOKbbWIfdL1o8U9YRWW6eZ5TYXbYPQK1/EkqaGkfCukmn5
 5NcJX14cKDkrFj9wbqiwO/EyFFXWhkclQNhR56Zxn5BeQ4GYCy5aFZOpCykMN73g8063b95baKl
 pS697orv7M4EABlkkIL2kf2OXG5xki4tZ1O8Hrj7SbKmuUKGpjdvVuCNkFQba5tIW7gV3Z252bW
 JJT5CVRjQOD6ZLx2SE5/VoXGLNP1BCjEVvNuQaM5dsuB5Ll8zSE1JVyuquyq+QmKIQEQZtKfzZk
 rRFJjzLF8wUFZgBfUwl4zdtioaNq2dhyGh0qMzRCpmUEuhCPOvzej6e7FBFXlblP1jJaK3Nneib
 gPkZ/TqKUCSGnxMTQzYunFq6fzgcAJdpV/yacKrOFPv8Gz27Q/iIOo9AcfzyMD7RBmwhsw4RgPj
 LTlBpIs7TJlfU3D7BBlWo2+kQc63nfR/ypGPUYxLoOXHbqkFZZ/eFy2SNdF5
X-Received: by 2002:a05:600c:540f:b0:4a1:97c6:d2e8 with SMTP id
 5b1f17b1804b1-4a1d7633b35mr1742305e9.32.1792163677354; 
 Fri, 16 Oct 2026 08:14:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cf04ffe9sm37057815e9.0.2026.10.16.08.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 08:14:36 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 16 Oct 2026 15:14:34 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
X-Gerrit-Change-Number: 1592
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1592?usp=email>
X-Gerrit-Commit: dda75df387f83ae10741d74a516495466ca78964
In-Reply-To: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
References: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0NDUxMzgwMDAwLkk3OWIyZGM0YTU1MGIxYzUwNjhhNDU0MDc5NzZiMGRmYzJmNzY1YjMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3ceb2e3c514a00c17ed9a4b28b8e88051850e87c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHjds-0000zD-Ag
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8363723328883185347=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8363723328883185347==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+hh5mK9u7kg="; charset=UTF-8

--+hh5mK9u7kg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#7) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
592?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


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

We =
heavily patch ax_code_coverage=2Em4, mostly to
achieve better compatibility=
 with non-Linux systems=2E
- Do not depend on autoconf-archive
- Do not dep=
end on GNU make
- Use more modern --coverage flag to better support
  diffe=
rent compilers

Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
Signed=
-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1592
Message-Id: <20261016080644=2E23188-1-gert@greenie=2Emuc=2Ede>=

URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg39917=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
-=
--
M =2Egitignore
M Makefile=2Eam
M configure=2Eac
A lcovrc
M m4/ax_code_co=
verage=2Em4
M src/openvpn/Makefile=2Eam
6 files changed, 114 insertions(+),=
 43 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/92/1592/7

diff --git a/=2Egitignore b/=2Egitignore
index 04523a=
f=2E=2E2749739 100644
--- a/=2Egitignore
+++ b/=2Egitignore
@@ -1,5 +1,9 @@=

 *=2E[oa]
 *=2El[oa]
+*=2Egcda
+*=2Egcno
+*-coverage/
+*-coverage=2Einfo
 =
*=2Edll
 *=2Eexe
 *=2Eexe=2E*
@@ -18,6 +22,7 @@
 Makefile
 Makefile=2Ein
 a=
clocal=2Em4
+aminclude_static=2Eam
 autodefs=2Eh
 autom4te=2Ecache
 config=
=2Eguess
diff --git a/Makefile=2Eam b/Makefile=2Eam
index 125fe84=2E=2Ed391=
0ed 100644
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
 
@@ -98,3 +10=
1,7 @@
 	INCLUDE_FLAGS=3D"$(LIBNL_GENL_CFLAGS)" \
 	CPPCHECK_VERBOSE=3D"$(A=
M_V_P)" \
 		"$(top_srcdir)/dev-tools/run-cppcheck=2Esh"
+
+CODE_COVERAGE_L=
COV_SHOPTS=3D--config-file $(srcdir)/lcovrc
+clean-local: code-coverage-cle=
an
+distclean-local: code-coverage-dist-clean
diff --git a/configure=2Eac b=
/configure=2Eac
index ad3f8f1=2E=2E6617c8d 100644
--- a/configure=2Eac
+++ =
b/configure=2Eac
@@ -59,6 +59,8 @@
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENS=
IONS
 
+AX_CODE_COVERAGE
+
 AC_ARG_ENABLE(
 	[lzo],
 	[AS_HELP_STRING([--di=
sable-lzo], [disable LZO compression support @<:@default=3Dyes@:>@])],
@@ -=
1236,6 +1238,11 @@
 	ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-cast-function-type])=

 fi
 
+# If coverage is enabled remove -O arguments from CFLAGS
+if test "=
$enable_code_coverage" =3D "yes"; then
+   [CFLAGS=3D"`echo $CFLAGS | $SED =
-e 's/-O[a-z0-9]*//g'`"]
+fi
+
 if test "${enable_pedantic}" =3D "yes"; the=
n
 	CFLAGS=3D"${CFLAGS} -pedantic"
 	AC_DEFINE([PEDANTIC], [1], [Enable ped=
antic mode])
@@ -1355,10 +1362,10 @@
 
 TEST_LDFLAGS=3D"${OPTIONAL_CRYPTO_L=
IBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${OPTIONAL_LIBCAPNG_LIBS}"
 TEST_LDFLAG=
S=3D"${TEST_LDFLAGS} ${OPTIONAL_LIBNL_GENL_LIBS}"
-TEST_LDFLAGS=3D"${TEST_L=
DFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS}"
+TEST_LDFLAGS=3D"${TEST_LDFLAG=
S} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS} ${CODE_COVERAGE_LIBS}"
 TEST_CFLAGS=
=3D"${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS} ${OPTIONAL_L=
IBCAPNG_CFLAGS}"
 TEST_CFLAGS=3D"${TEST_CFLAGS} ${OPTIONAL_LIBNL_GENL_CFLAG=
S} ${OPTIONAL_LZO_CFLAGS}"
-TEST_CFLAGS=3D"${TEST_CFLAGS} -I\$(top_srcdir)/=
include ${CMOCKA_CFLAGS}"
+TEST_CFLAGS=3D"${TEST_CFLAGS} -I\$(top_srcdir)/i=
nclude ${CMOCKA_CFLAGS} ${CODE_COVERAGE_CFLAGS}"
 
 AC_SUBST([TEST_LDFLAGS]=
)
 AC_SUBST([TEST_CFLAGS])
diff --git a/lcovrc b/lcovrc
new file mode 10064=
4
index 0000000=2E=2Ef8b4138
--- /dev/null
+++ b/lcovrc
@@ -0,0 +1,2 @@
+ge=
ninfo_external =3D 1
+geninfo_unexecuted_blocks =3D 1
diff --git a/m4/ax_co=
de_coverage=2Em4 b/m4/ax_code_coverage=2Em4
index 216708a4=2E=2Ef156d4d 100=
644
--- a/m4/ax_code_coverage=2Em4
+++ b/m4/ax_code_coverage=2Em4
@@ -42,8 =
+42,8 @@
 #     clean-local: code-coverage-clean
 #     distclean-local: co=
de-coverage-dist-clean
 #
-#   This results in a "check-code-coverage" rule=
 being added to any
-#   Makefile=2Eam which do "include $(top_srcdir)/amin=
clude_static=2Eam"
+#   This results in a "check-code-coverage" rule being =
added to the
+#   Makefile=2Eam which does "include $(top_srcdir)/aminclude=
_static=2Eam"
 #   (assuming the module has been configured with --enable-c=
ode-coverage)=2E
 #   Running `make check-code-coverage` in that directory =
will run the
 #   module's test suite (`make check`) and build a code cover=
age report
@@ -76,10 +76,51 @@
 
 #serial 37
 
+dnl Local modifications com=
pared to the autoconf-archive version:
+dnl
+dnl  - AX_ADD_AM_MACRO_STATIC =
(from autoconf-archive) is replaced by a
+dnl    minimal local equivalent, =
OPENVPN_ADD_AM_MACRO_STATIC, so that we do
+dnl    not depend on autoconf-a=
rchive being installed=2E
+dnl  - The generated rules no longer require GNU=
 make=2E  The AX_CHECK_GNU_MAKE
+dnl    check is gone (which also removed t=
he last autoconf-archive
+dnl    dependency) and the GNU make specific cons=
tructs in the rules were
+dnl    replaced:
+dnl      * the "ifeq ($(abs_bui=
lddir), $(abs_top_builddir))" guard is gone,
+dnl        aminclude_static=
=2Eam may only be included by the top level
+dnl        Makefile=2Eam now (=
which is the only place it was ever included
+dnl        from in this proje=
ct),
+dnl      * $(addprefix =2E=2E=2E) and $(if =2E=2E=2E) are replaced by=
 shell code inside
+dnl        the recipes,
+dnl      * $(call =2E=2E=2E)/$=
(subst =2E=2E=2E) for the lcov test name is replaced by
+dnl        CODE_CO=
VERAGE_TEST_NAME, computed at configure time,
+dnl      * "find =2E=2E=2E -=
delete" is replaced by "find =2E=2E=2E -exec rm -f {} +"=2E
+dnl    The onl=
y remaining non-POSIX construct is the nested variable
+dnl    expansion us=
ed for the silent rules ($(foo_$(V))), which is the same
+dnl    idiom auto=
make itself uses for AM_V_at and friends and which is
+dnl    understood by=
 BSD make as well=2E
+
+AC_DEFUN([OPENVPN_PRINT_TO_FILE],[
+m4_esyscmd(
+[
=
+printf "%s" "$2" > "$1"
+])
+])
+
+AC_DEFUN([OPENVPN_ADD_AM_MACRO_STATIC],=
[
+  OPENVPN_PRINT_TO_FILE([aminclude_static=2Eam],[$1])
+])
+
 m4_define(_=
AX_CODE_COVERAGE_RULES,[
-AX_ADD_AM_MACRO_STATIC([
+OPENVPN_ADD_AM_MACRO_ST=
ATIC([
+# This file was generated by ax_code_coverage
 # Code coverage
 #
+=
# This file must only be included by the top level Makefile=2Eam: the rules=

+# below always report on the complete build tree=2E
+#
+# The rules avoid=
 GNU make specific syntax so that they also work with
+# other make impleme=
ntations, e=2Eg=2E BSD make=2E
+#
 # Optional:
 #  - CODE_COVERAGE_DIRECTOR=
Y: Top-level directory for code coverage reporting=2E
 #    Multiple direct=
ories may be specified, separated by whitespace=2E
@@ -90,51 +131,51 @@
 # =
 - CODE_COVERAGE_OUTPUT_DIRECTORY: Directory for generated code coverage
 #=
    reports to be created=2E (Default:
 #    \$(PACKAGE_NAME)-\$(PACKAGE_VE=
RSION)-coverage)
+#  - CODE_COVERAGE_TEST_NAME: Test name to record in the =
=2Einfo file=2E  It is
+#    computed by configure (\$(PACKAGE_NAME)-\$(PAC=
KAGE_VERSION), with dashes
+#    and dots replaced by underscores) and can =
be overridden by defining it
+#    in Makefile=2Eam=2E
 #  - CODE_COVERAGE_=
BRANCH_COVERAGE: Set to 1 to enforce branch coverage,
 #    set to 0 to dis=
able it and leave empty to stay with the default=2E
-#    (Default: empty)
=
+#    The corresponding --rc option is passed to lcov and genhtml in
+#    =
addition to the options below=2E (Default: empty)
 #  - CODE_COVERAGE_LCOV_=
SHOPTS_DEFAULT: Extra options shared between both lcov
-#    instances=2E (=
Default: based on $CODE_COVERAGE_BRANCH_COVERAGE)
+#    instances=2E (Defau=
lt: empty)
 #  - CODE_COVERAGE_LCOV_SHOPTS: Extra options to shared between=
 both lcov
-#    instances=2E (Default: $CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)=

+#    instances=2E (Default: \$CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)
 #  - CO=
DE_COVERAGE_LCOV_OPTIONS_GCOVPATH: --gcov-tool pathtogcov
 #  - CODE_COVERA=
GE_LCOV_OPTIONS_DEFAULT: Extra options to pass to the
-#    collecting lcov=
 instance=2E (Default: $CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)
+#    collecti=
ng lcov instance=2E (Default: \$CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)
 #  - =
CODE_COVERAGE_LCOV_OPTIONS: Extra options to pass to the collecting lcov
-#=
    instance=2E (Default: $CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)
+#    instan=
ce=2E (Default: \$CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)
 #  - CODE_COVERAGE_L=
COV_RMOPTS_DEFAULT: Extra options to pass to the filtering
 #    lcov insta=
nce=2E (Default: empty)
-#  - CODE_COVERAGE_LCOV_RMOPTS: Extra options to p=
ass to the filtering lcov
-#    instance=2E (Default: $CODE_COVERAGE_LCOV_R=
MOPTS_DEFAULT)
+#  - CODE_COVERAGE_LCOV_RMOPTS: Extra options to pass to th=
e filtering
+#    lcov instance=2E (Default: \$CODE_COVERAGE_LCOV_RMOPTS_DE=
FAULT)
 #  - CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT: Extra options to pass t=
o the
-#    genhtml instance=2E (Default: based on $CODE_COVERAGE_BRANCH_CO=
VERAGE)
+#    genhtml instance=2E (Default: empty)
 #  - CODE_COVERAGE_GENH=
TML_OPTIONS: Extra options to pass to the genhtml
-#    instance=2E (Defaul=
t: $CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)
+#    instance=2E (Default: \$CO=
DE_COVERAGE_GENHTML_OPTIONS_DEFAULT)
 #  - CODE_COVERAGE_IGNORE_PATTERN: Ex=
tra glob pattern of files to ignore
 #
 # The generated report will be titl=
ed using the \$(PACKAGE_NAME) and
 # \$(PACKAGE_VERSION)=2E In order to add=
 the current git hash to the title,
 # use the git-version-gen script, avai=
lable online=2E
 # Optional variables
-# run only on top dir
 if CODE_COVER=
AGE_ENABLED
- ifeq (\$(abs_builddir), \$(abs_top_builddir))
 CODE_COVERAGE_=
DIRECTORY ?=3D \$(top_builddir)
 CODE_COVERAGE_OUTPUT_FILE ?=3D \$(PACKAGE_=
NAME)-\$(PACKAGE_VERSION)-coverage=2Einfo
 CODE_COVERAGE_OUTPUT_DIRECTORY ?=
=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage
 
 CODE_COVERAGE_BRANCH_C=
OVERAGE ?=3D
-CODE_COVERAGE_LCOV_SHOPTS_DEFAULT ?=3D \$(if \$(CODE_COVERAGE=
_BRANCH_COVERAGE),\
---rc lcov_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_CO=
VERAGE))
+CODE_COVERAGE_LCOV_SHOPTS_DEFAULT ?=3D
 CODE_COVERAGE_LCOV_SHOPTS=
 ?=3D \$(CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)
 CODE_COVERAGE_LCOV_OPTIONS_GCO=
VPATH ?=3D --gcov-tool \"\$(GCOV)\"
 CODE_COVERAGE_LCOV_OPTIONS_DEFAULT ?=
=3D \$(CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)
 CODE_COVERAGE_LCOV_OPTIONS ?=
=3D \$(CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)
 CODE_COVERAGE_LCOV_RMOPTS_DEFAU=
LT ?=3D
 CODE_COVERAGE_LCOV_RMOPTS ?=3D \$(CODE_COVERAGE_LCOV_RMOPTS_DEFAUL=
T)
-CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT ?=3D\
-\$(if \$(CODE_COVERAGE_BRA=
NCH_COVERAGE),\
---rc genhtml_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_COV=
ERAGE))
+CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT ?=3D
 CODE_COVERAGE_GENHTML_=
OPTIONS ?=3D \$(CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)
 CODE_COVERAGE_IGNOR=
E_PATTERN ?=3D
 
@@ -152,8 +193,15 @@
 code_coverage_quiet_ =3D \$(code_cov=
erage_quiet_\$(AM_DEFAULT_VERBOSITY))
 code_coverage_quiet_0 =3D --quiet
 
=
-# sanitizes the test-name: replaces with underscores: dashes and dots
-cod=
e_coverage_sanitize =3D \$(subst -,_,\$(subst =2E,_,\$(1)))
+# Shell fragme=
nts used by the recipes below=2E  They are portable
+# replacements for the=
 GNU make functions \$(addprefix =2E=2E=2E) and \$(if =2E=2E=2E):
+# code_c=
overage_dirs_opt sets \$cc_dirs to a list of --directory options,
+# code_c=
overage_prefix_opt sets \$cc_prefix to a list of --prefix options and
+# co=
de_coverage_*_branch_opt set \$cc_branch to the branch coverage option=2E
+=
code_coverage_dirs_opt =3D cc_dirs=3D; for cc_dir in \$(CODE_COVERAGE_DIREC=
TORY); do cc_dirs=3D\"\$\$cc_dirs --directory \$\$cc_dir\"; done
+code_cove=
rage_prefix_opt =3D cc_prefix=3D; for cc_dir in \$(CODE_COVERAGE_DIRECTORY)=
; do cc_prefix=3D\"\$\$cc_prefix --prefix \$\$cc_dir\"; done
+code_coverage=
_lcov_branch_opt =3D cc_branch=3D; test -z \"\$(CODE_COVERAGE_BRANCH_COVERA=
GE)\" || cc_branch=3D\"--rc lcov_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_=
COVERAGE)\"
+code_coverage_genhtml_branch_opt =3D cc_branch=3D; test -z \"\=
$(CODE_COVERAGE_BRANCH_COVERAGE)\" || cc_branch=3D\"--rc genhtml_branch_cov=
erage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE)\"
 
 # Use recursive makes in ord=
er to ignore errors during check
 check-code-coverage:
@@ -162,29 +210,26 @=
@
 
 # Capture code coverage data
 code-coverage-capture: code-coverage-cap=
ture-hook
-	\$(code_coverage_v_lcov_cap)\$(LCOV) \$(code_coverage_quiet) \$=
(addprefix --directory ,\$(CODE_COVERAGE_DIRECTORY)) --capture --output-fil=
e \"\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\" --test-name \"\$(call code_covera=
ge_sanitize,\$(PACKAGE_NAME)-\$(PACKAGE_VERSION))\" --no-checksum --compat-=
libtool \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_OPTIONS)
-	\$(c=
ode_coverage_v_lcov_ign)\$(LCOV) \$(code_coverage_quiet) \$(addprefix --dir=
ectory ,\$(CODE_COVERAGE_DIRECTORY)) --remove \"\$(CODE_COVERAGE_OUTPUT_FIL=
E)=2Etmp\" \$(CODE_COVERAGE_IGNORE_PATTERN) --output-file \"\$(CODE_COVERAG=
E_OUTPUT_FILE)\" \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_RMOPTS=
)
+	\$(code_coverage_v_lcov_cap)\$(code_coverage_dirs_opt); \\
+	\$(code_co=
verage_lcov_branch_opt); \\
+	\$(LCOV) \$(code_coverage_quiet) \$\$cc_dirs =
--capture --output-file \"\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\" --test-name=
 \"\$(CODE_COVERAGE_TEST_NAME)\" --no-checksum --compat-libtool \$\$cc_bran=
ch \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_OPTIONS)
+	\$(code_c=
overage_v_lcov_ign)\$(code_coverage_dirs_opt); \\
+	\$(code_coverage_lcov_b=
ranch_opt); \\
+	\$(LCOV) \$(code_coverage_quiet) \$\$cc_dirs --remove \"\$=
(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\" \$(CODE_COVERAGE_IGNORE_PATTERN) --outp=
ut-file \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \$\$cc_branch \$(CODE_COVERAGE_LC=
OV_SHOPTS) \$(CODE_COVERAGE_LCOV_RMOPTS)
 	-@rm -f \"\$(CODE_COVERAGE_OUTPU=
T_FILE)=2Etmp\"
-	\$(code_coverage_v_genhtml)LANG=3DC \$(GENHTML) \$(code_c=
overage_quiet) \$(addprefix --prefix ,\$(CODE_COVERAGE_DIRECTORY)) --output=
-directory \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\" --title \"\$(PACKAGE_NAME=
)-\$(PACKAGE_VERSION) Code Coverage\" --legend --show-details \"\$(CODE_COV=
ERAGE_OUTPUT_FILE)\" \$(CODE_COVERAGE_GENHTML_OPTIONS)
+	\$(code_coverage_v=
_genhtml)\$(code_coverage_prefix_opt); \\
+	\$(code_coverage_genhtml_branch=
_opt); \\
+	LANG=3DC \$(GENHTML) \$(code_coverage_quiet) \$\$cc_prefix --ou=
tput-directory \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\" --title \"\$(PACKAGE_=
NAME)-\$(PACKAGE_VERSION) Code Coverage\" --legend --show-details \"\$(CODE=
_COVERAGE_OUTPUT_FILE)\" \$\$cc_branch \$(CODE_COVERAGE_GENHTML_OPTIONS)
 	=
@echo \"file://\$(abs_builddir)/\$(CODE_COVERAGE_OUTPUT_DIRECTORY)/index=2E=
html\"
 
 code-coverage-clean:
 	-\$(LCOV) --directory \$(top_builddir) -z
=
 	-rm -rf \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \"\$(CODE_COVERAGE_OUTPUT_FILE)=
=2Etmp\" \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\"
-	-find =2E \\( -name \"*=
=2Egcda\" -o -name \"*=2Egcno\" -o -name \"*=2Egcov\" \\) -delete
+	-find =
=2E \\( -name \"*=2Egcda\" -o -name \"*=2Egcno\" -o -name \"*=2Egcov\" \\) =
-exec rm -f '{}' +
 
 code-coverage-dist-clean:
 
 A][M_DISTCHECK_CONFIGURE=
_FLAGS :=3D \$(A][M_DISTCHECK_CONFIGURE_FLAGS) --disable-code-coverage
- el=
se # ifneq (\$(abs_builddir), \$(abs_top_builddir))
-check-code-coverage:
-=

-code-coverage-capture: code-coverage-capture-hook
-
-code-coverage-clean:=

-
-code-coverage-dist-clean:
- endif # ifeq (\$(abs_builddir), \$(abs_top_=
builddir))
 else #! CODE_COVERAGE_ENABLED
 # Use recursive makes in order t=
o ignore errors during check
 check-code-coverage:
@@ -206,8 +251,7 @@
 ])
=
 
 AC_DEFUN([_AX_CODE_COVERAGE_ENABLED],[
-	AX_CHECK_GNU_MAKE([],[AC_MSG_ER=
ROR([not using GNU make that is needed for coverage])])
-	AC_REQUIRE([AX_AD=
D_AM_MACRO_STATIC])
+	AC_REQUIRE([OPENVPN_ADD_AM_MACRO_STATIC])
 	# check f=
or gcov
 	AC_CHECK_TOOL([GCOV],
 		  [$_AX_CODE_COVERAGE_GCOV_PROG_WITH],
@=
@ -232,13 +276,12 @@
 		AC_MSG_ERROR([Could not find genhtml from the lcov =
package])
 	])
 
-	AC_CHECK_LIB([gcov], [_gcov_init], [CODE_COVERAGE_LIBS=
=3D"-lgcov"], [CODE_COVERAGE_LIBS=3D""])
-
 	dnl Build the code coverage fl=
ags
 	dnl Define CODE_COVERAGE_LDFLAGS for backwards compatibility
 	CODE_C=
OVERAGE_CPPFLAGS=3D"-DNDEBUG"
-	CODE_COVERAGE_CFLAGS=3D"-O0 -g -fprofile-ar=
cs -ftest-coverage"
-	CODE_COVERAGE_CXXFLAGS=3D"-O0 -g -fprofile-arcs -ftes=
t-coverage"
+	CODE_COVERAGE_CFLAGS=3D"-O0 -g --coverage"
+	CODE_COVERAGE_CX=
XFLAGS=3D"-O0 -g --coverage"
+	CODE_COVERAGE_LIBS=3D"--coverage"
 
 	AC_SUB=
ST([CODE_COVERAGE_CPPFLAGS])
 	AC_SUBST([CODE_COVERAGE_CFLAGS])
@@ -265,6 +=
308,10 @@
 	AC_SUBST([CODE_COVERAGE_ENABLED], [$enable_code_coverage])
 	AC=
_MSG_RESULT($enable_code_coverage)
 
+	dnl The lcov test name must not cont=
ain dashes or dots
+	CODE_COVERAGE_TEST_NAME=3D`echo "$PACKAGE_NAME-$PACKAG=
E_VERSION" | tr '=2E-' '__'`
+	AC_SUBST([CODE_COVERAGE_TEST_NAME])
+
 	AS_I=
F([ test "x$enable_code_coverage" =3D xyes ], [
 		_AX_CODE_COVERAGE_ENABLE=
D
 	      ])
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=
=2Eam
index 7ecddff=2E=2E9424801 100644
--- a/src/openvpn/Makefile=2Eam
+++=
 b/src/openvpn/Makefile=2Eam
@@ -31,9 +31,12 @@
 	$(OPTIONAL_SYSTEMD_CFLAGS=
) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \
 	$(OPTIONAL_INOTIFY_CFLAGS) \
+	$=
(CODE_COVERAGE_CFLAGS) \
 	-DPLUGIN_LIBDIR=3D\"${plugindir}\" \
 	-DDEFAULT=
_DNS_UPDOWN=3D\"${scriptdir}/dns-updown\"
 
+AM_LDFLAGS =3D $(CODE_COVERAGE=
_LIBS)
+
 if WIN32
 # we want unicode entry point but not the macro
 AM_CFL=
AGS +=3D -municode -UUNICODE

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1592?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
Gerrit-Change-Num=
ber: 1592
Gerrit-PatchSet: 7
Gerrit-Owner: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--+hh5mK9u7kg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #7</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1592?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">configure: Add --enable-code-coverage<br><br>Can be used like this<br>=
=2E/configure --enable-code-coverage<br>make<br>make check<br>make code-cov=
erage-capture<br><br>We heavily patch ax_code_coverage=2Em4, mostly to<br>a=
chieve better compatibility with non-Linux systems=2E<br>- Do not depend on=
 autoconf-archive<br>- Do not depend on GNU make<br>- Use more modern --cov=
erage flag to better support<br>  different compilers<br><br>Change-Id: I79=
b2dc4a550b1c5068a45407976b0dfc2f765b33<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
592<br>Message-Id: &lt;20261016080644=2E23188-1-gert@greenie=2Emuc=2Ede&gt;=
<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg39917=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M =2Egitignore<br>M Makefile=2Eam<br>M configure=2Eac<=
br>A lcovrc<br>M m4/ax_code_coverage=2Em4<br>M src/openvpn/Makefile=2Eam<br=
>6 files changed, 114 insertions(+), 43 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/92/15=
92/7</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/=2Egitignore b/=2Egitignore</span><br><span>index=
 04523af=2E=2E2749739 100644</span><br><span>--- a/=2Egitignore</span><br><=
span>+++ b/=2Egitignore</span><br><span>@@ -1,5 +1,9 @@</span><br><span> *=
=2E[oa]</span><br><span> *=2El[oa]</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+*=2Egcda</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+*=2Egcno</span><br><span style=3D"color: hsl(120, 100%, 40%);">+*-cover=
age/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+*-coverage=2Ein=
fo</span><br><span> *=2Edll</span><br><span> *=2Eexe</span><br><span> *=2Ee=
xe=2E*</span><br><span>@@ -18,6 +22,7 @@</span><br><span> Makefile</span><b=
r><span> Makefile=2Ein</span><br><span> aclocal=2Em4</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+aminclude_static=2Eam</span><br><span> au=
todefs=2Eh</span><br><span> autom4te=2Ecache</span><br><span> config=2Egues=
s</span><br><span>diff --git a/Makefile=2Eam b/Makefile=2Eam</span><br><spa=
n>index 125fe84=2E=2Ed3910ed 100644</span><br><span>--- a/Makefile=2Eam</sp=
an><br><span>+++ b/Makefile=2Eam</span><br><span>@@ -22,6 +22,8 @@</span><b=
r><span> #  with this program; if not, see &lt;https://www=2Egnu=2Eorg/lice=
nses/&gt;=2E</span><br><span> #</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+include $(top_srcdir)/aminclude_static=2Eam</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> ACL=
OCAL_AMFLAGS =3D -I m4</span><br><span> </span><br><span> MAINTAINERCLEANFI=
LES =3D \</span><br><span>@@ -45,7 +47,8 @@</span><br><span> 	CMakeLists=2E=
txt \</span><br><span> 	CMakePresets=2Ejson \</span><br><span> 	config=2Eh=
=2Ecmake=2Ein \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	forke=
d-test-driver</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	forke=
d-test-driver \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	lco=
vrc</span><br><span> </span><br><span> =2EPHONY: config-version=2Eh doxygen=
</span><br><span> </span><br><span>@@ -98,3 +101,7 @@</span><br><span> 	INC=
LUDE_FLAGS=3D&quot;$(LIBNL_GENL_CFLAGS)&quot; \</span><br><span> 	CPPCHECK_=
VERBOSE=3D&quot;$(AM_V_P)&quot; \</span><br><span> 		&quot;$(top_srcdir)/de=
v-tools/run-cppcheck=2Esh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CODE_CO=
VERAGE_LCOV_SHOPTS=3D--config-file $(srcdir)/lcovrc</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+clean-local: code-coverage-clean</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+distclean-local: code-covera=
ge-dist-clean</span><br><span>diff --git a/configure=2Eac b/configure=2Eac<=
/span><br><span>index ad3f8f1=2E=2E6617c8d 100644</span><br><span>--- a/con=
figure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -59,6 +=
59,8 @@</span><br><span> AC_CANONICAL_HOST</span><br><span> AC_USE_SYSTEM_E=
XTENSIONS</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+AX_CODE_COVERAGE</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> AC_ARG_ENABLE(</span><br><span> 	[lzo],</span><br><s=
pan> 	[AS_HELP_STRING([--disable-lzo], [disable LZO compression support @&l=
t;:@default=3Dyes@:&gt;@])],</span><br><span>@@ -1236,6 +1238,11 @@</span><=
br><span> 	ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-cast-function-type])</span><br=
><span> fi</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# If coverage is enabled remove -O arguments from CFLAGS</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+if test &quot;$enable_code_co=
verage&quot; =3D &quot;yes&quot;; then</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+   [CFLAGS=3D&quot;`echo $CFLAGS | $SED -e &#39;s/-O[a-z=
0-9]*//g&#39;`&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> if test &quot;${enable_pedantic}&quot; =3D &quot;yes&quot;; then</span><=
br><span> 	CFLAGS=3D&quot;${CFLAGS} -pedantic&quot;</span><br><span> 	AC_DE=
FINE([PEDANTIC], [1], [Enable pedantic mode])</span><br><span>@@ -1355,10 +=
1362,10 @@</span><br><span> </span><br><span> TEST_LDFLAGS=3D&quot;${OPTION=
AL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${OPTIONAL_LIBCAPNG_LIBS}&qu=
ot;</span><br><span> TEST_LDFLAGS=3D&quot;${TEST_LDFLAGS} ${OPTIONAL_LIBNL_=
GENL_LIBS}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_=
LDFLAGS=3D&quot;${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS}&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_LDFLAGS=3D&quot;=
${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS} ${CODE_COVERAGE_LIBS}&q=
uot;</span><br><span> TEST_CFLAGS=3D&quot;${OPTIONAL_CRYPTO_CFLAGS} ${OPTIO=
NAL_PKCS11_HELPER_CFLAGS} ${OPTIONAL_LIBCAPNG_CFLAGS}&quot;</span><br><span=
> TEST_CFLAGS=3D&quot;${TEST_CFLAGS} ${OPTIONAL_LIBNL_GENL_CFLAGS} ${OPTION=
AL_LZO_CFLAGS}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-T=
EST_CFLAGS=3D&quot;${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS}=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_CFLAGS=
=3D&quot;${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS} ${CODE_CO=
VERAGE_CFLAGS}&quot;</span><br><span> </span><br><span> AC_SUBST([TEST_LDFL=
AGS])</span><br><span> AC_SUBST([TEST_CFLAGS])</span><br><span>diff --git a=
/lcovrc b/lcovrc</span><br><span>new file mode 100644</span><br><span>index=
 0000000=2E=2Ef8b4138</span><br><span>--- /dev/null</span><br><span>+++ b/l=
covrc</span><br><span>@@ -0,0 +1,2 @@</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+geninfo_external =3D 1</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+geninfo_unexecuted_blocks =3D 1</span><br><span>diff -=
-git a/m4/ax_code_coverage=2Em4 b/m4/ax_code_coverage=2Em4</span><br><span>=
index 216708a4=2E=2Ef156d4d 100644</span><br><span>--- a/m4/ax_code_coverag=
e=2Em4</span><br><span>+++ b/m4/ax_code_coverage=2Em4</span><br><span>@@ -4=
2,8 +42,8 @@</span><br><span> #     clean-local: code-coverage-clean</span>=
<br><span> #     distclean-local: code-coverage-dist-clean</span><br><span>=
 #</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#   This results in=
 a &quot;check-code-coverage&quot; rule being added to any</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#   Makefile=2Eam which do &quot;inclu=
de $(top_srcdir)/aminclude_static=2Eam&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#   This results in a &quot;check-code-coverage&qu=
ot; rule being added to the</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#   Makefile=2Eam which does &quot;include $(top_srcdir)/aminclude_=
static=2Eam&quot;</span><br><span> #   (assuming the module has been config=
ured with --enable-code-coverage)=2E</span><br><span> #   Running `make che=
ck-code-coverage` in that directory will run the</span><br><span> #   modul=
e&#39;s test suite (`make check`) and build a code coverage report</span><b=
r><span>@@ -76,10 +76,51 @@</span><br><span> </span><br><span> #serial 37</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl=
 Local modifications compared to the autoconf-archive version:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+dnl</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+dnl  - AX_ADD_AM_MACRO_STATIC (from autoconf-arc=
hive) is replaced by a</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+dnl    minimal local equivalent, OPENVPN_ADD_AM_MACRO_STATIC, so that we=
 do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl    not depen=
d on autoconf-archive being installed=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+dnl  - The generated rules no longer require GNU make=
=2E  The AX_CHECK_GNU_MAKE</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+dnl    check is gone (which also removed the last autoconf-archive</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl    dependency) an=
d the GNU make specific constructs in the rules were</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dnl    replaced:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+dnl      * the &quot;ifeq ($(abs_builddir), =
$(abs_top_builddir))&quot; guard is gone,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+dnl        aminclude_static=2Eam may only be included=
 by the top level</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dn=
l        Makefile=2Eam now (which is the only place it was ever included</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl        from in thi=
s project),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl     =
 * $(addprefix =2E=2E=2E) and $(if =2E=2E=2E) are replaced by shell code in=
side</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl        the =
recipes,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl      * =
$(call =2E=2E=2E)/$(subst =2E=2E=2E) for the lcov test name is replaced by<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl        CODE_COVE=
RAGE_TEST_NAME, computed at configure time,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+dnl      * &quot;find =2E=2E=2E -delete&quot; is re=
placed by &quot;find =2E=2E=2E -exec rm -f {} +&quot;=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+dnl    The only remaining non-POSIX co=
nstruct is the nested variable</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+dnl    expansion used for the silent rules ($(foo_$(V))), which =
is the same</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl    i=
diom automake itself uses for AM_V_at and friends and which is</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+dnl    understood by BSD make as=
 well=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+AC_DEFUN([OPENVPN_PRINT_TO_FIL=
E],[</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m4_esyscmd(</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+[</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+printf &quot;%s&quot; &quot;$2&quot; &gt;=
 &quot;$1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+])</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+])</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+AC_DEFUN([OPENVPN_ADD_AM_MACRO_STATIC],[</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  OPENVPN_PRINT_TO_FILE([aminclude_s=
tatic=2Eam],[$1])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+])=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> m=
4_define(_AX_CODE_COVERAGE_RULES,[</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-AX_ADD_AM_MACRO_STATIC([</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+OPENVPN_ADD_AM_MACRO_STATIC([</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# This file was generated by ax_code_coverage</=
span><br><span> # Code coverage</span><br><span> #</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# This file must only be included by the top=
 level Makefile=2Eam: the rules</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# below always report on the complete build tree=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# The rules avoid GNU make specific syntax so tha=
t they also work with</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# other make implementations, e=2Eg=2E BSD make=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span> # Optional:</span><br>=
<span> #  - CODE_COVERAGE_DIRECTORY: Top-level directory for code coverage =
reporting=2E</span><br><span> #    Multiple directories may be specified, s=
eparated by whitespace=2E</span><br><span>@@ -90,51 +131,51 @@</span><br><s=
pan> #  - CODE_COVERAGE_OUTPUT_DIRECTORY: Directory for generated code cove=
rage</span><br><span> #    reports to be created=2E (Default:</span><br><sp=
an> #    \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_TEST_NAME: Test name=
 to record in the =2Einfo file=2E  It is</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#    computed by configure (\$(PACKAGE_NAME)-\$(PACKAG=
E_VERSION), with dashes</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#    and dots replaced by underscores) and can be overridden by definin=
g it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    in Makefil=
e=2Eam=2E</span><br><span> #  - CODE_COVERAGE_BRANCH_COVERAGE: Set to 1 to =
enforce branch coverage,</span><br><span> #    set to 0 to disable it and l=
eave empty to stay with the default=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#    (Default: empty)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#    The corresponding --rc option is passed to lcov and=
 genhtml in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    add=
ition to the options below=2E (Default: empty)</span><br><span> #  - CODE_C=
OVERAGE_LCOV_SHOPTS_DEFAULT: Extra options shared between both lcov</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#    instances=2E (Default: b=
ased on $CODE_COVERAGE_BRANCH_COVERAGE)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#    instances=2E (Default: empty)</span><br><span> #  =
- CODE_COVERAGE_LCOV_SHOPTS: Extra options to shared between both lcov</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#    instances=2E (Default=
: $CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#    instances=2E (Default: \$CODE_COVERAGE_LCOV_SHOPTS_D=
EFAULT)</span><br><span> #  - CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH: --gcov-t=
ool pathtogcov</span><br><span> #  - CODE_COVERAGE_LCOV_OPTIONS_DEFAULT: Ex=
tra options to pass to the</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#    collecting lcov instance=2E (Default: $CODE_COVERAGE_LCOV_OPTIONS=
_GCOVPATH)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    coll=
ecting lcov instance=2E (Default: \$CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)</s=
pan><br><span> #  - CODE_COVERAGE_LCOV_OPTIONS: Extra options to pass to th=
e collecting lcov</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#   =
 instance=2E (Default: $CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#    instance=2E (Default: \$CODE_C=
OVERAGE_LCOV_OPTIONS_DEFAULT)</span><br><span> #  - CODE_COVERAGE_LCOV_RMOP=
TS_DEFAULT: Extra options to pass to the filtering</span><br><span> #    lc=
ov instance=2E (Default: empty)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#  - CODE_COVERAGE_LCOV_RMOPTS: Extra options to pass to the filt=
ering lcov</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#    instan=
ce=2E (Default: $CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_LCOV_RMOPTS: Extra opt=
ions to pass to the filtering</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#    lcov instance=2E (Default: \$CODE_COVERAGE_LCOV_RMOPTS_DEFAU=
LT)</span><br><span> #  - CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT: Extra opti=
ons to pass to the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  =
  genhtml instance=2E (Default: based on $CODE_COVERAGE_BRANCH_COVERAGE)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#    genhtml instance=
=2E (Default: empty)</span><br><span> #  - CODE_COVERAGE_GENHTML_OPTIONS: E=
xtra options to pass to the genhtml</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#    instance=2E (Default: $CODE_COVERAGE_GENHTML_OPTIONS_DEF=
AULT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    instance=
=2E (Default: \$CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)</span><br><span> #  =
- CODE_COVERAGE_IGNORE_PATTERN: Extra glob pattern of files to ignore</span=
><br><span> #</span><br><span> # The generated report will be titled using =
the \$(PACKAGE_NAME) and</span><br><span> # \$(PACKAGE_VERSION)=2E In order=
 to add the current git hash to the title,</span><br><span> # use the git-v=
ersion-gen script, available online=2E</span><br><span> # Optional variable=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# run only on top di=
r</span><br><span> if CODE_COVERAGE_ENABLED</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- ifeq (\$(abs_builddir), \$(abs_top_builddir))</span>=
<br><span> CODE_COVERAGE_DIRECTORY ?=3D \$(top_builddir)</span><br><span> C=
ODE_COVERAGE_OUTPUT_FILE ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage=
=2Einfo</span><br><span> CODE_COVERAGE_OUTPUT_DIRECTORY ?=3D \$(PACKAGE_NAM=
E)-\$(PACKAGE_VERSION)-coverage</span><br><span> </span><br><span> CODE_COV=
ERAGE_BRANCH_COVERAGE ?=3D</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-CODE_COVERAGE_LCOV_SHOPTS_DEFAULT ?=3D \$(if \$(CODE_COVERAGE_BRANCH_C=
OVERAGE),\</span><br><span>---rc lcov_branch_coverage=3D\$(CODE_COVERAGE_BR=
ANCH_COVERAGE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CODE=
_COVERAGE_LCOV_SHOPTS_DEFAULT ?=3D</span><br><span> CODE_COVERAGE_LCOV_SHOP=
TS ?=3D \$(CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)</span><br><span> CODE_COVERAG=
E_LCOV_OPTIONS_GCOVPATH ?=3D --gcov-tool \&quot;\$(GCOV)\&quot;</span><br><=
span> CODE_COVERAGE_LCOV_OPTIONS_DEFAULT ?=3D \$(CODE_COVERAGE_LCOV_OPTIONS=
_GCOVPATH)</span><br><span> CODE_COVERAGE_LCOV_OPTIONS ?=3D \$(CODE_COVERAG=
E_LCOV_OPTIONS_DEFAULT)</span><br><span> CODE_COVERAGE_LCOV_RMOPTS_DEFAULT =
?=3D</span><br><span> CODE_COVERAGE_LCOV_RMOPTS ?=3D \$(CODE_COVERAGE_LCOV_=
RMOPTS_DEFAULT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-CODE_C=
OVERAGE_GENHTML_OPTIONS_DEFAULT ?=3D\</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-\$(if \$(CODE_COVERAGE_BRANCH_COVERAGE),\</span><br><span>-=
--rc genhtml_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_GENHTML_OPTIONS=
_DEFAULT ?=3D</span><br><span> CODE_COVERAGE_GENHTML_OPTIONS ?=3D \$(CODE_C=
OVERAGE_GENHTML_OPTIONS_DEFAULT)</span><br><span> CODE_COVERAGE_IGNORE_PATT=
ERN ?=3D</span><br><span> </span><br><span>@@ -152,8 +193,15 @@</span><br><=
span> code_coverage_quiet_ =3D \$(code_coverage_quiet_\$(AM_DEFAULT_VERBOSI=
TY))</span><br><span> code_coverage_quiet_0 =3D --quiet</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-# sanitizes the test-na=
me: replaces with underscores: dashes and dots</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-code_coverage_sanitize =3D \$(subst -,_,\$(subst =
=2E,_,\$(1)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Shel=
l fragments used by the recipes below=2E  They are portable</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# replacements for the GNU make fun=
ctions \$(addprefix =2E=2E=2E) and \$(if =2E=2E=2E):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# code_coverage_dirs_opt sets \$cc_dirs t=
o a list of --directory options,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# code_coverage_prefix_opt sets \$cc_prefix to a list of --pre=
fix options and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# co=
de_coverage_*_branch_opt set \$cc_branch to the branch coverage option=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+code_coverage_dirs_op=
t =3D cc_dirs=3D; for cc_dir in \$(CODE_COVERAGE_DIRECTORY); do cc_dirs=3D\=
&quot;\$\$cc_dirs --directory \$\$cc_dir\&quot;; done</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+code_coverage_prefix_opt =3D cc_prefix=3D=
; for cc_dir in \$(CODE_COVERAGE_DIRECTORY); do cc_prefix=3D\&quot;\$\$cc_p=
refix --prefix \$\$cc_dir\&quot;; done</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+code_coverage_lcov_branch_opt =3D cc_branch=3D; test -z =
\&quot;\$(CODE_COVERAGE_BRANCH_COVERAGE)\&quot; || cc_branch=3D\&quot;--rc =
lcov_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE)\&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+code_coverage_genhtml_branch_op=
t =3D cc_branch=3D; test -z \&quot;\$(CODE_COVERAGE_BRANCH_COVERAGE)\&quot;=
 || cc_branch=3D\&quot;--rc genhtml_branch_coverage=3D\$(CODE_COVERAGE_BRAN=
CH_COVERAGE)\&quot;</span><br><span> </span><br><span> # Use recursive make=
s in order to ignore errors during check</span><br><span> check-code-covera=
ge:</span><br><span>@@ -162,29 +210,26 @@</span><br><span> </span><br><span=
> # Capture code coverage data</span><br><span> code-coverage-capture: code=
-coverage-capture-hook</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	\$(code_coverage_v_lcov_cap)\$(LCOV) \$(code_coverage_quiet) \$(addprefix=
 --directory ,\$(CODE_COVERAGE_DIRECTORY)) --capture --output-file \&quot;\=
$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot; --test-name \&quot;\$(call code_c=
overage_sanitize,\$(PACKAGE_NAME)-\$(PACKAGE_VERSION))\&quot; --no-checksum=
 --compat-libtool \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_OPTIO=
NS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	\$(code_coverage_=
v_lcov_ign)\$(LCOV) \$(code_coverage_quiet) \$(addprefix --directory ,\$(CO=
DE_COVERAGE_DIRECTORY)) --remove \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp=
\&quot; \$(CODE_COVERAGE_IGNORE_PATTERN) --output-file \&quot;\$(CODE_COVER=
AGE_OUTPUT_FILE)\&quot; \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV=
_RMOPTS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	\$(code_co=
verage_v_lcov_cap)\$(code_coverage_dirs_opt); \\</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	\$(code_coverage_lcov_branch_opt); \\</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	\$(LCOV) \$(code_coverage_=
quiet) \$\$cc_dirs --capture --output-file \&quot;\$(CODE_COVERAGE_OUTPUT_F=
ILE)=2Etmp\&quot; --test-name \&quot;\$(CODE_COVERAGE_TEST_NAME)\&quot; --n=
o-checksum --compat-libtool \$\$cc_branch \$(CODE_COVERAGE_LCOV_SHOPTS) \$(=
CODE_COVERAGE_LCOV_OPTIONS)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	\$(code_coverage_v_lcov_ign)\$(code_coverage_dirs_opt); \\</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	\$(code_coverage_lcov_bran=
ch_opt); \\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	\$(LCOV=
) \$(code_coverage_quiet) \$\$cc_dirs --remove \&quot;\$(CODE_COVERAGE_OUTP=
UT_FILE)=2Etmp\&quot; \$(CODE_COVERAGE_IGNORE_PATTERN) --output-file \&quot=
;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \$\$cc_branch \$(CODE_COVERAGE_LCOV_S=
HOPTS) \$(CODE_COVERAGE_LCOV_RMOPTS)</span><br><span> 	-@rm -f \&quot;\$(CO=
DE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	\$(code_coverage_v_genhtml)LANG=3DC \$(GENHTML) \$(code_co=
verage_quiet) \$(addprefix --prefix ,\$(CODE_COVERAGE_DIRECTORY)) --output-=
directory \&quot;\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\&quot; --title \&quot;\=
$(PACKAGE_NAME)-\$(PACKAGE_VERSION) Code Coverage\&quot; --legend --show-de=
tails \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \$(CODE_COVERAGE_GENHTML_=
OPTIONS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	\$(code_co=
verage_v_genhtml)\$(code_coverage_prefix_opt); \\</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	\$(code_coverage_genhtml_branch_opt); \\</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	LANG=3DC \$(GENHTML) \=
$(code_coverage_quiet) \$\$cc_prefix --output-directory \&quot;\$(CODE_COVE=
RAGE_OUTPUT_DIRECTORY)\&quot; --title \&quot;\$(PACKAGE_NAME)-\$(PACKAGE_VE=
RSION) Code Coverage\&quot; --legend --show-details \&quot;\$(CODE_COVERAGE=
_OUTPUT_FILE)\&quot; \$\$cc_branch \$(CODE_COVERAGE_GENHTML_OPTIONS)</span>=
<br><span> 	@echo \&quot;file://\$(abs_builddir)/\$(CODE_COVERAGE_OUTPUT_DI=
RECTORY)/index=2Ehtml\&quot;</span><br><span> </span><br><span> code-covera=
ge-clean:</span><br><span> 	-\$(LCOV) --directory \$(top_builddir) -z</span=
><br><span> 	-rm -rf \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \&quot;\$(=
CODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot; \&quot;\$(CODE_COVERAGE_OUTPUT_DIRE=
CTORY)\&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-find =
=2E \\( -name \&quot;*=2Egcda\&quot; -o -name \&quot;*=2Egcno\&quot; -o -na=
me \&quot;*=2Egcov\&quot; \\) -delete</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	-find =2E \\( -name \&quot;*=2Egcda\&quot; -o -name \&qu=
ot;*=2Egcno\&quot; -o -name \&quot;*=2Egcov\&quot; \\) -exec rm -f &#39;{}&=
#39; +</span><br><span> </span><br><span> code-coverage-dist-clean:</span><=
br><span> </span><br><span> A][M_DISTCHECK_CONFIGURE_FLAGS :=3D \$(A][M_DIS=
TCHECK_CONFIGURE_FLAGS) --disable-code-coverage</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- else # ifneq (\$(abs_builddir), \$(abs_top_build=
dir))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check-code-cover=
age:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-code-coverage-capture: code-coverage-c=
apture-hook</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-code-coverage-clean:</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-code-coverage-dist-clean:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- endif # ifeq (\$(abs_builddir), \$(abs_top_build=
dir))</span><br><span> else #! CODE_COVERAGE_ENABLED</span><br><span> # Use=
 recursive makes in order to ignore errors during check</span><br><span> ch=
eck-code-coverage:</span><br><span>@@ -206,8 +251,7 @@</span><br><span> ])<=
/span><br><span> </span><br><span> AC_DEFUN([_AX_CODE_COVERAGE_ENABLED],[</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AX_CHECK_GNU_MAKE([],[=
AC_MSG_ERROR([not using GNU make that is needed for coverage])])</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	AC_REQUIRE([AX_ADD_AM_MACRO_STA=
TIC])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_REQUIRE([O=
PENVPN_ADD_AM_MACRO_STATIC])</span><br><span> 	# check for gcov</span><br><=
span> 	AC_CHECK_TOOL([GCOV],</span><br><span> 		  [$_AX_CODE_COVERAGE_GCOV_=
PROG_WITH],</span><br><span>@@ -232,13 +276,12 @@</span><br><span> 		AC_MSG=
_ERROR([Could not find genhtml from the lcov package])</span><br><span> 	])=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AC=
_CHECK_LIB([gcov], [_gcov_init], [CODE_COVERAGE_LIBS=3D&quot;-lgcov&quot;],=
 [CODE_COVERAGE_LIBS=3D&quot;&quot;])</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span> 	dnl Build the code coverage flags</span>=
<br><span> 	dnl Define CODE_COVERAGE_LDFLAGS for backwards compatibility</s=
pan><br><span> 	CODE_COVERAGE_CPPFLAGS=3D&quot;-DNDEBUG&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	CODE_COVERAGE_CFLAGS=3D&quot;-O0 -=
g -fprofile-arcs -ftest-coverage&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	CODE_COVERAGE_CXXFLAGS=3D&quot;-O0 -g -fprofile-arcs -fte=
st-coverage&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	C=
ODE_COVERAGE_CFLAGS=3D&quot;-O0 -g --coverage&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	CODE_COVERAGE_CXXFLAGS=3D&quot;-O0 -g --=
coverage&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	CODE=
_COVERAGE_LIBS=3D&quot;--coverage&quot;</span><br><span> </span><br><span> =
	AC_SUBST([CODE_COVERAGE_CPPFLAGS])</span><br><span> 	AC_SUBST([CODE_COVERA=
GE_CFLAGS])</span><br><span>@@ -265,6 +308,10 @@</span><br><span> 	AC_SUBST=
([CODE_COVERAGE_ENABLED], [$enable_code_coverage])</span><br><span> 	AC_MSG=
_RESULT($enable_code_coverage)</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	dnl The lcov test name must not contain dashe=
s or dots</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	CODE_COVE=
RAGE_TEST_NAME=3D`echo &quot;$PACKAGE_NAME-$PACKAGE_VERSION&quot; | tr &#39=
;=2E-&#39; &#39;__&#39;`</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	AC_SUBST([CODE_COVERAGE_TEST_NAME])</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> 	AS_IF([ test &quot;x$enable_code_c=
overage&quot; =3D xyes ], [</span><br><span> 		_AX_CODE_COVERAGE_ENABLED</s=
pan><br><span> 	      ])</span><br><span>diff --git a/src/openvpn/Makefile=
=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 7ecddff=2E=2E942480=
1 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>++=
+ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -31,9 +31,12 @@</span><br>=
<span> 	$(OPTIONAL_SYSTEMD_CFLAGS) \</span><br><span> 	$(OPTIONAL_PKCS11_HE=
LPER_CFLAGS) \</span><br><span> 	$(OPTIONAL_INOTIFY_CFLAGS) \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	$(CODE_COVERAGE_CFLAGS) \</span>=
<br><span> 	-DPLUGIN_LIBDIR=3D\&quot;${plugindir}\&quot; \</span><br><span>=
 	-DDEFAULT_DNS_UPDOWN=3D\&quot;${scriptdir}/dns-updown\&quot;</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+AM_LDFLAGS =3D=
 $(CODE_COVERAGE_LIBS)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> if WIN32</span><br><span> # we want unicode entry poin=
t but not the macro</span><br><span> AM_CFLAGS +=3D -municode -UUNICODE</sp=
an><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1592?usp=3Demail">change 1592</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1592?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f=
765b33 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1592 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>

</body></html>
--+hh5mK9u7kg=--


--===============8363723328883185347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8363723328883185347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8363723328883185347==--

