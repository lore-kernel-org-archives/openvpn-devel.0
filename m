Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB51606A33D
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CgXCgau/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iPp03cDw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=nAQnGdnK;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TKIJkNhH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LlDgdtdMj6rd+HUmxzGIzQ9Elv1abzQwufMMQEELNpQ=; b=CgXCgau/C+bl+ziVvrLnJWtfmx
	lsGiV44dLq53dnSFlpYSw+tgYamsmO4WcG1o7cNAbHHQgZFlGS+1meCEsa4//b9ml4Vsod4UU9knb
	d11iaj4my2UciolkFMEi+yQ/pL37cl4ZWWCGO0p7IiOHVUvwO2cG6lB03oiBuYi5cP4w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNr4p-000000004ku-11vu;
	Mon, 02 Nov 2026 12:23:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNr4n-000000004ko-411R
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:23:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b5r2jtifWFKm9BSlVnzhpn7c40MauBf20hJbGzXsXOw=; b=iPp03cDwRVA0Hajd7IsmgK+vZp
 3JNrO6Y/IawCY5h0bNhtcnL25J9b2Wo+/+WZe2rWfNETun4ZeTGLN0ws2mqzslx6IvoyNRTZZwIwC
 HC9hHIcSni40cMvvfaF9oUZsFXGySfrvF8vBTFRvLaOct2wfUciUQ+k1C5075MzoqzKI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b5r2jtifWFKm9BSlVnzhpn7c40MauBf20hJbGzXsXOw=; b=nAQnGdnKQsuDMXBZG401JMtvvy
 gnUdPsCDtFmBf9WSS1vECx6cZfGRRV8DRU4EDVk/AfHR9wScHwDEch5GX2wLE6VCUy5Yqlq+nVT5P
 xnibY0BgiwWbjH+jR6GrjRmZjRDJzLikRl+td2zT6dnrlIh1okkpBAbcx5vm5M0Km4fI=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNr4m-000000006in-2f2l for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:23:49 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so19164325e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 04:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793622222; x=1794227022; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b5r2jtifWFKm9BSlVnzhpn7c40MauBf20hJbGzXsXOw=;
 b=TKIJkNhHP8P8H/jZCJ9IEMUupjTQ2fcGvPqaeECc7m9BZ9OlCmIoJj2figLtiBISxx
 qHP7E5tWz7vx4O/kaSon51Nw5qbcF24W0u73O7aPvqzwQfmrtMqCb5ZdHHc0p9foVIL2
 PyD+1wb5yHwI6mHGSuZfkz9bisEm1/gV3VlxNQKK6HuhKcTjgyy3SOuZDXJESw0QNWob
 xkeXh8qOrI4QM/GrLBi7WYZG7J/UZqEet+P/Z8esVSTy4Zv9kpMcQ9CUUTZDRqclxWMy
 Zq3nYI1pj+I/hRSz1HoNzZF5/A/LL2Kz+mZAk2pkPf0E6wLHSbJTEVGMaTw3W2Bj+DVC
 aAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793622222; x=1794227022;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=b5r2jtifWFKm9BSlVnzhpn7c40MauBf20hJbGzXsXOw=;
 b=T6v+BZGfXsXrgAMd04Ai/pViLi0fol6dRl8rv6WtjaFFFZ6ubmcq9D9CSx6geeB91W
 AAw79aX9RfssZcjEwll4o/aqyORCVxbwX6+rtEhgvLm10sFQAA/WKTMaDi9MZ4sOzpC4
 GWk9imd7TVrApQ24ET4u3hyXx/tgTJEqHC658/0rm7Njrfg4h9gthmQ/y7PbRdHxBaM7
 O/BN5e7vVmCPF+FLTT2bMAFV0kFKpuiWIjqEDnBtTThZDk+ggil5PfAJ1MHsFs20Wnrh
 kWHV5k/QXG9J/2GCGgPe9l72HLfjn489Gc2DPOORvhktgBcWYthp6Yt8fKM2uqZECtze
 aCNQ==
X-Gm-Message-State: AFq9FYJoQIs+ASECxoPOV1ziUeGblQ5vCLlB0oKF4aX2EQ6SmOH9rlD5
 X14B8ZMC9y/Dt/IOobeYPz0IxC4dH26Ird2ZSoMUtSNgEIuH5MjbyIa8Bcj4JtqlVdv+y7Z1TAN
 VGwWpXD/3RWRvKH7gji9jWxSc2Xboiv1yaIVi3GWf7GTxMdTrdY3GHTsZzKD2ynsmu4LsKCXEgR
 hb3VpeCA==
