Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855A8606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jPs4SR+t;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MWDJitNX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Q6ZglpqT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XTeL19xZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8ijP4S6dNauLUsMzeu8KmnVT2hxa3TcvkpSwDeg/HMo=; b=jPs4SR+t1d1MY6m2fz2QtGj/ox
	f8yq6O1Qvl32AGij/6r+qXNxYmhpq8YznZ5VlFaWPbjj/B0nxTBGiaRUT2vgFqP24cZPfRNM/dr58
	WIqwEvbwTtgLzsg6k8aLbwZcX2gjIA9IyiMzN3akk1O98QvT8Zzr7cbwB4oMsNsjcyXQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWVQp-000000004us-0xsg;
	Thu, 26 Nov 2026 09:06:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWVQn-000000004uc-2GvP
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:06:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4qevOfwtwm37jiHxTmwk+qr/gWay4CKwHfuY5gitCGE=; b=MWDJitNX1nlE2aDnF1t0KzVBNx
 K8rq3wNyYQNKuYUKTxeCsIQ9HkePPDAdZsUdEDX8rwcB0tvt5WD1mm9pZFsFFGy2djtB+AvUTtUmc
 4VAK5ukryJF9I3cZ4uTQR1i1hVJ1NwrPWS7hs01QQvdC7qHLsRPGil6lCL0bfg5L5s28=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4qevOfwtwm37jiHxTmwk+qr/gWay4CKwHfuY5gitCGE=; b=Q6ZglpqTolCtjhpLlp6I32SJfZ
 o3E53CkakcQz9b0SYkrPay4/duOmyGIqLrNvmWWPx19oFALjd+NtepC7CCG11hqB2HhfMtFQkxVJ3
 QJkEboZMLBaCJhI9KRORe0A5NIv+cRwPqri6sz6qQCgBkGVZQAhlwxxrqOjqE3Rp0QPw=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWVQl-0000000012J-1RQK for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:06:16 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4a357b1c649so3899889f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 01:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795683969; x=1796288769; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4qevOfwtwm37jiHxTmwk+qr/gWay4CKwHfuY5gitCGE=;
 b=XTeL19xZqpMuAc4rx4XIEEmLFZ/QAUY1rNbLDBkA+E44+q8qegV4JCzY+RWoRjqm5V
 BJ9VLK30j0wbKWaspV+/bWCzaF6njrkNzwpU6DIkpxjX20tApiTLY61BdiIxLxb1K6uF
 NLQwfVe1GUOcfwfrG9toVpPkLQvVtm5t3YN5E0xicW4xUTR6WpAQE52yeU9J/eBRWxzQ
 VFKYaM62NwXWZ3+KISv7TWxLVnkGApANaBjbyruoma3zDV1v5cgCAkXt+E5tjOj4Cnwi
 d4xWHJmMuHDeBZg8JopTpn7+SLCZexwn1ZQo9ar65ZAW/BiHoHnQynAuXT+4be8TPpRI
 XVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795683969; x=1796288769;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4qevOfwtwm37jiHxTmwk+qr/gWay4CKwHfuY5gitCGE=;
 b=IYZEeNFb+EcpNLdOs3Tj275dlUOFOACWlS4HsHEv20CTLk1s0jBrnO1wzqxh3TnkHl
 yzRRDpkTt6AutEqmf2qhWI89rfVDF2kARrAwVyagbMY4X9ZLe1qzFeEhFMvgJJ8LD5BY
 uhO0OF7OToG5RgbqbdFi1rjn9MLHQEYMtPu22y7b0Dcg8Co9Ta1DVJrHtGbFQxr6Zhim
 W+8CVG2MGhWDpT4y8J9pday6lAqMZCmZ05qOMeqAlIqmyp3AuXzI0N2St77Y9YQxuUyR
 yvi7+fg/AzGtfXuRHNYwJTbiWychy4cMnM/2QHg+Np18DNNFqT4ikZZ/NTqa2mGXVYvT
 Ew3Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFsfN0jeSCetoYG+vSIIMQEp6VPwjHvWFFns9To4Or1wJ84gqLSmUfck8UpvLvHNv8pYiWZx66xDuzyKPnk@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+Y2VdDlOqfjSQDaSNKeWqo5DOQ7lyJ/78a6AgVZT7i4ylfH9PV
 TY/VsdbEMf/qFyyXPO/hzQ/fg4/CkzFgrfLYY1A6R6PH7g7hxRr6vrZ6rrQOhe1/CbALUe2fLtF
 vFnwThM4Gtp3srCtv78c6RGmR7pstDtf7wBGwRQd5PLAl0px9wE5S7+nmXGcg1vcSyoxH
