Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF99CD4F25
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 10:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pWIW0pl/ef4zbd7xlB70xHMKnagamvfFPBVKHWIFHRU=; b=Ib5gnCKPV6snzINbf/vDyEiY7+
	YQbJGPq9POcHI59UNedDJvgfz24IE9MC6lETk5wX+uU0x3vgD7QFdZA5XbV8DMGvmNGDTvkAikiv5
	equ7nGWEuIeVrcsqdJ7Jnbr6KnDd5lrryAqSt779qymDWomqsfA1ZoK0vebO3KvXQtPI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNTKA-0003Dn-QI;
	Thu, 14 May 2026 10:29:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wNTK9-0003Dg-ME
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:29:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tatjjlthRLu3qMg5ATPeLutZU1MjPiOJihYE2Fs+8Qg=; b=giunlo/PsuMavlcj0bcmcKrtdu
 uGSXZOQDEyZCpIXCTvnn6ZCQX3OPLNm4tBTIKZiHgn/szpPSQ+zH3AQLpwgSdrQQ9nwhkkFkrI9Xt
 736f91tdJbXpjn/e6BsdN+/SxHGT5xRQ7KwngRzKZ0sj/xU9PDz+GWweFUIPdslif13I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tatjjlthRLu3qMg5ATPeLutZU1MjPiOJihYE2Fs+8Qg=; b=b
 DDbMU5n/KT3VphPYfs9ZtlNF6IPDny9pniUm3FoxcI7BgvU5nlgYKb/3gV82v9/IXsbpdEf6k5lhU
 nEgAjh7Q4Fmhqdvt+aO5cVM6pQROx0AKgMqW0S4kliGP+M5TSr/6XHfCHH+7e35RcK69cU3wd0Slw
 LKj+PJkiy6c3pqko=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNTK7-0006RW-Fv for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:29:49 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso75778765e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 03:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778754581; x=1779359381; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tatjjlthRLu3qMg5ATPeLutZU1MjPiOJihYE2Fs+8Qg=;
 b=aH7Mar02mCj6UwLVAeYW0BUZbu7uWb8h5/04GhYBviMv+IMTlWIismyQgQIX5JeTeP
 Y3ua+8uCt76s4M/eWIq0ZP3RlCprsMCM/9iVSttF+z833I7be38x93d3nGmmGvVsal/8
 bJbCGOVojbLgQd65CBvBH5OKDhwMF3Vi58YDZLOAYCcear/ZgyaMe6tgCbkAxNTcp2v3
 HJsoawEQwDDp7uTfZN0HNOL7GW/dZm1KRySJCgtCCpUz0fado6KOn+T0DMsCQ47dVt/9
 oH0z7bwmJOoYKqx0JBOIFhT0bvBy3/B37UiH7B71m0R8Po12CkRUCqXob9FKLMF1N6jt
 /dmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778754581; x=1779359381;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tatjjlthRLu3qMg5ATPeLutZU1MjPiOJihYE2Fs+8Qg=;
 b=AgSs2CudA2fXzy9/iYgPvoXz4QTx4xL8hScJDw5kSc6AWtBrW0nlwpOXNNYCpjTKEd
 H1Hj3Bpuv2aFFp5f4KYrUrves/6QUwg2hu4CPY39ON793zRCyGNmO/S1vfBorB327w7N
 tl/FHroiClu9UcgTwqbjjbWGC/co+DWvDltjByTbj/EL9EeVGPOvcr5c8yHPfhIiYYiQ
 H3hQy1aRY05u/NlVHMu2tgK3cJlyMcODMooCZd2n5ldPsTu/K+pvChjtyqB4oZEbH2sg
 xCZ+Mm++cAp8IfNe+bn2KvhH4iuVGto8wce2EneSmCYhhO4brBbUwtpyXAwgC59EVYCA
 IdIg==
X-Gm-Message-State: AOJu0YwCghx9y7rCNArdXbkmygcAcOukFjBcZ13V07EQ/xG1A3noLEKN
 T5XlGbSHR4G1zmczcPkJyHfk5D3YFxwNqnfrTJTAc2kEmKbicGGgWQfpfV7zB93YkNhvLpfdKzg
 YN0GwHMsktsIRYmydOfOuYxsqM21hWDm7WH8HEEKKeA0+XvQyulsqZrTF0tHc01NTO5fb
