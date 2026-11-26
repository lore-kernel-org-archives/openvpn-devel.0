Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FBB606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KJb20lps;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZdwJZkaU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lG34gVL+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XF68Ard6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=UJ/IjdxHpWaN+oEw9rS8YGJEtgBElrSUGbZklMNHNLo=; b=KJb20lpsHNn+CK/EjeArLWYbyl
	/sgiATSohoX1uvt9aatwFLRhQ9sw9Qg0vC+s4jBlUbTP3y0qjDObI2HLH0WtpGRtKw/nKMMKWdiLO
	TTPbRvZYi/OvVJpJ9xvMqAkek+3vISdVWSZeRSq29NpBVsz8Lj4GjR8FW20RKtVHW8gI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWdOj-000000006de-2fdX;
	Thu, 26 Nov 2026 17:36:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWdOc-000000006dV-2Td4
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 17:36:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+1totkBhu+Npn9mQ5SMchBZsVwLFUcT/ASLRRXHlHvM=; b=ZdwJZkaUSdiwvSmncFE2b6lFZq
 w5fgqQD2Smy7E4N8BRtx5nd2oAz9BT5gfoDPAcNkCju85Jwgizrtu66Nad3Uua6XsCFq+Qk9zIRp4
 Hy5Ntr2LWEjHQKbsHxtfIYLGjIQ73d6Ccweqs+XRbX00TJeYEwRG4OHAWFd53lrUmQ64=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+1totkBhu+Npn9mQ5SMchBZsVwLFUcT/ASLRRXHlHvM=; b=lG34gVL+KkbrtRMje4TsgvBpb/
 TPM0d4Hc+iMNkm1FAxe2cyP/udSm0ZymxT4EnhDMWW/490SIZIfkT1R69WEoUKrSuls+QrHcMZHPc
 dq/UQdFfItAISUnWjDt0xn5gAnCNmzUEFKadJVRRuQ0YBBmgrMJzbljn53s2MpQYOvWI=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWdOZ-000000001Os-2oNe for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 17:36:33 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so64357165e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 09:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795714585; x=1796319385; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+1totkBhu+Npn9mQ5SMchBZsVwLFUcT/ASLRRXHlHvM=;
 b=XF68Ard6/PmD0bkGdKkxBG1ytZ/BRedzEBb8Tp6egSJ1AQX/Au9SgeAfr+qcxK0ZKd
 GIARhCduOu7rMTp9uToogoHOQK3WI/ibj0AM2MWxkq/2+AIQqwcopib/vv2ilxK6qwXC
 Gyb2QU4DtDvWwcDtBSUuITp3c8OKOKLN2b3BCWSw6eFyg3CUkykR1mblNGeJsn0nu1sK
 kXAwYT8oiQerje/ODWyMcSBUVav8iEYyM3exYT68Cb1PC5HZWN6tb5SJB+ieuF8Mj8V5
 YxfjORva/DV4e/Im4d84PblHJIO3TI+R/QBclFCtHkVAVX1KLoYFcdN6Wxh1WQWlZPY1
 pk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795714585; x=1796319385;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+1totkBhu+Npn9mQ5SMchBZsVwLFUcT/ASLRRXHlHvM=;
 b=mREpJhFQ0osRQ/wbLIejL+MOz94K97AeU8+WDCwInaJ+e7GjddMY32i1gxbXJGDba8
 W1xg+mYzi4D6LoTfhcueY2FLlnJU8U7kX55GyGR5pkWqAh+WPPefLyiclKTMRM8wMZdZ
 BVZ1Ju0395s2/nYan2gPs8RqP8vv7XehYVCchlbciQxkTSx0jn2THDSJjEaH+XfjaOaF
 LHfTV2hGoTSK2yNqiHgafbPHAczrb6qKy9oS7IWRrHcT4vOG+21UWjePk2srBIjY+6O4
 JV73fn59Es5YijH6LYzc+fZbCiIQ70YLgZtcXAIp8zS+Qh5QIFMwRrzZWU3j27fryKjx
 SMXg==
