Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B21606D80C
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=afNIWWFg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=B9zxLKEb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EQWYa/e/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ex3DHYOk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TbyecQS64eRoVzPPipZMwatpZEPVqPD5eUVHDtJiWRY=; b=afNIWWFgnPfE6y5WqkZqDUALHV
	fNnCq3pzmXDB4XYd4QTjbpwREEOWWodOrnrbbi5twODIot1kniQDXtx7RWzBHXaNbuCY8PYr6yvIT
	H2ZHc30txFkEeP/3NvD1LyA0m2rTGrr5zT2JUC+z2Pr3bLQI/2iBhbIpcDQGnke5ZxHE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOeJ0-000000004qW-1FzB;
	Wed, 04 Nov 2026 16:57:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOeIx-000000004qP-3v00
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:57:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CvpAI7PFko4rPd7UnjusXTFeU5GQ/s+WQ3nRyh2UFHQ=; b=B9zxLKEbTIDQ88buIVqET2dz0w
 56zmY2tA5ge75oxdZwi8MZIxos1h9fhbEpFO1xl3mpAcq9wMuOHaJifMBOqg1yzHWA1n8A31MrVa7
 nWRIc5BRgLRwtZdQ8EB9yVPC5WI4EKMJpVP6pD5WiU+LkSrgH9pVmmAlLKgGoqNM7M14=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CvpAI7PFko4rPd7UnjusXTFeU5GQ/s+WQ3nRyh2UFHQ=; b=EQWYa/e/ayD5cTruRkfde2tuAw
 Z5pp8R0FRnvMjFGJzgpDmvVd5oVpah9ULDbvFHZhn1xC2q+ewwe0tj329Nr+7F0F1VMZV0IugFSGf
 90DSokEDHZ78Q5lyTfj3yOHtyJKLB+1S56BxcdbOxxKW0QI/d4hd+Bp4bnBn1dhYPM4Q=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOeIx-000000001Rq-092Y for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:57:43 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so769236f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793811456; x=1794416256; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CvpAI7PFko4rPd7UnjusXTFeU5GQ/s+WQ3nRyh2UFHQ=;
 b=Ex3DHYOkFBNqREZEZJSw0vTnjicoWH+wpKeGVujxvjrzn4jrPC/IFaCtT6zIhhPaco
 GDU2eLTylAqoBUwVC/BshISSvavQ377Zh6tQH4DgIacWdf2F2I9tENtlWoXZ9LuuYes3
 087isn+vG86FSycZm2ISkOu7JIDssQdGf6Pum6TMd9972iyRqPumKW8xi7e/+uzFoJ1v
 44w8JUFnsLId23eB5lgIyEwLB66WWRCIeTq/FrFXfEiCWQcg/QN7lLfaSuk8xfonoJ59
 XBSYx4m9PGyL0lFQdzn8TRlHXx040R5m9QFFHnlDRS1MncgP/cLYt4s5SD6tlRwcHXiL
 z6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793811456; x=1794416256;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CvpAI7PFko4rPd7UnjusXTFeU5GQ/s+WQ3nRyh2UFHQ=;
 b=n8MwufwT6xn+9QTIKqt3XRMk+aDCw6wK2GWQNTBzACq+J7BylNvICqEu6rlIw7cvBN
 LLgGRPDwJLUN74tIdDorfRA9DgcIpaInljwfiMEVPZnXeUA1l0lsUWIl+TZ4VW5zswu5
 9botlygG2Kpvniijxo/J5uJcYBs2tNeuCPydWbFJG5hstAUFYvcaYqaPYvunphAfMDLl
 UG67Z1bQArlmQRr0WPSGoo/wDp5yUxngEAN1jg7+620LgL9s10n5rO1Ljka7ktkoc0iR
 cbeiWbI+0lW/ucqBmMdDUdZfZJWOQ/ktvyc/dJbSwHOv2tiVWQ77QkF0rIi1BarYAzeX
 XLZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwV6nxKTNSMo1RJ1yM05jLtzAFspSuiFR7CiXhKi8hhrv/vux8d+9JX5rmFz5q1dqX3bXjOv4Lltc8gurEu@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/EV9t5i18+hJgbG+RsCRBesjYg++Yfa8LQBpJT8GCKJg4vWzPn
 QqIQ8SerHC4FB+WfVuX0+3S4TCV9bC/rCNFLtHJh72oWapuTPTGk/AMUq8x4uRTes/WAt1mArfK
 PHOY8JdO0HB7+IYaT9uDhri/UYWpQww0UzrHNX1j2tIQi9+qh7pT/byaNTT4tJkfNzFvr
