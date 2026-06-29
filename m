Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D113C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gPVOIAJAMq8qZNHrdVYTKm4HQho0ztYnn9J/NYnB6CM=; b=kOdeHs2WrzFKODwOTF52l/7RqZ
	sZFTnBEG4k2aChwN/nqWzHLRHvW+gZSVFZDfV6k12pzOGIiB+1LiUdu230PCn3RGYsyCieK1CyNYi
	OAYj8JSlpinz36jf5ow6TaZs6eOaBlr048U3eZTZN9n7AVQCk57Had8/eEh7eTM3QpjI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weEOO-0007SM-Sl;
	Mon, 29 Jun 2026 15:59:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weEON-0007S9-06
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 15:59:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0mka84bkGa9vQwg19PYYWkUqzDJDBK26Ib/HbcolerI=; b=d3M5bbOyH1ctdabbDoyG+QPlkV
 pMLRwMyCH8anwUI0BMHRfCWmSjDaKjVZjZog9geRFScm4Dhfiz7t+YN+a3dUzSKAKgfGSVh0Ov6H1
 T1/wD/nie6LfmEkBmUxn3LZSrUoibQw5OBKMnyYuEJpcoziILSVt4EMiudt/XEk0Mrb0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0mka84bkGa9vQwg19PYYWkUqzDJDBK26Ib/HbcolerI=; b=G
 iRqGeE0WODRs5MLiDK8bJHRmj9kuLa1S6d4zQipxIycp044mM1QLOWgOWSYLgclEV9imX+6rVMQR1
 eucfv1Lo0xrvYIadl9c/jrIyj6bOH5LF54CBCtskYyEAlziGmRyTypT0AT/gW9JC4vTumtpwspuWn
 KJIZaOnszN3LpQVE=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weEOH-00034R-KE for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 15:59:24 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-46ee68c3b7aso2996597f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 08:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782748750; x=1783353550; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0mka84bkGa9vQwg19PYYWkUqzDJDBK26Ib/HbcolerI=;
 b=Bd524gFAlfZrEppWrSopeDpZXmB54rC8AAsxA6d3+o+tbtxvPrhtWdCcpQ6VojLQCw
 KPblWxYT0kUDmjkmCHSF8v3XX7eRYHxtXcvlTv8VyXIY2i/Ir0tQaP8vUQ60DpMQsKFs
 0o681dySo2tPN5H4KE/q1wAHLmj5cjXQZqpx8P5GZDDkhYNfQZmn8Gg2c0jwcJnzkJZi
 vqKidcHdsNj9OOHfLBZUqWY5alGS/8i8X6EGgk49u1oy4yplEU08Y50PY4OH1anmABUq
 Ps77QFCp4fc2upT1Gy+Hz7X8gFQhV75VKiNR6O/MJsuz0ocV9aZUSbjzUEdyQCnQ93Cd
 mwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782748750; x=1783353550;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0mka84bkGa9vQwg19PYYWkUqzDJDBK26Ib/HbcolerI=;
 b=KxHgj6dwyq4TlUHYq5DG4ycVUhWxusYfTa1KIjwtUq0eb6XbaB433X2WFonCKcZmLn
 +vdnSJpasf7dhWXTrkT27mn6ijuhQviBAap/fKhkZxKPmWbobhAKX4BBzNQRerYhNLb7
 MGNJUUj2j3/Bi9WEw5IR5UDMRYM8Je0fbhekt+V8EMG7XmIlzeSPk2NZHFtdvRoKd/46
 t85Nb3Nis4r+qTNZC9CCpE9LPiCCYtTfssFLQzQn5tTitt9FSzPcV3AVFB+KxrI9Z8QQ
 VfwsDk9Z8p9cSt4O4UGQltEia8E9e15aXXq8O2w0aWWv+kmtald63lYUxDSzJ2sv/d51
 vZQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RotH6KZNOMfZnEoLLvWFDC8WGA/OR5Kfcpqy0dFXpX33Gv7QyU6vcbVjpcKAX4iDYuE9k06sifXmr15Tfie@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz55kTGEEQZm9PFPtVrchW29n40tk/H4YY+vXSGqrWxurv4ksPn
 KzsK7t80yvHHecks8+Gqds1nYJvGUuTG29+IhK2DjtMbZuAXJRbvcr7iEVBJo3CVDRjP97ycm+G
 fiBomyNKMh/PSVSB/1vuDYrtUPTejL/2pbhaAOhnzMa54J49aISquSzD5PWfuRclPLmqr
