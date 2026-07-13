Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E121FC43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=TQpxrGBYgIOAgQHfD9jM720mm+hlYanV6DZrsovAGDc=; b=g+QdjslWpS+9hq
	YNz4F7031wI5m/fMGwazdU42jEBoH6PmfTHfhxfrE+J8KIEk1IWJH5+IX09wFszGzJlakOAni+Xzg
	6n04pqL3Bog/30cEKUyDe5pw0a0mLjGEWR17YujyYkcCOmFk6/rY2Z6JYDU2/Sp6Ryvwnw1uCZqWz
	X5Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjJt9-0001EU-Dr;
	Mon, 13 Jul 2026 16:52:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjJt6-0001EK-Dj
 for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 16:52:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EzYT68ApGmxemSPkxBstj/6eXDI8mD7tY1yUPbwahPQ=; b=ddBx2jQKs0ElWheUfqXOj+LROK
 u9LYDrvY3oS7YIMNM5xzYfGY0SsFLmc4Ka8LlT1QorAOQGXslDr/a8K5VSdYkVZYFXYEHYDUWEHkk
 hnj+/EjZzEpYqElC3N1QrTGU3nEGUzF04cLrL0wyGeWgvLeALwGHhMRK+iqBbJl5eyyc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EzYT68ApGmxemSPkxBstj/6eXDI8mD7tY1yUPbwahPQ=; b=Y
 nr2/K2bfQVxHtayQDk3ZboFBMW3kYLgcEzGgaYPPwXBrEigSARsx1ffeMjcPvdkT7bd1UvfGOWskA
 r5J1MQW7CvVzOXkql/OG0aTbjGFaYz7nh0RyRvtP6ChsfE6ekqt1Z4/Pjrh3XJV1sinPw46b75EFQ
 QTBN3+kLXVbSu/Jw=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjJt3-0007NF-Uo for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 16:52:11 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so24106035e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 13 Jul 2026 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783961518; x=1784566318; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EzYT68ApGmxemSPkxBstj/6eXDI8mD7tY1yUPbwahPQ=;
 b=TwrZITs2Z9ktMq+/5u4AQOgO70XJNY/pIj8t8jc89nd5OspocpcLKrS2zBcQrFjEKy
 bKe5JUzzYMzVJb1Yvm1/F2sSdaP9cV6LuqGUwlxRby2jIC7fdIYe4MqzQL+Xj/XIPkpa
 FMxyy3KUIHf0WdAiMh/Q4fo++cvUqddpFb6kB+hSl7VwRdbCh5LvAreeq94Y5iOb2SCt
 aT5a9Mx2dMKojPTpidXlXGYnzq61H3ewCIeNlrlmGgrwdx6NnoEvXR+/CZtNnUB+hedT
 ltmQhN10ulY7Hsf9foYfqydXZI0K+wU1Hn4oi/fyIlWNj62/1WJZuIdCdb4Mq7es4cUi
 04QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783961518; x=1784566318;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EzYT68ApGmxemSPkxBstj/6eXDI8mD7tY1yUPbwahPQ=;
 b=c6639Naiyj/XSDLdi0HYVGkI+2PW6lLCrTTNqlcTKkebbElTTMdx8XyyCsekCmpRSz
 oHPlvPv0M3pvofC+ZsWrAXNjCwByV5VBMjMq4zexfQcCE/MEHo5g09emzhZKlA6nPfgD
 eccFVMtUz2CvP9U+XCnFf6r2Id/rFRmKxZDKEdq2egc79ety8SGKFFgkXPhBpLXM1yFI
 cUPKf0H8VX6ndN8BfJBoTbQ47vqjHL+ki67RyRnXSrHjBnIIIzMimKZ8+1OCF8XA4UN3
 KNPyq8e229c9YPsx8tyoF6hB72ezpVxlIgjJOqA0djN4aS9tlAVIkgbzXF1Iaen11MRy
 wkCw==
X-Gm-Message-State: AOJu0YzoZGedtlrMtGLX+sPDeZztKoXb9Lpep6qwNr598Yaxf5b80keu
 8RR9T85FTwy0qrLFemAm3KQ5mhPdkGwB/niAVP0VCdnklX0PCjOunqtYj80ovTX9K6A8eOkIXYo
 dRRCK7oy/SEhmGzJVTfD+NSmXE7nF1SzHFsyhDK2Rjo7f3WQYQoK8mAABdAvdX/SGsNFxSJX3Ku
 GmCCXHxQ==
