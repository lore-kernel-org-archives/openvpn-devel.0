Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE50ACA5FA1
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=hx/mkWq81F91ICHEkdZMjGCKoiUZHIF0rxcLPGjJiXo=; b=laMYjLleW5UJwn
	zR4lYeB5L7fV9tRrQIOMaTe9Ip2d+yAVxKUEbptIyfo6SOzCy+sWu+lYgdU5xmzQ2Sh/BvaNdOmPx
	yLf1E4hUhWF5s6JXM19QJK77vpe3NSspXbN+X7qGA9F8SdG9yR3BBRHl/ysI2PSPaAL8WLlEYvXW3
	51w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBDZ0-00030a-P0;
	Mon, 28 Sep 2026 15:46:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBDZ0-00030T-2T
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 15:46:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NS8ThFLFRjQG0D2WIyJmw6+sOzxwVY3I39iTuhkUx80=; b=lexI9vGGdcFCzuhdQriTbQ+iIw
 c7JT+5VRbj523NuCXmuVUrWqOgznv4+mUVRBYWD4mPqIK2/EiAqaKh7dcquuTNPbL1RM3OgVn1o2S
 XZGfka+PidXZOqCBEZFA2HTyXg3imxujyBvQOA2LS2SdgToohalMoDGIlCJogcFD3aHI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NS8ThFLFRjQG0D2WIyJmw6+sOzxwVY3I39iTuhkUx80=; b=i
 WjMu/ZSQa/8RGiPi03nn1CF5pZR1So8+ENrMf4S3tTiL4l7Ex6XrLitHFS4Pyu9lHMi+9fkgr3AEk
 L7WNzYfNjHIFtt2av63+ooK8emzI56fe6x4fzjUxEKb8gO3s4E4ZfIPyg+UkHmxugmlZ+azAlM79Y
 hl56D2GnYSSxGL2s=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBDYy-00007x-Ma for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 15:46:45 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4887f690df6so2274489f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790610398; x=1791215198; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NS8ThFLFRjQG0D2WIyJmw6+sOzxwVY3I39iTuhkUx80=;
 b=UvNfxl350H1ugmu+FSPh3zB49P+9k3TSpoHHJzMdm/N35NTh05sLrZ4t5lY2tKshU4
 hmWXe/58kVWefrsShxJ3Pwpfci7LxqMMmOHSFMR/DM0lgVxzxupLMdD0dcPRXZ48CZ0F
 nGfVNPsv/MjdXEvJVtKpuucGS7HKUaIoNJun/mrpxLKDEAgAzSMf6GHzvfq5B8s7PUPB
 8LB1yFW1YL+YDQm4RL502GY1UOaL04/N6XYFsFcGWCoIfqPfVuDfCmEP+h5F1hCFory8
 oHLGnYcvR2WXjZod9tCcZOE3NMBwJL7xonkK705/UZmtaqYxEASo0YbRzj68qvrh3bEI
 lyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790610398; x=1791215198;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NS8ThFLFRjQG0D2WIyJmw6+sOzxwVY3I39iTuhkUx80=;
 b=m+02yZS4N58dON2UF9h5ndXpdlfzoonGMxlZW3jx4yjASi9QzoMXS/YZz6xD2p7aP2
 alr2QxujSYdAJzOHFUxYOB2TcPaFIRfc5oF896G8C1d/VxbIC4E2Dx292VM9ufzvJyGM
 omClBvBKGPWXeXTR67HOeplW0rnA3Ux/36+naL/b9LnlsyWQcFAg4fPUG7g4ZMY/OMQJ
 fsxOpXsGdpPbbm6h2YNXMv0LWuUzEusqZM/k9UYlCNQJjRs3vJaadY99YNifj5DdmQN9
 4Dx7ffcJFsWmwKEX1G2Xn6Vq360IX+zuqPlTHrNFHmSOgvOJ74YaxzCvVURzgqTj0A9x
 KnbA==
X-Gm-Message-State: AFuF++m7iXfAsQz6HXK/jHQOxNgNw9ieHik1NzVRi9rPaT+m5vayCFco
 cUvcWcLEbRCU4YD6yY1CPjddrNEE/6GYKl81uxgkQ2ZBmSRuoPXO8RcTihdsbgtPwgVXuGt9GEL
 V3Qm4SYlOilvMkxVyGPCc4t2rnNOCsh1txiVG7NQxh87oVoE7qmzqHrnne+f06Anzf12shstuhx
 c06JGZfw==
