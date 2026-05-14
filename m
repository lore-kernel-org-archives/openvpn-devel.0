Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F0BCD4F25
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 10:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jedPQqv3OHKjMQvdiplsVaO3TGpUP7xHutwfqu/AQfU=; b=P/wYdaAy8hvVjlAovkhkYpOxCt
	7XTMhwyM3olgqnGRvtDzKjH7OBMK71Cmk1qwRNXcUOGjzs5KpN0eu5XDjZ+WfxzWRqj6MCrXLwe+A
	rc0YHuMpjxOh/iVSFq43xypbLu2pO8p7gZz+y/Xjh+aCKLoc+QnLkS6FbfS0iGGCAo2k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNTKF-0006vQ-W0;
	Thu, 14 May 2026 10:29:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wNTKE-0006vG-R3
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:29:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=B5ZhXHfqViNCuOoL4bNZOpMYik87cIXEuiqARghkLzE=; b=KsXoLMxUrMANAd4DuuCblRMlhp
 B0gahstqeglYtDt1bmENM/8+C2hebTwqDUghvadlIkBjCwYB8vezXb3IsdDQDEmsNMXzWBRfm2gcN
 ZTVtK85Ck9C/lL56jXPiAsOLDVP0Zpmw6nyYyKzblxlttJKbcwtevwjzlvtQpwVJvGnQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=B5ZhXHfqViNCuOoL4bNZOpMYik87cIXEuiqARghkLzE=; b=D
 /CbCbVWsN4BZuI8+4efSValv6Z93keyioJ1nH4gLUSz/uaJo9CIOQKOFXAfbRF8ml3crXumTat5e5
 75hCTbaYcdFaHTVF05JVxwz63RPRqPNnIRVbHpWtJmAZ9wctQtF2dmOq3uEce6BRacWjmKNYLPYiZ
 DB06qx59yF+bKYFY=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNTKE-0006S2-5b for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:29:55 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so48992815e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 03:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778754583; x=1779359383; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B5ZhXHfqViNCuOoL4bNZOpMYik87cIXEuiqARghkLzE=;
 b=VecTG+GiQ/Pal6Vc81k1FZ9waLogNbBXze4MLe+rSYPys0mdyWXZYrIUuB6gWqzAva
 q4BvTC1RmkoJH1dAZBQg+PQp+LdEnZyHONsTsDyxGanHjhDkl13PLw5qp2SjBXaFc3kU
 QhfqAi9+o0BugJeM2CjZCc9KMV5+rnDtSTC/wxuzzWRP8pw1Y6DFeKGl2/3YsCvQsps0
 Cbzfz0L9sreQQKbikzcsPRu6QOrCbpJu8FOngutsIMQAqeeS/X1ptqBaSGMQMK3Z+Tut
 Vahk2TMoEZleSBJEeGvfWiMZtOQC4oGNkr2Ul1O/3FVJEowOEnPnenkttMUSF8bDdRxP
 loxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778754583; x=1779359383;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B5ZhXHfqViNCuOoL4bNZOpMYik87cIXEuiqARghkLzE=;
 b=fn2BvU2qtl3/pnYHDRRNXQWkBdb11foNxet5n41lcenGakWowz11WisVh/w2H1T1Gk
 OUs0Kukv1Csn8utWFDo0qTori9o3c8AJ6Xv0WWnJxDzvVRJCyQi11+H5/hZqcl4ChFRl
 cKxnM0P9HUdz8PSEwJ792S2T5fOVGwP4Du+Bbm5bB9lJZMU/Cy1xzTZ+iC+KsoRX21fP
 xvnXxzYkGaUE6HKQ5mEIcVFveAV7XXE/2idAgu6IoUyLuhLoDW1kEZJb/V2fNNCcjkHM
 NFFweQbuIlg7RB2a0qJTRjaYmFdtbSvyOoez7TP8KTLXqA+aKiA+tvqYvEAXZbBvWuTJ
 /Alw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8iIJiamEOjwxcM/IZuDqTebwQck15xDVsyrO8yp1JNU6waKAyX7dlmBPUGrCfqYulgWMEO9mZFHS5iwi+U@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx6iRjAmJVlcdJN78p6pxrCBS0WhPG7uazFJ9o2q0JQHHw4GvRL
 u+CWLOwIlrEtAXNYHWKW9OTHfRaLipKzGCHA8jQrsPUc0MnTOJIyM9cGKQgR3cSXdhbIm1i8XTA
 UjFNk+XwduZ4Ir2KY36kAfL4UT/0H90ulp16eDUsBjKiUsrnkoYmKIxnw99Nsr+x/UN7P
