Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB540CA5FA1
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QvEdl9Qq0/tcuuKp1mWScOTPBr9sNJz10bvy68Y8OCg=; b=I7TNFIUcW1bUBluF428x82dnGn
	7vEr359+On+yw5zIwRK1n7ObbOG7I10Jchn5e8q64nHIOiTL1SdFkZWqy6rHBlASyP0wbaPpooKeY
	i+77Ymqp4yuRQKrRqh0NnaaHlWcbfHk191C/pV3fJGqMFwrJ3lMh2fHZSEfdQMjXN98I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBS5p-0004Ku-VF;
	Tue, 29 Sep 2026 07:17:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBS5o-0004Kb-Me
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:17:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=F58eW/5tJtpahyiwalx8etyqtSCOpE/om0Gb8c0N4P4=; b=I2f4eWMl0+iOkeaxLpFYk25oCR
 I2gzHh4kwslS4mpnnvXlQOXanXAwT/38EYzkCN2645AtwNpBHoV4z2bKS0rWOafInqwEtMeIBFFMv
 6VTlVRMY0WPM96nNn/RcEVNxvEB2Xf9AtRR18T9hbRqG0C3Vw/+juQa+3Ntkmzf7pvq0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=F58eW/5tJtpahyiwalx8etyqtSCOpE/om0Gb8c0N4P4=; b=U
 UdVW2jqXRcy7busMcf5e3a6vng/ewsPtOygZcIQ83jfwWYBYQKy6etcJlnKp5r6/LxajVhrpoVPkU
 dKkL69L2aG72ub5f+dQMHIW3gZFrdE9mLyxbgr2IbW2FVFLtIj3wj/Xp1Kf66U06nA+rin4VMwD9i
 0rT5uF8IrKwk7ZKc=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBS5P-0008QJ-1K for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:17:13 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso23625625e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 00:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790666224; x=1791271024; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F58eW/5tJtpahyiwalx8etyqtSCOpE/om0Gb8c0N4P4=;
 b=Yvf3IuIbgcIlN0U2Na3D2izURro6wCvOt80LV6lue1IPhs6RPE328GtQ0yHQHZpvBE
 HprOUjWA1Eg9rLWSA6whHw2pWbA97DNnvMSMey+5wHT+n/+YZpaorvcGV3dD9vXjOb1j
 34CA6snpn0mGFRDHRdfOGrYQpRgAS7SQUypP1fpYn0PhyNVVP78Z5ViSTNnRU6wwvMdz
 /t8BqVZ+lOJvW9xLVcfmZt0knGKUvUsLOzT23+Zg4lJkHH2wHvw3tKc6d08JT3P1W6io
 nUN3wSAf4S5HTgNxfeBqUGkDjAVZ7fT+Jfmq9HGk3HdXdmLgtbr2JsLKF+Hk96ZG+oo/
 v4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790666224; x=1791271024;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=F58eW/5tJtpahyiwalx8etyqtSCOpE/om0Gb8c0N4P4=;
 b=TrzBo5nuHDiqbsnwW9uX+FsSn74s/KIIBX5n84q+rZtqRv/I6pa4hQx2cp4WRRNp4v
 83WxCAqq/O+PfV1U0dFiRcPFy6uubO1RTRMFV35Plw/Csn8yRY6d8NSVEKC+R8b1dyIY
 V844AqMdX8KnvpjHjf81j7wd6K2auVJ1z294dIomsDlwzxlj+98VTXSUGrIFtKpEvY90
 0HtAdQDnkq1jFsJgxUzDssGecYkP+yi3SP/0LpMBolnszt19060I6qi96QsI/HqHJ8TH
 N4D4XOBOfr1xAWsSCoNGzNtC9NpZpK7oKgDsknnUiUzWyns2Vget8sPbX3hYaYmZBJpF
 v37A==
X-Gm-Message-State: AFuF++nn3nFY8Q+wxc21v3i+7tWiGLXUExsYrbFe1vWh6VPaY2u4eWZ9
 pB4nCOUbPR/e+p/KDCXlGJZe5rvogSf3tcfWxatpT0L2IHV8mfm+QzG8JRroM6xaBBq1oS0GvNT
 pgtzp8XJr2EtoS3+0FHQAgYlPM+8anNBf6/vvIBRPpJT2/BwO8vpiLroX6t+Rp/r9F4tP