X-Gm-Gg: AfdE7clhX9SDbycWBBPDIGB5eltn/8qTORkuipl+heJsKPrxTUNThjoLRUyOoSj/SSf
 hqapJfTryKWll6qCxIOKF3/3u9tT6iSqZnoxCl5sj3XOdRog9qnd3Nn+OaEGJ88R5v7AhjhFMun
 qhrJuHN39VXXQZ1ydEG5VfHCi3D8FIRbjBK+1og+ZYza/VdJOStq1/x6Ieh1XBN73BgM1iB8qKI
 ekxOsjDN7RLtwk7J/CckTobVAYf8+BGu8TzSv1o+72MjVR8Yvi+WqWo+6+HXlrpxGN00J6GuCjy
 ivb78HjJU+cOTrnX1aelcjfge89znJKPtNH6LluIptM2nPOg24X9BxX02g9r4mAz6lo3mbwr9L3
 zVOC0s7nOvWajSFv+XdTQPGnDbq2QRdyh7sDMsv7tPMrjvsJCOMYeg3JEV3udYrzJw51s/LB9xF
 721UOZAgVlkQokDtLQNq5y6TIUknLHDLG9IMXpx12Rl5f/1mqJx6vNuDz2l95iWTOpi7v7hSloE
 snWMosTSxME0AfO7G1HLjsp4oaV0WfD2wTIrYJpbl39ijEGjPVuVHo5sulAVit1XsUOIIAwaL/O
 Ac0=
X-Received: by 2002:a05:6000:605:b0:472:8c12:b93a with SMTP id
 ffacd0b85a97d-4728c12bbcfmr10516753f8f.28.1782748750272; 
 Mon, 29 Jun 2026 08:59:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47496fd271bsm4825709f8f.31.2026.06.29.08.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 08:59:09 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 15:59:09 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc
X-Gerrit-Change-Number: 1736
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1736?usp=email>
X-Gerrit-Commit: c553bb511f074b27334d54a1ce2d4d0c03a9d3e0
In-Reply-To: <gerrit.1782556099000.Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc@gerrit.openvpn.net>
References: <gerrit.1782556099000.Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTU2MDk5MDAwLkliN2Y5YzljZTVlZDc3ODE5MDQ0NWNjNGNmYWE4ZjNjZDVkMTExMGJjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1f6f445430407ca17417fcaf8b07976ae1f8a075-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weEOH-00034R-KE
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5342452540490918235=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5342452540490918235==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8q/A7XWztVo="; charset=UTF-8

--8q/A7XWztVo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1736?usp=3Demail )

Change subject: win32: fix plugin trusted-dir check=
 prefix bypass
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


win32: fix plugin trusted-dir check prefix bypass

plugin_in_trusted_dir(=
) validated the plugin path against the trusted
plugin/install directory (a=
nd the system directory fallback) using a raw
string prefix match via wcsni=
cmp()=2E When the trusted directory path does
not end in a separator (e=2Eg=
=2E the plugin_dir registry value is set to
"C:\openvpn_plugins"), a siblin=
g directory sharing the same prefix
("C:\openvpn_plugins_evil") also passes=
 the check, allowing a plugin to
be loaded from outside the allow-listed di=
rectory=2E

Introduce win_path_in_dir() in win32-util=2Ec which performs th=
e prefix
match but additionally requires the match to end on a path-compone=
nt
boundary, and use it for both the plugin/install directory and the
syste=
m directory checks=2E Add unit tests in test_misc=2Ec=2E

Change-Id: Ib7f9c=
9ce5ed778190445cc4cfaa8f3cd5d1110bc
Reported-By: =E7=AB=A0=E9=B1=BC=E5=93=
=A5 (@AiPy) (www=2Eaipyaipy=2Ecom)
Github: OpenVPN/openvpn-private-issues#1=
20
Reported-by: <genco@srlabs=2Ede>
Github: OpenVPN/openvpn-private-issues#=
109
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1736
Message-Id: <20260629124839=2E32433-1-gert@greenie=2Emuc=2Ede=
>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg37382=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/win32-util=2Ec
M src/openvpn/win32-util=2Eh
M src/openv=
pn/win32=2Ec
M tests/unit_tests/openvpn/test_misc=2Ec
4 files changed, 85 i=
nsertions(+), 9 deletions(-)




