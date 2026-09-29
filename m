Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2FDC9832A
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iBKRBo91icwOB8fjkJgoP/6B7u60h+G2d7NG889SZIE=; b=RZsBBW65ZQ0GHKOuWBdgyMUEfw
	n13UOmHVC1uShCDRoGClyJ49XleXxIQDkifgvx5WNMRJEmRzg6MAr7uApIzKgYf0JwKX7FrJctAz7
	rUITlqgIZItxqd07rSPSTxAfdhlMZuAjadZ8NLJ8ik0uO2HN369lc+mtojO7KTO+Hdd4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBS5t-0001O7-C7;
	Tue, 29 Sep 2026 07:17:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBS5r-0001Ni-5B
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:17:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=aAwVNNXbKb8G6b0C5lcJjJ37nQl+poF37tURhGxT0cI=; b=TVIItR8LGzQxW67eGT+/KwJ16j
 Slz/pA5wd3o4a1CztNS4y3A4GpfO4mDglKh1hCmNAWGUI1R6qfhDXtj8GyOs1kdLOWIm1oRdMiObb
 JM31kXRXA12wfYnt0BFNvZ9tIWxzdROGYgt3CcOFCwCSS5rMGzHaunp05/08tfEvUcHU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aAwVNNXbKb8G6b0C5lcJjJ37nQl+poF37tURhGxT0cI=; b=Q
 xQhdOgh1Vv0OAhLiHGWu82ecHr4Z4ewhMHTZVLnuM7eGC+kOqckbuDWb+pfqNzVhJIJQ7B8DJczLZ
 ipVJzf84SK7zgPYZ8DVUzrl0ArPSewKaNJP9krQ7SKbmrxyflfQZBCwIKCzD6h6ERwyi22ZdkgAJy
 CaSFeqCD1ulEJMQc=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBS5Q-00069r-0p for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:17:13 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a00d8bec5aso3117725e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 00:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790666225; x=1791271025; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aAwVNNXbKb8G6b0C5lcJjJ37nQl+poF37tURhGxT0cI=;
 b=EuJ6N5L8btU2zhTOI2/7DM0+lux3tvaI56DXMTXLFIqLqkGmWPZg6r33bQbQknlIVU
 4V5HS1rhyzcVYIKZtMdzcUkL94N12LqDAiQDixV+kXZHviaGJXnoqph9td6JRXTmk3wB
 ZQS9M9g7eIPq4+VqgfYuBi7y80LTRHX+JRXfArgvYZJ7Odb8J4gq6r+lGwNoYLnxO/M3
 h6c5Ne+vkSFYy4kEQks2nXLgwCIvamyTd4zL5qG15RQZI8PCGVFvkSu7NcRvlPiwB6zX
 W+XuLlay+rcPkLoozwwbikV1kZ8sE4ddQkY95Gr64DDgtRH3Tg18J95XOnLsnI3Jajkd
 m2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790666225; x=1791271025;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aAwVNNXbKb8G6b0C5lcJjJ37nQl+poF37tURhGxT0cI=;
 b=n7pTv7TSPO943EtIC6gbOR0yKCcmlne+GPMoRfJaIEMbK4NC7yMZAl6hfl1Buu0xLF
 97/OadLNMGT0qczasAe/ZCkzIcIuJAaKgjLko2BWSGSCGVJYEBA3X9AdIoOpjDOM2n5n
 41JDNecGfIP7fw5NL6NbpqD5qdTr41hlDJawJPLujr0pA9kIqz3mO/8awVxChC0ql6d3
 CZvitxcfstJ9WKVHuw9GxYncqmphKV0OuOw8hX1+gwl2KfriMrBJrEvhTsT1I2A7gWzo
 Ih1WeEaxVdMcNu8UrQNB9BkUPcCMIOsZrx028PB6NkTOQtBbIlJj6oL2sf5bpZ9Pr2lH
 ogig==
X-Forwarded-Encrypted: i=1;
 AKwUvBwX3GkEuNXwamiZPr7F+098v+MBRRZJ8srDShgbg0ZvyOS/eldLLMTd6egtCWMpJl/sxVdNV/2Ak0CpZHA/@lists.sourceforge.net
