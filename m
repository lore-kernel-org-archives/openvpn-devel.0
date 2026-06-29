Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC461C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+/gxFwrXHnyVa0YT4bwj/FfSBbtblEYuJLCQ3Xfoky8=; b=EyaoLa/JrsAOkF4YEpR0ShGlRr
	J9RJgvTBJV7OFibIWME5QScSIpzmxdOdC1U/aZb6FN0uRKLxFmTGAu30p4waB4qpiLjqy+KGN/EIN
	b71d1ZYBLG7Et2O5+tMRsaLyBkD95btSuC+cPpS+dTnq+tGWvZNGFITEWOakOE55WdL8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weB4t-0007cL-B2;
	Mon, 29 Jun 2026 12:27:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weB4s-0007cF-0l
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:27:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=D8B4bumhl/cDSNLo2Br3rJ4iZVwFyeQ4hdK2l9GOpWU=; b=ZjDwtjpFKdOKCay37oPkPmS5Zw
 fyInVUvSxHmuXTfeP7PoMhlUc5TTRk44StKwXoyQOXUzLhK7wlu5BsgaUgR1Xk8TX/KM/0YiExavb
 g7kTOUA5GrFQ+8epAaDQm0IobADSu2C+naFfGgOhMts80jmUq5t3FzBWQFvG7rpKIbhU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=D8B4bumhl/cDSNLo2Br3rJ4iZVwFyeQ4hdK2l9GOpWU=; b=N
 pNxABEIQomf0CJX+eZYQ6O2uDPIN2Ql/Ga6yHv2CQ0nFnI4Q7Ld4Jy/mPfNGf+Rr4IWzDIDvEtLbE
 W0BehYN9cOX2/V+v+3kuMp+JqxwAxHtwlLGQTlmSeejkPbYXs5V0P6Ky9WPVyI5azr7kB/7nRDwaN
 n+9VvB7aWKuJszUA=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weB4p-0002YQ-JD for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:27:05 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4720d22c94aso1304127f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 05:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782736012; x=1783340812; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D8B4bumhl/cDSNLo2Br3rJ4iZVwFyeQ4hdK2l9GOpWU=;
 b=UlCyfAzBLetMRJeTMAEdXifVSMj+9LD0OfaCaxtMjgKMPKGDB5aclBwvVcqdrYlPWz
 qrNlDwlbvCP6XasRPqqh5IK/ActN/OWe1OBeImLW4g16cTmZeBHCxP5p33oD/uwi48mY
 vphr57WPH8l85s96e7VFYHlDstF1qJarQeMu27+7JirMPD5OMl92vMVfO+cYnG57DeVg
 C6WmxSKwaNH/laOhPXE8pKhAC1RuNhexNcJLe0tDWSQAvmx8bZEdsITjzvrI+vnjojDj
 JZT0aF5hgvkQUIU2ODyBt4lzSH0TYkYpL2UgFxDw/fQRocV1OUWnRfqTN6GBfvZP9krQ
 jZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782736012; x=1783340812;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D8B4bumhl/cDSNLo2Br3rJ4iZVwFyeQ4hdK2l9GOpWU=;
 b=VOZznEuoN7hAb7snN8VocqOvbSjW8evrWlO24DNHqxvCEjhFly23Mh7N/eGX7wR++4
 rnsFlFDy7/brJmSDZbgR8i9DAyoqlRGMowN+vGM2Sr2J6JOTHFMOUbxyFI2f0h03kBOJ
 u93+QKwJraZVxnbf0yW2Mx2dEKFbRGuy2+TRAqL1MpN2Ouev7Tg4TM1eJbg8OZEgWE0X
 cAsMnpn3dHIxdBGduBirRI9g1I7e+0yShif8OkSB4RK7sruD5kzBFHUFSliMEp4u42+W
 ZQA0SwQM1NRqglcp+GBMcQ/ocLQ9ephy78lYdEfoFAvc2+qQ2OLmXdMIz0s47oCwQR9/
 bAvQ==
