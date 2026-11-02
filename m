Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D959C606A329
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZQWXXm0R;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VHQAReJp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hnP7wPTN;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DNHFfXIX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iYy2YP427xpTfPHc6MZ1sKnc5PJR6sXu1C4VOLHrkFE=; b=ZQWXXm0RUe8D0UiBoWmDzBC/kd
	CUfXagHRtI6tVsQKfy4tz6SEC8ziVsfcdbMqjB64z1NN0nXJk3bmWe2D/dtAd4eaYhYaPEfo7i8Cb
	4S++OPFxA24NGyfppoud6nujcP3rEYOkQfy3dqEwviInZu4Giy4u7G9OUgmgHMf0FxSI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNs1c-0000000044J-3SWP;
	Mon, 02 Nov 2026 13:24:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNs1b-00000000449-1vpm
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:24:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dSQOgHpcBZ5DBSRv+5TYpANwjz5hBLbyW8Qm0tuRX+k=; b=VHQAReJpyzDC4cCk4Y2qeKR8ZL
 Z/1hRtsRZlxnuUnwswepTkPPrir3sU6qw14yT/AGQ0MQCMmaDmfs2dk/EurdpiTtHxYp2//Es79gO
 aRvUzBFDee4/Q+XAh2QSaaPnZlsXb29sQczuMVTGpU0enITRHwVNDtsvaxvLAqtu8ync=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dSQOgHpcBZ5DBSRv+5TYpANwjz5hBLbyW8Qm0tuRX+k=; b=hnP7wPTNaFSfeyklALnJ2jnHOp
 RMC5pYLi+hpXY81dw3RwXvpiQN3uWeYC27tLwxgYqa4emOgie0AIFPdydLRNL69BV45bTVVhCec5L
 T3g+8ZeI0mpOwHpDxC88nES3pymFbdpJKzFxtE/SBcX7Ik/3/4AsZYK4SNAqT6VKUmiY=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNs1U-000000008Fy-0ies for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:24:29 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so13166105e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 05:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793625861; x=1794230661; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dSQOgHpcBZ5DBSRv+5TYpANwjz5hBLbyW8Qm0tuRX+k=;
 b=DNHFfXIXkkaOBFTy2hqIFq0lqtQikT6WhKeJFJJM6yA9BAN2MLdFDHATi6duFmlvSQ
 Ea40ztIvJ1bFLabDLJpFu6bsUIxKfJaWZz4/X9ppKJunYO6U9KkClqjLVs+rZ1x8dRnH
 olZpc4YiPry4ofEKszDDN4U2giZAsEUyb53yizyIex+RINLYxudrvxgx8+kv+UAC9/KQ
 wdctPQSJb2qJQPdZP+nfWo69HubicdQVTthGYJVeEBPizNHElYruno+bAViBmEYJe+KN
 ChlzEbJS28f8okEawdakNoUviE5oHzaIqD9MYJ0nfhtynnMFRGSnES6+10iaE9mifVEK
 t8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793625861; x=1794230661;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dSQOgHpcBZ5DBSRv+5TYpANwjz5hBLbyW8Qm0tuRX+k=;
 b=Daj9MYnt1m/mUkD7Mlb+agUO7ofhaNpbZFOZW5esU84x6hFI7x684SAGKR4nV8mqmV
 WyjhyUcvjatmC2TBE0NhgViGpZfcjHbDIsZ0Ynb1QI0+WE21t4gtRXnlVV3l6/A1aJlI
 sjtoNbb6GxMJkx+wKOZmVhuDoSIH87/+4Irr/PorN2p0u0ifgRH7IgIJN7B9Z1UImQr7
 5jgIeVt+VSH41a9lu5letrIbDr8hF+2XFg4bW+6Dl9uGuk9mS4gxQ8/IlpunINTRTjnQ
 qLnnaLqmiRUbwcPgmytsPAzIc1msPSUdN61nkCJecKYSZryZ0lT45ZpfCQ62SqmDPOuH
 mD6Q==
X-Gm-Message-State: AFq9FYLg9XUBo7VuTbRrRaZfMyGz/nyVr8EuOUmmZ9xjgO9kscy7GewY
 HYaumDzt/bDTYpwI9xvOsT0egGnz5IlaYbL0ATYuHQeia5lBvf1H7pIeRpBEJY1qCdJwYGMcrJR
 l7Nvb2y1mnDbp//yCM49FLnoKslTUd1rBjyT/o0HIdLhhnxhoH31KZeDBr767CLZ/EIPQKV4xph
 kcP8NfkA==
