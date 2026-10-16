Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5CECCA46C
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VkgcKJadOKvF4xAnY0fRRDOiBw6SMcqN4QWAE3uHPQ0=; b=VbParLCycDAceolORn5I6hpOpq
	sCNSgmhc16FniMt/5QUKWURUrGVm0UzvatGZV4MSBHuaSWW/HfB5SPf3765xA/nErqJzJxejwyUHm
	TBY4t4aU6RNo/ZRqWZW6KhqYKWPAXcR907GrUvFCaXtNqgo0O9gavlPvy8pKBjyiQfSg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHjdy-0002wu-LQ;
	Fri, 16 Oct 2026 15:14:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHjdx-0002wo-RH
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 15:14:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1UpUwP7KC6RLmMWgl0oO8yzRBal6g2x1dm5eV28iHh8=; b=fF6BjzNclRWK7hW/urGMCmDixw
 7dM9aHDjiEZUbpFwvHqeWlkVPxrB49s2YFaZrvuf+L59UdB0XKIxU3ftsfPRpfzrH9UA/niAAGhw6
 3o0LFvCGd9xGfzZpyfq3fYsDyILMyrDI3mRxrlHvUzq5BHfO+yi2+H+FpayFaLgnlFas=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1UpUwP7KC6RLmMWgl0oO8yzRBal6g2x1dm5eV28iHh8=; b=L
 7jNsU8AUFpT3oyh9vcKe5IppFe8tp/VALugS4cEphR1uqpnaQn3pgmAD2cwdAKW4OOYi/gPsJXJJN
 UzHdDWzDFrdUDIhWm/qL2CjXo45gwKd9uAZKpRUMEZ4W9Kr2V8jwKqD4a5K9R8goP0IfYcnWC6Sto
 S3mVHq6VUPERx5o4=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHjdt-0000zH-BF for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 15:14:49 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a0e1b0681bso412665e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 16 Oct 2026 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792163679; x=1792768479; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1UpUwP7KC6RLmMWgl0oO8yzRBal6g2x1dm5eV28iHh8=;
 b=g7wpU5SxVnRaNWtGMfZah2koeTiiAzZslUtXs1ZHdAHi1WxC9ei7GfDDx+z70wNJD4
 fpfJh285T7hJWYj+HalIoaCboExH73kvNgdznvPSBzkub5gcbXq9aDUKmgp/pUUu2lM6
 w3tNBy1eXBkzdu9Xtl1Q/h6igV0j65+W1DZHbQhhsb5UyJO9DkOzWLEqEVFCwoGx0LYH
 nurfW5XmhBqYLbdbndFjcomme03Yl1JDBu1yBm/uEYBrPVCRW1FIbIW7claeyoeFnHnU
 HztaKydNwsnsBK4B6a0gPyj4gAUINckTDWkzJx80guroeWpqqvQKdeCNUbz3h4bn9WsT
 qtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792163679; x=1792768479;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1UpUwP7KC6RLmMWgl0oO8yzRBal6g2x1dm5eV28iHh8=;
 b=wo6yGX93I9Xl+7l0sES/ctKZmru9lWRahqyjaY7V/00Swhfwc7oc/ajqwTLyDYKkXV
 zr/GxzuMwDXrlklzHez7u4dS1G/2WnlHyyuYvHekkf0frh+9KuySg1JpAd+f0aP746Q9
 c4eLoGTyBelTHa+tayGDpcgZF8wG1W6pcoaVngN7sAOV2kRPNIjzADyoM4l/qTEpSPFA
 FJwO7mFTuZz0TrxKqBcvR5rMAKJcd/YejdHHkDTXsFJDEEsKFhz5fWnmk195bCkQbgL/
 2rP1T5asq6ZYB3oTCU1uGutNbhk+iXuKE1otkZWLvG3rkeKJg+/bxQK27BucPdE8cThW
 YWuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6U0Mtzc6uX40sfT2CqrJsasI7BScbrWlRirsMXV9t2K8SpYSEIP7z/vx4ZMPx/gVWK9CpnmjQg8KZrZwu@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKvjIdeFBvIiZI1Ysd1r0wnCYs6aMUUsUfUjdgELI9aS2PXPIim
 v6lTEEN3fxfhOwqdTpgw9baaNwW2PSCAdAN7/r3x2nMe0EwJ30THRuOUpRGT0REHM+Twf/ZgKPJ
 JKWBf7g39OloafWWyT2J1X5p998G52Xhy/J44x8HUlS+lCRp6VnK5sq5vQ/gqWiOhymLM
