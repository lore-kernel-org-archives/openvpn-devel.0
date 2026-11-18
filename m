Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45682606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ddzRK6io;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZG0bajoy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HIEbQxoG;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=S6Ce0Cf+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6nMcLCVjeRllgGiLVXvTW8WAgFxexSaQrdEPyaZetmM=; b=ddzRK6io3h7j2Q0H6N2CrKmi4+
	qIS/4bxM+FyFFBB8iepgvpWSeF88ubYfFHIuA1WafH9NhQfn23ZIfOowAA0zI000+dR0QYt8vvbjK
	4B0UOJXNaH7tnEv8blu6gLxKO1AuouYbz84irysl+x+6asLuOtThyBG8im71EdYKEny0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTgkL-000000007uh-3zDb;
	Wed, 18 Nov 2026 14:34:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTgkK-000000007ua-1UAy
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:34:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vn18zdMg2jc2gkBMd2ONlVhdFnw/GJiLlhYsJSBe9DA=; b=ZG0bajoyRilM1idnxV+ZFVlmCx
 PCLyfFapJpjwhTK6Anq19x+qOE3gFJmyi0QCf6AikdChAAkJlmB1WWpmirgVtjjtnffnGhxdLXTsN
 z3q3r/+k9iPXr7hy1Y29TnsboXxnsoM9KHtqZLvaSCeHZCUICCeT/azrzdD+XH5QNcK8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vn18zdMg2jc2gkBMd2ONlVhdFnw/GJiLlhYsJSBe9DA=; b=HIEbQxoGTOXLHL8RXseThpfyY7
 CvesMSHwQXfhEpa4md8xIND/SwnZMdVTKK9nt+2Z8B24PTFjmKIrX4IkDi7O/ycCTFKwP/+VidhM7
 5pr5QNTrSp/pvVAKNx6ko0pD+twksgMzQ3g66E6djzxp+l8JiYV0owqonhFrQwlhS/sw=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTgkI-000000002wV-3Brj for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:34:48 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so8352795e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 06:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795012480; x=1795617280; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vn18zdMg2jc2gkBMd2ONlVhdFnw/GJiLlhYsJSBe9DA=;
 b=S6Ce0Cf+IXdJraAy6f0gRe+vBjx8P56/OBQE9/SJb3mhcNrvOX6OXTM6X/qvS25zzf
 26Ei0w49eHauEpEmGlfKX5AjB6sS27M12l6Ug/CHlHAOZzPYaSQ6yabPsm4B7R4O/F8C
 TPVYyDIWBHNRdg5M/JZ2bfIFp3OE2rgMhGHrVNOd/dzj4GZHJcfVJ0D1PhAB5jKeRRqm
 eWER0ZVYsiymcTnkf2Mst2rXHyzfchv3q01l7kASo+ueLkyyzzqHjumKeAdRn+J5dXLA
 amfgUF0uz2RHfTifYc0ObpK0w0Ztv6CTFfFVnzOXwcjZdu1T/Q1HtwvhowwSFD7aJcFB
 uSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795012480; x=1795617280;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vn18zdMg2jc2gkBMd2ONlVhdFnw/GJiLlhYsJSBe9DA=;
 b=GBi7QgtQjc+5xAW8QArJEm/Ki80U6kXngJAHPyLarmdRaaywgX7LK8n/fn6/9nUVYY
 /o6BVP971inox3NcjNU1SsUh3s4SsyZ+v6BFMeaOT6JvhDtHqz6qwgVzI4U4jUDdgNRe
 PpKyUB4uONhTVS+d+0OeOTljCyfhgT6Z97V+TQnOrW5wD3QaT27DcdfDUdvIGN4xklu8
 qQDt4n1C+JFlnjiq3l7sxOhzteZO/32L/sxW72MlD5DLPPKJiNngR39ke3jZDqILsADz
 ze/Wm1cvsEZMBOIcTsu1JAfkG8nVvCdaMtB+sXNy7/VkgJ+t/RBcHpjgxjQnzhTJlsWn
 b3+A==
X-Gm-Message-State: APuU4Z/eJNk8G9+uvT00VBQKJ2c9cPa3zQROWndwJRtroOBRp4QcBH4h
 RgSxAjigNI46ygBjY2SkxnlIgjpyS52rrMAskcXiZo22sIcYwPrqcGhyWeAJW52jLk/F4vDPTFU
 3ZuIlpltgsQkZEqmxTDpuZknPuZceb82tKdvGR8d0Lc6J73AJ68+z8wANLyV1RXwyXUs5zxsG4a
 wH9htHxA==