X-Gm-Message-State: APuU4Z/HRW/kwVoyeIFFSaP1rlS8ODbLOe1JGqST3qPp4IVZb0945EM7
 8XfzjASFteAq90bTauiMfJEErgsk6pnsjUdNs7Qb3i0vCZMxSI6u0h1JEctlRPla9dW6IC1r58q
 L0hmlqWt9LHyPlumMiriDAICWt6MLfiYW68qyX5m6ZPENOTbgzx2y3KGr+kEshiRoVfeIXMMT+a
 DAU/x1uQ==
X-Gm-Gg: AZFdTZfu0waxmK/IV2bo6/I1zvoyCLdEWPY0Gyq6du+fM3fG+LBGC9rBKitapnBvxGo
 Mygm/jrQ/YLtwCSKVLq/RcILoQKXu+x+OY/V695UvhtwxSVmAg/yO0luzGdj12R8SkNCxRwwncB
 jOiPXXzEvYWSm9+sWWKnpmuATZXd/nWfDT/34+3VtTSPEDzxAnVbzqMazuZWAXJcmnRJwZt5Fc/
 D3UR45fxaO6fmbMSFNKGZRBUV/+O3MdycPwO3zjze8jq7FJcmWy9aKb4Rxgc9ENl0auhQZb5DTm
 5MLDR/G7tss9alYU6sigisK/wJTK4xRiIhOIhEqDZmWCW6JR1NbmOx9sCENLz1Cij9533LBLifi
 USWEZvS9JlNxN33kETNIzOWFBiJCGTPrn1DhjaZhpw2dofQnrXeiJtWAybTG9qgoFV9koMZVlek
 7As1vPAf9nAftTX6+R6/PvvDJNyDmR1QVieqeIR7rgNv/1lq+CXdson31sG59ezjAzjxNKxRqQ0
 6rvbKSo3+bswbGB0NP5M6YlKiwozsL9UCsMuUGLcgNHH7//3+0J7j53rW313RWqQVXlNQuNagmK
 JgaZDo/thDr4dE0fLY+iSVvJz1e8UjNkIc2YGAvBCmzg8tgwqe9dzjU+M5Evi32CT39plrDawYb
 apGwXWxT85+3qZ1xTUGKjfN2JNsON9ojwYqu1Zfu3wix446FoaiB3bNWtSeYDwltlY0k0GqjrE/
 y4kwPsqaXtTkaCvtQ=
X-Received: by 2002:a05:600c:3b0e:b0:4a1:efba:511 with SMTP id
 5b1f17b1804b1-4bb8882508emr466488095e9.35.1795714584990; 
 Thu, 26 Nov 2026 09:36:24 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b39b6sm572323455e9.12.2026.11.26.09.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 09:36:24 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 17:36:24 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7
X-Gerrit-Change-Number: 2358
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2358?usp=email>
X-Gerrit-Commit: ab5643eb461c214fd3e46dea5210b383809159b7
References: <gerrit.1795714582000.Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzE0NTgyMDAwLklhNWMyNjViZDFmMjcyM2JlOTNmYjhmYmI3M2U3M2E0ZTg2ZDFjYWM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e7ecff6efc50bc51605d50512cee79caf73d2479-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWdOZ-000000001Os-2oNe
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0200417665864262297=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0200417665864262297==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Td55Uk/XjkY="; charset=UTF-8

--Td55Uk/XjkY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2358?usp=3Demail

to review the following change=2E
=


Change subject: openvpnmsica: Clean up sign conversion warnings
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnmsica: Clean up=
 sign conversion warnings

Improve code in x_msg_va to handle vsnprintf res=
ult=2E

Removes explict null termination that is not required
in supported =
versions of Windows=2E

Includes one unrelated cast that is too small to
wa=
rrant its own commit=2E

