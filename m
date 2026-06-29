Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F9CC43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FZ8BPq3Atw3TchUguKtTDDojtmVtM7XnJL9bKw9tf6s=; b=aa5ilD8VoRsaOJG4tZ0ezcCmWH
	ajY6IRPgCfmquXbMi7Zp+eBpJwyukfDDXMWMDyzhvibSC1cOmJguXj3mQta2WUWs1Z5xsjiit1HWt
	ZRp1U4R6THMT4XSFKCHbbgP+IZ/2AlKWowYjDYlEZCd8+PH/P1Focm5BrACY/G8dd8To=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weEOI-0007Ri-JP;
	Mon, 29 Jun 2026 15:59:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weEOG-0007Ra-Jb
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 15:59:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=G/w1UYT1ZdQ62Dp55EjP8o1Ny7YEEhLcHni+AlOQ73Q=; b=C11AIVvNc70iy+jQJpIxqJd2Dp
 Dj7IuooMPPSM/fl0i+FiJ9eM+C2YJM2tWvSBLk8GIh1hz+V0ALWyQYSj1ey8ZRSs+0VpcUzLKw9Tr
 xyMzkNUMsgi/clxvALXsgFFMjiTKxz9ReBMKNN7zk1o6IXG/VN+5gt3FsVVyqTNhRY0M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=G/w1UYT1ZdQ62Dp55EjP8o1Ny7YEEhLcHni+AlOQ73Q=; b=j
 xYJZypxbesm7qrZt0qaV2FhnDKtmqVkEduZVKQTlazzFD6ugGWu7CVDESLWxmk5Kg9VyhVukKXtio
 Hwg9+cR5J4gJbj1mQNLP+LpIXrRAoOQnzKaLV6t6EZLZJGaGCK4tOLTFT/toGusjXSGvbV+5MnXKu
 8LYPBBNgykC9gBdQ=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weEOB-000322-M3 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 15:59:18 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493b7612475so2206425e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782748750; x=1783353550; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G/w1UYT1ZdQ62Dp55EjP8o1Ny7YEEhLcHni+AlOQ73Q=;
 b=J2Vxa7irzXL57w3g3VQPo4WFu4sPGM+QRnMkxg53AAwi+RDpNXKu+uY9NcE+pz0bl7
 neYh6L0WfcoMEKLhkjf0fUMhgDNrVjYyw+6bqAsO+31bzqFv5STgljk94nMhF0+pViJP
 pFTAYFLN69Bt3y3ISxzwYia2AfgJEJrN/X3PjUXw690++fIPIem/rg3AskHFSfvjCO4+
 IJQ1+AMku6A8BC7UIr5ThwsLzM73LGMcEb5Fj1orz6sOa5EnUXn7HEzEY6OE+nRW8wC5
 D9SQimm+cexGC+JKiZb+e749wbzenTjYJJMIYygM6fJm534pUBxfDGQKcAr97B7NN30Y
 C0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782748750; x=1783353550;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G/w1UYT1ZdQ62Dp55EjP8o1Ny7YEEhLcHni+AlOQ73Q=;
 b=HC4Zy6E0YdpGc/JPo+YuJmvLfYAAUtvWBAOgFlswQa4wGb786lS2/CZE3t1xwZTQ8I
 uVr147ippVUZetEOYW+MiF2Msm+xFQajaLhld82hO7OqQwAQ10G/85J8PecZqhmoTp+S
 COhuzMiyFS12bMOs4+HC+RuXYxxG4pXUFCBAu6tx0gBRDhWAPz+OKz0oo5gNkL6ogdcX
 PFA6Krp1THoOfLYOUqedah5XswL9tiWOhc6BRdsTu/eP4hZZpMHuojdFnflhvejNFWjU
 4+5a3x7r4qzpHVHUAOp6UrnILHtyVMbGjR+cNVZBldLv8fg+gNgR8lRKkQ/5OL6DfTLP
 mTpw==
X-Gm-Message-State: AOJu0YzLen842GwvsRDuelEn0gL73HKbhdQ8QORXrN+Ne/dbfRaR1gBr
 /CMGNWiUl4Qp3PTZjLg198M6ceZmdsoIRVttiOlc3iWDeWb0CyknUeMlbBAwHVgkIB7C8pHhdBI
 0S1B/mfyeCnWOYlsVZrbr4uZ5IGp088mqcTL02KYDn86gIO2I0NuvBKD+XSuQOU742qA+