X-Gm-Gg: AYBFou23GcV29RkiDUxUG5qmZFzGtJqwvH8KsATNET0GBXdBo3IMoFyxKTfB4kZ7NsM
 DPf9Hbsq7M+FbSZFrfDrIi/J6bT5TrLK1F2S3f2KIT01w2CC4vuA26LO4TaBtyngUJS2HovZGwy
 2kRvQMf95O4k+cl71bfXvQfvOp28YbyUNj2TE03x/s3i7YxFsUJvPtR19WdsAju/H0QFfGiM147
 XYM8SHaJSDYoNvQNsg+uK8keT0kzZ5pqYiX3PbWLrSYD5FpIa0gpAAv03yBKPKwO2m1vyQRg62D
 gGzsf2ETPYLmSlNgUewwtktrnScJQlRg/ZoelSgZrG86CYhxV4tDVWojev+YQNupfBGVFbM2dRW
 N5i7hgXWYONCXHMFJOXr4ks1xv+Uzbfvduczxci6zcsLENlG4v/2+ci6lDju2RppWLgSiaJRPOp
 H46LpWA7+YxaZYwXwYr8DmZ3i3gGFZVXmE5US2b6AVs0wCs4cdZqlnsALQYClfmb730WHmOz9E4
 gZoSjrGPTkXfZFNmFwaMADW2wCIQie1XAJHjpsShHoYlT8bVAytNHVVZULK40Do1gcw5bznGJ+l
 yxx2tvB8A8K6ecFfc/oUM1OOVi9UnikDWx0dQ2Rfx8t9H16y4fYF0wbPd+jKxFZe/dKaeXbfaZ+
 AVnLkiUpV5CL1JKAH+IAuRqBQVDO2eCi+g0/QhLwKYneTHU00Yk7ZzfctYBeCanzKN0As89nJ6B
 w/fAaj7ZBHKNYsY5A=
X-Received: by 2002:a05:600c:6207:b0:4bb:6a75:d04f with SMTP id
 5b1f17b1804b1-4bb7d9fd1cfmr53533165e9.8.1795012479968; 
 Wed, 18 Nov 2026 06:34:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78430752sm157099855e9.12.2026.11.18.06.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 06:34:39 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 14:34:38 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib645e0bf5c8941f4b1e14f13397794be15eab68f
X-Gerrit-Change-Number: 2189
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2189?usp=email>
X-Gerrit-Commit: f4b0e57369874b634cbf9b402e05e5be2520c77b
In-Reply-To: <gerrit.1794827563000.Ib645e0bf5c8941f4b1e14f13397794be15eab68f@gerrit.openvpn.net>
References: <gerrit.1794827563000.Ib645e0bf5c8941f4b1e14f13397794be15eab68f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODI3NTYzMDAwLkliNjQ1ZTBiZjVjODk0MWY0YjFlMTRmMTMzOTc3OTRiZTE1ZWFiNjhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1ac43c755ba6ded229d2331b37ee56da64068935-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTgkI-000000002wV-3Brj
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: remove obsolete
 preprocessor guards
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
Content-Type: multipart/mixed; boundary="===============0328732771149992994=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0328732771149992994==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EEgM+ZJqPFw="; charset=UTF-8

--EEgM+ZJqPFw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2189?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: ssl: remove obsolete prep=
rocessor guards
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

ssl: remove obsolete preprocessor guards

- MBEDTLS_SSL_CBC_RECORD_SPL=
ITTING and its API were removed in
  mbed TLS 3; the minimum is now 4=2E0=
=2E
- INFO_CALLBACK_SSL_CONST is never defined=2E
- TLS1_3_VERSION is alrea=
dy used unguarded, and the only caller of
  convert_tls13_list_to_openssl()=
 isn't guarded=2E

Change-Id: Ib645e0bf5c8941f4b1e14f13397794be15eab68f
Sig=
ned-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering =
<gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2189
Message-Id: <20261117175605=2E14945-1-gert@greenie=2Emuc=2Ede>
U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg41577=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---=

M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_openssl=2Ec
2 files change=
d, 1 insertion(+), 15 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/89/2189/3

diff --git a/src/openvpn/ssl_mbedtl=
s=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 19a2d48=2E=2Edbc1b9d 100644
--- a=
/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -892,15 +=
892,6 @@
     mbedtls_ssl_conf_renegotiation(ks_ssl->ssl_config, MBEDTLS_SS=
L_RENEGOTIATION_DISABLED);
 #endif /* MBEDTLS_SSL_RENEGOTIATION */
 
-    /=
* Disable record splitting (for now)=2E  OpenVPN assumes records are sent
-=
     * unfragmented, and changing that will require thorough review and
-  =
   * testing=2E  Since OpenVPN is not susceptible to BEAST, we can just
-  =
   * disable record splitting as a quick fix=2E */
-#if defined(MBEDTLS_SSL=
_CBC_RECORD_SPLITTING)
-    mbedtls_ssl_conf_cbc_record_splitting(ks_ssl->s=
sl_config,
-                                          MBEDTLS_SSL_CBC_RECOR=
D_SPLITTING_DISABLED);
-#endif /* MBEDTLS_SSL_CBC_RECORD_SPLITTING */
-
   =
  /* Initialise authentication information */
     (void)mbed_ok(mbedtls_ss=
l_conf_own_cert(ks_ssl->ssl_config, ssl_ctx->crt_chain, ssl_ctx->priv_key))=
;
 
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
=
index b95de8e=2E=2Ee2b65bd 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/s=
rc/openvpn/ssl_openssl=2Ec
@@ -159,11 +159,8 @@
  * Print debugging informa=