X-Gm-Gg: AfdE7cn7/7U/gjp6niUgK9zFaynlVbAHpxK891ympKsDJY5U6XyBBGjg7vZWMNrS5o7
 /Ez0nMOP5EZNfmUWQqXWcHeMYuCzt1MaEvFwjixYPIHNFUj/CqpJTkQ+oKJwLs3d1LXjX6kCxTn
 8eRqCcNZzvvdgiFYMoavF4j6vLt3QLdrw4xqFAGnReYL/DAExc3OJ7qeyuN6zxSeiUuFr82FssS
 p7IyANV+RSW7A6Q7qxNpLLVfJ8SMz4lNycPPsgKH5AAQ4cbgFzKKpkXGCWekPSogkGDlsCG2zbU
 XYrgUCvbd6mcS3BIZuPA9eGjQyrmjQvQpMCoTJqUj6BKk4IeS8tD/yscfbFuq1W7r0LRrLuYA13
 sVkRYgySA4a85RKxGSjWCVGx2ZWKx4V7csnJ9hfLnzDHnHE8RoZ4GZEkZ9Uj3GKATrqBv+Tt9Aj
 o/4L2gWHNm8CLkYn2gOnOFRVHYtPmWLYU4p2XlMGQyxtbpPXEcDrMimKdmcEd5y1mRJLhraKVgO
 iBd7H2wXZcLOGJg5vU/sEuaB1/2WnlOglGZm1e7NKfy4kag5FEKM5OXBdYRr8HwMfLNFV1jb00V
 2+Mp34QuojcVgQ==
X-Received: by 2002:a05:600c:3e8e:b0:493:faf3:3ea5 with SMTP id
 5b1f17b1804b1-49400c39306mr54044165e9.4.1783961518219; 
 Mon, 13 Jul 2026 09:51:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c25b2sm575796f8f.30.2026.07.13.09.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:51:57 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 13 Jul 2026 16:51:57 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19
X-Gerrit-Change-Number: 1780
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1780?usp=email>
X-Gerrit-Commit: d28dba8619dbfdb15836b6eb8313249eaa681e29
References: <gerrit.1783961511000.I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTYxNTExMDAwLkk0MGY3MmRjMDM4YTM4ZTVhZDFkM2RkMDRjYjEwY2I3ZDVjYWQ1ZDE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <13e891a6f44b9e06c77edeb2c254449762405cad-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjJt3-0007NF-Uo
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5512833037415549049=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5512833037415549049==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+g2VCdUSGVk="; charset=UTF-8

--+g2VCdUSGVk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1780?usp=3Demail

to review the following change=2E


Chang=
e subject: platform: Add function to determine temp directory
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

platform: Add function to=
 determine temp directory

Move the code out of options=2Ec and make it sha=
reable=2E
Replace various stripped down versions of the code from
test_*

C=
hange-Id: I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19
Signed-off-by: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/options=2Ec
M src/ope=
nvpn/platform=2Ec
M src/openvpn/platform=2Eh
M tests/unit_tests/openvpn/tes=
t_ssl=2Ec
M tests/unit_tests/openvpn/test_tls_crypt=2Ec
5 files changed, 40=
 insertions(+), 35 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/80/1780/1

diff --git a/src/openvpn/options=2Ec =
b/src/openvpn/options=2Ec
index 87218d4=2E=2Ec57f398 100644
--- a/src/openv=
pn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -881,25 +881,8 @@
     o->a=
uth_token_generate =3D false;
 
     /* Set default --tmp-dir */