diff --git a/src/openvpn/win32-util=2Ec b/=
src/openvpn/win32-util=2Ec
index 6fc3be4=2E=2E209e34e 100644
--- a/src/open=
vpn/win32-util=2Ec
+++ b/src/openvpn/win32-util=2Ec
@@ -175,4 +175,30 @@
  =
   return tmpdir;
 }
 
+bool
+win_path_in_dir(const WCHAR *path, const WCHA=
R *dir)
+{
+    size_t dir_len =3D wcslen(dir);
+    /* dir_len <=3D 1 guar=
ds the dir[dir_len - 1] access below and rejects a
+     * degenerate singl=
e-character directory (a normalized absolute path is
+     * always longer)=
=2E */
+    if (dir_len <=3D 1 || wcsnicmp(dir, path, dir_len) !=3D 0)
+   =
 {
+        return false;
+    }
+
+    /* A plain prefix match is not suff=
icient: if dir is "C:\foo" then
+     * "C:\foo_evil\bar=2Edll" shares the =
prefix but is not inside "C:\foo"=2E
+     * Require that the matched prefi=
x ends on a path separator, i=2Ee=2E either
+     * dir already ends with a=
 separator or the character following the prefix
+     * in path is one=2E =
*/
+    if (dir[dir_len - 1] =3D=3D L'\\' || dir[dir_len - 1] =3D=3D L'/')
=
+    {
+        return true;
+    }
+
+    WCHAR next =3D path[dir_len];
+ =
   return next =3D=3D L'\\' || next =3D=3D L'/';
+}
+
 #endif /* _WIN32 */
=
diff --git a/src/openvpn/win32-util=2Eh b/src/openvpn/win32-util=2Eh
index =
6636cf3=2E=2E4849ea9 100644
--- a/src/openvpn/win32-util=2Eh
+++ b/src/open=
vpn/win32-util=2Eh
@@ -42,5 +42,17 @@
 /* Find temporary directory */
 cons=
t char *win_get_tempdir(void);
 
+/**
+ * Check whether @p path resides wit=
hin directory @p dir=2E
+ *
+ * Unlike a plain string prefix match, this re=
quires the match to end on a
+ * path-component boundary, so that "C:\\foo_=
evil\\bar" is not considered to be
+ * inside "C:\\foo"=2E Both arguments a=
re expected to be normalized absolute
+ * paths=2E The comparison is case-i=
nsensitive=2E
+ *
+ * @return true if @p path is inside @p dir, false other=
wise=2E
+ */
+bool win_path_in_dir(const WCHAR *path, const WCHAR *dir);
+
=
 #endif /* OPENVPN_WIN32_UTIL_H */
 #endif /* ifdef _WIN32 */
diff --git a/=
src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
index b2a7331=2E=2Eca08ead 10=
0644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -1587,14 +1=
587,13 @@
     }
 
     /* Check if the plugin path resides within the plug=
in/install directory */
-    if ((wcslen(normalized_plugin_dir) > 0)
-     =
   && (wcsnicmp(normalized_plugin_dir, plugin_path, wcslen(normalized_plugi=
n_dir)) =3D=3D 0))
+    if (win_path_in_dir(plugin_path, normalized_plugin_=
dir))
     {
         return true;
     }
 
     /* Fallback to the system =
directory */
-    return wcsnicmp(system_dir, plugin_path, wcslen(system_di=
r)) =3D=3D 0;
+    return win_path_in_dir(plugin_path, system_dir);
 }
 
 b=
ool
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/=
openvpn/test_misc=2Ec
index ccdfdee=2E=2Efc9840a 100644
--- a/tests/unit_te=
sts/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -=
38,6 +38,9 @@
 #include "test_common=2Eh"
 #include "list=2Eh"
 #include "m=
ock_msg=2Eh"
+#ifdef _WIN32
+#include "win32-util=2Eh"
+#endif
 
 static vo=
