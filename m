Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF6606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=H6J5aNoN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hHEHwZU0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=K1gXmD6f;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UGmd3uu2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AxsKa7OWanXHfxuwHVtCdVlxM8HE7wJu+jsW8mWb2Zg=; b=H6J5aNoNLEAGn8QqEptphKSHg1
	4zQkvhfK6Ct3V+NkJzTD56wVAtEUjj+BDjhqyjdYuPG3yTJiG5kYjHFk/oNxiXqpm1HR0BVDXOkWZ
	HnnZ4Wi6UywopyJwBeSgOtOwXlcALWJF63b3nVw/laYdeA4fRu0fwZ4DP0rNX0AHuer0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX20m-000000000tS-2YdG;
	Fri, 27 Nov 2026 19:53:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX20m-000000000tM-09Gi
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:53:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b/DbKycK2FGb9ctVhMtRYwrVmC7jQd08k01snmCbEwo=; b=hHEHwZU0jSPl9uCoWFA+r1kzUh
 HMRP6t7TLFRj8bLxxJQKagPMtoHMYCBZBbclu7CcWIOIG+n7WNVAwvSWpYSsowXc436dAcq8B3UC1
 OG1xCpAdihq9IbT71X6WS9z1bjn+B3tc8MOjXkuspJHZs0aDIJ2NxETpZnYZUyuELFss=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b/DbKycK2FGb9ctVhMtRYwrVmC7jQd08k01snmCbEwo=; b=K1gXmD6fRRyOMqfrjHwMEnl357
 CQtuJse3cVo4B5amE5Tfnt04APB4PdQW6WGLEA6y8uBcIRrm5AQGcXvBsFYKBNvGj/EqEnWXLUuEs
 ohxFOq1c8pLHOZcanuJ8MLzE1YvUmCQVfoXlRuqVvKJnCC0jdxItTLhgWGFuZesYWy2M=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX20k-000000004SR-2riu for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:53:35 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4ad6219f7d8so7642037f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 11:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795809208; x=1796414008; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b/DbKycK2FGb9ctVhMtRYwrVmC7jQd08k01snmCbEwo=;
 b=UGmd3uu2byeJMz5GsOstaHPaoRUaEcpjaWsLXgqyfFPr71vfM1TxIJ4kJ1oqn2h0BB
 BvKukL3NSkMhA0D7jbmME2K9QoeyjGygNxy7aG6kThTk/XLh7nNuF2HQDKAHMnTGiyW6
 Z8m/krA6gKAFpCHJ1fOEkk8bY+Z3qzgweT6rldvcZrM/opmftE1kEOVATQ93h7xk7CvU
 sfsdTILv5cnB/u8k4psNltxaoIgDBk1UMSrE1bDGYK9OeCI9gW7afCSstlD/aDR3gIqy
 2dOXc3PTw4tsWo/3/flBO8rpXvabLvM0eZwHBPJfNGdwehy2336hu+K7TxlB4m9Rcsau
 ++VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795809208; x=1796414008;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=b/DbKycK2FGb9ctVhMtRYwrVmC7jQd08k01snmCbEwo=;
 b=jqaPnHxANn2uQ/Ib1MU9Y04bjrcJ7Xk8AjC0JqIDn05T2o5vo9fvqFRmqL5rx1Vt3P
 By/aBhcqC+vAxcyY9XmVWaoRdiWOeZbzkSu/NhkvTI+hasMxsexPoXCULO6cK3BaS++F
 ZQdKGD/EoxcIA/hEFPzoKqc3L4nrVZB6VP/PbbfC6fjeAk2glku9SHsJWtdOJr22/xTX
 PflJO3ACm0PRtkKf8wn3wkcQNTUrnUeA7m1XAuABGNmumy9TJ8TGtXck6y3943wgp85f
 uoGYftnivnglBky1cWqPDHWvYN8kqCyILP6SN1x0tb/47cyYmCHYPCCBZUYpMM71vgJx
 56Cg==
