Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5AE606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NrPDspOv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gWIlp6P3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ag/wDyES;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SzNbJgNk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zyYRXEaP0WLK8wyyBy2BY/5W90f0/jjPm8QEz6c1nhQ=; b=NrPDspOvvvcIIj7AhhghmWOnz/
	FpqZI/P7++6+HzC0e7hOvahU8WGV/GjNmIJvBh/aQkIzIPmF/73UTQyiSm7/CaRm8S/cQkUqQlj4S
	YH6w5f7lI5nkGfc3BWr5Pn4QpEN5eCsMX7t5f8+RsstO/yXZ94VKwa85MOAytLH6UUZs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTgkM-0000000045S-2CQV;
	Wed, 18 Nov 2026 14:34:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTgkL-0000000045L-1bTg
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:34:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5wHN2VBHYnL+fB7lKLSXPrTG4bf2MCxCdxZ9xmK/bCQ=; b=gWIlp6P3zE2ckiSqhhaObL6AtK
 JwTSP9bttBoRJCE6IN4k0MqAagzfMMqh41JMhYKUM4TtPwhz4Krr5VIAIieHGA3pgZdOmfs/6WnJc
 qKrYPfSbal683VXGB4AMEpXOV+/F695EjZSWnXnkO4FyPJ8G4Ne66Ov4cym03+yHFBKY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5wHN2VBHYnL+fB7lKLSXPrTG4bf2MCxCdxZ9xmK/bCQ=; b=Ag/wDyESBjJE68VkNWDNGkWA/S
 Lh7vxRIFhxtjfD+hqy74B0OQmhTU2LQ69WO8SeGH7RUEPU3Rvg74e6wBxlYYTWm1j8mkQCH5K1f09
 81fGNxDNEvAhhXEpsiapyoxDSfblytSnrhPrFQOAu0utPzB9UtFoxcEZFkiB82+GtCS0=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTgkJ-000000000uL-2mRd for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:34:49 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so9793035e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 06:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795012481; x=1795617281; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5wHN2VBHYnL+fB7lKLSXPrTG4bf2MCxCdxZ9xmK/bCQ=;
 b=SzNbJgNkwn+Zqq5pCARuv3ZNr4rQvhZqIYDamF/rQzxl7bRe8xkpetTzQoNKEkV/83
 79F1htPk44F+AK7cc9d5S6YfSa9Hnjvf4+AExVlU8/bugyeHR4h4+ep96YUY1Rg3f6SQ
 EVFWAk5hgOFoamBGXDlAb8SHhW7PqyV8+i1UxvKYn8vpLxyAOI/kzwj/P75lAXNvmuiy
 eLdQ+C3NUfi6HL4dCJ72SlUSHUfmU6hXJ9S5F2hNdpD9IMOT7kpxV1CFDEMw9RkEray+
 IDF8qzIcXb7c2dt/wDdrx9G5+JQHULvf9qM/9qOJxo/TSBtDOZeunAzNutPp7UAi+fW6
 ekWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795012481; x=1795617281;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5wHN2VBHYnL+fB7lKLSXPrTG4bf2MCxCdxZ9xmK/bCQ=;
 b=C+WfKasd71a1uZZeagjSU+I2cGlebpdJOagVpW/D9ALQ/wdRnYOfcKysB4pxjktema
 DzinJyWiAxQV6Z8VNGQNmDeKokbA5LZS9BlBpiS+F6oGTG0zHZQSc6gP8nfiFUYQFEio
 1OeCRbde4HRXPneQ4aI5DF7cRoSQBQxN1aYg5APBkMp6S3C5y2eUbbJ04hkMTegkTP76
 vJpAhw+eYYgfwSTC4rHsckuHYPLUtgui124YTclcubdH6X4nzmjf+c4VgOlml40nGOyo
 XzJffYTk+8hJXw6a5fgekk8XSKllHRcFH9PNKyoUuzbxULYmgcuRZiCPQvCKkKD8oMqr
 F4YQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG3XnXIIc1N3S2XOMfF7Y3bzbVB5n+5N//Ofx/kBYqdsgH44MhskgiLnXjHsHHmN5GtZc1fg8IaZmbZ7DSn@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8fRzmpOw0gDNVAwihwvsBVEP9PCZ7CMgx2JgvaMMBs7U/QdZRN
 5+2uBlRL6PnuZWG/QVpBHWLpAr0re1FngzyOszi57IvXCuOGBw3Wg0B/cwPLiOJbbwiKbfd8NcP
 WLWf2TaCzYnQFcHzTRUb6Imb8QysV2n2hZl/6eNGO9GEWCnMp/mTE3gvgdKMRnvsNdo66
