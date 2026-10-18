Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B641CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WOq+PpjYVZ8YInL+x/IuEtndbtVQRr6VKF09+O+koyk=; b=CfGlBQCxTaVhiM4s2CE6nT78zG
	gwGtk5X67yQzkuJ9klHUzF+hIAvbXi24KTAGLlrwAtLs19mhxsuhRfLZEl2la++W/rEBAWzbbjHB1
	BBir2MsxzMAkeKk41cu1srA9dtmXWIS8DS3qnqbaSUrGMKvGsq6Tpu5twMZJWLNG3xvI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIS2O-0001kr-Q8;
	Sun, 18 Oct 2026 14:38:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIS2O-0001kk-1m
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 14:38:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pbcuLGNvhNuCdH9z6ToVscaejZHgJJC9bdJm5ZcNinI=; b=MyJru069E5DHNYTTeObamZWy0K
 aAPTDobAt60CZ0miAG1ttBvj8H+5RHtnitoMvaN54yENMRyf2612oitFL1k2PW/Ga7tBhspD8jzqj
 HSfKX1xpt8F7K9fd7UcoUTMnqOWwxsWxDjLw0Qv43IdcapVDxC0YNAd5e3XaRFJTn9gY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pbcuLGNvhNuCdH9z6ToVscaejZHgJJC9bdJm5ZcNinI=; b=J
 VFM17thoujx3SfOWvVT1Tvn8uaE/Dc2Z811orKFUZUVO8LxV0jpjEb99PxdfIX4efI24RR14Cf0u9
 QxDFu1Xh3bYNoWuR1BC9du+il+a79/T6VXTcNh/nMsKZtCY40QcIwgoTwy9lakrUj/3+3hfkX9CiY
 AzWOFtlW/rTaW24E=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIS2K-00007l-Qx for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 14:38:57 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so883290f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 07:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792334330; x=1792939130; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pbcuLGNvhNuCdH9z6ToVscaejZHgJJC9bdJm5ZcNinI=;
 b=VPiCM9IMW6AaoWnC0l9uG9CvQeRefqAbkpLqhUlVJ3F4IXCybimXnrZ+2ZcZhdjSTG
 95Yh+VlLxayJM57sOcr4WY5kYiR+ZGq7bAraqRnjOkekNZqCU3s0shxnhgHTCq3Oi0Zx
 h48yOeamOiWvtA0TTi/3YIn5MChqXY+yYdNRpKfd1fJJRrfC7yztmpRuAaJfFlxy124o
 cG5j2NfGniQavmq6ER0zMHL5uCKA/oqULs4KYcNzYIwKlMTJReARe4ks+91AMkhVAoIU
 4bJTvYcNZleeG3NtIgEL4hnNyEuB0K7BKHYVUN77GskHQ4O5pAamV3KF6y0zKzxy1iMp
 3xSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792334330; x=1792939130;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pbcuLGNvhNuCdH9z6ToVscaejZHgJJC9bdJm5ZcNinI=;
 b=mchJ+aLYEL+G/B6zEc3x2oXvVLIq1icjvC9ZaqYT4r1bUfRxo5Yz9arvZOS6oMwa0f
 Y+uEjK1xUVTyXe6KcTWKyXzvR9gTePQxH3O/sxmdgo8T9A0Sbge7g6His2KV3S6s3pfF
 Qjuyutz/jAYhn+PuIn3IxRkfc0eQdHk9RKq6HxQcK/ANroCza+XoEY5f+F9wxTizlYQR
 w/gJKi02LL1KRsMqn6kxcfjR9uAgadM0VmIK6aEU54aOFc5OpEM/SqYFPEmvHgkDkCGU
 PoVzwpTjiCShNCOomoPquqxEKF7zq+1Kz5Q+JLFRRK+bwxXEJ64bERval+2su04by6JG
 xBhg==
X-Forwarded-Encrypted: i=1;
 AKwUvByYyq3VtLftqpZQfIRAmjYk8gNZLgzlwGvTkE1QzCb7Dj+3kCPXUL/pCpGhWZF4a1MmxLBFRNb3x/z24q3y@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKo0xd2+7ZqnBr1m4o/8s4Pq9w/03VxZLx4dGAVE5z1L5gMpsRC
 d3d0NKyslS59uqrP8GFxyp9HI9VeTQU5r4V4UZlIY3VngCiMbe8VvrhCwFtQvr6xN5eujqM2B3Q
 b0JYYrYH/LMJRqS7drdhEcyyN2Z8cisVQrjlHHJMIC5KXm5zKeiRA1G5BYQMw/przqjm/
