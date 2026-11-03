Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF1F606A327
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=couTlsku;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MPZrkqke;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=h8jt078G;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=R+b4gwDj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BGgKzyHoUSBlIbTG5KgcELRQ93YI1EMhlOGbsSFA+bk=; b=couTlskux4h4FUL4AC0F7R/YbU
	iMm9fZ33nILw108s6rLDFxPPz0PrE402yhggFiybGtTOyw0gvEBDVuwpu8KR9Yv+fSNZwJCDC4+Fm
	yRqX7aXqysT40XWXaLU499WaSUp3IvxvBOB2PT/LFdnHPIPbxre+xSYLpwMUjXxvAoJM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xODRH-000000000DM-0aZa;
	Tue, 03 Nov 2026 12:16:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xODRE-000000000DE-3FwF
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:16:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kBpgnx+6jMhqQkf54Jd8D/zKWaN3D+K7+eiPegmTDXU=; b=MPZrkqkeBu8wUH1kXOLY5+15oY
 dZmlQFS1kpKGl7+MAUGH2Q1o6H39vXmefRCOYidT059tuz9FDsWSbGtrAh/38h9b6xaJry00zPWUf
 45auH1wQuDgNfbAP3AdpRmnrdMtGnQsQtHMluTBbe1lYivbykfqnMRuoLPcDJk2AgT08=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kBpgnx+6jMhqQkf54Jd8D/zKWaN3D+K7+eiPegmTDXU=; b=h8jt078G1jM3dpb8ptld3HEotr
 nGfLjRJ5oc5ryUafU88Bx0KcSHwB7b5PgOwwajgSteVJJkI7YFW8dIcTH3dO2SzKmcoOF18bnrWQF
 9u7NVhV37+PBg954j8m4T6uIxGysnpSjRJvehAZ+HBfUiAVi/14SOGWDqPcMm5gtdVDw=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xODRD-000000003AN-0bV1 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:16:28 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so40043475e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 04:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793708180; x=1794312980; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kBpgnx+6jMhqQkf54Jd8D/zKWaN3D+K7+eiPegmTDXU=;
 b=R+b4gwDjAUAmwXTkIDlyLlp4tEAa8BHX7jQeaJo+5zYY1xVzBrAw8bmes14MafjzW1
 CX6zr7tBOVwoU4OuP7IH5KLscxQEbndNl8kCAbkmOPmDnzbaxhGHKY/hd9xPq/pT6Nnc
 nHYHDry/2rIW87q5Q0xU91CojYMtigdXDoHe9I4Dq/XtPw0hgc9MztxTFBOzOgsr2yzV
 g2fj0CYKQD5jj9bK72etH4SPoGd2JdSLgbxz1IQluhFRGNI8jzSm0cQNQU1gRVJ1nQAS
 RZ1nkDzNjuIbXQvYRrqNJVyyMhvd7mtdVO0gTL0Cx3e7vbeuoyAprrJrnwEp2OXWwqXU
 Yl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793708180; x=1794312980;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kBpgnx+6jMhqQkf54Jd8D/zKWaN3D+K7+eiPegmTDXU=;
 b=VQ+XS1bDDZcccIkq3GyXKurzXR0Dk4qLorHMDrrkVvXW8vCLKl+7TlRbjhQ4u3UuIg
 g9fhYrZYYOH9AxiljzF1xpR08wjyjSO/sjMPzJ8acxl6lC8JMwkeocx4H0vBuvqfwcGE
 4KNh5OzaqlKYNHnwvcRhmJ0ISSHA6f6YWjlCn2jcOfo1NVxtXmBoyriVYvLmO6SzaEwl
 wzxd1LNrVfmZKKL5Pa4TocOWbKCuy4ZBNDow+RAA1H2u6E9PksqachrrOWzfAlS4cwAZ
 FhbXJs+aT98da+Gz2cZjs3Z1gQgyYrQ2B7NYC/zV4/GXY1e0z8Em/7iSLFxTCtERC+01
 ynuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxD7wfbw/GelBVyaLGViGl5/CiAdGKzz0HOOIXkcYUbC8NWs5P0+Y8WndpiINKyiEXdWdU3BOG1dHka2gn@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+vLAkzsX+3iqY9Rs0IzGmQZreiVCWDLRyjzuYMGHlz54Nnyr92
 eoxOpuSj8MDkrSdfQKy/j5y8Hzf5pkFoDNuzMLLkSpmVhx1k88qVvW9zu5hAVPUe3vK+vpGok6q
 AcRX619zy6M+zDxW7UAXaNgQzQnaAz8o9rOh4CG9ZA/t/4yPYI/HUFMnBD7/AY0aSZh3cDgqz8a
 c6fYvPDQ==
