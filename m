Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8BB606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KDapE7mJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BUhRrt4G;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=N9ePf6Mq;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RDGMAa7u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=37GHX6N2wUrXEYuOWt69gJXWCszLAr9pzd3v4uBYZ/w=; b=KDapE7mJFtTYyZ76WPrrEehYq6
	2BgxEOUU4zxpzSe4r6auz6l4/tBHIf4IhEP4bMKNw8NGglZjEP4G7y4DIm08MKSUvXnsaH9AInLb7
	4vna+YNDXbk73soE36sl8A0wl1x4iDKSeB8KMZdKBYllkONw8JdfmTQEC8yL0irVHXm4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX20o-000000005yU-2ktw;
	Fri, 27 Nov 2026 19:53:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX20n-000000005yN-1Qnl
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:53:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CLL2U9bcaBWLhTVTIl6lPRDS+YKp5RNmAfMyIiKc2fU=; b=BUhRrt4GkgmsU8PyqFm9WgpNgV
 pIErNRS0q7SPFh95oe+7pgRnNwRUxzONTRHP2WjwrlqqcZ+JAwscthoxXD4G8/1jG7FwO6CDszFVd
 4E30HWKWMEP3FrVGqWgA3PUK/QHFAbns7JVGUh+UcxMsd6QsoX7Y2fQUg680G7g14bfQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CLL2U9bcaBWLhTVTIl6lPRDS+YKp5RNmAfMyIiKc2fU=; b=N9ePf6Mqk5BVkPenYDq0z8GOfB
 djp6WL4lIJnA4UjhuWW+hkuDHM4U9fHixXXXoO8vjdLY1C4NRRrT5XcfMpdusuntomYH1kYHE3V19
 egk9wL3T8EcNwy57bmUcm7ga9GmBrLhmV2dGEXXFqRrGJhvCpryx+BQ1rEfsivdpSq8k=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX20l-000000001Yh-1d6g for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:53:37 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bba5e17cbeso30153225e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 11:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795809209; x=1796414009; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CLL2U9bcaBWLhTVTIl6lPRDS+YKp5RNmAfMyIiKc2fU=;
 b=RDGMAa7utEE6kT+rwenP5x1jPyXwF8G97CuawWMAjwvvMoLV9hi7t7deWc5PKi4RQ8
 kEhuY23pH9NvlG0bXRrPZOL2RBoMQuWw2r+k1p+hQTlrxAdrojeMLt7kKH0iQxX3cPrG
 CS4uQgeWri77Mrc/3oNrclZ/Agxe0nxHkNsxmGVOFi+MmMiZZuBiEhNj1KP1o4IguHns
 PyxvfB9bQJTPQRvJoH3ByODRqQFxQChRTj1jkbrOCZDaGp2ClHjAyJ+U2f3q8ELGPqES
 9OCkq2BFuph89aAuUhKQK9lvIrFGpL9IZYLrI6QOj2cpfUd9CZaEPAT+KjfowS3+pENB
 7Lkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795809209; x=1796414009;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CLL2U9bcaBWLhTVTIl6lPRDS+YKp5RNmAfMyIiKc2fU=;
 b=MQ3AqD5bhgE/6cXllgeul7HsJh1K4D175K6e32bRiqcYVjlPqQU7M6cmC6adNwT1o6
 ko6zIWmmFJqjilaclhUdioK7nS6yYx1PaUy0Ep+L12GZhZ2Uu8OhdmAA71FdBgsNSS5M
 GXalDIkkN/+5ue6fgb6goN4ubk0NoyIXVI1x9qYBwNAUeOHFiSxp9vnVATOZmNiQs4H0
 I/ys5TC/HKQyNumfMPA5A2fLZysvvcHjXJq5UiMGyMxcJik9qH7kPgmYdViBFtf8uY6F
 im0i8EkifgfLBtThvXAAb5xQ0tXUDVilAXFc34mXZ2RncK7JUSX2SBf8LQ1r4XdPcIBO
 Lcrg==
