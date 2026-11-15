Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B433D606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=J+1gc7pK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Aq8xW/x7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kEBgLccY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ftnl8NzT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vVjaNbJuGuBE+uJCnFDttGiVQL4dGZmLO4C62TRce48=; b=J+1gc7pKNXUf/jFDg7HAfxhdGG
	+tDh4HzRwAqupWh6Ay6q8Ta5UjHXSQx27OQcUQESNO6R1gEA4Qvy4gLajJM97TZrjVCS6ZR+8w4HO
	2SPbTpy4P7zdmyEXprrgiLlRJIt5UygSZjDppQ4CB70b90tcVg9X1Us4fVknmeMR+mVU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSYYR-00000000193-1lWJ;
	Sun, 15 Nov 2026 11:37:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSYYQ-0000000018x-3as5
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 11:37:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+Mv/ZatHwDOlke3Xzwi3AZ8GGiXarunARdtg5Jzrf8o=; b=Aq8xW/x7k0FmiBoeYXcFTJiRju
 j07hLlo/P6RdiL0i8dE6irArxDGi72LAMZia/i9hUOI67F5obrbb3aiROkLSgTHSNx/isAt3d3vEr
 5fbfoHEGSHBqTd1GPcItwBM/2J1O5TpsAGYcClbqL+KBUk3/ZzaTtVanGBrb8yaLKGWM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+Mv/ZatHwDOlke3Xzwi3AZ8GGiXarunARdtg5Jzrf8o=; b=kEBgLccYXTbU5OSbyChYlILbxz
 vWbVWSjqo0P/dt86CL593QuYAN0ZHjdWDj9mmi4Ty4eK+8AghhQQFBgfEaiXdn7gou49hZC2URDvv
 4PVgmqM2KrMADF2oJUNfrqERbmqP9LaACs6hWnWrxynqMQXX2B3dpfbZRZBRzq8xL6+M=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSYYQ-000000007az-0hJi for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 11:37:50 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso16752175e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 03:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794742664; x=1795347464; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+Mv/ZatHwDOlke3Xzwi3AZ8GGiXarunARdtg5Jzrf8o=;
 b=ftnl8NzTsqonkT0JjYwK0U2dXcSdMTJpJxJUF1TC2KyiByOzscAU9e+AxZgyxUnS+i
 T1IAHZ7S2a7c+icM55KyBm/ObDEPFZ5N9ZXg3LPuOZax0iLBeKm5BsZOfce6GmQuUZK3
 Taa1FPPSB6e99NDZ/ffn9shKxvu/haCAEP/UT+oYPLGzUcunxWOhvababX0FQUZZ0EVm
 /sT6k4Iz8cgZAndUOg6FqaUWSW546RF6K1bUekJ/K+JNtzOmmRgEKu8SoZ/Ez1YOJ5M+
 3QU7QtKJjSZxYURNrxTeYoD8C1OPrDxW/q3er7HTu8xdt6yTqO6XCfm6Co705lqtD0Ln
 O0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794742664; x=1795347464;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+Mv/ZatHwDOlke3Xzwi3AZ8GGiXarunARdtg5Jzrf8o=;
 b=oq0YGqQVQM/Ti6DeUVpI+6c0+FLNrBkcwi+NPgkQBYz1EBEzbSnu8KJb+tmWMUqjgQ
 4siMc2LgzOmXCYJ1gtIulYGUrv4qYKzULboXLknFD1BwH8tFzxtRB406eWQVmVR9TMnK
 1GRjsBxnn3A5H+GTmJjmwsuO4UYQrhyvaFFxkj5hPm4P2+IuIXKGa3r8pVe4Nwla9IrT
 CzyFb3RKqjRfHrX4yQRcPGWgOpj+NQE75nZu2VWwBtiMaLxCFf57+2dxABjOi477UkmX
 BJp/2F2HZwHHWJ7clZvil9dtNdKLZD0/RPFQjefgsiDrEoyh1fcjL5+gbXj63H3T6D6z
 Ga2Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFwiTVy33xSJ0d3lH2xmJHKzFMZ+srXcKmFefSAh3jaMjSu6ZpBEk2uoeaKi0eSiUG3zCMDHhEdk/JeK4lq@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/WiQ9WwDa4ztPUzF+wh5lq8TyzTY7kw7V6gQZg3LhZ/PeWmpFD
 EO7rPI5q74S0CQI+Yk65q9823jdDP30CEjZ8TvNylO94Zg06tEOAdpUwnQBMrJMVYt8J8hkn/c9
 2qbsmJR0vXKEAtY9UYPgCMEl6ZKNf+yrP+FijOzrsW9apRQR0wR6v8JYh19pS/GW4G79/
