Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339AEC624D2
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aVSDE/p4hxs6BIR7AcwX30W1Fj4joVK3q6v0dSsVwGk=; b=eH9AhwLDIZS8r8ZoFtiuKXyFEq
	9rICG1wSi5VzplvLRAZ9XWVWzyAzIp5h4ciB3m3CQHa734+ik5uT2/zhJjKkSKy2guDPf+J2DlNFZ
	nKSN75je7BL53kwDUuPtgeWTHabp5rJ85U3A/bl7aVYExi2WHLIhe4fT6E9OQ4GJWlMs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1Nkq-0000AI-Bk;
	Tue, 01 Sep 2026 12:38:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1Nko-0000AC-LL
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:38:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5pJbmJTGZLmdfxiS9mQYtLVW8odQ5aqk99poCRDVKRc=; b=FB7CVHGs6VhuH8PGcRFm5S8zPR
 YIV3PICC/COoyDSRMMTYH/cyH3hUfvaP+e986yF9TNU+Aog9Car2xj63hJpAxvPknee56aFr2lexq
 UIUv0AzRTYLEcFs2D7i58MYOIqAnBNmxcxoPZqkBpNMaQQEPJQTf+kuRkwaL0/t3OvU4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5pJbmJTGZLmdfxiS9mQYtLVW8odQ5aqk99poCRDVKRc=; b=d
 jlqCP2IkvOejfykXicSaGl+rhlQeLZukyVDF/Agr8OTv56IdLogg9xYpuu7jgNAlX4X7rtDv7itIo
 GIr3SCwgo/8og/WYdTLT1s/sArxdaZwHUUzMuUInMxe2x9zYmwgrRI1HbHm3rrh+AdaDRtBlA/Z75
 v13hCW23z4jkn5ZA=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1Nkk-0007sB-T6 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:38:16 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49b8687630fso34315145e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 05:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788266288; x=1788871088; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5pJbmJTGZLmdfxiS9mQYtLVW8odQ5aqk99poCRDVKRc=;
 b=eukmgWyUVNUbw0RElDe4PwZmbZkeajeOInbRrSUfV89zjsNcKMDfZ8CnbIkwT4wK82
 zS5W9UYhG+ZEwfX6SgurBm6A+Y7v6DdpydCKWAVUVSeOxd2MOG/HyOnp2Gkj9XXOQKS9
 PRjmjBcB3rmUHCCEzMdSdWXwB0lul1LsT1j64ZMwJnulRHCSMSD4MFmGK2y8hzkvVHCl
 cXPmsHXDZZO4nu6L+FWsZKVSYgP71u6MkSJm19xb9055kZ+tReNkp1GhE1HXKE4e+ulj
 TRZZcjC0KDhryEiJE2g+NLfcMR9zLZKa1qsDIfAzYNfI/Au0IW5kzXv5DlrG/kVLfVew
 Qspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788266288; x=1788871088;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5pJbmJTGZLmdfxiS9mQYtLVW8odQ5aqk99poCRDVKRc=;
 b=aTaVLqJC+NL2/i1XbtvrpUDLIWiLapJ5om/+tJEOcc/EzFrQaA9ZKZFTVqJvm70nIj
 HLYJviRjxoGLp0K4QffCQhessDVGlcTevZSORWi4oKS+wiCngioL/FG74pBf8PD0jO9l
 5uXL3pbVoJkb6m2h3hd3ZgpEXSpSE4Bzpc2tkU/6F5F8S8q5X0ZORbl2bbeld5YgBmGi
 qDo0bVUAIlZTD0YnYHm3QpyIHudT4GV8c61lALBwi6r+MyFB5qgPZoD4yBDRNVP/GvRz
 P37ovCDsPws9khk9Toc8LnnFEZeWCXWqLJky6QG1+L/NJC9n7UUGc635qVul7Z7AqZtR
 FP2w==
X-Gm-Message-State: AFuF++lIVOt/sRvGVaOVFAEaBjo0atUJFj1aT2E29w3OeV7b3D7649v4
 Zd20FqeOusjU0xVWw/G1OO0SpJ1j1cjrEk9xQP9MdvDenUlBcvBH+QtoCyFeLzVjacNW7kS/9Uv
 kRFSHLdSC2nfQGP0nPwCVtrVbepjT7+1CwdNVMhbiPYYN6+v3J3VLY75nU9KX/cgY+Sh4x88QVE
 wv50MdQw==
