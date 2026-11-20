Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC1E606A32A
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kg1aozlN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XI4hBYPw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QZxmbBIT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=H8YZuBox
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dqLqC/fMdE5mLA+K851VXuVGC4/LX/7pUCWJYYfOH8M=; b=kg1aozlNGaFL9x3AScgl3zlljo
	V6sNF9sIggLp8gadtj2pMyLpZa0MAJ5viYn0JODdQyJsWQwj0sxapf0AlSMeYMaeMxthXZ70EcpIT
	g1OpefIDryBHJVQxIrn/j58/U2yu8/8zXgf3HAPJPdrkdl/Gurrsm59pvvsT6lDmOldg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xULUc-000000007P8-3ApX;
	Fri, 20 Nov 2026 10:05:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xULUa-000000007Ou-3Bh4
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:05:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aUooRsKNFxQ21Kb7A4GeM64agRHLuHAmYYkFKHyDibI=; b=XI4hBYPwu4euAOdrz9McFBlntt
 87rRqFk4EfMYqafXSdDt7L80TYYpEmZaCXcAHN5MBLPFmAIGWti2s0NzPeVCvdyObKfSKXb166Bfl
 cl9Mrp2am1BT4bmuqXxhJSaDxWJmZwdXePgNuqANNXu+qaDF6dorWbEKqXMc4uh8gyDg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aUooRsKNFxQ21Kb7A4GeM64agRHLuHAmYYkFKHyDibI=; b=QZxmbBITI3ECjgxzWcrgGyA+x3
 18QVdNrYo2YmsvGWEeSQHMrv6IgQwF0cGMh8WBZkg4Fh6+jmUK6D/qQPLr8pmWBE9JRGCB3jHO1tD
 Hkb+R8kFUa/2LHjN37QY9c3n7g0X+GERv2RGDOabOY/K35JqKdRRaY0LK+ek78vA6AK4=;