X-Gm-Message-State: AFuF++ln3TrYw4S6yW7ID2Jh/4rIpcUML7aXSyicYNXa9wt74EPTlDT+
 s/0t8CYlnr1B0SmyaAc/AVpoMaYB4pBHIJ3Lor/LRkYuENK+64MvJbhdWyCQ7yC75xfAVhJgL8d
 EEwqLglMQpBzLAJwGLUblHlgly3KuRwqDdzzbIoyzz8fqa1DEMlVYCP65Cs3f/6jQzaoU
X-Gm-Gg: AYBFou0XndTlGBMl8IjH5DKUUA7Cv/IR1VwJnRNLjBWGaZfI6g1VJ2MIj+9/3gfo0WF
 4icSBL3USQq25+WUQe/U8gDxBFA9V/4Xj2NE/kEp1IyUUKIw/CptLtfAJUSGsaWaok9VGgdvbv0
 hvn3yAgIg5bV6GTyEz8VSho/q6ok3GSrFNa7bXOlUoVuIvWhdxOL0Aoo4MWo8V0W+oKx+WhTtAu
 uzPznjlSM0/QsgxgBK/YJUdHFQuu/RZ7RvtLwLECxo7C2k4jabt8Qnr1er3o3W8MzMXR1/cpdQX
 TIP2Y0Xq8EE6MNhfqfKIMgj/0QARJy7R1Ky11YDR1JqcxN9Pv2UV7veWZdZCJqLfDrUX6y6ldW/
 GhBdMlMLjA4LxnEbaZTOXaXNUvtkiRVwWTDpxCaHyTkO66xJIyU6JcnuLYzIV5I60Zsw2g36KkH
 IJrY1ThBZzz8VR5w9PLbIDbo6+5htBSwHDnsn9V+0bs2VHLVcUKfTYyk+yIbnes+AU0Zh0MuE2N
 7k9+QPAhle1UgRHIrHazq15Ze/hFeI8+WMxIk4gktSRyMgiwvaGM+9CJDThOjhYmLFxOjIWaDaL
 WYx/Md6IwWoyYa/Bbq5Aie8aBzsYibChXE6sMGeBqB7zBmGcdxD1q7KxJeOHRmCQeVtwbjg=
X-Received: by 2002:a05:600c:4f88:b0:49f:ff32:8044 with SMTP id
 5b1f17b1804b1-49fff328452mr110658805e9.7.1790666225170; 
 Tue, 29 Sep 2026 00:17:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00ebcd353sm64505325e9.3.2026.09.29.00.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:17:04 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 07:17:04 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I39b3b31983a2d6348fd66266448f8d13e53a422c
X-Gerrit-Change-Number: 1959
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1959?usp=email>
X-Gerrit-Commit: 0af3dd397ececd733e501cf264ed2240c191f34e
In-Reply-To: <gerrit.1790610390000.I39b3b31983a2d6348fd66266448f8d13e53a422c@gerrit.openvpn.net>
References: <gerrit.1790610390000.I39b3b31983a2d6348fd66266448f8d13e53a422c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjEwMzkwMDAwLkkzOWIzYjMxOTgzYTJkNjM0OGZkNjYyNjY0NDhmOGQxM2U1M2E0MjJjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a821e0c7aa7ea06b17d64e42083b533fb379d740-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBS5Q-00069r-0p
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7866836287952695666=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7866836287952695666==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Cl2V1REvJr0="; charset=UTF-8

--Cl2V1REvJr0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1959?usp=3Demail )

Change subject: openvpnmscia: Fix some ugly code fo=
rmatting
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

open=
vpnmscia: Fix some ugly code formatting

Trailing comments lead to some ugl=
iness due
to clang-format formatting=2E Make nicer=2E

Change-Id: I39b3b319=
83a2d6348fd66266448f8d13e53a422c
Signed-off-by: Frank Lichtenheld <frank@li=
chtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1959
Message-Id: <2026092821=
0129=2E12370-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ec=
om/openvpn-devel@lists=2Esourceforge=2Enet/msg39578=2Ehtml
Signed-off-by: G=
ert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnmsica/openvpnmsica=
=2Ec
1 file changed, 31 insertions(+), 23 deletions(-)




