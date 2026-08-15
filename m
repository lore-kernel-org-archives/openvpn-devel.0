Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98084C5DF6A
	for <openvpn-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o2a2tipFwlIbeS5uGZ77D5WGalF/UpOjF/T1C2d//w8=; b=IXdUHCaYp0IhYuwBAxbP/zRF6X
	+hjtpOHyC/HwusDwx5SdeNx5bfwPoWrRFSKZXXxu6nI9sPMy3z3Bcyt3eYpHU01yx+KQX2Sy4yyDV
	v7+aiia33J7OSplP/UynTzDfHvnTKAH9LyGHQanAgXiqD/pG1JzD6+bhMW8oJS7MGtqI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvKRn-0000fE-9j;
	Sat, 15 Aug 2026 19:53:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvKRk-0000f5-RU
 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 19:53:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LXEWUS9jweMg6e2z6moJutcUoHO0rUq49aoJe5NLjLQ=; b=WcF0cRwNEEQJjRydmVsg/A60+5
 cfY2d/xWam2gbL+eu+aWqiLQjKEi/5fMPEp7bSoqzNGCPKqgtGplmaA4pwrDOaHiVVkSknqhvXXAR
 yghpUcSJ7rBjmN95BmpotAC3jCYGyewfwGB4Dxixff1M0JvtKP8oVttoi7GdJN6xAInU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LXEWUS9jweMg6e2z6moJutcUoHO0rUq49aoJe5NLjLQ=; b=L
 NF8lECsFkH64z1ZjcC7kQxonL38zkwcuht7z442+VSJT3fQpaW1A2jjgc0EQ6wxLfAnYkoPZNsJw5
 RGwZz9HG2xJryFFy6+JynfdVAvz1ku/zCCR13OefLSewVldLu9NKw0YUyebmg1JnYgDtyxvYAgmAs
 Y8oVCv+CzkkDoOK8=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvKRk-0003Wv-DK for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 19:53:37 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so21761325e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 15 Aug 2026 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786823610; x=1787428410; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LXEWUS9jweMg6e2z6moJutcUoHO0rUq49aoJe5NLjLQ=;
 b=MLWDS3rOh1GedA5XU109JXk1Sj1GDLTzaU4d7KxVrL/N0PGms65Kfh0hobgATsEuSc
 a6IOno7Cyq0uUve7i+7ko0COP6+ouv5GMT6vjukGeGpNhlNyVCnmmzFFYUqetQNFgoKy
 MJ1J0vUMXTR6BtRFCBbFfvXDdJVExWEr7YUHnacSCxqCqFv1l1BexE0fCmyhqtHLzJI5
 H3RzCw4dpDbDfl8J+av9ZnBeSzApyzY7mrHlY4b9Rm0z8h8x0KWJnmgbr4l5qKY9p+CW
 G4zGfwEX6ZkMmBW8E0V6UNhLzq3rUNoRJbJ3umBAqMMkCiIcI0UY0VCBTV4QG7FObqyv
 m29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823610; x=1787428410;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LXEWUS9jweMg6e2z6moJutcUoHO0rUq49aoJe5NLjLQ=;
 b=W20yPXEF5UessEB2K2DdRwKxlK3202VNLHjY9QzrztbtBHH4Z2UTq78U0NwnF0lJg7
 xlZ0JEVJWULew4AS9cWLKzv8EB3eaBvN1X10FUWzar+chwpXwabAaacxI7n7ZmJnXMLT
 8y/VOAmHxp649lDyR6/PVpp1EROsyge+1NEwmwpBgS3Ttr11myzOm7rBwYC68j0FiE1D
 VUECu9wlKy8PIMYJVscG4/cEhWILobZlOUUXOWQzLBarXDmooHAH2W6AoKIxe1bDAOcr
 bS06XipF3HqfluowLnTq6SHfXiRZYZt2i2X1YT66vKrlRfvbq9k3HJ9pYG7T+qbX+wQJ
 eaoA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIetSk2Ofit5WBNVYpkdC9H6QoBpmVh8H6jZ5FCnwzVbJjRdeBSbLMQHkMXAfOYeKVtxbw4pATlXruM7VL@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxpQRTIYdNu0/BxITFbteyBGRw27iTZorM/ggZMznmy1lCWk1vi
 nSHh7hUdgEpOxPMNCQlYuXD3RwlCxyWm2k72qVjE9WfsHxeXDfdxnepsK3q+g4ye/izKVTHv3Wm
 NHrlXsgtNdwgcI77gzwle8raUoJj5QJTikgkPCD6J+lZxZnFdMR+xxGV5X1uu6X+h+KxIJjJJJb
 a3SqRarw==
