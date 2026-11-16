Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA58606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iKV9Hr1f;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=L4QA4hEN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lyG+xPdv;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GKA1SmHS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=N1a7WDDYZYwiuMOUnxRsFIc0nKYyfksjVmlyUPCGnpc=; b=iKV9Hr1fiLsf+0t/cZ9Y0q2wPy
	hPTZ4x4dpmDUMcd5/aOTbYroSEgNhWnpE5t/q7gTMfbvEDrgyMu8Z//gBnPihctQ71CSuGUq6Yfn7
	HMCWgm2fuXbwsVvgDiSyDzRSW6TcMp8AjZgRSKHSBgnJLPEpdukZTto0ye8H7FON7aZ0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSwOZ-0000000005q-0OtE;
	Mon, 16 Nov 2026 13:05:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSwOK-000000008WE-41pU
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 13:05:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NbXCNW3usrgxyl66ClDu0MWL7CHtjnH17Op2EGyuYy4=; b=L4QA4hENsvbRxXvYDqWctTfaFH
 4rTXr3ZiNYsN9/IbB57mUcnmtkEEdKxPrjvc3SoKUSLLtEAnB1Bc401W4c1Oug5pMmRgvblE+P5fm
 3IymtbaS1lYlhN/UvjjiC/If0K0PcM2Ck01SJDLsEFb4dsWI/1FnGxpA8Udn5mPIH4pU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NbXCNW3usrgxyl66ClDu0MWL7CHtjnH17Op2EGyuYy4=; b=lyG+xPdvSAgjm4+DZVZk27BI3B
 kZl8QHVs1NwvNnqf/WCJvKr+QZ1kWHCQpRL0GQGwcUddP7AEx4ohcKFWV33gHif11+D3Fpln5/2//
 jTVFJjrltLDKqRWUqTZ4wDHbaPnX2ZET1sWx2x4+y1JD/6Idx/+iV+WvZVLKeP8poX2o=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSwOI-000000004RQ-4Abf for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 13:05:00 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso20979885e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 05:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794834292; x=1795439092; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NbXCNW3usrgxyl66ClDu0MWL7CHtjnH17Op2EGyuYy4=;
 b=GKA1SmHSYoaguOtfeUEcZk90ilxFN+gWqEHVUEyhSndQq4FU06sOqKtAmpFWYzTe96
 sEve7p/yNagSBVnOMhADk1UnB/XIfjqu4vx08F7XE4+Jhr4rTuz9MhAFtYMni/JLyjRl
 i9eO0YTMC1+wbQPYrEr7TY5W6qJUy6P+vFJdl7ARzXrZYPX/OJITLSyAJnJ8jP5nQNzK
 sJP11vSqTQYJtiDtrohFUXgtNdhvLFqnvtIsOhKU7H2VbETJsX8qZcGJ6+UfwSwh9A4x
 eV26EmbAkCnwvda92HtpvT6Vw2i9CNb2z+x2Yr1AKeDs/Ncpe5eZtiFA6rUaCBs27D8H
 VDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794834292; x=1795439092;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NbXCNW3usrgxyl66ClDu0MWL7CHtjnH17Op2EGyuYy4=;
 b=W/2WF6hJVRZs7ETixhH6U7JcnuZ7uyZEa9wDQ86fdeG7NY+wgTZeJHlL35LoHbSXDK
 5BC6etaITTndoW6AU009l6Z4Rk0Hl/ioFU52y9hmGRZkJuU8roiiGwIZHsPDQfLOLC8o
 wHwKFwO3T4nBbR7orEiv5/aAoXBOBvR23cm3kcqxVdGVCfhulrmDmTqEfiqq653t6hH+
 qmP/PzcGAtRuYggJet5ZLK6+bJEP95j0VOCYrX0MlfHtxiAV8iVAMtUpD+jJHg9R1T4Z
 AsNRpnFwkaTUdrS1SZ09bHQmgCxfL89JCmwQr0gtXiqSgQ3osnpT7x17c2YNOvlc3VmQ
 uKAA==
X-Gm-Message-State: APuU4Z+2I+3+O/S9reu/fSvLmpUz62DQyjKSeKjmxmqNHLrbatqk2y9P
 uqfWDdfwmdaOf+BHbXdOZqTRx+YXY3LDWxUWmjfLR6+bQsax6Z0LzWrGbqoLq+/m2CrnxXekIoB
 1iR3sQcKSPGBW3LAM+G75hYfa/OGzRya2OPeLKRk8tCCZnDazInOWydXm+T1mA1/3NgNSw7EYeM
 diyEQcag==