X-Gm-Gg: AYBFou1IJWyawO3gtR+6AT3xmxrXwMpqgrcHAMNNfUOnGMBt3UcRbITWJlYZ7/i0q6G
 Ej5/cNVekinFJZWn2t14cjSAhGt4RGHJQ2B7iKRJ6wsJAA61TevD9AwxSQK9epbBxLrJQw7aF/b
 jx6VWyRWPZ1epRmIZV0Xs4kuTR2hzpxBfecwbWPrHahWMeh2xf6cNLG8nk4c/pZ1NFUC6Zq+yMc
 fMp/ZPc9mW8xiIApciaPqip9olTYyHNRsAl44Oj+M37yrgYnVcBfoRyA5/UZSRv4pUGXGAXtRRX
 IePypQOo+gGFmoZHIVhl4lUZvMokXcvkFCXxD7wLSu2W6LY79GepjHow5FnYZcVgLMAedTJdLUc
 RNOxBAKy6GM22llPBY7PvmuS5kh4ZPX82Y79Y0AHAD9i9sSOMjCMqPHbihD4dWUCyS4yZasAbgb
 xQBjDFytFojpvR9ZonsGclNcStXYEosINkvppOMThMvo4PwMgTTThCI2OwiJcDxhq8VWJR7hBmG
 barzSsz93cOnpglduZdauBBvXjNoum5t2Xyx2qZ1ze8ZbT96SE0Z9sntD+G5Y9fF6nJauGRYqvb
 M2KmobTSnKeO5wJ6lHqhLeSrt+fiKT9ujBAi1ILsPqBVmLvAONpNDmARGlCo
X-Received: by 2002:a05:600c:1c21:b0:4a0:2dd:7573 with SMTP id
 5b1f17b1804b1-4a002dd77demr119784375e9.33.1790666224192; 
 Tue, 29 Sep 2026 00:17:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfe13a1sm54580635e9.5.2026.09.29.00.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:17:03 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 07:17:00 +0000
To: flichtenheld <frank@lichtenheld.com>, razvanc <razvanc@mailbox.org>,
 plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I39b3b31983a2d6348fd66266448f8d13e53a422c
X-Gerrit-Change-Number: 1959
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1959?usp=email>
X-Gerrit-Commit: 0af3dd397ececd733e501cf264ed2240c191f34e
In-Reply-To: <gerrit.1790610390000.I39b3b31983a2d6348fd66266448f8d13e53a422c@gerrit.openvpn.net>
References: <gerrit.1790610390000.I39b3b31983a2d6348fd66266448f8d13e53a422c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjEwMzkwMDAwLkkzOWIzYjMxOTgzYTJkNjM0OGZkNjYyNjY0NDhmOGQxM2U1M2E0MjJjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a821e0c7aa7ea06b17d64e42083b533fb379d740-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBS5P-0008QJ-1K
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7712646904563231403=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7712646904563231403==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6JkIk8Se4F4="; charset=UTF-8

--6JkIk8Se4F4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1959?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: openvpnmscia: Fix some ugly code formatting
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnmscia:=
 Fix some ugly code formatting

Trailing comments lead to some ugliness due=

to clang-format formatting=2E Make nicer=2E

Change-Id: I39b3b31983a2d6348=
fd66266448f8d13e53a422c
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1959
Message-Id: <20260928210129=2E12=
370-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg39578=2Ehtml
Signed-off-by: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
---
M src/openvpnmsica/openvpnmsica=2Ec
1 file=
 changed, 31 insertions(+), 23 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/59/1959/2

