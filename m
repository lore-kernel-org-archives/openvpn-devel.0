Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6A9C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oRHHK1GgOZLhFZiAzO3SfkgcnsmTykGj7QQYLvQN9V0=; b=O+xUjY+q1Fc36QKoUCY3KiE/C+
	ccRYlXfe4DZ+ucqokkrtqmV6E/3arGsTZFXh42AscR3nSK0gsAfyf+kwcrY1VwN2F7Da2qw1zf2D7
	aHY4GkEi0JoybGyI7AzJEjxu5+QZyktDTHmjhQZBiEpPp+tnt40wCaenwk7MF6+txO/s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvKRm-0000os-FC;
	Sat, 15 Aug 2026 19:53:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvKRk-0000oe-HS
 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 19:53:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=46109nCTZ6GkBwCafGkANtNsJvjVTWXEvNw3aIU0OfI=; b=SQinJdiPqhdgNleQ0PbyTV2V++
 k9qeaZI0M8O9R5Srmiiwz0Qr4tw2131hKN4mGJCkf4geXOtBX2ZYh+wylDNlUCrwdc0yO/1i35qDn
 lfrYX+jkgTNAAXqmWmkBTakzfuztMJxe5l2lb1mqaVit4WxMDAgGrdywwShR1w75q9hg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=46109nCTZ6GkBwCafGkANtNsJvjVTWXEvNw3aIU0OfI=; b=H
 yhBPknDBg0SZPtuV7EAuGubn8MMHgFmLwVsKPKDpxUxPOsuQsq/SstZme4Ihx6n0yL1CwbTotwOjz
 UQZci/VqV+BBB+SGrMSX4fjiLvYw2lugfGZA6HkLxADkYirBuHhV4pRQ9aF77xsP+HE8iexDBej9I
 9fECLX255833+Ev0=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvKRn-0002kt-Ba for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 19:53:37 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso24563905e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 15 Aug 2026 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786823609; x=1787428409; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=46109nCTZ6GkBwCafGkANtNsJvjVTWXEvNw3aIU0OfI=;
 b=Yfdmn0VjB65onb4k1MkA7NDn4Dilo3gEiLVnqMShsRAjoJdoKiE/XKES5FrOpc2sKb
 Wh1xLKjt/2S6mRFh7AhAivcdgCiQoyiB3tEtpcdefTJWLMuPyKVx5AKZJVw4Jt2uTj6h
 DFT4fkYdmVUMXhXgqFRE1uKq/H112lt5jh5P/5QqFoSe2AkoiL6FwFDDpgtIoDFPdauM
 hUf0JmM7puNBDEFPowiuWeFeHXH+IYwZxAa0bfNC1aKNs7tXhPJNft1zYunfk7j4BUxD
 8VJOq0jQHs0kUw8fJEHxW+SLvskDVVGrgF+OsbgDQQtINrRk4tMQoZyI5+cvOCzP1oS/
 H1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823609; x=1787428409;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=46109nCTZ6GkBwCafGkANtNsJvjVTWXEvNw3aIU0OfI=;
 b=rLDYPBEtGQt7ySasiZYPHRBDLhde31UaER8TOWl32wNgz0TxQdXLcBUcnIEADDuGry
 MT1spZ0PFG+im3Nr5UIw6w3hGD6harqeDKsN8JNNyO+T6RY5W+aTC1DgC8k/7ely2mBD
 DugYbdpFLfwwuXzS4U0EqnntxPQX8COWfkHgQcBp1/qeL1cgjqgEGZopMAZfATfCUEVS
 PrRyJuglRejd8yQ8uevUZLlVffDUpb2OjbG7U3xs42HNFMtYyVZXvU30/+zTB4tLnxao
 l+XwC8tmJf1t6RR5K40uHd9+KzhuJPKmF4xuJGInsP4+uxC0VBdEvyHcpg61Uzyh4buV
 ZHvw==
X-Gm-Message-State: AOJu0YxBeLABgr+R19n3TLKwfTykpM6JzM0O8z1MGJ8qFfCJDdhfTXFe
 mHI6APzHxtHi45qUVEOSfhwg1tsiBGdMMMiaMWAJf1SRZoyBljK6bobIXB3gZtJvdnG9+KES4Gk
 TaOIwOM5oTwwZoclLm9HRPLDp7AlWJ1Xj+0/tJFA20driDwhL9vlecUrVUI240ggWPA/f
