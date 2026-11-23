Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA73606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AhPR5002;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=b6NzazEW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=J4sg/sNQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gGZJky+s
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fUmjSWKeTA3F2STVXQp6nZDA+WCYZjsoPv4jpgPhrMk=; b=AhPR5002NtMqqnzIx5g/3Fgw+7
	fhffNbHt4GK+ibV2WMkQed2vKOyC7Z4Z3rA+xRC8Z54/H7bHpexg5zg5J1pGa9SZjdv98apL6fL/w
	aU7tqXbkLUyjpOxSFR2xhzgzHzSszKGZClNbWK05OtaRIDkrmdUHPX3ih1OOh6GVaJYA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVWcV-000000002Ys-1oAM;
	Mon, 23 Nov 2026 16:10:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVWcU-000000002Yf-05ni
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 16:10:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vb5+9Bpq4P47OvkyBGIvIactZzebKBZFSCwZBbzBS0Q=; b=b6NzazEWZv56N4wiuiv73+x4Pz
 IMRJNW7dqng0bHxuaLtoKIFGbYgyjN/c/OkHxxxFnrJHFQ1MGX3tuCBUA1NrRHBGI2zp2j+EURW3d
 Eu7b/MSeAuWOrL1SauugnAr9JvH7Z03PoO/V+YYigqF3rOH8Aw8tRaob2nA+EUZkWkzE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vb5+9Bpq4P47OvkyBGIvIactZzebKBZFSCwZBbzBS0Q=; b=J4sg/sNQrLZug/OHCXJgCub5qY
 6J8FV4+O0mBdHUUewph2DXrpL4DAFMUQ4UueyQ4KGpWEIVLHoUlqDqq+nrDv6OGA307Mh/DotQUc4
 eNmiZJYegxVN90d+n2JmDFUYQIW9EerEy0ZQkXFhrckCNuZCwmRxKeK6v7Tld0bW3IYE=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVWcS-000000007f2-1Xep for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 16:10:17 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so36426105e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 08:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795450210; x=1796055010; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vb5+9Bpq4P47OvkyBGIvIactZzebKBZFSCwZBbzBS0Q=;
 b=gGZJky+sgKpDlEURe+QY6mI8OCWk+rfNLc8RcOlpvoCgogy7+oqgHhYk7/yr3AvjZh
 dHvY/ERP14rXdkM307fS6UYtkfW80m2TwTgVJcSV8rFD70OJ2enA/T8AkkVuv25OffzW
 TMMPhacs4Dju3tY7RmvshIX93gHvInKyJa5BN+J2KTkQ5034ztCNfWRnN5jA83JMkwVD
 0bJvFHAcZHrQoG4n2y3LAkpcc5sQXfoviS0I9jv/z95/9kTx6wTQMeLs9butPz1KhgGD
 lQHMpW6Ij41T78frphlsx3QBDU/6yDI9Y3ql49AiqdiZapwIPXVq8BVg8yiBvtzGgvn6
 NDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795450210; x=1796055010;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vb5+9Bpq4P47OvkyBGIvIactZzebKBZFSCwZBbzBS0Q=;
 b=f1M0pxQJXPChVu6gxbEjWl7P6LwjstssrwBtmnZuSSepToM/Yoq8YTunjtPPipdxrl
 GmSJuMPw3/ITZKLFXhA5hlmCIJf34yPB0OLgsBClYJ76xQGJAwmkWJ82UVG7Zxmv7ugS
 I+OBaOEW+C0KBCgTuX0WBk5HuA7AabRdQrUC2Uc21iZxxuRw8RmACN6Bjd4sLYycY16N
 WCSmbtLodhsKbuUlfcH3dpJKaIaXDtWeqRin6BoogzQ1uwYEvQ0yyOZfbd6Dc498DKt4
 plEtSl5I5GUhw8q4X6rIfkYs+MivTOv03FSCZJeBH4Jm8N08LyCcRgBKVRsaQY5KsRmB
 4Nzg==