diff --git a/src/openvpnms=
ica/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec
index a861e8a=2E=
=2E2a1b875 100644
--- a/src/openvpnmsica/openvpnmsica=2Ec
+++ b/src/openvpn=
msica/openvpnmsica=2Ec
@@ -185,9 +185,9 @@
         free(pAdapterAdresses);=

         if (ulResult !=3D ERROR_BUFFER_OVERFLOW)
         {
-            =
SetLastError(
-                ulResult); /* MSDN does not mention GetAdapt=
ersAddresses() to set GetLastError()=2E
-                              But =
we do have an error code=2E Set last error manually=2E */
+            /* M=
SDN does not mention GetAdaptersAddresses() to set GetLastError()=2E
+     =
        * But we do have an error code=2E Set last error manually=2E */
+  =
          SetLastError(ulResult);
             msg(M_NONFATAL | M_ERRNO, "%=
s: GetAdaptersAddresses() failed", __FUNCTION__);
             uiResult =3D=
 ulResult;
             goto cleanup_pAdapterList;
@@ -290,8 +290,9 @@
    =
 uiResult =3D MsiSetProperty(hInstall, szActiveAdaptersPropertyName, szAdap=
tersActive);
     if (uiResult !=3D ERROR_SUCCESS)
     {
-        SetLastE=
rror(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastErr=
or()=2E But
-                                   we do have an error code=2E=
 Set last error manually=2E */
+        /* MSDN does not mention MsiSetProp=
erty() to set GetLastError()=2E But
+         * we do have an error code=2E=
 Set last error manually=2E */
+        SetLastError(uiResult);
         ms=
g(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"%s\") failed", __FUNCTION__,
=
             szActiveAdaptersPropertyName);
         goto cleanup_szAdapter=
sActive;
@@ -386,8 +387,9 @@
     uiResult =3D MsiRecordSetString(hRecord, =
0, L"\"[#bin=2Eopenvpn_gui=2Eexe]\"");
     if (uiResult !=3D ERROR_SUCCESS=
)
     {
-        SetLastError(uiResult); /* MSDN does not mention MsiRecor=
dSetString() to set GetLastError()=2E
-                                   B=
ut we do have an error code=2E Set last error manually=2E */
+        /* MS=
DN does not mention MsiRecordSetString() to set GetLastError()=2E
+        =
 * But we do have an error code=2E Set last error manually=2E */
+        S=
etLastError(uiResult);
         msg(M_NONFATAL | M_ERRNO, "%s: MsiRecordSet=
String failed", __FUNCTION__);
         goto cleanup_MsiCreateRecord;
     =
}
@@ -412,16 +414,17 @@
     }
     if (uiResult !=3D ERROR_SUCCESS)
     {=

-        SetLastError(uiResult); /* MSDN does not mention MsiFormatRecord(=
) to set GetLastError()=2E
-                                   But we do ha=
ve an error code=2E Set last error manually=2E */
+        /* MSDN does not=
 mention MsiFormatRecord() to set GetLastError()=2E
+         * But we do h=
ave an error code=2E Set last error manually=2E */
+        SetLastError(ui=
Result);
         msg(M_NONFATAL | M_ERRNO, "%s: MsiFormatRecord failed", _=
_FUNCTION__);
         goto cleanup_malloc_szPath;
     }
 
     /* Launch =
the OpenVPN GUI=2E */
     SHELLEXECUTEINFO sei =3D { =2EcbSize =3D sizeof(=
SHELLEXECUTEINFO),
-                             =2EfMask =3D
-            =
                     SEE_MASK_FLAG_NO_UI, /* Don't show error UI, we'll dis=
play it=2E */
+                             /* Don't show error UI, we'll d=
isplay it=2E */
+                             =2EfMask =3D SEE_MASK_FLAG_NO=
_UI,
                              =2ElpFile =3D szPath,
                  =
            =2EnShow =3D SW_SHOWNORMAL };
     if (!ShellExecuteEx(&sei))
@=
@ -528,7 +531,8 @@
                     break;
                 }
         =
    }
-            break; /* Adapter names are unique=2E There should be no=
 other adapter with this name=2E */
+            /* Adapter names are uniqu=
e=2E There should be no other adapter with this name=2E */
+            bre=
ak;
         }
     }
 
@@ -614,7 +618,8 @@
             }
 
             *=
iTicks +=3D MSICA_ADAPTER_TICK_SIZE;
-            break; /* Adapter names a=
re unique=2E There should be no other adapter with this name=2E */
+       =
     /* Adapter names are unique=2E There should be no other adapter with t=
his name=2E */
+            break;
         }
     }
 
@@ -678,9 +683,9 @@
=
     uiResult =3D MsiDatabaseOpenView(hDatabase, szQuery, &hViewST);
     i=