X-Gm-Gg: Acq92OEs20gefQQdR0qQ+SoMzqrKdUAyeI8h+wnjN1UaYNwLs0YGr7F8Q+sHXh67bSB
 EdEJK1b4xizWGQ57uCLaAwAZvgSVjj2+r/YaMriSEcBO/Aa1CPKMlUtY7m0tT1yOLsfuYKKAqgh
 ZndXtZHnqMwczGHDBFU0mSnJhYiJUncLvZ6tc25CwoDo1lSD7aS8OgSy5EYqeurLzGjL18DNOPo
 WDh7gZjsiegSPJxHwuLFmBhUECrPxfxI+ZU2Z1VGPe4/+NZ4n9PnzbWzbYPsI26igiezgNtbhwh
 ZMS8OaAFltosBZzJlSNut4VwMeFQXqufRVSHQiLjRloLQgBheiM51tLjUGLsVD/oPlzkxxoT2iT
 lqEYBSUR7YksjTITIK4IBfPY+lDyjDAdWHQGzpd+QXCzLIikb6psBhfvwxEMuK3b45ifFeubH7l
 DlLrD1YOdUN+5/frjkjwefWeqBNlH+JByyBonNxiVLuwmHcCb81O5O8csKM8tjjNnKVvBzcHNjM
 Zl6X1SbqKww7Nq9kHhNBH13DlJvEuHR6l1id1ejiym1MhjGgLJvPlmx1z7gqYZTWIkvctPjejaC
 rMLjkoIZt+B5q+jsh8JOHKqq
X-Received: by 2002:a05:600c:c0c2:b0:48f:e230:2a20 with SMTP id
 5b1f17b1804b1-48fe2302b32mr5084745e9.31.1778754581314; 
 Thu, 14 May 2026 03:29:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd768c828sm21154535e9.9.2026.05.14.03.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 03:29:40 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 14 May 2026 10:29:39 +0000
To: flichtenheld <frank@lichtenheld.com>,
 plaisthos <arne-openvpn@rfc2549.org>, d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I04e35928244e6ecda8c58285a812516662b50742
X-Gerrit-Change-Number: 1673
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1673?usp=email>
X-Gerrit-Commit: d69a0dfe73de6aa698caa8580d3bf54e76bd0dca
In-Reply-To: <gerrit.1778239616000.I04e35928244e6ecda8c58285a812516662b50742@gerrit.openvpn.net>
References: <gerrit.1778239616000.I04e35928244e6ecda8c58285a812516662b50742@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkkwNGUzNTkyODI0NGU2ZWNkYThjNTgyODVhODEyNTE2NjYyYjUwNzQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8d9b370a58c067e89e8ab9918d6dcd985ccece2b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wNTK7-0006RW-Fv
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not use
 deprecated aliases on Windows
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2272730541935794850=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2272730541935794850==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gePTILYzhPg="; charset=UTF-8

--gePTILYzhPg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1673?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by d12fk


Change subject: Do not use deprecated aliases on Windows
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Do not use deprecat=
ed aliases on Windows

Both these work perfectly fine but are discouraged
a=
nd might cause warnings by compilers=2E

Identified by cppcheck=2E

Change-=
Id: I04e35928244e6ecda8c58285a812516662b50742
Signed-off-by: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Acked-by: Heiko Hund <heiko@openvpn=2Enet>
Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1673
Message-Id: <2026=
0513150838=2E27382-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archi=
ve=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg36909=2Ehtml
Signed-off=
-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/cryptoapi=2Ec=

M src/openvpnmsica/openvpnmsica=2Ec
2 files changed, 6 insertions(+), 6 de=
letions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/73/1673/3