X-Gm-Gg: AR+sD120mXRsXNVGrYYG96F8gECzFPhwxpoTlm/3fA+VQ11VLBgD32aiW+xg4MWKPo9
 n/DOhspiB9sl3eZ6rrsN+qWIcFlgOVwZ/xs4PVFuGFWQ26NceJGWoBlSuop4jOQWMDwsFaYqLcX
 KGG0eh+aKGseZiOYWt59IpMNy+wyg3b1RxsAd5fKRu7hrfHo6sBm7YVPHfYsNUS0SWRGHKlz5xk
 oLO8O4JDmEWa75ON41BRhsMAmojiAYw0EZWN3/+uugHj6OtGtEdisPTWaN5OhXYXhjVrxU22C7E
 Mij5vDU0EdZwQNKpvtFe5qFeFNdrcETYPuuX9qiSEBSxEX74KsySnnvcRipGt65ohRAtHpkxX5H
 cBfTS3+3SBbeYAQhPJHghf4mp7Z4oZht3IntbC8avAJII7ePPgqmeOedwp4jdMR7pLOULZROGaZ
 mfigWwgQdpIrz32n2XuAqceWB1onG1ijSAi1488VfNuFYWKF3DOkkgQrVVekrQfNKmN4r19/FLy
 86jRoaessM6PkhrjjLeD0U1ey+PU7+EQYLfjGmSmmxF2i1bU7q0V9vEIySufTU5TsHJRmnaFeBq
 w4gzN63OSVAg5kJtULfX5l/Z43avQv43YYSqA9h9Q8ZhjXsBFKkm
X-Received: by 2002:a05:600c:4f0e:b0:49b:9433:ea44 with SMTP id
 5b1f17b1804b1-49cdc40ff56mr171824645e9.4.1788266288028; 
 Tue, 01 Sep 2026 05:38:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdcdd9206sm65023635e9.0.2026.09.01.05.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 05:38:07 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 12:38:06 +0000
To: d12fk <heiko@openvpn.net>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182
X-Gerrit-Change-Number: 1886
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1886?usp=email>
X-Gerrit-Commit: 588af513aac1d2d774fd3fde1716384e3501a5a1
In-Reply-To: <gerrit.1788192180000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
References: <gerrit.1788192180000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTkyMTgwMDAwLkljOTgzYTNiZjFlZThkNGVmOThmMzg4M2Q1ZTVkZGYyMzQ2OTZhMTgyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d442772b4e62403f03850be50117d436e1d2bc0e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1Nkk-0007sB-T6
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: harden
 CheckConfigPath() a bit more
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0120717820131188865=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0120717820131188865==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sDg//+PhD0U="; charset=UTF-8

--sDg//+PhD0U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello d12fk, plaisthos, razvanc, 

I'd like you to reexamine a change=2E Pl=
ease visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1886?usp=3Demail
=

