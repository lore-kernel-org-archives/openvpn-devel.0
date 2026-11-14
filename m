Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27F7606A330
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b4eaR7mO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UNQOT7mA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bcVWZE8v;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Z7e8bBO0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PfD+LQ3ycLpNcpn+H5xTqwuKXlNLMCMevf5O5eVRDKw=; b=b4eaR7mOkVVasoJaST7sjEhm+i
	K/fxZenuKqzcouZxwaux08VrOupKCiJZeA4aKekcvUmIFrxWluK5NCjXTFbIPJAbH5U2fr6YLVSFT
	RGKKy9lD7HRxM7zbL94nOH6Vp9vDxZAeF8OHA8M4JVG+ENYR5JCZlwW5Vvz1ovQhP9ms=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGTw-000000003qe-2G12;
	Sat, 14 Nov 2026 16:20:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSGTv-000000003qX-0yWw
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:19:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OUbaDa2PnXiJX7Eu/w0CvYwaJBoBY4aZENFZEIXezYk=; b=UNQOT7mAEoTgCW+8V4URLnftD0
 LDywVk0JP55bPygtx9KT1KCAjw7FtsZABdD94omlC9RWNLjVXzStk5A80XoRDopCzAjmElflrTbfp
 B538t/Vwiuovlds4Irm291GTJvhsjLQ/vP6YzrvVmpROJ/s9u8sgkiitC8S+SegGy37U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OUbaDa2PnXiJX7Eu/w0CvYwaJBoBY4aZENFZEIXezYk=; b=bcVWZE8v4wn6DiS214pF6mYp5J
 pJo3RFOkZTiFvpTtqc11gtDljD61RRx3nrtDjH8zQf7RdP7mNC/TVZSkpZsSO3G6Q65LFg7l5+OK3
 Y5wFERDGLZbbzy+HHQiH0DhWulGx/dS9oFa7jXfYjMkDL9p1cS3TbGCwRkw9JsFax+Sg=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSGTu-000000001fL-1p11 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:19:59 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso11898365e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 08:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794673192; x=1795277992; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OUbaDa2PnXiJX7Eu/w0CvYwaJBoBY4aZENFZEIXezYk=;
 b=Z7e8bBO0zWaEqeZsd8OlbUXWwsoWChi7in57SSpxm0kkQECCZlhY8NZ5BEugTstvLL
 jnY2/ox3TBEXtiuPyaAHlUK5cOFXf0pbqqtxh3nnpdlC0HChKMg1zwUfId6cttGcsvSM
 ZTYaIZ7FixDjxEYI9owPuHna/1JhvXJ4/LGPExXlbNOVq4AQGH9iCe06VJcibpbnbs8e
 F1vcpoazpxily2h9elP7tro3pOG+OzZO59WoTcAIjs7zwViugXwQZYO/0090hnRY2efL
 Zx/N+MjNRcX+V0hekPb0gRt8d2tNTUgvwpp1SD3MIUePDBQPHnFNPlbWAhshIulfkNlk
 c4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794673192; x=1795277992;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OUbaDa2PnXiJX7Eu/w0CvYwaJBoBY4aZENFZEIXezYk=;
 b=Vz+JpHetdHANxxgOo6S6dpjkWDlMK3bJWQEh3z82Ho4SG6HJZsK7grUPfjNv7VeN9M
 sE1gKmIgz5so7cNrtv8SrAqjKAV+obmr5C3Jc2ER0L7rdn0HytG84f1fRl8X2oZA0Aio
 nXCdIvvvN7jWixbYow0HqO4i5XMmrt3haVaq4b77Kv2rz7pAPzX0naSyfdsv6GDemzoR
 lJuYoL7kcGBzvKcc/qKSFjt9Gx1mMuj5CUjQOdEAGWOqIvnQcZInDhWg/ppi2fKeStUw
 ozfI2pqEcexYU5OC+ZkcK3gpuVHeD2o+bs/0P2f8p2RHJ5XcFCRBH1jstl/mN8IfjZwZ
 IY0g==