diff --git a/src/openvpn/cryptoapi=2Ec b/src/openvpn/crypto=
api=2Ec
index e17936a=2E=2Ebf80bbd 100644
--- a/src/openvpn/cryptoapi=2Ec
+=
++ b/src/openvpn/cryptoapi=2Ec
@@ -235,7 +235,7 @@
         if (pvext && cb=
ext >=3D sizeof(CERT_TEMPLATE_EXT))
         {
             const CERT_TEMP=
LATE_EXT *cte =3D (const CERT_TEMPLATE_EXT *)pvext;
-            if (!stric=
mp(cert_prop, cte->pszObjId))
+            if (!_stricmp(cert_prop, cte->ps=
zObjId))
             {
                 /* found direct OID match with cer=
tificate property specified */
                 gc_free(&gc);
@@ -244,7 +24=
4,7 @@
 
             const CRYPT_OID_INFO *tmpl_oid =3D
                 f=
ind_oid(CRYPT_OID_INFO_NAME_KEY, tmpl_name, CRYPT_TEMPLATE_OID_GROUP_ID);
-=
            if (tmpl_oid && !stricmp(tmpl_oid->pszOID, cte->pszObjId))
+   =
         if (tmpl_oid && !_stricmp(tmpl_oid->pszOID, cte->pszObjId))
      =
       {
                 /* found OID match in extension against resolved =
key */
                 gc_free(&gc);
diff --git a/src/openvpnmsica/openvpn=
msica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec
index fdb610c=2E=2E9d12963 10=
0644
--- a/src/openvpnmsica/openvpnmsica=2Ec
+++ b/src/openvpnmsica/openvpn=
msica=2Ec
@@ -508,7 +508,7 @@
             *iTicks +=3D MSICA_ADAPTER_TICK_=
SIZE;
             break;
         }
-        else if (wcsicmp(szDisplayNam=
e, pAdapterOther->szName) =3D=3D 0)
+        else if (_wcsicmp(szDisplayNam=
e, pAdapterOther->szName) =3D=3D 0)
         {
             /* Adapter with=
 a same name found=2E */
             for (LPCWSTR hwid =3D pAdapterOther->=
szzHardwareIDs;; hwid +=3D wcslen(hwid) + 1)
@@ -521,7 +521,7 @@
          =
           dwResult =3D ERROR_ALREADY_EXISTS;
                     goto cle=
anup_pAdapterList;
                 }
-                else if (wcsicmp(hwi=
d, szHardwareId) =3D=3D 0)
+                else if (_wcsicmp(hwid, szHardw=
areId) =3D=3D 0)
                 {
                     /* This is an adap=
ter with the requested hardware ID=2E We already have what we
             =
         * want! */
@@ -583,7 +583,7 @@
     for (struct tap_adapter_node *=
pAdapter =3D pAdapterList; pAdapter !=3D NULL;
          pAdapter =3D pAdap=
ter->pNext)
     {
-        if (wcsicmp(szDisplayName, pAdapter->szName) =
=3D=3D 0)
+        if (_wcsicmp(szDisplayName, pAdapter->szName) =3D=3D 0)
=
         {
             /* Adapter found=2E */
             WCHAR szArgumen=
t[8 /*disable=3D|enable=3D|delete=3D*/
@@ -1084,7 +1084,7 @@
              =
   for (struct tap_adapter_node *pAdapter =3D pAdapterList; pAdapter !=3D N=
ULL;
                      pAdapter =3D pAdapter->pNext)
                 {=

-                    if (wcsicmp(szName, pAdapter->szName) =3D=3D 0)
+    =
                if (_wcsicmp(szName, pAdapter->szName) =3D=3D 0)
          =
           {
                         /* Adapter found=2E */
              =
           dwResult =3D tap_delete_adapter(NULL, &pAdapter->guid, &bRebootR=
equired);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/167=
3?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatch=
set
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I04e359=
28244e6ecda8c58285a812516662b50742
Gerrit-Change-Number: 1673
Gerrit-PatchS=
et: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>

--gePTILYzhPg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1673?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by d12fk</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">Do not use deprecated alia=
ses on Windows<br><br>Both these work perfectly fine but are discouraged<br=
>and might cause warnings by compilers=2E<br><br>Identified by cppcheck=2E<=
br><br>Change-Id: I04e35928244e6ecda8c58285a812516662b50742<br>Signed-off-b=
y: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Heiko Hun=
d &lt;heiko@openvpn=2Enet&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1673<br>Message-Id: &lt;20260513150838=2E27382-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg36909=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/cryptoapi=2Ec<br>M src/op=
envpnmsica/openvpnmsica=2Ec<br>2 files changed, 6 insertions(+), 6 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/73/1673/3</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/cryptoapi=
=2Ec b/src/openvpn/cryptoapi=2Ec</span><br><span>index e17936a=2E=2Ebf80bbd=
 100644</span><br><span>--- a/src/openvpn/cryptoapi=2Ec</span><br><span>+++=
 b/src/openvpn/cryptoapi=2Ec</span><br><span>@@ -235,7 +235,7 @@</span><br>=
<span>         if (pvext &amp;&amp; cbext &gt;=3D sizeof(CERT_TEMPLATE_EXT)=
)</span><br><span>         {</span><br><span>             const CERT_TEMPLA=
TE_EXT *cte =3D (const CERT_TEMPLATE_EXT *)pvext;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            if (!stricmp(cert_prop, cte-&gt;psz=
ObjId))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (!_stricmp(cert_prop, cte-&gt;pszObjId))</span><br><span>             {<=
/span><br><span>                 /* found direct OID match with certificate=
 property specified */</span><br><span>                 gc_free(&amp;gc);</=
span><br><span>@@ -244,7 +244,7 @@</span><br><span> </span><br><span>      =
       const CRYPT_OID_INFO *tmpl_oid =3D</span><br><span>                 =
find_oid(CRYPT_OID_INFO_NAME_KEY, tmpl_name, CRYPT_TEMPLATE_OID_GROUP_ID);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (tmpl_o=
id &amp;&amp; !stricmp(tmpl_oid-&gt;pszOID, cte-&gt;pszObjId))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (tmpl_oid &amp;&a=
mp; !_stricmp(tmpl_oid-&gt;pszOID, cte-&gt;pszObjId))</span><br><span>     =
        {</span><br><span>                 /* found OID match in extension =
against resolved key */</span><br><span>                 gc_free(&amp;gc);<=
/span><br><span>diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvp=
nmsica/openvpnmsica=2Ec</span><br><span>index fdb610c=2E=2E9d12963 100644</=
span><br><span>--- a/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>+++ =
b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>@@ -508,7 +508,7 @@</sp=
an><br><span>             *iTicks +=3D MSICA_ADAPTER_TICK_SIZE;</span><br><=
span>             break;</span><br><span>         }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        else if (wcsicmp(szDisplayName, pAd=
apterOther-&gt;szName) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        else if (_wcsicmp(szDisplayName, pAdapterOther-&gt;szN=
ame) =3D=3D 0)</span><br><span>         {</span><br><span>             /* A=
dapter with a same name found=2E */</span><br><span>             for (LPCWS=
TR hwid =3D pAdapterOther-&gt;szzHardwareIDs;; hwid +=3D wcslen(hwid) + 1)<=
/span><br><span>@@ -521,7 +521,7 @@</span><br><span>                     dw=
Result =3D ERROR_ALREADY_EXISTS;</span><br><span>                     goto =
cleanup_pAdapterList;</span><br><span>                 }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                else if (wcsicmp(hwid, s=
zHardwareId) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                else if (_wcsicmp(hwid, szHardwareId) =3D=3D 0)</span><b=
r><span>                 {</span><br><span>                     /* This is =
an adapter with the requested hardware ID=2E We already have what we</span>=
<br><span>                      * want! */</span><br><span>@@ -583,7 +583,7=
 @@</span><br><span>     for (struct tap_adapter_node *pAdapter =3D pAdapte=
rList; pAdapter !=3D NULL;</span><br><span>          pAdapter =3D pAdapter-=
&gt;pNext)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (wcsicmp(szDisplayName, pAdapter-&gt;szName) =3D=3D =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (_wcsi=
cmp(szDisplayName, pAdapter-&gt;szName) =3D=3D 0)</span><br><span>         =
{</span><br><span>             /* Adapter found=2E */</span><br><span>     =
        WCHAR szArgument[8 /*disable=3D|enable=3D|delete=3D*/</span><br><sp=
an>@@ -1084,7 +1084,7 @@</span><br><span>                 for (struct tap_a=
dapter_node *pAdapter =3D pAdapterList; pAdapter !=3D NULL;</span><br><span=
>                      pAdapter =3D pAdapter-&gt;pNext)</span><br><span>   =
              {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              if (wcsicmp(szName, pAdapter-&gt;szName) =3D=3D 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    if (_wcsic=
mp(szName, pAdapter-&gt;szName) =3D=3D 0)</span><br><span>                 =
    {</span><br><span>                         /* Adapter found=2E */</span=
><br><span>                         dwResult =3D tap_delete_adapter(NULL, &=
amp;pAdapter-&gt;guid, &amp;bRebootRequired);</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1673?usp=3Demail">change 1673</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1673?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpat=
chset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: I04e35928244e6ecda8c58285a812516662b50742 </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 1673 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> G=
errit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--gePTILYzhPg=--


--===============2272730541935794850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2272730541935794850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2272730541935794850==--

