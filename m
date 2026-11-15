Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB04606A31E
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Rkpv5xms;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KutZwjGP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FA3OyaKH;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=D15VSakD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pxrfsqKUynAI1dLBHU8EJ3ykfFkO+z+SFIS6aOhsB60=; b=Rkpv5xmsyiNYPwE/zuqejqkefv
	A1wJb44ZpjGnptbg7iw7G0dT8BJJcG6c4OCXS4fiQaR4PlYl5pffI9Th5tNftYNGus5l7qiuiZ0RB
	6H9ScorXXcOGfJaja6rPE6FwAy0lM1wRRxIa3Rr40NBOs9JhU8tUqYbJ4UYPVG2sHFhI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSaZl-000000008Or-1B4Z;
	Sun, 15 Nov 2026 13:47:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSaZj-000000008Of-4AWy
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 13:47:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rYdlNbkjiLQk6imtU4XU3zXqZTCpy4QTctT1u5vNtLI=; b=KutZwjGP6cF8pjcZtZQZgrvb/J
 EWO4L4mpUNOjfc75WdfaYaZypyJcfvwEUEpXUd0pUYf07aVzPAyVGn51IQq0KZU4rNUqLBsqWBTKy
 W4zG41dbCLSuLG18NaO9fTOYvvRwfpT27XD4IrJz2VlaE5vM+JL7zaZagMUGQSwUTWOY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rYdlNbkjiLQk6imtU4XU3zXqZTCpy4QTctT1u5vNtLI=; b=FA3OyaKH2AD5AWzoLbWhzB0gag
 8x35LwZugkR1Nbt1VOmIz5DwZiv40sbKy68Q2qhFeFO0JyF6IRlOaRpR5MlO4gkY+nlZTAyDSf1lx
 FY4MM2N7gMeW7aipdAcNK90b1ZDDFQVqlMdeN5P3cZSFLStYqBpCMcHC0AwSKUcQ5hhQ=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSaZi-000000001H4-2QEO for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 13:47:19 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a14so7876675e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 05:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794750432; x=1795355232; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rYdlNbkjiLQk6imtU4XU3zXqZTCpy4QTctT1u5vNtLI=;
 b=D15VSakDw9c1x1rtQlkv6FxwjV2KfLJLyZL7TwTSQ2Dv/Pys+PAkeTxiQTxW2VoaaB
 AEDteJw3IyD/3eji9FQ1wFckBqEYG+gcuHgQ+yE2MDvIAlF8DpfDZ0BB1YuaCU9NP3JH
 1cgD55UwmFgiJA7z17L7KmDBC6oQYstsybd/sTtVee5UhexmmmXdkx0d9ktmgUEKHoH1
 nSknseq4IOeGT4a3UQ0fU+eKGq6bLUik3kXdMaB1XHErfRoP/hpbvR2dzGeKXe+uYxw8
 2UYaJXWI0pXOOASHfp7r6ZbrZu8rI7SNgbokrZOHH59A7p0jjqJxxTtI72zKWjii4RjD
 1zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794750432; x=1795355232;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rYdlNbkjiLQk6imtU4XU3zXqZTCpy4QTctT1u5vNtLI=;
 b=DwyKF6K0xD8gRjKWGve4IU3hDMewbmor3OZez84y03C2N1o6St0+5z+rlfFdpWcFwp
 WTnt27NmII+v3e42qP0Lh9rhT2ykYRk9MH+CficyQSFyVrDRLxm4NShnMhKG7EGFULQ/
 Jn6if3VXE83fmDavbitSMTmXMm9r5zQO2WP0rHD+2ssvCamVhuAj7XFj8pTqiBYAPzbu
 6GuP1ldW/u/6qHeFT/5+kTU0mwCWAuEe6v50SW6UUcweFO9tuPsOP/sezS3jd3wgaMyv
 QbBArs7pGaZPmV9rCviXyncDiyw/F0QmUA9vLCAEwrc8ef7C1EPJzylM8tAlXcIQdDwB
 YMLw==
X-Forwarded-Encrypted: i=1;
 AL+hErGBmrolvXP0IcdlByKfTcTk2rlhQkr2lzzae9EVfWXMa5+FchOqu2SteP3JPfoJ0Cl8kpBkNkt8QM+gfrU7@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+hjy2j5slIusAkDgOjU3rjq2FUyWHVIJVh0QPZGfIiX2k5vLfe
 PIWE3BkfnnzGHU0o6XS3f9lVjQ3IOmEubCzMkPthI0omCmRLeind2Rh9k3u7vDphuSsgMcaZWuo
 vhw4oeKYR754jVUI1I0HMbFB68U+pJrdWRvDBgJmVwKAVTv4rMF17domAAsjODq3l9Q7Q