Change-Id: Ia5c265bd1f2723be93fb8fbb73e73a4e86d1ca=
c7
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/ope=
nvpnmsica/dllmain=2Ec
1 file changed, 19 insertions(+), 25 deletions(-)



=
  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/2358/=
1

diff --git a/src/openvpnmsica/dllmain=2Ec b/src/openvpnmsica/dllmain=2Ec=

index 777c823=2E=2Ee191207 100644
--- a/src/openvpnmsica/dllmain=2Ec
+++ b=
/src/openvpnmsica/dllmain=2Ec
@@ -98,11 +98,6 @@
     return true;
 }
 
-#i=
f defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pr=
agma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 void
 x_msg_va(c=
onst unsigned int flags, const char *format, va_list arglist)
 {
@@ -124,26=
 +119,29 @@
         /* Field 2: The message string=2E */
         char szB=
ufStack[128];
         int iResultLen =3D vsnprintf(szBufStack, _countof(sz=
BufStack), format, arglist);
-        if (iResultLen > 0 && (unsigned int)i=
ResultLen < _countof(szBufStack))
+        if (iResultLen > 0)
         {
-=
            /* Use from stack=2E */
-            MsiRecordSetStringA(hRecor=
dProg, 2, szBufStack);
-        }
-        else
-        {
-            /* =
Allocate on heap and retry=2E */
-            char *szMessage =3D (char *)m=
alloc(++iResultLen * sizeof(char));
-            if (szMessage !=3D NULL)
+=
            const size_t alloc_size =3D (size_t)iResultLen + 1;
+          =
  if (alloc_size <=3D _countof(szBufStack))
             {
-               =
 vsnprintf(szMessage, iResultLen, format, arglist);
-                MsiRec=
ordSetStringA(hRecordProg, 2, szMessage);
-                free(szMessage);=

+                /* Use from stack=2E */
+                MsiRecordSetStri=
ngA(hRecordProg, 2, szBufStack);
             }
             else
         =
    {
-                /* Use stack variant anyway, but make sure it's zero=
-terminated=2E */
-                szBufStack[_countof(szBufStack) - 1] =3D=
 0;
-                MsiRecordSetStringA(hRecordProg, 2, szBufStack);
+    =
            /* Allocate on heap and retry=2E */
+                char *szMe=
ssage =3D malloc(alloc_size);
+                if (szMessage !=3D NULL)
+  =
              {
+                    vsnprintf(szMessage, alloc_size, forma=
t, arglist);
+                    MsiRecordSetStringA(hRecordProg, 2, szMes=
sage);
+                    free(szMessage);
+                }
+          =
      else
+                {
+                    /* Use truncated stack v=
ariant anyway */
+                    MsiRecordSetStringA(hRecordProg, 2, s=
zBufStack);
+                }
             }
         }
     }
@@ -159,7 +=
157,7 @@
         MsiRecordSetInteger(hRecordProg, 1, ERROR_MSICA_ERRNO);
 =

         /* Field 3: The Windows error number=2E */
-        MsiRecordSetI=
nteger(hRecordProg, 3, dwResult);
+        MsiRecordSetInteger(hRecordProg,=
 3, (int)dwResult);
 
         /* Field 4: The Windows error description=2E=
 */
         LPWSTR szErrMessage =3D NULL;
@@ -194,7 +192,3 @@
            =
           hRecordProg);
     MsiCloseHandle(hRecordProg);
 }