X-Gm-Gg: AfdE7cnhoHx3tU3KrsBVx+rVcPJsB+Y7lWuTnVIrTBAka/zY30PkPDlYKjyVkOgxl8z
 HK6Hc2UEIjGa4DcQHdsdY8MTTlnsQuzJq45mCGRu8e2b7REbSw0K+KZlTR+cxo/TZZ/xL8EVaCv
 Jy+uEUBm6Ant1b6FNcoYl0p9VgAAIX3riHtNTQGhzLjsxpQ6B1gT0XLv/WKtyFgGg8AToRvIzdO
 Gh9F7w/iP+FOvPCpepIMCV2Zlc3kFJMYM92uiM+OkXqsJNJENCMSPXMAj4B53F+xKilaaFrh2Eo
 jku7WQRLKDNw826h5zQArsDSr6AoTzvKBIQT7hjamgpXzsFQQ+3biC9Oqht4Q6A5D/fH8ogS2NK
 omJFGkBlhY9z8eXaHgdQ2KtI0F4VWSce/HBZ7V/R0Hrc1iuSw3QRw3FYaXlIi3V/ehDVo/v738v
 pW4XblVjCz0qz9bRHUBhum0VaRwiSI5XlNRrdEcVv+7qmQ1Nhmsw8etv3A2hM2MKCm8nB7UjRlR
 fvTPREggR8gGZTNKMs/lOMxWmlhNSgLWYGv9GAwQdK/062luAlZ9vaGrLl8a901gX5BpaZQ11H3
 adM=
X-Received: by 2002:a05:600c:4713:b0:492:4c2e:9613 with SMTP id
 5b1f17b1804b1-493b82ac66bmr4072985e9.18.1782748749183; 
 Mon, 29 Jun 2026 08:59:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926f94f213sm289582465e9.12.2026.06.29.08.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 08:59:08 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 15:59:07 +0000
To: stipa <lstipakov@gmail.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc
X-Gerrit-Change-Number: 1736
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1736?usp=email>
X-Gerrit-Commit: c553bb511f074b27334d54a1ce2d4d0c03a9d3e0
In-Reply-To: <gerrit.1782556099000.Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc@gerrit.openvpn.net>
References: <gerrit.1782556099000.Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTU2MDk5MDAwLkliN2Y5YzljZTVlZDc3ODE5MDQ0NWNjNGNmYWE4ZjNjZDVkMTExMGJjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1f6f445430407ca17417fcaf8b07976ae1f8a075-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weEOB-000322-M3
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win32: fix plugin
 trusted-dir check prefix bypass
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5109443042611457489=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5109443042611457489==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Pc9eijdL7cQ="; charset=UTF-8

--Pc9eijdL7cQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by plai=
sthos


Change subject: win32: fix plugin trusted-dir check prefix bypass
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

win32: fix pl=
ugin trusted-dir check prefix bypass

plugin_in_trusted_dir() validated the=
 plugin path against the trusted
plugin/install directory (and the system d=
irectory fallback) using a raw
string prefix match via wcsnicmp()=2E When t=
he trusted directory path does
not end in a separator (e=2Eg=2E the plugin_=
dir registry value is set to
"C:\openvpn_plugins"), a sibling directory sha=
ring the same prefix
("C:\openvpn_plugins_evil") also passes the check, all=
owing a plugin to
be loaded from outside the allow-listed directory=2E

Int=
roduce win_path_in_dir() in win32-util=2Ec which performs the prefix
match =
but additionally requires the match to end on a path-component
boundary, an=
d use it for both the plugin/install directory and the
system directory che=
cks=2E Add unit tests in test_misc=2Ec=2E

Change-Id: Ib7f9c9ce5ed778190445=
cc4cfaa8f3cd5d1110bc
Reported-By: =E7=AB=A0=E9=B1=BC=E5=93=A5 (@AiPy) (www=
=2Eaipyaipy=2Ecom)
Github: OpenVPN/openvpn-private-issues#120
Reported-by: =
<genco@srlabs=2Ede>
Github: OpenVPN/openvpn-private-issues#109
Signed-off-b=
y: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736
Me=
ssage-Id: <20260629124839=2E32433-1-gert@greenie=2Emuc=2Ede>
URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37382=2E=
html
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvp=
n/win32-util=2Ec
M src/openvpn/win32-util=2Eh
M src/openvpn/win32=2Ec
M tes=
ts/unit_tests/openvpn/test_misc=2Ec
4 files changed, 85 insertions(+), 9 de=
letions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/36/1736/3