X-Gm-Message-State: APuU4Z9EvARYLHPW7NvuNhKg+jf/Bb7Yz0vUY6ru8yYGNBD8P7KygvGU
 bSQLzdMKIq+JXdoqapg29Zt9y0fAzL3MXBP8eRs+WyxWnjOyfg0ZcDc8xc4JU0fP9sXZWycMco7
 GScr7KbcJJQ7N2v/ALqI0uHOPMDCgUEyL78ZrzKTw5i31Kh+mIiJFlmY2JjntaWzTevY0
X-Gm-Gg: AZFdTZfHEktRrTnV+Of+oYorLdmqgaLXnWiAtWuNoe1Xrlq65KENRFWT2P3rviXzpzq
 1j7arZVrAkiPpguFx6jUbhQNpati7UYEXRxXkicccAktdO1yESTbvoNATcgfAiFFOqO8AP/XMm5
 soYncE+kGW8++eSn3mqR/tMg3SBauuu/QA3wIvCceuqRy7Kq6HFibcJvwDtMIB4ZJg9/RGHR8yQ
 1T3owwtWAzDWdJIcPCea3M12dH0OYbEp/FtO672LqGBkFKjn9ZDacjb/41UlhR8TGT6MADrZhMM
 fAxjJiCYJ6rYlKsb3o4T3rKojDaoxIEdPIkU2Dqohch0pd4e3PLTaRvnTbcpOFH8ihnNBQzhH/y
 ofbrLMRPniw/njCqFIzsHWQgeRr8nOPKyPLApgzsVBnkBCbMgRLsbRM/PN3C416BOdkcqvt71As
 xppmN3BS8ck7ZHlU4RxJl2LKFjNYjBOGigrpb5ry/L/t3XKUx8H3IqXveazGMP39vLQJki4zamH
 Aqp2oJyLJv0YopexiNKepFAmnE1VRnflPERzkzjTOu0QCVOqLgkyXc9k3evt3NZM55TX+AcLnC7
 kEwW/3mhm+aEyb8/2HEpT4XO2OKzvqWx439LKFX0mbMMiOIIYOlgMktG+0MScX4SgisktUcNhw4
 j4FC0fQyjaEZq8sv9h32yfft7r77OZBsDXsCg5JkrzMtxgYw8iKymm8/fuT04GDMFvaG9vQ2pUq
 MWtBn0bdAAa5ygD+Q=
X-Received: by 2002:a05:6000:4705:b0:48f:c4fb:6bb6 with SMTP id
 ffacd0b85a97d-4abb400bb83mr49506544f8f.12.1795809207961; 
 Fri, 27 Nov 2026 11:53:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b33a596f9csm24105371f8f.12.2026.11.27.11.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:53:27 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 19:53:26 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7
X-Gerrit-Change-Number: 2358
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2358?usp=email>
X-Gerrit-Commit: 469b1c717423456f330ceee66b4d119fc0354ab5
In-Reply-To: <gerrit.1795714582000.Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7@gerrit.openvpn.net>
References: <gerrit.1795714582000.Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzE0NTgyMDAwLklhNWMyNjViZDFmMjcyM2JlOTNmYjhmYmI3M2U3M2E0ZTg2ZDFjYWM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fd8ea857e4b07dfdbcca2201816f3adaff5b95a8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xX20k-000000004SR-2riu
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3988735763589792233=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3988735763589792233==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="41jl6z2Lf6E="; charset=UTF-8

--41jl6z2Lf6E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
358?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: openvpnmsica: Clean =
up sign conversion warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

openvpnmsica: Clean up sign conversion warnings

Improve c=
ode in x_msg_va to handle vsnprintf result=2E

Removes explict null termina=
tion that is not required
in supported versions of Windows=2E

Includes one=
 unrelated cast that is too small to
warrant its own commit=2E

Change-Id: =
Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7
Signed-off-by: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2358
Message-Id: <2=
0261126184443=2E15556-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg42062=2Ehtml
Signed-=
off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnmsica/dllma=
in=2Ec
1 file changed, 19 insertions(+), 25 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/2358/2