X-Gm-Gg: AYBFou3UeMj8DeVPfznwI2Zz1nrDVFeVH9S00ZQFQlhtr+Khn9YvsrG7NLCD7fMiWmb
 u7JpefT8xduvkmshAs9TNwX+csbzJDs3duNuGuSeCEV7Uy3X99VTo6QdmxytcImUkXp/sYIGyXY
 8tocVRktAVEcXInHS1w/rBi3z/X37PVcj+4Knmj6f2tU3SRflfbDFUGkyAtH1aUlgEMwzh8tWDG
 py2NaPLmZYD1NXhmnyU8hgrJdkuocEl/UvKONDHqcoMvXpgv87/d7kTq5P0OGRfp/ItGI/l93Y1
 Bg/UhsRUPKcr+OypLudvnvVXPVlabNbJHqtTeT7JMwPELUCLS66hRgqr//mho7L4KxmSIiNiKpk
 y/ujgKg5lQTqkkpVFcaBF8156rikQIFj3puI4iBP/qoQbm0UZZhhZQgI4sIuneGEIpWrikzdWbv
 QIqqWammthBko1aXBHr71mFusEyyB1kTl2exaHP6rtn8A222ks+RPtcyJrO1piweybiyJ2a5UN1
 yjqD0Mpk/IyXVemO4x1EwTzVIbDyZd5C0gIbYra1HDR7VcVCugksBJIL9/9QSN1tXijF7zKMLs5
 gt6b61hgMq8WMNilbrZSzsE+LFh7/q/sgDLLd9s2YM7/d11SFaQGZl60NwsMmQjvd4NW+0cBtvg
 yxLsUEQjRZlSHGPVQbwWRoRilmj/WEoq6nlXu5ecJNb2x1bevQbNCAuxwXC+s6OOP+5n4gGmQMc
 r3xmNPNCIsG1iZbaQ=
X-Received: by 2002:a05:600c:6096:b0:4bb:5de1:e923 with SMTP id
 5b1f17b1804b1-4bb5de1f26dmr164907525e9.4.1794834292122; 
 Mon, 16 Nov 2026 05:04:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571cfa2esm279569435e9.2.2026.11.16.05.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:04:51 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 13:04:51 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I00b340f30dc3518994b74c49565736524b7df318
X-Gerrit-Change-Number: 2195
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2195?usp=email>
X-Gerrit-Commit: 85cad2c4888fcfa210020d397ec90e3e1d68337d
References: <gerrit.1794834286000.I00b340f30dc3518994b74c49565736524b7df318@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM0Mjg2MDAwLkkwMGIzNDBmMzBkYzM1MTg5OTRiNzRjNDk1NjU3MzY1MjRiN2RmMzE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <474b3e4cf575718c0e4e068473ba1a7ce0cfa009-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSwOI-000000004RQ-4Abf
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
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4371521003305171224=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4371521003305171224==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WgmbGsR3Lk4="; charset=UTF-8

--WgmbGsR3Lk4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2195?usp=3Demail

to review the following change=2E
=


Change subject: gerrit-send-mail: Support user authentication
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

gerrit-send-mail: Supp=
ort user authentication

Required for changes in private projects=2E

Chang=
e-Id: I00b340f30dc3518994b74c49565736524b7df318
Signed-off-by: Frank Lichte=
nheld <frank@lichtenheld=2Ecom>
---
M dev-tools/gerrit-send-mail=2Epy
1 fil=
e changed, 18 insertions(+), 6 deletions(-)



  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/95/2195/1

diff --git a/dev-tools/ge=
rrit-send-mail=2Epy b/dev-tools/gerrit-send-mail=2Epy
index ae904d5=2E=2E53=
06c5e 100755
--- a/dev-tools/gerrit-send-mail=2Epy
+++ b/dev-tools/gerrit-s=
end-mail=2Epy
@@ -22,6 +22,7 @@
 import base64
 from datetime import timezo=
ne
 import json
+import os
 import sys
 from urllib=2Eparse import urlparse=

 
@@ -29,9 +30,11 @@
 import requests
 
 
