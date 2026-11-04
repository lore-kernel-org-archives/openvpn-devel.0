Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A9D606D822
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=B/ocXKDJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BD8H0pW+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bQc0wilW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=M8YAcZG4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3AAZVb/n6Gz51l5m365fYxLs89P/foH7CKHDsPQmQsg=; b=B/ocXKDJS2feSoHRcUhT2Fbgi6
	0saGOTrkmdyldCeBLq4DZXuLm+j+Rbl4hqZLtt7WO3ubrcHxaT1w6fXWcSDjR97TIz8yFBDfXs0Gm
	x2U1cPK2EPgWHwIc0lfI1Hfw+EYqqDyRsxkpVGh/eMLkIR3E0q/wg7WTgIXFaQbV+kYE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOeIy-000000005qi-3r09;
	Wed, 04 Nov 2026 16:57:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOeIx-000000005qa-1f7U
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:57:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rkqZizSgUp2Q38kn336gTiiXu/GDO3zBLZs6YINmp0c=; b=BD8H0pW+cz7ERouBHnb9JFsPBz
 cpmx6P1AvtjMNci2/q23mcExr/c0qiPTNh87DfmyFjdNKI+nb2iiG6iT/5tcXWtbOFDwnprsgbIrv
 cSdQsGFUwTdQprEzngbRKm5/DNLpmvuL+XUlRgentDw+Grcle3N1V1ebgwvQs5o06TxM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rkqZizSgUp2Q38kn336gTiiXu/GDO3zBLZs6YINmp0c=; b=bQc0wilWhntScS26WlvOaRITod
 hDKVe++hZOEgojwi6hkd2v/T5vKgxyeSXTLiHeczMdogX838YhMYYhxovqeQgwmNRjlMUnT31mIrv
 KWF+AKUQeBV0fPuL0ghUd6y7wXAYGeHIV3JK0PIZj9YodnguyQtdaNDezC4Nj/TYK0w0=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOeIw-000000007NA-1BqT for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:57:43 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso6513805e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793811456; x=1794416256; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rkqZizSgUp2Q38kn336gTiiXu/GDO3zBLZs6YINmp0c=;
 b=M8YAcZG4AIC/QOY1btRmku/yG8FAHgpZ6C9FmVMCRYtUSKKdmAmCmIHGit9SYwMZsK
 cEPJI0j9iMQ0OUXuKVYNxYTgIh14Et90MAe+Fqy3unSQMzh7oUy+LFCRFO1BNJZmo1RD
 SiNfBDi5kPbuKY1VK3oK7gku97R9iUvxdfCAWZQPqz95/yzUQ+Khbz65gHLmf+lhmrnN
 9RM8lwrcoAtZp9ykx+ZDhk68YTRc34T9HIr6OxPmBq3+bgYycx+1TuixwZVBKd1FNl30
 uWXYmsSrioxIPmJrqOJoDtpilgR9cHV5JsX54itf5U1seb6xjkxe1BRDoTATtxQblXfj
 njKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793811456; x=1794416256;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rkqZizSgUp2Q38kn336gTiiXu/GDO3zBLZs6YINmp0c=;
 b=xCRlE0iyW6x9HnhaVxiZD39k15zv0LCZRwRSh1QVpR7RUQDBUCPdfXf1BjojDhz88Z
 O0RllZ3bW19FsGHaczckoiNBaq+tulJrJtROsamJX1HNQy9mWYmuIXmcSD+94Nw5ltyf
 ogelJYt+Ccd7MGJWOs7FWKuyKptevpqKhqXu/wDndHxnUwN4AVzDMXuvqhmpV04iMhI+
 fhRA7sGqWvz9iDpf4XrcLmBpcYa+h4WSB/UeDjvuVtlnHPWO8ww5eGVOwmUqcGZ7pOkz
 oDgmPORM9U/6Vg63TdY3SgaRQqGXbkBjLgOgidemxyo6a0Hamf+P9baEqvEVA9JPxDMp
 UrKw==
X-Gm-Message-State: APuU4Z9ItNjolZ1byrMzXIOeS7+OnB3QBH8PksSKL7yXZ0Yv+2IR1YZG
 nHn/l/7K4nAho1y75Z/riJ8hRd8VuvMbzpTIne7SOou5Q52NhrteyMp8nD4Cjh/QZXL1ipAuNZt
 RMUOOHD2pVh1R0Dv9Wh9uL7ZszYkiT5HNxiWgHnbMu/YeLb/4lzO+GsILmZMLOecWuxo1
X-Gm-Gg: AYBFou3+BWlxsfwF9g0jwf8jCe2L0srqgYMmuAfVLS5DPbJCoxvL1VQrxDZJCvJ5geK
 kfC/uuBeffan/MkjHk2XrzHTn6BZgqEL58gTofIOUoiysE1JYSHk6WSlR1pb4CvZ0geAk7MmuUo
 EQriQSEbDOd6Mp1Oia9+lYXYYll1Elxl7HjMe/MNoJ8c3ATe6wuqcWb1O6vT/8rNf8pX+mM9K12
 rL80dYaNn7YJs9Zg2xJDnhQX3VZzMxra79aq7U8a8cdqVl8yAE+b3GWptKG4FJtsFCi03QhnYa2
 y3fTd33vxNIuwJUwjZ1Io2Iikm2GENFkbYTIgpVsZ4F154JizWb/54oeHAMZtJ5rOi20g13S2EO
 Du9g6u9BcE3KeltxRvE4axMkL6+w8IwbYJU3jt5Ax95U7xLXZJO5BjQg1CcdPSDtGAXsATNTWF2
 +p7mAMcy+Zxnk3e3wKC+eXx7AL/1mA8WjSpBpjbIFTFI12eKKDb9btgSj2cX7kEdMHm/eQfgQFh
 SZxk7FZCG9QnPY4ivuRGuLFKo+lafpjU45QIxjmO4t+aEHuLuRgVuik14lQBJzDiDJ4hxJPfHbn
 6TpKmwkwNEt2KcFdMmsGrBBXsFEDY0aEFhnb1dZupxwuLUPdoavgefOE69CwqBgIRp92xVOAJD4
 04CNze5eyJTgya5tAh1aCJD03vp4ArOW3x8HmuMm781APAe8R3Dh0hDS3EpZWyenXpQ2kpIuz/U
 a0RJ+3zGBFV98DRPs=