f (uiResult !=3D ERROR_SUCCESS)
     {
-        SetLastError(
-            =
uiResult); /* MSDN does not mention MsiDatabaseOpenView() to set GetLastErr=
or()=2E But we
-                          do have an error code=2E Set last=
 error manually=2E */
+        /* MSDN does not mention MsiDatabaseOpenView=
() to set GetLastError()=2E But we
+         * do have an error code=2E Set=
 last error manually=2E */
+        SetLastError(uiResult);
         msg(M_=
NONFATAL | M_ERRNO, "%s: MsiDatabaseOpenView(\"%ls\") failed", __FUNCTION__=
, szQuery);
         goto cleanup_hDatabase;
     }
@@ -689,8 +694,9 @@
   =
  uiResult =3D MsiViewExecute(hViewST, 0);
     if (uiResult !=3D ERROR_SUC=
CESS)
     {
-        SetLastError(uiResult); /* MSDN does not mention MsiV=
iewExecute() to set GetLastError()=2E But
-                                =
   we do have an error code=2E Set last error manually=2E */
+        /* MS=
DN does not mention MsiViewExecute() to set GetLastError()=2E But
+        =
 * we do have an error code=2E Set last error manually=2E */
+        SetLa=
stError(uiResult);
         msg(M_NONFATAL | M_ERRNO, "%s: MsiViewExecute(\=
"%ls\") failed", __FUNCTION__, szQuery);
         goto cleanup_hViewST;
   =
  }
@@ -715,8 +721,9 @@
         }
         else if (uiResult !=3D ERROR_SU=
CCESS)
         {
-            SetLastError(uiResult); /* MSDN does not men=
tion MsiViewFetch() to set GetLastError()=2E
-                             =
          But we do have an error code=2E Set last error manually=2E */
+  =
          /* MSDN does not mention MsiViewFetch() to set GetLastError()=2E
=
+             * But we do have an error code=2E Set last error manually=2E =
*/
+            SetLastError(uiResult);
             msg(M_NONFATAL | M_ERR=
NO, "%s: MsiViewFetch failed", __FUNCTION__);
             goto cleanup_hRe=
cordProg;
         }
@@ -735,9 +742,10 @@
             uiResult =3D MsiGetC=