X-Gm-Gg: AYBFou1inKavs76JHWchl/OF6/dqOLROPOiB6ZHUI8zYxVSX28Wzn/2kc/9t2hx3G/o
 ua0oRpmge7k2zfuR9vKWFz/EkYjCajO5xErQG9Zn7ShUBbQIH6AC9RsN2pJCqcd+tfWKsCo/cEh
 klzTH3giMcYHRRiR2NIJ7Xo8T682C+iOrUnPJUwYSV2ADZxTwQRO5asOHgRiOrwbA7ih4vhAyoR
 aT7M52NGY3ji3OoeQNBGFkCQPjLbK+NJytaRKDr5oxbiAjuB06OsABE1JsavDTtGhXeRUeFr2gB
 pWk2Z9M9NI0QIKud1dAdvpQOVsDkDTGiruehBfo/t7BdCtesIYeMZaeQg/Hkh+mPQBI3p0QCIiY
 FhkTmLGLmvk2JtQ164l9qlNPpmgpP6vTTBd6Da9NZHEu0TiRU+uGPRhxf5KjT8XQlS6qgOd9fhV
 Z42Ozy1sLgobCO3IRGtBc97LDeSCKComm7cYwyftSsA5pDQxuJ5CgM/Oc3SgUEsDKFxsTHYmC9I
 69PrXVfolzuwDJtNFoqjz6woBrazT1oC2LPt83Kc59s+XFsPwQZMzMd4lqbs8SIZMQOs3GrxItV
 GEYBZs8T7MPQGfIijQN4Lr5MEmb+pcRUV/Y09s2HQrAlXuKkW+R/9/CQVipZ
X-Received: by 2002:a05:600c:4505:b0:49b:9105:cdaf with SMTP id
 5b1f17b1804b1-49fe66d069dmr214029185e9.8.1790610397855; 
 Mon, 28 Sep 2026 08:46:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64f9bcsm28566906f8f.32.2026.09.28.08.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:46:37 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 15:46:36 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I39b3b31983a2d6348fd66266448f8d13e53a422c
X-Gerrit-Change-Number: 1959
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1959?usp=email>
X-Gerrit-Commit: 3b15daff6b7dee077609649785b7ad9187d9d851
References: <gerrit.1790610390000.I39b3b31983a2d6348fd66266448f8d13e53a422c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjEwMzkwMDAwLkkzOWIzYjMxOTgzYTJkNjM0OGZkNjYyNjY0NDhmOGQxM2U1M2E0MjJjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5757a59f346e9ab67db0c4ce7a1e48f53562c0d8-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBDYy-00007x-Ma
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnmscia: Fix
 some ugly code formatting
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6092241718853250474=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6092241718853250474==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Jrzmo+AtNrQ="; charset=UTF-8

--Jrzmo+AtNrQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1959?usp=3Demail

to review the following change=2E


Chang=
e subject: openvpnmscia: Fix some ugly code formatting
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnmscia: Fix some ugly cod=
e formatting

Trailing comments lead to some ugliness due
to clang-format f=
ormatting=2E Make nicer=2E