X-Gm-Gg: AR+sD11DS+BydybXbfBIDXZPcLe7IGKNT0tujcnK8MVHB8IQwwZx94wKTMiFCGYaEpG
 XWTENjcSoAKs0N6BBsoRXWETQmzlCQiCA4U5wgxCzgPmTD5oicU3TOv41MXvOvo714RN8q7rav+
 D9ZJcCY5eUqNVgdG1GuiKPeF13mBb8NKt4SpPPLQQwCGi18GP/gAJIe/yUM9OhxDr6HNYEyqQXN
 Zg6Ds41X33BGORkmIhX547npuBB2v29ALyLuhXyMZOGMiRVwuEvTZHeKtNx7UGuyFQihcmX4iw8
 Yo/8SMzdAK2dIDSptuaP1V4tS9ywmHm2dj6Bmmps/G18VNQt4OPrIfgh/A1Q7hfzqb4iFt/gJd9
 tAtj2x7EUCMc5JCGa5Zrkp8NhrN/KG+jyrEabvug9Uw7PtLJyuvrKfIPn1HAj5NKuUNctTtrPLJ
 TfJ+P6NssKrZjkHHQDd8WYUFN8VrKWLTUvQQUA/rfLmrne0oci6Pryp+PlFAEO3UAYzPEtS43fG
 xr/lMIUDXM1D1aN6b7Bx7AdtXNX/AomxzLoSRT/eirz+NJIjQUaClDk/dSccZR955SvZU3tzoA1
 t2edxu30a4xmuPXXErHXBiXGefFG578CzAFgNE412IAKSr6Pau4=
X-Received: by 2002:a05:600c:8209:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-4998796f497mr239670695e9.13.1786823609824; 
 Sat, 15 Aug 2026 12:53:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988aa2273sm156374275e9.0.2026.08.15.12.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:53:29 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 15 Aug 2026 19:53:28 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19
X-Gerrit-Change-Number: 1780
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1780?usp=email>
X-Gerrit-Commit: ab630a14940faf45285473bb9f94ddf1f429ae7a
In-Reply-To: <gerrit.1783961511000.I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19@gerrit.openvpn.net>
References: <gerrit.1783961511000.I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTYxNTExMDAwLkk0MGY3MmRjMDM4YTM4ZTVhZDFkM2RkMDRjYjEwY2I3ZDVjYWQ1ZDE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0c1d5a5dacc9812b31df09c847e526840bade5b8-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvKRk-0003Wv-DK
Subject: [Openvpn-devel] [M] Change in openvpn[master]: platform: Add
 function to determine temp directory
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7982418342311027565=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7982418342311027565==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FwkHAIb1dZI="; charset=UTF-8

--FwkHAIb1dZI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1780?usp=3Demail )

Change subject: platform: Add function to determine=
 temp directory
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

platform: Add function to determine temp directory

Move the code out =
of options=2Ec and make it shareable=2E
Replace various stripped down versi=
ons of the code from
test_*

Change-Id: I40f72dc038a38e5ad1d3dd04cb10cb7d5c=
ad5d19
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by:=
 Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1780
Message-Id: <20260815130619=2E20187-1-gert@greeni=
e=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg38408=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/options=2Ec
M src/openvpn/platform=2Ec
M src=
/openvpn/platform=2Eh
M tests/unit_tests/openvpn/test_ssl=2Ec
M tests/unit_=
tests/openvpn/test_tls_crypt=2Ec
5 files changed, 40 insertions(+), 35 dele=
tions(-)




diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec=

index d0f447c=2E=2E4aebfea 100644
--- a/src/openvpn/options=2Ec
+++ b/src/=
openvpn/options=2Ec
@@ -885,25 +885,8 @@
     o->auth_token_generate =3D fa=
lse;
 
     /* Set default --tmp-dir */
-#ifdef _WIN32
-    /* On Windows, =
find temp dir via environment variables */
-    o->tmp_dir =3D win_get_temp=
dir();
+    o->tmp_dir =3D platform_get_tmp_dir();
 