diff --git a/src=
/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec
index a8=
61e8a=2E=2E2a1b875 100644
--- a/src/openvpnmsica/openvpnmsica=2Ec
+++ b/src=
/openvpnmsica/openvpnmsica=2Ec
@@ -185,9 +185,9 @@
         free(pAdapterAd=
resses);
         if (ulResult !=3D ERROR_BUFFER_OVERFLOW)
         {
-    =
        SetLastError(
-                ulResult); /* MSDN does not mention =
GetAdaptersAddresses() to set GetLastError()=2E
-                          =
    But we do have an error code=2E Set last error manually=2E */
+        =
    /* MSDN does not mention GetAdaptersAddresses() to set GetLastError()=
=2E
+             * But we do have an error code=2E Set last error manually=
=2E */
+            SetLastError(ulResult);
             msg(M_NONFATAL | M=
_ERRNO, "%s: GetAdaptersAddresses() failed", __FUNCTION__);
             ui=
Result =3D ulResult;
             goto cleanup_pAdapterList;
@@ -290,8 +290=
,9 @@
     uiResult =3D MsiSetProperty(hInstall, szActiveAdaptersPropertyNa=
me, szAdaptersActive);
     if (uiResult !=3D ERROR_SUCCESS)
     {
-      =
  SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set =
GetLastError()=2E But
-                                   we do have an err=
or code=2E Set last error manually=2E */
+        /* MSDN does not mention =
MsiSetProperty() to set GetLastError()=2E But
+         * we do have an err=
or code=2E Set last error manually=2E */
+        SetLastError(uiResult);
 =
        msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"%s\") failed", __FU=
NCTION__,
             szActiveAdaptersPropertyName);
         goto cleanup=
_szAdaptersActive;
@@ -386,8 +387,9 @@
     uiResult =3D MsiRecordSetString=
(hRecord, 0, L"\"[#bin=2Eopenvpn_gui=2Eexe]\"");
     if (uiResult !=3D ERR=
OR_SUCCESS)
     {
-        SetLastError(uiResult); /* MSDN does not mentio=
n MsiRecordSetString() to set GetLastError()=2E
-                          =
         But we do have an error code=2E Set last error manually=2E */
+   =
     /* MSDN does not mention MsiRecordSetString() to set GetLastError()=2E=

+         * But we do have an error code=2E Set last error manually=2E */
=
+        SetLastError(uiResult);
         msg(M_NONFATAL | M_ERRNO, "%s: Ms=
iRecordSetString failed", __FUNCTION__);
         goto cleanup_MsiCreateRec=
ord;
     }
@@ -412,16 +414,17 @@
     }
     if (uiResult !=3D ERROR_SUCCE=
SS)
     {
-        SetLastError(uiResult); /* MSDN does not mention MsiFor=
matRecord() to set GetLastError()=2E
-                                   Bu=
t we do have an error code=2E Set last error manually=2E */
+        /* MSD=
N does not mention MsiFormatRecord() to set GetLastError()=2E
+         * B=
ut we do have an error code=2E Set last error manually=2E */
+        SetLa=
stError(uiResult);
         msg(M_NONFATAL | M_ERRNO, "%s: MsiFormatRecord =
failed", __FUNCTION__);
         goto cleanup_malloc_szPath;
     }
 
     =
/* Launch the OpenVPN GUI=2E */
     SHELLEXECUTEINFO sei =3D { =2EcbSize =
=3D sizeof(SHELLEXECUTEINFO),
-                             =2EfMask =3D
- =
                                SEE_MASK_FLAG_NO_UI, /* Don't show error UI=
, we'll display it=2E */
+                             /* Don't show error =
UI, we'll display it=2E */
+                             =2EfMask =3D SEE_M=
ASK_FLAG_NO_UI,
                              =2ElpFile =3D szPath,
       =
                       =2EnShow =3D SW_SHOWNORMAL };
     if (!ShellExecute=
Ex(&sei))
@@ -528,7 +531,8 @@
                     break;
                 =
}
             }
-            break; /* Adapter names are unique=2E There s=
hould be no other adapter with this name=2E */
+            /* Adapter name=
s are unique=2E There should be no other adapter with this name=2E */
+    =
        break;
         }
     }
 
@@ -614,7 +618,8 @@
             }
 
   =
          *iTicks +=3D MSICA_ADAPTER_TICK_SIZE;
-            break; /* Adap=
ter names are unique=2E There should be no other adapter with this name=2E =
*/
+            /* Adapter names are unique=2E There should be no other ada=
pter with this name=2E */
+            break;
         }
     }
 