X-Gm-Gg: AR+sD10PcuewfdtVEjlihYLDeck7FG3ImeDqcQCaNjN+3JXjmYaEzCwQWXlcekvfiM0
 9W+EbChZjW9JUorPTRobVJC9UkfCQ5/4pmVA89rl0i3sUd6oDYzxfq3zc/CUYAGGQzaVzr9uVAv
 WYA7WL0fpGRxIqwPF6H8e2f3AinbyNw4lwubfKAn9xZ1r5sC/vu8HgXYPtX0KmRDmS3KUpPZRNg
 dr9VqvvT0pzxzf3jNM9y6fSlZNYV7QSWKX0CiWs1/hWKSCqUnPDpeeORRokUvzgkrR/6+YeBMIf
 KQ+l0IJF0+S6+FL0KAmLF48yrk5RQlYWYxl8Zg72Rn5JymLzF1nm9BlfaKgHDfS7TaCg2oGEcHa
 XTnrEeLtyRqNaftyrO7kKogEvXEvMYgEmIp3BN7dkXqORoynYbk6buwFs0ciLnlCuORosGIlSES
 k+fQbKSQg/tzfYI3laBmIocxa7UYSj5gENCnTmF6rt0lI4YaWmAyEDKGlI/fiWWWXYc35QrHfJx
 gas0+Nm0Wy7ZlOgVB7k1CSP0fwDnnZhgKxYIkSVznGwVE+cVcmFb/RAUFN5u7MkSnID4SJVNzVg
 blephH/+XRYUemIqgquOWOcJqZ/Ystoa+CFeZpsRBorBXhj3Yf0=
X-Received: by 2002:a05:600c:3acf:b0:499:728c:4704 with SMTP id
 5b1f17b1804b1-49987979c41mr239300925e9.12.1786823608563; 
 Sat, 15 Aug 2026 12:53:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2c07d2sm18909319f8f.30.2026.08.15.12.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:53:27 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 15 Aug 2026 19:53:24 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19
X-Gerrit-Change-Number: 1780
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1780?usp=email>
X-Gerrit-Commit: ab630a14940faf45285473bb9f94ddf1f429ae7a
In-Reply-To: <gerrit.1783961511000.I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19@gerrit.openvpn.net>
References: <gerrit.1783961511000.I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTYxNTExMDAwLkk0MGY3MmRjMDM4YTM4ZTVhZDFkM2RkMDRjYjEwY2I3ZDVjYWQ1ZDE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0c1d5a5dacc9812b31df09c847e526840bade5b8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvKRn-0002kt-Ba
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1553421467588542442=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1553421467588542442==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yphpMdGVdNQ="; charset=UTF-8

--yphpMdGVdNQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1780?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: platform: Add function to determine temp direc=
tory
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

platfor=
m: Add function to determine temp directory

Move the code out of options=
=2Ec and make it shareable=2E
Replace various stripped down versions of the=
 code from
test_*

Change-Id: I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19
Sig=
ned-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Co=
jocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1780
Message-Id: <20260815130619=2E20187-1-gert@greenie=2Emuc=2E=
de>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38408=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/options=2Ec
M src/openvpn/platform=2Ec
M src/openvpn/pl=
atform=2Eh
M tests/unit_tests/openvpn/test_ssl=2Ec
M tests/unit_tests/openv=
pn/test_tls_crypt=2Ec
5 files changed, 40 insertions(+), 35 deletions(-)


=
  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/80/1780/=
2

diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index d0f=
447c=2E=2E4aebfea 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/op=
tions=2Ec
@@ -885,25 +885,8 @@
     o->auth_token_generate =3D false;
 
   =
  /* Set default --tmp-dir */
-#ifdef _WIN32
-    /* On Windows, find temp =
dir via environment variables */
-    o->tmp_dir =3D win_get_tempdir();
+  =
  o->tmp_dir =3D platform_get_tmp_dir();
 
