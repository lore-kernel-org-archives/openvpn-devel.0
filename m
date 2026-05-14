Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42183CD4F39
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OyFxJaf8O5xt4E4AsKYTb8l5gI1+vmJi7DnDDPJjiAA=; b=lp3q9Y7FSYeJf4WZdZcaliyhAK
	nU/N+i3GcKnkresj2ZmtAX1uL/vwHYHl5f6P4ZTU2tERWbVMDFqASKHC/pZwD8Az5AEXy5vAJNnul
	01i83+kay+AyBGSGRZfbiYGBLcB3oxLT8b8W2JD8Mr7pfNlsTIHdj8fitLhHKtZ07Lfk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNVue-00072C-AK;
	Thu, 14 May 2026 13:15:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wNVuc-000724-6U
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 13:15:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MWW4sIULDKDhDPygEvOrQewzuC2RN8Umm7c9+Vu3f8U=; b=ZKkiDHkJe5x+q5RTgJLzFjcN5g
 /zDZuw4GJ1mK+3/7C0qlkZugaiUrCHAgnPMTP28IbXimIkqRJewPDxZl0tjUXwrUWdSIzgbnXW8HH
 or5vUGYp1ioU4Zt5LltrIV/8uFJYoRVNVNqT1nn/PECi7w+cbhwpKjL3A31u3EUtrnHs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MWW4sIULDKDhDPygEvOrQewzuC2RN8Umm7c9+Vu3f8U=; b=Y
 isicI7aIuEGek3XGnHQGPPV3Uf9/j19z5B+97RTW/LE0nYOzGuwlK11P8jH7PiQeKLeZrdfc/ajgr
 Fd3+qpIkTedQD72eXKRbL7vRYk/TdPPK3KtqEUi9I2IlCTK0cP44wrhWnaWbJGKUxW/SBPEyjEvyR
 buyObrI+/MIMdXrw=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNVua-0006sQ-JZ for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 13:15:38 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43d7e23defbso4764918f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 06:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778764525; x=1779369325; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MWW4sIULDKDhDPygEvOrQewzuC2RN8Umm7c9+Vu3f8U=;
 b=P640aDRdFI6T+xffdIJL2pVTXIEP09hpKJOZ30Uh1GmVOEaSm+KC3O1W/lg1M2VM5c
 0NzFlBPHpt5EG3G+zBWB0onfQCWpweqJMzkQhcC3hVOmxo/rUo8sLTu58yzzr+F5l3eI
 KKpEX9fiwVwcBFR2kY3+IIQPkt/9slzHYaGCo/oq6oPRLP2nHu16Rk0/BfIqCWt3zzrD
 gH0DsomiMZ22p1n+K1FiwjGnscxLdS1NaTcugb1hN1wxnDv6OUwKHkrmB0QlNBSHmKkz
 FugW0nXxkhaym7ofxWiruaGa/ETOjfH09sUYQJiNOmAtQa43K4uwKUUjMkMtFOJTlEI+
 IdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778764525; x=1779369325;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MWW4sIULDKDhDPygEvOrQewzuC2RN8Umm7c9+Vu3f8U=;
 b=kknHOvssxdPoQgv4e62hKfaRmh2+KigOwHUMUgqo8SVt0sQoQsieaniMyMostNFCFy
 mpo7QwGh+oDEuu2UNBZFnkdZErL3WokWrpAlgyjaqCUbbz3F/IK7yF/5c9X4BonTbw16
 3zqW9egU8FReM+jMaoEhXN+izPbnYbUjKeAsDnj8C3AtZiuz1cu1JfY+//PYswk4mgYv
 cgzp2Jo3+Kaglq0XtCbF36HCHhy2weH/d3R2umLa0WLKYw7KCiCJndoQqNK40+0MsLC9
 58u7ntNEqmrSd0vV1nmyFog7runi28zI14ZiytGt9kSPy4w+HYc5fGCqKpNwgBVkLIXU
 c4LA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FRG+4205m7XrIrv8P+BGilnG/JS7qlFj500AiCMXG0MiWyfljlTtDPUKF2Nc9eK/J7cTbOT6mAHo2qr4q@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxRx321nyd2/5OlsFSpwkI6HSGzmE05TAs/WcwXDr2iJdT/6xd7
 19rvQlXvL9yE+VofVgv5tE8qcu7j5pYX9dume4v9IS1G/fuKtEqIrsBE5PJTp4QeaAnDRDHrcMu
 w4Aed2GOn1pkVYYaA/FjXci4OXga60a0sd1UY644MNT3gqfhj6SBSjBMCC1H+P+CAiYvN