X-Gm-Gg: AYBFou3OpzG/EnYHqQfCEdCLg6JV6g6YvSbrHKIf4KcuTrx2QYp1jLU754jKCGB1rjg
 qwX0WDg8BPnp1Yri4rTJROZ4jpcyZ2nmQy/uhLVPAQOxMpJ5AmpsDkYGKdYh7l0JS/ndrDLdHyf
 7Sbh4sgGdmhL4DkDC4CgH8ABBnybC679bFvt6JeS6zgMozko1iC0GIPPBqzuajdPDm5qIXGFAO6
 JmJEHb+rxL75ogqmQPMrSMZ34u/27P0PTGZF7S0bnFuzlxfPlmjPBEo/ezlGnWrZtTAvcJsA1gy
 mJokUYXE61bC/wVhkMgm9dSqXc6UI4Q2ZLNv1M9nVzFSzEkYe7Ad4rSRbr4sEpA76LZXeiYU5SN
 u735NSJeM6WVi6Y79lHBQjlBaKlPA+etMfYH+le+3KNMQ5dkSpnPUuQFKLJv9lhDd9VKaJ3QBmU
 kiFGX9hHQbfhin4levY4ERIGLaeY/xX4YzrcUXxLevEVVMXu1rB70z+QlILpm48KzaOy/s/epbr
 eTpiFGvDxgDQZXEZPHkYMT7x4hjAiwy/raAxETVfpW63HYs2pxCcKAErsU2t56ZRFPI1qMdCuJq
 35G3c7oVd1dkAb6WjskkZXVUEABKGrRRLtN8SYIboiC5dOCUZ0jOAR629vwO
X-Received: by 2002:a05:6000:4918:b0:48d:f02e:f7cc with SMTP id
 ffacd0b85a97d-48e07f9904cmr9732583f8f.24.1792334330084; 
 Sun, 18 Oct 2026 07:38:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4e7889sm17273897f8f.24.2026.10.18.07.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 07:38:47 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 14:38:47 +0000
To: Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3513563f199e1c5ac98219a527695e40540a9f73
X-Gerrit-Change-Number: 2009
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2009?usp=email>
X-Gerrit-Commit: 1b0bd8c6f60df96356e956b9982550902a622c5a
In-Reply-To: <gerrit.1792274029000.I3513563f199e1c5ac98219a527695e40540a9f73@gerrit.openvpn.net>
References: <gerrit.1792274029000.I3513563f199e1c5ac98219a527695e40540a9f73@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjc0MDI5MDAwLkkzNTEzNTYzZjE5OWUxYzVhYzk4MjE5YTUyNzY5NWU0MDU0MGE5ZjczQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c0686331cbca9285fd15b6767db237cc9d38a73f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIS2K-00007l-Qx
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: gen-sample-keys.sh:
 Don't apply server extensions to CSRs
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4811165850343609670=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4811165850343609670==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hlSwx9eeFO4="; charset=UTF-8

--hlSwx9eeFO4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2009?usp=3Demail )

Change subject: gen-sample-keys=2Esh: Don't=
 apply server extensions to CSRs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

gen-sample-keys=2Esh: Don't apply server extensions to =
CSRs

Newer OpenSSL versions refuse to add authorityKeyIdentifier with
issu=
er:always to a CSR, since there is no issuer certificate yet=2E The
extensi=
ons are already applied when signing with 'openssl ca', so drop
them from t=
he 'openssl req' calls=2E

Change-Id: I3513563f199e1c5ac98219a527695e40540a=
9f73
Signed-off-by: Steffan Karger <steffan@karger=2Eme>
Acked-by: Razvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2009
Message-Id: <20261018070320=2E15749-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg39973=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M sample/sample-keys/gen-sample-keys=2Esh
1 file changed, 1 inse=
rtion(+), 3 deletions(-)




diff --git a/sample/sample-keys/gen-sample-key=
s=2Esh b/sample/sample-keys/gen-sample-keys=2Esh
index fa5f697=2E=2Ee5a11f5=
 100755
--- a/sample/sample-keys/gen-sample-keys=2Esh
+++ b/sample/sample-k=
eys/gen-sample-keys=2Esh
@@ -31,7 +31,7 @@
     -config openssl=2Ecnf
 
 # =
Create server key and cert
-openssl req -new -nodes -config openssl=2Ecnf -=
extensions server \
+openssl req -new -nodes -config openssl=2Ecnf \
     -=
keyout sample-ca/server=2Ekey -out sample-ca/server=2Ecsr \
     -subj "/C=
=3DKG/ST=3DNA/O=3DOpenVPN-TEST/CN=3DTest-Server/emailAddress=3Dme@myhost=2E=
mydomain"
 openssl ca -batch -config openssl=2Ecnf -extensions server \
@@ =
-66,7 +66,6 @@
 openssl dsaparam -out sample-ca/dsaparams=2Epem 2048
 
 ope=
nssl req -new -newkey dsa:sample-ca/dsaparams=2Epem -nodes -config openssl=
=2Ecnf \
-    -extensions server \
     -keyout sample-ca/server-dsa=2Ekey =
-out sample-ca/server-dsa=2Ecsr \
     -subj "/C=3DKG/ST=3DNA/O=3DOpenVPN-T=
EST/CN=3DTest-Server-DSA/emailAddress=3Dme@myhost=2Emydomain"
 openssl ca -=