diff --git a/src/openvpn/win32-util=2Ec b/src/openvpn/win32=
-util=2Ec
index 6fc3be4=2E=2E209e34e 100644
--- a/src/openvpn/win32-util=2E=
c
+++ b/src/openvpn/win32-util=2Ec
@@ -175,4 +175,30 @@
     return tmpdir;=

 }
 
+bool
+win_path_in_dir(const WCHAR *path, const WCHAR *dir)
+{
+    s=
ize_t dir_len =3D wcslen(dir);
+    /* dir_len <=3D 1 guards the dir[dir_le=
n - 1] access below and rejects a
+     * degenerate single-character direc=
tory (a normalized absolute path is
+     * always longer)=2E */
+    if (d=
ir_len <=3D 1 || wcsnicmp(dir, path, dir_len) !=3D 0)
+    {
+        retur=
n false;
+    }
+
+    /* A plain prefix match is not sufficient: if dir is=
 "C:\foo" then
+     * "C:\foo_evil\bar=2Edll" shares the prefix but is not=
 inside "C:\foo"=2E
+     * Require that the matched prefix ends on a path =
separator, i=2Ee=2E either
+     * dir already ends with a separator or the=
 character following the prefix
+     * in path is one=2E */
+    if (dir[d=
ir_len - 1] =3D=3D L'\\' || dir[dir_len - 1] =3D=3D L'/')
+    {
+        r=
eturn true;
+    }
+
+    WCHAR next =3D path[dir_len];
+    return next =
=3D=3D L'\\' || next =3D=3D L'/';
+}
+
 #endif /* _WIN32 */
diff --git a/sr=
c/openvpn/win32-util=2Eh b/src/openvpn/win32-util=2Eh
index 6636cf3=2E=2E48=
49ea9 100644
--- a/src/openvpn/win32-util=2Eh
+++ b/src/openvpn/win32-util=
=2Eh
@@ -42,5 +42,17 @@
 /* Find temporary directory */
 const char *win_ge=
t_tempdir(void);
 
+/**
+ * Check whether @p path resides within directory =
@p dir=2E
+ *
+ * Unlike a plain string prefix match, this requires the mat=
ch to end on a
+ * path-component boundary, so that "C:\\foo_evil\\bar" is =
not considered to be
+ * inside "C:\\foo"=2E Both arguments are expected to=
 be normalized absolute
+ * paths=2E The comparison is case-insensitive=2E
=
+ *
+ * @return true if @p path is inside @p dir, false otherwise=2E
+ */
+=
bool win_path_in_dir(const WCHAR *path, const WCHAR *dir);
+
 #endif /* OPE=
NVPN_WIN32_UTIL_H */
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/wi=
n32=2Ec b/src/openvpn/win32=2Ec
index b2a7331=2E=2Eca08ead 100644
--- a/src=
/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -1587,14 +1587,13 @@
    =
 }
 
     /* Check if the plugin path resides within the plugin/install dir=
ectory */
-    if ((wcslen(normalized_plugin_dir) > 0)
-        && (wcsnicm=
p(normalized_plugin_dir, plugin_path, wcslen(normalized_plugin_dir)) =3D=3D=
 0))
+    if (win_path_in_dir(plugin_path, normalized_plugin_dir))
     {
 =
        return true;
     }
 
     /* Fallback to the system directory */
-=
    return wcsnicmp(system_dir, plugin_path, wcslen(system_dir)) =3D=3D 0;
=
+    return win_path_in_dir(plugin_path, system_dir);
 }
 
 bool
diff --git=
 a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_m=
isc=2Ec
index ccdfdee=2E=2Efc9840a 100644
--- a/tests/unit_tests/openvpn/te=
st_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -38,6 +38,9 @@
=
 #include "test_common=2Eh"
 #include "list=2Eh"
 #include "mock_msg=2Eh"