@@ -678,9=
 +683,9 @@
     uiResult =3D MsiDatabaseOpenView(hDatabase, szQuery, &hView=
ST);
     if (uiResult !=3D ERROR_SUCCESS)
     {
-        SetLastError(
- =
           uiResult); /* MSDN does not mention MsiDatabaseOpenView() to set=
 GetLastError()=2E But we
-                          do have an error code=
=2E Set last error manually=2E */
+        /* MSDN does not mention MsiData=
baseOpenView() to set GetLastError()=2E But we
+         * do have an error=
 code=2E Set last error manually=2E */
+        SetLastError(uiResult);
   =
      msg(M_NONFATAL | M_ERRNO, "%s: MsiDatabaseOpenView(\"%ls\") failed", =
__FUNCTION__, szQuery);
         goto cleanup_hDatabase;
     }
@@ -689,8 +=
694,9 @@
     uiResult =3D MsiViewExecute(hViewST, 0);
     if (uiResult !=
=3D ERROR_SUCCESS)
     {
-        SetLastError(uiResult); /* MSDN does not=
 mention MsiViewExecute() to set GetLastError()=2E But
-                   =
                we do have an error code=2E Set last error manually=2E */
+=
        /* MSDN does not mention MsiViewExecute() to set GetLastError()=2E =
But
+         * we do have an error code=2E Set last error manually=2E */
+=
        SetLastError(uiResult);
         msg(M_NONFATAL | M_ERRNO, "%s: Msi=
ViewExecute(\"%ls\") failed", __FUNCTION__, szQuery);
         goto cleanup=
_hViewST;
     }
@@ -715,8 +721,9 @@
         }
         else if (uiResult =
!=3D ERROR_SUCCESS)
         {
-            SetLastError(uiResult); /* MSDN=
 does not mention MsiViewFetch() to set GetLastError()=2E
-                =
                       But we do have an error code=2E Set last error manua=
lly=2E */
+            /* MSDN does not mention MsiViewFetch() to set GetLa=
stError()=2E
+             * But we do have an error code=2E Set last error=
 manually=2E */
+            SetLastError(uiResult);
             msg(M_NON=
FATAL | M_ERRNO, "%s: MsiViewFetch failed", __FUNCTION__);
             got=
o cleanup_hRecordProg;
         }
@@ -735,9 +742,10 @@
             uiResul=