batch -config openssl=2Ecnf -extensions server \
@@ -82,7 +81,6 @@
 openssl=
 ecparam -out sample-ca/secp256k1=2Epem -name secp256k1
 
 openssl req -new=
 -newkey ec:sample-ca/secp256k1=2Epem -nodes -config openssl=2Ecnf \
-    -=
extensions server \
     -keyout sample-ca/server-ec=2Ekey -out sample-ca/s=
erver-ec=2Ecsr \
     -subj "/C=3DKG/ST=3DNA/O=3DOpenVPN-TEST/CN=3DTest-Ser=
ver-EC/emailAddress=3Dme@myhost=2Emydomain"
 openssl ca -batch -config open=
ssl=2Ecnf -extensions server \

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2009?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I3513563f199e1c5ac98219a527695e40540a9f73
Gerrit-Change-Number: =
2009
Gerrit-PatchSet: 2
Gerrit-Owner: Steffan Karger <steffan@karger=2Eme>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>

--hlSwx9eeFO4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2009?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">gen-sample-keys=2Esh: Don&#39;t ap=
ply server extensions to CSRs<br><br>Newer OpenSSL versions refuse to add a=
uthorityKeyIdentifier with<br>issuer:always to a CSR, since there is no iss=
uer certificate yet=2E The<br>extensions are already applied when signing w=
ith &#39;openssl ca&#39;, so drop<br>them from the &#39;openssl req&#39; ca=
lls=2E<br><br>Change-Id: I3513563f199e1c5ac98219a527695e40540a9f73<br>Signe=
d-off-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>Acked-by: Razvan Co=
jocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2009<br>Message-Id: &lt;20261018070320=2E15749-1-gert@g=
reenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg39973=2Ehtml<br>Signed-off-by: Gert Doering =
&lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M sample/sample-keys/gen-sample-k=
eys=2Esh<br>1 file changed, 1 insertion(+), 3 deletions(-)<br><br></pre>
<p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/sample/sample-keys/gen-sample-keys=2Esh b/sample/sample-keys/=
gen-sample-keys=2Esh</span><br><span>index fa5f697=2E=2Ee5a11f5 100755</spa=
n><br><span>--- a/sample/sample-keys/gen-sample-keys=2Esh</span><br><span>+=
++ b/sample/sample-keys/gen-sample-keys=2Esh</span><br><span>@@ -31,7 +31,7=
 @@</span><br><span>     -config openssl=2Ecnf</span><br><span> </span><br>=
<span> # Create server key and cert</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-openssl req -new -nodes -config openssl=2Ecnf -extensions ser=
ver \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openssl req -n=
ew -nodes -config openssl=2Ecnf \</span><br><span>     -keyout sample-ca/se=
rver=2Ekey -out sample-ca/server=2Ecsr \</span><br><span>     -subj &quot;/=
C=3DKG/ST=3DNA/O=3DOpenVPN-TEST/CN=3DTest-Server/emailAddress=3Dme@myhost=
=2Emydomain&quot;</span><br><span> openssl ca -batch -config openssl=2Ecnf =
-extensions server \</span><br><span>@@ -66,7 +66,6 @@</span><br><span> ope=
nssl dsaparam -out sample-ca/dsaparams=2Epem 2048</span><br><span> </span><=
br><span> openssl req -new -newkey dsa:sample-ca/dsaparams=2Epem -nodes -co=
nfig openssl=2Ecnf \</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   -extensions server \</span><br><span>     -keyout sample-ca/server-dsa=
=2Ekey -out sample-ca/server-dsa=2Ecsr \</span><br><span>     -subj &quot;/=
C=3DKG/ST=3DNA/O=3DOpenVPN-TEST/CN=3DTest-Server-DSA/emailAddress=3Dme@myho=
st=2Emydomain&quot;</span><br><span> openssl ca -batch -config openssl=2Ecn=
f -extensions server \</span><br><span>@@ -82,7 +81,6 @@</span><br><span> o=
penssl ecparam -out sample-ca/secp256k1=2Epem -name secp256k1</span><br><sp=
an> </span><br><span> openssl req -new -newkey ec:sample-ca/secp256k1=2Epem=
 -nodes -config openssl=2Ecnf \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    -extensions server \</span><br><span>     -keyout sample-ca/s=
erver-ec=2Ekey -out sample-ca/server-ec=2Ecsr \</span><br><span>     -subj =
&quot;/C=3DKG/ST=3DNA/O=3DOpenVPN-TEST/CN=3DTest-Server-EC/emailAddress=3Dm=
e@myhost=2Emydomain&quot;</span><br><span> openssl ca -batch -config openss=
l=2Ecnf -extensions server \</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2009?usp=3Demail">change 2009</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2009?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I351356=
3f199e1c5ac98219a527695e40540a9f73 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 2009 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;ste=
ffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--hlSwx9eeFO4=--


--===============4811165850343609670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4811165850343609670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4811165850343609670==--