id
 test_compat_lzo_string(void **state)
@@ -445,12 +448,48 @@
     mock_se=
t_debug_level(saved_log_level);
 }
 
-const struct CMUnitTest misc_tests[] =
=3D { cmocka_unit_test(test_compat_lzo_string),
-                          =
               cmocka_unit_test(test_auth_fail_temp_no_flags),
-           =
                              cmocka_unit_test(test_auth_fail_temp_flags),
=
-                                         cmocka_unit_test(test_auth_fail_t=
emp_flags_msg),
-                                         cmocka_unit_test(=
test_list),
-                                         cmocka_unit_test(test=
_atoi_variants) };
+#ifdef _WIN32
+static void
+test_win_path_in_dir(void *=
*state)
+{
+    /* plugin/install dir without trailing separator */
+    as=
sert_true(win_path_in_dir(L"C:\\openvpn_plugins\\foo=2Edll", L"C:\\openvpn_=
plugins"));
+
+    /* the bug being fixed: a sibling dir sharing the prefix=
 must NOT match */
+    assert_false(win_path_in_dir(L"C:\\openvpn_plugins_=
evil\\foo=2Edll", L"C:\\openvpn_plugins"));
+
+    /* trusted dir with trai=
ling separator */
+    assert_true(win_path_in_dir(L"C:\\openvpn_plugins\\f=
oo=2Edll", L"C:\\openvpn_plugins\\"));
+    assert_false(win_path_in_dir(L"=
C:\\openvpn_plugins_evil\\foo=2Edll", L"C:\\openvpn_plugins\\"));
+
+    /*=
 forward slash separator in the candidate path is accepted */
+    assert_t=
rue(win_path_in_dir(L"C:\\openvpn_plugins/foo=2Edll", L"C:\\openvpn_plugins=
"));
+
+    /* comparison is case-insensitive */
+    assert_true(win_path_=
in_dir(L"c:\\OPENVPN_PLUGINS\\foo=2Edll", L"C:\\openvpn_plugins"));
+
+    =
/* the directory itself (no trailing component) is not "in" the directory *=
/
+    assert_false(win_path_in_dir(L"C:\\openvpn_plugins", L"C:\\openvpn_p=
lugins"));
+
+    /* nested subdirectories are still inside */
+    assert_=
true(win_path_in_dir(L"C:\\openvpn_plugins\\sub\\foo=2Edll", L"C:\\openvpn_=
plugins"));
+
+    /* an empty trusted dir never matches */
+    assert_fal=
se(win_path_in_dir(L"C:\\openvpn_plugins\\foo=2Edll", L""));
+}
+#endif /* =
_WIN32 */
+
+const struct CMUnitTest misc_tests[] =3D {
+#ifdef _WIN32
+   =
 cmocka_unit_test(test_win_path_in_dir),
+#endif
+    cmocka_unit_test(test=
_compat_lzo_string),
+    cmocka_unit_test(test_auth_fail_temp_no_flags),
+=
    cmocka_unit_test(test_auth_fail_temp_flags),
+    cmocka_unit_test(test=
_auth_fail_temp_flags_msg),
+    cmocka_unit_test(test_list),
+    cmocka_u=
nit_test(test_atoi_variants)
+};
 
 int
 main(void)

-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc
Ger=
rit-Change-Number: 1736
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@g=
mail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>

--8q/A7XWztVo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1736?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">win32: fix plugin trusted-dir check prefix=
 bypass<br><br>plugin_in_trusted_dir() validated the plugin path against th=
e trusted<br>plugin/install directory (and the system directory fallback) u=
sing a raw<br>string prefix match via wcsnicmp()=2E When the trusted direct=
ory path does<br>not end in a separator (e=2Eg=2E the plugin_dir registry v=
alue is set to<br>&quot;C:\openvpn_plugins&quot;), a sibling directory shar=
ing the same prefix<br>(&quot;C:\openvpn_plugins_evil&quot;) also passes th=
e check, allowing a plugin to<br>be loaded from outside the allow-listed di=
rectory=2E<br><br>Introduce win_path_in_dir() in win32-util=2Ec which perfo=
rms the prefix<br>match but additionally requires the match to end on a pat=
h-component<br>boundary, and use it for both the plugin/install directory a=
nd the<br>system directory checks=2E Add unit tests in test_misc=2Ec=2E<br>=
<br>Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc<br>Reported-By: =
=E7=AB=A0=E9=B1=BC=E5=93=A5 (@AiPy) (www=2Eaipyaipy=2Ecom)<br>Github: OpenV=
PN/openvpn-private-issues#120<br>Reported-by: &lt;genco@srlabs=2Ede&gt;<br>=
Github: OpenVPN/openvpn-private-issues#109<br>Signed-off-by: Lev Stipakov &=
lt;lev@openvpn=2Enet&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736<b=
r>Message-Id: &lt;20260629124839=2E32433-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg37382=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M src/openvpn/win32-util=2Ec<br>M src/openvpn/win32-util=2E=
h<br>M src/openvpn/win32=2Ec<br>M tests/unit_tests/openvpn/test_misc=2Ec<br=
>4 files changed, 85 insertions(+), 9 deletions(-)<br><br></pre>
<pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/win32-util=2Ec b/src/openvpn/win32-util=2Ec</span><br><sp=
an>index 6fc3be4=2E=2E209e34e 100644</span><br><span>--- a/src/openvpn/win3=
2-util=2Ec</span><br><span>+++ b/src/openvpn/win32-util=2Ec</span><br><span=
>@@ -175,4 +175,30 @@</span><br><span>     return tmpdir;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+win_path_in_dir=
(const WCHAR *path, const WCHAR *dir)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    size_t dir_len =3D wcslen(dir);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* dir_len &lt;=3D 1 guards the dir[dir_len - 1] access=
 below and rejects a</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * degenerate single-character directory (a normalized absolute path i=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * always long=
er)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (di=
r_len &lt;=3D 1 || wcsnicmp(dir, path, dir_len) !=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* A =
plain prefix match is not sufficient: if dir is &quot;C:\foo&quot; then</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * &quot;C:\foo_evi=
l\bar=2Edll&quot; shares the prefix but is not inside &quot;C:\foo&quot;=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Require that=
 the matched prefix ends on a path separator, i=2Ee=2E either</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * dir already ends with a se=
parator or the character following the prefix</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * in path is one=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (dir[dir_len - 1] =3D=3D L&#39;\\&=
#39; || dir[dir_len - 1] =3D=3D L&#39;/&#39;)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR next =3D p=
ath[dir_len];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn next =3D=3D L&#39;\\&#39; || next =3D=3D L&#39;/&#39;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> #endif /* _WIN32 */</span><br><span=
>diff --git a/src/openvpn/win32-util=2Eh b/src/openvpn/win32-util=2Eh</span=
><br><span>index 6636cf3=2E=2E4849ea9 100644</span><br><span>--- a/src/open=
vpn/win32-util=2Eh</span><br><span>+++ b/src/openvpn/win32-util=2Eh</span><=
br><span>@@ -42,5 +42,17 @@</span><br><span> /* Find temporary directory */=
</span><br><span> const char *win_get_tempdir(void);</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Check whether @p path resides within =
directory @p dir=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Unlike a plain=
 string prefix match, this requires the match to end on a</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * path-component boundary, so that &=
quot;C:\\foo_evil\\bar&quot; is not considered to be</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * inside &quot;C:\\foo&quot;=2E Both arg=
uments are expected to be normalized absolute</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * paths=2E The comparison is case-insensitive=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @return true if @p path is inside=
 @p dir, false otherwise=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool win=
_path_in_dir(const WCHAR *path, const WCHAR *dir);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* OPENVPN_WIN32_UT=
IL_H */</span><br><span> #endif /* ifdef _WIN32 */</span><br><span>diff --g=
it a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br><span>index b2=
a7331=2E=2Eca08ead 100644</span><br><span>--- a/src/openvpn/win32=2Ec</span=
><br><span>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -1587,14 +1587,13=
 @@</span><br><span>     }</span><br><span> </span><br><span>     /* Check =
if the plugin path resides within the plugin/install directory */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if ((wcslen(normalized_plug=
in_dir) &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  &amp;&amp; (wcsnicmp(normalized_plugin_dir, plugin_path, wcslen(normalize=
d_plugin_dir)) =3D=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (win_path_in_dir(plugin_path, normalized_plugin_dir))</span><b=
r><span>     {</span><br><span>         return true;</span><br><span>     }=
</span><br><span> </span><br><span>     /* Fallback to the system directory=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return wcsnicm=
p(system_dir, plugin_path, wcslen(system_dir)) =3D=3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return win_path_in_dir(plugin_path=
, system_dir);</span><br><span> }</span><br><span> </span><br><span> bool</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/=
unit_tests/openvpn/test_misc=2Ec</span><br><span>index ccdfdee=2E=2Efc9840a=
 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span>=
<br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -=
38,6 +38,9 @@</span><br><span> #include &quot;test_common=2Eh&quot;</span><=
br><span> #include &quot;list=2Eh&quot;</span><br><span> #include &quot;moc=
k_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifd=
ef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;win32-util=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span> </span><br><span> static void</span><br><span=
> test_compat_lzo_string(void **state)</span><br><span>@@ -445,12 +448,48 @=
@</span><br><span>     mock_set_debug_level(saved_log_level);</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-const struct CMUnitTest misc_tests[] =3D { cmocka_unit_test(test_compat_l=
zo_string),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                               cmocka_unit_test(test_auth_fail_temp_no_flag=
s),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
                       cmocka_unit_test(test_auth_fail_temp_flags),</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
            cmocka_unit_test(test_auth_fail_temp_flags_msg),</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                    =
     cmocka_unit_test(test_list),</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                         cmocka_unit_test(test_=
atoi_variants) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
fdef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_win_path_in=
_dir(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* plugin/insta=
ll dir without trailing separator */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(win_path_in_dir(L&quot;C:\\openvpn_plugins=
\\foo=2Edll&quot;, L&quot;C:\\openvpn_plugins&quot;));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* the bug being fixed: a sibling dir sharing the prefi=
x must NOT match */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_false(win_path_in_dir(L&quot;C:\\openvpn_plugins_evil\\foo=2Edll=
&quot;, L&quot;C:\\openvpn_plugins&quot;));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* trusted dir with trailing separator */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(win_path_in_dir(L&quot;C:\\o=
penvpn_plugins\\foo=2Edll&quot;, L&quot;C:\\openvpn_plugins\\&quot;));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(win_pat=
h_in_dir(L&quot;C:\\openvpn_plugins_evil\\foo=2Edll&quot;, L&quot;C:\\openv=
pn_plugins\\&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* forward sl=
ash separator in the candidate path is accepted */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(win_path_in_dir(L&quot;C:\\o=
penvpn_plugins/foo=2Edll&quot;, L&quot;C:\\openvpn_plugins&quot;));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* comparison is case-insensitive */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(win_path_=
in_dir(L&quot;c:\\OPENVPN_PLUGINS\\foo=2Edll&quot;, L&quot;C:\\openvpn_plug=
ins&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the directory itsel=
f (no trailing component) is not &quot;in&quot; the directory */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(win_path_in_d=
ir(L&quot;C:\\openvpn_plugins&quot;, L&quot;C:\\openvpn_plugins&quot;));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* nested subdirectories are still in=
side */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(win_path_in_dir(L&quot;C:\\openvpn_plugins\\sub\\foo=2Edll&quot;, L&quo=
t;C:\\openvpn_plugins&quot;));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a=
n empty trusted dir never matches */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_false(win_path_in_dir(L&quot;C:\\openvpn_plugin=
s\\foo=2Edll&quot;, L&quot;&quot;));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif /* _WIN32 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+const struct CMUnitT=
est misc_tests[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 cmocka_unit_test(test_win_path_in_dir),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    cmocka_unit_test(test_compat_lzo_string),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_auth_fail_temp_=
no_flags),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmock=
a_unit_test(test_auth_fail_temp_flags),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    cmocka_unit_test(test_auth_fail_temp_flags_msg),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(t=
est_list),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmock=
a_unit_test(test_atoi_variants)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+};</span><br><span> </span><br><span> int</span><br><span> main=
(void)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736?usp=3Demail">change 1736</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib7f9c9ce5ed7781=
90445cc4cfaa8f3cd5d1110bc </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1736 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>=

<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--8q/A7XWztVo=--


--===============5342452540490918235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5342452540490918235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5342452540490918235==--