X-Gm-Gg: AYBFou2EbMsnX4h5JbiHbMXTfo6phrV2GFloDYyg5FJ3NIcelJSVoeWjA50Q1YbdUyK
 SbyFFxBR0Xwm3O7c179LjPDBXQatACLhYC9MIru1q+72MgvDEGn6Kfa+NxgkKqlGuFdAK3vGAsM
 tIwxQYNwyK5In/6O5KlHmNd3e0ctGs8XvQOUK+KJTSkUAhzA/P3IiZt4ARoB5xRxUva8TmV3T6E
 1JZu7sGgi3K1pAMlIq6pOvhhjJsKvKXEwCOZLzMKcBKsOM/L8MZOzv4kwTr5Ugxa6VO7lo4DMQS
 cRkcWBq1thcFObLzi5vpc5fNfG/J0YPGFdvopakUITZ1Kioal0sGfHc9r58lR+GNgishclUSEWY
 sVE6udeYWJqkgpB4GZamRqfbHdFGTzIWk5yJKMVI2HCWGKz1WYmy8MKs22SEPGpq/KuwxpSnzuV
 HE/zrR+PL1VwLRE7CJ1ue5fSDNz5cnSHDxWrxq6biE5LwOS8VWACn4vC7W1lnx2pFA/wTAjRIc9
 RRDfPwirzGme2jdZKiebksJMLZnXOU4cEZQXt+HyMLhw9mbuc1NO11tOKmZ08MJOW6SNAGorZof
 Vy9e+B1+/pJapxU0WYWTXkimjHW/GSwSNeYSrco2b30qjqsfnDTPf1CmMrTb7AlwlAArAltD6/y
 d1EDwU+j2+fcoWkMVEFZa79CTM5fHnWTqS6kBOIRIlPUNfeVFxuTZuu612yy0NKXArARIbYkPlz
 Mc6O/fEpS8RdE42g==
X-Received: by 2002:a05:600c:3b1a:b0:4a7:9044:a87 with SMTP id
 5b1f17b1804b1-4ac18c73df6mr227444485e9.27.1793622221948; 
 Mon, 02 Nov 2026 04:23:41 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8c0b6sm19095741f8f.41.2026.11.02.04.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 04:23:41 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 12:23:39 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
X-Gerrit-Change-Number: 2080
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2080?usp=email>
X-Gerrit-Commit: 8191543f128ca4c29ac7f0806663132bead3d1ae
In-Reply-To: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
References: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljNWNmNWVmNzIzYTMzYWQzMDRiMDgwZWYxOWRiMmU0YTBmNGJiMmViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b363d62a7536f363ce1b2326732fb23af8ed6fc6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNr4m-000000006in-2f2l
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Clean up weak key
 check
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4694173105729905511=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4694173105729905511==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GP//0LjT2Vs="; charset=UTF-8

--GP//0LjT2Vs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Frank Lichtenheld, 

I'd like you to reexamine a change=2E Please visi=
t

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail

to look=
 at the new patch set (#2)=2E

The following approvals got outdated and wer=
e removed:
Code-Review-1 by Frank Lichtenheld


Change subject: Clean up we=
ak key check
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Clean up weak key check

These methods only check for zero keys after wea=
k DES checks were removed=2E
Simplify all this to always the first 32 bytes=
 of key and hmac and ensure
that they are not zero=2E

This now always rais=
es a FATAL alert instead of handling this error
gracefully but a all zeros =
keys should never ever happen=2E

Change-Id: Ic5cf5ef723a33ad304b080ef19db2=
e4a0f4bb2eb
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/open=
vpn/crypto=2Ec
M src/openvpn/crypto=2Eh
M src/openvpn/ssl=2Ec
3 files chang=
ed, 14 insertions(+), 57 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/80/2080/2

diff --git a/src/openvpn/crypt=
o=2Ec b/src/openvpn/crypto=2Ec
index 3d3ab0c=2E=2E386b164 100644
--- a/src/=
openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1104,40 +1104,6 @@
    =
 ctx->initialized =3D false;
 }
 
-static bool
-key_is_zero(const struct ke=
y *key, const struct key_type *kt)
-{
-    size_t cipher_length =3D cipher_=
kt_key_size(kt->cipher);
-    for (size_t i =3D 0; i < cipher_length; ++i)
=
-    {
-        if (key->cipher[i])
-        {
-            return false;
-=
        }
-    }
-    msg(D_CRYPT_ERRORS, "CRYPTO INFO: WARNING: zero key d=
etected");
-    return true;
-}
-
-/*
- * Make sure that cipher key is a va=
lid key for current key_type=2E
- */
-bool
-check_key(const struct key *key=
, const struct key_type *kt)
-{
-    if (cipher_defined(kt->cipher))
-    {=

-        /*
-         * Check for zero key
-         */
-        if (key_i=
s_zero(key, kt))
-        {
-            return false;
-        }
-    }
- =
   return true;
-}
-
 /*
  * Generate a random key=2E
  */
@@ -1307,8 +1273=
,8 @@
             print_key_filename(key_file, key_inline));
     }
 