X-Gm-Gg: AYBFou0gY2yCCc6d0tZRm3FqI0V7/gGro1zF3l9Sz7kJjVRP67d0Fwsrj++vmqu8Mv2
 4DK1nNihxOGDDNIkpNT/E6TZiTUu0Az62D5vOFCUUIPU+WSTdHPYhkypeqYZU1FFwHFhU2H/dru
 0meCf/IthPCO6DvDg/IGK0ZLaOCcLmesJzSNR+RodYBOQyETQCxQ7+QxejMD2Jj/fmdGbXW5W5v
 UJNiyWCAHKnmnF6S+N2c8px7FRq29Im5Ik0q3tda8m4MrEJa4XkitHLIPZxJvEWy9n5b15NS+k4
 b9aU/mq8cP34TeMk/aFND3SNQmbcep4dv9MkWKvH5dDtYCEVBONj1zLrWyqJk2Ux+jLH9QiqNEu
 OKAstB/ve+rr89CHKtGJulW/lqvooyc79G51COi+xiJPiJjwINEVadNmBOMB/HDHtMKN0p/9BRi
 bpS446bH2ruRu3ONF4CaQckr08Sohrh5jGN9pDQwSKzH8dc9P683QdZtGnhl7HgkEGG9scKm/Ua
 +iELbnSfoQVcb/as89G12hCfVeF35AMpy2BmePyLaLhBvv9hqC/DCS4viJxHneRRDVZik3GCdmv
 Ufh+NOWHu5VF33wM3v+2fAqhVZqKdCSmuP0FZjddb03mExdb4166vijRx21bSVKufnMpADMI3E/
 5wGk4BOuQgZ7qwUrgrjazrCMj7DOLZlOf++cMJs+5O8g2sTXvjtkXaRDbRtU9ANVYX4/MDU8CQ1
 pvbua/cQFYJwlLkc1OSGNJ42jnXBoMCJqdpuA=
X-Received: by 2002:a05:600c:6214:b0:4a2:9cda:57cb with SMTP id
 5b1f17b1804b1-4ac151a9077mr245858765e9.1.1793625861247; 
 Mon, 02 Nov 2026 05:24:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea72254csm147895565e9.1.2026.11.02.05.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:24:20 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 13:24:19 +0000
To: Steffan Karger <steffan@karger.me>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
X-Gerrit-Change-Number: 2080
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2080?usp=email>
X-Gerrit-Commit: e2794cef559a966b0ea1407060e7c5f051da3351
In-Reply-To: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
References: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljNWNmNWVmNzIzYTMzYWQzMDRiMDgwZWYxOWRiMmU0YTBmNGJiMmViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cd4c7c1d10a3e700f7b8ec9958409cd465a4a7de-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNs1U-000000008Fy-0ies
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
 frank@lichtenheld.com, steffan@karger.me
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0718493034111350455=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0718493034111350455==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HH6I1xCy6zw="; charset=UTF-8

--HH6I1xCy6zw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, Steffan Karger=2E
=

Hello Frank Lichtenheld, Steffan Karger, 

I'd like you to reexamine a cha=
nge=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?us=
p=3Demail

to look at the new patch set (#3)=2E

The following approvals go=
t outdated and were removed:
Code-Review-1 by Steffan Karger


Change subje=
ct: Clean up weak key check
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Clean up weak key check

These methods only check for zero=
 keys after weak DES checks were removed=2E
Simplify all this to always the=
 first 32 bytes of key and hmac and ensure
that they are not zero=2E

This =
now always raises a FATAL alert instead of handling this error
gracefully b=
ut a all zeros keys should never ever happen=2E

Change-Id: Ic5cf5ef723a33a=
d304b080ef19db2e4a0f4bb2eb
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>=

---
M src/openvpn/crypto=2Ec
M src/openvpn/crypto=2Eh
M src/openvpn/ssl=2E=
c
3 files changed, 14 insertions(+), 57 deletions(-)


  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/80/2080/3

diff --git a/src/=
openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index 3d3ab0c=2E=2Eff17b22 1006=
44
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1104,40 +1=
104,6 @@
     ctx->initialized =3D false;
 }
 
-static bool
-key_is_zero(co=
nst struct key *key, const struct key_type *kt)
-{
-    size_t cipher_lengt=
h =3D cipher_kt_key_size(kt->cipher);
-    for (size_t i =3D 0; i < cipher_=
length; ++i)
-    {
-        if (key->cipher[i])
-        {
-            re=
turn false;
-        }
-    }
-    msg(D_CRYPT_ERRORS, "CRYPTO INFO: WARNIN=
G: zero key detected");
-    return true;
-}
-
-/*
- * Make sure that ciphe=
r key is a valid key for current key_type=2E
- */
-bool
-check_key(const st=
ruct key *key, const struct key_type *kt)
-{
-    if (cipher_defined(kt->ci=
pher))
-    {
-        /*
-         * Check for zero key
-         */
-    =
    if (key_is_zero(key, kt))
-        {
-            return false;
-      =
  }
-    }
-    return true;
-}
-
 /*
  * Generate a random key=2E
  */
@@ =
-1307,8 +1273,8 @@
             print_key_filename(key_file, key_inline));