diff --git a/=
src/openvpnmsica/dllmain=2Ec b/src/openvpnmsica/dllmain=2Ec
index 777c823=
=2E=2Ee191207 100644
--- a/src/openvpnmsica/dllmain=2Ec
+++ b/src/openvpnms=
ica/dllmain=2Ec
@@ -98,11 +98,6 @@
     return true;
 }
 
-#if defined(__GN=
UC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagn=
ostic ignored "-Wsign-conversion"
-#endif
-
 void
 x_msg_va(const unsigned =
int flags, const char *format, va_list arglist)
 {
@@ -124,26 +119,29 @@
  =
       /* Field 2: The message string=2E */
         char szBufStack[128];
=
         int iResultLen =3D vsnprintf(szBufStack, _countof(szBufStack), for=
mat, arglist);
-        if (iResultLen > 0 && (unsigned int)iResultLen < _c=
ountof(szBufStack))
+        if (iResultLen > 0)
         {
-            /*=
 Use from stack=2E */
-            MsiRecordSetStringA(hRecordProg, 2, szBu=
fStack);
-        }
-        else
-        {
-            /* Allocate on he=
ap and retry=2E */
-            char *szMessage =3D (char *)malloc(++iResul=
tLen * sizeof(char));
-            if (szMessage !=3D NULL)
+            co=
nst size_t alloc_size =3D (size_t)iResultLen + 1;
+            if (alloc_si=
ze <=3D _countof(szBufStack))
             {
-                vsnprintf(szM=
essage, iResultLen, format, arglist);
-                MsiRecordSetStringA(=
hRecordProg, 2, szMessage);
-                free(szMessage);
+            =
    /* Use from stack=2E */
+                MsiRecordSetStringA(hRecordPro=
g, 2, szBufStack);
             }
             else
             {
-       =
         /* Use stack variant anyway, but make sure it's zero-terminated=2E=
 */
-                szBufStack[_countof(szBufStack) - 1] =3D 0;
-         =
       MsiRecordSetStringA(hRecordProg, 2, szBufStack);
+                /*=
 Allocate on heap and retry=2E */
+                char *szMessage =3D mall=
oc(alloc_size);
+                if (szMessage !=3D NULL)
+                =
{
+                    vsnprintf(szMessage, alloc_size, format, arglist);
+=
                    MsiRecordSetStringA(hRecordProg, 2, szMessage);
+      =
              free(szMessage);
+                }
+                else
+  =
              {
+                    /* Use truncated stack variant anyway =
*/
+                    MsiRecordSetStringA(hRecordProg, 2, szBufStack);
+ =
               }
             }
         }
     }
@@ -159,7 +157,7 @@
     =
    MsiRecordSetInteger(hRecordProg, 1, ERROR_MSICA_ERRNO);
 
         /* F=
ield 3: The Windows error number=2E */
-        MsiRecordSetInteger(hRecord=
Prog, 3, dwResult);
+        MsiRecordSetInteger(hRecordProg, 3, (int)dwRes=
ult);
 
         /* Field 4: The Windows error description=2E */
         L=
PWSTR szErrMessage =3D NULL;
@@ -194,7 +192,3 @@
                       hRe=
cordProg);
     MsiCloseHandle(hRecordProg);
 }
-
-#if defined(__GNUC__) ||=
 defined(__clang__)
-#pragma GCC diagnostic pop
-#endif