X-Gm-Gg: AYBFou2E5Qy0VmdNYOncwbocfn91F4lLdf3CfvrVw09IHRKRNLWaBDjuZUkBb3BSFLJ
 QWa9mJ2hgd22fIOtWf+7FpvDHJGbJ60s0ptDunJh2csPKXZtTNIhwLaUJHVLjkR1Hlh+s2vnwtX
 YHCh0Aqv6fcw2olwAVBxQiOY2nmIMOoyh/ienL0u68HrLg/xJBbujL8gzORr6fSnwqce8QADIO0
 ol0Z9T+fuFbWAcoXxS8Tzw4SogQxADz4ks8S8VgAgoOVD48Y6tuqYpHBhwRwNv7zn+9KBBhRBWe
 czJpt+M9gmbOLU52aYjKCALs8S/Bb70404uwIk/iliNXoMBOphJbj9axray76bxInvWqZlxU9tf
 41WSX841s+SX0OiC9u5J3eiHBuxNLd66gvyJl5yaeDw9qb3Pya8rzuevwCUWGcNgyotvWF0mRSk
 rh2mToHtmHgIn5wN6InZBgvOWewzJs6FvekGEcBoYT8wRHZc9EMQLToK24sTNIrnl46WCZ9mIJc
 P4ryuchTV2V0YnpTKqJlKZdecDALIMx8n6CPuYdzGjyn4vHdy9KaFa6jgx4d/RaWs2LrXgrVsJ8
 t1x5w8AKpDrLLieOyx1C5+0fXdqfjiMOcDsHKSMqyJq4f8puaVtWChb8AqE0
X-Received: by 2002:a05:600c:4e50:b0:4a0:1ea2:10c6 with SMTP id
 5b1f17b1804b1-4a1d7600357mr2913095e9.17.1792163678382; 
 Fri, 16 Oct 2026 08:14:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce3302b5sm34387265e9.4.2026.10.16.08.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 08:14:37 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 16 Oct 2026 15:14:37 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
X-Gerrit-Change-Number: 1592
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1592?usp=email>
X-Gerrit-Commit: dda75df387f83ae10741d74a516495466ca78964
In-Reply-To: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
References: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0NDUxMzgwMDAwLkk3OWIyZGM0YTU1MGIxYzUwNjhhNDU0MDc5NzZiMGRmYzJmNzY1YjMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3ceb2e3c514a00c17ed9a4b28b8e88051850e87c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHjdt-0000zH-BF
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5488552996450364213=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5488552996450364213==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gqA+6zGtgJg="; charset=UTF-8

--gqA+6zGtgJg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1592?usp=3Demail )

Change subject: configure: Add --enable-cod=
e-coverage
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
Acked-by: Razvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1592
Message-Id: <20261016080644=2E23188-1-gert@greenie=2Emuc=2Ede>
URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g39917=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =
=2Egitignore
M Makefile=2Eam
M configure=2Eac
A lcovrc
M m4/ax_code_coverag=
e=2Em4
M src/openvpn/Makefile=2Eam
6 files changed, 114 insertions(+), 43 d=
eletions(-)




diff --git a/=2Egitignore b/=2Egitignore
index 04523af=2E=
=2E2749739 100644
--- a/=2Egitignore
+++ b/=2Egitignore
@@ -1,5 +1,9 @@
 *=
=2E[oa]
 *=2El[oa]
+*=2Egcda
+*=2Egcno
+*-coverage/
+*-coverage=2Einfo
 *=
=2Edll
 *=2Eexe
 *=2Eexe=2E*
@@ -18,6 +22,7 @@
 Makefile
 Makefile=2Ein
 ac=
local=2Em4
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
t-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
Gerrit-Change-Number: =
1592
Gerrit-PatchSet: 7
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>

--gqA+6zGtgJg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1592?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">configure: Add --enable-code-cover=
age<br><br>Can be used like this<br>=2E/configure --enable-code-coverage<br=
>make<br>make check<br>make code-coverage-capture<br><br>We heavily patch a=
x_code_coverage=2Em4, mostly to<br>achieve better compatibility with non-Li=
nux systems=2E<br>- Do not depend on autoconf-archive<br>- Do not depend on=
 GNU make<br>- Use more modern --coverage flag to better support<br>  diffe=