X-Gm-Gg: AYBFou1PbzquT2YJFGYAwX9pG9xp+iH7nmqMrjOjoAa/HmECSmkw/pPnPwz5oNg0td5
 jYQg1GLZ2yFpc32hxt9vQAMd/cwkQ2x1T1S7qkEL3/kLFf4wEknQuvmm7IW4aUm5/Y3CmiKL9ZQ
 Gov7bRcyQtvhgcT1qUnehvUE5zpor5n2KbinqGJfHGqt0PQ54fLakDs2SRBeythsFfgQcvLeyd/
 pj1+SCoIBhUjOYNrXWEkeyqAjieYrw/9xV1edI616UEyE8bm3cQuhmtuH6pqB0XJaSWcfZ/5sXa
 N5CCH+7cnlWuwtWFmforuejl1z38Z7P2XsgyzZAg4uuDrWmPQiGkNLeIHAP3JNJB1+q5oyJAVnA
 lCCSuRPV+9qsZJ/XT4yEVr/MiUkPL8Ti+IBIegOyzq4HFFZgFGx4tR4roDkdCLWrfIUaibU4X+6
 3RE9Hq2+MFKHDNkugVFkxvYEoN726XQ+7l5g3zANjnbM8O3dnvPfctKtJWEpPiTPwde5c7ZNmER
 lCSZUNSPM9/M0TJLxMGKi4iFZ5IxR/Dmnr+VtpLhMVxr10FcJTr/v5Kzaq/53N5bkJ7gQoYnZsW
 U0SbJ16wEW46tujb+DWFhy6WK5eC0zZiXqWCnWYb2Ha/B2kRVlsI5rkA9T4NrfBabe+BjJ4ZB1d
 KZKuCgZp9PpaPmsFP2elrbEsY/EgZPrT/QA80z6GFV2+v+Ot3czIn5JtvbXaCLnMQRUP8AdDHtr
 OwZFRVBntyolkCLS8=
X-Received: by 2002:a05:600c:4e44:b0:4a2:a9:ed5a with SMTP id
 5b1f17b1804b1-4bb7da0f78dmr49377365e9.8.1795012480837; 
 Wed, 18 Nov 2026 06:34:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d28ec3asm77714085e9.0.2026.11.18.06.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 06:34:40 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 14:34:40 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib645e0bf5c8941f4b1e14f13397794be15eab68f
X-Gerrit-Change-Number: 2189
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2189?usp=email>
X-Gerrit-Commit: f4b0e57369874b634cbf9b402e05e5be2520c77b
In-Reply-To: <gerrit.1794827563000.Ib645e0bf5c8941f4b1e14f13397794be15eab68f@gerrit.openvpn.net>
References: <gerrit.1794827563000.Ib645e0bf5c8941f4b1e14f13397794be15eab68f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODI3NTYzMDAwLkliNjQ1ZTBiZjVjODk0MWY0YjFlMTRmMTMzOTc3OTRiZTE1ZWFiNjhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1ac43c755ba6ded229d2331b37ee56da64068935-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTgkJ-000000000uL-2mRd
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1589242200457752371=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1589242200457752371==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OX6hSucpmb8="; charset=UTF-8

--OX6hSucpmb8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2189?usp=3Demail )

Change subject: ssl: remove obsolete prepro=
cessor guards
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


ssl: remove obsolete preprocessor guards

- MBEDTLS_SSL_CBC_RECORD_SPLITT=
ING and its API were removed in
  mbed TLS 3; the minimum is now 4=2E0=2E
-=
 INFO_CALLBACK_SSL_CONST is never defined=2E
- TLS1_3_VERSION is already us=
ed unguarded, and the only caller of
  convert_tls13_list_to_openssl() isn'=
t guarded=2E

Change-Id: Ib645e0bf5c8941f4b1e14f13397794be15eab68f
Signed-o=
ff-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert=
@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2189
Message-Id: <20261117175605=2E14945-1-gert@greenie=2Emuc=2Ede>
URL: h=
ttps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg=
41577=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M sr=
c/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_openssl=2Ec
2 files changed, 1 =
insertion(+), 15 deletions(-)




diff --git a/src/openvpn/ssl_mbedtls=2Ec =
b/src/openvpn/ssl_mbedtls=2Ec
index 19a2d48=2E=2Edbc1b9d 100644
--- a/src/o=
penvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -892,15 +892,6 =
@@
     mbedtls_ssl_conf_renegotiation(ks_ssl->ssl_config, MBEDTLS_SSL_RENE=
GOTIATION_DISABLED);
 #endif /* MBEDTLS_SSL_RENEGOTIATION */
 
-    /* Disa=
ble record splitting (for now)=2E  OpenVPN assumes records are sent
-     *=
 unfragmented, and changing that will require thorough review and
-     * t=
esting=2E  Since OpenVPN is not susceptible to BEAST, we can just
-     * d=
isable record splitting as a quick fix=2E */
-#if defined(MBEDTLS_SSL_CBC_R=
ECORD_SPLITTING)
-    mbedtls_ssl_conf_cbc_record_splitting(ks_ssl->ssl_con=
fig,
-                                          MBEDTLS_SSL_CBC_RECORD_SPLI=
TTING_DISABLED);
-#endif /* MBEDTLS_SSL_CBC_RECORD_SPLITTING */
-
     /* I=
nitialise authentication information */
     (void)mbed_ok(mbedtls_ssl_conf=
_own_cert(ks_ssl->ssl_config, ssl_ctx->crt_chain, ssl_ctx->priv_key));
 
