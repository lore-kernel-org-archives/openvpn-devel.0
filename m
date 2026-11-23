Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334C3606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BKKvcEuN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GeahBK+x;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Lfo8K349;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RnH2a92a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+GsyMfaDgsKepS/0RF4tOUMXuYLTJtkuKjCyEJtSdGw=; b=BKKvcEuNgtO3lGobWVdTXpavYn
	ae7aaIOyvy6+tcscxWr4moN9f5dEuN+VTk/FF12BmDMoTHZnc/4FxLN90poDeIMFJk2Ys0Z3Tdd7K
	FX1fQyaNk6EkSpNqEhhExtE/buiuyOXglA/mzWXSavu2W+wVa78U6f1R/wdTvSZdaUV8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVY4v-000000001nI-3mZu;
	Mon, 23 Nov 2026 17:43:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVY4u-000000001n2-1q9Q
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:43:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tnoirDKhrR69KWKLvoHZIFyny/79jH5lRTj6rWlPkaw=; b=GeahBK+xchBU4LIi+Ho3t2j4Yp
 HRSSFB6qpxwS+G8EeXwieFdJ8pyVNeaof3HSI6Q6aNp9wC0XJaT8eKk6fH8kgRxhyXBSX+ItzcWry
 GxSahTtpbkETAiRc46YGQh0qRfSRkmCQJRYdHkpIM9WL44/oU6wsFadRMfDNg2dOm0BA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tnoirDKhrR69KWKLvoHZIFyny/79jH5lRTj6rWlPkaw=; b=Lfo8K349H2Qazx0cLgmKbmobXE
 cXIFtX4CcA3cwbRj2ONcago5qChWBS+GuNji6TetCnFXo2Fn+KTblb6hn5JHYg1up2Xql71lA2NID
 zUQSRafakE6Jv6apXrZfk0tAEQI3YSPwGH0g2E95rZ3+U/kLK3EG0GT1ixZ6ZRtsNR3Y=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVY4s-0000000029C-3i1e for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:43:44 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso2721624f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 09:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795455816; x=1796060616; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tnoirDKhrR69KWKLvoHZIFyny/79jH5lRTj6rWlPkaw=;
 b=RnH2a92aMjwuf3sMWZn+m4xegRFFrKLPprwm84XiTlfi/YrvDSRcRMBOoTUUDqp8pU
 GwIBjmzHe2TW4vGa7uZHFEukGtfWWyQ9yWingD3RFsCfQZ5k0bFct3PtVS7sStt5Td7E
 Ejwm0GQVZBheHMKLRG6PBz/1JNlI63vBiBHYBX8C06VxxW9qRKCTVHLPbAhnMzcI8LVR
 xBx6Urt2SLFOsBTYZdImQ5RNsMMG3gUOOa7Xg1omnki4BT/pzLTXnhBe1xg4nKbKoYmT
 cJ3F3S0mGUKSnLyV7NzI3NuyfeS9PMSg5E+XlW238m3btd+bODin6LhKXp9VUaxKv27/
 6iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455816; x=1796060616;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tnoirDKhrR69KWKLvoHZIFyny/79jH5lRTj6rWlPkaw=;
 b=B/jgfBK5yuc7W9yWQcG16Zv6x5+HeLxhMf/UQV5vXsGyA0LRq3mXOZCujrM9srRAPf
 qXHpISJyIxnBw1Uah3WwCwXzzSFBrduzDR0wyAaYzuDFPCi+oxLARU8qwKU69b/HKuC5
 CmC1eKlc+k0KoAw1wm/1Pp9EhpqgmRhZvRMVx4F1q8wqbcTBa0+TX2oU31Hxh0L4fUIi
 k018kctKCLJIIM/b0oX2hvvMPBqJltWO4m27m763vTiWt1iN10KBFsYYiHSTuslRriv7
 bA62ADAkuqRrMGjHYaB5rdKFo9mnYoC/kiFD+KGEJ11bbj3fPBf/SENz+jBDLm+e6UrM
 ssag==