Received: from mail-ej1-f53.google.com ([209.85.218.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xULUV-000000003I3-09FP for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:05:16 +0000
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c4d5b2db4bbso163372866b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 02:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795169104; x=1795773904; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aUooRsKNFxQ21Kb7A4GeM64agRHLuHAmYYkFKHyDibI=;
 b=H8YZuBox4FLFMe6jx+IlGu+prs9kZRBHjxGhkJlMQBHNGh6kAioJMZXC8ErqWTi7bP
 6/l6PeTitcJwXj4AzYanY38PgszxJJhegEPdBtNhLurpvsTeEM4ru1ssmf7CjEW+Dqsk
 SNN3lwhJnYitrc/1wDvjc3sTulfu6nZ0soUJx7JVQQ6GqZPCP3NmOF0TjeCTsJx44lwj
 U+jC+o7k8Y9wWFIZm6r2rMlCA39B2FShVNhp2M0VN4w4M/qWt3EMrgk7yq0ivCtIeHQC
 zFFIxa0xu9t7KDmDj1vwcQ1ecJ047j8zfUwscWBvdioo0Ky4LJhStLAF/qZ7twpTzV1e
 o4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795169104; x=1795773904;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aUooRsKNFxQ21Kb7A4GeM64agRHLuHAmYYkFKHyDibI=;
 b=qllqT+RsmS9YPD1iUxHAeWcVHM/mKH0O14W2iuHI2z5xu+zwmHoW8Courrhg/mrTQs
 j1MvILuBZGa6/mD4ve8zEaK1g3p9e84jNUS9XUxLtXLOirVyW6noKq0uPlAu7AzcGHrG
 zRSVs6DHTMXP8mnr60D7F2BgPF3TAk8GVgXXY846HJlwoAegWaWD1kRcRYQg2PIAJ+UU
 XmzysdEk3GhsApOMlHZUqJE8QtFnEpzDpPf2wflpgfBS31Z3TW7pRmqrur2L7vS2uPvb
 GivvEi81WCXwKwkaY9RL6B/bHUuPZGUro15ca7i0hKgXfFp2hJep2TTtODw5jHuRBZvZ
 JKVg==
X-Gm-Message-State: APuU4Z+L7FvEBYVrTxtTtd6HJWL1bHtHMOOLNtyz9gffvJRIRiNp69Ek
 b9ORXj1mKW3tlSHvHtbQEr5WXcRjK7NhHm3V8ADhW1bo796qcixAZcfvtKwjK7jUKe80/zasb2C
 wQ+FuS+0fdXEQasevio3pm2I0MtNUFNEOPkt1RO4CqBm/sF1PusH6JBs/jyo/bf2J9jTlP2Epw3
 cfavNJ+A==
X-Gm-Gg: AYBFou18o6k1eblDF21bfk9wZwgNKU3xFMd9c3ICXb2KinFiovDuj0YK+AfYMGscUQ4
 0STHaZFOwNuGgqn1yL4GowdS+8EXLRXXsphG12WVss0U269j2bWFkF3uNUcojC5uxrte4g+MxoE
 xIY9uimuaCuLAkszHgA/cnqIR69N0lrdT0wCA2vg5yWTMwsX4eyN4R1aZC0aXlW1tCEUqPXc7nQ
 zT3Pn0fYXu1AcqUR/z4x8TOyvVYLMp4qMrXxrFgyr16oWvkWEw8orwQOUhTIwHpEGM7FJxGbXXv
 yQ01VekrgvMBPHjiW2qWx0J2y0tbLq5CFxwUPSabpe6G/68DIdLqk7HCsWHcyRr0xub+4cO9J/i
 O9/wzpHZtUwQeAf7nz1lb5onV1hVKwz/GeRHM8kFYO4NmVOL+N1EZmat08Bo3KBI/r5fitXfD2b
 GGRjC7yAG10ZQxw7HCAjij+TCE/ZxPf/h7uLrX98qKMLVo/sgUZarjuXvX6WfSe50xp9BSLgWaq
 58JrMPhXqxMmOE+s3Eivv0h61LpSPvZe9tS/QTavXDiUdC8k0+r7w+otOHSFTLRMUDPBx5EFzdA
 yZg9wE4anZadrceIsHN02RYU+cG3rQyJYUxQtYs3MrNSWeYyiHEdFz7Cl0YeCknFNB6SztadxC0
 mtEECYqDt/iWutaUZ+9KBvNoP8eTwZ8EkyI9IezxxahQhJ1IwZuYYDagH554sw2slhwIYUTRbfO
 uu5y+Oz3aK2mFI1L8=
X-Received: by 2002:a17:907:2d13:b0:c42:4f89:13 with SMTP id
 a640c23a62f3a-c513186f187mr404108466b.15.1795169103488; 
 Fri, 20 Nov 2026 02:05:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d60sm4596430f8f.3.2026.11.20.02.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:05:02 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 10:05:00 +0000
To: Ralf Lici <ralf@mandelbit.com>,
	Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6
X-Gerrit-Change-Number: 1981
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1981?usp=email>
X-Gerrit-Commit: 483a821e6827a0e029e41394b7e635de2b9773af
In-Reply-To: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
References: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg2NDUyMDAwLkkwMDUxZWZmZTdmMDYzNmUzMDU1N2Q5Y2U5MmM1MGM0NTgwMDJmOWU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <78c2cf7f20c450b8946001477a0050d05e69cf1a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xULUV-000000003I3-09FP
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco: detect local
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6902636162806962519=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6902636162806962519==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KgEJbHUCgUc="; charset=UTF-8

--KgEJbHUCgUc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori, R=
alf Lici=2E

Hello Arne Schwabe, Ralf Lici, 

I'd like you to reexamine a c=
hange=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?=
usp=3Demail

to look at the new patch set (#3)=2E

The following approvals =
got outdated and were removed:
Code-Review-1 by Ralf Lici


Change subject:=
 dco: detect local kernel capabilities through netlink policies
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: detect local kern=
el capabilities through netlink policies

The ovpn module lives in the kern=
el, so the attributes it accepts may
differ from what we were built against=
=2E CTRL_CMD_GETPOLICY dumps the
validation policy of a family: which attri=
butes each command takes, of
what type, and for a nested one the sub-policy=
 that validates it=2E

Add a helper to query it, wrapped in dco_probe_capab=
ilities() so the
rest of the tree never talks to netlink itself=2E Answerin=
g a requirement
means following a chain - which policy validates the comman=
d, where its
nested attribute points if it has one, what type the target at=
tribute
has there - and CTRL_ATTR_OP narrows the dump enough to collect all=

three in one pass=2E

The answer has three values rather than two: without=
 "could not ask", a
netlink error would look the same as an old kernel=2E

=
The query needs uapi headers from 5=2E10 or later=2E Built against older
on=
es, it is left out and dco_probe_capabilities() reports no capability=2E

N=
o capability is defined yet, so the bitmap comes back empty; the rows
that =
fill it arrive with the features that need them=2E The unit test
drives the=
 pass and the decision separately, on dumps built by hand=2E

Change-Id: I0=
051effe7f0636e30557d9ce92c50c458002f9e6
Signed-off-by: Gianmarco De Gregori=
 <gianmarco@mandelbit=2Ecom>
---
M CMakeLists=2Etxt
M config=2Eh=2Ecmake=2E=
in
M configure=2Eac
M src/openvpn/dco=2Eh
M src/openvpn/dco_freebsd=2Ec
M s=
rc/openvpn/dco_linux=2Ec
M src/openvpn/dco_win=2Ec
M tests/unit_tests/openv=
pn/Makefile=2Eam
A tests/unit_tests/openvpn/mock_dco_dependencies=2Ec
A tes=
ts/unit_tests/openvpn/test_dco=2Ec
10 files changed, 911 insertions(+), 0 d=
eletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/81/1981/3

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 50b=
2d68=2E=2E593c511 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -=
19,6 +19,7 @@
 include(CheckLinkerFlag OPTIONAL)
 include(CheckTypeSize)
 i=
nclude(CheckStructHasMember)
+include(CheckCSourceCompiles)
 include(CTest)=

 
 option(UNSUPPORTED_BUILDS "Allow unsupported builds" OFF)
@@ -205,6 +20=
6,11 @@
     check_symbol_exists(getpeereid "unistd=2Eh;sys/socket=2Eh" HAV=
E_GETPEEREID)
 endif()
 
+if (ENABLE_LINUXDCO)
+    check_c_source_compiles=
("#include <linux/genetlink=2Eh>
+int main(void) { return CTRL_ATTR_OP_POLI=
CY; }" HAVE_DECL_CTRL_ATTR_OP_POLICY)
+endif ()
+
 check_include_files(grp=
=2Eh HAVE_GRP_H)
 if (HAVE_GRP_H)
     check_symbol_exists(getgrnam grp=2Eh=
 HAVE_GETGRNAM)
diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=
=2Ein
index f7818cf=2E=2Eaa21532 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b=
/config=2Eh=2Ecmake=2Ein
@@ -87,6 +87,9 @@
 /* Define to 1 if you have the =
`daemon' function=2E */
 #cmakedefine HAVE_DAEMON
 
+/* Define to 1 if linu=
x/genetlink=2Eh has netlink policy introspection (5=2E10) */
+#cmakedefine0=
1 HAVE_DECL_CTRL_ATTR_OP_POLICY
+
 /* Define to 1 if you have the <direct=
=2Eh> header file=2E */
 #cmakedefine HAVE_DIRECT_H
 
diff --git a/configur=
e=2Eac b/configure=2Eac
index 585c3bd=2E=2E5a19f25 100644
--- a/configure=
=2Eac
+++ b/configure=2Eac
@@ -692,6 +692,11 @@
 				OPTIONAL_LIBNL_GENL_CF=
LAGS=3D"${LIBNL_GENL_CFLAGS}"
 				OPTIONAL_LIBNL_GENL_LIBS=3D"${LIBNL_GENL=
_LIBS}"
 
+				dnl
+				dnl Netlink policy introspection needs uapi headers=
 from 5=2E10
+				dnl
+				AC_CHECK_DECLS([CTRL_ATTR_OP_POLICY], , , [[#inc=
lude <linux/genetlink=2Eh>]])
+
 				AC_DEFINE(ENABLE_DCO, 1, [Enable share=
d data channel offload])
 				AC_MSG_NOTICE([Enabled ovpn-dco (via ovpn ker=
nel module) support for Linux])
 			fi
@@ -1340,6 +1345,7 @@
 AC_SUBST([PLU=
GIN_AUTH_PAM_LIBS])
 
 AM_CONDITIONAL([WIN32], [test "${WIN32}" =3D "yes"])=

+AM_CONDITIONAL([DCO_UNIT_TESTS], [test "${ac_cv_have_decl_CTRL_ATTR_OP_PO=
LICY}" =3D "yes"])
 AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" =
=3D "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugi=
n_auth_pam}" =3D "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "=
${enable_plugin_down_root}" =3D "yes"])
diff --git a/src/openvpn/dco=2Eh b/=
src/openvpn/dco=2Eh
index c435f8c=2E=2Efba1795 100644
--- a/src/openvpn/dco=
=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -254,6 +254,17 @@
  */
 bool
 dco_support=
s_epoch_data(const struct context *c);
+
+/**
+ * Return a bitmap of DCO_CA=
P_* bits describing the negotiable features the
+ * local kernel supports=
=2E Everything DCO does without negotiating is available
+ * regardless=2E =
Resolved once and reused; platforms without capability probing
+ * return 0=
=2E
+ *
+ * @return  bitmask of DCO_CAP_* flags; 0 both when the kernel neg=
otiates none
+ *          of them and when it could not be asked
+ */
+unsi=
gned int dco_probe_capabilities(void);
 #else  /* if defined(ENABLE_DCO) */=

 
 typedef void *dco_context_t;
@@ -388,5 +399,11 @@
 {
     return false;=

 }
+
+static inline unsigned int
+dco_probe_capabilities(void)
+{
+    ret=
urn 0;
+}
 #endif /* defined(ENABLE_DCO) */
 #endif /* ifndef DCO_H */
diff=
 --git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec
index 11=
b8dff=2E=2E9613c63 100644
--- a/src/openvpn/dco_freebsd=2Ec
+++ b/src/openv=
pn/dco_freebsd=2Ec
@@ -707,6 +707,12 @@
     return 0;
 }
 
+unsigned int
+=
dco_probe_capabilities(void)
+{
+    return 0;
+}
+
 bool
 dco_available(ms=
glvl_t msglevel)
 {
diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dc=
o_linux=2Ec
index 3a55b6e=2E=2E7b5bd07 100644
--- a/src/openvpn/dco_linux=
=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -103,6 +103,342 @@
     return ret;=

 }
 
+/* What the local kernel supports=2E It cannot change while we run, =
so the first
+ * caller resolves it and the rest just read it=2E */
+static=
 unsigned int dco_caps =3D 0;
+static bool dco_caps_resolved =3D false;
+
+=
#if HAVE_DECL_CTRL_ATTR_OP_POLICY
+/*
+ * Netlink policy introspection: the=
 ovpn module lives in the kernel, so the
+ * attributes it accepts may diff=
er from what we were built against=2E
+ * CTRL_CMD_GETPOLICY says which att=
ributes a command takes and of what type,
+ * and CTRL_ATTR_OP narrows the =
dump to a single command=2E
+ */
+
+/* One row per capability, each resolve=
d with a dump of its own=2E A row can
+ * only ask for an attribute the dum=
p reports: UNSPEC and REJECT ones never
+ * appear, and before Linux 7=2E4 =
neither do BE16/BE32 ones (b785f5c56fb3)=2E */
+struct ovpn_cap_req
+{
+   =
 unsigned int cap;
+    uint16_t cmd;
+    uint16_t nested_attr; /* 0 if ta=
rget_attr is not nested */
+    uint16_t target_attr;
+    int expected_typ=
e;
+};
+
+/** the outcome of resolving one capability requirement */
+enum =
ovpn_cap_status
+{
+    OVPN_CAP_UNKNOWN,     /**< the question could not b=
e asked */
+    OVPN_CAP_SUPPORTED,   /**< the kernel accepts the attribute=
 */
+    OVPN_CAP_UNSUPPORTED, /**< the kernel answered, and does not accep=
t it */
+};
+
+struct ovpn_cap_query
+{
+    const struct ovpn_cap_req *req=
;
+
+    int cmd_policy; /* policy validating the doit of req->cmd, -1 unti=
l seen */
+    int sub_policy; /* where nested_attr points, -1 until seen *=
/
+    int type;       /* type of target_attr in the sub-policy, -1 until s=
een */
+
+    int err;        /* a message of the dump we could not parse *=
/
+};
+
+static struct nla_policy ovpn_cap_ctrl_policy[CTRL_ATTR_MAX + 1] =
=3D {
+    [CTRL_ATTR_POLICY] =3D { =2Etype =3D NLA_NESTED },
+    [CTRL_AT=
TR_OP_POLICY] =3D { =2Etype =3D NLA_NESTED },
+};
+
+static struct nla_poli=
cy ovpn_cap_op_policy[CTRL_ATTR_POLICY_DUMP_MAX + 1] =3D {
+    [CTRL_ATTR_=
POLICY_DO] =3D { =2Etype =3D NLA_U32 },
+};
+
+static struct nla_policy ovp=
n_cap_attr_policy[NL_POLICY_TYPE_ATTR_MAX + 1] =3D {
+    [NL_POLICY_TYPE_A=
TTR_TYPE] =3D { =2Etype =3D NLA_U32 },
+    [NL_POLICY_TYPE_ATTR_POLICY_IDX=
] =3D { =2Etype =3D NLA_U32 },
+};
+
+/*
+ * The command map arrives before=
 any policy, and the policies come in index
+ * order starting from the doi=
t one: netlink_policy_dump_add_policy() numbers
+ * them breadth-first and =
ctrl_dumppolicy() walks them in that order=2E A nested
+ * policy is theref=
ore always named before it is described, so one pass
+ * suffices and a lin=
k it did not find is not there=2E
+ */
+static int
+ovpn_cap_query_cb(struc=
t nl_msg *msg, void *arg)
+{
+    struct ovpn_cap_query *query =3D arg;
+  =
  struct nlattr *tb[CTRL_ATTR_MAX + 1];
+    const struct genlmsghdr *ghdr =
=3D nlmsg_data(nlmsg_hdr(msg));
+
+    /* one message of the dump: it carri=
es either the command map or a slice of
+     * one policy, and fills in wh=
ichever link of the chain it happens to hold */
+
+    query->err =3D nla_p=
arse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+                       =
    genlmsg_attrlen(ghdr, 0), ovpn_cap_ctrl_policy);
+    if (query->err)
+=
    {
+        return NL_STOP;
+    }
+
+    /* CTRL_ATTR_OP_POLICY: which =
policy validates the doit of each command */
+    if (tb[CTRL_ATTR_OP_POLIC=
Y])
+    {
+        const struct nlattr *nla_cmd;
+        int rem_cmd;
+
+=
        nla_for_each_nested(nla_cmd, tb[CTRL_ATTR_OP_POLICY], rem_cmd)
+   =
     {
+            struct nlattr *tb_cmd[CTRL_ATTR_POLICY_DUMP_MAX + 1];
+=

+            /* the dump is filtered, but do not rely on that */
+        =
    if (nla_type(nla_cmd) !=3D query->req->cmd)
+            {
+           =
     continue;
+            }
+
+            query->err =3D nla_parse(tb_cm=
d, CTRL_ATTR_POLICY_DUMP_MAX, nla_data(nla_cmd),
+                         =
          nla_len(nla_cmd), ovpn_cap_op_policy);
+            if (query->er=
r)
+            {
+                return NL_STOP;
+            }
+
+      =
      if (tb_cmd[CTRL_ATTR_POLICY_DO])
+            {
+                quer=
y->cmd_policy =3D (int)nla_get_u32(tb_cmd[CTRL_ATTR_POLICY_DO]);
+
+       =
         /* a requirement with no container looks for its target in the
+  =
               * command's own policy, so the search ends where it starts *=
/
+                if (!query->req->nested_attr)
+                {
+      =
              query->sub_policy =3D query->cmd_policy;
+                }
+=
            }
+        }
+    }
+
+    /* CTRL_ATTR_POLICY: which attribute=
s each policy accepts */
+    if (!tb[CTRL_ATTR_POLICY])
+    {
+        re=
turn NL_OK;
+    }
+
+    const struct nlattr *nla_policy;
+    int rem_pol=
icy;
+
+    nla_for_each_nested(nla_policy, tb[CTRL_ATTR_POLICY], rem_polic=
y)
+    {
+        struct nlattr *nla_attr;
+        int rem_attr;
+       =
 int policy_id =3D nla_type(nla_policy);
+
+        /* only the two policie=
s of the chain can hold anything we need */
+        if (policy_id !=3D que=
ry->cmd_policy && policy_id !=3D query->sub_policy)
+        {
+           =
 continue;
+        }
+
+        nla_for_each_nested(nla_attr, nla_policy, =
rem_attr)
+        {
+            struct nlattr *tb_attr[NL_POLICY_TYPE_ATT=
R_MAX + 1];
+            int attr_id =3D nla_type(nla_attr);
+
+           =
 if (attr_id !=3D query->req->nested_attr && attr_id !=3D query->req->targe=
t_attr)
+            {
+                continue;
+            }
+
+       =
     query->err =3D nla_parse_nested(tb_attr, NL_POLICY_TYPE_ATTR_MAX, nla_=
attr,
+                                          ovpn_cap_attr_policy);
+  =
          if (query->err)
+            {
+                return NL_STOP;
+=
            }
+
+            /* An attribute id only means something inside=
 its own policy, so
+             * each link is read where it belongs=2E F=
irst link: the nested
+             * attribute of the command's policy nam=
es the sub-policy=2E */
+            if (policy_id =3D=3D query->cmd_policy=
 && attr_id =3D=3D query->req->nested_attr
+                && tb_attr[NL_P=
OLICY_TYPE_ATTR_POLICY_IDX])
+            {
+                query->sub_pol=
icy =3D
+                    (int)nla_get_u32(tb_attr[NL_POLICY_TYPE_ATTR_P=
OLICY_IDX]);
+            }
+
+            /* Second link: the type the tar=
get has in that sub-policy=2E */
+            if (policy_id =3D=3D query->s=
ub_policy && attr_id =3D=3D query->req->target_attr
+                && tb_=
attr[NL_POLICY_TYPE_ATTR_TYPE])
+            {
+                query->type=
 =3D (int)nla_get_u32(tb_attr[NL_POLICY_TYPE_ATTR_TYPE]);
+            }
+ =
       }
+    }
+
+    return NL_OK;
+}
+
+/* Dump the policy of query->req=
->cmd and let the callback pick the chain out
+ * of it=2E Returns 0, or th=
e netlink error that kept us from reading it all=2E */
+static int
+ovpn_ca=
p_ask(struct ovpn_cap_query *query)
+{
+    struct nl_msg *nl_msg =3D NULL;=

+    int ret =3D 0;
+
+    struct nl_sock *nl_sock =3D nl_socket_alloc();
=
+    if (!nl_sock)
+    {
+        return -NLE_NOMEM;
+    }
+
+    ret =3D=
 genl_connect(nl_sock);
+    if (ret < 0)
+    {
+        goto out;
+    }
=
+    set_cloexec(nl_socket_get_fd(nl_sock));
+
+    nl_msg =3D nlmsg_alloc(=
);
+    if (!nl_msg)
+    {
+        ret =3D -NLE_NOMEM;
+        goto out;=

+    }
+
+    /* nlctrl has a fixed family id, so there is nothing to reso=
lve first=2E
+     * Unlike CTRL_CMD_GETFAMILY, CTRL_CMD_GETPOLICY does not=
 load the module:
+     * this relies on dco_available() having resolved th=
e family already=2E */
+    if (!genlmsg_put(nl_msg, NL_AUTO_PORT, NL_AUTO_=
SEQ, GENL_ID_CTRL, 0, NLM_F_DUMP,
+                     CTRL_CMD_GETPOLICY,=
 0))
+    {
+        ret =3D -NLE_MSGSIZE;
+        goto out;
+    }
+
+   =
 ret =3D nla_put_string(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_FAMILY_NAME);
+=
    if (ret < 0)
+    {
+        goto out;
+    }
+
+    ret =3D nla_put_u3=
2(nl_msg, CTRL_ATTR_OP, query->req->cmd);
+    if (ret < 0)
+    {
+       =
 goto out;
+    }
+
+    ret =3D nl_socket_modify_cb(nl_sock, NL_CB_VALID, =
NL_CB_CUSTOM, ovpn_cap_query_cb, query);
+    if (ret < 0)
+    {
+        =
goto out;
+    }
+
+    ret =3D nl_send_auto(nl_sock, nl_msg);
+    if (ret=
 < 0)
+    {
+        goto out;
+    }
+
+    ret =3D nl_recvmsgs_default(n=
l_sock);
+    if (ret >=3D 0)
+    {
+        ret =3D query->err;
+    }
+
=
+out:
+    nlmsg_free(nl_msg);
+    nl_socket_free(nl_sock);
+
+    return =
ret < 0 ? ret : 0;
+}
+
+/*
+ * Decide whether the kernel supports the requ=
irement, from the links the pass
+ * collected=2E A link the kernel never m=
entioned is a no=2E A dump that never
+ * named the policy of the command i=
s not an answer either way, and is
+ * reported as such, but the capability=
 stays off just the same=2E
+ */
+static enum ovpn_cap_status
+ovpn_cap_res=
olve(const struct ovpn_cap_query *query)
+{
+    /* the dump never named th=
e policy that validates the command */
+    if (query->cmd_policy < 0)
+   =
 {
+        return OVPN_CAP_UNKNOWN;
+    }
+
+    /* a link is missing: th=
e container or the target is not there */
+    if (query->sub_policy < 0 ||=
 query->type < 0)
+    {
+        return OVPN_CAP_UNSUPPORTED;
+    }
+
+  =
  /* the whole chain is there: a yes only if the attribute has the type we
=
+     * would be writing into it */
+    return (query->type =3D=3D query->=
req->expected_type) ? OVPN_CAP_SUPPORTED : OVPN_CAP_UNSUPPORTED;
+}
+
+/* R=
esolve one capability requirement against the running kernel=2E */
+static =
enum ovpn_cap_status
+ovpn_cap_probe_one(const struct ovpn_cap_req *req, in=
t *perr)
+{
+    struct ovpn_cap_query query =3D { =2Ereq =3D req, =2Ecmd_p=
olicy =3D -1, =2Esub_policy =3D -1, =2Etype =3D -1 };
+
+    *perr =3D ovpn=
_cap_ask(&query);
+    if (*perr)
+    {
+        return OVPN_CAP_UNKNOWN;
=
+    }
+
+    return ovpn_cap_resolve(&query);
+}
+
+unsigned int
+dco_prob=
e_capabilities(void)
+{
+    if (dco_caps_resolved)
+    {
+        return =
dco_caps;
+    }
+
+    /* no capability is defined yet: resolve one whose =
answer we already know */
+    static const struct ovpn_cap_req self_test =
=3D { 0, OVPN_CMD_PEER_NEW, OVPN_A_PEER,
+                                 =
                  OVPN_A_PEER_ID, NL_ATTR_TYPE_U32 };
+    int err =3D 0;
+=
    enum ovpn_cap_status status =3D ovpn_cap_probe_one(&self_test, &err);
+=

+    msg(D_DCO_DEBUG, "%s: policy introspection self-test: %s (status %d, =
err %d)", __func__,
+        status =3D=3D OVPN_CAP_SUPPORTED ? "ok" : "une=
xpected", (int)status, err);
+
+    dco_caps_resolved =3D true;
+    msg(D_=
DCO_DEBUG, "%s: DCO local capabilities: 0x%x", __func__, dco_caps);
+
+    =
return dco_caps;
+}
+
+#else  /* if HAVE_DECL_CTRL_ATTR_OP_POLICY */
+
+uns=
igned int
+dco_probe_capabilities(void)
+{
+    if (!dco_caps_resolved)
+  =
  {
+        msg(D_DCO_DEBUG,
+            "%s: built without netlink polic=
y introspection, no DCO capability can be detected",
+            __func__)=
;
+        dco_caps_resolved =3D true;
+    }
+
+    return dco_caps;
+}
+
=
+#endif /* if HAVE_DECL_CTRL_ATTR_OP_POLICY */
+
 static struct nl_msg *
 o=
vpn_dco_nlmsg_create(const dco_context_t *dco, uint8_t cmd)
 {
@@ -428,6 +7=
64,12 @@
 {
     dco->ovpn_dco_id =3D resolve_ovpn_netlink_id(M_FATAL);
 
+=
    /* nothing consumes the bitmap yet; resolve it here to exercise the pat=
h */
+    if (check_debug_level(D_DCO_DEBUG))
+    {
+        dco_probe_cap=
abilities();
+    }
+
     dco->nl_sock =3D nl_socket_alloc();
 
     if (!=
dco->nl_sock)
diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2E=
c
index a854045=2E=2Ef20be50 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src=
/openvpn/dco_win=2Ec
@@ -612,6 +612,12 @@
     return 0;
 }
 
+unsigned int=

+dco_probe_capabilities(void)
+{
+    return 0;
+}
+
 bool
 dco_available(=
msglvl_t msglevel)
 {
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b=
/tests/unit_tests/openvpn/Makefile=2Eam
index e3404754=2E=2Ed1dfac9 100644
=
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn=
/Makefile=2Eam
@@ -40,6 +40,12 @@
 endif
 endif
 
+if HAVE_SITNL
+if DCO_UN=
IT_TESTS
+test_binaries +=3D dco_testdriver
+endif
+endif
+
 if !CROSS_COMP=
ILING
 TESTS =3D $(test_binaries)
 endif
@@ -452,4 +458,16 @@
 	$(top_srcdi=
r)/src/openvpn/run_command=2Ec \
 	$(top_srcdir)/src/openvpn/socket_util=2E=
c
 
+dco_testdriver_CFLAGS  =3D \
+	-I$(top_srcdir)/include -I$(top_srcdir)=
/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO=
_CFLAGS)
+dco_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ $(OPTIONAL_CRYPTO_LIBS)=

+dco_testdriver_SOURCES =3D test_dco=2Ec \
+	mock_msg=2Ec mock_msg=2Eh moc=
k_dco_dependencies=2Ec mock_get_random=2Ec test_common=2Eh \
+	$(top_srcdir=
)/src/compat/compat-strlcpy=2Ec \
+	$(top_srcdir)/src/openvpn/buffer=2Ec \
=
+	$(top_srcdir)/src/openvpn/fdmisc=2Ec \
+	$(top_srcdir)/src/openvpn/platfo=
rm=2Ec \
+	$(top_srcdir)/src/openvpn/win32-util=2Ec
+
 build-tests-local: $=
(check_PROGRAMS)
diff --git a/tests/unit_tests/openvpn/mock_dco_dependencie=
s=2Ec b/tests/unit_tests/openvpn/mock_dco_dependencies=2Ec
new file mode 10=
0644
index 0000000=2E=2Ee7f20f5
--- /dev/null
+++ b/tests/unit_tests/openvp=
n/mock_dco_dependencies=2Ec
@@ -0,0 +1,80 @@
+/*
+ *  OpenVPN -- An applica=
tion to securely tunnel IP networks
+ *             over a single UDP port,=
 with support for SSL/TLS-based
+ *             session authentication and =
key exchange,
+ *             packet encryption, packet authentication, and=

+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 Ope=
nVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2026 Gianmarco De Gregori=
 <gianmarco@mandelbit=2Ecom>
+ *
+ *  This program is free software; you ca=
n redistribute it and/or modify
+ *  it under the terms of the GNU General =
Public License version 2
+ *  as published by the Free Software Foundation=
=2E
+ *
+ *  This program is distributed in the hope that it will be useful=
,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Ge=
neral Public License for more details=2E
+ *
+ *  You should have received =
a copy of the GNU General Public License along
+ *  with this program; if n=
ot, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/*
+ *  Stubs for wh=
at dco_linux=2Ec drags in but capability probing never reaches:
+ *  the da=
ta path, the event loop and the signal machinery=2E
+ */
+
+#ifdef HAVE_CON=
FIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+#include "d=
co=2Eh"
+#include "crypto_backend=2Eh"
+#include "forward=2Eh"
+#include "m=
ulti=2Eh"
+#include "networking=2Eh"
+#include "socket_util=2Eh"
+
+void
+m=
ulti_process_incoming_dco(dco_context_t *dco)
+{
+}
+
+void
+process_incomi=
ng_dco(dco_context_t *dco)
+{
+}
+
+void
+register_signal(struct signal_inf=
o *si, int signum, const char *signal_text)
+{
+}
+
+int
+net_iface_new(con=
st openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const char *ty=
pe,
+              const void *arg)
+{
+    return 0;
+}
+
+int
+net_iface_=
del(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface)
+{
+   =
 return 0;
+}
+
+unsigned int
+cipher_kt_key_size(const char *ciphername)
+=
{
+    return 0;
+}
+
+const char *
+print_sockaddr_ex(const struct sockadd=
r *addr, const char *separator, const unsigned int flags,
+                =
  struct gc_arena *gc)
+{
+    return "[mock]";
+}
diff --git a/tests/unit_=
tests/openvpn/test_dco=2Ec b/tests/unit_tests/openvpn/test_dco=2Ec
new file=
 mode 100644
index 0000000=2E=2E4bfa619
--- /dev/null
+++ b/tests/unit_test=
s/openvpn/test_dco=2Ec
@@ -0,0 +1,427 @@
+/*
+ *  OpenVPN -- An application=
 to securely tunnel IP networks
+ *             over a single UDP port, wit=
h support for SSL/TLS-based
+ *             session authentication and key =
exchange,
+ *             packet encryption, packet authentication, and
+ *=
             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN=
 Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2026 Gianmarco De Gregori <gi=
anmarco@mandelbit=2Ecom>
+ *
+ *  This program is free software; you can re=
distribute it and/or modify
+ *  it under the terms of the GNU General Publ=
ic License version 2
+ *  as published by the Free Software Foundation=2E
+=
 *
+ *  This program is distributed in the hope that it will be useful,
+ *=
  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCH=
ANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General=
 Public License for more details=2E
+ *
+ *  You should have received a cop=
y of the GNU General Public License along
+ *  with this program; if not, s=
ee <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/*
+ *  Unit tests for th=
e DCO capability queries=2E
+ *
+ *  Resolving a requirement is a single pa=
ss over a policy dump followed by a
+ *  look at what the pass collected=2E=
 The pass is fed dumps built by hand and
+ *  the decision is fed a query f=
illed in directly, which between them cover
+ *  what would otherwise need =
a particular kernel=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
=
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdarg=2Eh>
+#include <setjm=
p=2Eh>
+#include <cmocka=2Eh>
+
+#include "dco_linux=2Ec"
+
+#define CMD_PO=
LICY   4
+#define SUB_POLICY   9
+#define OTHER_POLICY 7
+
+/* the bit is n=
ever read here, only the chain that would set it */
+static const struct ov=
pn_cap_req test_req =3D { =2Ecap =3D 1u,
+                                 =
             =2Ecmd =3D OVPN_CMD_PEER_NEW,
+                               =
               =2Enested_attr =3D OVPN_A_PEER,
+                           =
                   =2Etarget_attr =3D OVPN_A_PEER_KEEPALIVE_INTERVAL,
+    =
                                          =2Eexpected_type =3D NL_ATTR_TYPE=
_U32 };
+
+/* the same requirement without a container: the target sits in =
the command's
+ * own policy */
+static const struct ovpn_cap_req flat_req =
=3D { =2Ecap =3D 1u,
+                                              =2Ecmd =
=3D OVPN_CMD_PEER_NEW,
+                                              =2Ene=
sted_attr =3D 0,
+                                              =2Etarget_a=
ttr =3D OVPN_A_IFINDEX,
+                                              =2Ee=
xpected_type =3D NL_ATTR_TYPE_U32 };
+
+static struct ovpn_cap_query
+new_q=
uery_for(const struct ovpn_cap_req *req)
+{
+    struct ovpn_cap_query quer=
y =3D { =2Ereq =3D req, =2Ecmd_policy =3D -1, =2Esub_policy =3D -1, =2Etype=
 =3D -1 };
+
+    return query;
+}
+
+static struct ovpn_cap_query
+new_que=
ry(void)
+{
+    return new_query_for(&test_req);
+}
+
+/* a CTRL_ATTR_OP_P=
OLICY message saying which policy validates `cmd` */
+static struct nl_msg =
*
+msg_op_policy(uint16_t cmd, uint32_t do_policy)
+{
+    struct nl_msg *m=
sg =3D nlmsg_alloc();
+    struct nlattr *ops, *op;
+
+    assert_non_null(=
msg);
+    assert_non_null(genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, 0, 0=
, 0, CTRL_CMD_GETPOLICY, 0));
+
+    ops =3D nla_nest_start(msg, CTRL_ATTR_=
OP_POLICY);
+    op =3D nla_nest_start(msg, cmd);
+    assert_int_equal(nla=
_put_u32(msg, CTRL_ATTR_POLICY_DO, do_policy), 0);
+    nla_nest_end(msg, o=
p);
+    nla_nest_end(msg, ops);
+
+    return msg;
+}
+
+/* one attribute =
of a policy: its id, which field of its descriptor to set,
+ * and the valu=
e to put there */
+struct attr_desc
+{
+    uint16_t attr_id;
+    int fiel=
d;
+    uint32_t value;
+};
+
+/* a CTRL_ATTR_POLICY message describing `n`=
 attributes of one policy */
+static struct nl_msg *
+msg_policy_attrs(uint=
16_t policy_id, const struct attr_desc *descs, size_t n)
+{
+    struct nl_=
msg *msg =3D nlmsg_alloc();
+    struct nlattr *policies, *policy, *attr;
+=

+    assert_non_null(msg);
+    assert_non_null(genlmsg_put(msg, NL_AUTO_P=
ORT, NL_AUTO_SEQ, 0, 0, 0, CTRL_CMD_GETPOLICY, 0));
+
+    policies =3D nla=
_nest_start(msg, CTRL_ATTR_POLICY);
+    policy =3D nla_nest_start(msg, pol=
icy_id);
+    for (size_t i =3D 0; i < n; i++)
+    {
+        attr =3D nla=
_nest_start(msg, descs[i]=2Eattr_id);
+        assert_int_equal(nla_put_u32=
(msg, descs[i]=2Efield, descs[i]=2Evalue), 0);
+        nla_nest_end(msg, a=
ttr);
+    }
+    nla_nest_end(msg, policy);
+    nla_nest_end(msg, policie=
s);
+
+    return msg;
+}
+
+/* the shape the kernel actually sends: one at=
tribute per message */
+static struct nl_msg *
+msg_policy_attr(uint16_t po=
licy_id, uint16_t attr_id, int field, uint32_t value)
+{
+    const struct =
attr_desc one =3D { attr_id, field, value };
+
+    return msg_policy_attrs=
(policy_id, &one, 1);
+}
+
+static void
+feed(struct ovpn_cap_query *query,=
 struct nl_msg *msg)
+{
+    assert_int_equal(ovpn_cap_query_cb(msg, query)=
, NL_OK);
+    nlmsg_free(msg);
+}
+
+/* Walk the whole chain, with both po=
licies carrying attributes we are not
+ * after and the ones we are neither=
 first nor last, so that the pass has to
+ * skip past them rather than sto=
p at the first mismatch=2E */
+static void
+feed_full_chain(struct ovpn_cap=
_query *query)
+{
+    const struct attr_desc cmd_attrs[] =3D {
+        { =
OVPN_A_IFINDEX, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U32 },
+        { OV=
PN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX, SUB_POLICY },
+        { OVPN_A_=
KEYCONF, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_NESTED },
+    };
+    cons=
t struct attr_desc sub_attrs[] =3D {
+        { OVPN_A_PEER_ID, NL_POLICY_T=
YPE_ATTR_TYPE, NL_ATTR_TYPE_U32 },
+        { OVPN_A_PEER_REMOTE_PORT, NL_P=
OLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U16 },
+        { test_req=2Etarget_attr=
, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U32 },
+        { OVPN_A_PEER_LOCA=
L_PORT, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U16 },
+    };
+
+    feed(q=
uery, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(query, msg_p=
olicy_attrs(CMD_POLICY, cmd_attrs, SIZE(cmd_attrs)));
+    feed(query, msg_=
policy_attrs(SUB_POLICY, sub_attrs, SIZE(sub_attrs)));
+}
+
+/* the map tel=
ls us which policy validates the command we asked about */
+static void
+te=
st_reads_command_policy(void **state)
+{
+    struct ovpn_cap_query query =
=3D new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_P=
OLICY));
+    assert_int_equal(query=2Ecmd_policy, CMD_POLICY);
+}
+
+/* an=
d not about another one, even though the dump is supposed to be filtered */=

+static void
+test_ignores_other_command(void **state)
+{
+    struct ovpn=
_cap_query query =3D new_query();
+
+    feed(&query, msg_op_policy(OVPN_CM=
D_PEER_DEL, CMD_POLICY));
+    assert_int_equal(query=2Ecmd_policy, -1);
+}=

+
+/* the nested attribute of that policy points at the sub-policy */
+sta=
tic void
+test_follows_nested_attribute(void **state)
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
+    assert_int_equal(query=2Esub_policy, SUB_POLICY);
+}
+
+/=
* an attribute id only means something inside its own policy, so the same
+=
 * number elsewhere says nothing about our question: a command policy witho=
ut
+ * the container is a no, whatever comes after it */
+static void
+test=
_ignores_nested_attribute_elsewhere(void **state)
+{
+    struct ovpn_cap_q=
uery query =3D new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER=
_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_A_IF=
INDEX, NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL_ATTR_=
TYPE_U32));
+    feed(&query, msg_policy_attr(OTHER_POLICY, OVPN_A_PEER, NL=
_POLICY_TYPE_ATTR_POLICY_IDX,
+                                 SUB_POLICY)=
);
+    feed(&query, msg_policy_attr(SUB_POLICY, test_req=2Etarget_attr, NL=
_POLICY_TYPE_ATTR_TYPE,
+                                 NL_ATTR_TYPE_U32)=
);
+    assert_int_equal(query=2Esub_policy, -1);
+    assert_int_equal(ovp=
n_cap_resolve(&query), OVPN_CAP_UNSUPPORTED);
+}
+
+/* the type of the targ=
et attribute is read in the sub-policy */
+static void
+test_reads_target_t=
ype(void **state)
+{
+    struct ovpn_cap_query query =3D new_query();
+
+ =
   feed_full_chain(&query);
+    assert_int_equal(query=2Etype, NL_ATTR_TYP=
E_U32);
+}
+
+/* and the same holds for the target attribute: a type read o=
ff some other
+ * policy is not an answer to what we asked */
+static void
=
+test_ignores_target_attribute_elsewhere(void **state)
+{
+    struct ovpn_=
cap_query query =3D new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD=
_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN=
_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                                 =
SUB_POLICY));
+    feed(&query, msg_policy_attr(OTHER_POLICY, test_req=2Eta=
rget_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL_A=
TTR_TYPE_U32));
+    assert_int_equal(query=2Etype, -1);
+}
+
+/* the comma=
nd's own policy does get read, so the target attribute has to be
+ * turned=
 away there too: the same id there is a different attribute */