X-Gm-Message-State: AOJu0Yyi4lJvm15xDK5YuAW4tcfgarPKMpZHy6kJs42dsF+8jXNP8FMV
 owqysoPFXUqyO/qD62WuSjLSMmNYnhwuH5i+eN4BTUs8j50aOOJKsOnwowASzuEpuIenIIox3eX
 cjgt0hzkK3ulGdr5FPC3Ft9InTf00MR7nIShSXR0IqSGuP3dWhnpu+rWI50kdKpTXEc10
X-Gm-Gg: AfdE7cmCKlQ+srxomkx0edpzo47lfDKu6LwUyNQQtyXa6Eq7Pod/AVE+3MEcTunSloA
 Vd7sS6w4N1ACmDhGKxhjEhbF0zz6Vq5nzK7M8NOkGIP394y0/v6b6Iks/cG0VXCQTl1WOJAjcHa
 sRBI73zWaOyI/hN1Ns5FiGj8dUA63VGGuslSjMSvrytkKhDdXfGkfZYqBkwOMTxTO6CrBu7OISa
 pGzecV+qwdR7DjF16SNYQDixHwG+lVZyFDsR+lpGXwQ3iBwmKXYc+/vUR2j/4oG7wUCNeujGua/
 EM54tBWQru/aqRiWdYBZnQYpOHg1qZbvaAfENM5xg1o7BDGzuL3Dmwesqnymaob1HGqyAb1Dx7q
 bzqkQY1jo/24kNLSwD2WZxrntr2oK5dWBwFWl1FTXJkuR/SKW0YM+TVmDbNTmtFdouSc5ZeIweW
 QzK77u+lNH75ibRQQEMsC50M5T0RaI3eKNzADOvmxi62dRd8WdWgf0zAi8x8r/Bu1WS/MME6IpC
 Q91EXdKQLlpLz7vikE/AsM1PRsUh6dV5hoAMmbT30ufIOb29gZzM5TgdNnKS/wkBOLwjKXNgyUb
 byE=
X-Received: by 2002:a05:6000:41da:b0:46f:f12b:e457 with SMTP id
 ffacd0b85a97d-46ff12be58fmr14298950f8f.21.1782736012259; 
 Mon, 29 Jun 2026 05:26:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4721c88bfcasm20547805f8f.10.2026.06.29.05.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:26:51 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 12:26:49 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc
X-Gerrit-Change-Number: 1736
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1736?usp=email>
X-Gerrit-Commit: d809e5626304963ddaff0a8b8ff1e3a6b2db8c09
In-Reply-To: <gerrit.1782556099000.Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc@gerrit.openvpn.net>
References: <gerrit.1782556099000.Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTU2MDk5MDAwLkliN2Y5YzljZTVlZDc3ODE5MDQ0NWNjNGNmYWE4ZjNjZDVkMTExMGJjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b619301d1eb3921db636b5e73af87b2812ebcfb3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weB4p-0002YQ-JD
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1761408483125824970=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1761408483125824970==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="67rDoAd8KME="; charset=UTF-8

--67rDoAd8KME=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

Hello plaisthos,=
 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1736?usp=3Demail

to look at the new patch set (#=
2)=2E

The following approvals got outdated and were removed:
Code-Review-1=
 by plaisthos


Change subject: win32: fix plugin trusted-dir check prefix =
bypass
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

win3=
2: fix plugin trusted-dir check prefix bypass

plugin_in_trusted_dir() vali=
dated the plugin path against the trusted
plugin/install directory (and the=
 system directory fallback) using a raw
string prefix match via wcsnicmp()=
=2E When the trusted directory path does
not end in a separator (e=2Eg=2E t=
he plugin_dir registry value is set to
"C:\openvpn_plugins"), a sibling dir=
ectory sharing the same prefix
("C:\openvpn_plugins_evil") also passes the =
check, allowing a plugin to
be loaded from outside the allow-listed directo=
ry=2E

Introduce win_path_in_dir() in win32-util=2Ec which performs the pre=
fix
match but additionally requires the match to end on a path-component
bo=
undary, and use it for both the plugin/install directory and the
system dir=
ectory checks=2E Add unit tests in test_misc=2Ec=2E

