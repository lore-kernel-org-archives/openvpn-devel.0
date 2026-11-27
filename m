Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D107606A332
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 03:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kWW9hoZx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=izPVFAUi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gBT/qzKC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KJu21gIq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ZMnf90HNHnZMVXftShH72aPeeX2dPiGEjKUpAbFiLUM=; b=kWW9hoZx/IV79KmbWyBGHZdASe
	jVwsB8xGINbuWZF94mPXY5xZS44sX0qLcqsXI0TRxL0A1jYMQLrUfSB0+8nfABCqsbVwEDJvLQrWr
	v22hkgBylcHBWmo1s19cfGAKQ0I7qdeUjZJRgQMO3Yb17kbYSS6MXhpLPULn2xSYlC3U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWmMA-000000001Ko-3NHu;
	Fri, 27 Nov 2026 03:10:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWmM9-000000001Kg-1few
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 03:10:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/HyskeR6ozbIHnRipu/b8nHaSS+vSLQZc3r+j/AoDYA=; b=izPVFAUiqMv/6n/8xvGRCBL787
 7zA96jhAC0fd9rCwDJyI1EOxmaXVKiIrcZUKZb+0kq+lIFDvA1gqY7B9gPqlagA2TvzXIKCXoJOpI
 bql2iaJ7Xbq4nQJ+4CJ0OpYv8yWJfe1LbMl0Kw7WIT3Is8FEuqUa4W8E5W6af8a4A+5Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/HyskeR6ozbIHnRipu/b8nHaSS+vSLQZc3r+j/AoDYA=; b=gBT/qzKC6BhkXlAXrYuOI+4yEy
 XyxJZSi21qD7wjWe20dnQkvdkt7B/oiswUr0ZqiGHdV9woQNTcd+TISSey9X3IgpXoRIZT4tR07k3
 j5elobzggfGff79wC7vgquLFC5HQEJW84r92NslSS+8SNkgS15AWhmz+mtU0NRr8dPaI=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWmM3-000000003B2-0uZz for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 03:10:37 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4ac08f4a0b2so5413454f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 19:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795749025; x=1796353825; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/HyskeR6ozbIHnRipu/b8nHaSS+vSLQZc3r+j/AoDYA=;
 b=KJu21gIq90cCMWz4bk2moSAAUiZ1wvrl7Pm1/2eFxCH2bS+qesLdXEj4beQnufWa+c
 IQarfiZIWlZFP7y9MlffV3ivK52qFUYH228Th4o9EX59Tik7N1VIAqjQ9RiiNOzjKwXa
 K1YDsiiHHzD0eICIDhwGXtBunEMJPURbkV110D634Zmc7qHZbL2cDatqaq7aVt1MkPfU
 c8flNt6Bg9j4YS1IROejwOWj0tOmluv8yp542qQXFENHVF9aDLVf2jne5zPoM7nau2nY
 nrmugLkR0gMBRPB1C2q8X3U0UxIhZb7nmyQ3gE/DHYbL23Vuy6lGLcYVHuT3EtcS4EGi
 JKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795749025; x=1796353825;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/HyskeR6ozbIHnRipu/b8nHaSS+vSLQZc3r+j/AoDYA=;
 b=Rz1nVrSEigduWxncjhaXxdRlEs7hSwCaHhYKqGG7QZ5d1M5CDo6GBPAJMnWPK+KUkK
 h+HCcMaJhRPjQVtaJFUn/emPpSuP87qsuKHTAFNXQuBP+0FF59SOqEcGjUuiDf2gBHAO
 9LLsNyiOPWMghUp5Offejy13lR3D7/VY2acrzIm3ExE0TdVOf7162grFjrXvuknkgSxJ
 KJQowQ1UJ7sX5IC8rkAdMzdbHLF1qXcdsp/Qp+SiqYsJPmF09OVvBz0Pr6rwB8fjW5QV
 i4xBOnzzLnYDYkEB5y/uvs3b9r+mYnprNYzFCW4GWWDrW8hL+2df42qw2218z6DOR6yW
 TUmg==
X-Gm-Message-State: APuU4Z8F4iYB9HneQmeuvGipfPdggXCytXJJgxKPmKySmWjMmzsILU5N
 osgrcOaiDGKXOEuLXB6ApQlNieN4B10gRGsTzLAj7GpLQ+Uqg06rMtCuS+nB4Q66flq+7fQHA2A
 +N53OahiW4ObyWRB7JFTvdHTUYH7Mjaq53AmReMEx7GiAygbS8rz+mhZmAWq2Oa/CXXd9
X-Gm-Gg: AZFdTZe4Ce2ZkrmwoZBGW0J9IjTUIM5dgYBMyf6dfFKkUQg+Tn6sAZjkUwvQ2bq8MYp
 g9iLS09Fa28LHvbGdhbTAUweDsnOdKsNbSJvRnLPwvc4woBh4nXXITp8iieN6klqtC4TeXZpng/
 tCP8uqkdQJnKRLVIhnGEGCttbaCeeHpJAvJgtodEuxYCZstk01OWJCwV8hBllPFOWlfqhYtTEE6
 sn7rpF+nYZd5tQBO6s4wJJVob6fnA9M0QGH27Wmr7eVtWkxiFrnaSnxxgCEgRV2eKoxTWqatglS
 A9j1ReOqpdbgdoYAJJKG+lOsmpkKbh5+SJsSQbEOdnPBa1KXM7FJEWYEW0xSCyeUn66M3xg8jgb
 a8h4hs6qVhGSwVASqgiiPPfy/mWnKK/GK5TdqZgc0pG9ddPfBM6G+0lL7y8qzo1jzmlYgiIjb0m
 bnRbbrW+j7P7HnzTTc/8K+CIjU/oMNbaV5C/ubNm749P+toT1zzyPx5dFT2MXoEbHGjEq4H5Mam
 Q8gA7Zj8Xz3FGlimNIN2Oi8aeEiT4gM0wjqHqeRLXt+dXJNzkF5295oN/y5KvIAIdXh7KTUCKM+
 qtUuRMJW2Nr/CkrkQgmY62ngBqEEqthfgCv7TgSrd5+UdponzZXHN0GobZrBpYiDJ6tRCL7MA4n
 sAoNxXVpBzIMj1SoNYvKWeQGwSIUAbaoVxa7h8bIfjAJmLlIbq+1RJEvIwujb4EVjnM00f24xLq
 g2nvLmTI3yPSFDEUo=
X-Received: by 2002:a5d:5888:0:b0:487:1ac0:32af with SMTP id
 ffacd0b85a97d-4abb47b0fb1mr43549077f8f.51.1795749023987; 
 Thu, 26 Nov 2026 19:10:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab65cb41f4sm42791441f8f.7.2026.11.26.19.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 19:10:23 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 03:10:20 +0000
To: Ralf Lici <ralf@mandelbit.com>,
	Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6
X-Gerrit-Change-Number: 1981
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1981?usp=email>
X-Gerrit-Commit: 02e1598c759109ca5a6c7176aeb6bf03ecbf0cb3
In-Reply-To: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
References: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg2NDUyMDAwLkkwMDUxZWZmZTdmMDYzNmUzMDU1N2Q5Y2U5MmM1MGM0NTgwMDJmOWU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8b202b576c95177c530d8beb96255d438c68b15d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWmM3-000000003B2-0uZz
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: dco: detect local
 kernel capabilities through netlink policies
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, antonio@mandelbit.com
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1968425663579859805=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1968425663579859805==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vTtp8ZEZ2ck="; charset=UTF-8

--vTtp8ZEZ2ck=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori, R=
alf Lici=2E

Hello Arne Schwabe, Ralf Lici, 

I'd like you to reexamine a c=
hange=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?=
usp=3Demail