X-Gm-Gg: AYBFou2Us7RBCSZa7WBoAr0+XI0jIljQNGA4GyHWNve5ShZ876EwpLUtnPHVOe2rsvZ
 xOt2Qfej00504r92ou+SXQ3TvSaAH2fd/xr+snq6VXqzlqC9dt6T+KYPphA5TbFb+qVekoLSVwE
 1fMjEy3rV79tAvb6vKy4R6v9x5bGJ/OWPDe8sJ08P6jV8am33KPQbSsWykXLcjXtlVawGfancRt
 W4vUD6VndfI0cMQe10p6wNy4CB9VnGOy405bBuuJZb8AAZWC/m/X01jHzq3QJKkAK2m6Suzgno1
 3fxk50M/WWw8XZ8OhkRQzBZgkaWyx/LZ7CZ0cvkqhucRzC0E4xito+bYNN6+pdL8Xadq+luGF+Y
 3wpcKUHdlRTPeHttBPjeZpv81+NAo7m/GWC8APyf7LuEtYsaUj9xMkjyYuaaT38aN8JWzdIMDcC
 /XKfH17ZjP/B4cX7ZIYxX3jl2RSV/RZg+i2/Rp0HZjZf7rT7h3LH6fJm3fzBYtrJ14ULkrlmBrE
 +B6KBNe6t4TP//gI3cs/WuFruytLp9ymQStuynXR4XPVn/gKGsnIcm1IAJ9b+KcvhDj05OANMQ+
 5JOOMmcfxTJpogeJ/myIjvc1xwAIrZuiLtvfGJtt3t8IRqXYgP8UdGlJAtDdjO7XmIxQc0RqtsO
 1IYtovdipkULKjuDSRTwCL0oktPsK4htilsSHlpRZ1ESXK0RBdLx0xT4RYAO4hOqNzCtCcERL1v
 prQJj4QU/T9NHekwMKIFswE6/bQijrkDKq266J
X-Received: by 2002:a05:600c:8b34:b0:4a2:1364:252a with SMTP id
 5b1f17b1804b1-4bb559f7039mr161438575e9.3.1794742663121; 
 Sun, 15 Nov 2026 03:37:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ac0e1esm189193635e9.3.2026.11.15.03.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 03:37:42 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 11:37:42 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5099b109d43664d5b83adfded6adfaf5ae9d608f
X-Gerrit-Change-Number: 2099
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2099?usp=email>
X-Gerrit-Commit: 6fcbfb8b1b1575af361fd6132c73b0aaf38742ed
In-Reply-To: <gerrit.1793686929000.I5099b109d43664d5b83adfded6adfaf5ae9d608f@gerrit.openvpn.net>
References: <gerrit.1793686929000.I5099b109d43664d5b83adfded6adfaf5ae9d608f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjg2OTI5MDAwLkk1MDk5YjEwOWQ0MzY2NGQ1YjgzYWRmZGVkNmFkZmFmNWFlOWQ2MDhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8d6028ffcdaa79d8803b8a94c6c66afdd678b7b7-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSYYQ-000000007az-0hJi
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2383191723415729291=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2383191723415729291==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PHZzSlvzuPE="; charset=UTF-8