tion on SSL/TLS session negotiation=2E
  */
 
-#ifndef INFO_CALLBACK_SSL_CO=
NST
-#define INFO_CALLBACK_SSL_CONST const
-#endif
 static void
-info_callb=
ack(INFO_CALLBACK_SSL_CONST SSL *s, int where, int ret)
+info_callback(cons=
t SSL *s, int where, int ret)
 {
     if (where & SSL_CB_LOOP)
     {
@@ -4=
25,7 +422,6 @@
     }
 }
 
-#ifdef TLS1_3_VERSION
 static void
 convert_tls=
13_list_to_openssl(char *openssl_ciphers, size_t len, const char *ciphers)
=
 {
@@ -449,7 +445,6 @@
         }
     }
 }
-#endif
 
 void
 tls_ctx_restri=
ct_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)

-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2189?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib645e0bf5c8941f4b1e14f13=
397794be15eab68f
Gerrit-Change-Number: 2189
Gerrit-PatchSet: 3
Gerrit-Owner=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>

--EEgM+ZJqPFw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2189?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ssl=
: remove obsolete preprocessor guards<br><br>- MBEDTLS_SSL_CBC_RECORD_SPLIT=
TING and its API were removed in<br>  mbed TLS 3; the minimum is now 4=2E0=
=2E<br>- INFO_CALLBACK_SSL_CONST is never defined=2E<br>- TLS1_3_VERSION is=
 already used unguarded, and the only caller of<br>  convert_tls13_list_to_=
openssl() isn&#39;t guarded=2E<br><br>Change-Id: Ib645e0bf5c8941f4b1e14f133=
97794be15eab68f<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2189<br>Message-Id: &lt;20261=
117175605=2E14945-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41577=2Ehtml<br>Si=
gned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/o=
penvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>2 files changed,=
 1 insertion(+), 15 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/89/2189/3</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br=
><span>index 19a2d48=2E=2Edbc1b9d 100644</span><br><span>--- a/src/openvpn/=
ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br=
><span>@@ -892,15 +892,6 @@</span><br><span>     mbedtls_ssl_conf_renegotia=
tion(ks_ssl-&gt;ssl_config, MBEDTLS_SSL_RENEGOTIATION_DISABLED);</span><br>=
<span> #endif /* MBEDTLS_SSL_RENEGOTIATION */</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* Disable record splitting (=
for now)=2E  OpenVPN assumes records are sent</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-     * unfragmented, and changing that will require=
 thorough review and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
    * testing=2E  Since OpenVPN is not susceptible to BEAST, we can just</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     * disable record sp=
litting as a quick fix=2E */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(MBEDTLS_SSL_CBC_RECORD_SPLITTING)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ssl_conf_cbc_record_splitting(k=
s_ssl-&gt;ssl_config,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                          MBEDTLS_SSL_CBC_RECORD_SPLITTING_=
DISABLED);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* M=
BEDTLS_SSL_CBC_RECORD_SPLITTING */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span>     /* Initialise authentication information=
 */</span><br><span>     (void)mbed_ok(mbedtls_ssl_conf_own_cert(ks_ssl-&gt=
;ssl_config, ssl_ctx-&gt;crt_chain, ssl_ctx-&gt;priv_key));</span><br><span=
> </span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/s=
sl_openssl=2Ec</span><br><span>index b95de8e=2E=2Ee2b65bd 100644</span><br>=
<span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/s=
sl_openssl=2Ec</span><br><span>@@ -159,11 +159,8 @@</span><br><span>  * Pri=
nt debugging information on SSL/TLS session negotiation=2E</span><br><span>=
  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#ifndef INFO_CALLBACK_SSL_CONST</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define INFO_CALLBACK_SSL_CONST const</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif</span><br><span> static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-info_callback(INFO_CALLBACK_SSL_CO=
NST SSL *s, int where, int ret)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+info_callback(const SSL *s, int where, int ret)</span><br><span=
> {</span><br><span>     if (where &amp; SSL_CB_LOOP)</span><br><span>     =
{</span><br><span>@@ -425,7 +422,6 @@</span><br><span>     }</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#ifdef TLS1_3_VERSION</span><br><span> static void</span><br><span> conver=
t_tls13_list_to_openssl(char *openssl_ciphers, size_t len, const char *ciph=
ers)</span><br><span> {</span><br><span>@@ -449,7 +445,6 @@</span><br><span=
>         }</span><br><span>     }</span><br><span> }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> </span><br><span> v=
oid</span><br><span> tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ct=
x, const char *ciphers)</span><br></pre><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2189?usp=3Demail">change 2189</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2189?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:n=
one"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Br=
anch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib645e0b=
f5c8941f4b1e14f13397794be15eab68f </div>
<div style=3D"display:none"> Gerri=
t-Change-Number: 2189 </div>
<div style=3D"display:none"> Gerrit-PatchSet: =
3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--EEgM+ZJqPFw=--


--===============0328732771149992994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0328732771149992994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0328732771149992994==--