X-Gm-Gg: AZFdTZc448nWW2+TReo2D5zLn0VvUS5qCM3ETarIwHHDpWP/Tb1CX4ze1jHx/5QhJ4X
 vnA6QwCLUTfOr+3jFAHCl0CIvAbyJ/ngwCZmtJhLPGw4o+NQv5AGu4BL6zH+AJG4pHKR24/RnAL
 3PnTuJ6tlOb+qJ2cg5vfU3jtKESC/n4Y+yBRPKvBEH/nWLhGiK36cV2SCH6pQ4HKTrOvLxfK5Ys
 ZReUklgLz5U1I/KrNciCZC/qjT9c7cipkpQzLLqVfT+h+u3SebQTnIxdIQ0ltOGS+rtmIm8Vmgh
 iWUdPCvGiSMuSuwPsTdmC/o4w+ow+B/QTag7lo9/OKB18XkwG1dHyKWi23UD/wQFWgQDe7mTyuG
 HDE/xyZ2AuPgUwntpcGDFLkskqrLPY3wta//gipQ4pzjH8ffw9dZcCvVkzdRH+JjzTJLhktrWdd
 qmZJBwRWqLMG0hLvv0AOFMhNIZS476qA+/O8NeeDqnOlzqjUlsLRv6vT7tlzw6HhSO9W3mi0arU
 gUJzkgdA4S+sW7icIxKxKLJnj9p55WNeMjSJTP79nFl/n71ucM2mgBiJcSeZ6B2PVAuREPZuHSc
 4jWDAGFXVqspa7FzGXvL/U0U9drxsX8dk5JqvX+iu/8nnekLXjIZkvWgnq5utdRKc6lXYtH5+bA
 gFl0ymOvLL4afShpBgXDpiWSdQGrtbT01BMEA4n02XmRPp5JjKKrW6Vbn9QlKfzu8K2xwtV11im
 DqGvUEXfmMj0VbRTV6Twvw8scuLZ4jiYnWQXLU
X-Received: by 2002:adf:e010:0:20b0:4a8:647c:f965 with SMTP id
 ffacd0b85a97d-4abb348dae1mr29411548f8f.41.1795683968461; 
 Thu, 26 Nov 2026 01:06:08 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa3c4dsm33053903f8f.46.2026.11.26.01.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 01:06:08 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 09:06:07 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I9d9b658a00f95ffdcd0db9abd0d8907618925746
X-Gerrit-Change-Number: 2206
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2206?usp=email>
X-Gerrit-Commit: f043cea230691f41bb05367b871d3ebd3e17ef19
In-Reply-To: <gerrit.1794903672000.I9d9b658a00f95ffdcd0db9abd0d8907618925746@gerrit.openvpn.net>
References: <gerrit.1794903672000.I9d9b658a00f95ffdcd0db9abd0d8907618925746@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTAzNjcyMDAwLkk5ZDliNjU4YTAwZjk1ZmZkY2QwZGI5YWJkMGQ4OTA3NjE4OTI1NzQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <38112654fd2fabaed896c829128fc690c9cba083-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWVQl-0000000012J-1RQK
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Wipe auth token and
 PEM key copies before freeing them
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
Content-Type: multipart/mixed; boundary="===============0086018770720298001=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0086018770720298001==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FQGYM5azeNc="; charset=UTF-8

--FQGYM5azeNc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2206?usp=3Demail )

Change subject: Wipe auth token and PEM key=
 copies before freeing them
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Wipe auth token and PEM key copies before freeing them

ge=
nerate_auth_token() freed the previous token and its intermediate copies
wi=
thout wiping them, unlike wipe_auth_token()=2E crypto_pem_decode() in the
m=
bed TLS backend freed its copy of the PEM key text the same way=2E

Change-=
Id: I9d9b658a00f95ffdcd0db9abd0d8907618925746
Signed-off-by: Razvan Cojocar=
u <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2206
Message-Id=
: <20261125213012=2E15799-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41971=2Ehtml
Sig=
ned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/auth_t=
oken=2Ec
M src/openvpn/crypto_mbedtls=2Ec
2 files changed, 9 insertions(+),=
 1 deletion(-)




diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/au=
th_token=2Ec
index 261c7c2=2E=2Ed8e599b 100644
--- a/src/openvpn/auth_token=
=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -271,10 +271,15 @@
     ASSERT(buf=
_write(&session_token, b64output, strlen(b64output)));
     ASSERT(buf_writ=
e_u8(&session_token, 0));
 