-    if (!o->tmp_dir)
-    {
-  =
      /* Error out if we can't find a valid temporary directory, which shou=
ld
-         * be very unlikely=2E */
-        msg(M_USAGE, "Could not find=
 a suitable temporary directory=2E"
-                     " (GetTempPath() =
failed)=2E  Consider using --tmp-dir");
-    }
-#else  /* ifdef _WIN32 */
-=
    /* Non-windows platforms use $TMPDIR, and if not set, default to '/tmp'=
 */
-    o->tmp_dir =3D getenv("TMPDIR");
-    if (!o->tmp_dir)
-    {
-   =
     o->tmp_dir =3D "/tmp";
-    }
-#endif /* _WIN32 */
     o->allow_recur=
sive_routing =3D false;
 
 #ifndef ENABLE_DCO
diff --git a/src/openvpn/plat=
form=2Ec b/src/openvpn/platform=2Ec
index 85b6408=2E=2E6c766c2 100644
--- a=
/src/openvpn/platform=2Ec
+++ b/src/openvpn/platform=2Ec
@@ -584,6 +584,34 =
@@
     return NULL;
 }
 
+const char *
+platform_get_tmp_dir(void)
+{
+   =
 const char *ret;
+#ifdef _WIN32
+    /* On Windows, find temp dir via envi=
ronment variables */
+    ret =3D win_get_tempdir();
+
+    if (!ret)
+    =
{
+        /* Error out if we can't find a valid temporary directory, which=
 should
+         * be very unlikely=2E */
+        msg(M_USAGE, "Could not=
 find a suitable temporary directory=2E"
+                     " (GetTempPa=
th() failed)=2E  Consider using --tmp-dir");
+    }
+#else
+    /* Non-wind=
ows platforms use $TMPDIR, and if not set, default to '/tmp' */
+    ret =
=3D getenv("TMPDIR");
+    if (!ret)
+    {
+        ret =3D "/tmp";
+    }=

+#endif
+
+    return ret;
+}
+
+
 /*
  * Put a directory and filename tog=
ether=2E
  */
diff --git a/src/openvpn/platform=2Eh b/src/openvpn/platform=
=2Eh
index 8e7ab7e=2E=2E784427bb 100644
--- a/src/openvpn/platform=2Eh
+++ =
b/src/openvpn/platform=2Eh
@@ -128,6 +128,13 @@
 const char *platform_creat=
e_temp_file(const char *directory, const char *prefix,
                    =
                   struct gc_arena *gc);
 
+/**
+ * Get a directory for tem=
porary files
+ *
+ * @return path to a directory
+ */
+const char *platform=
_get_tmp_dir(void);
+
 /** Put a directory and filename together=2E */
 con=
st char *platform_gen_path(const char *directory, const char *filename, str=
uct gc_arena *gc);
 
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/t=
ests/unit_tests/openvpn/test_ssl=2Ec
index cb9c480=2E=2Ed6b63d0 100644
--- =
a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test=
_ssl=2Ec
@@ -117,19 +117,6 @@
     "-----END PRIVATE KEY-----\n";
 
 