to look at the new patch set (#4)=2E


Change subject: dco: de=
tect local kernel capabilities through netlink policies
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: detect local kernel capabi=
lities through netlink policies

The ovpn module lives in the kernel, so th=
e attributes it accepts may
differ from what we were built against=2E CTRL_=
CMD_GETPOLICY dumps the
validation policy of a family: which attributes eac=
h command takes, of
what type, and for a nested one the sub-policy that val=
idates it=2E

Add a helper to query it, wrapped in dco_probe_capabilities()=
 so the
rest of the tree never talks to netlink itself=2E Answering a requi=
rement
means following a chain - which policy validates the command, where =
its
nested attribute points if it has one, what type the target attribute
h=
as there=2E One dump of the whole family answers every requirement: it is
r=
ecorded as it arrives and the chains are followed once it is complete=2E

T=
he answer has three values rather than two: without "could not ask", a
netl=
ink error would look the same as a kernel without the feature=2E

The query=
 needs uapi headers from 5=2E10 or later=2E Built against older
ones, it is=
 left out and dco_probe_capabilities() reports no capability=2E

No capabil=
ity is defined yet, so the bitmap comes back empty; the rows
that fill it a=
rrive with the features that need them=2E The unit test
feeds hand-built du=
mps to the pass and checks what each requirement
resolves to=2E

Change-Id:=
 I0051effe7f0636e30557d9ce92c50c458002f9e6
Signed-off-by: Gianmarco De Greg=
ori <gianmarco@mandelbit=2Ecom>
---
M CMakeLists=2Etxt
M config=2Eh=2Ecmake=
=2Ein
M configure=2Eac
M src/openvpn/dco=2Eh
M src/openvpn/dco_freebsd=2Ec
=
M src/openvpn/dco_linux=2Ec
M src/openvpn/dco_win=2Ec
M tests/unit_tests/op=
envpn/Makefile=2Eam
A tests/unit_tests/openvpn/mock_dco_dependencies=2Ec
A =
tests/unit_tests/openvpn/test_dco=2Ec
10 files changed, 1,006 insertions(+)=
, 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/81/1981/4

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
inde=
x 50b2d68=2E=2Ebb2ea0c 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt=

@@ -19,6 +19,7 @@
 include(CheckLinkerFlag OPTIONAL)
 include(CheckTypeSiz=
e)
 include(CheckStructHasMember)
+include(CheckCSourceCompiles)
 include(C=
Test)
 
 option(UNSUPPORTED_BUILDS "Allow unsupported builds" OFF)
@@ -205,=
6 +206,11 @@
     check_symbol_exists(getpeereid "unistd=2Eh;sys/socket=2Eh=
" HAVE_GETPEEREID)
 endif()
 
+if (ENABLE_LINUXDCO)
+    check_c_source_com=
piles("#include <linux/genetlink=2Eh>
+int main(void) { return CTRL_ATTR_OP=
_POLICY; }" HAVE_DECL_CTRL_ATTR_OP_POLICY)
+endif ()
+
 check_include_files=
(grp=2Eh HAVE_GRP_H)
 if (HAVE_GRP_H)
     check_symbol_exists(getgrnam grp=
=2Eh HAVE_GETGRNAM)
@@ -728,6 +734,12 @@
             )
     endif ()
 
+  =
  if (ENABLE_LINUXDCO AND HAVE_DECL_CTRL_ATTR_OP_POLICY)
+        list(APPE=
ND unit_tests
+            "test_dco"
+            )
+    endif ()
+
     i=
f (NOT WIN32 AND ${ENABLE_PKCS11})
         set(_HAVE_SOFTHSM2 YES)
       =
  find_program(P11TOOL p11tool)
@@ -969,6 +981,14 @@
             )
     en=
dif ()
 
+    if (TARGET test_dco)
+        target_sources(test_dco PRIVATE=

+            tests/unit_tests/openvpn/mock_dco_dependencies=2Ec
+         =
   tests/unit_tests/openvpn/mock_get_random=2Ec
+            src/openvpn/fd=
misc=2Ec
+            )
+    endif ()
+
     target_compile_definitions(tes=
t_dhcp PRIVATE DHCP_UNIT_TEST)
     target_sources(test_dhcp PRIVATE
      =
   tests/unit_tests/openvpn/mock_get_random=2Ec
diff --git a/config=2Eh=2Ec=
make=2Ein b/config=2Eh=2Ecmake=2Ein
index f7818cf=2E=2Eaa21532 100644
--- a=
/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -87,6 +87,9 @@
 /=
* Define to 1 if you have the `daemon' function=2E */
 #cmakedefine HAVE_DA=
EMON
 
+/* Define to 1 if linux/genetlink=2Eh has netlink policy introspect=
ion (5=2E10) */
+#cmakedefine01 HAVE_DECL_CTRL_ATTR_OP_POLICY
+
 /* Define =
to 1 if you have the <direct=2Eh> header file=2E */
 #cmakedefine HAVE_DIRE=
CT_H
 
diff --git a/configure=2Eac b/configure=2Eac
index 05fa964=2E=2Eef05=
253 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -664,6 +664,7 @@
 	=
	;;
 esac
 
+dco_unit_tests=3D"no"
 if test "$enable_dco" !=3D "no"; then
 =
	enable_dco_arg=3D"$enable_dco"
 	if test "${enable_iproute2}" =3D "yes"; t=
hen
@@ -692,6 +693,12 @@
 				OPTIONAL_LIBNL_GENL_CFLAGS=3D"${LIBNL_GENL_CF=
LAGS}"
 				OPTIONAL_LIBNL_GENL_LIBS=3D"${LIBNL_GENL_LIBS}"
 
+				dnl
+			=
	dnl Netlink policy introspection needs uapi headers from 5=2E10
+				dnl
+=
				AC_CHECK_DECLS([CTRL_ATTR_OP_POLICY], , , [[#include <linux/genetlink=
=2Eh>]])
+				dco_unit_tests=3D"${ac_cv_have_decl_CTRL_ATTR_OP_POLICY}"
+
 =
				AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
 				AC_=
MSG_NOTICE([Enabled ovpn-dco (via ovpn kernel module) support for Linux])
 =
			fi
@@ -1340,6 +1347,7 @@
 AC_SUBST([PLUGIN_AUTH_PAM_LIBS])
 
 AM_CONDITI=
ONAL([WIN32], [test "${WIN32}" =3D "yes"])
+AM_CONDITIONAL([DCO_UNIT_TESTS]=
, [test "${dco_unit_tests}" =3D "yes"])
 AM_CONDITIONAL([GIT_CHECKOUT], [te=
st "${GIT_CHECKOUT}" =3D "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], =
[test "${enable_plugin_auth_pam}" =3D "yes"])
 AM_CONDITIONAL([ENABLE_PLUGI=
N_DOWN_ROOT], [test "${enable_plugin_down_root}" =3D "yes"])
diff --git a/s=
rc/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index c435f8c=2E=2Eb0a8621 100644
=
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -254,6 +254,17 @@
  =
*/
 bool
 dco_supports_epoch_data(const struct context *c);
+
+/**
+ * Retu=
rn a bitmap of DCO_CAP_* bits describing the negotiable features the
+ * lo=
cal kernel supports=2E Everything DCO does without negotiating is available=

+ * regardless=2E Resolved once and reused; platforms without capability p=
robing
+ * return 0=2E
+ *
+ * @return  bitmask of DCO_CAP_* flags; 0 both =
when the kernel supports none
+ *          of them and when it could not be=
 asked
+ */
+unsigned int dco_probe_capabilities(void);
 #else  /* if defin=
ed(ENABLE_DCO) */
 
 typedef void *dco_context_t;
@@ -388,5 +399,11 @@
 {
 =
    return false;
 }
+
+static inline unsigned int
+dco_probe_capabilities(=
void)
+{
+    return 0;
+}
 #endif /* defined(ENABLE_DCO) */
 #endif /* ifn=
def DCO_H */
diff --git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_fre=
ebsd=2Ec
index 11b8dff=2E=2E9613c63 100644
--- a/src/openvpn/dco_freebsd=2E=
c
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -707,6 +707,12 @@
     return 0;
 }
=
 
+unsigned int
+dco_probe_capabilities(void)
+{
+    return 0;
+}
+
 bool
=
 dco_available(msglvl_t msglevel)
 {
diff --git a/src/openvpn/dco_linux=2Ec=
 b/src/openvpn/dco_linux=2Ec
index 3a55b6e=2E=2Efefc517 100644
--- a/src/op=
envpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -103,6 +103,361 @@
 =
    return ret;
 }
 
+/* What the local kernel supports=2E It cannot change=
 while we run, so the first
+ * caller resolves it and the rest just read i=
t=2E */
+static unsigned int dco_caps =3D 0;
+static bool dco_caps_resolved=
 =3D false;
+
+#if HAVE_DECL_CTRL_ATTR_OP_POLICY
+/*
+ * Netlink policy int=
rospection: the ovpn module lives in the kernel, so the
+ * attributes it a=
ccepts may differ from what we were built against=2E
+ * CTRL_CMD_GETPOLICY=
 says which attributes each command takes and of what type=2E
+ */
+
+/* On=
e row per capability, all resolved from the same dump=2E A row can
+ * only=
 ask for an attribute the dump reports: UNSPEC and REJECT ones never
+ * ap=
pear, and before Linux 7=2E4 neither do BE16/BE32 ones (b785f5c56fb3)=2E */=

+struct ovpn_cap_req
+{
+    unsigned int cap;
+    uint16_t cmd;
+    uin=
t16_t nested_attr; /* 0 if target_attr is not nested */
+    uint16_t targe=
t_attr;
+    int expected_type;
+};
+
+/** the outcome of resolving one cap=
ability requirement */
+enum ovpn_cap_status
+{
+    OVPN_CAP_UNKNOWN,     =
/**< the question could not be asked */
+    OVPN_CAP_SUPPORTED,   /**< the=
 kernel accepts the attribute */
+    OVPN_CAP_UNSUPPORTED, /**< the kernel=
 answered, and does not accept it */
+};
+
+/* The command map is kept with=
 the policies under this index: there `id` is a
+ * command and `nested` th=
e policy of its doit=2E -1 means "not reported"=2E */
+#define OVPN_CAP_CMD=
_MAP (-2)
+
+/* ovpn on Linux 7=2E3 reports 77 links */
+#define OVPN_CAP_I=
NITIAL_LINKS 128
+
+/* inside `policy`, attribute `id` has type `type` and,=
 if nested, is
+ * validated by policy `nested` */
+struct ovpn_cap_link
+{=

+    int policy;
+    uint16_t id;
+    int type;
+    int nested;
+};
+
+=
struct ovpn_cap_query
+{
+    struct ovpn_cap_link *links;
+    size_t n_li=
nks;
+    size_t max_links;
+
+    bool cmd_map; /* the dump carried a comm=
and map */
+    int err;      /* a message we could not parse, or no memory=
 to record it */
+};
+
+static struct nla_policy ovpn_cap_ctrl_policy[CTRL_=
ATTR_MAX + 1] =3D {
+    [CTRL_ATTR_POLICY] =3D { =2Etype =3D NLA_NESTED },=

+    [CTRL_ATTR_OP_POLICY] =3D { =2Etype =3D NLA_NESTED },
+};
+
+static s=
truct nla_policy ovpn_cap_op_policy[CTRL_ATTR_POLICY_DUMP_MAX + 1] =3D {
+ =
   [CTRL_ATTR_POLICY_DO] =3D { =2Etype =3D NLA_U32 },
+};
+
+static struct =
nla_policy ovpn_cap_attr_policy[NL_POLICY_TYPE_ATTR_MAX + 1] =3D {
+    [NL=
_POLICY_TYPE_ATTR_TYPE] =3D { =2Etype =3D NLA_U32 },
+    [NL_POLICY_TYPE_A=
TTR_POLICY_IDX] =3D { =2Etype =3D NLA_U32 },
+};
+
+static int
+ovpn_cap_ad=
d_link(struct ovpn_cap_query *query, int policy, uint16_t id, int type, int=
 nested)
+{
+    if (query->n_links =3D=3D query->max_links)
+    {
+      =
  size_t max_links =3D query->max_links ? 2 * query->max_links : OVPN_CAP_I=
NITIAL_LINKS;
+        struct ovpn_cap_link *links =3D realloc(query->links=
, max_links * sizeof(*links));
+        if (!links)
+        {
+           =
 return -NLE_NOMEM;
+        }
+
+        query->links =3D links;
+        =
query->max_links =3D max_links;
+    }
+
+    query->links[query->n_links++=
] =3D (struct ovpn_cap_link){ policy, id, type, nested };
+
+    return 0;
=
+}
+
+static const struct ovpn_cap_link *
+ovpn_cap_find(const struct ovpn_=
cap_query *query, int policy, uint16_t id)
+{
+    for (size_t i =3D 0; i <=
 query->n_links; i++)
+    {
+        if (query->links[i]=2Epolicy =3D=3D p=
olicy && query->links[i]=2Eid =3D=3D id)
+        {
+            return &qu=
ery->links[i];
+        }
+    }
+
+    return NULL;
+}
+
+/*
+ * One messa=
ge of the dump carries either the command map or a slice of one
+ * policy=
=2E Everything is recorded and the chain is followed only once the
+ * dump=
 is complete, so the order of the messages does not matter=2E
+ */
+static =
int
+ovpn_cap_query_cb(struct nl_msg *msg, void *arg)
+{
+    struct ovpn_c=
ap_query *query =3D arg;
+    struct nlattr *tb[CTRL_ATTR_MAX + 1];
+    co=
nst struct genlmsghdr *ghdr =3D nlmsg_data(nlmsg_hdr(msg));
+
+    query->e=
rr =3D nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+           =
                genlmsg_attrlen(ghdr, 0), ovpn_cap_ctrl_policy);
+    if (q=
uery->err)
+    {
+        return NL_STOP;
+    }
+
+    /* CTRL_ATTR_OP_PO=
LICY: which policy validates the doit of each command */
+    if (tb[CTRL_A=
TTR_OP_POLICY])
+    {
+        const struct nlattr *nla_cmd;
+        int =
rem_cmd;
+
+        query->cmd_map =3D true;
+
+        nla_for_each_nested=
(nla_cmd, tb[CTRL_ATTR_OP_POLICY], rem_cmd)
+        {
+            struct =
nlattr *tb_cmd[CTRL_ATTR_POLICY_DUMP_MAX + 1];
+
+            query->err =
=3D nla_parse(tb_cmd, CTRL_ATTR_POLICY_DUMP_MAX, nla_data(nla_cmd),
+      =
                             nla_len(nla_cmd), ovpn_cap_op_policy);
+      =
      if (query->err)
+            {
+                return NL_STOP;
+    =
        }
+
+            if (tb_cmd[CTRL_ATTR_POLICY_DO])
+            {
+ =
               query->err =3D ovpn_cap_add_link(query, OVPN_CAP_CMD_MAP, (u=
int16_t)nla_type(nla_cmd),
+                                               =
-1, (int)nla_get_u32(tb_cmd[CTRL_ATTR_POLICY_DO]));
+                if (qu=
ery->err)
+                {
+                    return NL_STOP;
+        =
        }
+            }
+        }
+    }
+
+    /* CTRL_ATTR_POLICY: whic=
h attributes each policy accepts */
+    if (!tb[CTRL_ATTR_POLICY])
+    {
=
+        return NL_OK;
+    }
+
+    const struct nlattr *nla_policy;
+    =
int rem_policy;
+
+    nla_for_each_nested(nla_policy, tb[CTRL_ATTR_POLICY]=
, rem_policy)
+    {
+        struct nlattr *nla_attr;
+        int rem_att=
r;
+        int policy_id =3D nla_type(nla_policy);
+
+        nla_for_each=
_nested(nla_attr, nla_policy, rem_attr)
+        {
+            struct nlat=
tr *tb_attr[NL_POLICY_TYPE_ATTR_MAX + 1];
+            int attr_id =3D nla_=
type(nla_attr);
+            int type =3D -1;
+            int nested =3D -=
1;
+
+            query->err =3D nla_parse_nested(tb_attr, NL_POLICY_TYPE_A=
TTR_MAX, nla_attr,
+                                          ovpn_cap_attr=
_policy);
+            if (query->err)
+            {
+                retu=
rn NL_STOP;
+            }
+
+            if (tb_attr[NL_POLICY_TYPE_ATTR_T=
YPE])
+            {
+                type =3D (int)nla_get_u32(tb_attr[NL_=
POLICY_TYPE_ATTR_TYPE]);
+            }
+            if (tb_attr[NL_POLICY_=
TYPE_ATTR_POLICY_IDX])
+            {
+                nested =3D (int)nla_=
get_u32(tb_attr[NL_POLICY_TYPE_ATTR_POLICY_IDX]);
+            }
+
+       =
     query->err =3D ovpn_cap_add_link(query, policy_id, (uint16_t)attr_id, =
type, nested);
+            if (query->err)
+            {
+               =
 return NL_STOP;
+            }
+        }
+    }
+
+    return NL_OK;
+}
+=

+/* Dump the policies of the family into query->links=2E Returns 0, or the=

+ * netlink error that kept us from reading it all=2E */
+static int
+ovpn=
_cap_ask(struct ovpn_cap_query *query)
+{
+    struct nl_msg *nl_msg =3D NU=
LL;
+    int ret =3D 0;
+
+    struct nl_sock *nl_sock =3D nl_socket_alloc(=
);
+    if (!nl_sock)
+    {
+        return -NLE_NOMEM;
+    }
+
+    ret =
=3D genl_connect(nl_sock);
+    if (ret < 0)
+    {
+        goto out;
+   =
 }
+    set_cloexec(nl_socket_get_fd(nl_sock));
+
+    nl_msg =3D nlmsg_all=
oc();
+    if (!nl_msg)
+    {
+        ret =3D -NLE_NOMEM;
+        goto o=
ut;
+    }
+
+    /* nlctrl has a fixed family id, so there is nothing to r=
esolve first=2E
+     * Unlike CTRL_CMD_GETFAMILY, CTRL_CMD_GETPOLICY does =
not load the module:
+     * this relies on dco_available() having resolved=
 the family already=2E */
+    if (!genlmsg_put(nl_msg, NL_AUTO_PORT, NL_AU=
TO_SEQ, GENL_ID_CTRL, 0, NLM_F_DUMP,
+                     CTRL_CMD_GETPOLI=
CY, 0))
+    {
+        ret =3D -NLE_MSGSIZE;
+        goto out;
+    }
+
+=
    ret =3D nla_put_string(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_FAMILY_NAME)=
;
+    if (ret < 0)
+    {
+        goto out;
+    }
+
+    ret =3D nl_sock=
et_modify_cb(nl_sock, NL_CB_VALID, NL_CB_CUSTOM, ovpn_cap_query_cb, query);=

+    if (ret < 0)
+    {
+        goto out;
+    }
+
+    ret =3D nl_send_=
auto(nl_sock, nl_msg);
+    if (ret < 0)
+    {
+        goto out;
+    }
+=

+    ret =3D nl_recvmsgs_default(nl_sock);
+    if (ret >=3D 0)
+    {
+  =
      ret =3D query->err;
+    }
+
+out:
+    nlmsg_free(nl_msg);
+    nl_s=
ocket_free(nl_sock);
+
+    return ret < 0 ? ret : 0;
+}
+
+/*
+ * Decide w=
hether the kernel supports the requirement, from the links the pass
+ * col=
lected=2E A link the kernel never mentioned is a no=2E A dump without a
+ *=
 command map is not an answer either way, and is reported as such, but the
=
+ * capability stays off just the same=2E
+ */
+static enum ovpn_cap_status=

+ovpn_cap_resolve(const struct ovpn_cap_query *query, const struct ovpn_ca=
p_req *req)
+{
+    /* no command map: the dump cannot say which policy val=
idates the command */
+    if (!query->cmd_map)
+    {
+        return OVPN=
_CAP_UNKNOWN;
+    }
+
+    /* a link is missing: the command, the containe=
r or the target is not there */
+    const struct ovpn_cap_link *link =3D o=
vpn_cap_find(query, OVPN_CAP_CMD_MAP, req->cmd);
+    if (link && req->nest=
ed_attr)
+    {
+        link =3D ovpn_cap_find(query, link->nested, req->n=
ested_attr);
+    }
+    if (link)
+    {
+        link =3D ovpn_cap_find(q=
uery, link->nested, req->target_attr);
+    }
+    if (!link)
+    {
+     =
   return OVPN_CAP_UNSUPPORTED;
+    }
+
+    /* the whole chain is there: =
a yes only if the attribute has the type we
+     * would be writing into i=
t */
+    return (link->type =3D=3D req->expected_type) ? OVPN_CAP_SUPPORTE=
D : OVPN_CAP_UNSUPPORTED;
+}
+
+unsigned int
+dco_probe_capabilities(void)
=
+{
+    if (dco_caps_resolved)
+    {
+        return dco_caps;
+    }
+
+ =
   /* no capability is defined yet: resolve one whose answer we already kno=
w */
+    static const struct ovpn_cap_req self_test =3D { 0, OVPN_CMD_PEER=
_NEW, OVPN_A_PEER,
+                                                   OVPN=
_A_PEER_ID, NL_ATTR_TYPE_U32 };
+    struct ovpn_cap_query query;
+    CLEA=
R(query);
+    int err =3D ovpn_cap_ask(&query);
+    enum ovpn_cap_status =
status =3D err ? OVPN_CAP_UNKNOWN : ovpn_cap_resolve(&query, &self_test);
+=
    free(query=2Elinks);
+
+    msg(D_DCO_DEBUG, "%s: policy introspection =
self-test: %s (status %d, err %d)", __func__,
+        status =3D=3D OVPN_C=
AP_SUPPORTED ? "ok" : "unexpected", (int)status, err);
+
+    dco_caps_reso=
lved =3D true;
+    msg(D_DCO_DEBUG, "%s: DCO local capabilities: 0x%x", __=
func__, dco_caps);
+
+    return dco_caps;
+}
+
+#else  /* if HAVE_DECL_CTR=
L_ATTR_OP_POLICY */
+
+unsigned int
+dco_probe_capabilities(void)
+{
+    i=
f (!dco_caps_resolved)
+    {
+        msg(D_DCO_DEBUG,
+            "%s: b=
uilt without netlink policy introspection, no DCO capability can be detecte=
d",
+            __func__);
+        dco_caps_resolved =3D true;
+    }
+
+=
    return dco_caps;
+}
+
+#endif /* if HAVE_DECL_CTRL_ATTR_OP_POLICY */
+
=
 static struct nl_msg *
 ovpn_dco_nlmsg_create(const dco_context_t *dco, ui=
nt8_t cmd)
 {
@@ -428,6 +783,12 @@
 {
     dco->ovpn_dco_id =3D resolve_ovp=
n_netlink_id(M_FATAL);
 
+    /* nothing consumes the bitmap yet; resolve i=
t here to exercise the path */
+    if (check_debug_level(D_DCO_DEBUG))
+  =
  {
+        dco_probe_capabilities();
+    }
+
     dco->nl_sock =3D nl_so=
cket_alloc();
 
     if (!dco->nl_sock)
diff --git a/src/openvpn/dco_win=2E=
c b/src/openvpn/dco_win=2Ec
index 6074552=2E=2E0f2b9eb 100644
--- a/src/ope=
nvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -612,6 +612,12 @@
     re=
turn 0;
 }
 
+unsigned int
+dco_probe_capabilities(void)
+{
+    return 0;
=
+}
+
 bool
 dco_available(msglvl_t msglevel)
 {
diff --git a/tests/unit_tes=
ts/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index e34=
04754=2E=2Ed1dfac9 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ =
b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -40,6 +40,12 @@
 endif
 endif
 =

+if HAVE_SITNL
+if DCO_UNIT_TESTS
+test_binaries +=3D dco_testdriver
+endi=
f
+endif
+
 if !CROSS_COMPILING
 TESTS =3D $(test_binaries)
 endif
@@ -452,=
4 +458,16 @@
 	$(top_srcdir)/src/openvpn/run_command=2Ec \
 	$(top_srcdir)/=
src/openvpn/socket_util=2Ec
 
+dco_testdriver_CFLAGS  =3D \
+	-I$(top_srcdi=
r)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST=
_CFLAGS@ $(OPTIONAL_CRYPTO_CFLAGS)
+dco_testdriver_LDFLAGS =3D @TEST_LDFLAG=
S@ $(OPTIONAL_CRYPTO_LIBS)
+dco_testdriver_SOURCES =3D test_dco=2Ec \
+	moc=
k_msg=2Ec mock_msg=2Eh mock_dco_dependencies=2Ec mock_get_random=2Ec test_c=
ommon=2Eh \
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
+	$(top_srcdir)=
/src/openvpn/buffer=2Ec \
+	$(top_srcdir)/src/openvpn/fdmisc=2Ec \
+	$(top_=
srcdir)/src/openvpn/platform=2Ec \
+	$(top_srcdir)/src/openvpn/win32-util=
=2Ec
+
 build-tests-local: $(check_PROGRAMS)
diff --git a/tests/unit_tests/=
openvpn/mock_dco_dependencies=2Ec b/tests/unit_tests/openvpn/mock_dco_depen=
dencies=2Ec
new file mode 100644
index 0000000=2E=2Ee7f20f5
--- /dev/null
+=
++ b/tests/unit_tests/openvpn/mock_dco_dependencies=2Ec
@@ -0,0 +1,80 @@
+/=
*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *        =
     over a single UDP port, with support for SSL/TLS-based
+ *            =
 session authentication and key exchange,
+ *             packet encryption=
, packet authentication, and
+ *             packet compression=2E
+ *
+ * =
 Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (=
C) 2026 Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
+ *
+ *  This prog=
ram is free software; you can redistribute it and/or modify
+ *  it under t=
he terms of the GNU General Public License version 2
+ *  as published by t=
he Free Software Foundation=2E
+ *
+ *  This program is distributed in the =
hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *=
  You should have received a copy of the GNU General Public License along
+=
 *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+=
 */
+
+/*
+ *  Stubs for what dco_linux=2Ec drags in but capability probing=
 never reaches:
+ *  the data path, the event loop and the signal machinery=
=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include=
 "syshead=2Eh"
+#include "dco=2Eh"
+#include "crypto_backend=2Eh"
+#include=
 "forward=2Eh"
+#include "multi=2Eh"
+#include "networking=2Eh"
+#include "=
socket_util=2Eh"
+
+void
+multi_process_incoming_dco(dco_context_t *dco)
+{=

+}
+
+void
+process_incoming_dco(dco_context_t *dco)
+{
+}
+
+void
+regist=
er_signal(struct signal_info *si, int signum, const char *signal_text)
+{
+=
}
+
+int
+net_iface_new(const openvpn_net_ctx_t *ctx, const openvpn_net_ifa=
ce_t *iface, const char *type,
+              const void *arg)
+{
+    retu=
rn 0;
+}
+
+int
+net_iface_del(const openvpn_net_ctx_t *ctx, const openvpn_=
net_iface_t *iface)
+{
+    return 0;
+}
+
+unsigned int
+cipher_kt_key_siz=
e(const char *ciphername)
+{
+    return 0;
+}
+
+const char *
+print_socka=
ddr_ex(const struct sockaddr *addr, const char *separator, const unsigned i=
nt flags,
+                  struct gc_arena *gc)
+{
+    return "[mock]";
=
+}
diff --git a/tests/unit_tests/openvpn/test_dco=2Ec b/tests/unit_tests/op=
envpn/test_dco=2Ec
new file mode 100644
index 0000000=2E=2Ebd874bf
--- /dev=
/null
+++ b/tests/unit_tests/openvpn/test_dco=2Ec
@@ -0,0 +1,487 @@
+/*
+ *=
  OpenVPN -- An application to securely tunnel IP networks
+ *             =
over a single UDP port, with support for SSL/TLS-based
+ *             sess=
ion authentication and key exchange,
+ *             packet encryption, pac=
ket authentication, and
+ *             packet compression=2E
+ *
+ *  Copy=
right (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 20=
26 Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
+ *
+ *  This program i=
s free software; you can redistribute it and/or modify
+ *  it under the te=
rms of the GNU General Public License version 2
+ *  as published by the Fr=
ee Software Foundation=2E
+ *
+ *  This program is distributed in the hope =
that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the imp=
lied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  Y=
ou should have received a copy of the GNU General Public License along
+ * =
 with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */=

+
+/*
+ *  Unit tests for the DCO capability queries=2E
+ *
+ *  Resolving=
 a requirement is a pass over a policy dump that records what it
+ *  repor=
ts, followed by a walk along what the pass recorded=2E The pass is fed
+ * =
 dumps built by hand, which cover what would otherwise need a particular
+ =
*  kernel=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
=
+#include "syshead=2Eh"
+
+#include <stdarg=2Eh>
+#include <setjmp=2Eh>
+#i=
nclude <cmocka=2Eh>
+
+#include "dco_linux=2Ec"
+
+#define CMD_POLICY   4
+=
#define SUB_POLICY   9
+#define OTHER_POLICY 7
+
+/* the bit is never read =
here, only the chain that would set it */
+static const struct ovpn_cap_req=
 test_req =3D { =2Ecap =3D 1u,
+                                           =
   =2Ecmd =3D OVPN_CMD_PEER_NEW,
+                                         =
     =2Enested_attr =3D OVPN_A_PEER,
+                                     =
         =2Etarget_attr =3D OVPN_A_PEER_KEEPALIVE_INTERVAL,
+              =
                                =2Eexpected_type =3D NL_ATTR_TYPE_U32 };
+
=
+/* the same requirement without a container: the target sits in the comman=
d's
+ * own policy */
+static const struct ovpn_cap_req flat_req =3D { =2Ec=
ap =3D 1u,
+                                              =2Ecmd =3D OVPN_C=
MD_PEER_NEW,
+                                              =2Enested_attr =
=3D 0,
+                                              =2Etarget_attr =3D OV=
PN_A_IFINDEX,
+                                              =2Eexpected_ty=
pe =3D NL_ATTR_TYPE_U32 };
+
+static struct ovpn_cap_query
+new_query(void)=

+{
+    struct ovpn_cap_query query;
+
+    CLEAR(query);
+    return quer=
y;
+}
+
+/* a CTRL_ATTR_OP_POLICY message saying which policy validates `cm=
d` */
+static struct nl_msg *
+msg_op_policy(uint16_t cmd, uint32_t do_poli=
cy)
+{
+    struct nl_msg *msg =3D nlmsg_alloc();
+    struct nlattr *ops, =
*op;
+
+    assert_non_null(msg);
+    assert_non_null(genlmsg_put(msg, NL_=
AUTO_PORT, NL_AUTO_SEQ, 0, 0, 0, CTRL_CMD_GETPOLICY, 0));
+
+    ops =3D nl=
a_nest_start(msg, CTRL_ATTR_OP_POLICY);
+    op =3D nla_nest_start(msg, cmd=
);
+    assert_int_equal(nla_put_u32(msg, CTRL_ATTR_POLICY_DO, do_policy), =
0);
+    nla_nest_end(msg, op);
+    nla_nest_end(msg, ops);
+
+    return =
msg;
+}
+
+/* one attribute of a policy: its id, which field of its descrip=
tor to set,
+ * and the value to put there */
+struct attr_desc
+{
+    uin=
t16_t attr_id;
+    int field;
+    uint32_t value;
+};
+
+/* a CTRL_ATTR_P=
OLICY message describing `n` attributes of one policy */
+static struct nl_=
msg *
+msg_policy_attrs(uint16_t policy_id, const struct attr_desc *descs, =
size_t n)
+{
+    struct nl_msg *msg =3D nlmsg_alloc();
+    struct nlattr =
*policies, *policy, *attr;
+
+    assert_non_null(msg);
+    assert_non_nul=
l(genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, 0, 0, 0, CTRL_CMD_GETPOLICY, =
0));
+
+    policies =3D nla_nest_start(msg, CTRL_ATTR_POLICY);
+    policy=
 =3D nla_nest_start(msg, policy_id);
+    for (size_t i =3D 0; i < n; i++)
=
+    {
+        attr =3D nla_nest_start(msg, descs[i]=2Eattr_id);
+        =
assert_int_equal(nla_put_u32(msg, descs[i]=2Efield, descs[i]=2Evalue), 0);
=
+        nla_nest_end(msg, attr);
+    }
+    nla_nest_end(msg, policy);
+ =
   nla_nest_end(msg, policies);
+
+    return msg;
+}
+
+/* the shape the k=
ernel actually sends: one attribute per message */
+static struct nl_msg *
=
+msg_policy_attr(uint16_t policy_id, uint16_t attr_id, int field, uint32_t =
value)
+{
+    const struct attr_desc one =3D { attr_id, field, value };
+
=
+    return msg_policy_attrs(policy_id, &one, 1);
+}
+
+static void
+feed(s=
truct ovpn_cap_query *query, struct nl_msg *msg)
+{
+    assert_int_equal(o=
vpn_cap_query_cb(msg, query), NL_OK);
+    nlmsg_free(msg);
+}
+
+/* Walk t=
he whole chain, with both policies carrying attributes we are not
+ * after=
 and the ones we are neither first nor last, so that the pass has to
+ * sk=
ip past them rather than stop at the first mismatch=2E */
+static void
+fee=
d_full_chain(struct ovpn_cap_query *query)
+{
+    const struct attr_desc c=
md_attrs[] =3D {
+        { OVPN_A_IFINDEX, NL_POLICY_TYPE_ATTR_TYPE, NL_AT=
TR_TYPE_U32 },
+        { OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX, SUB_=
POLICY },
+        { OVPN_A_KEYCONF, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE=
_NESTED },
+    };
+    const struct attr_desc sub_attrs[] =3D {
+        {=
 OVPN_A_PEER_ID, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U32 },
+        { O=
VPN_A_PEER_REMOTE_PORT, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U16 },
+    =
    { test_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U32 },=

+        { OVPN_A_PEER_LOCAL_PORT, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_=
U16 },
+    };
+
+    feed(query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLI=
CY));
+    feed(query, msg_policy_attrs(CMD_POLICY, cmd_attrs, SIZE(cmd_att=
rs)));
+    feed(query, msg_policy_attrs(SUB_POLICY, sub_attrs, SIZE(sub_at=
trs)));
+}
+
+/* the map tells us which policy validates the command we ask=
ed about */
+static void
+test_reads_command_policy(void **state)
+{
+    s=
truct ovpn_cap_query query =3D new_query();
+
+    feed(&query, msg_op_poli=
cy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    const struct ovpn_cap_link *link =
=3D ovpn_cap_find(&query, OVPN_CAP_CMD_MAP, OVPN_CMD_PEER_NEW);
+    assert=
_non_null(link);
+    assert_int_equal(link->nested, CMD_POLICY);
+    free=
(query=2Elinks);
+}
+
+/* and not about another one */
+static void
+test_i=
gnores_other_command(void **state)
+{
+    struct ovpn_cap_query query =3D =
new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_DEL, CMD_POLIC=
Y));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_T=
YPE_ATTR_POLICY_IDX,
+                                 SUB_POLICY));
+    f=
eed(&query, msg_policy_attr(SUB_POLICY, test_req=2Etarget_attr, NL_POLICY_T=
YPE_ATTR_TYPE,
+                                 NL_ATTR_TYPE_U32));
+    a=
ssert_int_equal(ovpn_cap_resolve(&query, &test_req), OVPN_CAP_UNSUPPORTED);=

+    free(query=2Elinks);
+}
+
+/* the nested attribute of that policy poi=
nts at the sub-policy */
+static void
+test_follows_nested_attribute(void *=
*state)
+{
+    struct ovpn_cap_query query =3D new_query();
+
+    feed(&q=
uery, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_=
policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+     =
                            SUB_POLICY));
+    const struct ovpn_cap_link *=
link =3D ovpn_cap_find(&query, CMD_POLICY, OVPN_A_PEER);
+    assert_non_nu=
ll(link);
+    assert_int_equal(link->nested, SUB_POLICY);
+    free(query=
=2Elinks);
+}
+
+/* an attribute id only means something inside its own pol=
icy, so the same
+ * number elsewhere says nothing about our question: a co=
mmand policy without
+ * the container is a no, whatever comes after it */
=
+static void
+test_ignores_nested_attribute_elsewhere(void **state)
+{
+   =
 struct ovpn_cap_query query =3D new_query();
+
+    feed(&query, msg_op_po=
licy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD=
_POLICY, OVPN_A_IFINDEX, NL_POLICY_TYPE_ATTR_TYPE,
+                       =
          NL_ATTR_TYPE_U32));
+    feed(&query, msg_policy_attr(OTHER_POLIC=
Y, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                          =
       SUB_POLICY));
+    feed(&query, msg_policy_attr(SUB_POLICY, test_req=
=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                                =
 NL_ATTR_TYPE_U32));
+    assert_int_equal(ovpn_cap_resolve(&query, &test_r=
eq), OVPN_CAP_UNSUPPORTED);
+    free(query=2Elinks);
+}
+
+/* the type of =
the target attribute is read in the sub-policy */
+static void
+test_reads_=
target_type(void **state)
+{
+    struct ovpn_cap_query query =3D new_query=
();
+
+    feed_full_chain(&query);
+    const struct ovpn_cap_link *link =
=3D ovpn_cap_find(&query, SUB_POLICY, test_req=2Etarget_attr);
+    assert_=
non_null(link);
+    assert_int_equal(link->type, NL_ATTR_TYPE_U32);
+    f=
ree(query=2Elinks);
+}
+
+/* and the same holds for the target attribute: a=
 type read off some other
+ * policy is not an answer to what we asked */
+=
static void
+test_ignores_target_attribute_elsewhere(void **state)
+{
+    =
struct ovpn_cap_query query =3D new_query();
+
+    feed(&query, msg_op_pol=
icy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_=
POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                     =
            SUB_POLICY));
+    feed(&query, msg_policy_attr(OTHER_POLICY, t=
est_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                         =
        NL_ATTR_TYPE_U32));
+    assert_int_equal(ovpn_cap_resolve(&query, =
&test_req), OVPN_CAP_UNSUPPORTED);
+    free(query=2Elinks);
+}
+
+/* the c=
ommand's own policy does get read, so the target attribute has to be
+ * tu=
rned away there too: the same id there is a different attribute */
+static =
void
+test_ignores_target_attribute_in_command_policy(void **state)
+{
+   =
 struct ovpn_cap_query query =3D new_query();
+
+    feed(&query, msg_op_po=
licy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD=
_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                    =
             SUB_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, te=
st_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                          =
       NL_ATTR_TYPE_U32));
+    assert_int_equal(ovpn_cap_resolve(&query, &=
test_req), OVPN_CAP_UNSUPPORTED);
+    free(query=2Elinks);
+}
+
+/* the su=
b-policy is read too, so the nested attribute has to be turned away
+ * the=
re as well */
+static void
+test_ignores_nested_attribute_in_sub_policy(voi=
d **state)
+{
+    struct ovpn_cap_query query =3D new_query();
+
+    feed=
(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, m=
sg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+  =
                               SUB_POLICY));
+    feed(&query, msg_policy_a=
ttr(SUB_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+             =
                    OTHER_POLICY));
+    feed(&query, msg_policy_attr(OTHER=
_POLICY, test_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,
+               =
                  NL_ATTR_TYPE_U32));
+    assert_int_equal(ovpn_cap_resolv=
e(&query, &test_req), OVPN_CAP_UNSUPPORTED);
+    free(query=2Elinks);
+}
+=

+/* an attribute that is there but not as a nest has nothing to follow */
=
+static void
+test_nested_attribute_without_policy_idx(void **state)
+{
+  =
  struct ovpn_cap_query query =3D new_query();
+
+    feed(&query, msg_op_p=
olicy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CM=
D_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_TYPE,
+                         =
        NL_ATTR_TYPE_U32));
+    feed(&query, msg_policy_attr(SUB_POLICY, t=
est_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                         =
        NL_ATTR_TYPE_U32));
+    assert_int_equal(ovpn_cap_resolve(&query, =
&test_req), OVPN_CAP_UNSUPPORTED);
+    free(query=2Elinks);
+}
+
+/* and o=
ne that is a nest says nothing about the type we are after */
+static void
=
+test_target_attribute_without_type(void **state)
+{
+    struct ovpn_cap_q=
uery query =3D new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER=
_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_A_PE=
ER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                                 SUB_P=
OLICY));
+    feed(&query, msg_policy_attr(SUB_POLICY, test_req=2Etarget_at=
tr,
+                                 NL_POLICY_TYPE_ATTR_POLICY_IDX, OTHER=
_POLICY));
+    assert_int_equal(ovpn_cap_resolve(&query, &test_req), OVPN_=
CAP_UNSUPPORTED);
+    free(query=2Elinks);
+}
+
+/* a flat requirement nee=
ds no hop: the command's policy is where to look */
+static void
+test_flat=
_requirement_reads_command_policy(void **state)
+{
+    struct ovpn_cap_que=
ry query =3D new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_N=
EW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, flat_req=2E=
target_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL=
_ATTR_TYPE_U32));
+    assert_int_equal(ovpn_cap_resolve(&query, &flat_req)=
, OVPN_CAP_SUPPORTED);
+    free(query=2Elinks);
+}
+
+/* and an absent one=
 is a plain no */
+static void
+test_flat_requirement_absent_is_unsupported=
(void **state)
+{
+    struct ovpn_cap_query query =3D new_query();
+
+    =
feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&quer=
y, msg_policy_attr(OTHER_POLICY, flat_req=2Etarget_attr, NL_POLICY_TYPE_ATT=
R_TYPE,
+                                 NL_ATTR_TYPE_U32));
+    assert_i=
nt_equal(ovpn_cap_resolve(&query, &flat_req), OVPN_CAP_UNSUPPORTED);
+    f=
ree(query=2Elinks);
+}
+
+/* a message we cannot parse stops the pass with =
an error, rather than
+ * leaving a hole that would read as a no */
+static=
 void
+test_malformed_message_stops(void **state)
+{
+    struct ovpn_cap_q=
uery query =3D new_query();
+    struct nl_msg *msg =3D nlmsg_alloc();
+   =
 struct nlattr *ops, *op;
+
+    assert_non_null(msg);
+    assert_non_null=
(genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, 0, 0, 0, CTRL_CMD_GETPOLICY, 0=
));
+    ops =3D nla_nest_start(msg, CTRL_ATTR_OP_POLICY);
+    op =3D nla_=
nest_start(msg, OVPN_CMD_PEER_NEW);
+    assert_int_equal(nla_put_u16(msg, =
CTRL_ATTR_POLICY_DO, CMD_POLICY), 0);
+    nla_nest_end(msg, op);
+    nla_=
nest_end(msg, ops);
+
+    assert_int_equal(ovpn_cap_query_cb(msg, &query),=
 NL_STOP);
+    assert_true(query=2Eerr < 0);
+    assert_int_equal(query=
=2En_links, 0);
+    nlmsg_free(msg);
+    free(query=2Elinks);
+}
+
+/* no=
thing to read an answer out of is not the same as a "no" */
+static void
+t=
est_resolve_without_command_policy(void **state)
+{
+    struct ovpn_cap_qu=
ery query =3D new_query();
+
+    assert_int_equal(ovpn_cap_resolve(&query,=
 &test_req), OVPN_CAP_UNKNOWN);
+}
+
+/* a kernel that does not nest the at=
tribute simply never mentions it */
+static void
+test_resolve_nested_absen=
t(void **state)
+{
+    struct ovpn_cap_query query =3D new_query();
+
+   =
 feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    assert_in=
t_equal(ovpn_cap_resolve(&query, &test_req), OVPN_CAP_UNSUPPORTED);
+    fr=
ee(query=2Elinks);
+}
+
+/* the sub-policy is there but does not define the=
 attribute: the ordinary no */
+static void
+test_resolve_target_absent(voi=
d **state)
+{
+    struct ovpn_cap_query query =3D new_query();
+
+    feed=
(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, m=
sg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+  =
                               SUB_POLICY));
+    assert_int_equal(ovpn_cap=
_resolve(&query, &test_req), OVPN_CAP_UNSUPPORTED);
+    free(query=2Elinks=
);
+}
+
+/* right name, wrong type: not the attribute we would be writing *=
/
+static void
+test_resolve_wrong_type(void **state)
+{
+    struct ovpn_c=
ap_query query =3D new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_=
PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_=
A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                                 S=
UB_POLICY));
+    feed(&query, msg_policy_attr(SUB_POLICY, test_req=2Etarge=
t_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL_ATTR=
_TYPE_U8));
+    assert_int_equal(ovpn_cap_resolve(&query, &test_req), OVPN=
_CAP_UNSUPPORTED);
+    free(query=2Elinks);
+}
+
+/* and the whole chain, =
from a dump to a yes */
+static void
+test_resolve_complete_chain(void **st=
ate)
+{
+    struct ovpn_cap_query query =3D new_query();
+
+    feed_full_=
chain(&query);
+    assert_int_equal(ovpn_cap_resolve(&query, &test_req), O=
VPN_CAP_SUPPORTED);
+    free(query=2Elinks);
+}
+
+/* the kernel's order i=
s not relied upon */
+static void
+test_resolve_any_order(void **state)
+{
=
+    struct ovpn_cap_query query =3D new_query();
+
+    feed(&query, msg_p=
olicy_attr(SUB_POLICY, test_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,
+ =
                                NL_ATTR_TYPE_U32));
+    feed(&query, msg_p=
olicy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+      =
                           SUB_POLICY));
+    feed(&query, msg_op_policy(OV=
PN_CMD_PEER_NEW, CMD_POLICY));
+    assert_int_equal(ovpn_cap_resolve(&quer=
y, &test_req), OVPN_CAP_SUPPORTED);
+    free(query=2Elinks);
+}
+
+/* a du=
mp larger than the first allocation */
+static void
+test_resolve_large_dum=
p(void **state)
+{
+    struct ovpn_cap_query query =3D new_query();
+
+   =
 for (uint16_t attr_id =3D 1; attr_id <=3D 3 * OVPN_CAP_INITIAL_LINKS; attr=
_id++)
+    {
+        feed(&query, msg_policy_attr(OTHER_POLICY, attr_id, =
NL_POLICY_TYPE_ATTR_TYPE,
+                                     NL_ATTR_TYP=
E_U32));
+    }
+    feed_full_chain(&query);
+    assert_true(query=2En_li=
nks <=3D query=2Emax_links);
+    assert_int_equal(ovpn_cap_resolve(&query,=
 &test_req), OVPN_CAP_SUPPORTED);
+    free(query=2Elinks);
+}
+
+int
+main=
(void)
+{
+    const struct CMUnitTest tests[] =3D {
+        cmocka_unit_t=
est(test_reads_command_policy),
+        cmocka_unit_test(test_ignores_othe=
r_command),
+        cmocka_unit_test(test_follows_nested_attribute),
+    =
    cmocka_unit_test(test_ignores_nested_attribute_elsewhere),
+        cmo=
cka_unit_test(test_reads_target_type),
+        cmocka_unit_test(test_ignor=
es_target_attribute_elsewhere),
+        cmocka_unit_test(test_ignores_targ=
et_attribute_in_command_policy),
+        cmocka_unit_test(test_ignores_nes=
ted_attribute_in_sub_policy),
+        cmocka_unit_test(test_nested_attribu=
te_without_policy_idx),
+        cmocka_unit_test(test_target_attribute_wit=
hout_type),
+        cmocka_unit_test(test_flat_requirement_reads_command_p=
olicy),
+        cmocka_unit_test(test_flat_requirement_absent_is_unsupport=
ed),
+        cmocka_unit_test(test_malformed_message_stops),
+        cmoc=
ka_unit_test(test_resolve_without_command_policy),
+        cmocka_unit_tes=
t(test_resolve_nested_absent),
+        cmocka_unit_test(test_resolve_targe=
t_absent),
+        cmocka_unit_test(test_resolve_wrong_type),
+        cmo=
cka_unit_test(test_resolve_complete_chain),
+        cmocka_unit_test(test_=
resolve_any_order),
+        cmocka_unit_test(test_resolve_large_dump),
+  =
  };
+
+    return cmocka_run_group_tests_name("dco", tests, NULL, NULL);
+=
}

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0051effe7f=
0636e30557d9ce92c50c458002f9e6
Gerrit-Change-Number: 1981
Gerrit-PatchSet: =
4
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Rev=
iewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ralf Lici=
 <ralf@mandelbit=2Ecom>
Gerrit-CC: Antonio Quartulli <antonio@mandelbit=2Ec=
om>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gia=
nmarco@mandelbit=2Ecom>

--vTtp8ZEZ2ck=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori, Ralf Lici=2E </p>=

<p>Gianmarco De Gregori <strong>uploaded patch set #4</strong> to this cha=
nge=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=
=3Demail">View Change</a></p><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">dco: detect local kernel capabil=
ities through netlink policies<br><br>The ovpn module lives in the kernel, =
so the attributes it accepts may<br>differ from what we were built against=
=2E CTRL_CMD_GETPOLICY dumps the<br>validation policy of a family: which at=
tributes each command takes, of<br>what type, and for a nested one the sub-=
policy that validates it=2E<br><br>Add a helper to query it, wrapped in dco=
_probe_capabilities() so the<br>rest of the tree never talks to netlink its=
elf=2E Answering a requirement<br>means following a chain - which policy va=
lidates the command, where its<br>nested attribute points if it has one, wh=
at type the target attribute<br>has there=2E One dump of the whole family a=
nswers every requirement: it is<br>recorded as it arrives and the chains ar=
e followed once it is complete=2E<br><br>The answer has three values rather=
 than two: without &quot;could not ask&quot;, a<br>netlink error would look=
 the same as a kernel without the feature=2E<br><br>The query needs uapi he=
aders from 5=2E10 or later=2E Built against older<br>ones, it is left out a=
nd dco_probe_capabilities() reports no capability=2E<br><br>No capability i=
s defined yet, so the bitmap comes back empty; the rows<br>that fill it arr=
ive with the features that need them=2E The unit test<br>feeds hand-built d=
umps to the pass and checks what each requirement<br>resolves to=2E<br><br>=
Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6<br>Signed-off-by: Gian=
marco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M CMakeLists=
=2Etxt<br>M config=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M src/openvpn/dc=
o=2Eh<br>M src/openvpn/dco_freebsd=2Ec<br>M src/openvpn/dco_linux=2Ec<br>M =
src/openvpn/dco_win=2Ec<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A te=
sts/unit_tests/openvpn/mock_dco_dependencies=2Ec<br>A tests/unit_tests/open=
vpn/test_dco=2Ec<br>10 files changed, 1,006 insertions(+), 0 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/81/1981/4</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeList=
s=2Etxt</span><br><span>index 50b2d68=2E=2Ebb2ea0c 100644</span><br><span>-=
-- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><spa=
n>@@ -19,6 +19,7 @@</span><br><span> include(CheckLinkerFlag OPTIONAL)</spa=
n><br><span> include(CheckTypeSize)</span><br><span> include(CheckStructHas=
Member)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+include(Chec=
kCSourceCompiles)</span><br><span> include(CTest)</span><br><span> </span><=
br><span> option(UNSUPPORTED_BUILDS &quot;Allow unsupported builds&quot; OF=
F)</span><br><span>@@ -205,6 +206,11 @@</span><br><span>     check_symbol_e=
xists(getpeereid &quot;unistd=2Eh;sys/socket=2Eh&quot; HAVE_GETPEEREID)</sp=
an><br><span> endif()</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+if (ENABLE_LINUXDCO)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    check_c_source_compiles(&quot;#include &lt;linux/g=
enetlink=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int=
 main(void) { return CTRL_ATTR_OP_POLICY; }&quot; HAVE_DECL_CTRL_ATTR_OP_PO=
LICY)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif ()</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> check_i=
nclude_files(grp=2Eh HAVE_GRP_H)</span><br><span> if (HAVE_GRP_H)</span><br=
><span>     check_symbol_exists(getgrnam grp=2Eh HAVE_GETGRNAM)</span><br><=
span>@@ -728,6 +734,12 @@</span><br><span>             )</span><br><span>  =
   endif ()</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (ENABLE_LINUXDCO AND HAVE_DECL_CTRL_ATTR_OP_POLICY)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        list(APPEND unit_t=
ests</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &qu=
ot;test_dco&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    endi=
f ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n>     if (NOT WIN32 AND ${ENABLE_PKCS11})</span><br><span>         set(_HA=
VE_SOFTHSM2 YES)</span><br><span>         find_program(P11TOOL p11tool)</sp=
an><br><span>@@ -969,6 +981,14 @@</span><br><span>             )</span><br>=
<span>     endif ()</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (TARGET test_dco)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        target_sources(test_dco PRIVATE</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            tests/unit_tests/ope=
nvpn/mock_dco_dependencies=2Ec</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            tests/unit_tests/openvpn/mock_get_random=2Ec</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/fdm=
isc=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    endif ()</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     tar=
get_compile_definitions(test_dhcp PRIVATE DHCP_UNIT_TEST)</span><br><span> =
    target_sources(test_dhcp PRIVATE</span><br><span>         tests/unit_te=
sts/openvpn/mock_get_random=2Ec</span><br><span>diff --git a/config=2Eh=2Ec=
make=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>index f7818cf=2E=2Eaa21=
532 100644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>++=
+ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -87,6 +87,9 @@</span><br><sp=
an> /* Define to 1 if you have the `daemon&#39; function=2E */</span><br><s=
pan> #cmakedefine HAVE_DAEMON</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Define to 1 if linux/genetlink=2Eh has netli=
nk policy introspection (5=2E10) */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#cmakedefine01 HAVE_DECL_CTRL_ATTR_OP_POLICY</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Define to 1 i=
f you have the &lt;direct=2Eh&gt; header file=2E */</span><br><span> #cmake=
define HAVE_DIRECT_H</span><br><span> </span><br><span>diff --git a/configu=
re=2Eac b/configure=2Eac</span><br><span>index 05fa964=2E=2Eef05253 100644<=
/span><br><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</=
span><br><span>@@ -664,6 +664,7 @@</span><br><span> 		;;</span><br><span> e=
sac</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+dco_unit_tests=3D&quot;no&quot;</span><br><span> if test &quot;$enable_dc=
o&quot; !=3D &quot;no&quot;; then</span><br><span> 	enable_dco_arg=3D&quot;=
$enable_dco&quot;</span><br><span> 	if test &quot;${enable_iproute2}&quot; =
=3D &quot;yes&quot;; then</span><br><span>@@ -692,6 +693,12 @@</span><br><s=
pan> 				OPTIONAL_LIBNL_GENL_CFLAGS=3D&quot;${LIBNL_GENL_CFLAGS}&quot;</spa=
n><br><span> 				OPTIONAL_LIBNL_GENL_LIBS=3D&quot;${LIBNL_GENL_LIBS}&quot;<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+		=
		dnl</span><br><span style=3D"color: hsl(120, 100%, 40%);">+				dnl Netlin=
k policy introspection needs uapi headers from 5=2E10</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+				dnl</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+				AC_CHECK_DECLS([CTRL_ATTR_OP_POLICY], , , [[#incl=
ude &lt;linux/genetlink=2Eh&gt;]])</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+				dco_unit_tests=3D&quot;${ac_cv_have_decl_CTRL_ATTR_OP_PO=
LICY}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> 				AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload]=
)</span><br><span> 				AC_MSG_NOTICE([Enabled ovpn-dco (via ovpn kernel mod=
ule) support for Linux])</span><br><span> 			fi</span><br><span>@@ -1340,6 =
+1347,7 @@</span><br><span> AC_SUBST([PLUGIN_AUTH_PAM_LIBS])</span><br><spa=
n> </span><br><span> AM_CONDITIONAL([WIN32], [test &quot;${WIN32}&quot; =3D=
 &quot;yes&quot;])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+A=