Change-Id: I39b3b31983a2d6348fd66266448f8d13e53=
a422c
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/=
openvpnmsica/openvpnmsica=2Ec
1 file changed, 31 insertions(+), 23 deletion=
s(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
59/1959/1

diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsic=
a/openvpnmsica=2Ec
index 25fa1e4=2E=2Ee510e4d 100644
--- a/src/openvpnmsica=
/openvpnmsica=2Ec
+++ b/src/openvpnmsica/openvpnmsica=2Ec
@@ -185,9 +185,9 =
@@
         free(pAdapterAdresses);
         if (ulResult !=3D ERROR_BUFFER=
_OVERFLOW)
         {
-            SetLastError(
-                ulResult)=
; /* MSDN does not mention GetAdaptersAddresses() to set GetLastError()=2E
=
-                              But we do have an error code=2E Set last err=
or manually=2E */
+            /* MSDN does not mention GetAdaptersAddresse=
s() to set GetLastError()=2E
+             * But we do have an error code=
=2E Set last error manually=2E */
+            SetLastError(ulResult);
    =
         msg(M_NONFATAL | M_ERRNO, "%s: GetAdaptersAddresses() failed", __F=
UNCTION__);
             uiResult =3D ulResult;
             goto cleanup_p=
AdapterList;
@@ -290,8 +290,9 @@
     uiResult =3D MsiSetProperty(hInstall,=
 szActiveAdaptersPropertyName, szAdaptersActive);
     if (uiResult !=3D ER=
ROR_SUCCESS)
     {
-        SetLastError(uiResult); /* MSDN does not menti=
on MsiSetProperty() to set GetLastError()=2E But
-                         =
          we do have an error code=2E Set last error manually=2E */
+      =
  /* MSDN does not mention MsiSetProperty() to set GetLastError()=2E But
+ =
        * we do have an error code=2E Set last error manually=2E */
+      =
  SetLastError(uiResult);
         msg(M_NONFATAL | M_ERRNO, "%s: MsiSetPro=
perty(\"%s\") failed", __FUNCTION__,
             szActiveAdaptersPropertyN=
ame);
         goto cleanup_szAdaptersActive;
@@ -386,8 +387,9 @@
     uiRe=
sult =3D MsiRecordSetString(hRecord, 0, L"\"[#bin=2Eopenvpn_gui=2Eexe]\"");=

     if (uiResult !=3D ERROR_SUCCESS)
     {
-        SetLastError(uiResul=
t); /* MSDN does not mention MsiRecordSetString() to set GetLastError()=2E
=
-                                   But we do have an error code=2E Set las=
t error manually=2E */
+        /* MSDN does not mention MsiRecordSetString=
() to set GetLastError()=2E
+         * But we do have an error code=2E Set=
 last error manually=2E */
+        SetLastError(uiResult);
         msg(M_=
NONFATAL | M_ERRNO, "%s: MsiRecordSetString failed", __FUNCTION__);
       =
  goto cleanup_MsiCreateRecord;
     }
@@ -412,16 +414,17 @@
     }
     if=
 (uiResult !=3D ERROR_SUCCESS)
     {
-        SetLastError(uiResult); /* M=
SDN does not mention MsiFormatRecord() to set GetLastError()=2E
-          =
                         But we do have an error code=2E Set last error man=
ually=2E */
+        /* MSDN does not mention MsiFormatRecord() to set GetL=
astError()=2E
+         * But we do have an error code=2E Set last error ma=
nually=2E */
+        SetLastError(uiResult);
         msg(M_NONFATAL | M_E=
RRNO, "%s: MsiFormatRecord failed", __FUNCTION__);
         goto cleanup_ma=
lloc_szPath;
     }
 
     /* Launch the OpenVPN GUI=2E */
     SHELLEXECUT=
EINFO sei =3D { =2EcbSize =3D sizeof(SHELLEXECUTEINFO),
-                  =
           =2EfMask =3D
-                                 SEE_MASK_FLAG_NO_=
UI, /* Don't show error UI, we'll display it=2E */
+                       =
      /* Don't show error UI, we'll display it=2E */
+                     =
        =2EfMask =3D SEE_MASK_FLAG_NO_UI,
                              =2E=
lpFile =3D szPath,
                              =2EnShow =3D SW_SHOWNORMAL=
 };
     if (!ShellExecuteEx(&sei))
@@ -528,7 +531,8 @@
                   =
  break;
                 }
             }
-            break; /* Adapter n=
ames are unique=2E There should be no other adapter with this name=2E */
+ =
           /* Adapter names are unique=2E There should be no other adapter =
with this name=2E */
+            break;
         }
     }
 
@@ -614,7 +618=
,8 @@
             }
 
             *iTicks +=3D MSICA_ADAPTER_TICK_SIZE;
-=
            break; /* Adapter names are unique=2E There should be no other =
adapter with this name=2E */
+            /* Adapter names are unique=2E Th=
ere should be no other adapter with this name=2E */
+            break;
   =
      }
     }
 