-#ifdef _W=
IN32
-    /* On Windows, find temp dir via environment variables */
-    o-=
>tmp_dir =3D win_get_tempdir();
+    o->tmp_dir =3D platform_get_tmp_dir();=

 
-    if (!o->tmp_dir)
-    {
-        /* Error out if we can't find a va=
lid temporary directory, which should
-         * be very unlikely=2E */
- =
       msg(M_USAGE, "Could not find a suitable temporary directory=2E"
-   =
                  " (GetTempPath() failed)=2E  Consider using --tmp-dir");
=
-    }
-#else  /* ifdef _WIN32 */
-    /* Non-windows platforms use $TMPDIR=
, and if not set, default to '/tmp' */
-    o->tmp_dir =3D getenv("TMPDIR")=
;
-    if (!o->tmp_dir)
-    {
-        o->tmp_dir =3D "/tmp";
-    }
-#end=
if /* _WIN32 */
     o->allow_recursive_routing =3D false;
 
 #ifndef ENABL=
E_DCO
diff --git a/src/openvpn/platform=2Ec b/src/openvpn/platform=2Ec
inde=
x 85b6408=2E=2E6c766c2 100644
--- a/src/openvpn/platform=2Ec
+++ b/src/open=
vpn/platform=2Ec
@@ -584,6 +584,34 @@
     return NULL;
 }
 