+static void=

+test_ignores_target_attribute_in_command_policy(void **state)
+{
+    str=
uct ovpn_cap_query query =3D new_query();
+
+    feed(&query, msg_op_policy=
(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POL=
ICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                        =
         SUB_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, test_r=
eq=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                              =
   NL_ATTR_TYPE_U32));
+    assert_int_equal(query=2Etype, -1);
+}
+
+/* th=
e sub-policy is read too, so the nested attribute has to be turned away
+ *=
 there as well */
+static void
+test_ignores_nested_attribute_in_sub_policy=
(void **state)
+{
+    struct ovpn_cap_query query =3D new_query();
+
+    =
feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&quer=
y, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,=

+                                 SUB_POLICY));
+    feed(&query, msg_poli=
cy_attr(SUB_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+         =
                        OTHER_POLICY));
+    assert_int_equal(query=2Esub_p=
olicy, SUB_POLICY);
+}
+
+/* an attribute that is there but not as a nest h=
as nothing to follow */
+static void
+test_nested_attribute_without_policy_=
idx(void **state)
+{
+    struct ovpn_cap_query query =3D new_query();
+
+ =
   feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&q=
uery, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_TYPE,
+ =
                                NL_ATTR_TYPE_U32));
+    assert_int_equal(q=
uery=2Esub_policy, -1);
+}
+
+/* and one that is a nest says nothing about =
the type we are after */
+static void
+test_target_attribute_without_type(v=
oid **state)
+{
+    struct ovpn_cap_query query =3D new_query();
+
+    fe=
ed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query,=
 msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+=
                                 SUB_POLICY));