+=
#ifdef _WIN32
+#include "win32-util=2Eh"
+#endif
 
 static void
 test_compa=
t_lzo_string(void **state)
@@ -445,12 +448,48 @@
     mock_set_debug_level(=
saved_log_level);
 }
 
-const struct CMUnitTest misc_tests[] =3D { cmocka_u=
nit_test(test_compat_lzo_string),
-                                        =
 cmocka_unit_test(test_auth_fail_temp_no_flags),
-                         =
                cmocka_unit_test(test_auth_fail_temp_flags),
-             =
                            cmocka_unit_test(test_auth_fail_temp_flags_msg)=
,
-                                         cmocka_unit_test(test_list),
- =
                                        cmocka_unit_test(test_atoi_variants=
) };
+#ifdef _WIN32
+static void
+test_win_path_in_dir(void **state)
+{
+  =
  /* plugin/install dir without trailing separator */
+    assert_true(win_=
path_in_dir(L"C:\\openvpn_plugins\\foo=2Edll", L"C:\\openvpn_plugins"));
+
=
+    /* the bug being fixed: a sibling dir sharing the prefix must NOT matc=
h */
+    assert_false(win_path_in_dir(L"C:\\openvpn_plugins_evil\\foo=2Edl=
l", L"C:\\openvpn_plugins"));
+
+    /* trusted dir with trailing separator=
 */
+    assert_true(win_path_in_dir(L"C:\\openvpn_plugins\\foo=2Edll", L"C=
:\\openvpn_plugins\\"));
+    assert_false(win_path_in_dir(L"C:\\openvpn_pl=
ugins_evil\\foo=2Edll", L"C:\\openvpn_plugins\\"));
+
+    /* forward slash=
 separator in the candidate path is accepted */
+    assert_true(win_path_i=
n_dir(L"C:\\openvpn_plugins/foo=2Edll", L"C:\\openvpn_plugins"));
+
+    /*=
 comparison is case-insensitive */
+    assert_true(win_path_in_dir(L"c:\\O=
PENVPN_PLUGINS\\foo=2Edll", L"C:\\openvpn_plugins"));
+
+    /* the directo=
ry itself (no trailing component) is not "in" the directory */
+    assert_=
false(win_path_in_dir(L"C:\\openvpn_plugins", L"C:\\openvpn_plugins"));
+
+=
    /* nested subdirectories are still inside */
+    assert_true(win_path_=
in_dir(L"C:\\openvpn_plugins\\sub\\foo=2Edll", L"C:\\openvpn_plugins"));
+
=
+    /* an empty trusted dir never matches */
+    assert_false(win_path_in=
_dir(L"C:\\openvpn_plugins\\foo=2Edll", L""));
+}
+#endif /* _WIN32 */
+
+c=
onst struct CMUnitTest misc_tests[] =3D {
+#ifdef _WIN32
+    cmocka_unit_t=
est(test_win_path_in_dir),
+#endif
+    cmocka_unit_test(test_compat_lzo_st=
ring),
+    cmocka_unit_test(test_auth_fail_temp_no_flags),
+    cmocka_uni=
t_test(test_auth_fail_temp_flags),
+    cmocka_unit_test(test_auth_fail_tem=
p_flags_msg),
+    cmocka_unit_test(test_list),
+    cmocka_unit_test(test_=
atoi_variants)
+};
 
 int
 main(void)

-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1736?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc
Gerrit-Chang=
e-Number: 1736
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@gmail=2Eco=
m>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: cron2=
 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>

--Pc9eijdL7cQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by stipa=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">win32: fix plugin trusted-dir=
 check prefix bypass<br><br>plugin_in_trusted_dir() validated the plugin pa=
th against the trusted<br>plugin/install directory (and the system director=
y fallback) using a raw<br>string prefix match via wcsnicmp()=2E When the t=
rusted directory path does<br>not end in a separator (e=2Eg=2E the plugin_d=
ir registry value is set to<br>&quot;C:\openvpn_plugins&quot;), a sibling d=
irectory sharing the same prefix<br>(&quot;C:\openvpn_plugins_evil&quot;) a=
lso passes the check, allowing a plugin to<br>be loaded from outside the al=
low-listed directory=2E<br><br>Introduce win_path_in_dir() in win32-util=2E=
c which performs the prefix<br>match but additionally requires the match to=
 end on a path-component<br>boundary, and use it for both the plugin/instal=
l directory and the<br>system directory checks=2E Add unit tests in test_mi=
sc=2Ec=2E<br><br>Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc<br>Re=
ported-By: =E7=AB=A0=E9=B1=BC=E5=93=A5 (@AiPy) (www=2Eaipyaipy=2Ecom)<br>Gi=
thub: OpenVPN/openvpn-private-issues#120<br>Reported-by: &lt;genco@srlabs=
=2Ede&gt;<br>Github: OpenVPN/openvpn-private-issues#109<br>Signed-off-by: L=
ev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1736<br>Message-Id: &lt;20260629124839=2E32433-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg37382=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/win32-util=2Ec<br>M src/openvpn=
/win32-util=2Eh<br>M src/openvpn/win32=2Ec<br>M tests/unit_tests/openvpn/te=
st_misc=2Ec<br>4 files changed, 85 insertions(+), 9 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/36/1736/3</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/win32-util=2Ec b/src/open=
vpn/win32-util=2Ec</span><br><span>index 6fc3be4=2E=2E209e34e 100644</span>=
<br><span>--- a/src/openvpn/win32-util=2Ec</span><br><span>+++ b/src/openvp=
n/win32-util=2Ec</span><br><span>@@ -175,4 +175,30 @@</span><br><span>     =
return tmpdir;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+win_path_in_dir(const WCHAR *path, const WCHAR *dir)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    size_t dir_len =3D wcslen(dir);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* dir_len &lt;=3D 1 =
guards the dir[dir_len - 1] access below and rejects a</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * degenerate single-character direc=
tory (a normalized absolute path is</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * always longer)=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (dir_len &lt;=3D 1 || wcsnicmp(dir, path, di=
r_len) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* A plain prefix match is not sufficient: if =
dir is &quot;C:\foo&quot; then</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * &quot;C:\foo_evil\bar=2Edll&quot; shares the prefix but i=
s not inside &quot;C:\foo&quot;=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * Require that the matched prefix ends on a path separa=
tor, i=2Ee=2E either</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * dir already ends with a separator or the character following the pr=
efix</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * in path =
is one=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(dir[dir_len - 1] =3D=3D L&#39;\\&#39; || dir[dir_len - 1] =3D=3D L&#39;/&#=
39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    WCHAR next =3D path[dir_len];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return next =3D=3D L&#39;\\&#39; || next =
=3D=3D L&#39;/&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 #endif /* _WIN32 */</span><br><span>diff --git a/src/openvpn/win32-util=2E=
h b/src/openvpn/win32-util=2Eh</span><br><span>index 6636cf3=2E=2E4849ea9 1=
00644</span><br><span>--- a/src/openvpn/win32-util=2Eh</span><br><span>+++ =
b/src/openvpn/win32-util=2Eh</span><br><span>@@ -42,5 +42,17 @@</span><br><=
span> /* Find temporary directory */</span><br><span> const char *win_get_t=
empdir(void);</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * C=
heck whether @p path resides within directory @p dir=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Unlike a plain string prefix match, this requires the=
 match to end on a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* path-component boundary, so that &quot;C:\\foo_evil\\bar&quot; is not con=
sidered to be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ins=
ide &quot;C:\\foo&quot;=2E Both arguments are expected to be normalized abs=
olute</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * paths=2E Th=
e comparison is case-insensitive=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return true if @p path is inside @p dir, false otherwise=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool win_path_in_dir(const WCHAR *path, const WC=
HAR *dir);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> #endif /* OPENVPN_WIN32_UTIL_H */</span><br><span> #endif /* ifdef=
 _WIN32 */</span><br><span>diff --git a/src/openvpn/win32=2Ec b/src/openvpn=
/win32=2Ec</span><br><span>index b2a7331=2E=2Eca08ead 100644</span><br><spa=
n>--- a/src/openvpn/win32=2Ec</span><br><span>+++ b/src/openvpn/win32=2Ec</=
span><br><span>@@ -1587,14 +1587,13 @@</span><br><span>     }</span><br><sp=
an> </span><br><span>     /* Check if the plugin path resides within the pl=
ugin/install directory */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if ((wcslen(normalized_plugin_dir) &gt; 0)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        &amp;&amp; (wcsnicmp(normalized_plugin=
_dir, plugin_path, wcslen(normalized_plugin_dir)) =3D=3D 0))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (win_path_in_dir(plugin_pat=
h, normalized_plugin_dir))</span><br><span>     {</span><br><span>         =
return true;</span><br><span>     }</span><br><span> </span><br><span>     =
/* Fallback to the system directory */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return wcsnicmp(system_dir, plugin_path, wcslen(system=
_dir)) =3D=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return win_path_in_dir(plugin_path, system_dir);</span><br><span> }</span>=
<br><span> </span><br><span> bool</span><br><span>diff --git a/tests/unit_t=
ests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><=
br><span>index ccdfdee=2E=2Efc9840a 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn=
/test_misc=2Ec</span><br><span>@@ -38,6 +38,9 @@</span><br><span> #include =
&quot;test_common=2Eh&quot;</span><br><span> #include &quot;list=2Eh&quot;<=
/span><br><span> #include &quot;mock_msg=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;win32-util=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br=
><span> static void</span><br><span> test_compat_lzo_string(void **state)</=
span><br><span>@@ -445,12 +448,48 @@</span><br><span>     mock_set_debug_le=
vel(saved_log_level);</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-const struct CMUnitTest misc_tests[] =
=3D { cmocka_unit_test(test_compat_lzo_string),</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                         cmocka_u=
nit_test(test_auth_fail_temp_no_flags),</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                         cmocka_unit_test=
(test_auth_fail_temp_flags),</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                                         cmocka_unit_test(test_auth_=
fail_temp_flags_msg),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                         cmocka_unit_test(test_list),</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
              cmocka_unit_test(test_atoi_variants) };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+test_win_path_in_dir(void **state)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* plugin/install dir without trailing separator */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(win_pa=
th_in_dir(L&quot;C:\\openvpn_plugins\\foo=2Edll&quot;, L&quot;C:\\openvpn_p=
lugins&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the bug being fi=
xed: a sibling dir sharing the prefix must NOT match */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_false(win_path_in_dir(L&quot=
;C:\\openvpn_plugins_evil\\foo=2Edll&quot;, L&quot;C:\\openvpn_plugins&quot=
;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* trusted dir with trailing s=
eparator */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(win_path_in_dir(L&quot;C:\\openvpn_plugins\\foo=2Edll&quot;, L&quot=
;C:\\openvpn_plugins\\&quot;));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_false(win_path_in_dir(L&quot;C:\\openvpn_plugins_evi=
l\\foo=2Edll&quot;, L&quot;C:\\openvpn_plugins\\&quot;));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* forward slash separator in the candidate path is =
accepted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(win_path_in_dir(L&quot;C:\\openvpn_plugins/foo=2Edll&quot;, L&quot;=
C:\\openvpn_plugins&quot;));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* com=
parison is case-insensitive */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(win_path_in_dir(L&quot;c:\\OPENVPN_PLUGINS\\foo=
=2Edll&quot;, L&quot;C:\\openvpn_plugins&quot;));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* the directory itself (no trailing component) is not &quot=
;in&quot; the directory */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_false(win_path_in_dir(L&quot;C:\\openvpn_plugins&quot;, L=
&quot;C:\\openvpn_plugins&quot;));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* nested subdirectories are still inside */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(win_path_in_dir(L&quot;C:\\openvpn=
_plugins\\sub\\foo=2Edll&quot;, L&quot;C:\\openvpn_plugins&quot;));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* an empty trusted dir never matches */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(win_=
path_in_dir(L&quot;C:\\openvpn_plugins\\foo=2Edll&quot;, L&quot;&quot;));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif /* _WIN32 */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+const struct CMUnitTest misc_tests[] =3D {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_win_path_in_dir=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_comp=
at_lzo_string),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
cmocka_unit_test(test_auth_fail_temp_no_flags),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_auth_fail_temp_flags)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_te=
st(test_auth_fail_temp_flags_msg),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    cmocka_unit_test(test_list),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_atoi_variants)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span> </span=
><br><span> int</span><br><span> main(void)</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
36?usp=3Demail">change 1736</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1736?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatch=
set </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 1736 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> G=
errit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=2E=
de&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--Pc9eijdL7cQ=--


--===============5109443042611457489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5109443042611457489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5109443042611457489==--