X-Forwarded-Encrypted: i=1;
 AL+hErEmj9pp/5s1L/9+jd8lbttOSd9fC3hNBvt3W7lk/TEo0IfRUCz1H34MpB6yYmNDsqdBNqIwt8WTbDZrffYR@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9jDcpitZACirLjyPxZPj6vw1JO5IjOx3zIK7GMPEoHamlTzC/1
 KrkUAEHDQrMF8R3uj62jF0y5nIUsNv6yRKev16XxivSXOWamIDpAFLgQyRsM27/AdVBAAEUrg8S
 EESIpqs0N4Lm0zAfVQ2Z+1L1ls64qVnP1T6OFcKDrc/xL4ywUh0nDAx289lVnweSpjGjZ
X-Gm-Gg: AZFdTZfkgKZvqzpXx6AcQ3GEBLQ9aPu5NGF3UHCLlwSUbUlNHjA75crJT3NLheAJYl7
 7mbnH6mZd5kESws9UK+nZr3YYd4ePWJm7EDPvW/gjOiHT1pvgx9RM6H6UBfxDpmnvcg/H065C5e
 iEO9YlremHIbgunQIuU192IZh7PDtKEFoCIuOa/kj96y4s9S+zAHLk9SudtL8wfdjb3J1GDpM2O
 OViWkYY2DG3MYiyYQMWOhs8aajeUsgkOP28XT9hWGlNUFZjfD2js/ErmYQXu+1NKNjZR5SZayx7
 XppBjgzYFONtxx5P4UgjTbUvPI5o2V15o9uA07ZiV57t7e9knC9DLqXZMjQK+YFHUGPpfoRLJSU
 3/xGNyOQDoaXge7VQ+5kzKeCratyqEM2dvpblY6Iw/nImJYe0AikoCIx/offr1zVCkZZigI7Mwl
 G9NXrCHXv3s4WuVXOJHJW2LyfTGepgMcQ6jKJwsbAIhLSbJa8rhUDUSOmkhQ7vtjox2C3vi4ib7
 ShMkfpBK29jWX6GuLzUNRzJzETVDuol2EeVdwxjTp7c2Bt3mM/Zcp9B1xG9I4aoRNmaxsWKS9AY
 8RePPyQWkFK2c6rJKPoWm4OxNphSGuCGVGFzh/r79I2HscuCNYNWWECkY3xUAcbfpefvn3trqXu
 nFrLcwRoBUYhbHkQjlc40P36ARIUWRs9+8NmlBfER3CFME9RhUgoG0DW7dv6+JT9zrVCshU+UWD
 q1qrZOPFAaG65/tmY=
X-Received: by 2002:a05:600c:6219:b0:4bb:a5f1:fc5f with SMTP id
 5b1f17b1804b1-4bba60168f3mr197000825e9.26.1795809208636; 
 Fri, 27 Nov 2026 11:53:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849e598sm706991115e9.8.2026.11.27.11.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:53:28 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 19:53:28 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7
X-Gerrit-Change-Number: 2358
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2358?usp=email>
X-Gerrit-Commit: 469b1c717423456f330ceee66b4d119fc0354ab5
In-Reply-To: <gerrit.1795714582000.Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7@gerrit.openvpn.net>
References: <gerrit.1795714582000.Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzE0NTgyMDAwLklhNWMyNjViZDFmMjcyM2JlOTNmYjhmYmI3M2U3M2E0ZTg2ZDFjYWM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fd8ea857e4b07dfdbcca2201816f3adaff5b95a8-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xX20l-000000001Yh-1d6g
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnmsica: Clean
 up sign conversion warnings
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6199042651745575327=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6199042651745575327==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Kzv+7Hldyb8="; charset=UTF-8

--Kzv+7Hldyb8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2358?usp=3Demail )

Change subject: openvpnmsica: Clean up sign=
 conversion warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

openvpnmsica: Clean up sign conversion warnings

Improve code in x_=
msg_va to handle vsnprintf result=2E

Removes explict null termination that=
 is not required
in supported versions of Windows=2E

Includes one unrelate=
d cast that is too small to
warrant its own commit=2E