X-Forwarded-Encrypted: i=1;
 AL+hErFT2HwGO+gSHkd2VEdH3ZVKLrMxKX6ZvIk3ulQ4xvUp2rX2bkbtcq8iPAfF/y1y52MgGxGRoXwrcNKcOl8a@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+4kus5nFq3LxoxH/aIe2ObmxMCgF9PoLfCaCMhJhL1P5pRguxU
 WN8OtTDtChSY5C0B7g1yxP5p+Tbcys3QoLaI/GQIDOUclc2GsjvG3uCicTWWSAImHesQVfvAgfr
 Bz4BaN8pLMeoMZXAKQl2N+LemOWs/dvALeMbdUGLTP4JJXdIhN5LPtuQWKHe6fCuQ5DU9
X-Gm-Gg: AZFdTZemUoFRlKatUEH2cJ8zSyHdp6hWi61TgVzGREFEM2aXFShxLdRpW6cWR92j6lY
 dLE5ZtXBcFx4jytJISNcJmzZD49YfQdjX72C6wqj8BaHKQw1bx9ICM/SZnTqa905vQZto+g1kLn
 CPeYcYf7lkMRG02vAY/ZeaM4DxDyS2jaqGr7Q1uAuWTVrH4gNmw5CaiAIINcfEHVgmFjYsmhupt
 Id1cCPxtkDMCfWevvblSZeJfFk8KeeCinZkiBTZA31XpwYYDFtz3MfTXPhshMCSbIkKp4qzziFG
 rM5AQhyrYqY2Q8HGKbTe06TZJL0xq7AbReF7TFvoaJ/5gUmC5qbgPeSUtg4k6Nqexc49kAICr4G
 ug4kvAQPuGzT9Vwp5FNUO6yzdj4E3wlqO1XVGHQctfdl+S5yCaOTZy3uzLQLXaj+ohSa2V6lBtE
 gE+8EbT7eFl+sHeECMiDr6RxtSdNHSQaurPv87CSyu6CbMS7kNHWYHaUtGKzGczDrtOZW8JK93Z
 IhBP8i2cCSynjPZw/3rycjEj7NHTDEN2JICOQ6L6LyKbWIwQO0OpWRiQYmx1R4CcwWkMVeDDhvb
 HHSJnDFOTF+7fE9Ur6rt5IOYW4clh7P5lcZ8mdZtT5Cnbtg7A5qN638JJZ88Kkvjh4i4fWbnT2O
 PcefI2AtRiBwIZ47IJQWIZ6bU5x12Pv/Pv2q0oc84HsQV0omZ6J7T5D9OYQkFhQiiv2hgRAyjFK
 XJhQ8AbgtRj3YE0YM=
X-Received: by 2002:a05:600c:34c9:b0:4a3:5d64:df91 with SMTP id
 5b1f17b1804b1-4bb88810d28mr272476415e9.18.1795455816031; 
 Mon, 23 Nov 2026 09:43:36 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b33a596f9csm5222363f8f.12.2026.11.23.09.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 09:43:35 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 17:43:35 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I00b340f30dc3518994b74c49565736524b7df318
X-Gerrit-Change-Number: 2195
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2195?usp=email>
X-Gerrit-Commit: 765487a0234965edd833716ae7efcce9b93f8921
In-Reply-To: <gerrit.1794834286000.I00b340f30dc3518994b74c49565736524b7df318@gerrit.openvpn.net>
References: <gerrit.1794834286000.I00b340f30dc3518994b74c49565736524b7df318@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM0Mjg2MDAwLkkwMGIzNDBmMzBkYzM1MTg5OTRiNzRjNDk1NjU3MzY1MjRiN2RmMzE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <48ef8297fa64672d510ef89eca29d09ecbe3cefa-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVY4s-0000000029C-3i1e
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3527474419558255617=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3527474419558255617==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AZgsB0VIJVg="; charset=UTF-8

--AZgsB0VIJVg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2195?usp=3Demail )

Change subject: gerrit-send-mail: Support u=
ser authentication
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

gerrit-send-mail: Support user authentication

Required for changes=
 in private projects=2E

Change-Id: I00b340f30dc3518994b74c49565736524b7df3=
18
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M dev-too=
ls/gerrit-send-mail=2Epy
1 file changed, 25 insertions(+), 6 deletions(-)

=
Approvals:
  Gert Doering: Looks good to me, approved