to look at the new patch set (#2)=2E

The following approvals got outdated=
 and were removed:
Code-Review+2 by razvanc


Change subject: openvpnserv: =
harden CheckConfigPath() a bit more
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

openvpnserv: harden CheckConfigPath() a bit more

If=
 the config_path retrieved from the Registry doesn't end with a path
sepata=
tor, the prefix check could be satisfied by a sibling directory
that starts=
 with the same substring, e=2Eg=2E "config" vs=2E "configx"=2E While
code i=
n common=2Ec ensures this, that code could disappear in the future
leaving =
the check vulnerable=2E Instead spend the few CPU cycles to be
absolutely s=
ure, we're doing the right thing here=2E

Discovered and reported by Breach=
X Zero Day Labs, using Typhon AI Mil v2=2E
Contributing Researcher: Vivek P=
arikh=2E

Reported-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
Tested-by=
: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
CVE: 2026-78043
Change-Id: Ic9=
83a3bf1ee8d4ef98f3883d5e5ddf234696a182
Signed-off-by: Heiko Hund <heiko@ist=
=2Eeigentlich=2Enet>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acke=
d-by: Arne Schwabe <arne@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1886
Message-Id: <20260831184709=2E3359-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg38854=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpnserv/validate=2Ec
1 file changed, 7 insertion=
s(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/86/1886/2

diff --git a/src/openvpnserv/validate=2Ec b/src/op=
envpnserv/validate=2Ec
index e3ef8b6=2E=2E8e529b9 100644
--- a/src/openvpns=
erv/validate=2Ec
+++ b/src/openvpnserv/validate=2Ec
@@ -62,7 +62,13 @@
 {
 =
    HRESULT res;
     WCHAR config_path[MAX_PATH];
+    const size_t config=
_dir_len =3D wcslen(s->config_dir);
 
+    /* config_dir must end with a '\=
' or the prefix check below could be satisfied by a sibling directory */
+ =
   if (config_dir_len =3D=3D 0 || s->config_dir[config_dir_len - 1] !=3D L'=
\\')
+    {
+        return FALSE;
+    }
     /* fname =3D stdin is specia=
l: do not treat it as a relative path */
     if (wcscmp(fname, L"stdin") =
=3D=3D 0)
     {
@@ -83,7 +89,7 @@
         res =3D PathCchCanonicalize(con=
fig_path, _countof(config_path), fname);
     }
 
-    return res =3D=3D S_=
OK && wcsnicmp(config_path, s->config_dir, wcslen(s->config_dir)) =3D=3D 0;=

+    return res =3D=3D S_OK && wcsnicmp(config_path, s->config_dir, config=
_dir_len) =3D=3D 0;
 }
 
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1886?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182
Gerrit-Change-Number: 1=
886
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit=
-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc =
<razvanc@mailbox=2Eorg>
Gerrit-CC: d12fk <heiko@openvpn=2Enet>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--sDg//+PhD0U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1886?usp=3Demail">View Change</a></p><p>The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by razvanc<=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">openvpnserv: harden CheckConfigPath() a bit more<br><br>If=
 the config_path retrieved from the Registry doesn&#39;t end with a path<br=
>sepatator, the prefix check could be satisfied by a sibling directory<br>t=
hat starts with the same substring, e=2Eg=2E &quot;config&quot; vs=2E &quot=
;configx&quot;=2E While<br>code in common=2Ec ensures this, that code could=
 disappear in the future<br>leaving the check vulnerable=2E Instead spend t=
he few CPU cycles to be<br>absolutely sure, we&#39;re doing the right thing=
 here=2E<br><br>Discovered and reported by BreachX Zero Day Labs, using Typ=
hon AI Mil v2=2E<br>Contributing Researcher: Vivek Parikh=2E<br><br>Reporte=
d-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>Tested-by: Vivek =
Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>CVE: 2026-78043<br>Change-Id:=
 Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182<br>Signed-off-by: Heiko Hund &lt=
;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1886<br>Message-Id: &=
lt;20260831184709=2E3359-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38854=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpnserv/validate=2Ec<br>1 file changed, 7 insertions(+), 1 delet=
ion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/86/1886/2</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/vali=
date=2Ec b/src/openvpnserv/validate=2Ec</span><br><span>index e3ef8b6=2E=2E=
8e529b9 100644</span><br><span>--- a/src/openvpnserv/validate=2Ec</span><br=
><span>+++ b/src/openvpnserv/validate=2Ec</span><br><span>@@ -62,7 +62,13 @=
@</span><br><span> {</span><br><span>     HRESULT res;</span><br><span>    =
 WCHAR config_path[MAX_PATH];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const size_t config_dir_len =3D wcslen(s-&gt;config_dir);</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* config_dir must end with a &#39;\&#39; or the prefix check below could be=
 satisfied by a sibling directory */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (config_dir_len =3D=3D 0 || s-&gt;config_dir[config=
_dir_len - 1] !=3D L&#39;\\&#39;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span>     /* fname =3D stdin is special: do not treat it=
 as a relative path */</span><br><span>     if (wcscmp(fname, L&quot;stdin&=
quot;) =3D=3D 0)</span><br><span>     {</span><br><span>@@ -83,7 +89,7 @@</=
span><br><span>         res =3D PathCchCanonicalize(config_path, _countof(c=
onfig_path), fname);</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return res =3D=3D S_OK &amp;&am=
p; wcsnicmp(config_path, s-&gt;config_dir, wcslen(s-&gt;config_dir)) =3D=3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return res =
=3D=3D S_OK &amp;&amp; wcsnicmp(config_path, s-&gt;config_dir, config_dir_l=
en) =3D=3D 0;</span><br><span> }</span><br><span> </span><br><span> </span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1886?usp=3Demail">change 1886</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1886?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883=
d5e5ddf234696a182 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1886 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--sDg//+PhD0U=--


--===============0120717820131188865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0120717820131188865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0120717820131188865==--