Change-Id: Ia5c265bd=
1f2723be93fb8fbb73e73a4e86d1cac7
Signed-off-by: Frank Lichtenheld <frank@li=
chtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2358
Message-Id: <2026112618=
4443=2E15556-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ec=
om/openvpn-devel@lists=2Esourceforge=2Enet/msg42062=2Ehtml
Signed-off-by: G=
ert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnmsica/dllmain=2Ec
1 =
file changed, 19 insertions(+), 25 deletions(-)




diff --git a/src/openvp=
nmsica/dllmain=2Ec b/src/openvpnmsica/dllmain=2Ec
index 777c823=2E=2Ee19120=
7 100644
--- a/src/openvpnmsica/dllmain=2Ec
+++ b/src/openvpnmsica/dllmain=
=2Ec
@@ -98,11 +98,6 @@
     return true;
 }
 
-#if defined(__GNUC__) || de=
fined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignor=
ed "-Wsign-conversion"
-#endif
-
 void
 x_msg_va(const unsigned int flags, =
const char *format, va_list arglist)
 {
@@ -124,26 +119,29 @@
         /* F=
ield 2: The message string=2E */
         char szBufStack[128];
         in=
t iResultLen =3D vsnprintf(szBufStack, _countof(szBufStack), format, arglis=
t);
-        if (iResultLen > 0 && (unsigned int)iResultLen < _countof(szBu=
fStack))
+        if (iResultLen > 0)
         {
-            /* Use from s=
tack=2E */
-            MsiRecordSetStringA(hRecordProg, 2, szBufStack);
- =
       }
-        else
-        {
-            /* Allocate on heap and retr=
y=2E */
-            char *szMessage =3D (char *)malloc(++iResultLen * size=
of(char));
-            if (szMessage !=3D NULL)
+            const size_t =
alloc_size =3D (size_t)iResultLen + 1;
+            if (alloc_size <=3D _co=
untof(szBufStack))
             {
-                vsnprintf(szMessage, iRe=
sultLen, format, arglist);
-                MsiRecordSetStringA(hRecordProg=
, 2, szMessage);
-                free(szMessage);
+                /* Use =
from stack=2E */
+                MsiRecordSetStringA(hRecordProg, 2, szBuf=
Stack);
             }
             else
             {
-                /*=
 Use stack variant anyway, but make sure it's zero-terminated=2E */
-      =
          szBufStack[_countof(szBufStack) - 1] =3D 0;
-                MsiR=
ecordSetStringA(hRecordProg, 2, szBufStack);
+                /* Allocate o=
n heap and retry=2E */
+                char *szMessage =3D malloc(alloc_si=
ze);
+                if (szMessage !=3D NULL)
+                {
+        =
            vsnprintf(szMessage, alloc_size, format, arglist);
+           =
         MsiRecordSetStringA(hRecordProg, 2, szMessage);
+                 =
   free(szMessage);
+                }
+                else
+             =
   {
+                    /* Use truncated stack variant anyway */
+       =
             MsiRecordSetStringA(hRecordProg, 2, szBufStack);
+            =
    }
             }
         }
     }
@@ -159,7 +157,7 @@
         MsiReco=
rdSetInteger(hRecordProg, 1, ERROR_MSICA_ERRNO);
 
         /* Field 3: The=
 Windows error number=2E */
-        MsiRecordSetInteger(hRecordProg, 3, dw=
Result);
+        MsiRecordSetInteger(hRecordProg, 3, (int)dwResult);
 
   =
      /* Field 4: The Windows error description=2E */
         LPWSTR szErr=
Message =3D NULL;
@@ -194,7 +192,3 @@
                       hRecordProg);
=
     MsiCloseHandle(hRecordProg);
 }
-
-#if defined(__GNUC__) || defined(__=
clang__)
-#pragma GCC diagnostic pop
-#endif

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2358?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7
Gerrit-=
Change-Number: 2358
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--Kzv+7Hldyb8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2358?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpnmsica: Clean up sign conver=
sion warnings<br><br>Improve code in x_msg_va to handle vsnprintf result=2E=
<br><br>Removes explict null termination that is not required<br>in support=
ed versions of Windows=2E<br><br>Includes one unrelated cast that is too sm=
all to<br>warrant its own commit=2E<br><br>Change-Id: Ia5c265bd1f2723be93fb=
8fbb73e73a4e86d1cac7<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br=
>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2358<br>Message-Id:=
 &lt;20261126184443=2E15556-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg42062=2E=