X-Gm-Gg: AYBFou29/cyfBoAxPL+/YJxBCNjBKg1moIv4mh3lFBVK0+T07R/7h5XgHYrxg/F0Cow
 NpYXKRbb20UMV4VqUSjMTZzk6wQ5fsm2aKITkj2adw5TTmdTlYpOlYFUhE4TyDPzDCiqRU1QVGL
 DZHntSOILu//w6nYf7z0mpudAe9o8/rTQmzsJn5oZK4si5cZqUctlkJS/FMIY77N2S4CjzWYsJ7
 25jJpGDqlKPHR6flaHgmAumxl46OwkvB1PiPFstfKZsfjr06qsPJfsiMF9Q2WuuzCpK6RRzFTO3
 s3/yUsqHB+XuFHUxbSfsEIzPcyyZCMj1cviF/87IoPt84UGs0NGbcOGR0UEFRAZWuT/W2ZJuYu0
 9owbAaCu7AWmIj6a/vXkDjdIIBKZsQxLk6BlaAaN+ktiOauvlc5jVTVa6vcFcQJJApXFH6Htlys
 64KaPLG3ZCmw7b/Vyw5VFDpzwSb2tXf38k1tqp4Z1xsmYKkn7YhbrVyHu87gBbjRZMj9hPdvFt3
 u8kfguhNDt3IPq40GhNfFjuFMyI7Hfb7MGiOG1BJDVnD7wFnHzsYGcJbEbWwwbnKLKtbPconqyP
 FOziBJcoeqp07umlqGlp+imdwOOc4RqMBtZmG2ZyqW8mIU5vXqjjA7ay3Q4VMffKYY2hBrIHIIU
 R3LImbNZy5zs1G39lRN14LUGgGuoKutcQsthSeWn6tAvdBilJE9bVJvV/5spFzI4nJjG8qCmKBR
 S1uUR1fEu5N+eGNm9V6z7VCxzyh8Jkl2/pC4Ag
X-Received: by 2002:a05:600c:4e16:b0:4a2:729:f7ce with SMTP id
 5b1f17b1804b1-4bb55a47429mr166148295e9.8.1794750431807; 
 Sun, 15 Nov 2026 05:47:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb6f7ff527sm16476295e9.1.2026.11.15.05.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 05:47:11 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 13:47:10 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I387f652ecba92283a272610ff0780273c4902996
X-Gerrit-Change-Number: 2183
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2183?usp=email>
X-Gerrit-Commit: 09eb959c29b4cd3efc8b565529c965895fcb14cd
In-Reply-To: <gerrit.1794571077000.I387f652ecba92283a272610ff0780273c4902996@gerrit.openvpn.net>
References: <gerrit.1794571077000.I387f652ecba92283a272610ff0780273c4902996@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NTcxMDc3MDAwLkkzODdmNjUyZWNiYTkyMjgzYTI3MjYxMGZmMDc4MDI3M2M0OTAyOTk2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <335cb35c50b6919160027721aae56d1d93197065-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSaZi-000000001H4-2QEO
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_openssl: free
 what PKCS12_parse() returns
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
Content-Type: multipart/mixed; boundary="===============8360923381619405574=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8360923381619405574==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xLc4A1lzgNo="; charset=UTF-8

--xLc4A1lzgNo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2183?usp=3Demail )

Change subject: ssl_openssl: free what PKCS=
12_parse() returns
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

ssl_openssl: free what PKCS12_parse() returns

tls_ctx_load_pkcs12(=
) never released its references to the
certificate, key and CA stack, leaki=
ng them on every SSL context
setup=2E The context takes its own references,=
 except for extra chain
certificates, which it takes over=2E

Change-Id: I3=
87f652ecba92283a272610ff0780273c4902996
Signed-off-by: Razvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2183
Message-Id: <202=
61113161309=2E24472-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41268=2Ehtml
Signed-of=
f-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_openssl=
=2Ec
1 file changed, 5 insertions(+), 0 deletions(-)




diff --git a/src/o=
penvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 035cfb8=2E=2Ee19=
0935 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=
=2Ec
@@ -1025,6 +1025,7 @@
                 }
             }
         }
+  =
      sk_X509_pop_free(ca, X509_free);
     }
     else
     {
@@ -1045,7 +=
1046,11 @@
                 }
             }
         }
+        /* the cer=
ts now belong to ctx */
+        sk_X509_free(ca);
     }
+    X509_free(ce=
rt);
+    EVP_PKEY_free(pkey);
     return 0;
 }
 

-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2183?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I387f652ecba92283a272610ff0780273c4902996
Ge=
rrit-Change-Number: 2183
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--xLc4A1lzgNo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2183?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl_openssl: free what PKCS12_pars=
e() returns<br><br>tls_ctx_load_pkcs12() never released its references to t=
he<br>certificate, key and CA stack, leaking them on every SSL context<br>s=
etup=2E The context takes its own references, except for extra chain<br>cer=
tificates, which it takes over=2E<br><br>Change-Id: I387f652ecba92283a27261=
0ff0780273c4902996<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2183<br>Message-Id: &=
lt;20261113161309=2E24472-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41268=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/ssl_openssl=2Ec<br>1 file changed, 5 insertions(+), 0 deleti=
ons(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/open=
vpn/ssl_openssl=2Ec</span><br><span>index 035cfb8=2E=2Ee190935 100644</span=
><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/open=
vpn/ssl_openssl=2Ec</span><br><span>@@ -1025,6 +1025,7 @@</span><br><span> =
                }</span><br><span>             }</span><br><span>         }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sk_X509_pop=
_free(ca, X509_free);</span><br><span>     }</span><br><span>     else</spa=
n><br><span>     {</span><br><span>@@ -1045,7 +1046,11 @@</span><br><span> =
                }</span><br><span>             }</span><br><span>         }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* the cert=
s now belong to ctx */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        sk_X509_free(ca);</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    X509_free(cert);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    EVP_PKEY_free(pkey);</span><br><span=
>     return 0;</span><br><span> }</span><br></pre><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2183?usp=3Demail">change 21=
83</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2183?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I387f652ecba92283a272610ff0780273c4902996 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2183 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--xLc4A1lzgNo=--


--===============8360923381619405574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8360923381619405574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8360923381619405574==--