t =3D MsiGetComponentState(hInstall, szValue, &iInstalled, &iAction);
     =
        if (uiResult !=3D ERROR_SUCCESS)
             {
-                Se=
tLastError(uiResult); /* MSDN does not mention MsiGetComponentState() to se=
t
-                                           GetLastError()=2E But we do h=
ave an error code=2E Set last
-                                           e=
rror manually=2E */
+                /* MSDN does not mention MsiGetCompone=
ntState() to set
+                 * GetLastError()=2E But we do have an er=
ror code=2E Set last
+                 * error manually=2E */
+            =
    SetLastError(uiResult);
                 msg(M_NONFATAL | M_ERRNO, "%s:=
 MsiGetComponentState(\"%ls\") failed", __FUNCTION__,
                     =
szValue);
                 free(szValue);

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1959?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: I39b3b31983a2d6348fd66266448f8d13e53a422c
Gerrit-Change=
-Number: 1959
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>

--Cl2V1REvJr0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1959?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">openvpnmscia: Fix some ugly code formattin=
g<br><br>Trailing comments lead to some ugliness due<br>to clang-format for=
matting=2E Make nicer=2E<br><br>Change-Id: I39b3b31983a2d6348fd66266448f8d1=
3e53a422c<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL=
: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1959<br>Message-Id: &lt;202609=
28210129=2E12370-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-a=
rchive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39578=2Ehtml<br>Sig=
ned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/op=
envpnmsica/openvpnmsica=2Ec<br>1 file changed, 31 insertions(+), 23 deletio=
ns(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src=
/openvpnmsica/openvpnmsica=2Ec</span><br><span>index a861e8a=2E=2E2a1b875 1=
00644</span><br><span>--- a/src/openvpnmsica/openvpnmsica=2Ec</span><br><sp=
an>+++ b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>@@ -185,9 +185,9=
 @@</span><br><span>         free(pAdapterAdresses);</span><br><span>      =
   if (ulResult !=3D ERROR_BUFFER_OVERFLOW)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            SetLastError(<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ulResu=
lt); /* MSDN does not mention GetAdaptersAddresses() to set GetLastError()=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
            But we do have an error code=2E Set last error manually=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* MSDN d=
oes not mention GetAdaptersAddresses() to set GetLastError()=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+             * But we do have a=
n error code=2E Set last error manually=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            SetLastError(ulResult);</span><br><sp=
an>             msg(M_NONFATAL | M_ERRNO, &quot;%s: GetAdaptersAddresses() =
failed&quot;, __FUNCTION__);</span><br><span>             uiResult =3D ulRe=
sult;</span><br><span>             goto cleanup_pAdapterList;</span><br><sp=
an>@@ -290,8 +290,9 @@</span><br><span>     uiResult =3D MsiSetProperty(hIn=
stall, szActiveAdaptersPropertyName, szAdaptersActive);</span><br><span>   =
  if (uiResult !=3D ERROR_SUCCESS)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        SetLastError(uiResult); /* MSDN=
 does not mention MsiSetProperty() to set GetLastError()=2E But</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
  we do have an error code=2E Set last error manually=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* MSDN does not mention Ms=
iSetProperty() to set GetLastError()=2E But</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+         * we do have an error code=2E Set last err=
or manually=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      SetLastError(uiResult);</span><br><span>         msg(M_NONFATAL | M_E=
RRNO, &quot;%s: MsiSetProperty(\&quot;%s\&quot;) failed&quot;, __FUNCTION__=
,</span><br><span>             szActiveAdaptersPropertyName);</span><br><sp=
an>         goto cleanup_szAdaptersActive;</span><br><span>@@ -386,8 +387,9=
 @@</span><br><span>     uiResult =3D MsiRecordSetString(hRecord, 0, L&quot=
;\&quot;[#bin=2Eopenvpn_gui=2Eexe]\&quot;&quot;);</span><br><span>     if (=
uiResult !=3D ERROR_SUCCESS)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        SetLastError(uiResult); /* MSDN doe=
s not mention MsiRecordSetString() to set GetLastError()=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                   Bu=
t we do have an error code=2E Set last error manually=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* MSDN does not mention Ms=
iRecordSetString() to set GetLastError()=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+         * But we do have an error code=2E Set last=
 error manually=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        SetLastError(uiResult);</span><br><span>         msg(M_NONFATAL |=
 M_ERRNO, &quot;%s: MsiRecordSetString failed&quot;, __FUNCTION__);</span><=
br><span>         goto cleanup_MsiCreateRecord;</span><br><span>     }</spa=
n><br><span>@@ -412,16 +414,17 @@</span><br><span>     }</span><br><span>  =
   if (uiResult !=3D ERROR_SUCCESS)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        SetLastError(uiResult); /* MSD=
N does not mention MsiFormatRecord() to set GetLastError()=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                                   =
But we do have an error code=2E Set last error manually=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /* MSDN does not mention =
MsiFormatRecord() to set GetLastError()=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * But we do have an error code=2E Set last =
error manually=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        SetLastError(uiResult);</span><br><span>         msg(M_NONFATAL | =
M_ERRNO, &quot;%s: MsiFormatRecord failed&quot;, __FUNCTION__);</span><br><=
span>         goto cleanup_malloc_szPath;</span><br><span>     }</span><br>=
<span> </span><br><span>     /* Launch the OpenVPN GUI=2E */</span><br><spa=
n>     SHELLEXECUTEINFO sei =3D { =2EcbSize =3D sizeof(SHELLEXECUTEINFO),</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
      =2EfMask =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                              SEE_MASK_FLAG_NO_UI, /* Don&#39;t show error =
UI, we&#39;ll display it=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                             /* Don&#39;t show error UI, we&#39;=
ll display it=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                             =2EfMask =3D SEE_MASK_FLAG_NO_UI,</span><br><s=
pan>                              =2ElpFile =3D szPath,</span><br><span>   =
                           =2EnShow =3D SW_SHOWNORMAL };</span><br><span>  =
   if (!ShellExecuteEx(&amp;sei))</span><br><span>@@ -528,7 +531,8 @@</span=
><br><span>                     break;</span><br><span>                 }</=
span><br><span>             }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            break; /* Adapter names are unique=2E There should be n=
o other adapter with this name=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            /* Adapter names are unique=2E There should be=
 no other adapter with this name=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            break;</span><br><span>         }</span><br>=
<span>     }</span><br><span> </span><br><span>@@ -614,7 +618,8 @@</span><b=
r><span>             }</span><br><span> </span><br><span>             *iTic=
ks +=3D MSICA_ADAPTER_TICK_SIZE;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            break; /* Adapter names are unique=2E There should b=
e no other adapter with this name=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            /* Adapter names are unique=2E There should=
 be no other adapter with this name=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            break;</span><br><span>         }</span><=
br><span>     }</span><br><span> </span><br><span>@@ -678,9 +683,9 @@</span=
><br><span>     uiResult =3D MsiDatabaseOpenView(hDatabase, szQuery, &amp;h=
ViewST);</span><br><span>     if (uiResult !=3D ERROR_SUCCESS)</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        Set=
LastError(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 uiResult); /* MSDN does not mention MsiDatabaseOpenView() to set GetLastEr=
ror()=2E But we</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                    do have an error code=2E Set last error manually=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* MSDN does=
 not mention MsiDatabaseOpenView() to set GetLastError()=2E But we</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+         * do have an error =
code=2E Set last error manually=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        SetLastError(uiResult);</span><br><span>         =
msg(M_NONFATAL | M_ERRNO, &quot;%s: MsiDatabaseOpenView(\&quot;%ls\&quot;) =
failed&quot;, __FUNCTION__, szQuery);</span><br><span>         goto cleanup=
_hDatabase;</span><br><span>     }</span><br><span>@@ -689,8 +694,9 @@</spa=
n><br><span>     uiResult =3D MsiViewExecute(hViewST, 0);</span><br><span> =
    if (uiResult !=3D ERROR_SUCCESS)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        SetLastError(uiResult); /* MS=
DN does not mention MsiViewExecute() to set GetLastError()=2E But</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
    we do have an error code=2E Set last error manually=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /* MSDN does not mention =
MsiViewExecute() to set GetLastError()=2E But</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * we do have an error code=2E Set last e=
rror manually=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        SetLastError(uiResult);</span><br><span>         msg(M_NONFATAL | M=
_ERRNO, &quot;%s: MsiViewExecute(\&quot;%ls\&quot;) failed&quot;, __FUNCTIO=
N__, szQuery);</span><br><span>         goto cleanup_hViewST;</span><br><sp=
an>     }</span><br><span>@@ -715,8 +721,9 @@</span><br><span>         }</s=
pan><br><span>         else if (uiResult !=3D ERROR_SUCCESS)</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   SetLastError(uiResult); /* MSDN does not mention MsiViewFetch() to set G=
etLastError()=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                                  But we do have an error code=2E Set last =
error manually=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* MSDN does not mention MsiViewFetch() to set GetLastError()=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * B=
ut we do have an error code=2E Set last error manually=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            SetLastError(uiResult)=
;</span><br><span>             msg(M_NONFATAL | M_ERRNO, &quot;%s: MsiViewF=
etch failed&quot;, __FUNCTION__);</span><br><span>             goto cleanup=
_hRecordProg;</span><br><span>         }</span><br><span>@@ -735,9 +742,10 =
@@</span><br><span>             uiResult =3D MsiGetComponentState(hInstall,=
 szValue, &amp;iInstalled, &amp;iAction);</span><br><span>             if (=
uiResult !=3D ERROR_SUCCESS)</span><br><span>             {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                SetLastError(uiResult=
); /* MSDN does not mention MsiGetComponentState() to set</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                                       =
    GetLastError()=2E But we do have an error code=2E Set last</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
         error manually=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                /* MSDN does not mention MsiGetComponentState() t=
o set</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
   * GetLastError()=2E But we do have an error code=2E Set last</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                 * error manual=
ly=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     SetLastError(uiResult);</span><br><span>                 msg(M_NONFATA=
L | M_ERRNO, &quot;%s: MsiGetComponentState(\&quot;%ls\&quot;) failed&quot;=
, __FUNCTION__,</span><br><span>                     szValue);</span><br><s=
pan>                 free(szValue);</span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1959?usp=3Demail">change 19=
59</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1959?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3=
9b3b31983a2d6348fd66266448f8d13e53a422c </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1959 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--Cl2V1REvJr0=--


--===============7866836287952695666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7866836287952695666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7866836287952695666==--