X-Gm-Gg: AYBFou2dOq9cuZcEWGZXM41HTp0g/nweAte9RzuqigLR66GxmVMa7dv2wGipmDcK+IH
 yET/feCN1rJs2bIlobv01gG2MT5x11lqiUyjunhU6nGrY2L2nXhjQpxSeNCOHnghFq6qE0s6fu8
 fmE7eHaNWW0nTdOA/8GmuEtrHvIUYgqTB/gIE8kbVteTU6O+c6YStFxlCha6QYlF89oU1i101/i
 GJwPyltO66bsHPtkrEFkrD/6uar4EhhIEFT+G1EJ9+5lVEZ8KIq9Ur2cLT/hSU31ewnwNMjycpK
 ai5xXEmsRw1UAdyXN2IL0BBQIMmoz8G/HOsTGtkrWi6+6V4gZkpNnMetimJwpelNwhRvAz2ferX
 QaPEOw0lHQRYaLYAwG/E8FqgRf/Z9nCqMoWIc45UA2E6rgdJrugJtOpfliV6/2CkT/PElKNNjR6
 go5vVzmMDvWn/TnJIFdl7Hmp77D+HcEoAy1LgnesYIGZiWmx2BzZwa0BObbgNXu6gNsomHuzFEI
 Kl75GQkoyFBNxCZ1/RF11dWrdPFh59ZJJJZyZ5AlioRtyzxLmzzVO7Rf2JGv5pK/ZeBBHZlzy95
 ikPyGeA8Qa6UsXXLz12kFq5PtaCPSaWos5Yd7sKhDbpYibFsR9f+y7WThoaGzDOnEeM6n9RSGLR
 TOi3f/y7LZQjHlyoAgwFbTDqXtvPzYhIhvL4WNEWS9YyERG30ozjqQfVaHDVz4aS3BH9oEf5PKS
 /iCTpati44lkw0lg==
X-Received: by 2002:a5d:5d06:0:b0:487:88b:4681 with SMTP id
 ffacd0b85a97d-48e6e303c2dmr38771415f8f.10.1793811456244; 
 Wed, 04 Nov 2026 08:57:36 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fecac2772sm4669651f8f.18.2026.11.04.08.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:57:35 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:57:35 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I23c6480967d4785beada3879667d50d60d7d8df4
X-Gerrit-Change-Number: 2122
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2122?usp=email>
X-Gerrit-Commit: ca879870516150ba6c853a4edb268b5549c11e3a
In-Reply-To: <gerrit.1793779170000.I23c6480967d4785beada3879667d50d60d7d8df4@gerrit.openvpn.net>
References: <gerrit.1793779170000.I23c6480967d4785beada3879667d50d60d7d8df4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc5MTcwMDAwLkkyM2M2NDgwOTY3ZDQ3ODViZWFkYTM4Nzk2NjdkNTBkNjBkN2Q4ZGY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9ff0549499b41ff04c1688d771cb5a9ee5e50f0c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOeIx-000000001Rq-092Y
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_mbedtls: remove
 empty tls_ctx_personalise_random()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2098598534018911824=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2098598534018911824==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AeCDgtagO5k="; charset=UTF-8

--AeCDgtagO5k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2122?usp=3Demail )

Change subject: ssl_mbedtls: remove empty t=
ls_ctx_personalise_random()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

ssl_mbedtls: remove empty tls_ctx_personalise_random()

Mb=
ed TLS 4 has no application-owned CTR_DRBG to personalise, so
494fb718 ("Ad=
d support for Mbed TLS 4") limited the function body to
older versions, and=
 77a04d48 ("Remove Mbed TLS 3 compatibility")
removed that body but kept th=
e empty function and its call=2E

Change-Id: I23c6480967d4785beada3879667d5=
0d60d7d8df4
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by=
: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2122
Message-Id: <20261104105531=2E7096-1-gert@greenie=
=2Emuc=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261104105531=
=2E7096-1-gert@greenie=2Emuc=2Ede
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_backend=2Eh
M src/=
openvpn/ssl_mbedtls=2Ec
3 files changed, 0 insertions(+), 24 deletions(-)

=



diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 12b6119=2E=
=2Eb701c0a 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -6=
72,11 +672,6 @@
         tls_ctx_load_ecdh_params(new_ctx, options->ecdh_cu=
rve);
     }
 
-#ifdef ENABLE_CRYPTO_MBEDTLS
-    /* Personalise the random=
 by mixing in the certificate */
-    tls_ctx_personalise_random(new_ctx);
=
-#endif
-
     tls_clear_error();
     return new_ctx;
 