@@ -678,9 +683,9 @@
     uiResult =3D MsiDatabaseOpenView(=
hDatabase, szQuery, &hViewST);
     if (uiResult !=3D ERROR_SUCCESS)
     {=

-        SetLastError(
-            uiResult); /* MSDN does not mention Ms=
iDatabaseOpenView() to set GetLastError()=2E But we
-                      =
    do have an error code=2E Set last error manually=2E */
+        /* MSDN=
 does not mention MsiDatabaseOpenView() to set GetLastError()=2E But we
+  =
       * do have an error code=2E Set last error manually=2E */
+        Se=
tLastError(uiResult);
         msg(M_NONFATAL | M_ERRNO, "%s: MsiDatabaseOp=
enView(\"%ls\") failed", __FUNCTION__, szQuery);
         goto cleanup_hDat=
abase;
     }
@@ -689,8 +694,9 @@
     uiResult =3D MsiViewExecute(hViewST,=
 0);
     if (uiResult !=3D ERROR_SUCCESS)
     {
-        SetLastError(uiR=
esult); /* MSDN does not mention MsiViewExecute() to set GetLastError()=2E =
But
-                                   we do have an error code=2E Set las=
t error manually=2E */
+        /* MSDN does not mention MsiViewExecute() t=
o set GetLastError()=2E But
+         * we do have an error code=2E Set las=
t error manually=2E */
+        SetLastError(uiResult);
         msg(M_NONF=
ATAL | M_ERRNO, "%s: MsiViewExecute(\"%ls\") failed", __FUNCTION__, szQuery=
);
         goto cleanup_hViewST;
     }
@@ -715,8 +721,9 @@
         }
   =
      else if (uiResult !=3D ERROR_SUCCESS)
         {
-            SetLast=
Error(uiResult); /* MSDN does not mention MsiViewFetch() to set GetLastErro=
r()=2E
-                                       But we do have an error code=
=2E Set last error manually=2E */
+            /* MSDN does not mention Msi=
ViewFetch() to set GetLastError()=2E
+             * But we do have an erro=
r code=2E Set last error manually=2E */
+            SetLastError(uiResult)=
;
             msg(M_NONFATAL | M_ERRNO, "%s: MsiViewFetch failed", __FUNCT=
ION__);
             goto cleanup_hRecordProg;
         }