+const char *
=
+platform_get_tmp_dir(void)
+{
+    const char *ret;
+#ifdef _WIN32
+    /*=
 On Windows, find temp dir via environment variables */
+    ret =3D win_ge=
t_tempdir();
+
+    if (!ret)
+    {
+        /* Error out if we can't find=
 a valid temporary directory, which should
+         * be very unlikely=2E =
*/
+        msg(M_USAGE, "Could not find a suitable temporary directory=2E"=

+                     " (GetTempPath() failed)=2E  Consider using --tmp-di=
r");
+    }
+#else
+    /* Non-windows platforms use $TMPDIR, and if not se=
t, default to '/tmp' */
+    ret =3D getenv("TMPDIR");
+    if (!ret)
+    =
{
+        ret =3D "/tmp";
+    }
+#endif
+
+    return ret;
+}
+
+
 /*
  *=
 Put a directory and filename together=2E
  */
diff --git a/src/openvpn/pla=
tform=2Eh b/src/openvpn/platform=2Eh
index 8e7ab7e=2E=2E784427bb 100644
---=
 a/src/openvpn/platform=2Eh
+++ b/src/openvpn/platform=2Eh
@@ -128,6 +128,1=
3 @@
 const char *platform_create_temp_file(const char *directory, const ch=
ar *prefix,
                                       struct gc_arena *gc);
 
=
+/**
+ * Get a directory for temporary files
+ *
+ * @return path to a dire=
ctory
+ */
+const char *platform_get_tmp_dir(void);
+
 /** Put a directory =
and filename together=2E */
 const char *platform_gen_path(const char *dire=
ctory, const char *filename, struct gc_arena *gc);
 
diff --git a/tests/uni=
t_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index =
0e9cecf=2E=2E065c7e3f 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
++=
+ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -115,19 +115,6 @@
     "-----E=
ND PRIVATE KEY-----\n";
 
 
-static const char *
-get_tmp_dir(void)
-{
-   =
 const char *ret;
-#ifdef _WIN32
-    ret =3D win_get_tempdir();
-#else
-  =
  ret =3D "/tmp";
-#endif
-    assert_non_null(ret);
-    return ret;
-}
-
=
 static struct
 {
     struct gc_arena gc;
@@ -140,8 +127,8 @@
 {
     (voi=
d)state;
     global_state=2Egc =3D gc_new();
-    global_state=2Ecertfile =
=3D platform_create_temp_file(get_tmp_dir(), "cert", &global_state=2Egc);
-=
    global_state=2Ekeyfile =3D platform_create_temp_file(get_tmp_dir(), "ke=
y", &global_state=2Egc);
+    global_state=2Ecertfile =3D platform_create_t=
emp_file(platform_get_tmp_dir(), "cert", &global_state=2Egc);
+    global_s=
tate=2Ekeyfile =3D platform_create_temp_file(platform_get_tmp_dir(), "key",=
 &global_state=2Egc);
 
     int certfd =3D open(global_state=2Ecertfile, O=
_RDWR);
     int keyfd =3D open(global_state=2Ekeyfile, O_RDWR);
@@ -188,7 =
+175,7 @@
     cert =3D ctx=2Ecrt_chain;
 #endif
 
-    const char *tmpfile=
 =3D platform_create_temp_file(get_tmp_dir(), "ut_pem", &gc);
+    const ch=
ar *tmpfile =3D platform_create_temp_file(platform_get_tmp_dir(), "ut_pem",=
 &gc);
     backend_x509_write_pem(cert, tmpfile);
 
     struct buffer exp=
orted_pem =3D buffer_read_from_file(tmpfile, &gc);
diff --git a/tests/unit_=
tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec
index 1d8ac25=2E=2Ea2987c6 100644
--- a/tests/unit_tests/openvpn/test_=
tls_crypt=2Ec
+++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
@@ -720,7 +=
720,7 @@
         tls_options=2Etls_crypt_v2_verify_script =3D "/bin/true";=

     }
 
-    tls_options=2Etmp_dir =3D "/tmp";
+    tls_options=2Etmp_dir=
 =3D platform_get_tmp_dir();
 
     /* Since we override rand_bytes the tmp=
file name is non-random as well=2E
      * Build the expected name via the =
same code path as

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1780?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19
Gerrit-Change-Number: 1780
Gerrit-=
PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>

--+g2VCdUSGVk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1780?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">platform: Add function to determine temp directory<br><br>Move the cod=
e out of options=2Ec and make it shareable=2E<br>Replace various stripped d=
own versions of the code from<br>test_*<br><br>Change-Id: I40f72dc038a38e5a=
d1d3dd04cb10cb7d5cad5d19<br>Signed-off-by: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt;<br>---<br>M src/openvpn/options=2Ec<br>M src/openvpn/plat=
form=2Ec<br>M src/openvpn/platform=2Eh<br>M tests/unit_tests/openvpn/test_s=
sl=2Ec<br>M tests/unit_tests/openvpn/test_tls_crypt=2Ec<br>5 files changed,=
 40 insertions(+), 35 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/80/1780/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>i=
ndex 87218d4=2E=2Ec57f398 100644</span><br><span>--- a/src/openvpn/options=
=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -881,=
25 +881,8 @@</span><br><span>     o-&gt;auth_token_generate =3D false;</spa=
n><br><span> </span><br><span>     /* Set default --tmp-dir */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /* On Windows, find temp dir via envir=
onment variables */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  o-&gt;tmp_dir =3D win_get_tempdir();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    o-&gt;tmp_dir =3D platform_get_tmp_dir();</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!o-&gt=
;tmp_dir)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Error out if we c=
an&#39;t find a valid temporary directory, which should</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-         * be very unlikely=2E */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_USAGE, &quot;Co=
uld not find a suitable temporary directory=2E&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                     &quot; (GetTempPath() =
failed)=2E  Consider using --tmp-dir&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#else  /* ifdef _WIN32 */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* Non-windows platforms use $TMPDIR, and if not set, defaul=
t to &#39;/tmp&#39; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    o-&gt;tmp_dir =3D getenv(&quot;TMPDIR&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!o-&gt;tmp_dir)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        o-&gt;tmp_dir =3D &quot;/tmp&quot;;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif /* _WIN32 */</span><br><span>     o-&gt;allow_=
recursive_routing =3D false;</span><br><span> </span><br><span> #ifndef ENA=
BLE_DCO</span><br><span>diff --git a/src/openvpn/platform=2Ec b/src/openvpn=
/platform=2Ec</span><br><span>index 85b6408=2E=2E6c766c2 100644</span><br><=
span>--- a/src/openvpn/platform=2Ec</span><br><span>+++ b/src/openvpn/platf=
orm=2Ec</span><br><span>@@ -584,6 +584,34 @@</span><br><span>     return NU=
LL;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+const char *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+platform_get_tmp_dir(void)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const char *ret;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* On Windows, find temp dir via environment variables */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ret =3D win_get_tempdir();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!ret)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        /* Error out if we can&#39;t find a valid temporary d=
irectory, which should</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+         * be very unlikely=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        msg(M_USAGE, &quot;Could not find a suitable tempo=
rary directory=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                     &quot; (GetTempPath() failed)=2E  Consider using -=
-tmp-dir&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* Non-windows platforms us=
e $TMPDIR, and if not set, default to &#39;/tmp&#39; */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ret =3D getenv(&quot;TMPDIR&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ret)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        ret =3D &quot;/tmp&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>=
  * Put a directory and filename together=2E</span><br><span>  */</span><br=
><span>diff --git a/src/openvpn/platform=2Eh b/src/openvpn/platform=2Eh</sp=
an><br><span>index 8e7ab7e=2E=2E784427bb 100644</span><br><span>--- a/src/o=
penvpn/platform=2Eh</span><br><span>+++ b/src/openvpn/platform=2Eh</span><b=
r><span>@@ -128,6 +128,13 @@</span><br><span> const char *platform_create_t=
emp_file(const char *directory, const char *prefix,</span><br><span>       =
                                struct gc_arena *gc);</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Get a directory for temporary files<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @return path to a directory</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+const char *platform_get_tmp_dir(void);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**=
 Put a directory and filename together=2E */</span><br><span> const char *p=
latform_gen_path(const char *directory, const char *filename, struct gc_are=
na *gc);</span><br><span> </span><br><span>diff --git a/tests/unit_tests/op=
envpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>=
index 0e9cecf=2E=2E065c7e3f 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=
=2Ec</span><br><span>@@ -115,19 +115,6 @@</span><br><span>     &quot;-----E=
ND PRIVATE KEY-----\n&quot;;</span><br><span> </span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-static const char *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-get_tmp_dir(void)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    const char *ret;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    ret =3D win_get_tempdir();</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    ret =3D &quot;/tmp&quot;;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    as=
sert_non_null(ret);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static str=
uct</span><br><span> {</span><br><span>     struct gc_arena gc;</span><br><=
span>@@ -140,8 +127,8 @@</span><br><span> {</span><br><span>     (void)stat=
e;</span><br><span>     global_state=2Egc =3D gc_new();</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    global_state=2Ecertfile =3D platform_=
create_temp_file(get_tmp_dir(), &quot;cert&quot;, &amp;global_state=2Egc);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    global_state=2Ekey=
file =3D platform_create_temp_file(get_tmp_dir(), &quot;key&quot;, &amp;glo=
bal_state=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 global_state=2Ecertfile =3D platform_create_temp_file(platform_get_tmp_dir=
(), &quot;cert&quot;, &amp;global_state=2Egc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    global_state=2Ekeyfile =3D platform_create_t=
emp_file(platform_get_tmp_dir(), &quot;key&quot;, &amp;global_state=2Egc);<=
/span><br><span> </span><br><span>     int certfd =3D open(global_state=2Ec=
ertfile, O_RDWR);</span><br><span>     int keyfd =3D open(global_state=2Eke=
yfile, O_RDWR);</span><br><span>@@ -188,7 +175,7 @@</span><br><span>     ce=
rt =3D ctx=2Ecrt_chain;</span><br><span> #endif</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    const char *tmpfile =3D pla=
tform_create_temp_file(get_tmp_dir(), &quot;ut_pem&quot;, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *tmpfile =3D=
 platform_create_temp_file(platform_get_tmp_dir(), &quot;ut_pem&quot;, &amp=
;gc);</span><br><span>     backend_x509_write_pem(cert, tmpfile);</span><br=
><span> </span><br><span>     struct buffer exported_pem =3D buffer_read_fr=
om_file(tmpfile, &amp;gc);</span><br><span>diff --git a/tests/unit_tests/op=
envpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec</spa=
n><br><span>index 1d8ac25=2E=2Ea2987c6 100644</span><br><span>--- a/tests/u=
nit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>+++ b/tests/unit_tests=
/openvpn/test_tls_crypt=2Ec</span><br><span>@@ -720,7 +720,7 @@</span><br><=
span>         tls_options=2Etls_crypt_v2_verify_script =3D &quot;/bin/true&=
quot;;</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    tls_options=2Etmp_dir =3D &quot;/tmp&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_options=2Etmp=
_dir =3D platform_get_tmp_dir();</span><br><span> </span><br><span>     /* =
Since we override rand_bytes the tmpfile name is non-random as well=2E</spa=
n><br><span>      * Build the expected name via the same code path as</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1780?usp=3Demail">change 1780</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1780?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I40f72dc038a38e5ad1d3dd04=
cb10cb7d5cad5d19 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
1780 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--+g2VCdUSGVk=--


--===============5512833037415549049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5512833037415549049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5512833037415549049==--