diff --git a/dev-=
tools/gerrit-send-mail=2Epy b/dev-tools/gerrit-send-mail=2Epy
index ae904d5=
=2E=2Ed6e78a9 100755
--- a/dev-tools/gerrit-send-mail=2Epy
+++ b/dev-tools/=
gerrit-send-mail=2Epy
@@ -18,10 +18,18 @@
 # Extract a patch from Gerrit an=
d transform it in a file suitable as input
 # for git send-email=2E
 
+# No=
te: This generally works without authentication since it only reads
+# info=
rmation and doesn't change any state in Gerrit itself=2E
+# To access chang=
es in projects that are not viewable by anonymous
+# visitors set GERRIT_US=
ER and GERRIT_PASS environment variables=2E
+# GERRIT_PASS can be a token a=
s generated on your user settings page
+# under "HTTP Credentials"=2E
+
 im=
port argparse
 import base64
 from datetime import timezone
 import json
+i=
mport os
 import sys
 from urllib=2Eparse import urlparse
 
@@ -29,9 +37,11=
 @@
 import requests
 
 
-def get_details(args):
+def get_details(args, ger=
rit_api_url, auth):
     params =3D {"o": ["CURRENT_REVISION", "LABELS", "D=
ETAILED_ACCOUNTS"]}
-    r =3D requests=2Eget(f"{args=2Eurl}/changes/{args=
=2Echangeid}", params=3Dparams)
+    r =3D requests=2Eget(
+        f"{gerr=
it_api_url}/changes/{args=2Echangeid}", params=3Dparams, auth=3Dauth
+    )=

     print(r=2Eurl)
     json_txt =3D r=2Etext=2Eremoveprefix(")]}'\n")
  =
   json_data =3D json=2Eloads(json_txt)
@@ -76,9 +86,10 @@
     }
 
 
-def =
get_patch(details, args):
+def get_patch(details, args, gerrit_api_url, aut=
h):
     r =3D requests=2Eget(
-        f"{args=2Eurl}/changes/{args=2Echan=
geid}/revisions/{details['revision']}/patch?download"
+        f"{gerrit_ap=
i_url}/changes/{args=2Echangeid}/revisions/{details['revision']}/patch?down=
load",
+        auth=3Dauth,
     )
     print(r=2Eurl)
     patch_text =3D=
 base64=2Eb64decode(r=2Etext)=2Edecode()
@@ -138,8 +149,16 @@
     parser=
=2Eadd_argument("-u", "--url", default=3D"https://gerrit=2Eopenvpn=2Enet")
=
     args =3D parser=2Eparse_args()
 
-    details =3D get_details(args)
- =
   patch =3D get_patch(details, args)