diff --git a/src/o=
penvpn/ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh
index 2150d81=2E=2Eb46=
04ea 100644
--- a/src/openvpn/ssl_backend=2Eh
+++ b/src/openvpn/ssl_backend=
=2Eh
@@ -327,17 +327,6 @@
 void tls_ctx_load_extra_certs(struct tls_root_ct=
x *ctx, const char *extra_certs_file,
                               bool e=
xtra_certs_file_inline);
 
-#ifdef ENABLE_CRYPTO_MBEDTLS
-/**
- * Add a per=
sonalisation string to the mbed TLS RNG, based on the certificate
- * loade=
d into the given context=2E
- *
- * @param ctx                   TLS contex=
t to use
- */
-void tls_ctx_personalise_random(struct tls_root_ctx *ctx);
-=

-#endif
-
 /* **************************************
  *
  * Key-state spe=
cific functions
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_=
mbedtls=2Ec
index 8aaca96=2E=2E45d7715 100644
--- a/src/openvpn/ssl_mbedtls=
=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -767,14 +767,6 @@
     msg(my_log=
level, "mbed TLS msg (%s:%d): %s", file, line, str);
 }
 
-/*
- * Further p=
ersonalise the RNG using a hash of the public key
- */
-void
-tls_ctx_perso=
nalise_random(struct tls_root_ctx *ctx)
-{
-}
-
 int
 tls_version_max(void)=

 {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2122?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I23c6480967d4785=
beada3879667d50d60d7d8df4
Gerrit-Change-Number: 2122
Gerrit-PatchSet: 2
Ger=
rit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert=
@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>

--AeCDgtagO5k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2122?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl_mbedtls: remove empty tls_ctx_=
personalise_random()<br><br>Mbed TLS 4 has no application-owned CTR_DRBG to=
 personalise, so<br>494fb718 (&quot;Add support for Mbed TLS 4&quot;) limit=
ed the function body to<br>older versions, and 77a04d48 (&quot;Remove Mbed =
TLS 3 compatibility&quot;)<br>removed that body but kept the empty function=
 and its call=2E<br><br>Change-Id: I23c6480967d4785beada3879667d50d60d7d8df=
4<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-=
by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2122<br>Message-Id: &lt;20261104105531=2E70=
96-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvp=
n-devel/20261104105531=2E7096-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl=2Ec=
<br>M src/openvpn/ssl_backend=2Eh<br>M src/openvpn/ssl_mbedtls=2Ec<br>3 fil=
es changed, 0 insertions(+), 24 deletions(-)<br><br></pre>
<pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 12b6119=2E=
=2Eb701c0a 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span=
>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -672,11 +672,6 @@</span><br><=
span>         tls_ctx_load_ecdh_params(new_ctx, options-&gt;ecdh_curve);</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#ifdef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* Personalise the random by mixing in the cert=
ificate */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_ctx=
_personalise_random(new_ctx);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span>     tls_clear_error();</span><br><span>     return new_ctx;</spa=
n><br><span> </span><br><span>diff --git a/src/openvpn/ssl_backend=2Eh b/sr=
c/openvpn/ssl_backend=2Eh</span><br><span>index 2150d81=2E=2Eb4604ea 100644=
</span><br><span>--- a/src/openvpn/ssl_backend=2Eh</span><br><span>+++ b/sr=
c/openvpn/ssl_backend=2Eh</span><br><span>@@ -327,17 +327,6 @@</span><br><s=
pan> void tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *ex=
tra_certs_file,</span><br><span>                               bool extra_c=
erts_file_inline);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#ifdef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * Add a personalisation string to the mbed TLS RNG, based on the certi=
ficate</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * loaded into =
the given context=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param ctx       =
            TLS context to use</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void tls_=
ctx_personalise_random(struct tls_root_ctx *ctx);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> /* **************************************</span><br><span>  *</sp=
an><br><span>  * Key-state specific functions</span><br><span>diff --git a/=
src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>i=
ndex 8aaca96=2E=2E45d7715 100644</span><br><span>--- a/src/openvpn/ssl_mbed=
tls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@=
@ -767,14 +767,6 @@</span><br><span>     msg(my_loglevel, &quot;mbed TLS ms=
g (%s:%d): %s&quot;, file, line, str);</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * Further personalise the RNG using a h=
ash of the public key</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_personalise_random(struct t=
ls_root_ctx *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br><span> tls_=
version_max(void)</span><br><span> {</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2122?usp=3Demail">change =
2122</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2122?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I23c6480967d4785beada3879667d50d60d7d8df4 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2122 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--AeCDgtagO5k=--


--===============2098598534018911824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2098598534018911824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2098598534018911824==--