X-Gm-Message-State: APuU4Z+71+mTu9ZI/g/bRoDQjEf4eOCZuu/7t7OECkwyGjWlZEMnt60q
 UKBxr1ZN/3YtunW9djv0w1XCFMf0gzlEzeQAQIjFl6B3i8FXRVLPd0asAOvApfIxKRol3j4X7wO
 BQRbYrz9/YUfQHz2yxUvJRTdzp/r7UtqfMTco/Mw8ZpXkq5RO8qNlQQEWDfg7OnHPh7XGco9F8B
 63t855+Q==
X-Gm-Gg: AZFdTZeyml0shrO/i+hx1a0PVdHQ72kzXftwb9wvruVHGVEoL+TPexqWk9PCduqlKft
 s5NyuqmszGqf5cz0I+UwEoopD+UyKFn6s7u9/ruqyx7kHBN06oc9cx9WTDRGpFxkpMilF/8cFCG
 WyVTIOre6TcEJMDl9YZr0feTfJKYbSKVoUWNDNTknsmhhFN06plL2Dy1KdUNOExr7y5Bk3ISSd5
 fFjG+dFMG3hGym/Yq/m3ZeXkE07pzSE1G8dKoiD1+PWFPBpqC+MKTTyTVtx1FXkG5KbpPqag0UZ
 cvYhVL9tGGGQRMASMJnE1xLd+SZ7hepWUWjZDHvivnKcUEANFZjjbutlF8x/8xZAl6KDc3BRFvE
 /mnWaDb+uyeHtKNkwBFm6ckXd4lW6KRovZQDKnNJ/DhM6mEBD6DjbUtm0VE+Rl4MsBdt9+C+TV3
 qubMlM29UIGStXc6dGWoBCqZsIbd1g4liCLNS7pGGKgX6T5fT+NokOBG2LY0csMpiTyjfCABV5a
 P45K/e3nqOH3azp0zswRyUGyk/Ui6RS4urquQavJJEkC28H3JUO0i1rtQMrCbChIUWPtf2M8Y4J
 jeCkEPNWlKpcRWPm1Kwd9VJbF3EzkppEBYX6LM/UPB4rmEo4cRhZK0gQclcSERY02t4X5xFGVz1
 0ovl/AWmj0hUOGwQ2PGC4Y0Xv15XL5s16FgO489hGIkCm/5J13SehFJe5oSna0b7lcLeBhg4Icv
 jdrusgxxirVv4Gu/4=
X-Received: by 2002:a05:600c:a085:b0:4a5:26b8:4507 with SMTP id
 5b1f17b1804b1-4bb8881e6c6mr250228585e9.21.1795450209185; 
 Mon, 23 Nov 2026 08:10:09 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b8429sm563161905e9.14.2026.11.23.08.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 08:10:08 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 16:10:07 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I00b340f30dc3518994b74c49565736524b7df318
X-Gerrit-Change-Number: 2195
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2195?usp=email>
X-Gerrit-Commit: b091ec1e334d9e3fcf809775f4a359ed0e32fab8
In-Reply-To: <gerrit.1794834286000.I00b340f30dc3518994b74c49565736524b7df318@gerrit.openvpn.net>
References: <gerrit.1794834286000.I00b340f30dc3518994b74c49565736524b7df318@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM0Mjg2MDAwLkkwMGIzNDBmMzBkYzM1MTg5OTRiNzRjNDk1NjU3MzY1MjRiN2RmMzE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6cf29392498bfc02cf202a487d879c5d244b042d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVWcS-000000007f2-1Xep
Subject: [Openvpn-devel] [S] Change in openvpn[master]: gerrit-send-mail:
 Support user authentication
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6309237875671441915=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6309237875671441915==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3lk3e0/94lY="; charset=UTF-8

--3lk3e0/94lY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Gert=
 Doering=2E

Hello Arne Schwabe, Gert Doering, 

I'd like you to reexamine =
a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
95?usp=3Demail