X-Gm-Gg: AYBFou1HocFzLKmO7NoKZzDEO2dWukcDVSJAELKD9El6lFFTgIwB1t/CoWogXSdJsqG
 T/duy5q3axsD3RMFUEGuTwEFE+fTgdPrAH71WFNF9JAczjQwBIeZKpZZxo+RwbYAfSbmEabnBAS
 DvdJI5pprI1Mj1b8kpRkiVr26yLmXNtVxmrF4P/igcs9MxgKXKqLYGHyRFI86TDW1ihcgHsN4b0
 CDY6+nslLKKB4eJg6iMbPF7K6BiOW5jX2xmaJ68FYzYb0QN2Oj3gs1LhxW9UuWJqAE2emXqy8an
 V3B5gz+4cRx1YGh8o9S+QAxDi+z9PCkjuxYLNsPh0ZNfN0MXSx7NXO2M28cEhg52xefV0J8RtTg
 j29J5KcuojW2TpwlrVw3N4ev3YBRugev7srxWBLKw/98ZSz1KavPI9Yrc/5s0D/jaD1C9bwq3CO
 dXjdAD3IAEa7EsUS0KQekQ5V7lIvRLYUbKxq4h6dEtFd0tMcp5/tFYk9qZvvfLODEWhejPn7LW1
 6RYTjvT3iSxAlV35UhmI0g4EegKsgnxVtnccJBh7brWTvGFP/vsPL41/n0Y5sRgfDkZkUKa9fkG
 7oEH0CTNcNSfyFC1SXFHyUPkRitrfm4CfotpBM8wozQI9WC1gcSKrJczp8UDjnBYGbR5radLEv/
 9OebTwKZpWXQjLJFSai+Qn8q5jsK/FlvvCatfPJ1QRWR9ZH5EPf0RC+bKkVlgm0sOg+EzcgziCx
 PWm5rzsYcASSjC0g==
X-Received: by 2002:a05:600c:e555:10b0:4b2:61e5:b2f4 with SMTP id
 5b1f17b1804b1-4b261e5b38bmr46871345e9.11.1793708180466; 
 Tue, 03 Nov 2026 04:16:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa38bb4asm52858105e9.6.2026.11.03.04.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:16:20 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 12:16:19 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
X-Gerrit-Change-Number: 1856
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1856?usp=email>
X-Gerrit-Commit: 6b617486ada6b9b936e0076081ca878ba493a3a9
In-Reply-To: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
References: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MmQ4Nzg1OTU5YzI0YmY2ODgxOTA5NjVlNThiOWI5ODI1MWI4NTU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fde164ddbb6efd910e96d92ebf80bfacc351aff3-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xODRD-000000003AN-0bV1
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Introduce
 get_key_by_management_key_id helper function
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0180139060881789871=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0180139060881789871==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MW/bs8sW7c8="; charset=UTF-8

--MW/bs8sW7c8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Gert Doering has sub=
mitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=
=3Demail )

Change subject: Introduce get_key_by_management_key_id helper f=
unction
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Intr=
oduce get_key_by_management_key_id helper function

This function allows us=
 to map from a management key id to a key structure
and also allows this fu=
nction to be reused=2E

Patch v2: add message when key is not found=2E
Patc=
h v3: only consider valid keys

Change-Id: I42d8785959c24bf688190965e58b9b9=
8251b8557
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Razvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1856
Message-Id: <20261102134628=2E26248-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg40434=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1856
Message-Id: <20261103100955=2E20917-1-gert@greenie=2Emuc=
=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261103100955=2E2091=
7-1-gert@greenie=2Emuc=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/ssl_common=2Eh
M src/openvpn/ssl_verify=2Ec
2 file=
s changed, 32 insertions(+), 10 deletions(-)




diff --git a/src/openvpn/s=
sl_common=2Eh b/src/openvpn/ssl_common=2Eh
index 579f46c=2E=2E9a55ead 10064=
4
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -764=
,4 +764,24 @@
     return &multi->session[TM_ACTIVE]=2Ekey[KS_PRIMARY];
 }
=
 
+#ifdef ENABLE_MANAGEMENT
+/**
+ * Gets the \c key_state object that belo=
ngs to the management key id or
+ * return NULL if not found=2E
+ */
+stati=
c inline struct key_state *
+get_key_by_management_key_id(struct tls_multi =
*multi, unsigned int mda_key_id)
+{
+    for (int i =3D 0; i < KEY_SCAN_SIZ=
E; ++i)
+    {
+        struct key_state *ks =3D get_key_scan(multi, i);
+ =
       if (ks->mda_key_id =3D=3D mda_key_id && ks->state > S_UNDEF)
+      =
  {
+            return ks;
+        }
+    }
+    return NULL;
+}
+#endif
=
+
 #endif /* SSL_COMMON_H_ */
diff --git a/src/openvpn/ssl_verify=2Ec b/src=
/openvpn/ssl_verify=2Ec
index 73e3696=2E=2E7baa4fc 100644
--- a/src/openvpn=
/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1250,22 +1250,24 @@
 t=
