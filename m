Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B726DC43327
	for <openvpn-devel@archiver.kernel.org>; Sat, 27 Jun 2026 10:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=qkjFqqaoYXsaLZKBubZr7uHhZpgSoYEYmx9JYSg3Rxc=; b=TAOAocb2R1iAyU
	ia3INM1hRWpI4S6nl7Hvc/bYbq/QYvkYc09TbbhtLqn0NJKHib4qZe/huIxKdJ5Fft5pXAdQd6Z/Y
	cPcY/FBQfKEll2yT1iOdb9/KLOuKAOJg8yEb4gTCt3qUXVKbzn0XQkodF3oZPOU/qFadq0hUu80bd
	164=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdQH5-0004eQ-P6;
	Sat, 27 Jun 2026 10:28:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wdQH4-0004eJ-Hq
 for openvpn-devel@lists.sourceforge.net;
 Sat, 27 Jun 2026 10:28:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gFAIaj0j5Faxe5HZk3Ovx98nSVOCEB16coz/MovFHyw=; b=FQ+LMw8cgc+W+rDNUZrzHao9uc
 gKjecbEZ819jwOd/z4H7cQiPBiI0T/x1yvNuVUmeeIJV+Eq2grxqeRyPrM74t/G5PjxjTxr8Az6+f
 Zb6EwnqXjN65Z0JzPyS1/etUSXm/Ii4jGAVOVqPemgzy0VQ7cmw6vGkPMTyvI46i/lZs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gFAIaj0j5Faxe5HZk3Ovx98nSVOCEB16coz/MovFHyw=; b=E
 aktTfiz+IEgcgWxNLPW09H4z4b8SdNnCGoHg67jSZYfE7o+7ihEtcoEcVD0Pf73B5rgveUouiMo05
 MebGKBHEQ4E/0Xv7PmlUynotn+8CCVNWncVOIHKPeZhcrRl00/zbix6vBVSRgPljxDGodt5ZyxQu0
 fkmefo/6XAzxN3lY=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wdQH3-0005gL-I3 for openvpn-devel@lists.sourceforge.net;
 Sat, 27 Jun 2026 10:28:35 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49319ebb3a9so2006465e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 27 Jun 2026 03:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782556102; x=1783160902; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gFAIaj0j5Faxe5HZk3Ovx98nSVOCEB16coz/MovFHyw=;
 b=KleIdwRsiEhGL12plOckk1tn+muT6ZLwKQ34umWVZlYVVtJRQllelBWwl4CTLRZMFi
 rQ7ydQDlghABD2VxVlFx7Z6BKa/ESp4c1Nkqu0CCOAQExCvrlj8hQhdMrkUsU27f3CKF
 MMay/Uc2ukdGHoOa14QczcZuCLJqofT8Q1svq+YglmYtsHC7QdMVDtdvOqlZCznoGxi3
 ZSAC1wQ9v1o96zAeysIylJaAmqvE5wDbQqw1acrQPtKIXGaKrS129OTq5ZQCUhsXww8f
 v4YKAgsn8XhK88pzDwcX6ryjClAHDIcJORjJ50aL7N3zCje8XY7K2Z9gWSUprJMS0ky+
 7hpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782556102; x=1783160902;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gFAIaj0j5Faxe5HZk3Ovx98nSVOCEB16coz/MovFHyw=;
 b=IPuhWbz9mE3tT7VZ2Jfrc3w5v7RHhpspyl2+KfHLoQnpAO+sAVHMplzLurz4jHZxDP
 gRJkqULxV12K0brm7zT0BwUtKlQu2/DsMEto1MKL1xA9PNfJY6PXuZAR8B5UzMadKqGf
 fqXd1j2LPNPI1sQoSz6ugSrGxGR0e//CRscdpbQoE9Qfp6SZqcR2H8ItcuzFFPVKDyiJ
 3WYs8TewPjeiuHXqYpsxJ2RwQjZ2DzZlVv3M5LJMePPILjyTD1Y4qTyYilUaUdWg8L2a
 u1qq7Ef+ExDMKV7QisFQckL2U90cHzYhftK/Kjj1U5pqCb9UJOghuoUSvjCmdBIvxBCH
 2esA==