X-Gm-Gg: Acq92OGm/M1OBOmWV0Z+R2L1GZsq2UVHg8Bd6t/yyeqUXCn2ZYKL3E9zVhjJlC6RnbV
 pyX4aPbVzKBiySUpWm9SbZqAuLlySX398HCixJgTKpxqj+YVon3xNN5gb79HhURDAX+GKH7JBCQ
 XS0bkWhUCmHCUJU4p0QAV3+zmNukPTfGXo2EypvFGirN4EX0wlGp3gUHvQABU1G9gqcfO2gH63K
 WyYB2gf1fU6BeC242SNAUKtl+7dPtWP7dOLjT1pQmhHMOAPPyFxPGqkt16FtuBkbcAAiCUWZvNl
 pMUNkxGtgkGJTDMM3fj6YoYFXtQXqAX6njkbzi89VKQ6B1FlRb6r1MvZJVC4sKRBEDE7ofPq+DP
 +5fkj/6yuauLqzNG5oVexS2Iua52Cze26dN78qzaA22Dtc8hrWgGOm+ZylsUohSDSM0Qai0n9Uv
 3glX3AF+5A/VmBxrkZtZr+QBGLMlu6Q9uEvju3X4dn1hPWV/pA2P33j/7Ppx6vEcCacu4rT09ma
 /slX320+PCAEeylzIgcUs3x98oluiO/2/ppmLRdOinMgSLkDNkuwRLuYdu8TYTytZm4/kg51r8k
 VyYtzSVR5dWUuw==
X-Received: by 2002:a5d:5d87:0:b0:441:1c18:f779 with SMTP id
 ffacd0b85a97d-45c59cce4demr12313192f8f.37.1778764525431; 
 Thu, 14 May 2026 06:15:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767d0bsm6149031f8f.3.2026.05.14.06.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:15:25 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 14 May 2026 13:15:24 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48
X-Gerrit-Change-Number: 1670
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1670?usp=email>
X-Gerrit-Commit: ae63905eb97e036756352bfc1576e5f71ffc3873
In-Reply-To: <gerrit.1778239616000.Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48@gerrit.openvpn.net>
References: <gerrit.1778239616000.Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLklhZDNmMGMzNmFjMzc5NWZhNmExM2YyZDYzYmQwMGFkOWMyYzMwZDQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0b25f70838ca991dad0bcf814efdbdecd1bd6e51-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wNVua-0006sQ-JZ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: Fix
 memory leak when loading DLLs
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
Content-Type: multipart/mixed; boundary="===============2154535527028064934=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2154535527028064934==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FSq8SyFqstY="; charset=UTF-8

--FSq8SyFqstY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1670?usp=3Demail )

Change subject: openvpnserv: Fix memory leak when l=
oading DLLs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
penvpnserv: Fix memory leak when loading DLLs

Identified by cppcheck=2E

C=
hange-Id: Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48
Signed-off-by: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Acked-by: Heiko Hund <heiko@openvpn=2En=
et>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1670
Message-Id:=
 <20260514091512=2E17662-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg36913=2Ehtml
Sign=
ed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/int=
eractive=2Ec
1 file changed, 14 insertions(+), 6 deletions(-)




diff --gi=
t a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index=
 164f1bf=2E=2E7726bc9 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/sr=
c/openvpnserv/interactive=2Ec
@@ -1071,6 +1071,7 @@
     publish_fn_t RtlPu=
blishWnfStateData;
     const DWORD WNF_GPOL_SYSTEM_CHANGES_HI =3D 0x0D891E=
2A;
     const DWORD WNF_GPOL_SYSTEM_CHANGES_LO =3D 0xA3BC0875;
+    BOOL r=
et =3D FALSE;
 
     HMODULE ntdll =3D LoadLibraryA("ntdll=2Edll");
     if=
 (ntdll =3D=3D NULL)
@@ -1081,16 +1082,19 @@
     RtlPublishWnfStateData =
=3D (publish_fn_t)GetProcAddress(ntdll, "RtlPublishWnfStateData");
     if =
(RtlPublishWnfStateData =3D=3D NULL)
     {
-        return FALSE;
+       =
 goto cleanup;
     }
 
     if (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHA=
NGES_LO, WNF_GPOL_SYSTEM_CHANGES_HI, 0, 0, 0, 0)
         !=3D ERROR_SUCCES=
S)
     {
-        return FALSE;
+        goto cleanup;
     }
 