-
-#if define=
d(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif

-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2358?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia5c265bd1f2723be93fb8=
fbb73e73a4e86d1cac7
Gerrit-Change-Number: 2358
Gerrit-PatchSet: 1
Gerrit-Ow=
ner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>

--Td55Uk/XjkY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2358?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">openvpnmsica: Clean up sign conversion warnings<br><br>Imp=
rove code in x_msg_va to handle vsnprintf result=2E<br><br>Removes explict =
null termination that is not required<br>in supported versions of Windows=
=2E<br><br>Includes one unrelated cast that is too small to<br>warrant its =
own commit=2E<br><br>Change-Id: Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<b=
r>M src/openvpnmsica/dllmain=2Ec<br>1 file changed, 19 insertions(+), 25 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/58/2358/1</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnmsica=
/dllmain=2Ec b/src/openvpnmsica/dllmain=2Ec</span><br><span>index 777c823=
=2E=2Ee191207 100644</span><br><span>--- a/src/openvpnmsica/dllmain=2Ec</sp=
an><br><span>+++ b/src/openvpnmsica/dllmain=2Ec</span><br><span>@@ -98,11 +=
98,6 @@</span><br><span>     return true;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> x=
_msg_va(const unsigned int flags, const char *format, va_list arglist)</spa=
n><br><span> {</span><br><span>@@ -124,26 +119,29 @@</span><br><span>      =
   /* Field 2: The message string=2E */</span><br><span>         char szBuf=
Stack[128];</span><br><span>         int iResultLen =3D vsnprintf(szBufStac=
k, _countof(szBufStack), format, arglist);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (iResultLen &gt; 0 &amp;&amp; (unsigned int=
)iResultLen &lt; _countof(szBufStack))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (iResultLen &gt; 0)</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Use f=
rom stack=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      MsiRecordSetStringA(hRecordProg, 2, szBufStack);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            /* Allocate on heap and retry=2E */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            char *szMessage =3D (char *)malloc(++=
iResultLen * sizeof(char));</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            if (szMessage !=3D NULL)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            const size_t alloc_size =3D (size_t)iRes=
ultLen + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    if (alloc_size &lt;=3D _countof(szBufStack))</span><br><span>          =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                v=
snprintf(szMessage, iResultLen, format, arglist);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                MsiRecordSetStringA(hRecordProg=
, 2, szMessage);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           free(szMessage);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                /* Use from stack=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                MsiRecordSetStringA(hRecordProg=
, 2, szBufStack);</span><br><span>             }</span><br><span>          =
   else</span><br><span>             {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                /* Use stack variant anyway, but make sure=
 it&#39;s zero-terminated=2E */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                szBufStack[_countof(szBufStack) - 1] =3D 0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                MsiRecordSe=
tStringA(hRecordProg, 2, szBufStack);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                /* Allocate on heap and retry=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                char *szM=
essage =3D malloc(alloc_size);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                if (szMessage !=3D NULL)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    vsnprintf(szMessage, =
alloc_size, format, arglist);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    MsiRecordSetStringA(hRecordProg, 2, szMessage=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   free(szMessage);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 /* Use truncated stack variant anyway */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    MsiRecordSetStrin=
gA(hRecordProg, 2, szBufStack);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                }</span><br><span>             }</span><br><spa=
n>         }</span><br><span>     }</span><br><span>@@ -159,7 +157,7 @@</sp=
an><br><span>         MsiRecordSetInteger(hRecordProg, 1, ERROR_MSICA_ERRNO=
);</span><br><span> </span><br><span>         /* Field 3: The Windows error=
 number=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
MsiRecordSetInteger(hRecordProg, 3, dwResult);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        MsiRecordSetInteger(hRecordProg, 3, (int=
)dwResult);</span><br><span> </span><br><span>         /* Field 4: The Wind=
ows error description=2E */</span><br><span>         LPWSTR szErrMessage =
=3D NULL;</span><br><span>@@ -194,7 +192,3 @@</span><br><span>             =
          hRecordProg);</span><br><span>     MsiCloseHandle(hRecordProg);</=
span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2358?usp=3Demail">change 2358</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2358?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: Ia5c265bd1f2723be93fb8fbb=
73e73a4e86d1cac7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2358 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--Td55Uk/XjkY=--


--===============0200417665864262297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0200417665864262297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0200417665864262297==--