X-Gm-Message-State: AOJu0Yx/JC6EYyy9d/O1S0peyCIChbmk+VWSlb1q52A9KOaJsGlOH0x4
 VwgYoQSGnEY7Pag8BVMQ8g9MHyWoAxf6dsUYBDkIaCYFF8c+FoNaXutmf9l06otve/kSGwHJmEY
 bnv1hRQ44Xh5k/1IWJZxCdbX7wHfmV2rOCTncUj+uhH07NZzhJUTeIQ5hbASRcoGe+UI0WVIUjI
 UeIYaTeQ==
X-Gm-Gg: AfdE7cnkYAcah2hXkK26DyMAHKfzr8BiuRI2My+OdH4TYP2WP7diEB7O+Yv6hphEkKm
 fd3wg38EAm/+qugEuGR6eyXSE3d8DjRwSgVb6EbRJRXjts/hy+hZEWcnkpOne3g4WMrJYAolmbl
 rhOa1S/ofrRkOIfpI9dBg5WOXI9wXE0qxQ6GbVNcPmqvMOzbaIF4KlIDXrDsjRGuDSDD3XROeDJ
 FOAUYZqlofCx/xtldAW/riZLsOBDLBdSTUv+Z3ui6YfmTNaWG8iDKU8vXporeV9OR2x68MzALst
 R60IK7NSx+qZruJsprivYvCtH6GqI6mJpJOy43rvqOKdt2onwBzlB1+tOhyFCsEA5AySVhnTgDy
 kkacnHbemejYQQcIyrkVF6ATCBDwImu5RhztqZuj6l5+wvRyWQzN9ttSUS+CMnPJhb98xnXcr5A
 L1IdBOqlX07xhaWAJCQjM+RsxfmOBd69BFIJjVKf/5cDEOuXVEVe6TLi+kD81v+VzCHyiQ6xf1f
 nC8bHzKMQNF0DuisrfNzO0GfLQfAix6FEHNoX6zjm6DzMdYmo48OnhrMhRteF/Jni9crsaQwrJJ
 4aA=
X-Received: by 2002:a05:600c:3f0c:b0:490:bcf6:469f with SMTP id
 5b1f17b1804b1-492667e9b5dmr139235575e9.0.1782556102338; 
 Sat, 27 Jun 2026 03:28:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fe949csm176873275e9.5.2026.06.27.03.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 03:28:21 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 27 Jun 2026 10:28:21 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc
X-Gerrit-Change-Number: 1736
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1736?usp=email>
X-Gerrit-Commit: e0ba79507431a8c970b721cd1413d32c64c15415
References: <gerrit.1782556099000.Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTU2MDk5MDAwLkliN2Y5YzljZTVlZDc3ODE5MDQ0NWNjNGNmYWE4ZjNjZDVkMTExMGJjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <479b3aa84a84300a7dd2dec80fdceb0d6b8aeadb-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wdQH3-0005gL-I3
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2824540296490643577=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2824540296490643577==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LSJ5DGaA95s="; charset=UTF-8

--LSJ5DGaA95s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1736?usp=3Demail

to review the following change=2E


Chang=
e subject: win32: fix plugin trusted-dir check prefix bypass
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

win32: fix plugin trusted=
-dir check prefix bypass

plugin_in_trusted_dir() validated the plugin path=
 against the trusted
plugin/install directory (and the system directory fal=
lback) using a raw
string prefix match via wcsnicmp()=2E When the trusted d=
irectory path does
not end in a separator (e=2Eg=2E the plugin_dir registry=
 value is set to
"C:\openvpn_plugins"), a sibling directory sharing the sam=
e prefix
("C:\openvpn_plugins_evil") also passes the check, allowing a plug=
in to
be loaded from outside the allow-listed directory=2E