-    retur=
n TRUE;
+    ret =3D TRUE;
+cleanup:
+    FreeLibrary(ntdll);
+    return r=
et;
 }
 
 /**
@@ -1106,6 +1110,7 @@
                                      u=
nsigned int Length, INT64 ExplicitScope);
     publish_fn_t RtlPublishWnfSt=
ateData;
     const INT64 WNF_GPOL_SYSTEM_CHANGES =3D 0x0D891E2AA3BC0875;
+=
    BOOL ret =3D FALSE;
 
     HMODULE ntdll =3D LoadLibraryA("ntdll=2Edll"=
);
     if (ntdll =3D=3D NULL)
@@ -1116,15 +1121,18 @@
     RtlPublishWnfSt=
ateData =3D (publish_fn_t)GetProcAddress(ntdll, "RtlPublishWnfStateData");
=
     if (RtlPublishWnfStateData =3D=3D NULL)
     {
-        return FALSE;
=
+        goto cleanup;
     }
 
     if (RtlPublishWnfStateData(WNF_GPOL_SY=
STEM_CHANGES, 0, 0, 0, 0) !=3D ERROR_SUCCESS)
     {
-        return FALSE;=

+        goto cleanup;
     }
 
-    return TRUE;
+    ret =3D TRUE;
+clea=
nup:
+    FreeLibrary(ntdll);
+    return ret;
 }
 
 /**

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1670?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d4=
8
Gerrit-Change-Number: 1670
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>

--FSq8SyFqstY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1670?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">openvpnserv: Fix memory leak when loading =
DLLs<br><br>Identified by cppcheck=2E<br><br>Change-Id: Iad3f0c36ac3795fa6a=
13f2d63bd00ad9c2c30d48<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt;<br>Acked-by: Heiko Hund &lt;heiko@openvpn=2Enet&gt;<br>Gerr=
it URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1670<br>Message-Id: &lt;=
20260514091512=2E17662-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg36913=2Ehtml<=
br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =
src/openvpnserv/interactive=2Ec<br>1 file changed, 14 insertions(+), 6 dele=
tions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/sr=
c/openvpnserv/interactive=2Ec</span><br><span>index 164f1bf=2E=2E7726bc9 10=
0644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>=
+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -1071,6 +1071,7 @@=
</span><br><span>     publish_fn_t RtlPublishWnfStateData;</span><br><span>=
     const DWORD WNF_GPOL_SYSTEM_CHANGES_HI =3D 0x0D891E2A;</span><br><span=
>     const DWORD WNF_GPOL_SYSTEM_CHANGES_LO =3D 0xA3BC0875;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    BOOL ret =3D FALSE;</span><br>=
<span> </span><br><span>     HMODULE ntdll =3D LoadLibraryA(&quot;ntdll=2Ed=
ll&quot;);</span><br><span>     if (ntdll =3D=3D NULL)</span><br><span>@@ -=
1081,16 +1082,19 @@</span><br><span>     RtlPublishWnfStateData =3D (publis=
h_fn_t)GetProcAddress(ntdll, &quot;RtlPublishWnfStateData&quot;);</span><br=
><span>     if (RtlPublishWnfStateData =3D=3D NULL)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return FALSE;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto cleanup=
;</span><br><span>     }</span><br><span> </span><br><span>     if (RtlPubl=
ishWnfStateData(WNF_GPOL_SYSTEM_CHANGES_LO, WNF_GPOL_SYSTEM_CHANGES_HI, 0, =
0, 0, 0)</span><br><span>         !=3D ERROR_SUCCESS)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return FALSE=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto clean=
up;</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return TRUE;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ret =3D TRUE;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+cleanup:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    FreeLibrary(ntdll);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return ret;</span><br><span> }</span><br><span> </span><br><=
span> /**</span><br><span>@@ -1106,6 +1110,7 @@</span><br><span>           =
                           unsigned int Length, INT64 ExplicitScope);</span=
><br><span>     publish_fn_t RtlPublishWnfStateData;</span><br><span>     c=
onst INT64 WNF_GPOL_SYSTEM_CHANGES =3D 0x0D891E2AA3BC0875;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    BOOL ret =3D FALSE;</span><br><s=
pan> </span><br><span>     HMODULE ntdll =3D LoadLibraryA(&quot;ntdll=2Edll=
&quot;);</span><br><span>     if (ntdll =3D=3D NULL)</span><br><span>@@ -11=
16,15 +1121,18 @@</span><br><span>     RtlPublishWnfStateData =3D (publish_=
fn_t)GetProcAddress(ntdll, &quot;RtlPublishWnfStateData&quot;);</span><br><=
span>     if (RtlPublishWnfStateData =3D=3D NULL)</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        return FALSE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto cleanup;<=
/span><br><span>     }</span><br><span> </span><br><span>     if (RtlPublis=
hWnfStateData(WNF_GPOL_SYSTEM_CHANGES, 0, 0, 0, 0) !=3D ERROR_SUCCESS)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       goto cleanup;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return TRUE;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ret =3D TRUE;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+cleanup:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    FreeLibrary(ntdll);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return ret;</span><br><span> }</span><br><s=
pan> </span><br><span> /**</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1670?usp=3Demail">c=
hange 1670</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1670?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1670 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>

</body></html>
--FSq8SyFqstY=--


--===============2154535527028064934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2154535527028064934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2154535527028064934==--