=
     }
 
-    /* check for and fix highly unlikely key problems */
-    ver=
ify_fix_key2(&key2, key_type, key_file);
+    /* check for highly unlikely =
key problems */
+    check_key2(&key2);
 
     /* handle key direction */
 =
    key_direction_state_init(&kds, key_direction);
@@ -1708,18 +1674,19 @@
=
 }
 
 void
-verify_fix_key2(struct key2 *key2, const struct key_type *kt, c=
onst char *shared_secret_file)
+check_key2(struct key2 *key2)
 {
-    int i=
;
+    /* Check the first 128 bit of every key slot to be not 0=2E This is
=
+     * not a comprehensive check, but no valid key should fail this check =
*/
 
-    for (i =3D 0; i < key2->n; ++i)
+    uint8_t zero_key[16] =3D { 0=
 };
+
+    if (memcmp_constant_time(key2->keys[0]=2Ecipher, zero_key, sizeo=
f(zero_key)) =3D=3D 0
+        || memcmp_constant_time(key2->keys[1]=2Eciph=
er, zero_key, sizeof(zero_key)) =3D=3D 0
+        || memcmp_constant_time(k=
ey2->keys[0]=2Ehmac, zero_key, sizeof(zero_key)) =3D=3D 0
+        || memcm=
p_constant_time(key2->keys[1]=2Ehmac, zero_key, sizeof(zero_key)) =3D=3D 0)=

     {
-        /* This should be a very improbable failure */
-        if=
 (!check_key(&key2->keys[i], kt))
-        {
-            msg(M_FATAL, "Key=
 #%d in '%s' is bad=2E  Try making a new key with --genkey=2E", i + 1,
-   =
             shared_secret_file);
-        }
+        msg(M_FATAL, "One key=
 in static key/generated key  is all zero=2E");
     }
 }
 
diff --git a/sr=
c/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
index e3c1c6a=2E=2Edbe0802 10=
0644
--- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -414,8 +4=
14,6 @@
  */
 int write_key_file(const int nkeys, const char *filename);
 
=
-bool check_key(const struct key *key, const struct key_type *kt);
-
 /**
 =
 * Initialize a key_type structure with=2E
  *
@@ -621,7 +619,7 @@
 
 void =
key_direction_state_init(struct key_direction_state *kds, int key_direction=
);
 
-void verify_fix_key2(struct key2 *key2, const struct key_type *kt, co=
nst char *shared_secret_file);
+void check_key2(struct key2 *key2);
 
 void=
 must_have_n_keys(const char *filename, const char *option, const struct ke=
y2 *key2, int n);
 
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
=
index 086a6fc=2E=2Eddee3eb 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openv=
pn/ssl=2Ec
@@ -1583,15 +1583,7 @@
     key2_print(&key2, &session->opt->key=
_type, "Master Encrypt", "Master Decrypt");
 
     /* check for weak keys *=
/
-    for (int i =3D 0; i < 2; ++i)
-    {
-        if (!check_key(&key2=
=2Ekeys[i], &session->opt->key_type))
-        {
-            msg(D_TLS_ERR=
ORS, "TLS Error: Bad dynamic key generated");
-            goto exit;
-    =
    }
-    }
-
+    check_key2(&key2);
     ret =3D init_key_contexts(ks, m=
ulti, &session->opt->key_type, server, &key2,
                             =
session->opt->dco_enabled);
 

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2080?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
Gerrit-Change-Num=
ber: 2080
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Steffan Karger =
<steffan@karger=2Eme>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>

--HH6I1xCy6zw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Steffan Karger=2E </p>
<p>Arne Sch=
wabe <strong>uploaded patch set #3</strong> to this change=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Rev=
iew-1 by Steffan Karger</p><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Clean up weak key check<br><br>The=
se methods only check for zero keys after weak DES checks were removed=2E<b=
r>Simplify all this to always the first 32 bytes of key and hmac and ensure=
<br>that they are not zero=2E<br><br>This now always raises a FATAL alert i=
nstead of handling this error<br>gracefully but a all zeros keys should nev=
er ever happen=2E<br><br>Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2=
eb<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M sr=
c/openvpn/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/ssl=2Ec<b=
r>3 files changed, 14 insertions(+), 57 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/80/20=
80/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</=
span><br><span>index 3d3ab0c=2E=2Eff17b22 100644</span><br><span>--- a/src/=
openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><=
span>@@ -1104,40 +1104,6 @@</span><br><span>     ctx-&gt;initialized =3D fa=
lse;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-key_is_zero(const struct key *key, const struct key_type *kt)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    size_t cipher_length =3D cipher_kt_key_=
size(kt-&gt;cipher);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   for (size_t i =3D 0; i &lt; cipher_length; ++i)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (key-&gt;cipher[i])</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            return false;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_CRYP=
T_ERRORS, &quot;CRYPTO INFO: WARNING: zero key detected&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Make sure that ciphe=
r key is a valid key for current key_type=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_key(co=
nst struct key *key, const struct key_type *kt)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (cipher_defined(kt-&gt;cipher))</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
     * Check for zero key</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (key_is_zero(key, kt))</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Generate a ran=
dom key=2E</span><br><span>  */</span><br><span>@@ -1307,8 +1273,8 @@</span=
><br><span>             print_key_filename(key_file, key_inline));</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* check for and fix highly unlikely key problems */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    verify_fix_key2(&amp;key2=
, key_type, key_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* check for highly unlikely key problems */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    check_key2(&amp;key2);</span><br><spa=
n> </span><br><span>     /* handle key direction */</span><br><span>     ke=
y_direction_state_init(&amp;kds, key_direction);</span><br><span>@@ -1708,1=
8 +1674,19 @@</span><br><span> }</span><br><span> </span><br><span> void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-verify_fix_key2(struct k=
ey2 *key2, const struct key_type *kt, const char *shared_secret_file)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+check_key2(struct key2 *k=
ey2)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Check the first 128 bit of every key slot to be not 0=2E This is</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * not a comprehensive che=
ck, but no valid key should fail this check */</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; key2-&g=
t;n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_=
t zero_key[16] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (memcm=
p_constant_time(key2-&gt;keys[0]=2Ecipher, zero_key, sizeof(zero_key)) =3D=
=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || mem=
cmp_constant_time(key2-&gt;keys[1]=2Ecipher, zero_key, sizeof(zero_key)) =
=3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || =
memcmp_constant_time(key2-&gt;keys[0]=2Ehmac, zero_key, sizeof(zero_key)) =
=3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || =
memcmp_constant_time(key2-&gt;keys[1]=2Ehmac, zero_key, sizeof(zero_key)) =
=3D=3D 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* This should be a very improbable failure */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (!check_key(&amp;key=
2-&gt;keys[i], kt))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ms=
g(M_FATAL, &quot;Key #%d in &#39;%s&#39; is bad=2E  Try making a new key wi=
th --genkey=2E&quot;, i + 1,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                shared_secret_file);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(M_FATAL, &quot;One key in static key/generated key =
 is all zero=2E&quot;);</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span>diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/=
crypto=2Eh</span><br><span>index e3c1c6a=2E=2Edbe0802 100644</span><br><spa=
n>--- a/src/openvpn/crypto=2Eh</span><br><span>+++ b/src/openvpn/crypto=2Eh=
</span><br><span>@@ -414,8 +414,6 @@</span><br><span>  */</span><br><span> =
int write_key_file(const int nkeys, const char *filename);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool check_key(const=
 struct key *key, const struct key_type *kt);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * Initializ=
e a key_type structure with=2E</span><br><span>  *</span><br><span>@@ -621,=
7 +619,7 @@</span><br><span> </span><br><span> void key_direction_state_ini=
t(struct key_direction_state *kds, int key_direction);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-void verify_fix_key2(str=
uct key2 *key2, const struct key_type *kt, const char *shared_secret_file);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void check_key2(str=
uct key2 *key2);</span><br><span> </span><br><span> void must_have_n_keys(c=
onst char *filename, const char *option, const struct key2 *key2, int n);</=
span><br><span> </span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/ope=
nvpn/ssl=2Ec</span><br><span>index 086a6fc=2E=2Eddee3eb 100644</span><br><s=
pan>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</sp=
an><br><span>@@ -1583,15 +1583,7 @@</span><br><span>     key2_print(&amp;ke=
y2, &amp;session-&gt;opt-&gt;key_type, &quot;Master Encrypt&quot;, &quot;Ma=
ster Decrypt&quot;);</span><br><span> </span><br><span>     /* check for we=
ak keys */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (in=
t i =3D 0; i &lt; 2; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
!check_key(&amp;key2=2Ekeys[i], &amp;session-&gt;opt-&gt;key_type))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            msg(D_TLS_ERRORS, &quot;TLS E=
rror: Bad dynamic key generated&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            goto exit;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    check_key2(&amp;key2);</=
span><br><span>     ret =3D init_key_contexts(ks, multi, &amp;session-&gt;o=
pt-&gt;key_type, server, &amp;key2,</span><br><span>                       =
      session-&gt;opt-&gt;dco_enabled);</span><br></pre><p>To view, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail">chan=
ge 2080</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

=
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 2080 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@k=
arger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Steffan Karger &lt;steffan@karger=2Eme&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>

</body></html>
--HH6I1xCy6zw=--


--===============0718493034111350455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0718493034111350455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0718493034111350455==--