Change-Id: Ib7f9c9ce5e=
d778190445cc4cfaa8f3cd5d1110bc
Signed-off-by: Lev Stipakov <lev@openvpn=2En=
et>
---
M src/openvpn/win32-util=2Ec
M src/openvpn/win32-util=2Eh
M src/ope=
nvpn/win32=2Ec
M tests/unit_tests/openvpn/test_misc=2Ec
4 files changed, 85=
 insertions(+), 9 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/36/1736/2

diff --git a/src/openvpn/win32-util=2Ec=
 b/src/openvpn/win32-util=2Ec
index 6fc3be4=2E=2E209e34e 100644
--- a/src/o=
penvpn/win32-util=2Ec
+++ b/src/openvpn/win32-util=2Ec
@@ -175,4 +175,30 @@=

     return tmpdir;
 }
 
+bool
+win_path_in_dir(const WCHAR *path, const W=
CHAR *dir)
+{
+    size_t dir_len =3D wcslen(dir);
+    /* dir_len <=3D 1 g=
uards the dir[dir_len - 1] access below and rejects a
+     * degenerate si=
ngle-character directory (a normalized absolute path is
+     * always long=
er)=2E */
+    if (dir_len <=3D 1 || wcsnicmp(dir, path, dir_len) !=3D 0)
+=
    {
+        return false;
+    }
+
+    /* A plain prefix match is not s=
ufficient: if dir is "C:\foo" then
+     * "C:\foo_evil\bar=2Edll" shares t=
he prefix but is not inside "C:\foo"=2E
+     * Require that the matched pr=
efix ends on a path separator, i=2Ee=2E either
+     * dir already ends wit=
h a separator or the character following the prefix
+     * in path is one=
=2E */
+    if (dir[dir_len - 1] =3D=3D L'\\' || dir[dir_len - 1] =3D=3D L'=
/')
+    {
+        return true;
+    }
+
+    WCHAR next =3D path[dir_len]=
;
+    return next =3D=3D L'\\' || next =3D=3D L'/';
+}
+
 #endif /* _WIN32=
 */
diff --git a/src/openvpn/win32-util=2Eh b/src/openvpn/win32-util=2Eh
in=
dex 6636cf3=2E=2E4849ea9 100644
--- a/src/openvpn/win32-util=2Eh
+++ b/src/=
openvpn/win32-util=2Eh
@@ -42,5 +42,17 @@
 /* Find temporary directory */
 =
const char *win_get_tempdir(void);
 
+/**
+ * Check whether @p path resides=
 within directory @p dir=2E
+ *
+ * Unlike a plain string prefix match, thi=
s requires the match to end on a
+ * path-component boundary, so that "C:\\=
foo_evil\\bar" is not considered to be
+ * inside "C:\\foo"=2E Both argumen=
ts are expected to be normalized absolute
+ * paths=2E The comparison is ca=
se-insensitive=2E
+ *
+ * @return true if @p path is inside @p dir, false o=
therwise=2E
+ */
+bool win_path_in_dir(const WCHAR *path, const WCHAR *dir)=
;
+
 #endif /* OPENVPN_WIN32_UTIL_H */
 #endif /* ifdef _WIN32 */
diff --gi=
t a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
index b2a7331=2E=2Eca08ea=
d 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -1587,1=
4 +1587,13 @@
     }
 
     /* Check if the plugin path resides within the =
plugin/install directory */
-    if ((wcslen(normalized_plugin_dir) > 0)
- =
       && (wcsnicmp(normalized_plugin_dir, plugin_path, wcslen(normalized_p=
lugin_dir)) =3D=3D 0))
+    if (win_path_in_dir(plugin_path, normalized_plu=
gin_dir))
     {
         return true;
     }
 
     /* Fallback to the sys=
tem directory */
-    return wcsnicmp(system_dir, plugin_path, wcslen(syste=
m_dir)) =3D=3D 0;
+    return win_path_in_dir(plugin_path, system_dir);
 }
=
 
 bool
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_te=
sts/openvpn/test_misc=2Ec
index ccdfdee=2E=2Efc9840a 100644
--- a/tests/uni=
t_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
=
@@ -38,6 +38,9 @@
 #include "test_common=2Eh"
 #include "list=2Eh"
 #includ=
e "mock_msg=2Eh"
+#ifdef _WIN32
+#include "win32-util=2Eh"
+#endif
 
 stati=