+    feed(&query, msg_policy=
_attr(SUB_POLICY, test_req=2Etarget_attr,
+                                =
 NL_POLICY_TYPE_ATTR_POLICY_IDX, OTHER_POLICY));
+    assert_int_equal(quer=
y=2Etype, -1);
+}
+
+/* a flat requirement needs no hop: the command's poli=
cy is where to look */
+static void
+test_flat_requirement_reads_command_po=
licy(void **state)
+{
+    struct ovpn_cap_query query =3D new_query_for(&f=
lat_req);
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY))=
;
+    assert_int_equal(query=2Esub_policy, CMD_POLICY);
+
+    feed(&query=
, msg_policy_attr(CMD_POLICY, flat_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_T=
YPE,
+                                 NL_ATTR_TYPE_U32));
+    assert_int_=
equal(ovpn_cap_resolve(&query), OVPN_CAP_SUPPORTED);
+}
+
+/* and an absent=
 one is a plain no */
+static void
+test_flat_requirement_absent_is_unsuppo=
rted(void **state)
+{
+    struct ovpn_cap_query query =3D new_query_for(&f=
lat_req);
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY))=
;
+    feed(&query, msg_policy_attr(OTHER_POLICY, flat_req=2Etarget_attr, N=
L_POLICY_TYPE_ATTR_TYPE,
+                                 NL_ATTR_TYPE_U32=
));
+    assert_int_equal(ovpn_cap_resolve(&query), OVPN_CAP_UNSUPPORTED);
=
+}
+
+/* a message we cannot parse stops the pass with an error, rather tha=
n
+ * leaving a hole that would read as a no */
+static void
+test_malforme=
d_message_stops(void **state)
+{
+    struct ovpn_cap_query query =3D new_q=
uery();
+    struct nl_msg *msg =3D nlmsg_alloc();
+    struct nlattr *ops,=
 *op;
+
+    assert_non_null(msg);
+    assert_non_null(genlmsg_put(msg, NL=
_AUTO_PORT, NL_AUTO_SEQ, 0, 0, 0, CTRL_CMD_GETPOLICY, 0));
+    ops =3D nla=
_nest_start(msg, CTRL_ATTR_OP_POLICY);
+    op =3D nla_nest_start(msg, OVPN=
_CMD_PEER_NEW);
+    assert_int_equal(nla_put_u16(msg, CTRL_ATTR_POLICY_DO,=
 CMD_POLICY), 0);
+    nla_nest_end(msg, op);
+    nla_nest_end(msg, ops);
=
+
+    assert_int_equal(ovpn_cap_query_cb(msg, &query), NL_STOP);
+    asse=
rt_true(query=2Eerr < 0);
+    assert_int_equal(query=2Ecmd_policy, -1);
+ =
   nlmsg_free(msg);
+}
+
+/* nothing to read an answer out of is not the sa=
me as a "no" */
+static void
+test_resolve_without_command_policy(void **st=
ate)
+{
+    struct ovpn_cap_query query =3D new_query();
+
+    assert_int=
_equal(ovpn_cap_resolve(&query), OVPN_CAP_UNKNOWN);
+}
+
+/* a kernel that =
does not nest the attribute simply never mentions it */
+static void
+test_=
resolve_nested_absent(void **state)
+{
+    struct ovpn_cap_query query =3D=
 new_query();
+
+    query=2Ecmd_policy =3D CMD_POLICY;
+    assert_int_equ=
al(ovpn_cap_resolve(&query), OVPN_CAP_UNSUPPORTED);
+}
+
+/* the sub-policy=
 is there but does not define the attribute: the ordinary no */