html<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<=
br>M src/openvpnmsica/dllmain=2Ec<br>1 file changed, 19 insertions(+), 25 d=
eletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpnmsica/dllmain=2Ec b/sr=
c/openvpnmsica/dllmain=2Ec</span><br><span>index 777c823=2E=2Ee191207 10064=
4</span><br><span>--- a/src/openvpnmsica/dllmain=2Ec</span><br><span>+++ b/=
src/openvpnmsica/dllmain=2Ec</span><br><span>@@ -98,11 +98,6 @@</span><br><=
span>     return true;</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> void</span><br><span> x_msg_va(const uns=
igned int flags, const char *format, va_list arglist)</span><br><span> {</s=
pan><br><span>@@ -124,26 +119,29 @@</span><br><span>         /* Field 2: Th=
e message string=2E */</span><br><span>         char szBufStack[128];</span=
><br><span>         int iResultLen =3D vsnprintf(szBufStack, _countof(szBuf=
Stack), format, arglist);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (iResultLen &gt; 0 &amp;&amp; (unsigned int)iResultLen &lt; =
_countof(szBufStack))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (iResultLen &gt; 0)</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            /* Use from stack=2E */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            MsiRecordSe=
tStringA(hRecordProg, 2, szBufStack);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Al=
locate on heap and retry=2E */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            char *szMessage =3D (char *)malloc(++iResultLen * size=
of(char));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (szMessage !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            const size_t alloc_size =3D (size_t)iResultLen + 1;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (alloc_siz=
e &lt;=3D _countof(szBufStack))</span><br><span>             {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                vsnprintf(szMessag=
e, iResultLen, format, arglist);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                MsiRecordSetStringA(hRecordProg, 2, szMessage);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                free(s=
zMessage);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       /* Use from stack=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                MsiRecordSetStringA(hRecordProg, 2, szBufStack);=
</span><br><span>             }</span><br><span>             else</span><br=
><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                /* Use stack variant anyway, but make sure it&#39;s zero-te=
rminated=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         szBufStack[_countof(szBufStack) - 1] =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                MsiRecordSetStringA(hRecord=
Prog, 2, szBufStack);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                /* Allocate on heap and retry=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                char *szMessage =3D mallo=
c(alloc_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           if (szMessage !=3D NULL)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    vsnprintf(szMessage, alloc_size, format, =
arglist);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          MsiRecordSetStringA(hRecordProg, 2, szMessage);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    free(szMessage);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                else</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    /* =
Use truncated stack variant anyway */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    MsiRecordSetStringA(hRecordProg, 2, s=
zBufStack);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        }</span><br><span>             }</span><br><span>         }</span><=
br><span>     }</span><br><span>@@ -159,7 +157,7 @@</span><br><span>       =
  MsiRecordSetInteger(hRecordProg, 1, ERROR_MSICA_ERRNO);</span><br><span> =
</span><br><span>         /* Field 3: The Windows error number=2E */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        MsiRecordSetInteger(=
hRecordProg, 3, dwResult);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        MsiRecordSetInteger(hRecordProg, 3, (int)dwResult);</span><b=
r><span> </span><br><span>         /* Field 4: The Windows error descriptio=
n=2E */</span><br><span>         LPWSTR szErrMessage =3D NULL;</span><br><s=
pan>@@ -194,7 +192,3 @@</span><br><span>                       hRecordProg)=
;</span><br><span>     MsiCloseHandle(hRecordProg);</span><br><span> }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic po=
p</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br></p=
re><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2358?usp=3Demail">change 2358</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2358?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merg=
ed </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 2358 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerr=
it-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>

</body></html>
--Kzv+7Hldyb8=--


--===============6199042651745575327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6199042651745575327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6199042651745575327==--