-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2358?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: Ia5c265bd1f2723be93fb8fbb73e73a4e8=
6d1cac7
Gerrit-Change-Number: 2358
Gerrit-PatchSet: 2
Gerrit-Owner: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--41jl6z2Lf6E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2358?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">openvpnmsica: Clean up sign conversion warnings<br><br>Improve code in =
x_msg_va to handle vsnprintf result=2E<br><br>Removes explict null terminat=
ion that is not required<br>in supported versions of Windows=2E<br><br>Incl=
udes one unrelated cast that is too small to<br>warrant its own commit=2E<b=
r><br>Change-Id: Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7<br>Signed-off-by=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2358<br>Message-Id: &lt;20261126184443=2E15556-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg42062=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnmsica/dllmain=2Ec<br>=
1 file changed, 19 insertions(+), 25 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/235=
8/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpnmsica/dllmain=2Ec b/src/openvpnmsica/dl=
lmain=2Ec</span><br><span>index 777c823=2E=2Ee191207 100644</span><br><span=
>--- a/src/openvpnmsica/dllmain=2Ec</span><br><span>+++ b/src/openvpnmsica/=
dllmain=2Ec</span><br><span>@@ -98,11 +98,6 @@</span><br><span>     return =
true;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ign=
ored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> void</span><br><span> x_msg_va(const unsigned int flags, co=
nst char *format, va_list arglist)</span><br><span> {</span><br><span>@@ -1=
24,26 +119,29 @@</span><br><span>         /* Field 2: The message string=2E=
 */</span><br><span>         char szBufStack[128];</span><br><span>        =
 int iResultLen =3D vsnprintf(szBufStack, _countof(szBufStack), format, arg=
list);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (iRe=
sultLen &gt; 0 &amp;&amp; (unsigned int)iResultLen &lt; _countof(szBufStack=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (iResu=
ltLen &gt; 0)</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            /* Use from stack=2E */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            MsiRecordSetStringA(hRecordPro=
g, 2, szBufStack);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            /* Allocate on heap and =
retry=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  char *szMessage =3D (char *)malloc(++iResultLen * sizeof(char));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            if (szMessage !=3D=
 NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c=
onst size_t alloc_size =3D (size_t)iResultLen + 1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if (alloc_size &lt;=3D _countof(=
szBufStack))</span><br><span>             {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                vsnprintf(szMessage, iResultLen, form=
at, arglist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        MsiRecordSetStringA(hRecordProg, 2, szMessage);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                free(szMessage);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                /* Use from =
stack=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        MsiRecordSetStringA(hRecordProg, 2, szBufStack);</span><br><span>  =
           }</span><br><span>             else</span><br><span>            =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* =
Use stack variant anyway, but make sure it&#39;s zero-terminated=2E */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                szBufStack=
[_countof(szBufStack) - 1] =3D 0;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                MsiRecordSetStringA(hRecordProg, 2, szBufStack)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /*=
 Allocate on heap and retry=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                char *szMessage =3D malloc(alloc_size);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (szMes=
sage !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              vsnprintf(szMessage, alloc_size, format, arglist);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    MsiRecordS=
etStringA(hRecordProg, 2, szMessage);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    free(szMessage);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    /* Use truncated stac=
k variant anyway */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    MsiRecordSetStringA(hRecordProg, 2, szBufStack);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><b=
r><span>             }</span><br><span>         }</span><br><span>     }</s=
pan><br><span>@@ -159,7 +157,7 @@</span><br><span>         MsiRecordSetInte=
ger(hRecordProg, 1, ERROR_MSICA_ERRNO);</span><br><span> </span><br><span> =
        /* Field 3: The Windows error number=2E */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        MsiRecordSetInteger(hRecordProg, 3, dw=
Result);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Msi=
RecordSetInteger(hRecordProg, 3, (int)dwResult);</span><br><span> </span><b=
r><span>         /* Field 4: The Windows error description=2E */</span><br>=
<span>         LPWSTR szErrMessage =3D NULL;</span><br><span>@@ -194,7 +192=
,3 @@</span><br><span>                       hRecordProg);</span><br><span>=
     MsiCloseHandle(hRecordProg);</span><br><span> }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br></pre><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2358?usp=3Demail"=
>change 2358</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/23=
58?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 2358 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Fr=
ank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bod=
y></html>
--41jl6z2Lf6E=--


--===============3988735763589792233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3988735763589792233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3988735763589792233==--