X-Forwarded-Encrypted: i=1;
 AL+hErFYOTyn/2OUkpG5tleOANjDvnDtlWS2vvFap5PqR5Ve2+Dc0Fdke+rd1lRbGsneqXQ8Bedcp0l3s5TjKx15@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/49buEMaE430LVoCkOAFFulfDizBC7780Gk7CliBoBS43y6jOP
 M8eAHP5vjkK1kP/DL74Bls4DlqLHhGERxIZxIRCu/QBLtdqT2jlKSVWbvf21fGhh6A7991vDV1J
 aL69XQ5ZLcgNY7s+U+g+J3lQJzUl8usPo/LhVVsNWnfNPYdpxQXcY/fU5v4SyMTA+KfX6
X-Gm-Gg: AYBFou148SJIbzzsVbkslS0lkuH4Oo23WYYQ9hoAs5fgL/wrdgMYTlq6Yq9p0WJviW9
 aph4/VOm8XMl/lsGNQ0DPB0TtX5bVodpJLBR4JagvejsTOK6Ss5KWcFtYIe6nNadlFifIaUPg5i
 NSq47Ma567ZwkdP7IJ/UH8jbciwlRLwGyrvhWI15llYoqrs1zmpJ1ExSttfof7wweRLm5GPb21P
 oV4II56wnz7+NGBFA0TDy311drKntaN1as/UqKoQO5ZWYLxhgZcz/6LnawB+jPDk6zNwkii4WGt
 zTOV8JfaiuD/t20pyWtrIDXT1kEyN7pnhzm+xuLxJPpMCe99Nad7E5CbPyoGszYfAHg0P7n6Ut4
 n+LP05r853Wb8mvc1tZMlPynTxH8bnxrIQ6ExIUPnshSCvH6fykW6YvcNdfso1z+K0sIrv6IAbC
 EVvEUJV37uF9jkLUJlnBC3PXZUWBHS5FSaormAcwoY78iCrNg7v/RNZAcyQjamIPvg1zCKcny2G
 R3aGEs20GGYYLZALqTzjc0kMmML0C646VheICGO59sajuN86v7si7AHrOp9kGjAmk7GlW0zRGEM
 oypWU3wFQiRUgLGSD8UjhkagHK3RQ0wVAzjGUm6q3Bb/t03sXnQ8pNO9p/zROf8+ZxZFsc0y9L8
 uc71GtkMgCxo1Ue+IAOaIlt2lwTz5nf8LXjRwjmt5PGeTzPH66iA264ZHmhFBL19yJlhRWRiIKE
 v88D+yevvOuPZ5Krw=
X-Received: by 2002:a05:600c:6096:b0:4bb:5de1:e923 with SMTP id
 5b1f17b1804b1-4bb5de1f26dmr78105035e9.4.1794673191695; 
 Sat, 14 Nov 2026 08:19:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55a0ffcdsm139117005e9.0.2026.11.14.08.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:19:51 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 16:19:51 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icab02b28773a409821fa9b80ccb1560d2796d1df
X-Gerrit-Change-Number: 2117
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2117?usp=email>
X-Gerrit-Commit: 3c687de340436e0c6d516df73379ee993782d13e
In-Reply-To: <gerrit.1793776420000.Icab02b28773a409821fa9b80ccb1560d2796d1df@gerrit.openvpn.net>
References: <gerrit.1793776420000.Icab02b28773a409821fa9b80ccb1560d2796d1df@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2NDIwMDAwLkljYWIwMmIyODc3M2E0MDk4MjFmYTliODBjY2IxNTYwZDI3OTZkMWRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a5a54d8843247b81c8cc5cd40687f1716549f65f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSGTu-000000001fL-1p11
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tls_crypt: print
 tls-crypt-v2 client key hint before CRYPT_ERROR
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
Content-Type: multipart/mixed; boundary="===============6699534717789167852=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6699534717789167852==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K5V4XYowesw="; charset=UTF-8

--K5V4XYowesw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2117?usp=3Demail )

Change subject: tls_crypt: print tls-crypt-=
v2 client key hint before CRYPT_ERROR
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

tls_crypt: print tls-crypt-v2 client key hint bef=
ore CRYPT_ERROR