to look at the new patch set (#2)=2E

The following approva=
ls got outdated and were removed:
Code-Review-1 by Gert Doering


Change su=
bject: gerrit-send-mail: Support user authentication
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

gerrit-send-mail: Support user aut=
hentication

Required for changes in private projects=2E

Change-Id: I00b34=
0f30dc3518994b74c49565736524b7df318
Signed-off-by: Frank Lichtenheld <frank=
@lichtenheld=2Ecom>
---
M dev-tools/gerrit-send-mail=2Epy
1 file changed, 2=
5 insertions(+), 6 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/95/2195/2

diff --git a/dev-tools/gerrit-send-mai=
l=2Epy b/dev-tools/gerrit-send-mail=2Epy
index ae904d5=2E=2Ed6e78a9 100755
=
--- a/dev-tools/gerrit-send-mail=2Epy
+++ b/dev-tools/gerrit-send-mail=2Epy=

@@ -18,10 +18,18 @@
 # Extract a patch from Gerrit and transform it in a f=
ile suitable as input
 # for git send-email=2E
 
+# Note: This generally wo=
rks without authentication since it only reads
+# information and doesn't c=
hange any state in Gerrit itself=2E
+# To access changes in projects that a=
re not viewable by anonymous
+# visitors set GERRIT_USER and GERRIT_PASS en=
vironment variables=2E
+# GERRIT_PASS can be a token as generated on your u=
ser settings page
+# under "HTTP Credentials"=2E
+
 import argparse
 import=
 base64
 from datetime import timezone
 import json
+import os
 import sys
=
 from urllib=2Eparse import urlparse
 
@@ -29,9 +37,11 @@
 import requests
=
 
 
-def get_details(args):
+def get_details(args, gerrit_api_url, auth):
 =
    params =3D {"o": ["CURRENT_REVISION", "LABELS", "DETAILED_ACCOUNTS"]}
-=
    r =3D requests=2Eget(f"{args=2Eurl}/changes/{args=2Echangeid}", params=
=3Dparams)
+    r =3D requests=2Eget(
+        f"{gerrit_api_url}/changes/{=
args=2Echangeid}", params=3Dparams, auth=3Dauth
+    )
     print(r=2Eurl)
=
     json_txt =3D r=2Etext=2Eremoveprefix(")]}'\n")
     json_data =3D json=
=2Eloads(json_txt)
@@ -76,9 +86,10 @@
     }
 
 
-def get_patch(details, ar=
gs):
+def get_patch(details, args, gerrit_api_url, auth):
     r =3D reques=
ts=2Eget(
-        f"{args=2Eurl}/changes/{args=2Echangeid}/revisions/{deta=
ils['revision']}/patch?download"
+        f"{gerrit_api_url}/changes/{args=
=2Echangeid}/revisions/{details['revision']}/patch?download",
+        auth=
=3Dauth,
     )
     print(r=2Eurl)
     patch_text =3D base64=2Eb64decode(=
r=2Etext)=2Edecode()
@@ -138,8 +149,16 @@
     parser=2Eadd_argument("-u", =
"--url", default=3D"https://gerrit=2Eopenvpn=2Enet")
     args =3D parser=
=2Eparse_args()
 
-    details =3D get_details(args)
-    patch =3D get_pat=
ch(details, args)
+    auth =3D None
+    gerrit_api_url =3D args=2Eurl
+  =
  if "GERRIT_USER" in os=2Eenviron:
+        gerrit_user =3D os=2Eenviron["=
GERRIT_USER"]
+        gerrit_pass =3D os=2Eenviron["GERRIT_PASS"]
+       =
 auth =3D requests=2Eauth=2EHTTPBasicAuth(gerrit_user, gerrit_pass)
+      =
  gerrit_api_url +=3D "/a"
+
+    details =3D get_details(args, gerrit_api_=
url, auth)
+    patch =3D get_patch(details, args, gerrit_api_url, auth)
  =
   apply_patch_mods(patch, details, args)
 
 

-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I00b340f30dc3518994b74c49565736524b7df318
Ge=
rrit-Change-Number: 2195
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering =
<gert@greenie=2Emuc=2Ede>
Gerrit-Attention: Frank Lichtenheld <frank@lichte=
nheld=2Ecom>

--3lk3e0/94lY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Gert Doering=2E </p>=

<p>Frank Lichtenheld <strong>uploaded patch set #2</strong> to this change=
=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review-1 by Gert Doering</p><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">gerrit-send-mail: S=
upport user authentication<br><br>Required for changes in private projects=
=2E<br><br>Change-Id: I00b340f30dc3518994b74c49565736524b7df318<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-to=
ols/gerrit-send-mail=2Epy<br>1 file changed, 25 insertions(+), 6 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/95/2195/2</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/gerrit-send-ma=
il=2Epy b/dev-tools/gerrit-send-mail=2Epy</span><br><span>index ae904d5=2E=
=2Ed6e78a9 100755</span><br><span>--- a/dev-tools/gerrit-send-mail=2Epy</sp=
an><br><span>+++ b/dev-tools/gerrit-send-mail=2Epy</span><br><span>@@ -18,1=
0 +18,18 @@</span><br><span> # Extract a patch from Gerrit and transform it=
 in a file suitable as input</span><br><span> # for git send-email=2E</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Note:=
 This generally works without authentication since it only reads</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# information and doesn&#39;t =
change any state in Gerrit itself=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# To access changes in projects that are not viewable by a=
nonymous</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# visitors =
set GERRIT_USER and GERRIT_PASS environment variables=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# GERRIT_PASS can be a token as genera=
ted on your user settings page</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# under &quot;HTTP Credentials&quot;=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> import argparse</span><br>=
<span> import base64</span><br><span> from datetime import timezone</span><=
br><span> import json</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+import os</span><br><span> import sys</span><br><span> from urllib=2Epars=
e import urlparse</span><br><span> </span><br><span>@@ -29,9 +37,11 @@</spa=
n><br><span> import requests</span><br><span> </span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-def get_details(args):</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+def get_details(args, gerrit_=
api_url, auth):</span><br><span>     params =3D {&quot;o&quot;: [&quot;CURR=
ENT_REVISION&quot;, &quot;LABELS&quot;, &quot;DETAILED_ACCOUNTS&quot;]}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    r =3D requests=2Eget(=
f&quot;{args=2Eurl}/changes/{args=2Echangeid}&quot;, params=3Dparams)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    r =3D requests=2Eget(=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        f&quot;{ger=
rit_api_url}/changes/{args=2Echangeid}&quot;, params=3Dparams, auth=3Dauth<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><spa=
n>     print(r=2Eurl)</span><br><span>     json_txt =3D r=2Etext=2Eremovepr=
efix(&quot;)]}&#39;\n&quot;)</span><br><span>     json_data =3D json=2Eload=
s(json_txt)</span><br><span>@@ -76,9 +86,10 @@</span><br><span>     }</span=
><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-def get_patch(details, args):</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+def get_patch(details, args, gerrit_api_url, auth):</spa=
n><br><span>     r =3D requests=2Eget(</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        f&quot;{args=2Eurl}/changes/{args=2Echangeid}/revi=
sions/{details[&#39;revision&#39;]}/patch?download&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        f&quot;{gerrit_api_url}/change=
s/{args=2Echangeid}/revisions/{details[&#39;revision&#39;]}/patch?download&=
quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        auth=
=3Dauth,</span><br><span>     )</span><br><span>     print(r=2Eurl)</span><=
br><span>     patch_text =3D base64=2Eb64decode(r=2Etext)=2Edecode()</span>=
<br><span>@@ -138,8 +149,16 @@</span><br><span>     parser=2Eadd_argument(&=
quot;-u&quot;, &quot;--url&quot;, default=3D&quot;https://gerrit=2Eopenvpn=
=2Enet&quot;)</span><br><span>     args =3D parser=2Eparse_args()</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    details =
=3D get_details(args)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    patch =3D get_patch(details, args)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    auth =3D None</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    gerrit_api_url =3D args=2Eurl</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if &quot;GERRIT_USER&quot; in os=2Eenvir=
on:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gerrit_u=
ser =3D os=2Eenviron[&quot;GERRIT_USER&quot;]</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        gerrit_pass =3D os=2Eenviron[&quot;GERRIT=
_PASS&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 auth =3D requests=2Eauth=2EHTTPBasicAuth(gerrit_user, gerrit_pass)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        gerrit_api_url +=3D=
 &quot;/a&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    details =3D get_det=
ails(args, gerrit_api_url, auth)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    patch =3D get_patch(details, args, gerrit_api_url, auth)</=
span><br><span>     apply_patch_mods(patch, details, args)</span><br></pre>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/219=
5?usp=3Demail">change 2195</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2195?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatc=
hset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: I00b340f30dc3518994b74c49565736524b7df318 </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 2195 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>

</body></html>
--3lk3e0/94lY=--


--===============6309237875671441915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6309237875671441915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6309237875671441915==--