di=
ff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index =
b95de8e=2E=2Ee2b65bd 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/ope=
nvpn/ssl_openssl=2Ec
@@ -159,11 +159,8 @@
  * Print debugging information o=
n SSL/TLS session negotiation=2E
  */
 
-#ifndef INFO_CALLBACK_SSL_CONST
-#=
define INFO_CALLBACK_SSL_CONST const
-#endif
 static void
-info_callback(IN=
FO_CALLBACK_SSL_CONST SSL *s, int where, int ret)
+info_callback(const SSL =
*s, int where, int ret)
 {
     if (where & SSL_CB_LOOP)
     {
@@ -425,7 +=
422,6 @@
     }
 }
 
-#ifdef TLS1_3_VERSION
 static void
 convert_tls13_lis=
t_to_openssl(char *openssl_ciphers, size_t len, const char *ciphers)
 {
@@ =
-449,7 +445,6 @@
         }
     }
 }
-#endif
 
 void
 tls_ctx_restrict_cip=
hers_tls13(struct tls_root_ctx *ctx, const char *ciphers)

-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2189?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: Ib645e0bf5c8941f4b1e14f13397794be15ea=
b68f
Gerrit-Change-Number: 2189
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--OX6hSucpmb8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2189?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl: remove obsolete preprocessor =
guards<br><br>- MBEDTLS_SSL_CBC_RECORD_SPLITTING and its API were removed i=
n<br>  mbed TLS 3; the minimum is now 4=2E0=2E<br>- INFO_CALLBACK_SSL_CONST=
 is never defined=2E<br>- TLS1_3_VERSION is already used unguarded, and the=
 only caller of<br>  convert_tls13_list_to_openssl() isn&#39;t guarded=2E<b=
r><br>Change-Id: Ib645e0bf5c8941f4b1e14f13397794be15eab68f<br>Signed-off-by=
: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2189<br>Message-Id: &lt;20261117175605=2E14945-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg41577=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/=
openvpn/ssl_openssl=2Ec<br>2 files changed, 1 insertion(+), 15 deletions(-)=
<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ss=
l_mbedtls=2Ec</span><br><span>index 19a2d48=2E=2Edbc1b9d 100644</span><br><=
span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ss=
l_mbedtls=2Ec</span><br><span>@@ -892,15 +892,6 @@</span><br><span>     mbe=
dtls_ssl_conf_renegotiation(ks_ssl-&gt;ssl_config, MBEDTLS_SSL_RENEGOTIATIO=
N_DISABLED);</span><br><span> #endif /* MBEDTLS_SSL_RENEGOTIATION */</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Dis=
able record splitting (for now)=2E  OpenVPN assumes records are sent</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-     * unfragmented, and cha=
nging that will require thorough review and</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-     * testing=2E  Since OpenVPN is not susceptible t=
o BEAST, we can just</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
    * disable record splitting as a quick fix=2E */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(MBEDTLS_SSL_CBC_RECORD_SPLITTIN=
G)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ssl_con=
f_cbc_record_splitting(ks_ssl-&gt;ssl_config,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                          MBEDTLS_S=
SL_CBC_RECORD_SPLITTING_DISABLED);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif /* MBEDTLS_SSL_CBC_RECORD_SPLITTING */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Initialise au=
thentication information */</span><br><span>     (void)mbed_ok(mbedtls_ssl_=
conf_own_cert(ks_ssl-&gt;ssl_config, ssl_ctx-&gt;crt_chain, ssl_ctx-&gt;pri=
v_key));</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_ope=
nssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index b95de8e=2E=2Ee=
2b65bd 100644</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><=
span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -159,11 +159,8 @@=
</span><br><span>  * Print debugging information on SSL/TLS session negotia=
tion=2E</span><br><span>  */</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#ifndef INFO_CALLBACK_SSL_CONST</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define INFO_CALLBACK_SSL_CONST const</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> =
static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-info_callb=
ack(INFO_CALLBACK_SSL_CONST SSL *s, int where, int ret)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+info_callback(const SSL *s, int where, =
int ret)</span><br><span> {</span><br><span>     if (where &amp; SSL_CB_LOO=
P)</span><br><span>     {</span><br><span>@@ -425,7 +422,6 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#ifdef TLS1_3_VERSION</span><br><span> static void=
</span><br><span> convert_tls13_list_to_openssl(char *openssl_ciphers, size=
_t len, const char *ciphers)</span><br><span> {</span><br><span>@@ -449,7 +=
445,6 @@</span><br><span>         }</span><br><span>     }</span><br><span>=
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan> </span><br><span> void</span><br><span> tls_ctx_restrict_ciphers_tls13=
(struct tls_root_ctx *ctx, const char *ciphers)</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2189?usp=3Dema=
il">change 2189</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2189?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: Ib645e0bf5c8941f4b1e14f13397794be15eab68f </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2189 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></htm=
l>
--OX6hSucpmb8=--


--===============1589242200457752371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1589242200457752371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1589242200457752371==--