+    secure_memzero(b64output, strlen(b64output=
));
     free(b64output);
 
     /* free the auth-token if defined, we will=
 replace it with a new one */
-    free(multi->auth_token);
+    if (multi-=
>auth_token)
+    {
+        secure_memzero(multi->auth_token, strlen(multi=
->auth_token));
+        free(multi->auth_token);
+    }
     multi->auth_t=
oken =3D string_alloc((char *)BPTR(&session_token), NULL);
 
     dmsg(D_SH=
OW_KEYS, "Generated token for client: %s (%s)", multi->auth_token, up->user=
name);
@@ -288,6 +293,8 @@
         multi->auth_token_initial =3D string_al=
loc(multi->auth_token, NULL);
     }
 
+    buf_clear(&token);
+    buf_cle=
ar(&session_token);
     gc_free(&gc);
 }
 
diff --git a/src/openvpn/crypto=
_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec
index ceaaad4=2E=2E58c1fd2 10=
0644
--- a/src/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/crypto_mbedtls=
=2Ec
@@ -1150,6 +1150,7 @@
     }
 
     mbedtls_pem_free(&ctx);
+    buf_c=
lear(&input);
     gc_free(&gc);
     return ret;
 }

-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2206?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I9d9b658a00f95ffdcd0db9abd0d8907618925746
=
Gerrit-Change-Number: 2206
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--FQGYM5azeNc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2206?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Wipe auth token and PEM key copies=
 before freeing them<br><br>generate_auth_token() freed the previous token =
and its intermediate copies<br>without wiping them, unlike wipe_auth_token(=
)=2E crypto_pem_decode() in the<br>mbed TLS backend freed its copy of the P=
EM key text the same way=2E<br><br>Change-Id: I9d9b658a00f95ffdcd0db9abd0d8=
907618925746<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit =
URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2206<br>Message-Id: &lt;202=
61125213012=2E15799-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41971=2Ehtml<br>=
Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src=
/openvpn/auth_token=2Ec<br>M src/openvpn/crypto_mbedtls=2Ec<br>2 files chan=
ged, 9 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/auth_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>index 261c7c=
2=2E=2Ed8e599b 100644</span><br><span>--- a/src/openvpn/auth_token=2Ec</spa=
n><br><span>+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ -271,10 +27=
1,15 @@</span><br><span>     ASSERT(buf_write(&amp;session_token, b64output=
, strlen(b64output)));</span><br><span>     ASSERT(buf_write_u8(&amp;sessio=
n_token, 0));</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    secure_memzero(b64output, strlen(b64output));</span><br><sp=
an>     free(b64output);</span><br><span> </span><br><span>     /* free the=
 auth-token if defined, we will replace it with a new one */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    free(multi-&gt;auth_token);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;auth_t=
oken)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        secure_memzero(multi=
-&gt;auth_token, strlen(multi-&gt;auth_token));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        free(multi-&gt;auth_token);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     mult=
i-&gt;auth_token =3D string_alloc((char *)BPTR(&amp;session_token), NULL);<=
/span><br><span> </span><br><span>     dmsg(D_SHOW_KEYS, &quot;Generated to=
ken for client: %s (%s)&quot;, multi-&gt;auth_token, up-&gt;username);</spa=
n><br><span>@@ -288,6 +293,8 @@</span><br><span>         multi-&gt;auth_tok=
en_initial =3D string_alloc(multi-&gt;auth_token, NULL);</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    buf_clear(&amp;token);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buf_clear(&amp;session_token);</span><br><span>     gc_free(&=
amp;gc);</span><br><span> }</span><br><span> </span><br><span>diff --git a/=
src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec</span><br><=
span>index ceaaad4=2E=2E58c1fd2 100644</span><br><span>--- a/src/openvpn/cr=
ypto_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtls=2Ec</span=
><br><span>@@ -1150,6 +1150,7 @@</span><br><span>     }</span><br><span> </=
span><br><span>     mbedtls_pem_free(&amp;ctx);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    buf_clear(&amp;input);</span><br><span>    =
 gc_free(&amp;gc);</span><br><span>     return ret;</span><br><span> }</spa=
n><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2206?usp=3Demail">change 2206</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2206?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I9d9b658a00f95ffdcd0db9abd0d8907618925=
746 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2206 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--FQGYM5azeNc=--


--===============0086018770720298001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0086018770720298001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0086018770720298001==--