+    auth =3D None
+    gerrit_api_ur=
l =3D args=2Eurl
+    if "GERRIT_USER" in os=2Eenviron:
+        gerrit_use=
r =3D os=2Eenviron["GERRIT_USER"]
+        gerrit_pass =3D os=2Eenviron["GE=
RRIT_PASS"]
+        auth =3D requests=2Eauth=2EHTTPBasicAuth(gerrit_user, =
gerrit_pass)
+        gerrit_api_url +=3D "/a"
+
+    details =3D get_detai=
ls(args, gerrit_api_url, auth)
+    patch =3D get_patch(details, args, gerr=
it_api_url, auth)
     apply_patch_mods(patch, details, args)
 
 

-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I00b340f30dc3518994b74c495657=
36524b7df318
Gerrit-Change-Number: 2195
Gerrit-PatchSet: 3
Gerrit-Owner: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--AZgsB0VIJVg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2195?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap">Approvals:
  Gert Doering: Looks good to me, approved
=

</div><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">gerrit-send-mail: Support user authentication<br><br>R=
equired for changes in private projects=2E<br><br>Change-Id: I00b340f30dc35=
18994b74c49565736524b7df318<br>Signed-off-by: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt;<br>---<br>M dev-tools/gerrit-send-mail=2Epy<br>1 file =
changed, 25 insertions(+), 6 deletions(-)<br><br></pre>
<pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev=
-tools/gerrit-send-mail=2Epy b/dev-tools/gerrit-send-mail=2Epy</span><br><s=
pan>index ae904d5=2E=2Ed6e78a9 100755</span><br><span>--- a/dev-tools/gerri=
t-send-mail=2Epy</span><br><span>+++ b/dev-tools/gerrit-send-mail=2Epy</spa=
n><br><span>@@ -18,10 +18,18 @@</span><br><span> # Extract a patch from Ger=
rit and transform it in a file suitable as input</span><br><span> # for git=
 send-email=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# Note: This generally works without authentication since it o=
nly reads</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# informat=
ion and doesn&#39;t change any state in Gerrit itself=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# To access changes in projects that a=
re not viewable by anonymous</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# visitors set GERRIT_USER and GERRIT_PASS environment variables=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# GERRIT_PASS ca=
n be a token as generated on your user settings page</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# under &quot;HTTP Credentials&quot;=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> imp=
ort argparse</span><br><span> import base64</span><br><span> from datetime =
import timezone</span><br><span> import json</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+import os</span><br><span> import sys</span><br><s=
pan> from urllib=2Eparse import urlparse</span><br><span> </span><br><span>=
@@ -29,9 +37,11 @@</span><br><span> import requests</span><br><span> </span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-def get_d=
etails(args):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+def ge=
t_details(args, gerrit_api_url, auth):</span><br><span>     params =3D {&qu=
ot;o&quot;: [&quot;CURRENT_REVISION&quot;, &quot;LABELS&quot;, &quot;DETAIL=
ED_ACCOUNTS&quot;]}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  r =3D requests=2Eget(f&quot;{args=2Eurl}/changes/{args=2Echangeid}&quot;,=
 params=3Dparams)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  r =3D requests=2Eget(</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        f&quot;{gerrit_api_url}/changes/{args=2Echangeid}&quot;, params=
=3Dparams, auth=3Dauth</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    )</span><br><span>     print(r=2Eurl)</span><br><span>     json_txt =
=3D r=2Etext=2Eremoveprefix(&quot;)]}&#39;\n&quot;)</span><br><span>     js=
on_data =3D json=2Eloads(json_txt)</span><br><span>@@ -76,9 +86,10 @@</span=
><br><span>     }</span><br><span> </span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-def get_patch(details, args):</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+def get_patch(details, args, gerr=
it_api_url, auth):</span><br><span>     r =3D requests=2Eget(</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        f&quot;{args=2Eurl}/changes=
/{args=2Echangeid}/revisions/{details[&#39;revision&#39;]}/patch?download&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        f&quot;=
{gerrit_api_url}/changes/{args=2Echangeid}/revisions/{details[&#39;revision=
&#39;]}/patch?download&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        auth=3Dauth,</span><br><span>     )</span><br><span>     =
print(r=2Eurl)</span><br><span>     patch_text =3D base64=2Eb64decode(r=2Et=
ext)=2Edecode()</span><br><span>@@ -138,8 +149,16 @@</span><br><span>     p=
arser=2Eadd_argument(&quot;-u&quot;, &quot;--url&quot;, default=3D&quot;htt=
ps://gerrit=2Eopenvpn=2Enet&quot;)</span><br><span>     args =3D parser=2Ep=
arse_args()</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    details =3D get_details(args)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    patch =3D get_patch(details, args)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    auth =3D None</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gerrit_api_url =3D args=2Eurl</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if &quot;GERRIT_USER=
&quot; in os=2Eenviron:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        gerrit_user =3D os=2Eenviron[&quot;GERRIT_USER&quot;]</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        gerrit_pass =3D os=2E=
environ[&quot;GERRIT_PASS&quot;]</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        auth =3D requests=2Eauth=2EHTTPBasicAuth(gerrit_user, =
gerrit_pass)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 gerrit_api_url +=3D &quot;/a&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 details =3D get_details(args, gerrit_api_url, auth)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    patch =3D get_patch(details, args, ge=
rrit_api_url, auth)</span><br><span>     apply_patch_mods(patch, details, a=
rgs)</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2195?usp=3Demail">change 2195</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I00b340f30dc3518994b74c4956573=
6524b7df318 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2195 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D=
"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>

</body></html>
--AZgsB0VIJVg=--


--===============3527474419558255617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3527474419558255617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3527474419558255617==--