CRYPT_ERROR() jumps to error_exit, so the hint about a cli=
ent key
generated for a different server key was never printed=2E Log it fi=
rst,
and drop a stray ')' from it=2E

Broken since 7a477c16 ("Print a more =
user-friendly error when
tls-crypt-v2 client auth fails")=2E

Change-Id: Ic=
ab02b28773a409821fa9b80ccb1560d2796d1df
Signed-off-by: Razvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2117
Message-Id: <202=
61104122103=2E15637-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40810=2Ehtml
Signed-of=
f-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/tls_crypt=2E=
c
1 file changed, 2 insertions(+), 2 deletions(-)




diff --git a/src/open=
vpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 08d9fcd=2E=2E64db29f 10=
0644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -49=
3,9 +493,9 @@
     {
         dmsg(D_CRYPTO_DEBUG, "tag      : %s", format_=
hex(tag, sizeof(tag_check), 0, &gc));
         dmsg(D_CRYPTO_DEBUG, "tag_ch=
eck: %s", format_hex(tag_check, sizeof(tag_check), 0, &gc));
-        CRYPT=
_ERROR("client key authentication error");
         msg(D_TLS_DEBUG_LOW, "T=
his might be a client-key that was generated for "
-                       =
      "a different tls-crypt-v2 server key)");
+                           =
  "a different tls-crypt-v2 server key");
+        CRYPT_ERROR("client key =
authentication error");
     }
 
     if (BLENZ(&plaintext) < sizeof(client=
_key->keys))

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2117?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: mer=
ged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icab02b=
28773a409821fa9b80ccb1560d2796d1df
Gerrit-Change-Number: 2117
Gerrit-PatchS=
et: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Rev=
iewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>

--K5V4XYowesw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2117?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">tls_crypt: print tls-crypt-v2 clie=
nt key hint before CRYPT_ERROR<br><br>CRYPT_ERROR() jumps to error_exit, so=
 the hint about a client key<br>generated for a different server key was ne=
ver printed=2E Log it first,<br>and drop a stray &#39;)&#39; from it=2E<br>=
<br>Broken since 7a477c16 (&quot;Print a more user-friendly error when<br>t=
ls-crypt-v2 client auth fails&quot;)=2E<br><br>Change-Id: Icab02b28773a4098=
21fa9b80ccb1560d2796d1df<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2117<br>Message=
-Id: &lt;20261104122103=2E15637-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4081=
0=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>=
---<br>M src/openvpn/tls_crypt=2Ec<br>1 file changed, 2 insertions(+), 2 de=
letions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/tls_crypt=2Ec b/src/op=
envpn/tls_crypt=2Ec</span><br><span>index 08d9fcd=2E=2E64db29f 100644</span=
><br><span>--- a/src/openvpn/tls_crypt=2Ec</span><br><span>+++ b/src/openvp=
n/tls_crypt=2Ec</span><br><span>@@ -493,9 +493,9 @@</span><br><span>     {<=
/span><br><span>         dmsg(D_CRYPTO_DEBUG, &quot;tag      : %s&quot;, fo=
rmat_hex(tag, sizeof(tag_check), 0, &amp;gc));</span><br><span>         dms=
g(D_CRYPTO_DEBUG, &quot;tag_check: %s&quot;, format_hex(tag_check, sizeof(t=
ag_check), 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        CRYPT_ERROR(&quot;client key authentication error&quot;);</span>=
<br><span>         msg(D_TLS_DEBUG_LOW, &quot;This might be a client-key th=
at was generated for &quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                             &quot;a different tls-crypt-v2 server ke=
y)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                    &quot;a different tls-crypt-v2 server key&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        CRYPT_ERROR(&quot=
;client key authentication error&quot;);</span><br><span>     }</span><br><=
span> </span><br><span>     if (BLENZ(&amp;plaintext) &lt; sizeof(client_ke=
y-&gt;keys))</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2117?usp=3Demail">change 2117</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2117?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Icab02b28773a409821fa9b=
80ccb1560d2796d1df </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2117 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--K5V4XYowesw=--


--===============6699534717789167852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6699534717789167852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6699534717789167852==--