--PHZzSlvzuPE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2099?usp=3Demail )

Change subject: ssl_mbedtls: wipe private k=
ey password buffer after use
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

ssl_mbedtls: wipe private key password buffer after use

t=
ls_ctx_load_priv_file() left the private key password on the stack=2E
Clear=
 passbuf with secure_memzero() once the key has been parsed=2E

Change-Id: =
I5099b109d43664d5b83adfded6adfaf5ae9d608f
Signed-off-by: Razvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2099
Message-Id: <2=
0261114154843=2E1738-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41302=2Ehtml
Signed-o=
ff-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_mbedtls=
=2Ec
1 file changed, 2 insertions(+), 0 deletions(-)




diff --git a/src/o=
penvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index f4e142b=2E=2E43b=
b0ff 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=
=2Ec
@@ -486,6 +486,7 @@
             status =3D mbedtls_pk_parse_key(
    =
             ctx->priv_key, (const unsigned char *)priv_key_file, strlen(pr=
iv_key_file) + 1,
                 (unsigned char *)passbuf, strlen(passbuf=
));
+            secure_memzero(passbuf, sizeof(passbuf));
         }
     =
}
     else
@@ -496,6 +497,7 @@
             char passbuf[512] =3D { 0 };
 =
            pem_password_callback(passbuf, 512, 0, NULL);
             stat=
us =3D mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
+  =
          secure_memzero(passbuf, sizeof(passbuf));
         }
     }
     =
if (!mbed_ok(status))

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2099?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I5099b109d43664d5b83adfded6adfaf5ae9d608f
Gerrit-Change-Number: 2099
Gerr=
it-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>

--PHZzSlvzuPE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2099?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl_mbedtls: wipe private key pass=
word buffer after use<br><br>tls_ctx_load_priv_file() left the private key =
password on the stack=2E<br>Clear passbuf with secure_memzero() once the ke=
y has been parsed=2E<br><br>Change-Id: I5099b109d43664d5b83adfded6adfaf5ae9=
d608f<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Ac=
ked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2099<br>Message-Id: &lt;2026111415=
4843=2E1738-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archiv=
e=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41302=2Ehtml<br>Signed-o=
ff-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn=
/ssl_mbedtls=2Ec<br>1 file changed, 2 insertions(+), 0 deletions(-)<br><br>=
</pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtl=
s=2Ec</span><br><span>index f4e142b=2E=2E43bb0ff 100644</span><br><span>---=
 a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtl=
s=2Ec</span><br><span>@@ -486,6 +486,7 @@</span><br><span>             stat=
us =3D mbedtls_pk_parse_key(</span><br><span>                 ctx-&gt;priv_=
key, (const unsigned char *)priv_key_file, strlen(priv_key_file) + 1,</span=
><br><span>                 (unsigned char *)passbuf, strlen(passbuf));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            secure_memz=
ero(passbuf, sizeof(passbuf));</span><br><span>         }</span><br><span> =
    }</span><br><span>     else</span><br><span>@@ -496,6 +497,7 @@</span><=
br><span>             char passbuf[512] =3D { 0 };</span><br><span>        =
     pem_password_callback(passbuf, 512, 0, NULL);</span><br><span>        =
     status =3D mbedtls_pk_parse_keyfile(ctx-&gt;priv_key, priv_key_file, p=
assbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 secure_memzero(passbuf, sizeof(passbuf));</span><br><span>         }</span=
><br><span>     }</span><br><span>     if (!mbed_ok(status))</span><br></pr=
e><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
099?usp=3Demail">change 2099</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2099?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merge=
d </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I5099b109d43664d5b83adfded6adfaf5ae9d608f </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2099 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerri=
t-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--PHZzSlvzuPE=--


--===============2383191723415729291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2383191723415729291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2383191723415729291==--