+static voi=
d
+test_resolve_target_absent(void **state)
+{
+    struct ovpn_cap_query q=
uery =3D new_query();
+
+    query=2Ecmd_policy =3D CMD_POLICY;
+    query=
=2Esub_policy =3D SUB_POLICY;
+    assert_int_equal(ovpn_cap_resolve(&query=
), OVPN_CAP_UNSUPPORTED);
+}
+
+/* right name, wrong type: not the attribut=
e we would be writing */
+static void
+test_resolve_wrong_type(void **state=
)
+{
+    struct ovpn_cap_query query =3D new_query();
+
+    query=2Ecmd_p=
olicy =3D CMD_POLICY;
+    query=2Esub_policy =3D SUB_POLICY;
+    query=2E=
type =3D NL_ATTR_TYPE_U8;
+    assert_int_equal(ovpn_cap_resolve(&query), O=
VPN_CAP_UNSUPPORTED);
+}
+
+/* and the whole chain, from a dump to a yes */=

+static void
+test_resolve_complete_chain(void **state)
+{
+    struct ovp=
n_cap_query query =3D new_query();
+
+    feed_full_chain(&query);
+    ass=
ert_int_equal(ovpn_cap_resolve(&query), OVPN_CAP_SUPPORTED);
+}
+
+int
+mai=
n(void)
+{
+    const struct CMUnitTest tests[] =3D {
+        cmocka_unit_=
test(test_reads_command_policy),
+        cmocka_unit_test(test_ignores_oth=
er_command),
+        cmocka_unit_test(test_follows_nested_attribute),
+   =
     cmocka_unit_test(test_ignores_nested_attribute_elsewhere),
+        cm=
ocka_unit_test(test_reads_target_type),
+        cmocka_unit_test(test_igno=
res_target_attribute_elsewhere),
+        cmocka_unit_test(test_ignores_tar=
get_attribute_in_command_policy),
+        cmocka_unit_test(test_ignores_ne=
sted_attribute_in_sub_policy),
+        cmocka_unit_test(test_nested_attrib=
ute_without_policy_idx),
+        cmocka_unit_test(test_target_attribute_wi=
thout_type),
+        cmocka_unit_test(test_flat_requirement_reads_command_=
policy),
+        cmocka_unit_test(test_flat_requirement_absent_is_unsuppor=
ted),
+        cmocka_unit_test(test_malformed_message_stops),
+        cmo=
cka_unit_test(test_resolve_without_command_policy),
+        cmocka_unit_te=
st(test_resolve_nested_absent),
+        cmocka_unit_test(test_resolve_targ=
et_absent),
+        cmocka_unit_test(test_resolve_wrong_type),
+        cm=
ocka_unit_test(test_resolve_complete_chain),
+    };
+
+    return cmocka_r=
un_group_tests_name("dco", tests, NULL, NULL);
+}

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e=
6
Gerrit-Change-Number: 1981
Gerrit-PatchSet: 3
Gerrit-Owner: Gianmarco De =
Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianmarco@ma=
ndelbit=2Ecom>

--KgEJbHUCgUc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori, Ralf Lici=2E </p>=

<p>Gianmarco De Gregori <strong>uploaded patch set #3</strong> to this cha=
nge=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review-1 by Ralf Lici</p><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">dco: detect local k=
ernel capabilities through netlink policies<br><br>The ovpn module lives in=
 the kernel, so the attributes it accepts may<br>differ from what we were b=
uilt against=2E CTRL_CMD_GETPOLICY dumps the<br>validation policy of a fami=
ly: which attributes each command takes, of<br>what type, and for a nested =
one the sub-policy that validates it=2E<br><br>Add a helper to query it, wr=
apped in dco_probe_capabilities() so the<br>rest of the tree never talks to=
 netlink itself=2E Answering a requirement<br>means following a chain - whi=
ch policy validates the command, where its<br>nested attribute points if it=
 has one, what type the target attribute<br>has there - and CTRL_ATTR_OP na=
rrows the dump enough to collect all<br>three in one pass=2E<br><br>The ans=
wer has three values rather than two: without &quot;could not ask&quot;, a<=
br>netlink error would look the same as an old kernel=2E<br><br>The query n=
eeds uapi headers from 5=2E10 or later=2E Built against older<br>ones, it i=
s left out and dco_probe_capabilities() reports no capability=2E<br><br>No =
capability is defined yet, so the bitmap comes back empty; the rows<br>that=
 fill it arrive with the features that need them=2E The unit test<br>drives=
 the pass and the decision separately, on dumps built by hand=2E<br><br>Cha=
nge-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6<br>Signed-off-by: Gianmar=
co De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M CMakeLists=2Etx=
t<br>M config=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M src/openvpn/dco=2Eh=
<br>M src/openvpn/dco_freebsd=2Ec<br>M src/openvpn/dco_linux=2Ec<br>M src/o=
penvpn/dco_win=2Ec<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/u=
nit_tests/openvpn/mock_dco_dependencies=2Ec<br>A tests/unit_tests/openvpn/t=
est_dco=2Ec<br>10 files changed, 911 insertions(+), 0 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/81/1981/3</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt=
</span><br><span>index 50b2d68=2E=2E593c511 100644</span><br><span>--- a/CM=
akeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -1=
9,6 +19,7 @@</span><br><span> include(CheckLinkerFlag OPTIONAL)</span><br><=
span> include(CheckTypeSize)</span><br><span> include(CheckStructHasMember)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+include(CheckCSourc=
eCompiles)</span><br><span> include(CTest)</span><br><span> </span><br><spa=
n> option(UNSUPPORTED_BUILDS &quot;Allow unsupported builds&quot; OFF)</spa=
n><br><span>@@ -205,6 +206,11 @@</span><br><span>     check_symbol_exists(g=
etpeereid &quot;unistd=2Eh;sys/socket=2Eh&quot; HAVE_GETPEEREID)</span><br>=
<span> endif()</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+if (ENABLE_LINUXDCO)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    check_c_source_compiles(&quot;#include &lt;linux/genetlin=
k=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int main(v=
oid) { return CTRL_ATTR_OP_POLICY; }&quot; HAVE_DECL_CTRL_ATTR_OP_POLICY)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif ()</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> check_include_=
files(grp=2Eh HAVE_GRP_H)</span><br><span> if (HAVE_GRP_H)</span><br><span>=
     check_symbol_exists(getgrnam grp=2Eh HAVE_GETGRNAM)</span><br><span>di=