X-Gm-Gg: Acq92OGgsR7TdgG9PK0i6u121hsp1rEAAXepDJ417Tj8IB0niEMFYkWSzKGblSh0mlD
 Z9bAGWS8qfaNC33LQ2cuklT/ZGAcGEFKJt+m+Pc9Q5iuHltf7z5IKGDyImMR9RZEOTptSGhsXv5
 7RaNx8g+aJM0RzMCyaENwCOnZAkRzMV187g1VmW3luhQykyh/nBLGIFtfxyZv2h2OMlCGqLm53K
 PNSQr4mqxBNyT2jgdoDd0zVLGziXDhyrVFH07EN9U/AA9MuYFRrChKZmAsDlLy00qvEL+RBqs95
 XL4F21OlrFACcZEXoVM2fElbTt5xxa9qndr8XV0vqLfBwq1FPIci+qpLSf2nGh7OwBbklqNEZrY
 eEzLzQXZ1flsbcKgswlDGiwOIGXHODyJOLDp/MwD+xZg5ApC7XmePR7CCWh/4H9J8EkNmLdWKW0
 HHsZPBFTUClsoPhFgbTPulYne3perSIe/rAbLqq4/kp+/qnf9gARA/TrMki+FXr8KZPkVmqsnd6
 dWWD+Q7tHYdgX9H9ghPhEPmZI6OufMiEI0qyFgtcaAIAze0ShF/eq6vSSRcwgsDLNvkMZB60L6c
 nlpOFFjGOSGaT8wwg+D1de8X
X-Received: by 2002:a05:600c:a011:b0:48a:563c:c8c0 with SMTP id
 5b1f17b1804b1-48fc9a0e65emr113258315e9.7.1778754583047; 
 Thu, 14 May 2026 03:29:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fdafc6741sm24098115e9.2.2026.05.14.03.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 03:29:42 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 14 May 2026 10:29:41 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I04e35928244e6ecda8c58285a812516662b50742
X-Gerrit-Change-Number: 1673
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1673?usp=email>
X-Gerrit-Commit: d69a0dfe73de6aa698caa8580d3bf54e76bd0dca
In-Reply-To: <gerrit.1778239616000.I04e35928244e6ecda8c58285a812516662b50742@gerrit.openvpn.net>
References: <gerrit.1778239616000.I04e35928244e6ecda8c58285a812516662b50742@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkkwNGUzNTkyODI0NGU2ZWNkYThjNTgyODVhODEyNTE2NjYyYjUwNzQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8d9b370a58c067e89e8ab9918d6dcd985ccece2b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wNTKE-0006S2-5b
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 d12fk <heiko@openvpn.net>, plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2246937647118595219=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2246937647118595219==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DWucsZXMSEI="; charset=UTF-8

--DWucsZXMSEI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1673?usp=3Demail )

Change subject: Do not use deprecated aliases on Wi=
ndows
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Do not =
use deprecated aliases on Windows

Both these work perfectly fine but are d=
iscouraged
and might cause warnings by compilers=2E

Identified by cppcheck=
=2E

Change-Id: I04e35928244e6ecda8c58285a812516662b50742
Signed-off-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Heiko Hund <heiko@openv=
pn=2Enet>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1673
Messa=
ge-Id: <20260513150838=2E27382-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg36909=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
cryptoapi=2Ec
M src/openvpnmsica/openvpnmsica=2Ec
2 files changed, 6 insert=
ions(+), 6 deletions(-)




diff --git a/src/openvpn/cryptoapi=2Ec b/src/op=
envpn/cryptoapi=2Ec
index e17936a=2E=2Ebf80bbd 100644
--- a/src/openvpn/cry=
ptoapi=2Ec
+++ b/src/openvpn/cryptoapi=2Ec
@@ -235,7 +235,7 @@
         if =