ls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id,=
 const bool auth,
                      const char *client_reason)
 {
-    =
bool ret =3D false;
+    struct key_state *ks =3D NULL;
     if (multi)
   =
  {
-        int i;
         auth_set_client_reason(multi, client_reason);
=
-        for (i =3D 0; i < KEY_SCAN_SIZE; ++i)
+        ks =3D get_key_by_m=
anagement_key_id(multi, mda_key_id);
+
+        if (ks)
         {
-       =
     struct key_state *ks =3D get_key_scan(multi, i);
-            if (ks->=
mda_key_id =3D=3D mda_key_id)
-            {
-                ks->mda_statu=
s =3D auth ? ACF_SUCCEEDED : ACF_FAILED;
-                ret =3D true;
-  =
          }
+            ks->mda_status =3D auth ? ACF_SUCCEEDED : ACF_FAIL=
ED;
+        }
+        else
+        {
+            msg(D_TLS_DEBUG_LOW,
+=
                "%s: no key state found for management key id %u",
+       =
         __func__, mda_key_id);
         }
     }
-    return ret;
+    ret=
urn (bool)ks;
 }
 #endif /* ifdef ENABLE_MANAGEMENT */
 

-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8=
557
Gerrit-Change-Number: 1856
Gerrit-PatchSet: 15
Gerrit-Owner: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>

--MW/bs8sW7c8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gert Doering <strong>submitte=
d</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1856?usp=3Demail">View Change</a></p><div style=3D"white-space:p=
re-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Introduce get_key_by_management_key_id helper =
function<br><br>This function allows us to map from a management key id to =
a key structure<br>and also allows this function to be reused=2E<br><br>Pat=
ch v2: add message when key is not found=2E<br>Patch v3: only consider vali=
d keys<br><br>Change-Id: I42d8785959c24bf688190965e58b9b98251b8557<br>Signe=
d-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1856<br>Message-Id: &lt;20261102134628=2E26248-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg40434=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856<br>Message-=
Id: &lt;20261103100955=2E20917-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:=
//lore=2Ekernel=2Eorg/openvpn-devel/20261103100955=2E20917-1-gert@greenie=
=2Emuc=2Ede<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<=
br>---<br>M src/openvpn/ssl_common=2Eh<br>M src/openvpn/ssl_verify=2Ec<br>2=
 files changed, 32 insertions(+), 10 deletions(-)<br><br></pre>
<pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><sp=
an>index 579f46c=2E=2E9a55ead 100644</span><br><span>--- a/src/openvpn/ssl_=
common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span=
>@@ -764,4 +764,24 @@</span><br><span>     return &amp;multi-&gt;session[TM=
_ACTIVE]=2Ekey[KS_PRIMARY];</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Gets the \c key_state object that belo=
ngs to the management key id or</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * return NULL if not found=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static inline struct key_state *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+get_key_by_management_key_id(struct tls_multi *multi, u=
nsigned int mda_key_id)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i=
 =3D 0; i &lt; KEY_SCAN_SIZE; ++i)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        struct key_state *ks =3D get_key_scan(multi, i);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (ks-&gt;mda_key_id =3D=3D =
mda_key_id &amp;&amp; ks-&gt;state &gt; S_UNDEF)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return ks;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* SSL_COMM=
ON_H_ */</span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/open=
vpn/ssl_verify=2Ec</span><br><span>index 73e3696=2E=2E7baa4fc 100644</span>=
<br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvp=
n/ssl_verify=2Ec</span><br><span>@@ -1250,22 +1250,24 @@</span><br><span> t=
ls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id,=
 const bool auth,</span><br><span>                      const char *client_=
reason)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    bool ret =3D false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct key_state *ks =3D NULL;</span><br><span>     if (multi)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        int i;</span><br><span>         auth_set_client_reason(multi, cli=
ent_reason);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        f=
or (i =3D 0; i &lt; KEY_SCAN_SIZE; ++i)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        ks =3D get_key_by_management_key_id(multi, mda_=
key_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (ks)</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   struct key_state *ks =3D get_key_scan(multi, i);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (ks-&gt;mda_key_id =3D=3D md=
a_key_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ks-&=
gt;mda_status =3D auth ? ACF_SUCCEEDED : ACF_FAILED;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                ret =3D true;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            ks-&gt;mda_status =3D auth ? =
ACF_SUCCEEDED : ACF_FAILED;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_T=
LS_DEBUG_LOW,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          &quot;%s: no key state found for management key id %u&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                __func__=
, mda_key_id);</span><br><span>         }</span><br><span>     }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return (bool)ks;</span><br><span=
> }</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856=
?usp=3Demail">change 1856</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1856?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1856 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 15 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--MW/bs8sW7c8=--


--===============0180139060881789871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0180139060881789871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0180139060881789871==--