ff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><spa=
n>index f7818cf=2E=2Eaa21532 100644</span><br><span>--- a/config=2Eh=2Ecmak=
e=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -87=
,6 +87,9 @@</span><br><span> /* Define to 1 if you have the `daemon&#39; fu=
nction=2E */</span><br><span> #cmakedefine HAVE_DAEMON</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if linu=
x/genetlink=2Eh has netlink policy introspection (5=2E10) */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine01 HAVE_DECL_CTRL_ATTR=
_OP_POLICY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> /* Define to 1 if you have the &lt;direct=2Eh&gt; header file=2E *=
/</span><br><span> #cmakedefine HAVE_DIRECT_H</span><br><span> </span><br><=
span>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>index 585=
c3bd=2E=2E5a19f25 100644</span><br><span>--- a/configure=2Eac</span><br><sp=
an>+++ b/configure=2Eac</span><br><span>@@ -692,6 +692,11 @@</span><br><spa=
n> 				OPTIONAL_LIBNL_GENL_CFLAGS=3D&quot;${LIBNL_GENL_CFLAGS}&quot;</span>=
<br><span> 				OPTIONAL_LIBNL_GENL_LIBS=3D&quot;${LIBNL_GENL_LIBS}&quot;</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+				=
dnl</span><br><span style=3D"color: hsl(120, 100%, 40%);">+				dnl Netlink =
policy introspection needs uapi headers from 5=2E10</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+				dnl</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+				AC_CHECK_DECLS([CTRL_ATTR_OP_POLICY], , , [[#incl=
ude &lt;linux/genetlink=2Eh&gt;]])</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> 				AC_DEFINE(ENABLE_DCO, 1, [Enable share=
d data channel offload])</span><br><span> 				AC_MSG_NOTICE([Enabled ovpn-d=
co (via ovpn kernel module) support for Linux])</span><br><span> 			fi</spa=
n><br><span>@@ -1340,6 +1345,7 @@</span><br><span> AC_SUBST([PLUGIN_AUTH_PA=
M_LIBS])</span><br><span> </span><br><span> AM_CONDITIONAL([WIN32], [test &=
quot;${WIN32}&quot; =3D &quot;yes&quot;])</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+AM_CONDITIONAL([DCO_UNIT_TESTS], [test &quot;${ac_cv_=
have_decl_CTRL_ATTR_OP_POLICY}&quot; =3D &quot;yes&quot;])</span><br><span>=
 AM_CONDITIONAL([GIT_CHECKOUT], [test &quot;${GIT_CHECKOUT}&quot; =3D &quot=
;yes&quot;])</span><br><span> AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [tes=
t &quot;${enable_plugin_auth_pam}&quot; =3D &quot;yes&quot;])</span><br><sp=
an> AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test &quot;${enable_plugin_d=
own_root}&quot; =3D &quot;yes&quot;])</span><br><span>diff --git a/src/open=
vpn/dco=2Eh b/src/openvpn/dco=2Eh</span><br><span>index c435f8c=2E=2Efba179=
5 100644</span><br><span>--- a/src/openvpn/dco=2Eh</span><br><span>+++ b/sr=
c/openvpn/dco=2Eh</span><br><span>@@ -254,6 +254,17 @@</span><br><span>  */=
</span><br><span> bool</span><br><span> dco_supports_epoch_data(const struc=
t context *c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Return a bitmap of DCO_CAP_* bits des=
cribing the negotiable features the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * local kernel supports=2E Everything DCO does without neg=
otiating is available</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * regardless=2E Resolved once and reused; platforms without capability p=
robing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * return 0=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return  bitmask of DCO_CAP_* =
flags; 0 both when the kernel negotiates none</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *          of them and when it could not be aske=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+unsigned int dco_probe_capabilitie=
s(void);</span><br><span> #else  /* if defined(ENABLE_DCO) */</span><br><sp=
an> </span><br><span> typedef void *dco_context_t;</span><br><span>@@ -388,=
5 +399,11 @@</span><br><span> {</span><br><span>     return false;</span><b=
r><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static inline unsigned int</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_probe_capabilitie=
s(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #endif /* defined=
(ENABLE_DCO) */</span><br><span> #endif /* ifndef DCO_H */</span><br><span>=
diff --git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec</spa=
n><br><span>index 11b8dff=2E=2E9613c63 100644</span><br><span>--- a/src/ope=
nvpn/dco_freebsd=2Ec</span><br><span>+++ b/src/openvpn/dco_freebsd=2Ec</spa=
n><br><span>@@ -707,6 +707,12 @@</span><br><span>     return 0;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+d=
co_probe_capabilities(void)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><=
span> dco_available(msglvl_t msglevel)</span><br><span> {</span><br><span>d=
iff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br=
><span>index 3a55b6e=2E=2E7b5bd07 100644</span><br><span>--- a/src/openvpn/=
dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br><sp=
an>@@ -103,6 +103,342 @@</span><br><span>     return ret;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* What the local kernel supports=2E It cannot change while we run, so the =
first</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * caller reso=
lves it and the rest just read it=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static unsigned int dco_caps =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static bool dco_caps_resolved =3D false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if HAVE_DECL_CTRL_ATTR_OP_POLICY</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Netlink policy introspection: the ovp=
n module lives in the kernel, so the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * attributes it accepts may differ from what we were buil=
t against=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * CTRL=
_CMD_GETPOLICY says which attributes a command takes and of what type,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and CTRL_ATTR_OP narr=
ows the dump to a single command=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* One row per capa=
bility, each resolved with a dump of its own=2E A row can</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * only ask for an attribute the dump=
 reports: UNSPEC and REJECT ones never</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * appear, and before Linux 7=2E4 neither do BE16/BE32 o=
nes (b785f5c56fb3)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+struct ovpn_cap_req</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned =
int cap;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_=
t cmd;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t =
nested_attr; /* 0 if target_attr is not nested */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    uint16_t target_attr;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int expected_type;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/** the outcome of resolving one capability requirement */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+enum ovpn_cap_status</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    OVPN_CAP_UNKNOWN,     /**&lt; the question cou=
ld not be asked */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   OVPN_CAP_SUPPORTED,   /**&lt; the kernel accepts the attribute */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CAP_UNSUPPORTED, =
/**&lt; the kernel answered, and does not accept it */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
truct ovpn_cap_query</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct =
ovpn_cap_req *req;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int cmd_policy; =
/* policy validating the doit of req-&gt;cmd, -1 until seen */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int sub_policy; /* where nes=
ted_attr points, -1 until seen */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    int type;       /* type of target_attr in the sub-policy,=
 -1 until seen */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int err;        /=
* a message of the dump we could not parse */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static str=
uct nla_policy ovpn_cap_ctrl_policy[CTRL_ATTR_MAX + 1] =3D {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    [CTRL_ATTR_POLICY] =3D { =2Ety=
pe =3D NLA_NESTED },</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    [CTRL_ATTR_OP_POLICY] =3D { =2Etype =3D NLA_NESTED },</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static struct nla_policy ovpn_cap_op_policy[CTRL_ATTR_POLICY_DUMP_MAX + =
1] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    [CTRL_A=
TTR_POLICY_DO] =3D { =2Etype =3D NLA_U32 },</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struc=
t nla_policy ovpn_cap_attr_policy[NL_POLICY_TYPE_ATTR_MAX + 1] =3D {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    [NL_POLICY_TYPE_ATTR_T=
YPE] =3D { =2Etype =3D NLA_U32 },</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    [NL_POLICY_TYPE_ATTR_POLICY_IDX] =3D { =2Etype =3D NLA_U3=
2 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * The command map arrives before any policy, and the policies come =
in index</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * order st=
arting from the doit one: netlink_policy_dump_add_policy() numbers</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * them breadth-first and ct=
rl_dumppolicy() walks them in that order=2E A nested</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * policy is therefore always named befor=
e it is described, so one pass</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * suffices and a link it did not find is not there=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ovpn_cap_query_cb(struct nl_msg *msg, void *arg)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query *query =3D arg;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nlattr *=
tb[CTRL_ATTR_MAX + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const struct genlmsghdr *ghdr =3D nlmsg_data(nlmsg_hdr(msg));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* one message of the dump: it carries ei=
ther the command map or a slice of</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * one policy, and fills in whichever link of the chain =
it happens to hold */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    query-&gt;err=
 =3D nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(ghdr, 0),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                           genlmsg=
_attrlen(ghdr, 0), ovpn_cap_ctrl_policy);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (query-&gt;err)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return NL_STOP;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* CTRL_ATTR_O=
P_POLICY: which policy validates the doit of each command */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (tb[CTRL_ATTR_OP_POLICY])</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        const struct nlattr *nla_cm=
d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int rem_c=
md;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        nla_for_each_nested(nla_cmd=
, tb[CTRL_ATTR_OP_POLICY], rem_cmd)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            struct nlattr *tb_cmd[CTRL_ATTR_POLICY_DUMP_MAX + 1];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* the dump is filtered, but =
do not rely on that */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (nla_type(nla_cmd) !=3D query-&gt;req-&gt;cmd)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                continue;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            query-&gt;err =3D nla_parse(tb_cmd, CTRL_AT=
TR_POLICY_DUMP_MAX, nla_data(nla_cmd),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                   nla_len(nla_cmd), ovp=
n_cap_op_policy);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (query-&gt;err)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                return NL_STOP;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (tb_cmd[CTRL_ATTR_POLICY_DO])</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                query-&gt;cmd_policy =3D (int)nla_get_u32(tb_cmd[C=
TRL_ATTR_POLICY_DO]);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /=
* a requirement with no container looks for its target in the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                 * command&#39;s =
own policy, so the search ends where it starts */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                if (!query-&gt;req-&gt;nested=
_attr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     query-&gt;sub_policy =3D query-&gt;cmd_policy;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
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
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* only the t=
wo policies of the chain can hold anything we need */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (policy_id !=3D query-&gt;cmd_=
policy &amp;&amp; policy_id !=3D query-&gt;sub_policy)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            continue;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      nla_for_each_nested(nla_attr, nla_policy, rem_attr)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            struct nlattr *tb_attr[NL_POLICY_TY=
PE_ATTR_MAX + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          int attr_id =3D nla_type(nla_attr);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (attr_id !=3D query-&gt;req-&gt;nested_attr &amp;&amp=
; attr_id !=3D query-&gt;req-&gt;target_attr)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                continue;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            query-&gt;err =3D nla_parse_nested(tb_attr, NL_POLICY_TYPE_ATT=
R_MAX, nla_attr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                       ovpn_cap_attr_policy);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (query-&gt;err)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                return NL_ST=
OP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* An attribute id only means=
 something inside its own policy, so</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+             * each link is read where it belongs=2E First=
 link: the nested</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
           * attribute of the command&#39;s policy names the sub-policy=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (p=
olicy_id =3D=3D query-&gt;cmd_policy &amp;&amp; attr_id =3D=3D query-&gt;re=
q-&gt;nested_attr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              &amp;&amp; tb_attr[NL_POLICY_TYPE_ATTR_POLICY_IDX])</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                query-&gt;sub_polic=
y =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      (int)nla_get_u32(tb_attr[NL_POLICY_TYPE_ATTR_POLICY_IDX]);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            /* Second link: the type the target has in =
that sub-policy=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (policy_id =3D=3D query-&gt;sub_policy &amp;&amp; attr_id =
=3D=3D query-&gt;req-&gt;target_attr</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                &amp;&amp; tb_attr[NL_POLICY_TYPE_ATTR_TYP=
E])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                query-=
&gt;type =3D (int)nla_get_u32(tb_attr[NL_POLICY_TYPE_ATTR_TYPE]);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return NL_OK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Dump the policy of query-&gt;req-&gt;c=
md and let the callback pick the chain out</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * of it=2E Returns 0, or the netlink error that kep=
t us from reading it all=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ovpn_cap_ask(struct ovpn_cap_query *query)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct nl_msg *nl_msg =3D NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int ret =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct nl_sock *nl_sock =3D nl_socket_alloc();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!nl_sock)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return -NLE_NOMEM;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
t =3D genl_connect(nl_sock);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set_cloexec(nl_so=
cket_get_fd(nl_sock));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nl_msg =3D n=
lmsg_alloc();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!nl_msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D -NLE_NO=
MEM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto ou=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* nlctrl has a fixed family id, so there is n=
othing to resolve first=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * Unlike CTRL_CMD_GETFAMILY, CTRL_CMD_GETPOLICY does not load t=
he module:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * th=
is relies on dco_available() having resolved the family already=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!genlmsg_put(nl_m=
sg, NL_AUTO_PORT, NL_AUTO_SEQ, GENL_ID_CTRL, 0, NLM_F_DUMP,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     CTRL_CMD_GETPO=
LICY, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D -NLE_MSG=
SIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto o=
ut;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ret =3D nla_put_string(nl_msg, CTRL_ATTR_FAMI=
LY_NAME, OVPN_FAMILY_NAME);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ret =3D nla_put_u32(nl_msg, CTRL_ATTR=
_OP, query-&gt;req-&gt;cmd);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ret =3D nl_socket_modify_cb(nl_sock,=
 NL_CB_VALID, NL_CB_CUSTOM, ovpn_cap_query_cb, query);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D nl=
_send_auto(nl_sock, nl_msg);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ret =3D nl_recvmsgs_default(nl_sock)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret &gt;=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D query-&gt;e=
rr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+out:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    nlmsg_free(nl_msg);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    nl_socket_free(nl_sock);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return ret &lt; 0 ? ret : 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Decide whether the kernel support=
s the requirement, from the links the pass</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * collected=2E A link the kernel never mentioned is=
 a no=2E A dump that never</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * named the policy of the command is not an answer either way, and =
is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reported as su=
ch, but the capability stays off just the same=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static enum ovpn_cap_status</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ovpn_cap_resolve(const struct ovpn_cap_query *query)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* the dump never named the policy=
 that validates the command */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (query-&gt;cmd_policy &lt; 0)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return OVPN_CAP_UNKNOWN;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 a link is missing: the container or the target is not there */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (query-&gt;sub_policy &l=
t; 0 || query-&gt;type &lt; 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return OVPN_CAP_UNSUPPORTED;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the whole ch=
ain is there: a yes only if the attribute has the type we</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * would be writing into it */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (query-&gt;=
type =3D=3D query-&gt;req-&gt;expected_type) ? OVPN_CAP_SUPPORTED : OVPN_CA=
P_UNSUPPORTED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Resolve one capability requirement aga=
inst the running kernel=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static enum ovpn_cap_status</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ovpn_cap_probe_one(const struct ovpn_cap_req *req, int *p=
err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =
=3D { =2Ereq =3D req, =2Ecmd_policy =3D -1, =2Esub_policy =3D -1, =2Etype =
=3D -1 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    *perr =3D ovpn_cap_ask(&a=
mp;query);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (*=
perr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return OVPN_CAP_UNKN=
OWN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return ovpn_cap_resolve(&amp;query);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+dco_probe_capabilities(void)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (dco_caps_resolved)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn dco_caps;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* no capability is defined yet: res=
olve one whose answer we already know */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    static const struct ovpn_cap_req self_test =3D { 0=
, OVPN_CMD_PEER_NEW, OVPN_A_PEER,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                                   OVPN_A_PEE=
R_ID, NL_ATTR_TYPE_U32 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int err =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    enum ovpn_cap_status status =3D ovpn_cap_probe_one(&amp;self_test,=
 &amp;err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;=
%s: policy introspection self-test: %s (status %d, err %d)&quot;, __func__,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        status =3D=
=3D OVPN_CAP_SUPPORTED ? &quot;ok&quot; : &quot;unexpected&quot;, (int)stat=
us, err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    dco_caps_resolved =3D tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEB=
UG, &quot;%s: DCO local capabilities: 0x%x&quot;, __func__, dco_caps);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return dco_caps;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
lse  /* if HAVE_DECL_CTRL_ATTR_OP_POLICY */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dc=
o_probe_capabilities(void)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!dc=
o_caps_resolved)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO=
_DEBUG,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
&quot;%s: built without netlink policy introspection, no DCO capability can=
 be detected&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        dco_caps_resolved =3D true;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return dco=
_caps;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif /* if HAVE_DECL_CTRL_ATTR_OP_POLICY */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static=
 struct nl_msg *</span><br><span> ovpn_dco_nlmsg_create(const dco_context_t=
 *dco, uint8_t cmd)</span><br><span> {</span><br><span>@@ -428,6 +764,12 @@=
</span><br><span> {</span><br><span>     dco-&gt;ovpn_dco_id =3D resolve_ov=
pn_netlink_id(M_FATAL);</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* nothing consumes the bitmap yet; resolve it he=
re to exercise the path */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (check_debug_level(D_DCO_DEBUG))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        dco_probe_capabilities();</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     dco-&gt;nl_sock =3D nl_socket_alloc();</=
span><br><span> </span><br><span>     if (!dco-&gt;nl_sock)</span><br><span=
>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><=
span>index a854045=2E=2Ef20be50 100644</span><br><span>--- a/src/openvpn/dc=
o_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ =
-612,6 +612,12 @@</span><br><span>     return 0;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned =
int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_probe_capabi=
lities(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> dco_avail=
able(msglvl_t msglevel)</span><br><span> {</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Ea=
m</span><br><span>index e3404754=2E=2Ed1dfac9 100644</span><br><span>--- a/=
tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tes=
ts/openvpn/Makefile=2Eam</span><br><span>@@ -40,6 +40,12 @@</span><br><span=
> endif</span><br><span> endif</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+if HAVE_SITNL</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+if DCO_UNIT_TESTS</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+test_binaries +=3D dco_testdriver</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> if !CROSS_COMPILING</span><br><span> TESTS =3D $(t=
est_binaries)</span><br><span> endif</span><br><span>@@ -452,4 +458,16 @@</=
span><br><span> 	$(top_srcdir)/src/openvpn/run_command=2Ec \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/socket_util=2Ec</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+dco_testdriver_CFLAGS  =3D \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/inclu=
de -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO_CF=
LAGS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_testdriver=
_LDFLAGS =3D @TEST_LDFLAGS@ $(OPTIONAL_CRYPTO_LIBS)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_testdriver_SOURCES =3D test_dco=2Ec \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg=2Ec mock_=
msg=2Eh mock_dco_dependencies=2Ec mock_get_random=2Ec test_common=2Eh \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/comp=
at/compat-strlcpy=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/fdmisc=2Ec \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/plat=
form=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_sr=
cdir)/src/openvpn/win32-util=2Ec</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> build-tests-local: $(check_PROGRAMS)</span><=
br><span>diff --git a/tests/unit_tests/openvpn/mock_dco_dependencies=2Ec b/=
tests/unit_tests/openvpn/mock_dco_dependencies=2Ec</span><br><span>new file=
 mode 100644</span><br><span>index 0000000=2E=2Ee7f20f5</span><br><span>---=
 /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/mock_dco_dependen=
cies=2Ec</span><br><span>@@ -0,0 +1,80 @@</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a single =
UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             session authentication and key exchange=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pac=
ket encryption, packet authentication, and</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@op=
envpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
Copyright (C) 2026 Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you=
 can redistribute it and/or modify</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  it under the terms of the GNU General Public License ver=
sion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publis=
hed by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  This program is distributed in the hope that it will be useful,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRA=
NTY; without even the implied warranty of</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPO=
SE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  G=
NU General Public License for more details=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  You should have received a copy of the GNU General Public Lice=
nse along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with t=
his program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  Stubs for what dco_linux=2Ec drags in but capability probing never reache=
s:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  the data path=
, the event loop and the signal machinery=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAV=
E_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;d=
co=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;crypto_backend=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;forward=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;multi=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;networking=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket_=
util=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+multi_process_incoming_dco(dco_context_=
t *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+process=
_incoming_dco(dco_context_t *dco)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+register_signal(struct signal_info *si, int signum, cons=
t char *signal_text)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+net_iface_new(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t =
*iface, const char *type,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+              const void *arg)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+net_iface_del(const openvpn_net_ctx_t *ctx, const openvpn_ne=
t_iface_t *iface)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+cipher_kt_key_size(const char *ciphername)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+const char *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+print_sockaddr_ex(const struct sockaddr =
*addr, const char *separator, const unsigned int flags,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                  struct gc_arena *gc)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return &quot;[mock]&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/test_dco=2Ec b/tests/unit_tests/openvpn/test_d=
co=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2E4bfa619</span><br><span>--- /dev/null</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_dco=2Ec</span><br><span>@@ -0,0 +1,427 @@</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel =
IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
       over a single UDP port, with support for SSL/TLS-based</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             session authentica=
tion and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             packet encryption, packet authentication, and</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compressi=
on=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 Ope=
nVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2026 Gianmarco De Gregori &lt;gianmarco@=
mandelbit=2Ecom&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program =
is free software; you can redistribute it and/or modify</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Gener=
al Public License version 2</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  as published by the Free Software Foundation=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that it =
will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS F=
OR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  GNU General Public License for more details=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GN=
U General Public License along</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/l=
icenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  Unit tests for the DCO capability queries=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  Resolving a requirement is a single pass=
 over a policy dump followed by a</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  look at what the pass collected=2E The pass is fed dumps =
built by hand and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  the decision is fed a query filled in directly, which between them cover<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  what would other=
wise need a particular kernel=2E</span><br><span style=3D"color: hsl(120, 1=
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
ew_query_for(const struct ovpn_cap_req *req)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct ovpn_cap_query query =3D { =2Ereq =3D req, =2Ecmd_policy =
=3D -1, =2Esub_policy =3D -1, =2Etype =3D -1 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return query;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static struct ovpn_cap_query</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+new_query(void)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return new_query_for(&amp;test_req);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* a CTRL_ATTR_OP_POLICY message saying which policy vali=
dates `cmd` */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c struct nl_msg *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ms=
g_op_policy(uint16_t cmd, uint32_t do_policy)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct nl_msg *msg =3D nlmsg_alloc();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct nlattr *ops, *op;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_non_null(msg);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_non_null(genlmsg_put(msg, NL_AUTO_PORT=
, NL_AUTO_SEQ, 0, 0, 0, CTRL_CMD_GETPOLICY, 0));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ops =3D nla_nest_start(msg, CTRL_ATTR_OP_POLICY);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    op =3D nla_nest_start(msg, =
cmd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(nla_put_u32(msg, CTRL_ATTR_POLICY_DO, do_policy), 0);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    nla_nest_end(msg, op);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    nla_nest_end(msg, ops);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return msg;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
one attribute of a policy: its id, which field of its descriptor to set,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and the value to pu=
t there */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct at=
tr_desc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t attr_id;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int field;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    uint32_t value;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* a CTRL_ATTR_POLICY message describing `n` attributes of one policy=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct nl=
_msg *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+msg_policy_at=
trs(uint16_t policy_id, const struct attr_desc *descs, size_t n)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct nl_msg *msg =3D nlmsg_alloc();</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nlattr *policie=
s, *policy, *attr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(=
msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_non=
_null(genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, 0, 0, 0, CTRL_CMD_GETPOLI=
CY, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    policies =3D nla_nest_star=
t(msg, CTRL_ATTR_POLICY);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    policy =3D nla_nest_start(msg, policy_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; n; i++)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        attr =3D nla_nest_start(msg=
, descs[i]=2Eattr_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        assert_int_equal(nla_put_u32(msg, descs[i]=2Efield, descs[i]=2Ev=
alue), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        n=
la_nest_end(msg, attr);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nla_ne=
st_end(msg, policy);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    nla_nest_end(msg, policies);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn msg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* the shape the kernel actually sends: one at=
tribute per message */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static struct nl_msg *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+msg_policy_attr(uint16_t policy_id, uint16_t attr_id, int field, uint=
32_t value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct attr_desc=
 one =3D { attr_id, field, value };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return msg_policy_attrs(policy_id, &amp;one, 1);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+feed(struct ovp=
n_cap_query *query, struct nl_msg *msg)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(ovpn_cap_query_cb(msg, query), NL_OK);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    nlmsg_free(msg);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* Walk the whole chain, with both policies carrying attributes we ar=
e not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * after and t=
he ones we are neither first nor last, so that the pass has to</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * skip past them rather than st=
op at the first mismatch=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+feed_full_chain(struct ovpn_cap_query *query)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const struct attr_desc cmd_attrs[] =3D {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        { OVPN_A_IFINDEX, NL_POLICY_TYP=
E_ATTR_TYPE, NL_ATTR_TYPE_U32 },</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        { OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX, SUB_POL=
ICY },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { OVP=
N_A_KEYCONF, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_NESTED },</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const struct attr_desc sub_attrs[] =3D {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { OVPN_A_PEER=
_ID, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U32 },</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        { OVPN_A_PEER_REMOTE_PORT, NL_POLICY=
_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U16 },</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        { test_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE=
, NL_ATTR_TYPE_U32 },</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        { OVPN_A_PEER_LOCAL_PORT, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_=
U16 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    feed(query, msg_op_policy(OVPN_CMD_PEER_N=
EW, CMD_POLICY));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  feed(query, msg_policy_attrs(CMD_POLICY, cmd_attrs, SIZE(cmd_attrs)));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(query, msg_po=
licy_attrs(SUB_POLICY, sub_attrs, SIZE(sub_attrs)));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
the map tells us which policy validates the command we asked about */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_reads_command_policy(void **=
state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query=
 =3D new_query();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, =
msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(query=2Ecmd_policy, CMD_POL=
ICY);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* and not about another one, even though the dump =
is supposed to be filtered */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_ignores_other_command(void **state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct ovpn_cap_query query =3D new_query();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    feed(&amp;query, msg_op_policy(OVPN_CMD_PEER_DEL, CMD_PO=
LICY));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(query=2Ecmd_policy, -1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* the nested attribute=
 of that policy points at the sub-policy */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_follows_nested_attribute(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new_query();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_policy(OVPN_C=
MD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POL=
ICY_TYPE_ATTR_POLICY_IDX,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                 SUB_POLICY));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(query=2Esub_policy, =
SUB_POLICY);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* an attribute id only means something insi=
de its own policy, so the same</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * number elsewhere says nothing about our question: a command p=
olicy without</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the=
 container is a no, whatever comes after it */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_ignores_nested_attribute_elsewhere(void **state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new_=
query();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_po=
licy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, OVPN_A_I=
FINDEX, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                 NL_ATTR_TYPE_U32));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_pol=
icy_attr(OTHER_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
      SUB_POLICY));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    feed(&amp;query, msg_policy_attr(SUB_POLICY, test_req=2Etarget_attr, NL=
_POLICY_TYPE_ATTR_TYPE,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                 NL_ATTR_TYPE_U32));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(query=2Esub_polic=
y, -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(ovpn_cap_resolve(&amp;query), OVPN_CAP_UNSUPPORTED);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* the type of the target attribute is read in the sub-policy */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_reads_target_type(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =
=3D new_query();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed_full_chain(&a=
mp;query);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(query=2Etype, NL_ATTR_TYPE_U32);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* and the s=
ame holds for the target attribute: a type read off some other</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * policy is not an answer to wh=
at we asked */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ignores_=
target_attribute_elsewhere(void **state)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct ovpn_cap_query query =3D new_query();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    feed(&amp;query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_PO=
LICY));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&am=
p;query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLIC=
Y_IDX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                    SUB_POLICY));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    feed(&amp;query, msg_policy_attr(OTHER_POLICY, test_req=
=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                 NL_ATTR_TYPE_U32));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(query=2Etype, -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* the command&#39;s own policy does =
get read, so the target attribute has to be</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * turned away there too: the same id there is a di=
fferent attribute */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ig=
nores_target_attribute_in_command_policy(void **state)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct ovpn_cap_query query =3D new_query();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_policy(OVPN_CMD_PEER=
_NEW, CMD_POLICY));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    feed(&amp;query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYP=
E_ATTR_POLICY_IDX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                SUB_POLICY));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, =
test_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                 NL_ATTR_TYPE=
_U32));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(query=2Etype, -1);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* the sub-policy is read too=
, so the nested attribute has to be turned away</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * there as well */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+test_ignores_nested_attribute_in_sub_policy(void **stat=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D=
 new_query();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_=
op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, OVP=
N_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                 SUB_POLICY));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_p=
olicy_attr(SUB_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
      OTHER_POLICY));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(query=2Esub_policy, SUB_POLICY);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* an attribute that is there but not as a nest has nothing to follow */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+test_nested_attribute_without_p=
olicy_idx(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ovp=
n_cap_query query =3D new_query();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
feed(&amp;query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy=
_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                 NL_AT=
TR_TYPE_U32));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(query=2Esub_policy, -1);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* and one that =
is a nest says nothing about the type we are after */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_target_attribute_without_type(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D ne=
w_query();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_=
policy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, OVPN_A=
_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                 SUB_POLICY));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_poli=
cy_attr(SUB_POLICY, test_req=2Etarget_attr,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                 NL_POLICY_TYPE_ATT=
R_POLICY_IDX, OTHER_POLICY));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(query=2Etype, -1);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* a fl=
at requirement needs no hop: the command&#39;s policy is where to look */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+test_flat_requirement_reads_c=
ommand_policy(void **state)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 ovpn_cap_query query =3D new_query_for(&amp;flat_req);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    feed(&amp;query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_=
POLICY));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(query=2Esub_policy, CMD_POLICY);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, flat_req=2Etarget_att=
r, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                 NL_ATTR_TYPE_U32));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ovpn_cap_res=
olve(&amp;query), OVPN_CAP_SUPPORTED);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* and an absent o=
ne is a plain no */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_fla=
t_requirement_absent_is_unsupported(void **state)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct ovpn_cap_query query =3D new_query_for(&amp;flat_req=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_policy(O=
VPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    feed(&amp;query, msg_policy_attr(OTHER_POLICY, flat_req=2Et=
arget_attr, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                 NL_ATTR_TYPE_U32));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ovp=
n_cap_resolve(&amp;query), OVPN_CAP_UNSUPPORTED);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* a me=
ssage we cannot parse stops the pass with an error, rather than</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * leaving a hole that would re=
ad as a no */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_malformed=
_message_stops(void **state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t ovpn_cap_query query =3D new_query();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct nl_msg *msg =3D nlmsg_alloc();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct nlattr *ops, *op;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(msg);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(genlmsg_put(msg=
, NL_AUTO_PORT, NL_AUTO_SEQ, 0, 0, 0, CTRL_CMD_GETPOLICY, 0));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ops =3D nla_nest_start(msg, =
CTRL_ATTR_OP_POLICY);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    op =3D nla_nest_start(msg, OVPN_CMD_PEER_NEW);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(nla_put_u16(msg, CTR=
L_ATTR_POLICY_DO, CMD_POLICY), 0);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    nla_nest_end(msg, op);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    nla_nest_end(msg, ops);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(ovpn_cap_query_cb(msg, &amp;query), NL_STOP=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(q=
uery=2Eerr &lt; 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(query=2Ecmd_policy, -1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    nlmsg_free(msg);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* nothing=
 to read an answer out of is not the same as a &quot;no&quot; */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+test_resolve_without_command_policy(vo=
id **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query =
query =3D new_query();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(ovpn_cap_resolve(&amp;query), OVPN_CAP_UNKNOWN);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
a kernel that does not nest the attribute simply never mentions it */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_resolve_nested_absent(void *=
*state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query quer=
y =3D new_query();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    query=2Ecmd_poli=
cy =3D CMD_POLICY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(ovpn_cap_resolve(&amp;query), OVPN_CAP_UNSUPPORTED);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* the sub-policy is there but does not define the attribut=
e: the ordinary no */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_r=
esolve_target_absent(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct ovpn_cap_query query =3D new_query();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    query=2Ecmd_policy =3D CMD_POLICY;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    query=2Esub_policy =3D SUB_POLICY;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ovpn_cap_=
resolve(&amp;query), OVPN_CAP_UNSUPPORTED);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* right name=
, wrong type: not the attribute we would be writing */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+test_resolve_wrong_type(void **state)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new_query();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    query=2Ecmd_policy =3D CMD_POLICY;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    query=2Esub_pol=
icy =3D SUB_POLICY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    query=2Etype =3D NL_ATTR_TYPE_U8;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(ovpn_cap_resolve(&amp;query), OVPN_C=
AP_UNSUPPORTED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* and the whole chain, from a dump to a=
 yes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_resolve_complet=
e_chain(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_=
cap_query query =3D new_query();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fe=
ed_full_chain(&amp;query);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(ovpn_cap_resolve(&amp;query), OVPN_CAP_SUPPORTE=
D);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+main(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct CMUn=
itTest tests[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        cmocka_unit_test(test_reads_command_policy),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_ignores_oth=
er_command),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 cmocka_unit_test(test_follows_nested_attribute),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_ignores_nested_=
attribute_elsewhere),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        cmocka_unit_test(test_reads_target_type),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_ignores_tar=
get_attribute_elsewhere),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        cmocka_unit_test(test_ignores_target_attribute_in_command_pol=
icy),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka=
_unit_test(test_ignores_nested_attribute_in_sub_policy),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_nested_a=
ttribute_without_policy_idx),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test(test_target_attribute_without_type),</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_tes=
t(test_flat_requirement_reads_command_policy),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_flat_requirement_a=
bsent_is_unsupported),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_malformed_message_stops),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_resolv=
e_without_command_policy),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        cmocka_unit_test(test_resolve_nested_absent),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_reso=
lve_target_absent),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        cmocka_unit_test(test_resolve_wrong_type),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_resolve_comple=
te_chain),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
<div style=3D"display:none"> Gerrit-PatchSet: 3 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gia=
nmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Gianmarco De Gregori &=
lt;gianmarco@mandelbit=2Ecom&gt; </div>

</body></html>
--KgEJbHUCgUc=--


--===============6902636162806962519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6902636162806962519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6902636162806962519==--