-   =
 /* check for and fix highly unlikely key problems */
-    verify_fix_key2(=
&key2, key_type, key_file);
+    /* check for highly unlikely key problems =
*/
+    check_key2(&key2);
 
     /* handle key direction */
     key_direc=
tion_state_init(&kds, key_direction);
@@ -1708,18 +1674,19 @@
 }
 
 void
-v=
erify_fix_key2(struct key2 *key2, const struct key_type *kt, const char *sh=
ared_secret_file)
+check_key2(struct key2 *key2)
 {
-    int i;
+    /* Che=
ck the first 128 bit of every key slot to be not 0=2E This is
+     * not a=
 compressive check, but no valid key should fail this check */
 
-    for (=
i =3D 0; i < key2->n; ++i)
+    uint8_t zero_key[16] =3D { 0 };
+
+    if (=
memcmp(key2->keys[0]=2Ecipher, zero_key, sizeof(zero_key)) =3D=3D 0
+      =
  || memcmp(key2->keys[1]=2Ecipher, zero_key, sizeof(zero_key)) =3D=3D 0
+ =
       || memcmp(key2->keys[0]=2Ehmac, zero_key, sizeof(zero_key)) =3D=3D 0=

+        || memcmp(key2->keys[1]=2Ehmac, zero_key, sizeof(zero_key)) =3D=
=3D 0)
     {
-        /* This should be a very improbable failure */
-    =
    if (!check_key(&key2->keys[i], kt))
-        {
-            msg(M_FATAL=
, "Key #%d in '%s' is bad=2E  Try making a new key with --genkey=2E", i + 1=
,
-                shared_secret_file);
-        }
+        msg(M_FATAL, "O=
ne key in static key/generated key  is all zero=2E");
     }
 }
 
diff --gi=
t a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
index e3c1c6a=2E=2Edbe0=
802 100644
--- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -41=
4,8 +414,6 @@
  */
 int write_key_file(const int nkeys, const char *filenam=
e);
 
-bool check_key(const struct key *key, const struct key_type *kt);
-
=
 /**
  * Initialize a key_type structure with=2E
  *
@@ -621,7 +619,7 @@
 
=
 void key_direction_state_init(struct key_direction_state *kds, int key_dir=
ection);
 
-void verify_fix_key2(struct key2 *key2, const struct key_type *=
kt, const char *shared_secret_file);
+void check_key2(struct key2 *key2);
 =

 void must_have_n_keys(const char *filename, const char *option, const str=
uct key2 *key2, int n);
 
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ss=
l=2Ec
index 086a6fc=2E=2Eddee3eb 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src=
/openvpn/ssl=2Ec
@@ -1583,15 +1583,7 @@
     key2_print(&key2, &session->op=
t->key_type, "Master Encrypt", "Master Decrypt");
 
     /* check for weak =
keys */
-    for (int i =3D 0; i < 2; ++i)
-    {
-        if (!check_key(&=
key2=2Ekeys[i], &session->opt->key_type))
-        {
-            msg(D_TLS=
_ERRORS, "TLS Error: Bad dynamic key generated");
-            goto exit;
-=
        }
-    }
-
+    check_key2(&key2);
     ret =3D init_key_contexts(k=
s, multi, &session->opt->key_type, server, &key2,
                         =
    session->opt->dco_enabled);
 

-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2080?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
Gerrit-Change-=
Number: 2080
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>

--GP//0LjT2Vs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Arne Schwa=
be <strong>uploaded patch set #2</strong> to this change=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Rev=
iew-1 by Frank Lichtenheld</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Clean up weak key check<br><br>=
These methods only check for zero keys after weak DES checks were removed=
=2E<br>Simplify all this to always the first 32 bytes of key and hmac and e=
nsure<br>that they are not zero=2E<br><br>This now always raises a FATAL al=
ert instead of handling this error<br>gracefully but a all zeros keys shoul=
d never ever happen=2E<br><br>Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0=
f4bb2eb<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br=
>M src/openvpn/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/ssl=
=2Ec<br>3 files changed, 14 insertions(+), 57 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/80/2080/2</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=
=2Ec</span><br><span>index 3d3ab0c=2E=2E386b164 100644</span><br><span>--- =
a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span=
><br><span>@@ -1104,40 +1104,6 @@</span><br><span>     ctx-&gt;initialized =
=3D false;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-key_is_zero(const struct key *key, const struct key_type *k=
t)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    size_t cipher_length =3D cipher_kt_=
key_size(kt-&gt;cipher);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    for (size_t i =3D 0; i &lt; cipher_length; ++i)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (key-&gt;cipher[i])</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            return false;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_=
CRYPT_ERRORS, &quot;CRYPTO INFO: WARNING: zero key detected&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Make sure that c=
ipher key is a valid key for current key_type=2E</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_ke=
y(const struct key *key, const struct key_type *kt)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (cipher_defined(kt-&gt;cipher))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-         * Check for zero key</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (key_is_zero(key, kt))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            return false;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Generate=
 a random key=2E</span><br><span>  */</span><br><span>@@ -1307,8 +1273,8 @@=
</span><br><span>             print_key_filename(key_file, key_inline));</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    /* check for and fix highly unlikely key problems */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    verify_fix_key2(&am=
p;key2, key_type, key_file);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* check for highly unlikely key problems */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    check_key2(&amp;key2);</span><br>=
<span> </span><br><span>     /* handle key direction */</span><br><span>   =
  key_direction_state_init(&amp;kds, key_direction);</span><br><span>@@ -17=