X-Received: by 2002:a05:600c:848c:b0:4a5:dc5d:20f7 with SMTP id
 5b1f17b1804b1-4ac175669d8mr416147905e9.14.1793811455488; 
 Wed, 04 Nov 2026 08:57:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43cff3b14sm65060765e9.10.2026.11.04.08.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:57:35 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:57:34 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I23c6480967d4785beada3879667d50d60d7d8df4
X-Gerrit-Change-Number: 2122
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2122?usp=email>
X-Gerrit-Commit: ca879870516150ba6c853a4edb268b5549c11e3a
In-Reply-To: <gerrit.1793779170000.I23c6480967d4785beada3879667d50d60d7d8df4@gerrit.openvpn.net>
References: <gerrit.1793779170000.I23c6480967d4785beada3879667d50d60d7d8df4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc5MTcwMDAwLkkyM2M2NDgwOTY3ZDQ3ODViZWFkYTM4Nzk2NjdkNTBkNjBkN2Q4ZGY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9ff0549499b41ff04c1688d771cb5a9ee5e50f0c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOeIw-000000007NA-1BqT
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7623423071336948999=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7623423071336948999==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Totmvd3CY9E="; charset=UTF-8

--Totmvd3CY9E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2122?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: ssl_mbedtls: remove empty=
 tls_ctx_personalise_random()
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

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/22/2122=
/2

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

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I23c6480967=
d4785beada3879667d50d60d7d8df4
Gerrit-Change-Number: 2122
Gerrit-PatchSet: =
2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering =
<gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>

--Totmvd3CY9E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2122?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ssl=
_mbedtls: remove empty tls_ctx_personalise_random()<br><br>Mbed TLS 4 has n=
o application-owned CTR_DRBG to personalise, so<br>494fb718 (&quot;Add supp=
ort for Mbed TLS 4&quot;) limited the function body to<br>older versions, a=
nd 77a04d48 (&quot;Remove Mbed TLS 3 compatibility&quot;)<br>removed that b=
ody but kept the empty function and its call=2E<br><br>Change-Id: I23c64809=
67d4785beada3879667d50d60d7d8df4<br>Signed-off-by: Razvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede=
&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2122<br>Mess=
age-Id: &lt;20261104105531=2E7096-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: htt=
ps://lore=2Ekernel=2Eorg/openvpn-devel/20261104105531=2E7096-1-gert@greenie=
=2Emuc=2Ede<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<=
br>---<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_backend=2Eh<br>M src/o=
penvpn/ssl_mbedtls=2Ec<br>3 files changed, 0 insertions(+), 24 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/22/2122/2</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/=
openvpn/ssl=2Ec</span><br><span>index 12b6119=2E=2Eb701c0a 100644</span><br=
><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec<=
/span><br><span>@@ -672,11 +672,6 @@</span><br><span>         tls_ctx_load_=
ecdh_params(new_ctx, options-&gt;ecdh_curve);</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENA=
BLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /* Personalise the random by mixing in the certificate */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    tls_ctx_personalise_random(new_ctx=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     tls_clear_er=
ror();</span><br><span>     return new_ctx;</span><br><span> </span><br><sp=
an>diff --git a/src/openvpn/ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh</=
span><br><span>index 2150d81=2E=2Eb4604ea 100644</span><br><span>--- a/src/=
openvpn/ssl_backend=2Eh</span><br><span>+++ b/src/openvpn/ssl_backend=2Eh</=
span><br><span>@@ -327,17 +327,6 @@</span><br><span> void tls_ctx_load_extr=
a_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,</span><br><=
span>                               bool extra_certs_file_inline);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABL=
E_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Add a personalisatio=
n string to the mbed TLS RNG, based on the certificate</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * loaded into the given context=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * @param ctx                   TLS context to =
use</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void tls_ctx_personalise_random(stru=
ct tls_root_ctx *ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* **************=
************************</span><br><span>  *</span><br><span>  * Key-state =
specific functions</span><br><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec=
 b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index 8aaca96=2E=2E45d7715 1=
00644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++=
 b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -767,14 +767,6 @@</span><=
br><span>     msg(my_loglevel, &quot;mbed TLS msg (%s:%d): %s&quot;, file, =
line, str);</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * Further personalise the RNG using a hash of the public key</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-tls_ctx_personalise_random(struct tls_root_ctx *ctx)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> int</span><br><span> tls_version_max(void)</span><b=
r><span> {</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2122?usp=3Demail">change 2122</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2122?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I23c6480967d4785be=
ada3879667d50d60d7d8df4 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2122 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--Totmvd3CY9E=--


--===============7623423071336948999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7623423071336948999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7623423071336948999==--