@@ -735,9 +742,10=
 @@
             uiResult =3D MsiGetComponentState(hInstall, szValue, &iIns=
talled, &iAction);
             if (uiResult !=3D ERROR_SUCCESS)
          =
   {
-                SetLastError(uiResult); /* MSDN does not mention MsiG=
etComponentState() to set
-                                           GetLa=
stError()=2E But we do have an error code=2E Set last
-                    =
                       error manually=2E */
+                /* MSDN does n=
ot mention MsiGetComponentState() to set
+                 * GetLastError()=
=2E But we do have an error code=2E Set last
+                 * error manu=
ally=2E */
+                SetLastError(uiResult);
                 msg(M_=
NONFATAL | M_ERRNO, "%s: MsiGetComponentState(\"%ls\") failed", __FUNCTION_=
_,
                     szValue);
                 free(szValue);

-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1959?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I39b3b31983a2d6348fd6626644=
8f8d13e53a422c
Gerrit-Change-Number: 1959
Gerrit-PatchSet: 1
Gerrit-Owner: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--Jrzmo+AtNrQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1959?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">openvpnmscia: Fix some ugly code formatting<br><br>Trailing comments l=
ead to some ugliness due<br>to clang-format formatting=2E Make nicer=2E<br>=
<br>Change-Id: I39b3b31983a2d6348fd66266448f8d13e53a422c<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpnms=
ica/openvpnmsica=2Ec<br>1 file changed, 31 insertions(+), 23 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/59/1959/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpnmsica/openvpnmsic=
a=2Ec b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>index 25fa1e4=2E=
=2Ee510e4d 100644</span><br><span>--- a/src/openvpnmsica/openvpnmsica=2Ec</=
span><br><span>+++ b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>@@ -=
185,9 +185,9 @@</span><br><span>         free(pAdapterAdresses);</span><br>=
<span>         if (ulResult !=3D ERROR_BUFFER_OVERFLOW)</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            Se=
tLastError(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      ulResult); /* MSDN does not mention GetAdaptersAddresses() to set Get=
LastError()=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                       But we do have an error code=2E Set last error manua=
lly=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  /* MSDN does not mention GetAdaptersAddresses() to set GetLastError()=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * But w=
e do have an error code=2E Set last error manually=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            SetLastError(ulResult);</s=
pan><br><span>             msg(M_NONFATAL | M_ERRNO, &quot;%s: GetAdaptersA=
ddresses() failed&quot;, __FUNCTION__);</span><br><span>             uiResu=
lt =3D ulResult;</span><br><span>             goto cleanup_pAdapterList;</s=
pan><br><span>@@ -290,8 +290,9 @@</span><br><span>     uiResult =3D MsiSetP=
roperty(hInstall, szActiveAdaptersPropertyName, szAdaptersActive);</span><b=
r><span>     if (uiResult !=3D ERROR_SUCCESS)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        SetLastError(uiResul=
t); /* MSDN does not mention MsiSetProperty() to set GetLastError()=2E But<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
             we do have an error code=2E Set last error manually=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* MSDN does not=
 mention MsiSetProperty() to set GetLastError()=2E But</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         * we do have an error code=2E S=
et last error manually=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        SetLastError(uiResult);</span><br><span>         msg(M_NON=
FATAL | M_ERRNO, &quot;%s: MsiSetProperty(\&quot;%s\&quot;) failed&quot;, _=
_FUNCTION__,</span><br><span>             szActiveAdaptersPropertyName);</s=
pan><br><span>         goto cleanup_szAdaptersActive;</span><br><span>@@ -3=
86,8 +387,9 @@</span><br><span>     uiResult =3D MsiRecordSetString(hRecord=
, 0, L&quot;\&quot;[#bin=2Eopenvpn_gui=2Eexe]\&quot;&quot;);</span><br><spa=
n>     if (uiResult !=3D ERROR_SUCCESS)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        SetLastError(uiResult); /*=
 MSDN does not mention MsiRecordSetString() to set GetLastError()=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
       But we do have an error code=2E Set last error manually=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* MSDN does not m=
ention MsiRecordSetString() to set GetLastError()=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * But we do have an error code=
=2E Set last error manually=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        SetLastError(uiResult);</span><br><span>         msg(=
M_NONFATAL | M_ERRNO, &quot;%s: MsiRecordSetString failed&quot;, __FUNCTION=
__);</span><br><span>         goto cleanup_MsiCreateRecord;</span><br><span=
>     }</span><br><span>@@ -412,16 +414,17 @@</span><br><span>     }</span>=
<br><span>     if (uiResult !=3D ERROR_SUCCESS)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        SetLastError(uiRes=
ult); /* MSDN does not mention MsiFormatRecord() to set GetLastError()=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
            But we do have an error code=2E Set last error manually=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* MSDN does =
not mention MsiFormatRecord() to set GetLastError()=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         * But we do have an error code=
=2E Set last error manually=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        SetLastError(uiResult);</span><br><span>         msg(=
M_NONFATAL | M_ERRNO, &quot;%s: MsiFormatRecord failed&quot;, __FUNCTION__)=
;</span><br><span>         goto cleanup_malloc_szPath;</span><br><span>    =
 }</span><br><span> </span><br><span>     /* Launch the OpenVPN GUI=2E */</=
span><br><span>     SHELLEXECUTEINFO sei =3D { =2EcbSize =3D sizeof(SHELLEX=
ECUTEINFO),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                   =2EfMask =3D</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                 SEE_MASK_FLAG_NO_UI, /* Don&#39;=
t show error UI, we&#39;ll display it=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                             /* Don&#39;t show erro=
r UI, we&#39;ll display it=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                             =2EfMask =3D SEE_MASK_FLAG_NO_UI,=
</span><br><span>                              =2ElpFile =3D szPath,</span>=
<br><span>                              =2EnShow =3D SW_SHOWNORMAL };</span=
><br><span>     if (!ShellExecuteEx(&amp;sei))</span><br><span>@@ -528,7 +5=
31,8 @@</span><br><span>                     break;</span><br><span>       =
          }</span><br><span>             }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            break; /* Adapter names are unique=2E Ther=
e should be no other adapter with this name=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            /* Adapter names are unique=2E Th=
ere should be no other adapter with this name=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span>      =
   }</span><br><span>     }</span><br><span> </span><br><span>@@ -614,7 +61=
8,8 @@</span><br><span>             }</span><br><span> </span><br><span>   =
          *iTicks +=3D MSICA_ADAPTER_TICK_SIZE;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            break; /* Adapter names are unique=2E=
 There should be no other adapter with this name=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            /* Adapter names are unique=
=2E There should be no other adapter with this name=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span>  =
       }</span><br><span>     }</span><br><span> </span><br><span>@@ -678,9=
 +683,9 @@</span><br><span>     uiResult =3D MsiDatabaseOpenView(hDatabase,=
 szQuery, &amp;hViewST);</span><br><span>     if (uiResult !=3D ERROR_SUCCE=
SS)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        SetLastError(</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            uiResult); /* MSDN does not mention MsiDatabaseOpenView() =
to set GetLastError()=2E But we</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                          do have an error code=2E Set last error=
 manually=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* MSDN does not mention MsiDatabaseOpenView() to set GetLastError()=2E=
 But we</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * d=
o have an error code=2E Set last error manually=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        SetLastError(uiResult);</span><br=
><span>         msg(M_NONFATAL | M_ERRNO, &quot;%s: MsiDatabaseOpenView(\&q=
uot;%ls\&quot;) failed&quot;, __FUNCTION__, szQuery);</span><br><span>     =
    goto cleanup_hDatabase;</span><br><span>     }</span><br><span>@@ -689,=
8 +694,9 @@</span><br><span>     uiResult =3D MsiViewExecute(hViewST, 0);</=
span><br><span>     if (uiResult !=3D ERROR_SUCCESS)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        SetLastError(=
uiResult); /* MSDN does not mention MsiViewExecute() to set GetLastError()=
=2E But</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
                     we do have an error code=2E Set last error manually=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* MSDN =
does not mention MsiViewExecute() to set GetLastError()=2E But</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         * we do have an error c=
ode=2E Set last error manually=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        SetLastError(uiResult);</span><br><span>         m=
sg(M_NONFATAL | M_ERRNO, &quot;%s: MsiViewExecute(\&quot;%ls\&quot;) failed=
&quot;, __FUNCTION__, szQuery);</span><br><span>         goto cleanup_hView=
ST;</span><br><span>     }</span><br><span>@@ -715,8 +721,9 @@</span><br><s=
pan>         }</span><br><span>         else if (uiResult !=3D ERROR_SUCCES=
S)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            SetLastError(uiResult); /* MSDN does not mention MsiVie=
wFetch() to set GetLastError()=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                       But we do have an error =
code=2E Set last error manually=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            /* MSDN does not mention MsiViewFetch() to se=
t GetLastError()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
             * But we do have an error code=2E Set last error manually=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            SetLas=
tError(uiResult);</span><br><span>             msg(M_NONFATAL | M_ERRNO, &q=
uot;%s: MsiViewFetch failed&quot;, __FUNCTION__);</span><br><span>         =
    goto cleanup_hRecordProg;</span><br><span>         }</span><br><span>@@=
 -735,9 +742,10 @@</span><br><span>             uiResult =3D MsiGetComponen=
tState(hInstall, szValue, &amp;iInstalled, &amp;iAction);</span><br><span> =
            if (uiResult !=3D ERROR_SUCCESS)</span><br><span>             {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                SetLa=
stError(uiResult); /* MSDN does not mention MsiGetComponentState() to set</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
                    GetLastError()=2E But we do have an error code=2E Set l=
ast</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
                         error manually=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                /* MSDN does not mention MsiGetCo=
mponentState() to set</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                 * GetLastError()=2E But we do have an error code=2E Set =
last</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
  * error manually=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                SetLastError(uiResult);</span><br><span>              =
   msg(M_NONFATAL | M_ERRNO, &quot;%s: MsiGetComponentState(\&quot;%ls\&quo=
t;) failed&quot;, __FUNCTION__,</span><br><span>                     szValu=
e);</span><br><span>                 free(szValue);</span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1959?usp=3D=
email">change 1959</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1959?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I39b3b31983a2d6348fd66266448f8d13e53a422c </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1959 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--Jrzmo+AtNrQ=--


--===============6092241718853250474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6092241718853250474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6092241718853250474==--