-stat=
ic const char *
-get_tmp_dir(void)
-{
-    const char *ret;
-#ifdef _WIN32
=
-    ret =3D win_get_tempdir();
-#else
-    ret =3D "/tmp";
-#endif
-    as=
sert_non_null(ret);
-    return ret;
-}
-
 static struct
 {
     struct gc_=
arena gc;
@@ -142,8 +129,8 @@
 {
     (void)state;
     global_state=2Egc =
=3D gc_new();
-    global_state=2Ecertfile =3D platform_create_temp_file(ge=
t_tmp_dir(), "cert", &global_state=2Egc);
-    global_state=2Ekeyfile =3D p=
latform_create_temp_file(get_tmp_dir(), "key", &global_state=2Egc);
+    gl=
obal_state=2Ecertfile =3D platform_create_temp_file(platform_get_tmp_dir(),=
 "cert", &global_state=2Egc);
+    global_state=2Ekeyfile =3D platform_crea=
te_temp_file(platform_get_tmp_dir(), "key", &global_state=2Egc);
 
     int=
 certfd =3D open(global_state=2Ecertfile, O_RDWR);
     int keyfd =3D open(=
global_state=2Ekeyfile, O_RDWR);
@@ -190,7 +177,7 @@
     cert =3D ctx=2Ecr=
t_chain;
 #endif
 
-    const char *tmpfile =3D platform_create_temp_file(g=
et_tmp_dir(), "ut_pem", &gc);
+    const char *tmpfile =3D platform_create_=
temp_file(platform_get_tmp_dir(), "ut_pem", &gc);
     backend_x509_write_p=
em(cert, tmpfile);
 
     struct buffer exported_pem =3D buffer_read_from_f=
ile(tmpfile, &gc);
diff --git a/tests/unit_tests/openvpn/test_tls_crypt=2Ec=
 b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
index fa313d0=2E=2Edb03437 1=
00644
--- a/tests/unit_tests/openvpn/test_tls_crypt=2Ec
+++ b/tests/unit_te=
sts/openvpn/test_tls_crypt=2Ec
@@ -720,7 +720,7 @@
         tls_options=2Et=
ls_crypt_v2_verify_script =3D "/bin/true";
     }
 
-    tls_options=2Etmp_=
dir =3D "/tmp";
+    tls_options=2Etmp_dir =3D platform_get_tmp_dir();
 
  =
   /* Since we override rand_bytes the tmpfile name is non-random as well=
=2E
      * Build the expected name via the same code path as

-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1780?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I40f72dc038a38e5ad1d3dd04cb10c=
b7d5cad5d19
Gerrit-Change-Number: 1780
Gerrit-PatchSet: 2
Gerrit-Owner: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--yphpMdGVdNQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1780?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">platform: Add function t=
o determine temp directory<br><br>Move the code out of options=2Ec and make=
 it shareable=2E<br>Replace various stripped down versions of the code from=
<br>test_*<br><br>Change-Id: I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19<br>S=
igned-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by=
: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1780<br>Message-Id: &lt;20260815130619=2E201=
87-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg38408=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/options=
=2Ec<br>M src/openvpn/platform=2Ec<br>M src/openvpn/platform=2Eh<br>M tests=
/unit_tests/openvpn/test_ssl=2Ec<br>M tests/unit_tests/openvpn/test_tls_cry=
pt=2Ec<br>5 files changed, 40 insertions(+), 35 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/80/1780/2</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/opt=
ions=2Ec</span><br><span>index d0f447c=2E=2E4aebfea 100644</span><br><span>=
--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec=
</span><br><span>@@ -885,25 +885,8 @@</span><br><span>     o-&gt;auth_token=
_generate =3D false;</span><br><span> </span><br><span>     /* Set default =
--tmp-dir */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _W=
IN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* On Windows=
, find temp dir via environment variables */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    o-&gt;tmp_dir =3D win_get_tempdir();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;tmp_dir =3D platform_=
get_tmp_dir();</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!o-&gt;tmp_dir)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     /* Error out if we can&#39;t find a valid temporary directory, which s=
hould</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * be ve=
ry unlikely=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    msg(M_USAGE, &quot;Could not find a suitable temporary directory=2E&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
  &quot; (GetTempPath() failed)=2E  Consider using --tmp-dir&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#else  /* ifdef _WIN32 */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* Non-windows platforms use $TMPDI=
R, and if not set, default to &#39;/tmp&#39; */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    o-&gt;tmp_dir =3D getenv(&quot;TMPDIR&quot;);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!o-&gt;tmp_di=
r)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;tmp_dir =3D &quot;/tm=
p&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* _WIN32 */</span><br=
><span>     o-&gt;allow_recursive_routing =3D false;</span><br><span> </spa=
n><br><span> #ifndef ENABLE_DCO</span><br><span>diff --git a/src/openvpn/pl=
atform=2Ec b/src/openvpn/platform=2Ec</span><br><span>index 85b6408=2E=2E6c=
766c2 100644</span><br><span>--- a/src/openvpn/platform=2Ec</span><br><span=
>+++ b/src/openvpn/platform=2Ec</span><br><span>@@ -584,6 +584,34 @@</span>=
<br><span>     return NULL;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+const char *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+platform_get_tmp_dir(void)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *ret;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* On Windows, find temp dir via environment vari=
ables */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D=
 win_get_tempdir();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ret)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        /* Error out if we can&#39;t fi=
nd a valid temporary directory, which should</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+         * be very unlikely=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;Could not=
 find a suitable temporary directory=2E&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                     &quot; (GetTempPath() failed=
)=2E  Consider using --tmp-dir&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* No=
n-windows platforms use $TMPDIR, and if not set, default to &#39;/tmp&#39; =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D geten=
v(&quot;TMPDIR&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!ret)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D &=
quot;/tmp&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> /*</span><br><span>  * Put a directory and filename together=2E</span><b=
r><span>  */</span><br><span>diff --git a/src/openvpn/platform=2Eh b/src/op=
envpn/platform=2Eh</span><br><span>index 8e7ab7e=2E=2E784427bb 100644</span=
><br><span>--- a/src/openvpn/platform=2Eh</span><br><span>+++ b/src/openvpn=
/platform=2Eh</span><br><span>@@ -128,6 +128,13 @@</span><br><span> const c=
har *platform_create_temp_file(const char *directory, const char *prefix,</=
span><br><span>                                       struct gc_arena *gc);=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Get a director=
y for temporary files</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return path=
 to a directory</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *platform=