Introduce win_p=
ath_in_dir() in win32-util=2Ec which performs the prefix
match but addition=
ally requires the match to end on a path-component
boundary, and use it for=
 both the plugin/install directory and the
system directory checks=2E Add u=
nit tests in test_misc=2Ec=2E

Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd=
5d1110bc
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/=
win32-util=2Ec
M src/openvpn/win32-util=2Eh
M src/openvpn/win32=2Ec
M tests=
/unit_tests/openvpn/test_misc=2Ec
4 files changed, 76 insertions(+), 4 dele=
tions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/36/1736/1

diff --git a/src/openvpn/win32-util=2Ec b/src/openvpn/win32-=
util=2Ec
index 6fc3be4=2E=2E5d65c6f 100644
--- a/src/openvpn/win32-util=2Ec=

+++ b/src/openvpn/win32-util=2Ec
@@ -175,4 +175,27 @@
     return tmpdir;
=
 }
 
+bool
+win_path_in_dir(const WCHAR *path, const WCHAR *dir)
+{
+    si=
ze_t dir_len =3D wcslen(dir);
+    if (dir_len =3D=3D 0 || wcsnicmp(dir, pa=
th, dir_len) !=3D 0)
+    {
+        return false;
+    }
+
+    /* A plain=
 prefix match is not sufficient: if dir is "C:\foo" then
+     * "C:\foo_ev=
il\bar=2Edll" shares the prefix but is not inside "C:\foo"=2E
+     * Requi=
re that the matched prefix ends on a path separator, i=2Ee=2E either
+     =
* dir already ends with a separator or the character following the prefix
+=
     * in path is one=2E */
+    if (dir[dir_len - 1] =3D=3D L'\\' || dir[d=
ir_len - 1] =3D=3D L'/')
+    {
+        return true;
+    }
+
+    WCHAR n=
ext =3D path[dir_len];
+    return next =3D=3D L'\\' || next =3D=3D L'/';
+=
}
+
 #endif /* _WIN32 */
diff --git a/src/openvpn/win32-util=2Eh b/src/open=
vpn/win32-util=2Eh
index 6636cf3=2E=2E4849ea9 100644
--- a/src/openvpn/win3=
2-util=2Eh
+++ b/src/openvpn/win32-util=2Eh
@@ -42,5 +42,17 @@
 /* Find tem=
porary directory */
 const char *win_get_tempdir(void);
 
+/**
+ * Check wh=
ether @p path resides within directory @p dir=2E
+ *
+ * Unlike a plain str=
ing prefix match, this requires the match to end on a
+ * path-component bo=
undary, so that "C:\\foo_evil\\bar" is not considered to be
+ * inside "C:\=
\foo"=2E Both arguments are expected to be normalized absolute
+ * paths=2E=
 The comparison is case-insensitive=2E
+ *
+ * @return true if @p path is i=
nside @p dir, false otherwise=2E
+ */
+bool win_path_in_dir(const WCHAR *pa=
th, const WCHAR *dir);
+
 #endif /* OPENVPN_WIN32_UTIL_H */
 #endif /* ifde=
f _WIN32 */
diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
inde=
x b2a7331=2E=2Eca08ead 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn=
/win32=2Ec
@@ -1587,14 +1587,13 @@
     }
 
     /* Check if the plugin pat=
h resides within the plugin/install directory */
-    if ((wcslen(normalize=
d_plugin_dir) > 0)
-        && (wcsnicmp(normalized_plugin_dir, plugin_path=
, wcslen(normalized_plugin_dir)) =3D=3D 0))
+    if (win_path_in_dir(plugin=
_path, normalized_plugin_dir))
     {
         return true;
     }
 
     /=
* Fallback to the system directory */
-    return wcsnicmp(system_dir, plug=
in_path, wcslen(system_dir)) =3D=3D 0;
+    return win_path_in_dir(plugin_p=
ath, system_dir);
 }
 
 bool
