Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B70606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UjokA1in;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ClDNr8TT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mYI5kZ2V;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eDJ82O1s
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9r5pPJY1o4ZWZVtcPzjzqJ4gP8VAPTVJGoHzRWhpn2E=; b=UjokA1in19SDk3wmyTu4UqcJxu
	Ol20lACf547MGIHvHNsh0oqNCR07Mwz8ysoTSXH4YBOT3Yumh+z+a2Bah7kCYTsjN6Z64rKCdilip
	DZB9m1WB3d53sHv8IgW9RIe8k5KS0w/Sgdz3eVpwvDCIYCMa23RZjT3dH8fL3haS3+n4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSYYQ-000000002CY-1xx6;
	Sun, 15 Nov 2026 11:37:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSYYP-000000002CR-32ZE
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 11:37:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xmGDWnPuRnip6eJpEk4CaT47IJHv1n/B3TptE+E8Z6k=; b=ClDNr8TTnd7OBUzFRco2CzIW0b
 NyOG1CRB6xo4fU1JSfLq63U2WwfDqsmcBjmn8nOAPgdQNombgbP0AqpXQIgaC3q3Kzo9WxNTM5O3b
 94PL+pLVqtMQA/V6kPGrLKgTbtJ12PRCiLAH0rUupw/MheQRN+sWPKalWQrJvmRHlyQ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xmGDWnPuRnip6eJpEk4CaT47IJHv1n/B3TptE+E8Z6k=; b=mYI5kZ2VLfosBBZUtrmV6/3mGa
 LUdDScCOwKHqE66AiHFmTWOgdpwaGhaV1ecRoJmtFn94Cc2HYk3J64IiKt8IlxOY6P8bgjBn9ZkEd
 002++r2B72u/gwTHZFWmIoBdZNnl+vWnSi12NQ1QfHHVk4DqyEq4+UV7M6GD6F/GqfUM=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSYYP-000000007ay-0NuU for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 11:37:49 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so20665925e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 03:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794742662; x=1795347462; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xmGDWnPuRnip6eJpEk4CaT47IJHv1n/B3TptE+E8Z6k=;
 b=eDJ82O1sGq4ZJPiUOMCgcHIy5p8J9GDwlZTVu/E2C436W2ZQ+5W7ZtCcq3hMmwazGb
 8ItLujkCyWdY/sgekK77wLVYrQaduVVU8VsgxFYl/FvizeCCHLaSJ3zkvWxkrCCiQn3B
 R6FVbSAByT7NtLXE8uHHc2fg5y3o5OzHqqNgNwddXCkUoyfBKn8UC5xFxdp428GQ5Sde
 sDPMW20+y0PtEJrp9Xb3m08yRj60S4gPGqkbRkcPnTIg7u29cH4F9SSEJrhaDHKYdzih
 TLUMG5ev73TLjNoAZUiUlX15f3cwv+nslbveUe3ANyTjA/EFZcULHfW2PxzOyu0XlW4a
 wtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794742662; x=1795347462;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xmGDWnPuRnip6eJpEk4CaT47IJHv1n/B3TptE+E8Z6k=;
 b=pN+pBLQFu+kqxfodC6rzI4Vp37kIIXfDKOJtHqXJX7j6C5SQ2AJ9iu4MtiHfdTb23X
 aXZgn8ePyuVO0IGZFgoyPOjgVCDn0I5ZyG6+Cpo06GbTl6FeFySDt5ux6jmRKiPUW73m
 B0wUhsEoOZl8YJ4NJZsSAmfa8cJgd1xcA7trn3uUzaXTTB0IgZMo91b2AGiZhtIUrmG3
 qSnJZBI7FQXJ5GbGZydBfZZnh9RyjJl+bZ8bd4eYaRAMuxBYLpMqYmOgGRHHrTOugDA4
 fYMi2yjp16+TPH55FUA2GPP+8X1qnJ7+S8hX8pe61s07GDlrVHH/O1ru1FPdyFIPiifD
 IftQ==
X-Gm-Message-State: APuU4Z+uKyn/4XivT6oPgKurdwY7Nh2lH0fc1XP39AEuUr44HtPz18oa
 5TVEUmIjADl8phBygY+GK/90xSCazoV2fmJJgbTjt/FL64HJHK7E2+g+b7y1ZtFHBPhItCShLLO
 dGCyyOP90D+Hrz87H67zi6E8b0CT6yPiMH368G0gwfvnMwPK0xC4ru8ubpt/X2TkCJiRQ
X-Gm-Gg: AYBFou0KefLCz9L7cr55x1KLIdJuDZ0hwqDrArd5kwzy+SLkWSLibppvgiwihb4E0UY
 AXxlu7UGHjGHQnlVjvuZPHfzwkUa8DexVicGexmZpUMGvMdy7IOQ170Q7zdsisSIGhnvD1sQhOZ
 rmrgvUGcVBI/zCSVfXYhmLKU8qNcdF7qv7o2FMdGubRruqKBUIFbhATvDws8lAiZS8JoOGHpx/1
 EUqBKVvEBiYMD6IJ4ojTPSdOy0WUKvqelZ+EnlCL4mE1x5tgCOebEKWCOh/X+Y8Vq6RLLcwdWAS
 mDRihHOFMj76TVMJPpvzK6kfg4yhL+U8n+Y4WTTS/AXSbmMJ7bFV5ZanAngjv0xEQTXuh9/8Zj2
 Zy3IX2D074z7sHGVsax1q+PhYTlk246U0cmDYuCCcHg3d0sztg1dfdz8LDrdjnH1TpUiM1kENlh
 JOrcJW6X4T5QRcrXtbwtldHhXmBCwrnHzO7klnwBhpeWAoOntUrBD+GYNOesLE2yiQJsKFMPVEf
 0Wy8J66qffHLU1vM/0zLFx3BRwdzVpU6iQYMTAgiG5PXash+pKk6E0u7k5fICkhEt6ykBCCdlpT
 XC/+FXlAtUoDW9ojK8QY3zbmM/WWv6wXJANviGeAMmEeQvS6T2sU+w3w+06poiByxler6oDvKwo
 cu+j6utZCTWGA8avvQBWiRq+jISX5tHCMMiqyyFTuVDEtVU0g8ksUlWq3Xr/jCumA36o/jKL0aj
 cxSpksAQxLOslCHW0=