_get_tmp_dir(void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> /** Put a directory and filename together=2E */</span><br=
><span> const char *platform_gen_path(const char *directory, const char *fi=
lename, struct gc_arena *gc);</span><br><span> </span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=
=2Ec</span><br><span>index cb9c480=2E=2Ed6b63d0 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_te=
sts/openvpn/test_ssl=2Ec</span><br><span>@@ -117,19 +117,6 @@</span><br><sp=
an>     &quot;-----END PRIVATE KEY-----\n&quot;;</span><br><span> </span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static const=
 char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_tmp_dir(vo=
id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    const char *ret;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    ret =3D win_get_tempdir();</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    ret =3D &quot;/tmp&quot;;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    assert_non_null(ret);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    return ret;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> static struct</span><br><span> {</span><br><span>     struct gc_a=
rena gc;</span><br><span>@@ -142,8 +129,8 @@</span><br><span> {</span><br><=
span>     (void)state;</span><br><span>     global_state=2Egc =3D gc_new();=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    global_state=2Ece=
rtfile =3D platform_create_temp_file(get_tmp_dir(), &quot;cert&quot;, &amp;=
global_state=2Egc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  global_state=2Ekeyfile =3D platform_create_temp_file(get_tmp_dir(), &quot=
;key&quot;, &amp;global_state=2Egc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    global_state=2Ecertfile =3D platform_create_temp_file(=
platform_get_tmp_dir(), &quot;cert&quot;, &amp;global_state=2Egc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    global_state=2Ekeyfile =
=3D platform_create_temp_file(platform_get_tmp_dir(), &quot;key&quot;, &amp=
;global_state=2Egc);</span><br><span> </span><br><span>     int certfd =3D =
open(global_state=2Ecertfile, O_RDWR);</span><br><span>     int keyfd =3D o=
pen(global_state=2Ekeyfile, O_RDWR);</span><br><span>@@ -190,7 +177,7 @@</s=
pan><br><span>     cert =3D ctx=2Ecrt_chain;</span><br><span> #endif</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const =
char *tmpfile =3D platform_create_temp_file(get_tmp_dir(), &quot;ut_pem&quo=
t;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char *tmpfile =3D platform_create_temp_file(platform_get_tmp_dir(), &qu=
ot;ut_pem&quot;, &amp;gc);</span><br><span>     backend_x509_write_pem(cert=
, tmpfile);</span><br><span> </span><br><span>     struct buffer exported_p=
em =3D buffer_read_from_file(tmpfile, &amp;gc);</span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/te=
st_tls_crypt=2Ec</span><br><span>index fa313d0=2E=2Edb03437 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>+=
++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>@@ -720,7 =
+720,7 @@</span><br><span>         tls_options=2Etls_crypt_v2_verify_script=
 =3D &quot;/bin/true&quot;;</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_options=2Etmp_dir =
=3D &quot;/tmp&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    tls_options=2Etmp_dir =3D platform_get_tmp_dir();</span><br><span> </=
span><br><span>     /* Since we override rand_bytes the tmpfile name is non=
-random as well=2E</span><br><span>      * Build the expected name via the =
same code path as</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1780?usp=3Demail">change 178=
0</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1780?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1780 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>

</body></html>
--yphpMdGVdNQ=--


--===============1553421467588542442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1553421467588542442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1553421467588542442==--