diff --git a/tests/unit_tests/openvpn/test_mis=
c=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index a9ae33f=2E=2Ef883a88 1=
00644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/o=
penvpn/test_misc=2Ec
@@ -38,6 +38,9 @@
 #include "test_common=2Eh"
 #includ=
e "list=2Eh"
 #include "mock_msg=2Eh"
+#ifdef _WIN32
+#include "win32-util=
=2Eh"
+#endif
 
 static void
 test_compat_lzo_string(void **state)
@@ -445,=
7 +448,42 @@
     mock_set_debug_level(saved_log_level);
 }
 
-const struct=
 CMUnitTest misc_tests[] =3D { cmocka_unit_test(test_compat_lzo_string),
+#=
ifdef _WIN32
+static void
+test_win_path_in_dir(void **state)
+{
+    /* pl=
ugin/install dir without trailing separator */
+    assert_true(win_path_in=
_dir(L"C:\\openvpn_plugins\\foo=2Edll", L"C:\\openvpn_plugins"));
+
+    /*=
 the bug being fixed: a sibling dir sharing the prefix must NOT match */
+ =
   assert_false(win_path_in_dir(L"C:\\openvpn_plugins_evil\\foo=2Edll", L"C=
:\\openvpn_plugins"));
+
+    /* trusted dir with trailing separator */
+  =
  assert_true(win_path_in_dir(L"C:\\openvpn_plugins\\foo=2Edll", L"C:\\open=
vpn_plugins\\"));
+    assert_false(win_path_in_dir(L"C:\\openvpn_plugins_e=
vil\\foo=2Edll", L"C:\\openvpn_plugins\\"));
+
+    /* forward slash separa=
tor in the candidate path is accepted */
+    assert_true(win_path_in_dir(L=
"C:\\openvpn_plugins/foo=2Edll", L"C:\\openvpn_plugins"));
+
+    /* compar=
ison is case-insensitive */
+    assert_true(win_path_in_dir(L"c:\\OPENVPN_=
PLUGINS\\foo=2Edll", L"C:\\openvpn_plugins"));
+
+    /* the directory itse=
lf (no trailing component) is not "in" the directory */
+    assert_false(w=
in_path_in_dir(L"C:\\openvpn_plugins", L"C:\\openvpn_plugins"));
+
+    /* =
nested subdirectories are still inside */
+    assert_true(win_path_in_dir(=
L"C:\\openvpn_plugins\\sub\\foo=2Edll", L"C:\\openvpn_plugins"));
+
+    /*=
 an empty trusted dir never matches */
+    assert_false(win_path_in_dir(L"=
C:\\openvpn_plugins\\foo=2Edll", L""));
+}
+#endif /* _WIN32 */
+
+const st=
ruct CMUnitTest misc_tests[] =3D {
+#ifdef _WIN32
+                        =
                 cmocka_unit_test(test_win_path_in_dir),
+#endif
+         =
                                cmocka_unit_test(test_compat_lzo_string),
 =
                                         cmocka_unit_test(test_auth_fail_te=
mp_no_flags),
                                          cmocka_unit_test(te=
st_auth_fail_temp_flags),
                                          cmocka_=
unit_test(test_auth_fail_temp_flags_msg),

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1736?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc
Gerrit-Cha=
nge-Number: 1736
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@gmail=2E=
com>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plai=
sthos <arne-openvpn@rfc2549=2Eorg>

--LSJ5DGaA95s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1736?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">wi=
n32: fix plugin trusted-dir check prefix bypass<br><br>plugin_in_trusted_di=
r() validated the plugin path against the trusted<br>plugin/install directo=
ry (and the system directory fallback) using a raw<br>string prefix match v=
ia wcsnicmp()=2E When the trusted directory path does<br>not end in a separ=
ator (e=2Eg=2E the plugin_dir registry value is set to<br>&quot;C:\openvpn_=
plugins&quot;), a sibling directory sharing the same prefix<br>(&quot;C:\op=
envpn_plugins_evil&quot;) also passes the check, allowing a plugin to<br>be=
 loaded from outside the allow-listed directory=2E<br><br>Introduce win_pat=
h_in_dir() in win32-util=2Ec which performs the prefix<br>match but additio=
nally requires the match to end on a path-component<br>boundary, and use it=
 for both the plugin/install directory and the<br>system directory checks=
=2E Add unit tests in test_misc=2Ec=2E<br><br>Change-Id: Ib7f9c9ce5ed778190=
445cc4cfaa8f3cd5d1110bc<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Ene=
t&gt;<br>---<br>M src/openvpn/win32-util=2Ec<br>M src/openvpn/win32-util=2E=
h<br>M src/openvpn/win32=2Ec<br>M tests/unit_tests/openvpn/test_misc=2Ec<br=
>4 files changed, 76 insertions(+), 4 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/36/173=
6/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/win32-util=2Ec b/src/openvpn/win32-uti=
l=2Ec</span><br><span>index 6fc3be4=2E=2E5d65c6f 100644</span><br><span>---=
 a/src/openvpn/win32-util=2Ec</span><br><span>+++ b/src/openvpn/win32-util=
=2Ec</span><br><span>@@ -175,4 +175,27 @@</span><br><span>     return tmpdi=
r;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+win_path_in_dir(const WCHAR *path, const WCHAR *dir)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    size_t dir_len =3D wcslen(dir);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (dir_len =3D=3D 0 || wcsnicmp(di=
r, path, dir_len) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* A plain prefix match is not suff=
icient: if dir is &quot;C:\foo&quot; then</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * &quot;C:\foo_evil\bar=2Edll&quot; shares the p=
refix but is not inside &quot;C:\foo&quot;=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * Require that the matched prefix ends on a =
path separator, i=2Ee=2E either</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * dir already ends with a separator or the character follo=
wing the prefix</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * in path is one=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (dir[dir_len - 1] =3D=3D L&#39;\\&#39; || dir[dir_len - 1] =3D=
=3D L&#39;/&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    WCHAR next =3D path[dir_len];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return next =3D=3D L&#39;\\&#3=
9; || next =3D=3D L&#39;/&#39;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> #endif /* _WIN32 */</span><br><span>diff --git a/src/openvpn/wi=
n32-util=2Eh b/src/openvpn/win32-util=2Eh</span><br><span>index 6636cf3=2E=
=2E4849ea9 100644</span><br><span>--- a/src/openvpn/win32-util=2Eh</span><b=
r><span>+++ b/src/openvpn/win32-util=2Eh</span><br><span>@@ -42,5 +42,17 @@=
</span><br><span> /* Find temporary directory */</span><br><span> const cha=
r *win_get_tempdir(void);</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Check whether @p path resides within directory @p dir=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Unlike a plain string prefix match, this =
requires the match to end on a</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * path-component boundary, so that &quot;C:\\foo_evil\\bar&quot=
; is not considered to be</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * inside &quot;C:\\foo&quot;=2E Both arguments are expected to be no=
rmalized absolute</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 paths=2E The comparison is case-insensitive=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @return true if @p path is inside @p dir, false otherwise=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool win_path_in_dir(const WCHAR *pa=
th, const WCHAR *dir);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> #endif /* OPENVPN_WIN32_UTIL_H */</span><br><span> #en=
dif /* ifdef _WIN32 */</span><br><span>diff --git a/src/openvpn/win32=2Ec b=
/src/openvpn/win32=2Ec</span><br><span>index b2a7331=2E=2Eca08ead 100644</s=
pan><br><span>--- a/src/openvpn/win32=2Ec</span><br><span>+++ b/src/openvpn=
/win32=2Ec</span><br><span>@@ -1587,14 +1587,13 @@</span><br><span>     }</=
span><br><span> </span><br><span>     /* Check if the plugin path resides w=
ithin the plugin/install directory */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if ((wcslen(normalized_plugin_dir) &gt; 0)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; (wcsnicmp(norma=
lized_plugin_dir, plugin_path, wcslen(normalized_plugin_dir)) =3D=3D 0))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (win_path_in_di=
r(plugin_path, normalized_plugin_dir))</span><br><span>     {</span><br><sp=
an>         return true;</span><br><span>     }</span><br><span> </span><br=
><span>     /* Fallback to the system directory */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return wcsnicmp(system_dir, plugin_path, w=
cslen(system_dir)) =3D=3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return win_path_in_dir(plugin_path, system_dir);</span><br><sp=
an> }</span><br><span> </span><br><span> bool</span><br><span>diff --git a/=
tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=
=2Ec</span><br><span>index a9ae33f=2E=2Ef883a88 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_t=
ests/openvpn/test_misc=2Ec</span><br><span>@@ -38,6 +38,9 @@</span><br><spa=
n> #include &quot;test_common=2Eh&quot;</span><br><span> #include &quot;lis=
t=2Eh&quot;</span><br><span> #include &quot;mock_msg=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;win32-util=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
> </span><br><span> static void</span><br><span> test_compat_lzo_string(voi=
d **state)</span><br><span>@@ -445,7 +448,42 @@</span><br><span>     mock_s=
et_debug_level(saved_log_level);</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-const struct CMUnitTest mis=
c_tests[] =3D { cmocka_unit_test(test_compat_lzo_string),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_win_path_in_dir(void **state)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* plugin/install dir without trailing separator=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
win_path_in_dir(L&quot;C:\\openvpn_plugins\\foo=2Edll&quot;, L&quot;C:\\ope=
nvpn_plugins&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the bug be=
ing fixed: a sibling dir sharing the prefix must NOT match */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(win_path_in_dir(=
L&quot;C:\\openvpn_plugins_evil\\foo=2Edll&quot;, L&quot;C:\\openvpn_plugin=
s&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* trusted dir with trai=
ling separator */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(win_path_in_dir(L&quot;C:\\openvpn_plugins\\foo=2Edll&quot;, =
L&quot;C:\\openvpn_plugins\\&quot;));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_false(win_path_in_dir(L&quot;C:\\openvpn_plugi=
ns_evil\\foo=2Edll&quot;, L&quot;C:\\openvpn_plugins\\&quot;));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* forward slash separator in the candidate pa=
th is accepted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(win_path_in_dir(L&quot;C:\\openvpn_plugins/foo=2Edll&quot;, L=
&quot;C:\\openvpn_plugins&quot;));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* comparison is case-insensitive */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(win_path_in_dir(L&quot;c:\\OPENVPN_PLUGINS=
\\foo=2Edll&quot;, L&quot;C:\\openvpn_plugins&quot;));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* the directory itself (no trailing component) is not =
&quot;in&quot; the directory */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_false(win_path_in_dir(L&quot;C:\\openvpn_plugins&quo=
t;, L&quot;C:\\openvpn_plugins&quot;));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* nested subdirectories are still inside */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(win_path_in_dir(L&quot;C:\\op=
envpn_plugins\\sub\\foo=2Edll&quot;, L&quot;C:\\openvpn_plugins&quot;));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* an empty trusted dir never matches=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false=
(win_path_in_dir(L&quot;C:\\openvpn_plugins\\foo=2Edll&quot;, L&quot;&quot;=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif /* _WIN32 */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+const struct CMUnitTest misc_tests[] =3D {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
     cmocka_unit_test(test_win_path_in_dir),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                         cmocka_unit_test(test_=
compat_lzo_string),</span><br><span>                                       =
   cmocka_unit_test(test_auth_fail_temp_no_flags),</span><br><span>        =
                                  cmocka_unit_test(test_auth_fail_temp_flag=
s),</span><br><span>                                          cmocka_unit_t=
est(test_auth_fail_temp_flags_msg),</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736?usp=
=3Demail">change 1736</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1736?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1736 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--LSJ5DGaA95s=--


--===============2824540296490643577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2824540296490643577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2824540296490643577==--