X-Received: by 2002:a05:600c:b50:b0:4bb:5c5c:8130 with SMTP id
 5b1f17b1804b1-4bb5c5c8255mr91326795e9.5.1794742662345; 
 Sun, 15 Nov 2026 03:37:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb679b7e1asm156646125e9.6.2026.11.15.03.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 03:37:41 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 11:37:40 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5099b109d43664d5b83adfded6adfaf5ae9d608f
X-Gerrit-Change-Number: 2099
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2099?usp=email>
X-Gerrit-Commit: 6fcbfb8b1b1575af361fd6132c73b0aaf38742ed
In-Reply-To: <gerrit.1793686929000.I5099b109d43664d5b83adfded6adfaf5ae9d608f@gerrit.openvpn.net>
References: <gerrit.1793686929000.I5099b109d43664d5b83adfded6adfaf5ae9d608f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjg2OTI5MDAwLkk1MDk5YjEwOWQ0MzY2NGQ1YjgzYWRmZGVkNmFkZmFmNWFlOWQ2MDhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8d6028ffcdaa79d8803b8a94c6c66afdd678b7b7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSYYP-000000007ay-0NuU
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_mbedtls: wipe
 private key password buffer after use
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
Content-Type: multipart/mixed; boundary="===============1794381700232948199=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1794381700232948199==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1MHx0Lcre5I="; charset=UTF-8

--1MHx0Lcre5I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2099?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: ssl_mbedtls: wipe pr=
ivate key password buffer after use
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

ssl_mbedtls: wipe private key password buffer after =
use

tls_ctx_load_priv_file() left the private key password on the stack=2E=

Clear passbuf with secure_memzero() once the key has been parsed=2E

Chang=
e-Id: I5099b109d43664d5b83adfded6adfaf5ae9d608f
Signed-off-by: Razvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2099
Message=
-Id: <20261114154843=2E1738-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Em=
ail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41302=2Ehtml
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_=
mbedtls=2Ec
1 file changed, 2 insertions(+), 0 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/99/2099/2

diff --git=
 a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index f4e142b=
=2E=2E43bb0ff 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ss=
l_mbedtls=2Ec
@@ -486,6 +486,7 @@
             status =3D mbedtls_pk_parse_=
key(
                 ctx->priv_key, (const unsigned char *)priv_key_file, =
strlen(priv_key_file) + 1,
                 (unsigned char *)passbuf, strle=
n(passbuf));
+            secure_memzero(passbuf, sizeof(passbuf));
       =
  }
     }
     else
@@ -496,6 +497,7 @@
             char passbuf[512] =3D=
 { 0 };
             pem_password_callback(passbuf, 512, 0, NULL);
        =
     status =3D mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, pass=
buf);
+            secure_memzero(passbuf, sizeof(passbuf));
         }
   =
  }
     if (!mbed_ok(status))

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2099?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I5099b109d43664d5b83adfded6adfaf5ae9d608f
Gerrit-Change-Num=
ber: 2099
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--1MHx0Lcre5I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2099?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">ssl_mbedtls: wipe private key password buffer after use<br><br>tls_ctx_=
load_priv_file() left the private key password on the stack=2E<br>Clear pas=
sbuf with secure_memzero() once the key has been parsed=2E<br><br>Change-Id=
: I5099b109d43664d5b83adfded6adfaf5ae9d608f<br>Signed-off-by: Razvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2099<br>Message-Id: &lt;20261114154843=2E1738-1-gert@greenie=2Emuc=2Ede=
&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg41302=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl_mbedtls=2Ec<br>1 file changed, =
2 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/99/2099/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><=
span>index f4e142b=2E=2E43bb0ff 100644</span><br><span>--- a/src/openvpn/ss=
l_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><=
span>@@ -486,6 +486,7 @@</span><br><span>             status =3D mbedtls_pk=
_parse_key(</span><br><span>                 ctx-&gt;priv_key, (const unsig=
ned char *)priv_key_file, strlen(priv_key_file) + 1,</span><br><span>      =
           (unsigned char *)passbuf, strlen(passbuf));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            secure_memzero(passbuf, size=
of(passbuf));</span><br><span>         }</span><br><span>     }</span><br><=
span>     else</span><br><span>@@ -496,6 +497,7 @@</span><br><span>        =
     char passbuf[512] =3D { 0 };</span><br><span>             pem_password=
_callback(passbuf, 512, 0, NULL);</span><br><span>             status =3D m=
bedtls_pk_parse_keyfile(ctx-&gt;priv_key, priv_key_file, passbuf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            secure_memzero(p=
assbuf, sizeof(passbuf));</span><br><span>         }</span><br><span>     }=
</span><br><span>     if (!mbed_ok(status))</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2099?usp=3Demail">=
change 2099</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/209=
9?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I5099b109d43664d5b83adfded6adfaf5ae9d608f </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 2099 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bo=
dy></html>
--1MHx0Lcre5I=--


--===============1794381700232948199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1794381700232948199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1794381700232948199==--