c void
 test_compat_lzo_string(void **state)
@@ -445,12 +448,48 @@
     moc=
k_set_debug_level(saved_log_level);
 }
 
-const struct CMUnitTest misc_test=
s[] =3D { cmocka_unit_test(test_compat_lzo_string),
-                      =
                   cmocka_unit_test(test_auth_fail_temp_no_flags),
-       =
                                  cmocka_unit_test(test_auth_fail_temp_flag=
s),
-                                         cmocka_unit_test(test_auth_fa=
il_temp_flags_msg),
-                                         cmocka_unit_t=
est(test_list),
-                                         cmocka_unit_test(=
test_atoi_variants) };
+#ifdef _WIN32
+static void
+test_win_path_in_dir(vo=
id **state)
+{
+    /* plugin/install dir without trailing separator */
+  =
  assert_true(win_path_in_dir(L"C:\\openvpn_plugins\\foo=2Edll", L"C:\\open=
vpn_plugins"));
+
+    /* the bug being fixed: a sibling dir sharing the pr=
efix must NOT match */
+    assert_false(win_path_in_dir(L"C:\\openvpn_plug=
ins_evil\\foo=2Edll", L"C:\\openvpn_plugins"));
+
+    /* trusted dir with =
trailing separator */
+    assert_true(win_path_in_dir(L"C:\\openvpn_plugin=
s\\foo=2Edll", L"C:\\openvpn_plugins\\"));
+    assert_false(win_path_in_di=
r(L"C:\\openvpn_plugins_evil\\foo=2Edll", L"C:\\openvpn_plugins\\"));
+
+  =
  /* forward slash separator in the candidate path is accepted */
+    asse=
rt_true(win_path_in_dir(L"C:\\openvpn_plugins/foo=2Edll", L"C:\\openvpn_plu=
gins"));
+
+    /* comparison is case-insensitive */
+    assert_true(win_p=
ath_in_dir(L"c:\\OPENVPN_PLUGINS\\foo=2Edll", L"C:\\openvpn_plugins"));
+
+=
    /* the directory itself (no trailing component) is not "in" the directo=
ry */
+    assert_false(win_path_in_dir(L"C:\\openvpn_plugins", L"C:\\openv=
pn_plugins"));
+
+    /* nested subdirectories are still inside */
+    ass=
ert_true(win_path_in_dir(L"C:\\openvpn_plugins\\sub\\foo=2Edll", L"C:\\open=
vpn_plugins"));
+
+    /* an empty trusted dir never matches */
+    assert=
_false(win_path_in_dir(L"C:\\openvpn_plugins\\foo=2Edll", L""));
+}
+#endif=
 /* _WIN32 */
+
+const struct CMUnitTest misc_tests[] =3D {
+#ifdef _WIN32
=
+    cmocka_unit_test(test_win_path_in_dir),
+#endif
+    cmocka_unit_test(=
test_compat_lzo_string),
+    cmocka_unit_test(test_auth_fail_temp_no_flags=
),
+    cmocka_unit_test(test_auth_fail_temp_flags),
+    cmocka_unit_test(=
test_auth_fail_temp_flags_msg),
+    cmocka_unit_test(test_list),
+    cmoc=
ka_unit_test(test_atoi_variants)
+};
 
 int
 main(void)

-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1=
110bc
Gerrit-Change-Number: 1736
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <ls=
tipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--67rDoAd8KME=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>stipa <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1736?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">win32: fix plugin trusted-dir check prefix bypass<br><br>plugin_=
in_trusted_dir() validated the plugin path against the trusted<br>plugin/in=
stall directory (and the system directory fallback) using a raw<br>string p=
refix match via wcsnicmp()=2E When the trusted directory path does<br>not e=
nd in a separator (e=2Eg=2E the plugin_dir registry value is set to<br>&quo=
t;C:\openvpn_plugins&quot;), a sibling directory sharing the same prefix<br=
>(&quot;C:\openvpn_plugins_evil&quot;) also passes the check, allowing a pl=
ugin to<br>be loaded from outside the allow-listed directory=2E<br><br>Intr=
oduce win_path_in_dir() in win32-util=2Ec which performs the prefix<br>matc=
h but additionally requires the match to end on a path-component<br>boundar=
y, and use it for both the plugin/install directory and the<br>system direc=
tory checks=2E Add unit tests in test_misc=2Ec=2E<br><br>Change-Id: Ib7f9c9=
ce5ed778190445cc4cfaa8f3cd5d1110bc<br>Signed-off-by: Lev Stipakov &lt;lev@o=
penvpn=2Enet&gt;<br>---<br>M src/openvpn/win32-util=2Ec<br>M src/openvpn/wi=
n32-util=2Eh<br>M src/openvpn/win32=2Ec<br>M tests/unit_tests/openvpn/test_=
misc=2Ec<br>4 files changed, 85 insertions(+), 9 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/36/1736/2</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/win32-util=2Ec b/src/openvpn=
/win32-util=2Ec</span><br><span>index 6fc3be4=2E=2E209e34e 100644</span><br=
><span>--- a/src/openvpn/win32-util=2Ec</span><br><span>+++ b/src/openvpn/w=
in32-util=2Ec</span><br><span>@@ -175,4 +175,30 @@</span><br><span>     ret=
urn tmpdir;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+win_path_in_dir(const WCHAR *path, const WCHAR *dir)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    size_t dir_len =3D wcslen(dir);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* dir_len &lt;=3D 1 guard=
s the dir[dir_len - 1] access below and rejects a</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * degenerate single-character directory =
(a normalized absolute path is</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * always longer)=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (dir_len &lt;=3D 1 || wcsnicmp(dir, path, dir_len=
) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* A plain prefix match is not sufficient: if dir i=
s &quot;C:\foo&quot; then</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * &quot;C:\foo_evil\bar=2Edll&quot; shares the prefix but is not=
 inside &quot;C:\foo&quot;=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * Require that the matched prefix ends on a path separator, =
i=2Ee=2E either</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * dir already ends with a separator or the character following the prefix<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * in path is on=
e=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dir[=
dir_len - 1] =3D=3D L&#39;\\&#39; || dir[dir_len - 1] =3D=3D L&#39;/&#39;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return true;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    WCHAR next =3D path[dir_len];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return next =3D=3D L&#39;\\&#39; || next =3D=3D =
L&#39;/&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif=
 /* _WIN32 */</span><br><span>diff --git a/src/openvpn/win32-util=2Eh b/src=
/openvpn/win32-util=2Eh</span><br><span>index 6636cf3=2E=2E4849ea9 100644</=
span><br><span>--- a/src/openvpn/win32-util=2Eh</span><br><span>+++ b/src/o=
penvpn/win32-util=2Eh</span><br><span>@@ -42,5 +42,17 @@</span><br><span> /=
* Find temporary directory */</span><br><span> const char *win_get_tempdir(=
void);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check wh=
ether @p path resides within directory @p dir=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Unlike a plain string prefix match, this requires the match =
to end on a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * path-=
component boundary, so that &quot;C:\\foo_evil\\bar&quot; is not considered=
 to be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * inside &qu=
ot;C:\\foo&quot;=2E Both arguments are expected to be normalized absolute</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * paths=2E The compa=
rison is case-insensitive=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retu=
rn true if @p path is inside @p dir, false otherwise=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool win_path_in_dir(const WCHAR *path, const WCHAR *di=
r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> #endif /* OPENVPN_WIN32_UTIL_H */</span><br><span> #endif /* ifdef _WIN32=
 */</span><br><span>diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=
=2Ec</span><br><span>index b2a7331=2E=2Eca08ead 100644</span><br><span>--- =
a/src/openvpn/win32=2Ec</span><br><span>+++ b/src/openvpn/win32=2Ec</span><=
br><span>@@ -1587,14 +1587,13 @@</span><br><span>     }</span><br><span> </=
span><br><span>     /* Check if the plugin path resides within the plugin/i=
nstall directory */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if ((wcslen(normalized_plugin_dir) &gt; 0)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        &amp;&amp; (wcsnicmp(normalized_plugin_dir, =
plugin_path, wcslen(normalized_plugin_dir)) =3D=3D 0))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (win_path_in_dir(plugin_path, nor=
malized_plugin_dir))</span><br><span>     {</span><br><span>         return=
 true;</span><br><span>     }</span><br><span> </span><br><span>     /* Fal=
lback to the system directory */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return wcsnicmp(system_dir, plugin_path, wcslen(system_dir))=
 =3D=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n win_path_in_dir(plugin_path, system_dir);</span><br><span> }</span><br><s=
pan> </span><br><span> bool</span><br><span>diff --git a/tests/unit_tests/o=
penvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><sp=
an>index ccdfdee=2E=2Efc9840a 100644</span><br><span>--- a/tests/unit_tests=
/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
misc=2Ec</span><br><span>@@ -38,6 +38,9 @@</span><br><span> #include &quot;=
test_common=2Eh&quot;</span><br><span> #include &quot;list=2Eh&quot;</span>=
<br><span> #include &quot;mock_msg=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;win32-util=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span=
> static void</span><br><span> test_compat_lzo_string(void **state)</span><=
br><span>@@ -445,12 +448,48 @@</span><br><span>     mock_set_debug_level(sa=
ved_log_level);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-const struct CMUnitTest misc_tests[] =3D { =
cmocka_unit_test(test_compat_lzo_string),</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                         cmocka_unit_te=
st(test_auth_fail_temp_no_flags),</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                         cmocka_unit_test(test_=
auth_fail_temp_flags),</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                         cmocka_unit_test(test_auth_fail_t=
emp_flags_msg),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                                   cmocka_unit_test(test_list),</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
        cmocka_unit_test(test_atoi_variants) };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+test_win_path_in_dir(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* plugin/install dir without trailing separator */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(win_path_in_=
dir(L&quot;C:\\openvpn_plugins\\foo=2Edll&quot;, L&quot;C:\\openvpn_plugins=
&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* the bug being fixed: a=
 sibling dir sharing the prefix must NOT match */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_false(win_path_in_dir(L&quot;C:\\o=
penvpn_plugins_evil\\foo=2Edll&quot;, L&quot;C:\\openvpn_plugins&quot;));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* trusted dir with trailing separat=
or */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(win_path_in_dir(L&quot;C:\\openvpn_plugins\\foo=2Edll&quot;, L&quot;C:\\o=
penvpn_plugins\\&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_false(win_path_in_dir(L&quot;C:\\openvpn_plugins_evil\\foo=
=2Edll&quot;, L&quot;C:\\openvpn_plugins\\&quot;));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* forward slash separator in the candidate path is acce=
pted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(win_path_in_dir(L&quot;C:\\openvpn_plugins/foo=2Edll&quot;, L&quot;C:\\=
openvpn_plugins&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* compari=
son is case-insensitive */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(win_path_in_dir(L&quot;c:\\OPENVPN_PLUGINS\\foo=2Edl=
l&quot;, L&quot;C:\\openvpn_plugins&quot;));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* the directory itself (no trailing component) is not &quot;in&q=
uot; the directory */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(win_path_in_dir(L&quot;C:\\openvpn_plugins&quot;, L&quot=
;C:\\openvpn_plugins&quot;));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ne=
sted subdirectories are still inside */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(win_path_in_dir(L&quot;C:\\openvpn_plug=
ins\\sub\\foo=2Edll&quot;, L&quot;C:\\openvpn_plugins&quot;));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* an empty trusted dir never matches */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(win_path_=
in_dir(L&quot;C:\\openvpn_plugins\\foo=2Edll&quot;, L&quot;&quot;));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif /* _WIN32 */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+const struct CMUnitTest misc_tests[] =3D {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_win_path_in_dir),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_compat_lz=
o_string),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmock=
a_unit_test(test_auth_fail_temp_no_flags),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    cmocka_unit_test(test_auth_fail_temp_flags),</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(te=
st_auth_fail_temp_flags_msg),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    cmocka_unit_test(test_list),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    cmocka_unit_test(test_atoi_variants)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span> </span><br>=
<span> int</span><br><span> main(void)</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736?us=
p=3Demail">change 1736</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1736?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1736 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-O=
wner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>

</body></html>
--67rDoAd8KME=--


--===============1761408483125824970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1761408483125824970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1761408483125824970==--