-    if (!o->tmp_dir)
=
-    {
-        /* Error out if we can't find a valid temporary directory, =
which should
-         * be very unlikely=2E */
-        msg(M_USAGE, "Coul=
d not find a suitable temporary directory=2E"
-                     " (GetT=
empPath() failed)=2E  Consider using --tmp-dir");
-    }
-#else  /* ifdef _=
WIN32 */
-    /* Non-windows platforms use $TMPDIR, and if not set, default=
 to '/tmp' */
-    o->tmp_dir =3D getenv("TMPDIR");
-    if (!o->tmp_dir)
-=
    {
-        o->tmp_dir =3D "/tmp";
-    }
-#endif /* _WIN32 */
     o->a=
llow_recursive_routing =3D false;
 
 #ifndef ENABLE_DCO
diff --git a/src/op=
envpn/platform=2Ec b/src/openvpn/platform=2Ec
index 85b6408=2E=2E6c766c2 10=
0644
--- a/src/openvpn/platform=2Ec
+++ b/src/openvpn/platform=2Ec
@@ -584,=
6 +584,34 @@
     return NULL;
 }
 
+const char *
+platform_get_tmp_dir(voi=
d)
+{
+    const char *ret;
+#ifdef _WIN32
+    /* On Windows, find temp di=
r via environment variables */
+    ret =3D win_get_tempdir();
+
+    if (!=
ret)
+    {
+        /* Error out if we can't find a valid temporary direct=
ory, which should
+         * be very unlikely=2E */
+        msg(M_USAGE, =
"Could not find a suitable temporary directory=2E"
+                     " =
(GetTempPath() failed)=2E  Consider using --tmp-dir");
+    }
+#else
+    /=
* Non-windows platforms use $TMPDIR, and if not set, default to '/tmp' */
+=
    ret =3D getenv("TMPDIR");
+    if (!ret)
+    {
+        ret =3D "/tmp"=
;
+    }
+#endif
+
+    return ret;
+}
+
+
 /*
  * Put a directory and file=
name together=2E
  */
diff --git a/src/openvpn/platform=2Eh b/src/openvpn/p=
latform=2Eh
index 8e7ab7e=2E=2E784427bb 100644
--- a/src/openvpn/platform=
=2Eh
+++ b/src/openvpn/platform=2Eh
@@ -128,6 +128,13 @@
 const char *platf=
orm_create_temp_file(const char *directory, const char *prefix,
           =
                            struct gc_arena *gc);
 
+/**
+ * Get a director=
y for temporary files
+ *
+ * @return path to a directory
+ */
+const char =
*platform_get_tmp_dir(void);
+
 /** Put a directory and filename together=
=2E */
 const char *platform_gen_path(const char *directory, const char *fi=
lename, struct gc_arena *gc);
 
diff --git a/tests/unit_tests/openvpn/test_=
ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index cb9c480=2E=2Ed6b63d0 =
100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/o=
penvpn/test_ssl=2Ec
@@ -117,19 +117,6 @@
     "-----END PRIVATE KEY-----\n"=
;
 
 
-static const char *
-get_tmp_dir(void)
-{
-    const char *ret;
-#if=
def _WIN32
-    ret =3D win_get_tempdir();
-#else
-    ret =3D "/tmp";
-#en=
dif
-    assert_non_null(ret);
-    return ret;
-}
-
 static struct
 {
    =
 struct gc_arena gc;
@@ -142,8 +129,8 @@
 {
     (void)state;
     global_s=
tate=2Egc =3D gc_new();
-    global_state=2Ecertfile =3D platform_create_te=
mp_file(get_tmp_dir(), "cert", &global_state=2Egc);
-    global_state=2Ekey=
file =3D platform_create_temp_file(get_tmp_dir(), "key", &global_state=2Egc=
);
+    global_state=2Ecertfile =3D platform_create_temp_file(platform_get_=
tmp_dir(), "cert", &global_state=2Egc);
+    global_state=2Ekeyfile =3D pla=
tform_create_temp_file(platform_get_tmp_dir(), "key", &global_state=2Egc);
=
 
     int certfd =3D open(global_state=2Ecertfile, O_RDWR);
     int keyfd=
 =3D open(global_state=2Ekeyfile, O_RDWR);
@@ -190,7 +177,7 @@
     cert =
=3D ctx=2Ecrt_chain;
 #endif
 
-    const char *tmpfile =3D platform_create=
_temp_file(get_tmp_dir(), "ut_pem", &gc);
+    const char *tmpfile =3D plat=
form_create_temp_file(platform_get_tmp_dir(), "ut_pem", &gc);
     backend_=
x509_write_pem(cert, tmpfile);
 
     struct buffer exported_pem =3D buffer=
_read_from_file(tmpfile, &gc);
diff --git a/tests/unit_tests/openvpn/test_t=
ls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
index fa313d0=2E=
=2Edb03437 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt=2Ec
+++ b/t=
ests/unit_tests/openvpn/test_tls_crypt=2Ec
@@ -720,7 +720,7 @@
         tls=
_options=2Etls_crypt_v2_verify_script =3D "/bin/true";
     }
 
-    tls_op=
tions=2Etmp_dir =3D "/tmp";
+    tls_options=2Etmp_dir =3D platform_get_tmp=
_dir();
 
     /* Since we override rand_bytes the tmpfile name is non-rand=
om as well=2E
      * Build the expected name via the same code path as

--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1780?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I40f72dc038a38e5ad1d3dd04=
cb10cb7d5cad5d19
Gerrit-Change-Number: 1780
Gerrit-PatchSet: 2
Gerrit-Owner=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--FwkHAIb1dZI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1780?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">platform: Add function to determine temp d=
irectory<br><br>Move the code out of options=2Ec and make it shareable=2E<b=
r>Replace various stripped down versions of the code from<br>test_*<br><br>=
Change-Id: I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19<br>Signed-off-by: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1780<br>Message-Id: &lt;20260815130619=2E20187-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg38408=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/options=2Ec<br>M src/open=
vpn/platform=2Ec<br>M src/openvpn/platform=2Eh<br>M tests/unit_tests/openvp=
n/test_ssl=2Ec<br>M tests/unit_tests/openvpn/test_tls_crypt=2Ec<br>5 files =
changed, 40 insertions(+), 35 deletions(-)<br><br></pre>
<pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index d0f44=
7c=2E=2E4aebfea 100644</span><br><span>--- a/src/openvpn/options=2Ec</span>=
<br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -885,25 +885,8 @=
@</span><br><span>     o-&gt;auth_token_generate =3D false;</span><br><span=
> </span><br><span>     /* Set default --tmp-dir */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* On Windows, find temp dir via environment va=
riables */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o-&gt;t=
mp_dir =3D win_get_tempdir();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    o-&gt;tmp_dir =3D platform_get_tmp_dir();</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!o-&gt;tmp_dir)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        /* Error out if we can&#39;t =
find a valid temporary directory, which should</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-         * be very unlikely=2E */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(M_USAGE, &quot;Could not f=
ind a suitable temporary directory=2E&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                     &quot; (GetTempPath() failed)=2E=
  Consider using --tmp-dir&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#el=
se  /* ifdef _WIN32 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* Non-windows platforms use $TMPDIR, and if not set, default to &#39;=
/tmp&#39; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o-&gt=
;tmp_dir =3D getenv(&quot;TMPDIR&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (!o-&gt;tmp_dir)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        o-&gt;tmp_dir =3D &quot;/tmp&quot;;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif /* _WIN32 */</span><br><span>     o-&gt;allow_recursive_r=
outing =3D false;</span><br><span> </span><br><span> #ifndef ENABLE_DCO</sp=
an><br><span>diff --git a/src/openvpn/platform=2Ec b/src/openvpn/platform=
=2Ec</span><br><span>index 85b6408=2E=2E6c766c2 100644</span><br><span>--- =
a/src/openvpn/platform=2Ec</span><br><span>+++ b/src/openvpn/platform=2Ec</=
span><br><span>@@ -584,6 +584,34 @@</span><br><span>     return NULL;</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+const char *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+platform_get_tmp_dir(void)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char *ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifde=
f _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* On W=
indows, find temp dir via environment variables */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ret =3D win_get_tempdir();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!ret)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        /* Error out if we can&#39;t find a valid temporary directory, w=
hich should</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * be very unlikely=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(M_USAGE, &quot;Could not find a suitable temporary direct=
ory=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
              &quot; (GetTempPath() failed)=2E  Consider using --tmp-dir&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Non-windows platforms use $TMPDIR,=
 and if not set, default to &#39;/tmp&#39; */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ret =3D getenv(&quot;TMPDIR&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ret)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        ret =3D &quot;/tmp&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Put a =
directory and filename together=2E</span><br><span>  */</span><br><span>dif=
f --git a/src/openvpn/platform=2Eh b/src/openvpn/platform=2Eh</span><br><sp=
an>index 8e7ab7e=2E=2E784427bb 100644</span><br><span>--- a/src/openvpn/pla=
tform=2Eh</span><br><span>+++ b/src/openvpn/platform=2Eh</span><br><span>@@=
 -128,6 +128,13 @@</span><br><span> const char *platform_create_temp_file(c=
onst char *directory, const char *prefix,</span><br><span>                 =
                      struct gc_arena *gc);</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Get a directory for temporary files</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @return path to a directory</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+const char *platform_get_tmp_dir(void);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /** Put a dire=
ctory and filename together=2E */</span><br><span> const char *platform_gen=
_path(const char *directory, const char *filename, struct gc_arena *gc);</s=
pan><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index cb9c4=
80=2E=2Ed6b63d0 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
ssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><=
br><span>@@ -117,19 +117,6 @@</span><br><span>     &quot;-----END PRIVATE K=
EY-----\n&quot;;</span><br><span> </span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static const char *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-get_tmp_dir(void)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    const char *ret;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#ifdef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   ret =3D win_get_tempdir();</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =
=3D &quot;/tmp&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_non_=
null(ret);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static struct</span=
><br><span> {</span><br><span>     struct gc_arena gc;</span><br><span>@@ -=
142,8 +129,8 @@</span><br><span> {</span><br><span>     (void)state;</span>=
<br><span>     global_state=2Egc =3D gc_new();</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    global_state=2Ecertfile =3D platform_create_te=
mp_file(get_tmp_dir(), &quot;cert&quot;, &amp;global_state=2Egc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    global_state=2Ekeyfile =3D =
platform_create_temp_file(get_tmp_dir(), &quot;key&quot;, &amp;global_state=
=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    global_s=
tate=2Ecertfile =3D platform_create_temp_file(platform_get_tmp_dir(), &quot=
;cert&quot;, &amp;global_state=2Egc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    global_state=2Ekeyfile =3D platform_create_temp_file(=
platform_get_tmp_dir(), &quot;key&quot;, &amp;global_state=2Egc);</span><br=
><span> </span><br><span>     int certfd =3D open(global_state=2Ecertfile, =
O_RDWR);</span><br><span>     int keyfd =3D open(global_state=2Ekeyfile, O_=
RDWR);</span><br><span>@@ -190,7 +177,7 @@</span><br><span>     cert =3D ct=
x=2Ecrt_chain;</span><br><span> #endif</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    const char *tmpfile =3D platform_cre=
ate_temp_file(get_tmp_dir(), &quot;ut_pem&quot;, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const char *tmpfile =3D platform=
_create_temp_file(platform_get_tmp_dir(), &quot;ut_pem&quot;, &amp;gc);</sp=
an><br><span>     backend_x509_write_pem(cert, tmpfile);</span><br><span> <=
/span><br><span>     struct buffer exported_pem =3D buffer_read_from_file(t=
mpfile, &amp;gc);</span><br><span>diff --git a/tests/unit_tests/openvpn/tes=
t_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><sp=
an>index fa313d0=2E=2Edb03437 100644</span><br><span>--- a/tests/unit_tests=
/openvpn/test_tls_crypt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/=
test_tls_crypt=2Ec</span><br><span>@@ -720,7 +720,7 @@</span><br><span>    =
     tls_options=2Etls_crypt_v2_verify_script =3D &quot;/bin/true&quot;;</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    tls_options=2Etmp_dir =3D &quot;/tmp&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    tls_options=2Etmp_dir =3D =
platform_get_tmp_dir();</span><br><span> </span><br><span>     /* Since we =
override rand_bytes the tmpfile name is non-random as well=2E</span><br><sp=
an>      * Build the expected name via the same code path as</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1780?usp=3Demail">change 1780</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1780?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: I40f72dc038a38e5ad1d3dd04cb10cb7d5ca=
d5d19 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1780 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razva=
nc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

=
</body></html>
--FwkHAIb1dZI=--


--===============7982418342311027565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7982418342311027565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7982418342311027565==--