rent compilers<br><br>Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acke=
d-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592<br>Message-Id: &lt;20261016080644=
=2E23188-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39917=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =2Egitignore=
<br>M Makefile=2Eam<br>M configure=2Eac<br>A lcovrc<br>M m4/ax_code_coverag=
e=2Em4<br>M src/openvpn/Makefile=2Eam<br>6 files changed, 114 insertions(+)=
, 43 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/=2Egitignore b/=2Egitignore=
</span><br><span>index 04523af=2E=2E2749739 100644</span><br><span>--- a/=
=2Egitignore</span><br><span>+++ b/=2Egitignore</span><br><span>@@ -1,5 +1,=
9 @@</span><br><span> *=2E[oa]</span><br><span> *=2El[oa]</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+*=2Egcda</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+*=2Egcno</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+*-coverage/</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+*-coverage=2Einfo</span><br><span> *=2Edll</span><br><span> *=2Eexe=
</span><br><span> *=2Eexe=2E*</span><br><span>@@ -18,6 +22,7 @@</span><br><=
span> Makefile</span><br><span> Makefile=2Ein</span><br><span> aclocal=2Em4=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+aminclude_static=2E=
am</span><br><span> autodefs=2Eh</span><br><span> autom4te=2Ecache</span><b=
r><span> config=2Eguess</span><br><span>diff --git a/Makefile=2Eam b/Makefi=
le=2Eam</span><br><span>index 125fe84=2E=2Ed3910ed 100644</span><br><span>-=
-- a/Makefile=2Eam</span><br><span>+++ b/Makefile=2Eam</span><br><span>@@ -=
22,6 +22,8 @@</span><br><span> #  with this program; if not, see &lt;https:=
//www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span> #</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+include $(top_srcdir)/a=
minclude_static=2Eam</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> ACLOCAL_AMFLAGS =3D -I m4</span><br><span> </span><br><s=
pan> MAINTAINERCLEANFILES =3D \</span><br><span>@@ -45,7 +47,8 @@</span><br=
><span> 	CMakeLists=2Etxt \</span><br><span> 	CMakePresets=2Ejson \</span><=
br><span> 	config=2Eh=2Ecmake=2Ein \</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	forked-test-driver</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	forked-test-driver \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	lcovrc</span><br><span> </span><br><span> =2EPHONY: confi=
g-version=2Eh doxygen</span><br><span> </span><br><span>@@ -98,3 +101,7 @@<=
/span><br><span> 	INCLUDE_FLAGS=3D&quot;$(LIBNL_GENL_CFLAGS)&quot; \</span>=
<br><span> 	CPPCHECK_VERBOSE=3D&quot;$(AM_V_P)&quot; \</span><br><span> 		&=
quot;$(top_srcdir)/dev-tools/run-cppcheck=2Esh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+CODE_COVERAGE_LCOV_SHOPTS=3D--config-file $(srcdir)/lcovrc</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+clean-local: code-cov=
erage-clean</span><br><span style=3D"color: hsl(120, 100%, 40%);">+distclea=
n-local: code-coverage-dist-clean</span><br><span>diff --git a/configure=2E=
ac b/configure=2Eac</span><br><span>index ad3f8f1=2E=2E6617c8d 100644</span=
><br><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span>=
<br><span>@@ -59,6 +59,8 @@</span><br><span> AC_CANONICAL_HOST</span><br><s=
pan> AC_USE_SYSTEM_EXTENSIONS</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+AX_CODE_COVERAGE</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> AC_ARG_ENABLE(</span><br><span> =
	[lzo],</span><br><span> 	[AS_HELP_STRING([--disable-lzo], [disable LZO com=
pression support @&lt;:@default=3Dyes@:&gt;@])],</span><br><span>@@ -1236,6=
 +1238,11 @@</span><br><span> 	ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-cast-funct=
ion-type])</span><br><span> fi</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# If coverage is enabled remove -O arguments f=
rom CFLAGS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if test &=
quot;$enable_code_coverage&quot; =3D &quot;yes&quot;; then</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+   [CFLAGS=3D&quot;`echo $CFLAGS | $=
SED -e &#39;s/-O[a-z0-9]*//g&#39;`&quot;]</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> if test &quot;${enable_pedantic}&quot; =3D &quot;yes=
&quot;; then</span><br><span> 	CFLAGS=3D&quot;${CFLAGS} -pedantic&quot;</sp=
an><br><span> 	AC_DEFINE([PEDANTIC], [1], [Enable pedantic mode])</span><br=
><span>@@ -1355,10 +1362,10 @@</span><br><span> </span><br><span> TEST_LDFL=
AGS=3D&quot;${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${OPTION=
AL_LIBCAPNG_LIBS}&quot;</span><br><span> TEST_LDFLAGS=3D&quot;${TEST_LDFLAG=
S} ${OPTIONAL_LIBNL_GENL_LIBS}&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-TEST_LDFLAGS=3D&quot;${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${=
CMOCKA_LIBS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+T=
EST_LDFLAGS=3D&quot;${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS} ${C=
ODE_COVERAGE_LIBS}&quot;</span><br><span> TEST_CFLAGS=3D&quot;${OPTIONAL_CR=
YPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS} ${OPTIONAL_LIBCAPNG_CFLAGS}&q=
uot;</span><br><span> TEST_CFLAGS=3D&quot;${TEST_CFLAGS} ${OPTIONAL_LIBNL_G=
ENL_CFLAGS} ${OPTIONAL_LZO_CFLAGS}&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-TEST_CFLAGS=3D&quot;${TEST_CFLAGS} -I\$(top_srcdir)/incl=
ude ${CMOCKA_CFLAGS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+TEST_CFLAGS=3D&quot;${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA=
_CFLAGS} ${CODE_COVERAGE_CFLAGS}&quot;</span><br><span> </span><br><span> A=
C_SUBST([TEST_LDFLAGS])</span><br><span> AC_SUBST([TEST_CFLAGS])</span><br>=
<span>diff --git a/lcovrc b/lcovrc</span><br><span>new file mode 100644</sp=
an><br><span>index 0000000=2E=2Ef8b4138</span><br><span>--- /dev/null</span=
><br><span>+++ b/lcovrc</span><br><span>@@ -0,0 +1,2 @@</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+geninfo_external =3D 1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+geninfo_unexecuted_blocks =3D 1</spa=
n><br><span>diff --git a/m4/ax_code_coverage=2Em4 b/m4/ax_code_coverage=2Em=
4</span><br><span>index 216708a4=2E=2Ef156d4d 100644</span><br><span>--- a/=
m4/ax_code_coverage=2Em4</span><br><span>+++ b/m4/ax_code_coverage=2Em4</sp=
an><br><span>@@ -42,8 +42,8 @@</span><br><span> #     clean-local: code-cov=
erage-clean</span><br><span> #     distclean-local: code-coverage-dist-clea=
n</span><br><span> #</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
   This results in a &quot;check-code-coverage&quot; rule being added to an=
y</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#   Makefile=2Eam wh=
ich do &quot;include $(top_srcdir)/aminclude_static=2Eam&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#   This results in a &quot;chec=
k-code-coverage&quot; rule being added to the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#   Makefile=2Eam which does &quot;include $(top_=
srcdir)/aminclude_static=2Eam&quot;</span><br><span> #   (assuming the modu=
le has been configured with --enable-code-coverage)=2E</span><br><span> #  =
 Running `make check-code-coverage` in that directory will run the</span><b=
r><span> #   module&#39;s test suite (`make check`) and build a code covera=
ge report</span><br><span>@@ -76,10 +76,51 @@</span><br><span> </span><br><=
span> #serial 37</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+dnl Local modifications compared to the autoconf-archive ver=
sion:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+dnl  - AX_ADD_AM_MACRO_STATIC =
(from autoconf-archive) is replaced by a</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+dnl    minimal local equivalent, OPENVPN_ADD_AM_MACRO_=
STATIC, so that we do</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+dnl    not depend on autoconf-archive being installed=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+dnl  - The generated rules no longer=
 require GNU make=2E  The AX_CHECK_GNU_MAKE</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+dnl    check is gone (which also removed the last a=
utoconf-archive</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl =
   dependency) and the GNU make specific constructs in the rules were</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl    replaced:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+dnl      * the &quot;ifeq ($=
(abs_builddir), $(abs_top_builddir))&quot; guard is gone,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+dnl        aminclude_static=2Eam may =
only be included by the top level</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+dnl        Makefile=2Eam now (which is the only place it was =
ever included</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl   =
     from in this project),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+dnl      * $(addprefix =2E=2E=2E) and $(if =2E=2E=2E) are replaced =
by shell code inside</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+dnl        the recipes,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+dnl      * $(call =2E=2E=2E)/$(subst =2E=2E=2E) for the lcov test name=
 is replaced by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl =
       CODE_COVERAGE_TEST_NAME, computed at configure time,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+dnl      * &quot;find =2E=2E=2E -de=
lete&quot; is replaced by &quot;find =2E=2E=2E -exec rm -f {} +&quot;=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl    The only remain=
ing non-POSIX construct is the nested variable</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+dnl    expansion used for the silent rules ($(fo=
o_$(V))), which is the same</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+dnl    idiom automake itself uses for AM_V_at and friends and which=
 is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl    understoo=
d by BSD make as well=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_DEFUN([OPEN=
VPN_PRINT_TO_FILE],[</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+m4_esyscmd(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+[</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+printf &quot;%s&quot; &qu=
ot;$2&quot; &gt; &quot;$1&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+])</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+AC_DEFUN([OPENVPN_ADD_AM_MACRO_STATIC],[<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  OPENVPN_PRINT_TO_F=
ILE([aminclude_static=2Eam],[$1])</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> m4_define(_AX_CODE_COVERAGE_RULES,[</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-AX_ADD_AM_MACRO_STATIC([</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+OPENVPN_ADD_AM_MACRO_STATIC([</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# This file was generated by ax=
_code_coverage</span><br><span> # Code coverage</span><br><span> #</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# This file must only be inc=
luded by the top level Makefile=2Eam: the rules</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# below always report on the complete build tre=
e=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# The rules avoid GNU make specif=
ic syntax so that they also work with</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# other make implementations, e=2Eg=2E BSD make=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span> # Optio=
nal:</span><br><span> #  - CODE_COVERAGE_DIRECTORY: Top-level directory for=
 code coverage reporting=2E</span><br><span> #    Multiple directories may =
be specified, separated by whitespace=2E</span><br><span>@@ -90,51 +131,51 =
@@</span><br><span> #  - CODE_COVERAGE_OUTPUT_DIRECTORY: Directory for gene=
rated code coverage</span><br><span> #    reports to be created=2E (Default=
:</span><br><span> #    \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_TEST_=
NAME: Test name to record in the =2Einfo file=2E  It is</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#    computed by configure (\$(PACKAGE_=
NAME)-\$(PACKAGE_VERSION), with dashes</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#    and dots replaced by underscores) and can be overri=
dden by defining it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#    in Makefile=2Eam=2E</span><br><span> #  - CODE_COVERAGE_BRANCH_COVERAG=
E: Set to 1 to enforce branch coverage,</span><br><span> #    set to 0 to d=
isable it and leave empty to stay with the default=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#    (Default: empty)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#    The corresponding --rc option is pas=
sed to lcov and genhtml in</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#    addition to the options below=2E (Default: empty)</span><br><sp=
an> #  - CODE_COVERAGE_LCOV_SHOPTS_DEFAULT: Extra options shared between bo=
th lcov</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#    instances=
=2E (Default: based on $CODE_COVERAGE_BRANCH_COVERAGE)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#    instances=2E (Default: empty)</span=
><br><span> #  - CODE_COVERAGE_LCOV_SHOPTS: Extra options to shared between=
 both lcov</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#    instan=
ces=2E (Default: $CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#    instances=2E (Default: \$CODE_COVERA=
GE_LCOV_SHOPTS_DEFAULT)</span><br><span> #  - CODE_COVERAGE_LCOV_OPTIONS_GC=
OVPATH: --gcov-tool pathtogcov</span><br><span> #  - CODE_COVERAGE_LCOV_OPT=
IONS_DEFAULT: Extra options to pass to the</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#    collecting lcov instance=2E (Default: $CODE_COVER=
AGE_LCOV_OPTIONS_GCOVPATH)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#    collecting lcov instance=2E (Default: \$CODE_COVERAGE_LCOV_OPTI=
ONS_GCOVPATH)</span><br><span> #  - CODE_COVERAGE_LCOV_OPTIONS: Extra optio=
ns to pass to the collecting lcov</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#    instance=2E (Default: $CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    instance=2E (D=
efault: \$CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)</span><br><span> #  - CODE_CO=
VERAGE_LCOV_RMOPTS_DEFAULT: Extra options to pass to the filtering</span><b=
r><span> #    lcov instance=2E (Default: empty)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#  - CODE_COVERAGE_LCOV_RMOPTS: Extra options to =
pass to the filtering lcov</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#    instance=2E (Default: $CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_LCOV_RMO=
PTS: Extra options to pass to the filtering</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#    lcov instance=2E (Default: \$CODE_COVERAGE_LCO=
V_RMOPTS_DEFAULT)</span><br><span> #  - CODE_COVERAGE_GENHTML_OPTIONS_DEFAU=
LT: Extra options to pass to the</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#    genhtml instance=2E (Default: based on $CODE_COVERAGE_BRANC=
H_COVERAGE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    gen=
html instance=2E (Default: empty)</span><br><span> #  - CODE_COVERAGE_GENHT=
ML_OPTIONS: Extra options to pass to the genhtml</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#    instance=2E (Default: $CODE_COVERAGE_GENHTM=
L_OPTIONS_DEFAULT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
    instance=2E (Default: \$CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)</span><b=
r><span> #  - CODE_COVERAGE_IGNORE_PATTERN: Extra glob pattern of files to =
ignore</span><br><span> #</span><br><span> # The generated report will be t=
itled using the \$(PACKAGE_NAME) and</span><br><span> # \$(PACKAGE_VERSION)=
=2E In order to add the current git hash to the title,</span><br><span> # u=
se the git-version-gen script, available online=2E</span><br><span> # Optio=
nal variables</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# run on=
ly on top dir</span><br><span> if CODE_COVERAGE_ENABLED</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- ifeq (\$(abs_builddir), \$(abs_top_build=
dir))</span><br><span> CODE_COVERAGE_DIRECTORY ?=3D \$(top_builddir)</span>=
<br><span> CODE_COVERAGE_OUTPUT_FILE ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSI=
ON)-coverage=2Einfo</span><br><span> CODE_COVERAGE_OUTPUT_DIRECTORY ?=3D \$=
(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage</span><br><span> </span><br><sp=
an> CODE_COVERAGE_BRANCH_COVERAGE ?=3D</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-CODE_COVERAGE_LCOV_SHOPTS_DEFAULT ?=3D \$(if \$(CODE_COVER=
AGE_BRANCH_COVERAGE),\</span><br><span>---rc lcov_branch_coverage=3D\$(CODE=
_COVERAGE_BRANCH_COVERAGE))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+CODE_COVERAGE_LCOV_SHOPTS_DEFAULT ?=3D</span><br><span> CODE_COVERA=
GE_LCOV_SHOPTS ?=3D \$(CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)</span><br><span> =
CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH ?=3D --gcov-tool \&quot;\$(GCOV)\&quot;=
</span><br><span> CODE_COVERAGE_LCOV_OPTIONS_DEFAULT ?=3D \$(CODE_COVERAGE_=
LCOV_OPTIONS_GCOVPATH)</span><br><span> CODE_COVERAGE_LCOV_OPTIONS ?=3D \$(=
CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)</span><br><span> CODE_COVERAGE_LCOV_RMO=
PTS_DEFAULT ?=3D</span><br><span> CODE_COVERAGE_LCOV_RMOPTS ?=3D \$(CODE_CO=
VERAGE_LCOV_RMOPTS_DEFAULT)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT ?=3D\</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-\$(if \$(CODE_COVERAGE_BRANCH_COVERAGE),\</span=
><br><span>---rc genhtml_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_GEN=
HTML_OPTIONS_DEFAULT ?=3D</span><br><span> CODE_COVERAGE_GENHTML_OPTIONS ?=
=3D \$(CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)</span><br><span> CODE_COVERAG=
E_IGNORE_PATTERN ?=3D</span><br><span> </span><br><span>@@ -152,8 +193,15 @=
@</span><br><span> code_coverage_quiet_ =3D \$(code_coverage_quiet_\$(AM_DE=
FAULT_VERBOSITY))</span><br><span> code_coverage_quiet_0 =3D --quiet</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-# sanitize=
s the test-name: replaces with underscores: dashes and dots</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-code_coverage_sanitize =3D \$(subst -=
,_,\$(subst =2E,_,\$(1)))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# Shell fragments used by the recipes below=2E  They are portable</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# replacements for the =
GNU make functions \$(addprefix =2E=2E=2E) and \$(if =2E=2E=2E):</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# code_coverage_dirs_opt sets =
\$cc_dirs to a list of --directory options,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# code_coverage_prefix_opt sets \$cc_prefix to a li=
st of --prefix options and</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+# code_coverage_*_branch_opt set \$cc_branch to the branch coverage =
option=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code_cover=
age_dirs_opt =3D cc_dirs=3D; for cc_dir in \$(CODE_COVERAGE_DIRECTORY); do =
cc_dirs=3D\&quot;\$\$cc_dirs --directory \$\$cc_dir\&quot;; done</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+code_coverage_prefix_opt =3D c=
c_prefix=3D; for cc_dir in \$(CODE_COVERAGE_DIRECTORY); do cc_prefix=3D\&qu=
ot;\$\$cc_prefix --prefix \$\$cc_dir\&quot;; done</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+code_coverage_lcov_branch_opt =3D cc_branch=
=3D; test -z \&quot;\$(CODE_COVERAGE_BRANCH_COVERAGE)\&quot; || cc_branch=
=3D\&quot;--rc lcov_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE)\&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code_coverage_ge=
nhtml_branch_opt =3D cc_branch=3D; test -z \&quot;\$(CODE_COVERAGE_BRANCH_C=
OVERAGE)\&quot; || cc_branch=3D\&quot;--rc genhtml_branch_coverage=3D\$(COD=
E_COVERAGE_BRANCH_COVERAGE)\&quot;</span><br><span> </span><br><span> # Use=
 recursive makes in order to ignore errors during check</span><br><span> ch=
eck-code-coverage:</span><br><span>@@ -162,29 +210,26 @@</span><br><span> <=
/span><br><span> # Capture code coverage data</span><br><span> code-coverag=
e-capture: code-coverage-capture-hook</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	\$(code_coverage_v_lcov_cap)\$(LCOV) \$(code_coverage_quie=
t) \$(addprefix --directory ,\$(CODE_COVERAGE_DIRECTORY)) --capture --outpu=
t-file \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot; --test-name \&quot=
;\$(call code_coverage_sanitize,\$(PACKAGE_NAME)-\$(PACKAGE_VERSION))\&quot=
; --no-checksum --compat-libtool \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVE=
RAGE_LCOV_OPTIONS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	\$=
(code_coverage_v_lcov_ign)\$(LCOV) \$(code_coverage_quiet) \$(addprefix --d=
irectory ,\$(CODE_COVERAGE_DIRECTORY)) --remove \&quot;\$(CODE_COVERAGE_OUT=
PUT_FILE)=2Etmp\&quot; \$(CODE_COVERAGE_IGNORE_PATTERN) --output-file \&quo=
t;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \$(CODE_COVERAGE_LCOV_SHOPTS) \$(COD=
E_COVERAGE_LCOV_RMOPTS)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	\$(code_coverage_v_lcov_cap)\$(code_coverage_dirs_opt); \\</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	\$(code_coverage_lcov_branch_o=
pt); \\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	\$(LCOV) \$=
(code_coverage_quiet) \$\$cc_dirs --capture --output-file \&quot;\$(CODE_CO=
VERAGE_OUTPUT_FILE)=2Etmp\&quot; --test-name \&quot;\$(CODE_COVERAGE_TEST_N=
AME)\&quot; --no-checksum --compat-libtool \$\$cc_branch \$(CODE_COVERAGE_L=
COV_SHOPTS) \$(CODE_COVERAGE_LCOV_OPTIONS)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	\$(code_coverage_v_lcov_ign)\$(code_coverage_dirs_o=
pt); \\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	\$(code_cov=
erage_lcov_branch_opt); \\</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	\$(LCOV) \$(code_coverage_quiet) \$\$cc_dirs --remove \&quot;\$(COD=
E_COVERAGE_OUTPUT_FILE)=2Etmp\&quot; \$(CODE_COVERAGE_IGNORE_PATTERN) --out=
put-file \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \$\$cc_branch \$(CODE_=
COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_RMOPTS)</span><br><span> 	-@rm =
-f \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	\$(code_coverage_v_genhtml)LANG=3DC \$(GEN=
HTML) \$(code_coverage_quiet) \$(addprefix --prefix ,\$(CODE_COVERAGE_DIREC=
TORY)) --output-directory \&quot;\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\&quot; =
--title \&quot;\$(PACKAGE_NAME)-\$(PACKAGE_VERSION) Code Coverage\&quot; --=
legend --show-details \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \$(CODE_C=
OVERAGE_GENHTML_OPTIONS)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	\$(code_coverage_v_genhtml)\$(code_coverage_prefix_opt); \\</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	\$(code_coverage_genhtml_bra=
nch_opt); \\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	LANG=
=3DC \$(GENHTML) \$(code_coverage_quiet) \$\$cc_prefix --output-directory \=
&quot;\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\&quot; --title \&quot;\$(PACKAGE_N=
AME)-\$(PACKAGE_VERSION) Code Coverage\&quot; --legend --show-details \&quo=
t;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \$\$cc_branch \$(CODE_COVERAGE_GENHT=
ML_OPTIONS)</span><br><span> 	@echo \&quot;file://\$(abs_builddir)/\$(CODE_=
COVERAGE_OUTPUT_DIRECTORY)/index=2Ehtml\&quot;</span><br><span> </span><br>=
<span> code-coverage-clean:</span><br><span> 	-\$(LCOV) --directory \$(top_=
builddir) -z</span><br><span> 	-rm -rf \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=
\&quot; \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot; \&quot;\$(CODE_CO=
VERAGE_OUTPUT_DIRECTORY)\&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	-find =2E \\( -name \&quot;*=2Egcda\&quot; -o -name \&quot;*=2Eg=
cno\&quot; -o -name \&quot;*=2Egcov\&quot; \\) -delete</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	-find =2E \\( -name \&quot;*=2Egcda\&qu=
ot; -o -name \&quot;*=2Egcno\&quot; -o -name \&quot;*=2Egcov\&quot; \\) -ex=
ec rm -f &#39;{}&#39; +</span><br><span> </span><br><span> code-coverage-di=
st-clean:</span><br><span> </span><br><span> A][M_DISTCHECK_CONFIGURE_FLAGS=
 :=3D \$(A][M_DISTCHECK_CONFIGURE_FLAGS) --disable-code-coverage</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- else # ifneq (\$(abs_builddir),=
 \$(abs_top_builddir))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-check-code-coverage:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-code-coverage-capture=
: code-coverage-capture-hook</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-code-coverage-=
clean:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-code-coverage-dist-clean:</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- endif # ifeq (\$(abs_builddir),=
 \$(abs_top_builddir))</span><br><span> else #! CODE_COVERAGE_ENABLED</span=
><br><span> # Use recursive makes in order to ignore errors during check</s=
pan><br><span> check-code-coverage:</span><br><span>@@ -206,8 +251,7 @@</sp=
an><br><span> ])</span><br><span> </span><br><span> AC_DEFUN([_AX_CODE_COVE=
RAGE_ENABLED],[</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AX_CH=
ECK_GNU_MAKE([],[AC_MSG_ERROR([not using GNU make that is needed for covera=
ge])])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AC_REQUIRE([AX=
_ADD_AM_MACRO_STATIC])</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	AC_REQUIRE([OPENVPN_ADD_AM_MACRO_STATIC])</span><br><span> 	# check for=
 gcov</span><br><span> 	AC_CHECK_TOOL([GCOV],</span><br><span> 		  [$_AX_CO=
DE_COVERAGE_GCOV_PROG_WITH],</span><br><span>@@ -232,13 +276,12 @@</span><b=
r><span> 		AC_MSG_ERROR([Could not find genhtml from the lcov package])</sp=
an><br><span> 	])</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	AC_CHECK_LIB([gcov], [_gcov_init], [CODE_COVERAGE_LIBS=3D&qu=
ot;-lgcov&quot;], [CODE_COVERAGE_LIBS=3D&quot;&quot;])</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> 	dnl Build the code cove=
rage flags</span><br><span> 	dnl Define CODE_COVERAGE_LDFLAGS for backwards=
 compatibility</span><br><span> 	CODE_COVERAGE_CPPFLAGS=3D&quot;-DNDEBUG&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	CODE_COVERAGE_CFL=
AGS=3D&quot;-O0 -g -fprofile-arcs -ftest-coverage&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	CODE_COVERAGE_CXXFLAGS=3D&quot;-O0 -g -f=
profile-arcs -ftest-coverage&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	CODE_COVERAGE_CFLAGS=3D&quot;-O0 -g --coverage&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	CODE_COVERAGE_CXXFLAGS=3D=
&quot;-O0 -g --coverage&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	CODE_COVERAGE_LIBS=3D&quot;--coverage&quot;</span><br><span> </s=
pan><br><span> 	AC_SUBST([CODE_COVERAGE_CPPFLAGS])</span><br><span> 	AC_SUB=
ST([CODE_COVERAGE_CFLAGS])</span><br><span>@@ -265,6 +308,10 @@</span><br><=
span> 	AC_SUBST([CODE_COVERAGE_ENABLED], [$enable_code_coverage])</span><br=
><span> 	AC_MSG_RESULT($enable_code_coverage)</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	dnl The lcov test name must no=
t contain dashes or dots</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	CODE_COVERAGE_TEST_NAME=3D`echo &quot;$PACKAGE_NAME-$PACKAGE_VERSION&=
quot; | tr &#39;=2E-&#39; &#39;__&#39;`</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	AC_SUBST([CODE_COVERAGE_TEST_NAME])</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> 	AS_IF([ test &quot;=
x$enable_code_coverage&quot; =3D xyes ], [</span><br><span> 		_AX_CODE_COVE=
RAGE_ENABLED</span><br><span> 	      ])</span><br><span>diff --git a/src/op=
envpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 7ecdd=
ff=2E=2E9424801 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</spa=
n><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -31,9 +31,12=
 @@</span><br><span> 	$(OPTIONAL_SYSTEMD_CFLAGS) \</span><br><span> 	$(OPTI=
ONAL_PKCS11_HELPER_CFLAGS) \</span><br><span> 	$(OPTIONAL_INOTIFY_CFLAGS) \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(CODE_COVERAGE_CF=
LAGS) \</span><br><span> 	-DPLUGIN_LIBDIR=3D\&quot;${plugindir}\&quot; \</s=
pan><br><span> 	-DDEFAULT_DNS_UPDOWN=3D\&quot;${scriptdir}/dns-updown\&quot=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
AM_LDFLAGS =3D $(CODE_COVERAGE_LIBS)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> if WIN32</span><br><span> # we want unic=
ode entry point but not the macro</span><br><span> AM_CFLAGS +=3D -municode=
 -UUNICODE</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1592?usp=3Demail">change 1592</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I79b2dc4a550b1c5068a454=
07976b0dfc2f765b33 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1592 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--gqA+6zGtgJg=--


--===============5488552996450364213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5488552996450364213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5488552996450364213==--