-def get_details(args):
+def get=
_details(args, gerrit_api_url, auth):
     params =3D {"o": ["CURRENT_REVIS=
ION", "LABELS", "DETAILED_ACCOUNTS"]}
-    r =3D requests=2Eget(f"{args=2Eu=
rl}/changes/{args=2Echangeid}", params=3Dparams)
+    r =3D requests=2Eget(=

+        f"{gerrit_api_url}/changes/{args=2Echangeid}", params=3Dparams, a=
uth=3Dauth
+    )
     print(r=2Eurl)
     json_txt =3D r=2Etext=2Eremovepr=
efix(")]}'\n")
     json_data =3D json=2Eloads(json_txt)
@@ -76,9 +79,10 @@=

     }
 
 
-def get_patch(details, args):
+def get_patch(details, args, ge=
rrit_api_url, auth):
     r =3D requests=2Eget(
-        f"{args=2Eurl}/cha=
nges/{args=2Echangeid}/revisions/{details['revision']}/patch?download"
+   =
     f"{gerrit_api_url}/changes/{args=2Echangeid}/revisions/{details['revis=
ion']}/patch?download",
+        auth=3Dauth,
     )
     print(r=2Eurl)
  =
   patch_text =3D base64=2Eb64decode(r=2Etext)=2Edecode()
@@ -138,8 +142,16=
 @@
     parser=2Eadd_argument("-u", "--url", default=3D"https://gerrit=2Eo=
penvpn=2Enet")
     args =3D parser=2Eparse_args()
 
-    details =3D get_d=
etails(args)
-    patch =3D get_patch(details, args)
+    auth =3D None
+  =
  gerrit_api_url =3D args=2Eurl
+    if "GERRIT_USER" in os=2Eenviron:
+   =
     gerrit_user =3D os=2Eenviron["GERRIT_USER"]
+        gerrit_pass =3D o=
s=2Eenviron["GERRIT_PASS"]
+        auth =3D requests=2Eauth=2EHTTPBasicAut=
h(gerrit_user, gerrit_pass)
+        gerrit_api_url +=3D "/a"
+
+    detail=
s =3D get_details(args, gerrit_api_url, auth)
+    patch =3D get_patch(deta=
ils, args, gerrit_api_url, auth)
     apply_patch_mods(patch, details, args=
)
 
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00b340f30d=
c3518994b74c49565736524b7df318
Gerrit-Change-Number: 2195
Gerrit-PatchSet: =
1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>

--WgmbGsR3Lk4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">gerrit-send-mail: Support user authentication<br><br>Requi=
red for changes in private projects=2E<br><br>Change-Id: I00b340f30dc351899=
4b74c49565736524b7df318<br>Signed-off-by: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt;<br>---<br>M dev-tools/gerrit-send-mail=2Epy<br>1 file chan=
ged, 18 insertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/95/2195/1</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/dev-tools/gerrit-send-mail=2Epy b/dev-tools/gerrit-send-mail=2Ep=
y</span><br><span>index ae904d5=2E=2E5306c5e 100755</span><br><span>--- a/d=
ev-tools/gerrit-send-mail=2Epy</span><br><span>+++ b/dev-tools/gerrit-send-=
mail=2Epy</span><br><span>@@ -22,6 +22,7 @@</span><br><span> import base64<=
/span><br><span> from datetime import timezone</span><br><span> import json=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import os</span><br=
><span> import sys</span><br><span> from urllib=2Eparse import urlparse</sp=
an><br><span> </span><br><span>@@ -29,9 +30,11 @@</span><br><span> import r=
equests</span><br><span> </span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-def get_details(args):</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+def get_details(args, gerrit_api_url, auth):</span=
><br><span>     params =3D {&quot;o&quot;: [&quot;CURRENT_REVISION&quot;, &=
quot;LABELS&quot;, &quot;DETAILED_ACCOUNTS&quot;]}</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    r =3D requests=2Eget(f&quot;{args=2Eurl}/c=
hanges/{args=2Echangeid}&quot;, params=3Dparams)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    r =3D requests=2Eget(</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        f&quot;{gerrit_api_url}/changes/=
{args=2Echangeid}&quot;, params=3Dparams, auth=3Dauth</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span>     print(r=2Eurl)=
</span><br><span>     json_txt =3D r=2Etext=2Eremoveprefix(&quot;)]}&#39;\n=
&quot;)</span><br><span>     json_data =3D json=2Eloads(json_txt)</span><br=
><span>@@ -76,9 +79,10 @@</span><br><span>     }</span><br><span> </span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-def get_patc=
h(details, args):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+de=
f get_patch(details, args, gerrit_api_url, auth):</span><br><span>     r =
=3D requests=2Eget(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      f&quot;{args=2Eurl}/changes/{args=2Echangeid}/revisions/{details[&#39=
;revision&#39;]}/patch?download&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        f&quot;{gerrit_api_url}/changes/{args=2Echangeid}=
/revisions/{details[&#39;revision&#39;]}/patch?download&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        auth=3Dauth,</span><br><=
span>     )</span><br><span>     print(r=2Eurl)</span><br><span>     patch_=
text =3D base64=2Eb64decode(r=2Etext)=2Edecode()</span><br><span>@@ -138,8 =
+142,16 @@</span><br><span>     parser=2Eadd_argument(&quot;-u&quot;, &quot=
;--url&quot;, default=3D&quot;https://gerrit=2Eopenvpn=2Enet&quot;)</span><=
br><span>     args =3D parser=2Eparse_args()</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    details =3D get_details(args)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    patch =3D get_patc=
h(details, args)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 auth =3D None</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    g=
errit_api_url =3D args=2Eurl</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if &quot;GERRIT_USER&quot; in os=2Eenviron:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        gerrit_user =3D os=2Eenviron[&=
quot;GERRIT_USER&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        gerrit_pass =3D os=2Eenviron[&quot;GERRIT_PASS&quot;]</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        auth =3D requests=2Ea=
uth=2EHTTPBasicAuth(gerrit_user, gerrit_pass)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        gerrit_api_url +=3D &quot;/a&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    details =3D get_details(args, gerrit_api_=
url, auth)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    patch=
 =3D get_patch(details, args, gerrit_api_url, auth)</span><br><span>     ap=
ply_patch_mods(patch, details, args)</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail">change =
2195</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I00b340f30dc3518994b74c49565736524b7df318 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2195 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--WgmbGsR3Lk4=--


--===============4371521003305171224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4371521003305171224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4371521003305171224==--