08,18 +1674,19 @@</span><br><span> }</span><br><span> </span><br><span> voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-verify_fix_key2(stru=
ct key2 *key2, const struct key_type *kt, const char *shared_secret_file)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_key2(struct key=
2 *key2)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* Check the first 128 bit of every key slot to be not 0=2E This is</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * not a compressive c=
heck, but no valid key should fail this check */</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; key2-=
&gt;n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint=
8_t zero_key[16] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mem=
cmp(key2-&gt;keys[0]=2Ecipher, zero_key, sizeof(zero_key)) =3D=3D 0</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        || memcmp(key2-&gt;=
keys[1]=2Ecipher, zero_key, sizeof(zero_key)) =3D=3D 0</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        || memcmp(key2-&gt;keys[0]=2Ehma=
c, zero_key, sizeof(zero_key)) =3D=3D 0</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        || memcmp(key2-&gt;keys[1]=2Ehmac, zero_key, si=
zeof(zero_key)) =3D=3D 0)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        /* This should be a very improbable fail=
ure */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!ch=
eck_key(&amp;key2-&gt;keys[i], kt))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            msg(M_FATAL, &quot;Key #%d in &#39;%s&#39; is bad=2E  Try mak=
ing a new key with --genkey=2E&quot;, i + 1,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                shared_secret_file);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;One key in static ke=
y/generated key  is all zero=2E&quot;);</span><br><span>     }</span><br><s=
pan> }</span><br><span> </span><br><span>diff --git a/src/openvpn/crypto=2E=
h b/src/openvpn/crypto=2Eh</span><br><span>index e3c1c6a=2E=2Edbe0802 10064=
4</span><br><span>--- a/src/openvpn/crypto=2Eh</span><br><span>+++ b/src/op=
envpn/crypto=2Eh</span><br><span>@@ -414,8 +414,6 @@</span><br><span>  */</=
span><br><span> int write_key_file(const int nkeys, const char *filename);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool=
 check_key(const struct key *key, const struct key_type *kt);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><sp=
an>  * Initialize a key_type structure with=2E</span><br><span>  *</span><b=
r><span>@@ -621,7 +619,7 @@</span><br><span> </span><br><span> void key_dir=
ection_state_init(struct key_direction_state *kds, int key_direction);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void ver=
ify_fix_key2(struct key2 *key2, const struct key_type *kt, const char *shar=
ed_secret_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d check_key2(struct key2 *key2);</span><br><span> </span><br><span> void mu=
st_have_n_keys(const char *filename, const char *option, const struct key2 =
*key2, int n);</span><br><span> </span><br><span>diff --git a/src/openvpn/s=
sl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 086a6fc=2E=2Eddee3eb 100=
644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/ope=
nvpn/ssl=2Ec</span><br><span>@@ -1583,15 +1583,7 @@</span><br><span>     ke=
y2_print(&amp;key2, &amp;session-&gt;opt-&gt;key_type, &quot;Master Encrypt=
&quot;, &quot;Master Decrypt&quot;);</span><br><span> </span><br><span>    =
 /* check for weak keys */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    for (int i =3D 0; i &lt; 2; ++i)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (!check_key(&amp;key2=2Ekeys[i], &amp;session-&gt;opt-&gt;ke=
y_type))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_TLS_ERR=
ORS, &quot;TLS Error: Bad dynamic key generated&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            goto exit;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_ke=
y2(&amp;key2);</span><br><span>     ret =3D init_key_contexts(ks, multi, &a=
mp;session-&gt;opt-&gt;key_type, server, &amp;key2,</span><br><span>       =
                      session-&gt;opt-&gt;dco_enabled);</span><br></pre><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?u=
sp=3Demail">change 2080</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2080?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchse=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2080 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>

</body></html>
--GP//0LjT2Vs=--


--===============4694173105729905511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4694173105729905511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4694173105729905511==--