M_CONDITIONAL([DCO_UNIT_TESTS], [test &quot;${dco_unit_tests}&quot; =3D &qu=
ot;yes&quot;])</span><br><span> AM_CONDITIONAL([GIT_CHECKOUT], [test &quot;=
${GIT_CHECKOUT}&quot; =3D &quot;yes&quot;])</span><br><span> AM_CONDITIONAL=
([ENABLE_PLUGIN_AUTH_PAM], [test &quot;${enable_plugin_auth_pam}&quot; =3D =
&quot;yes&quot;])</span><br><span> AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT]=
, [test &quot;${enable_plugin_down_root}&quot; =3D &quot;yes&quot;])</span>=
<br><span>diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh</span><br>=
<span>index c435f8c=2E=2Eb0a8621 100644</span><br><span>--- a/src/openvpn/d=
co=2Eh</span><br><span>+++ b/src/openvpn/dco=2Eh</span><br><span>@@ -254,6 =
+254,17 @@</span><br><span>  */</span><br><span> bool</span><br><span> dco_=
supports_epoch_data(const struct context *c);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return=
 a bitmap of DCO_CAP_* bits describing the negotiable features the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * local kernel supports=2E =
Everything DCO does without negotiating is available</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * regardless=2E Resolved once and reused=
; platforms without capability probing</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * return 0=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@return  bitmask of DCO_CAP_* flags; 0 both when the kernel supports none</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          of them a=
nd when it could not be asked</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsign=
ed int dco_probe_capabilities(void);</span><br><span> #else  /* if defined(=
ENABLE_DCO) */</span><br><span> </span><br><span> typedef void *dco_context=
_t;</span><br><span>@@ -388,5 +399,11 @@</span><br><span> {</span><br><span=
>     return false;</span><br><span> }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static inline unsigned int</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+dco_probe_capabilities(void)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span> #endif /* defined(ENABLE_DCO) */</span><br><span> #endif /* ifnd=
ef DCO_H */</span><br><span>diff --git a/src/openvpn/dco_freebsd=2Ec b/src/=
openvpn/dco_freebsd=2Ec</span><br><span>index 11b8dff=2E=2E9613c63 100644</=
span><br><span>--- a/src/openvpn/dco_freebsd=2Ec</span><br><span>+++ b/src/=
openvpn/dco_freebsd=2Ec</span><br><span>@@ -707,6 +707,12 @@</span><br><spa=
n>     return 0;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+dco_probe_capabilities(void)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> bool</span><br><span> dco_available(msglvl_t msglevel)</span><b=
r><span> {</span><br><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/ope=
nvpn/dco_linux=2Ec</span><br><span>index 3a55b6e=2E=2Efefc517 100644</span>=
<br><span>--- a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn=
/dco_linux=2Ec</span><br><span>@@ -103,6 +103,361 @@</span><br><span>     r=
eturn ret;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* What the local kernel supports=2E It cannot =
change while we run, so the first</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * caller resolves it and the rest just read it=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static unsigned int dco_cap=
s =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool=
 dco_caps_resolved =3D false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if HAVE_=
DECL_CTRL_ATTR_OP_POLICY</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Netlink p=
olicy introspection: the ovpn module lives in the kernel, so the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * attributes it accepts may d=
iffer from what we were built against=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * CTRL_CMD_GETPOLICY says which attributes each comma=
nd takes and of what type=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* One row per capability,=
 all resolved from the same dump=2E A row can</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * only ask for an attribute the dump reports: UN=
SPEC and REJECT ones never</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * appear, and before Linux 7=2E4 neither do BE16/BE32 ones (b785f5c=
56fb3)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct =
ovpn_cap_req</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int cap;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t cmd;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t nested_attr;=
 /* 0 if target_attr is not nested */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    uint16_t target_attr;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int expected_type;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** the o=
utcome of resolving one capability requirement */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+enum ovpn_cap_status</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    OVPN_CAP_UNKNOWN,     /**&lt; the question could not be as=
ked */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CAP_=
SUPPORTED,   /**&lt; the kernel accepts the attribute */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    OVPN_CAP_UNSUPPORTED, /**&lt; the =
kernel answered, and does not accept it */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The comman=
d map is kept with the policies under this index: there `id` is a</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * command and `nested` the p=
olicy of its doit=2E -1 means &quot;not reported&quot;=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define OVPN_CAP_CMD_MAP (-2)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* ovpn on Linux 7=2E3 reports 77 links *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OVPN_CAP_I=
NITIAL_LINKS 128</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* inside `policy`, at=
tribute `id` has type `type` and, if nested, is</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * validated by policy `nested` */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+struct ovpn_cap_link</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int policy;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    uint16_t id;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int type;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int nested;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+struct ovpn_cap_query</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_link *links;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    size_t n_links;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    size_t max_links;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    bool cmd_map; /* the dump carried a comma=
nd map */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int er=
r;      /* a message we could not parse, or no memory to record it */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static struct nla_policy ovpn_cap_ctrl_policy[CTRL_ATTR_MAX =
+ 1] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    [CTRL=
_ATTR_POLICY] =3D { =2Etype =3D NLA_NESTED },</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    [CTRL_ATTR_OP_POLICY] =3D { =2Etype =3D NLA_N=
ESTED },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static struct nla_policy ovpn_cap_op_policy[CTR=
L_ATTR_POLICY_DUMP_MAX + 1] =3D {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    [CTRL_ATTR_POLICY_DO] =3D { =2Etype =3D NLA_U32 },</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static struct nla_policy ovpn_cap_attr_policy[NL_POLICY_TYPE=
_ATTR_MAX + 1] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    [NL_POLICY_TYPE_ATTR_TYPE] =3D { =2Etype =3D NLA_U32 },</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    [NL_POLICY_TYPE_ATTR_POLICY_ID=
X] =3D { =2Etype =3D NLA_U32 },</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ovpn_cap_add_link(struct ovpn_cap=
_query *query, int policy, uint16_t id, int type, int nested)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (query-&gt;n_links =3D=3D query-&gt;max_link=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        size_t max_links =3D qu=
ery-&gt;max_links ? 2 * query-&gt;max_links : OVPN_CAP_INITIAL_LINKS;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct ovpn_cap_l=
ink *links =3D realloc(query-&gt;links, max_links * sizeof(*links));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!links)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            return -NLE_NOMEM;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        query-&gt;links =3D links;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        query-&gt;max_links =3D max_lin=
ks;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    query-&gt;links[query-&gt;n_links++] =3D (str=
uct ovpn_cap_link){ policy, id, type, nested };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static const struct ovpn_cap_link =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_cap_find(cons=
t struct ovpn_cap_query *query, int policy, uint16_t id)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; query-&gt;n_links; i++)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (query-&gt;links[i]=2Ep=
olicy =3D=3D policy &amp;&amp; query-&gt;links[i]=2Eid =3D=3D id)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            return &amp;query-&gt;links=
[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * One message of the dump carries eithe=
r the command map or a slice of one</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * policy=2E Everything is recorded and the chain is follow=
ed only once the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
dump is complete, so the order of the messages does not matter=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ovpn_cap_query_cb(struct nl_msg *msg, void *arg)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query *query =3D arg;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nlattr *=
tb[CTRL_ATTR_MAX + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const struct genlmsghdr *ghdr =3D nlmsg_data(nlmsg_hdr(msg));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    query-&gt;err =3D nla_parse(tb, CTRL_ATTR=
_MAX, genlmsg_attrdata(ghdr, 0),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                           genlmsg_attrlen(ghdr, 0), ovpn_cap_=
ctrl_policy);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (query-&gt;err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NL=
_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* CTRL_ATTR_OP_POLICY: which policy valid=
ates the doit of each command */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (tb[CTRL_ATTR_OP_POLICY])</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        const struct nlattr *nla_cmd;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        int rem_cmd;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        query-&gt;cmd_map =3D true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        nla_for_each_nested(nla_cmd, tb[CTRL_ATTR_OP_POLICY], rem_=
cmd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct nlattr=
 *tb_cmd[CTRL_ATTR_POLICY_DUMP_MAX + 1];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            query-&gt;err =3D nla_parse(tb_cmd, CTRL_ATTR_POLICY_DUMP_MAX=
, nla_data(nla_cmd),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                   nla_len(nla_cmd), ovpn_cap_op_policy);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (quer=
y-&gt;err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 return NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (tb_cmd[CTRL_=
ATTR_POLICY_DO])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       query-&gt;err =3D ovpn_cap_add_link(query, OVPN_CAP_CMD_MAP, (uint16=
_t)nla_type(nla_cmd),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                               -1, (int)nla_get_u32(tb_cm=
d[CTRL_ATTR_POLICY_DO]));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                if (query-&gt;err)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    return NL_STOP;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* CTRL_ATT=
R_POLICY: which attributes each policy accepts */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!tb[CTRL_ATTR_POLICY])</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return NL_OK;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const struct nlattr *nla_policy;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int rem_policy;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nl=
a_for_each_nested(nla_policy, tb[CTRL_ATTR_POLICY], rem_policy)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct nlattr *nla_attr;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        int rem_attr;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        int policy_id =3D nla_=
type(nla_policy);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        nla_for_each_=
nested(nla_attr, nla_policy, rem_attr)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            struct nlattr *tb_attr[NL_POLICY_TYPE_ATTR_MAX + 1];</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            int attr_=
id =3D nla_type(nla_attr);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            int type =3D -1;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            int nested =3D -1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            query-&gt;err =3D nla_parse_nested(tb_attr, NL_POLICY_T=
YPE_ATTR_MAX, nla_attr,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                          ovpn_cap_attr_policy);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if (query-&gt;=
err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                retur=
n NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            if (tb_attr[NL_POLICY_=
TYPE_ATTR_TYPE])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       type =3D (int)nla_get_u32(tb_attr[NL_POLICY_TYPE_ATTR_TYPE]);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (tb_attr[NL_POLIC=
Y_TYPE_ATTR_POLICY_IDX])</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               nested =3D (int)nla_get_u32(tb_attr[NL_POLICY_TYPE_ATTR_POLI=
CY_IDX]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            query-&gt;err =3D ovpn_=
cap_add_link(query, policy_id, (uint16_t)attr_id, type, nested);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (query-&gt;err)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                return NL=
_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return NL_OK;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Dump the policies of =
the family into query-&gt;links=2E Returns 0, or the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * netlink error that kept us from readin=
g it all=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_cap_ask(s=
truct ovpn_cap_query *query)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t nl_msg *nl_msg =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int ret =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nl=
_sock *nl_sock =3D nl_socket_alloc();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!nl_sock)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return -NLE_NOMEM;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D genl_connect=
(nl_sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (r=
et &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    set_cloexec(nl_socket_get_fd(nl_soc=
k));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    nl_msg =3D nlmsg_alloc();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!nl_msg)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ret =3D -NLE_NOMEM;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* nlctrl has a fixed family id, so there is nothing to resolve =
first=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Unli=
ke CTRL_CMD_GETFAMILY, CTRL_CMD_GETPOLICY does not load the module:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * this relies on dco_a=
vailable() having resolved the family already=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!genlmsg_put(nl_msg, NL_AUTO_PORT=
, NL_AUTO_SEQ, GENL_ID_CTRL, 0, NLM_F_DUMP,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                     CTRL_CMD_GETPOLICY, 0))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        ret =3D -NLE_MSGSIZE;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ret =3D nla_put_string(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_FA=
MILY_NAME);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ret =3D nl_socket_modify_cb(nl_sock, NL_CB_VALID, NL_=
CB_CUSTOM, ovpn_cap_query_cb, query);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (ret &lt; 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D nl_send_auto(nl_soc=
k, nl_msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ret =3D nl_recvmsgs_default(nl_sock);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (ret &gt;=3D 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        ret =3D query-&gt;err;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+out:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nlms=
g_free(nl_msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
nl_socket_free(nl_sock);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret=
 &lt; 0 ? ret : 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Decide whether the kernel supports the requirement, =
from the links the pass</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * collected=2E A link the kernel never mentioned is a no=2E A dump wit=
hout a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * command ma=
p is not an answer either way, and is reported as such, but the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * capability stays off just th=
e same=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static enum ovpn_cap_statu=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_cap_resolve(c=
onst struct ovpn_cap_query *query, const struct ovpn_cap_req *req)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* no command map: the dump cannot say whi=
ch policy validates the command */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!query-&gt;cmd_map)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return OVPN_CAP_UNKNOWN;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a li=
nk is missing: the command, the container or the target is not there */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct ovpn_c=
ap_link *link =3D ovpn_cap_find(query, OVPN_CAP_CMD_MAP, req-&gt;cmd);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (link &amp;&amp; =
req-&gt;nested_attr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        link =
=3D ovpn_cap_find(query, link-&gt;nested, req-&gt;nested_attr);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (link)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        link =3D ovpn_cap_find(query, link-&gt;nested, req-&gt;ta=
rget_attr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!link)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return OVPN_CAP_UNSUPPORTED;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* the whole chain is there: a yes only if the attrib=
ute has the type we</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * would be writing into it */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return (link-&gt;type =3D=3D req-&gt;expected_type) ? OV=
PN_CAP_SUPPORTED : OVPN_CAP_UNSUPPORTED;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_probe_capabilities(=
void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (dco_caps_resolved)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return dco_caps;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* no capability is defined yet: resolve one whose answer we al=
ready know */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
atic const struct ovpn_cap_req self_test =3D { 0, OVPN_CMD_PEER_NEW, OVPN_A=
_PEER,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                                      OVPN_A_PEER_ID, NL_ATTR_TYPE_U32 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_q=
uery query;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEA=
R(query);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int er=
r =3D ovpn_cap_ask(&amp;query);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    enum ovpn_cap_status status =3D err ? OVPN_CAP_UNKNOWN : ov=
pn_cap_resolve(&amp;query, &amp;self_test);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    free(query=2Elinks);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: policy introspection self-test: %s=
 (status %d, err %d)&quot;, __func__,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        status =3D=3D OVPN_CAP_SUPPORTED ? &quot;ok&quot;=
 : &quot;unexpected&quot;, (int)status, err);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    dco_caps_resolved =3D true;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: DCO local capabilities: 0=
x%x&quot;, __func__, dco_caps);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn dco_caps;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else  /* if HAVE_DECL_CTRL_ATTR_OP_POLIC=
Y */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_probe_capabilities(void)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!dco_caps_resolved)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(D_DCO_DEBUG,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            &quot;%s: built without netlink policy=
 introspection, no DCO capability can be detected&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            __func__);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        dco_caps_resolved =3D true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return dco_caps;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if =
HAVE_DECL_CTRL_ATTR_OP_POLICY */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> static struct nl_msg *</span><br><span> ovpn=
_dco_nlmsg_create(const dco_context_t *dco, uint8_t cmd)</span><br><span> {=
</span><br><span>@@ -428,6 +783,12 @@</span><br><span> {</span><br><span>  =
   dco-&gt;ovpn_dco_id =3D resolve_ovpn_netlink_id(M_FATAL);</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* nothing c=
onsumes the bitmap yet; resolve it here to exercise the path */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (check_debug_level(D_DCO=
_DEBUG))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco_probe_capabil=
ities();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     dco=
-&gt;nl_sock =3D nl_socket_alloc();</span><br><span> </span><br><span>     =
if (!dco-&gt;nl_sock)</span><br><span>diff --git a/src/openvpn/dco_win=2Ec =
b/src/openvpn/dco_win=2Ec</span><br><span>index 6074552=2E=2E0f2b9eb 100644=
</span><br><span>--- a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/op=
envpn/dco_win=2Ec</span><br><span>@@ -612,6 +612,12 @@</span><br><span>    =
 return 0;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+unsigned int</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+dco_probe_capabilities(void)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> bool</span><br><span> dco_available(msglvl_t msglevel)</span><br><spa=
n> {</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/=
tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index e3404754=2E=2E=
d1dfac9 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam=
</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><sp=
an>@@ -40,6 +40,12 @@</span><br><span> endif</span><br><span> endif</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+if HAVE_S=
ITNL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if DCO_UNIT_TES=
TS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_binaries +=
=3D dco_testdriver</span><br><span style=3D"color: hsl(120, 100%, 40%);">+e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> if !CROSS_C=
OMPILING</span><br><span> TESTS =3D $(test_binaries)</span><br><span> endif=
</span><br><span>@@ -452,4 +458,16 @@</span><br><span> 	$(top_srcdir)/src/o=
penvpn/run_command=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/socket=
_util=2Ec</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+dco_testdriver_CFLAGS  =3D \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(to=
p_srcdir)/src/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO_CFLAGS)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+dco_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ $(OPTION=
AL_CRYPTO_LIBS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_=
testdriver_SOURCES =3D test_dco=2Ec \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	mock_msg=2Ec mock_msg=2Eh mock_dco_dependencies=2Ec mock=
_get_random=2Ec test_common=2Eh \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buffer=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/fdmisc=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/win32-util=2Ec</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> build-=
tests-local: $(check_PROGRAMS)</span><br><span>diff --git a/tests/unit_test=
s/openvpn/mock_dco_dependencies=2Ec b/tests/unit_tests/openvpn/mock_dco_dep=
endencies=2Ec</span><br><span>new file mode 100644</span><br><span>index 00=
00000=2E=2Ee7f20f5</span><br><span>--- /dev/null</span><br><span>+++ b/test=
s/unit_tests/openvpn/mock_dco_dependencies=2Ec</span><br><span>@@ -0,0 +1,8=
0 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to=
 securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             over a single UDP port, with support for SSL/TLS-ba=
sed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             s=
ession authentication and key exchange,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *             packet encryption, packet authentication=
, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright =
(C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 Gianmarco De Grego=
ri &lt;gianmarco@mandelbit=2Ecom&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  This program is free software; you can redistribute it and/or modify</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms=
 of the GNU General Public License version 2</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed i=
n the hope that it will be useful,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warra=
nty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTA=
BILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more =
details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have receiv=
ed a copy of the GNU General Public License along</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https:=
//www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  Stubs for what dco_linux=2Ec drag=
s in but capability probing never reaches:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  the data path, the event loop and the signal mac=
hinery=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;dco=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto_backend=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;forwar=
d=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;networking=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;socket_util=2Eh&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+multi_process_incoming_dco(dco_context_t *dco)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+process_incoming_dco(dco_context_t *dco)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+register_signal=
(struct signal_info *si, int signum, const char *signal_text)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_new(const openvpn_n=
et_ctx_t *ctx, const openvpn_net_iface_t *iface, const char *type,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+              const void *ar=
g)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_del(const=
 openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+cipher_kt_key_size(const char=
 *ciphername)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+print_sockaddr_ex(const struct sockaddr *addr, const char *separator, cons=
t unsigned int flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                  struct gc_arena *gc)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return &quot;[mock]&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
dco=2Ec b/tests/unit_tests/openvpn/test_dco=2Ec</span><br><span>new file mo=
de 100644</span><br><span>index 0000000=2E=2Ebd874bf</span><br><span>--- /d=
ev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_dco=2Ec</span><=
br><span>@@ -0,0 +1,487 @@</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVP=
N -- An application to securely tunnel IP networks</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             over a single UDP port, with =
support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             session authentication and key exchange,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption,=
 packet authentication, and</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             packet compression=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2=
026 Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  This program is free software; you can redistribu=
te it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  it under the terms of the GNU General Public License version 2</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free=
 Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This prog=
ram is distributed in the hope that it will be useful,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without ev=
en the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Publ=
ic License for more details=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Yo=
u should have received a copy of the GNU General Public License along</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if=
 not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Unit tests fo=
r the DCO capability queries=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  R=
esolving a requirement is a pass over a policy dump that records what it</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  reports, followed =
by a walk along what the pass recorded=2E The pass is fed</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  dumps built by hand, which cover =
what would otherwise need a particular</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  kernel=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;dco_linux=2Ec&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define CMD_POLICY   4</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define SUB_POLICY   9</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define OTHER_POLICY 7</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* the bit is never read here, only the chain that wou=
ld set it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
const struct ovpn_cap_req test_req =3D { =2Ecap =3D 1u,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
       =2Ecmd =3D OVPN_CMD_PEER_NEW,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                              =2Enested_at=
tr =3D OVPN_A_PEER,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                              =2Etarget_attr =3D OVPN_A_PEE=
R_KEEPALIVE_INTERVAL,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                              =2Eexpected_type =3D NL_ATT=
R_TYPE_U32 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* the same requirement w=
ithout a container: the target sits in the command&#39;s</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * own policy */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static const struct ovpn_cap_req flat_req=
 =3D { =2Ecap =3D 1u,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                              =2Ecmd =3D OVPN_CMD_PEER_NE=
W,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                             =2Enested_attr =3D 0,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                            =
  =2Etarget_attr =3D OVPN_A_IFINDEX,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                              =2Eexpected_=
type =3D NL_ATTR_TYPE_U32 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static str=
uct ovpn_cap_query</span><br><span style=3D"color: hsl(120, 100%, 40%);">+n=
ew_query(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_que=
ry query;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(query);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return query;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* a CTRL_ATTR_OP_POLICY message saying which policy validates `cmd` *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct nl_m=
sg *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+msg_op_policy(u=
int16_t cmd, uint32_t do_policy)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct nl_msg *msg =3D nlmsg_alloc();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct nlattr *ops, *op;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_non_null(msg);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_non_null(genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ=
, 0, 0, 0, CTRL_CMD_GETPOLICY, 0));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ops =3D nla_nest_start(msg, CTRL_ATTR_OP_POLICY);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    op =3D nla_nest_start(msg, cmd);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(nla_pu=
t_u32(msg, CTRL_ATTR_POLICY_DO, do_policy), 0);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    nla_nest_end(msg, op);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    nla_nest_end(msg, ops);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return msg;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* one attribute =
of a policy: its id, which field of its descriptor to set,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * and the value to put there */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+struct attr_desc</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    uint16_t attr_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int field;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    uint32_t value;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* a CT=
RL_ATTR_POLICY message describing `n` attributes of one policy */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static struct nl_msg *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+msg_policy_attrs(uint16_t =
policy_id, const struct attr_desc *descs, size_t n)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct nl_msg *msg =3D nlmsg_alloc();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct nlattr *policies, *policy,=
 *attr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(msg);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(genlm=
sg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, 0, 0, 0, CTRL_CMD_GETPOLICY, 0));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    policies =3D nla_nest_start(msg, CTRL=
_ATTR_POLICY);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p=
olicy =3D nla_nest_start(msg, policy_id);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; n; i++)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        attr =3D nla_nest_start(msg, descs[i]=
=2Eattr_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 assert_int_equal(nla_put_u32(msg, descs[i]=2Efield, descs[i]=2Evalue), 0);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        nla_nest_en=
d(msg, attr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nla_nest_end(msg=
, policy);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nla_n=
est_end(msg, policies);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return msg;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* the shape the kernel actually sends: one attribute pe=
r message */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
struct nl_msg *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+msg_=
policy_attr(uint16_t policy_id, uint16_t attr_id, int field, uint32_t value=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const struct attr_desc one =3D {=
 attr_id, field, value };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ms=
g_policy_attrs(policy_id, &amp;one, 1);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+feed(struct ovpn_cap_quer=
y *query, struct nl_msg *msg)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(ovpn_cap_query_cb(msg, query), NL_OK);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    nlmsg_free(msg);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 Walk the whole chain, with both policies carrying attributes we are not</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * after and the ones =
we are neither first nor last, so that the pass has to</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * skip past them rather than stop at th=
e first mismatch=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+feed_=
full_chain(struct ovpn_cap_query *query)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const struct attr_desc cmd_attrs[] =3D {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        { OVPN_A_IFINDEX, NL_POLICY_TYPE_ATTR_T=
YPE, NL_ATTR_TYPE_U32 },</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        { OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX, SUB_POLICY },</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { OVPN_A_KEYC=
ONF, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_NESTED },</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const struct attr_desc sub_attrs[] =3D {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        { OVPN_A_PEER_ID, NL_=
POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U32 },</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        { OVPN_A_PEER_REMOTE_PORT, NL_POLICY_TYPE_AT=
TR_TYPE, NL_ATTR_TYPE_U16 },</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        { test_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE, NL_ATT=
R_TYPE_U32 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  { OVPN_A_PEER_LOCAL_PORT, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U16 },</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    feed(query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_=
POLICY));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(q=
uery, msg_policy_attrs(CMD_POLICY, cmd_attrs, SIZE(cmd_attrs)));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    feed(query, msg_policy_att=
rs(SUB_POLICY, sub_attrs, SIZE(sub_attrs)));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* the map t=
ells us which policy validates the command we asked about */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_reads_command_policy(void **state)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new=
_query();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_p=
olicy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const struct ovpn_cap_link *link =3D ovpn_cap_find(&=
amp;query, OVPN_CAP_CMD_MAP, OVPN_CMD_PEER_NEW);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_non_null(link);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(link-&gt;nested, C=
MD_POLICY);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free=
(query=2Elinks);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* and not about another one */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_ignores_other_command(void **st=
ate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =
=3D new_query();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, m=
sg_op_policy(OVPN_CMD_PEER_DEL, CMD_POLICY));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, =
OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                 SUB_POLICY));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, ms=
g_policy_attr(SUB_POLICY, test_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
              NL_ATTR_TYPE_U32));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(ovpn_cap_resolve(&amp;query, &amp;test_r=
eq), OVPN_CAP_UNSUPPORTED);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    free(query=2Elinks);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* the nested attribute =
of that policy points at the sub-policy */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_follows_nested_attribute(void **state)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new_query();</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_policy(OVPN_CMD_=
PEER_NEW, CMD_POLICY));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY=
_TYPE_ATTR_POLICY_IDX,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                 SUB_POLICY));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const struct ovpn_cap_link *link =3D ovpn=
_cap_find(&amp;query, CMD_POLICY, OVPN_A_PEER);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_non_null(link);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(link-&gt;nested, SU=
B_POLICY);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(=
query=2Elinks);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* an attribute id only means something i=
nside its own policy, so the same</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * number elsewhere says nothing about our question: a comman=
d policy without</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
the container is a no, whatever comes after it */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+test_ignores_nested_attribute_elsewhere(void **state)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D n=
ew_query();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op=
_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, OVPN_=
A_IFINDEX, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                 NL_ATTR_TYPE_U32));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_=
policy_attr(OTHER_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
         SUB_POLICY));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    feed(&amp;query, msg_policy_attr(SUB_POLICY, test_req=2Etarget_attr,=
 NL_POLICY_TYPE_ATTR_TYPE,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                 NL_ATTR_TYPE_U32));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ovpn_cap_resol=
ve(&amp;query, &amp;test_req), OVPN_CAP_UNSUPPORTED);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free(query=2Elinks);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* the type of the target attribute is read in the sub-policy */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_reads_target_type(void **state)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D n=
ew_query();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    feed_full_chain(&amp;qu=
ery);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const stru=
ct ovpn_cap_link *link =3D ovpn_cap_find(&amp;query, SUB_POLICY, test_req=
=2Etarget_attr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_non_null(link);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(link-&gt;type, NL_ATTR_TYPE_U32);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    free(query=2Elinks);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* and the same holds for the target attribute: a type read off some=
 other</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * policy is =
not an answer to what we asked */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_ignores_target_attribute_elsewhere(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new_query();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_policy(OVPN_C=
MD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POL=
ICY_TYPE_ATTR_POLICY_IDX,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                 SUB_POLICY));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(OTHE=
R_POLICY, test_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                 NL=
_ATTR_TYPE_U32));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(ovpn_cap_resolve(&amp;query, &amp;test_req), OVPN_CAP_UN=
SUPPORTED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free=
(query=2Elinks);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* the command&#39;s own policy does get=
 read, so the target attribute has to be</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * turned away there too: the same id there is a diffe=
rent attribute */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ignor=
es_target_attribute_in_command_policy(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct ovpn_cap_query query =3D new_query();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_policy(OVPN_CMD_PEER_=
NEW, CMD_POLICY));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   feed(&amp;query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE=
_ATTR_POLICY_IDX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                               SUB_POLICY));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, t=
est_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                 NL_ATTR_TYPE_=
U32));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(ovpn_cap_resolve(&amp;query, &amp;test_req), OVPN_CAP_UNSUPPORTED);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(query=2Eli=
nks);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* the sub-policy is read too, so the nested attrib=
ute has to be turned away</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * there as well */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+te=
st_ignores_nested_attribute_in_sub_policy(void **state)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct ovpn_cap_query query =3D new_query();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_policy(OVPN_CMD_PEE=
R_NEW, CMD_POLICY));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    feed(&amp;query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TY=
PE_ATTR_POLICY_IDX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                 SUB_POLICY));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(SUB_POLICY,=
 OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                 OTHER_POLICY));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query,=
 msg_policy_attr(OTHER_POLICY, test_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_=
TYPE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                   NL_ATTR_TYPE_U32));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(ovpn_cap_resolve(&amp;query, &amp;t=
est_req), OVPN_CAP_UNSUPPORTED);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    free(query=2Elinks);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* an attribute tha=
t is there but not as a nest has nothing to follow */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_nested_attribute_without_policy_idx(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =
=3D new_query();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, m=
sg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, =
OVPN_A_PEER, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                 NL_ATTR_TYPE_U32));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, ms=
g_policy_attr(SUB_POLICY, test_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
              NL_ATTR_TYPE_U32));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(ovpn_cap_resolve(&amp;query, &amp;test_r=
eq), OVPN_CAP_UNSUPPORTED);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    free(query=2Elinks);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* and one that is a nes=
t says nothing about the type we are after */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+test_target_attribute_without_type(void **state)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new_query(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_policy(O=
VPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, N=
L_POLICY_TYPE_ATTR_POLICY_IDX,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                 SUB_POLICY));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(=
SUB_POLICY, test_req=2Etarget_attr,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                 NL_POLICY_TYPE_ATTR_POLICY=
_IDX, OTHER_POLICY));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(ovpn_cap_resolve(&amp;query, &amp;test_req), OVPN_CA=
P_UNSUPPORTED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
free(query=2Elinks);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* a flat requirement needs no hop: =
the command&#39;s policy is where to look */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_flat_requirement_reads_command_policy(void **state)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new=
_query();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_p=
olicy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, flat_re=
q=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                 NL_ATTR_TYPE_U32));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(ovpn_cap_resolve(&amp;query, &amp;flat_req), OVPN_CAP_SUPPORTED);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    free(query=2Elinks);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* and an absent one is a plain no */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_flat_requirement_absent_is_unsupported(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query que=
ry =3D new_query();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query=
, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(OTHER_POL=
ICY, flat_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                 NL_ATTR=
_TYPE_U32));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(ovpn_cap_resolve(&amp;query, &amp;flat_req), OVPN_CAP_UNSUPPO=
RTED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(quer=
y=2Elinks);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* a message we cannot parse stops the pass w=
ith an error, rather than</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * leaving a hole that would read as a no */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+test_malformed_message_stops(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new_query()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nl_msg =
*msg =3D nlmsg_alloc();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct nlattr *ops, *op;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_non_null(msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_non_null(genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, 0, 0, 0, CT=
RL_CMD_GETPOLICY, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ops =3D nla_nest_start(msg, CTRL_ATTR_OP_POLICY);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    op =3D nla_nest_start(msg, OVPN_CM=
D_PEER_NEW);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(nla_put_u16(msg, CTRL_ATTR_POLICY_DO, CMD_POLICY), 0);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    nla_nest_end(msg, op);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nla_nest_end(ms=
g, ops);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ovpn_cap_=
query_cb(msg, &amp;query), NL_STOP);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(query=2Eerr &lt; 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(query=2En_links, 0);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nlmsg_free(msg)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(query=2El=
inks);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* nothing to read an answer out of is not the sam=
e as a &quot;no&quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tes=
t_resolve_without_command_policy(void **state)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct ovpn_cap_query query =3D new_query();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(ovpn_cap_resolve(&amp;query, &amp;t=
est_req), OVPN_CAP_UNKNOWN);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* a kernel that does not ne=
st the attribute simply never mentions it */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_resolve_nested_absent(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new_query();</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_policy(OVPN_CMD_P=
EER_NEW, CMD_POLICY));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_equal(ovpn_cap_resolve(&amp;query, &amp;test_req), OVPN_C=
AP_UNSUPPORTED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 free(query=2Elinks);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* the sub-policy is there but does=
 not define the attribute: the ordinary no */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+test_resolve_target_absent(void **state)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new_query();</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_policy(OVPN_CMD_=
PEER_NEW, CMD_POLICY));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY=
_TYPE_ATTR_POLICY_IDX,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                 SUB_POLICY));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(ovpn_cap_resolve(&amp;qu=
ery, &amp;test_req), OVPN_CAP_UNSUPPORTED);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    free(query=2Elinks);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* right=
 name, wrong type: not the attribute we would be writing */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_resolve_wrong_type(void **state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new_q=
uery();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_pol=
icy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, OVPN_A_PE=
ER, NL_POLICY_TYPE_ATTR_POLICY_IDX,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                 SUB_POLICY));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_=
attr(SUB_POLICY, test_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
     NL_ATTR_TYPE_U8));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(ovpn_cap_resolve(&amp;query, &amp;test_req), OVPN_=
CAP_UNSUPPORTED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  free(query=2Elinks);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* and the whole chain, from a dum=
p to a yes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_resolve_c=
omplete_chain(void **state)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 ovpn_cap_query query =3D new_query();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    feed_full_chain(&amp;query);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(ovpn_cap_resolve(&amp;query, &amp;test_re=
q), OVPN_CAP_SUPPORTED);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    free(query=2Elinks);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* the kernel&#39;s order i=
s not relied upon */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_re=
solve_any_order(void **state)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct ovpn_cap_query query =3D new_query();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    feed(&amp;query, msg_policy_attr(SUB_POLICY, test_req=2Etarget_attr, =
NL_POLICY_TYPE_ATTR_TYPE,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                 NL_ATTR_TYPE_U32));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_attr=
(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                 SUB_=
POLICY));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&=
amp;query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ovpn_cap_resolve=
(&amp;query, &amp;test_req), OVPN_CAP_SUPPORTED);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    free(query=2Elinks);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 a dump larger than the first allocation */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_resolve_large_dump(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct ovpn_cap_query query =3D new_query();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    for (uint16_t attr_id =3D 1; attr_id &lt;=3D =
3 * OVPN_CAP_INITIAL_LINKS; attr_id++)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        feed(&amp;query, msg_policy_attr(OTHER_POLICY, attr_id, NL_POL=
ICY_TYPE_ATTR_TYPE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                     NL_ATTR_TYPE_U32));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    feed_full_chain(&amp;query);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(query=2En_links &lt;=3D=
 query=2Emax_links);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(ovpn_cap_resolve(&amp;query, &amp;test_req), OVPN_CAP=
_SUPPORTED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fre=
e(query=2Elinks);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+main(void)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st struct CMUnitTest tests[] =3D {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_reads_command_policy),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(te=
st_ignores_other_command),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        cmocka_unit_test(test_follows_nested_attribute),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_i=
gnores_nested_attribute_elsewhere),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cmocka_unit_test(test_reads_target_type),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test=
_ignores_target_attribute_elsewhere),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test(test_ignores_target_attribute_in=
_command_policy),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cmocka_unit_test(test_ignores_nested_attribute_in_sub_policy),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(t=
est_nested_attribute_without_policy_idx),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_target_attribute_withou=
t_type),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmo=
cka_unit_test(test_flat_requirement_reads_command_policy),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_flat_r=
equirement_absent_is_unsupported),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_malformed_message_stops),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test=
(test_resolve_without_command_policy),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmocka_unit_test(test_resolve_nested_absent),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_resolve_target_absent),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        cmocka_unit_test(test_resolve_wrong_type),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_re=
solve_complete_chain),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_resolve_any_order),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_resolve_lar=
ge_dump),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_group_tests_name(&q=
uot;dco&quot;, tests, NULL, NULL);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br></pre><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail">change 1981</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0051effe7f06=
36e30557d9ce92c50c458002f9e6 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1981 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gia=
nmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: Antonio Quartulli &lt;antonio@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>

</body></htm=
l>
--vTtp8ZEZ2ck=--


--===============1968425663579859805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1968425663579859805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1968425663579859805==--