omponentState(hInstall, szValue, &iInstalled, &iAction);
             if (u=
iResult !=3D ERROR_SUCCESS)
             {
-                SetLastError(ui=
Result); /* MSDN does not mention MsiGetComponentState() to set
-          =
                                 GetLastError()=2E But we do have an error =
code=2E Set last
-                                           error manually=
=2E */
+                /* MSDN does not mention MsiGetComponentState() to =
set
+                 * GetLastError()=2E But we do have an error code=2E S=
et last
+                 * error manually=2E */
+                SetLastEr=
ror(uiResult);
                 msg(M_NONFATAL | M_ERRNO, "%s: MsiGetCompon=
entState(\"%ls\") failed", __FUNCTION__,
                     szValue);
   =
              free(szValue);

-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1959?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I39b3b31983a2d6348fd66266448f8d13e53a422c
Gerrit-Change-Number:=
 1959
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>

--6JkIk8Se4F4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1959?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">openvpnmscia: Fix some u=
gly code formatting<br><br>Trailing comments lead to some ugliness due<br>t=
o clang-format formatting=2E Make nicer=2E<br><br>Change-Id: I39b3b31983a2d=
6348fd66266448f8d13e53a422c<br>Signed-off-by: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1959<br>Mess=
age-Id: &lt;20260928210129=2E12370-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3=
9578=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<=
br>---<br>M src/openvpnmsica/openvpnmsica=2Ec<br>1 file changed, 31 inserti=
ons(+), 23 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/59/1959/2</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec</span><b=
r><span>index a861e8a=2E=2E2a1b875 100644</span><br><span>--- a/src/openvpn=
msica/openvpnmsica=2Ec</span><br><span>+++ b/src/openvpnmsica/openvpnmsica=
=2Ec</span><br><span>@@ -185,9 +185,9 @@</span><br><span>         free(pAda=
pterAdresses);</span><br><span>         if (ulResult !=3D ERROR_BUFFER_OVER=
FLOW)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            SetLastError(</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                ulResult); /* MSDN does not mention GetAdapt=
ersAddresses() to set GetLastError()=2E</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                              But we do have an error cod=
e=2E Set last error manually=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            /* MSDN does not mention GetAdaptersAddresses() =
to set GetLastError()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+             * But we do have an error code=2E Set last error manually=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            S=
etLastError(ulResult);</span><br><span>             msg(M_NONFATAL | M_ERRN=
O, &quot;%s: GetAdaptersAddresses() failed&quot;, __FUNCTION__);</span><br>=
<span>             uiResult =3D ulResult;</span><br><span>             goto=
 cleanup_pAdapterList;</span><br><span>@@ -290,8 +290,9 @@</span><br><span>=
     uiResult =3D MsiSetProperty(hInstall, szActiveAdaptersPropertyName, sz=
AdaptersActive);</span><br><span>     if (uiResult !=3D ERROR_SUCCESS)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to s=
et GetLastError()=2E But</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                   we do have an error code=2E Set last =
error manually=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* MSDN does not mention MsiSetProperty() to set GetLastError()=2E=
 But</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * we d=
o have an error code=2E Set last error manually=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        SetLastError(uiResult);</span><br=
><span>         msg(M_NONFATAL | M_ERRNO, &quot;%s: MsiSetProperty(\&quot;%=
s\&quot;) failed&quot;, __FUNCTION__,</span><br><span>             szActive=
AdaptersPropertyName);</span><br><span>         goto cleanup_szAdaptersActi=
ve;</span><br><span>@@ -386,8 +387,9 @@</span><br><span>     uiResult =3D M=
siRecordSetString(hRecord, 0, L&quot;\&quot;[#bin=2Eopenvpn_gui=2Eexe]\&quo=
t;&quot;);</span><br><span>     if (uiResult !=3D ERROR_SUCCESS)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        S=
etLastError(uiResult); /* MSDN does not mention MsiRecordSetString() to set=
 GetLastError()=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                                But we do have an error code=2E Set last er=
ror manually=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* MSDN does not mention MsiRecordSetString() to set GetLastError()=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * But w=
e do have an error code=2E Set last error manually=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        SetLastError(uiResult);</span>=
<br><span>         msg(M_NONFATAL | M_ERRNO, &quot;%s: MsiRecordSetString f=
ailed&quot;, __FUNCTION__);</span><br><span>         goto cleanup_MsiCreate=
Record;</span><br><span>     }</span><br><span>@@ -412,16 +414,17 @@</span>=
<br><span>     }</span><br><span>     if (uiResult !=3D ERROR_SUCCESS)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     SetLastError(uiResult); /* MSDN does not mention MsiFormatRecord() to =
set GetLastError()=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                   But we do have an error code=2E Set last=
 error manually=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* MSDN does not mention MsiFormatRecord() to set GetLastError()=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * But w=
e do have an error code=2E Set last error manually=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        SetLastError(uiResult);</span>=
<br><span>         msg(M_NONFATAL | M_ERRNO, &quot;%s: MsiFormatRecord fail=
ed&quot;, __FUNCTION__);</span><br><span>         goto cleanup_malloc_szPat=
h;</span><br><span>     }</span><br><span> </span><br><span>     /* Launch =
the OpenVPN GUI=2E */</span><br><span>     SHELLEXECUTEINFO sei =3D { =2Ecb=
Size =3D sizeof(SHELLEXECUTEINFO),</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                             =2EfMask =3D</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                 SEE_MASK_=
FLAG_NO_UI, /* Don&#39;t show error UI, we&#39;ll display it=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
 /* Don&#39;t show error UI, we&#39;ll display it=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                             =2EfMask =
=3D SEE_MASK_FLAG_NO_UI,</span><br><span>                              =2El=
pFile =3D szPath,</span><br><span>                              =2EnShow =
=3D SW_SHOWNORMAL };</span><br><span>     if (!ShellExecuteEx(&amp;sei))</s=
pan><br><span>@@ -528,7 +531,8 @@</span><br><span>                     brea=
k;</span><br><span>                 }</span><br><span>             }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            break; /* Adapte=
r names are unique=2E There should be no other adapter with this name=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Adap=
ter names are unique=2E There should be no other adapter with this name=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break=
;</span><br><span>         }</span><br><span>     }</span><br><span> </span=
><br><span>@@ -614,7 +618,8 @@</span><br><span>             }</span><br><sp=
an> </span><br><span>             *iTicks +=3D MSICA_ADAPTER_TICK_SIZE;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            break; /* Ada=
pter names are unique=2E There should be no other adapter with this name=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* A=
dapter names are unique=2E There should be no other adapter with this name=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            b=
reak;</span><br><span>         }</span><br><span>     }</span><br><span> </=
span><br><span>@@ -678,9 +683,9 @@</span><br><span>     uiResult =3D MsiDat=
abaseOpenView(hDatabase, szQuery, &amp;hViewST);</span><br><span>     if (u=
iResult !=3D ERROR_SUCCESS)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        SetLastError(</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            uiResult); /* MSDN does not mentio=
n MsiDatabaseOpenView() to set GetLastError()=2E But we</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                          do have an erro=
r code=2E Set last error manually=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* MSDN does not mention MsiDatabaseOpenView() =
to set GetLastError()=2E But we</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         * do have an error code=2E Set last error manually=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        SetLastEr=
ror(uiResult);</span><br><span>         msg(M_NONFATAL | M_ERRNO, &quot;%s:=
 MsiDatabaseOpenView(\&quot;%ls\&quot;) failed&quot;, __FUNCTION__, szQuery=
);</span><br><span>         goto cleanup_hDatabase;</span><br><span>     }<=
/span><br><span>@@ -689,8 +694,9 @@</span><br><span>     uiResult =3D MsiVi=
ewExecute(hViewST, 0);</span><br><span>     if (uiResult !=3D ERROR_SUCCESS=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        SetLastError(uiResult); /* MSDN does not mention MsiViewExecute(=
) to set GetLastError()=2E But</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                                   we do have an error code=2E Set=
 last error manually=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* MSDN does not mention MsiViewExecute() to set GetLastErro=
r()=2E But</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
* we do have an error code=2E Set last error manually=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        SetLastError(uiResult);</sp=
an><br><span>         msg(M_NONFATAL | M_ERRNO, &quot;%s: MsiViewExecute(\&=
quot;%ls\&quot;) failed&quot;, __FUNCTION__, szQuery);</span><br><span>    =
     goto cleanup_hViewST;</span><br><span>     }</span><br><span>@@ -715,8=
 +721,9 @@</span><br><span>         }</span><br><span>         else if (uiR=
esult !=3D ERROR_SUCCESS)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            SetLastError(uiResult); /* MSDN=
 does not mention MsiViewFetch() to set GetLastError()=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                                       =
But we do have an error code=2E Set last error manually=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            /* MSDN does not ment=
ion MsiViewFetch() to set GetLastError()=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+             * But we do have an error code=2E Set =
last error manually=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            SetLastError(uiResult);</span><br><span>             msg(=
M_NONFATAL | M_ERRNO, &quot;%s: MsiViewFetch failed&quot;, __FUNCTION__);</=
span><br><span>             goto cleanup_hRecordProg;</span><br><span>     =
    }</span><br><span>@@ -735,9 +742,10 @@</span><br><span>             uiR=
esult =3D MsiGetComponentState(hInstall, szValue, &amp;iInstalled, &amp;iAc=
tion);</span><br><span>             if (uiResult !=3D ERROR_SUCCESS)</span>=
<br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                SetLastError(uiResult); /* MSDN does not mention MsiGetC=
omponentState() to set</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                           GetLastError()=2E But we do hav=
e an error code=2E Set last</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                           error manually=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* MSDN d=
oes not mention MsiGetComponentState() to set</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                 * GetLastError()=2E But we do ha=
ve an error code=2E Set last</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                 * error manually=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                SetLastError(uiResult);</span>=
<br><span>                 msg(M_NONFATAL | M_ERRNO, &quot;%s: MsiGetCompon=
entState(\&quot;%ls\&quot;) failed&quot;, __FUNCTION__,</span><br><span>   =
                  szValue);</span><br><span>                 free(szValue);=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1959?usp=3Demail">change 1959</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1959?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: I39b3b31983a2d6348fd66266448f8d13e=
53a422c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1959 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: raz=
vanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--6JkIk8Se4F4=--


--===============7712646904563231403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7712646904563231403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7712646904563231403==--