(pvext && cbext >=3D sizeof(CERT_TEMPLATE_EXT))
         {
             con=
st CERT_TEMPLATE_EXT *cte =3D (const CERT_TEMPLATE_EXT *)pvext;
-          =
  if (!stricmp(cert_prop, cte->pszObjId))
+            if (!_stricmp(cert_p=
rop, cte->pszObjId))
             {
                 /* found direct OID ma=
tch with certificate property specified */
                 gc_free(&gc);
@=
@ -244,7 +244,7 @@
 
             const CRYPT_OID_INFO *tmpl_oid =3D
      =
           find_oid(CRYPT_OID_INFO_NAME_KEY, tmpl_name, CRYPT_TEMPLATE_OID_=
GROUP_ID);
-            if (tmpl_oid && !stricmp(tmpl_oid->pszOID, cte->psz=
ObjId))
+            if (tmpl_oid && !_stricmp(tmpl_oid->pszOID, cte->pszOb=
jId))
             {
                 /* found OID match in extension again=
st resolved key */
                 gc_free(&gc);
diff --git a/src/openvpnm=
sica/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec
index fdb610c=2E=
=2E9d12963 100644
--- a/src/openvpnmsica/openvpnmsica=2Ec
+++ b/src/openvpn=
msica/openvpnmsica=2Ec
@@ -508,7 +508,7 @@
             *iTicks +=3D MSICA_=
ADAPTER_TICK_SIZE;
             break;
         }
-        else if (wcsicmp=
(szDisplayName, pAdapterOther->szName) =3D=3D 0)
+        else if (_wcsicmp=
(szDisplayName, pAdapterOther->szName) =3D=3D 0)
         {
             /*=
 Adapter with a same name found=2E */
             for (LPCWSTR hwid =3D pA=
dapterOther->szzHardwareIDs;; hwid +=3D wcslen(hwid) + 1)
@@ -521,7 +521,7 =
@@
                     dwResult =3D ERROR_ALREADY_EXISTS;
                =
     goto cleanup_pAdapterList;
                 }
-                else if=
 (wcsicmp(hwid, szHardwareId) =3D=3D 0)
+                else if (_wcsicmp(=
hwid, szHardwareId) =3D=3D 0)
                 {
                     /* Th=
is is an adapter with the requested hardware ID=2E We already have what we
=
                      * want! */
@@ -583,7 +583,7 @@
     for (struct tap_a=
dapter_node *pAdapter =3D pAdapterList; pAdapter !=3D NULL;
          pAdap=
ter =3D pAdapter->pNext)
     {
-        if (wcsicmp(szDisplayName, pAdapte=
r->szName) =3D=3D 0)
+        if (_wcsicmp(szDisplayName, pAdapter->szName)=
 =3D=3D 0)
         {
             /* Adapter found=2E */
             WCHA=
R szArgument[8 /*disable=3D|enable=3D|delete=3D*/
@@ -1084,7 +1084,7 @@
   =
              for (struct tap_adapter_node *pAdapter =3D pAdapterList; pAda=
pter !=3D NULL;
                      pAdapter =3D pAdapter->pNext)
       =
          {
-                    if (wcsicmp(szName, pAdapter->szName) =3D=
=3D 0)
+                    if (_wcsicmp(szName, pAdapter->szName) =3D=3D 0=
)
                     {
                         /* Adapter found=2E */
  =
                       dwResult =3D tap_delete_adapter(NULL, &pAdapter->gui=
d, &bRebootRequired);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1673?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I04e35928244e6ecda8c58285a812516662b50742
Gerrit-Change-Number: 1673
Gerrit=
-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>

--DWucsZXMSEI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1673?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Do not use deprecated aliases on Windows<b=
r><br>Both these work perfectly fine but are discouraged<br>and might cause=
 warnings by compilers=2E<br><br>Identified by cppcheck=2E<br><br>Change-Id=
: I04e35928244e6ecda8c58285a812516662b50742<br>Signed-off-by: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Heiko Hund &lt;heiko@open=
vpn=2Enet&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/167=
3<br>Message-Id: &lt;20260513150838=2E27382-1-gert@greenie=2Emuc=2Ede&gt;<b=
r>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg36909=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/cryptoapi=2Ec<br>M src/openvpnmsica/open=
vpnmsica=2Ec<br>2 files changed, 6 insertions(+), 6 deletions(-)<br><br></p=
re>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/cryptoapi=2Ec b/src/openvpn/cryptoapi=2Ec</=
span><br><span>index e17936a=2E=2Ebf80bbd 100644</span><br><span>--- a/src/=
openvpn/cryptoapi=2Ec</span><br><span>+++ b/src/openvpn/cryptoapi=2Ec</span=
><br><span>@@ -235,7 +235,7 @@</span><br><span>         if (pvext &amp;&amp=
; cbext &gt;=3D sizeof(CERT_TEMPLATE_EXT))</span><br><span>         {</span=
><br><span>             const CERT_TEMPLATE_EXT *cte =3D (const CERT_TEMPLA=
TE_EXT *)pvext;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      if (!stricmp(cert_prop, cte-&gt;pszObjId))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            if (!_stricmp(cert_prop, cte-&gt;p=
szObjId))</span><br><span>             {</span><br><span>                 /=
* found direct OID match with certificate property specified */</span><br><=
span>                 gc_free(&amp;gc);</span><br><span>@@ -244,7 +244,7 @@=
</span><br><span> </span><br><span>             const CRYPT_OID_INFO *tmpl_=
oid =3D</span><br><span>                 find_oid(CRYPT_OID_INFO_NAME_KEY, =
tmpl_name, CRYPT_TEMPLATE_OID_GROUP_ID);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            if (tmpl_oid &amp;&amp; !stricmp(tmpl_oid-&g=
t;pszOID, cte-&gt;pszObjId))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (tmpl_oid &amp;&amp; !_stricmp(tmpl_oid-&gt;pszOID,=
 cte-&gt;pszObjId))</span><br><span>             {</span><br><span>        =
         /* found OID match in extension against resolved key */</span><br>=
<span>                 gc_free(&amp;gc);</span><br><span>diff --git a/src/o=
penvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec</span><br>=
<span>index fdb610c=2E=2E9d12963 100644</span><br><span>--- a/src/openvpnms=
ica/openvpnmsica=2Ec</span><br><span>+++ b/src/openvpnmsica/openvpnmsica=2E=
c</span><br><span>@@ -508,7 +508,7 @@</span><br><span>             *iTicks =
+=3D MSICA_ADAPTER_TICK_SIZE;</span><br><span>             break;</span><br=
><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    else if (wcsicmp(szDisplayName, pAdapterOther-&gt;szName) =3D=3D 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (_wcsic=
mp(szDisplayName, pAdapterOther-&gt;szName) =3D=3D 0)</span><br><span>     =
    {</span><br><span>             /* Adapter with a same name found=2E */<=
/span><br><span>             for (LPCWSTR hwid =3D pAdapterOther-&gt;szzHar=
dwareIDs;; hwid +=3D wcslen(hwid) + 1)</span><br><span>@@ -521,7 +521,7 @@<=
/span><br><span>                     dwResult =3D ERROR_ALREADY_EXISTS;</sp=
an><br><span>                     goto cleanup_pAdapterList;</span><br><spa=
n>                 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               else if (wcsicmp(hwid, szHardwareId) =3D=3D 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                else if (_wcsicmp=
(hwid, szHardwareId) =3D=3D 0)</span><br><span>                 {</span><br=
><span>                     /* This is an adapter with the requested hardwa=
re ID=2E We already have what we</span><br><span>                      * wa=
nt! */</span><br><span>@@ -583,7 +583,7 @@</span><br><span>     for (struct=
 tap_adapter_node *pAdapter =3D pAdapterList; pAdapter !=3D NULL;</span><br=
><span>          pAdapter =3D pAdapter-&gt;pNext)</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (wcsicmp(szDi=
splayName, pAdapter-&gt;szName) =3D=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (_wcsicmp(szDisplayName, pAdapter-&gt;szNa=
me) =3D=3D 0)</span><br><span>         {</span><br><span>             /* Ad=
apter found=2E */</span><br><span>             WCHAR szArgument[8 /*disable=
=3D|enable=3D|delete=3D*/</span><br><span>@@ -1084,7 +1084,7 @@</span><br><=
span>                 for (struct tap_adapter_node *pAdapter =3D pAdapterLi=
st; pAdapter !=3D NULL;</span><br><span>                      pAdapter =3D =
pAdapter-&gt;pNext)</span><br><span>                 {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    if (wcsicmp(szName, pA=
dapter-&gt;szName) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    if (_wcsicmp(szName, pAdapter-&gt;szName) =3D=
=3D 0)</span><br><span>                     {</span><br><span>             =
            /* Adapter found=2E */</span><br><span>                        =
 dwResult =3D tap_delete_adapter(NULL, &amp;pAdapter-&gt;guid, &amp;bReboot=
Required);</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1673?usp=3Demail">change 1673</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1673?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I04e359282=
44e6ecda8c58285a812516662b50742 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1673 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 =
</div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d1=
2fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>

</body></html>
--DWucsZXMSEI=--


--===============2246937647118595219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2246937647118595219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2246937647118595219==--

