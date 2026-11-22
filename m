Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD27606A32A
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TdSRTbOe;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=M6aE/sqh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=D1qfUVcy;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QQMW5sqD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=E0pSj3VzAwk7Zo7Iva73vypMmEzmMsCSwZ0IKwBz3H8=; b=TdSRTbOeMHgtBe9jnp59QZRdl3
	vH8ZeRbFScFPTIY3Dcwid/GS5h/4fc6ATO3rkMaNRJzcTPOjOvX+KQOxXUDlVMiHn6vs5gH4YWWha
	s77jrytsWmxNC72y9Z2iGAMn2X9rSaHM0mwRREaHAVF56A2QnOh5NPMh3Vkbtufe36EY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV7M7-000000002Sl-1TEq;
	Sun, 22 Nov 2026 13:11:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xV7Ln-000000002R3-3dgR
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 13:11:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vcv3579pCMC5AfkrwGJzxtSwGNIMh8bk6YmkNAVa0Wg=; b=M6aE/sqhD4uuxpXTrZAJTo7ihk
 gnVfm2S/zWT3n8XH042JPtVD2NyhBKgx24jISbmOZgFPaWUwDg1tzG1iRFCDJ0JFC/2fHTBIFBSyy
 y6X4a5Kgpz5TprniNOg9OKWzije0enQ/GkIhAXzuu2Qr0bjDXGMp9P4BllGM/sqHJnDc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vcv3579pCMC5AfkrwGJzxtSwGNIMh8bk6YmkNAVa0Wg=; b=D1qfUVcynUe+GhNDVXNxeulasT
 yDqJyE7ENWxrdoLbV5zfZS309EUGqtynWbFst8m4Qca36zZ/Rb+LyRmmhI9BpbmPkR57cIWT+kUoA
 Se0OuV84OdxqHAhexTVGfA7mhh3s3WCF61NAFXmnXnVx8qjq4OYrz8wBo9macZkN0woY=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xV7Lb-0000000077d-05EW for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 13:11:12 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so22729475e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 22 Nov 2026 05:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795353064; x=1795957864; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vcv3579pCMC5AfkrwGJzxtSwGNIMh8bk6YmkNAVa0Wg=;
 b=QQMW5sqDntLoF7P9ljSOIfSr0sX6oahiuhKhTKPsWpPTLffbFMpCrbsPzxGpuf/b/A
 Ad5lghD7ulbBd09Y569/mu/Z6IQCXEby0wEdfoZfya/X6ZyS8gXA/mCD4dFNiUsvUW5q
 nzuY+WNMtQUa1kXlS5xdjco5pVPt6WQmYyWkLZwqARK/Xdo6DKJUCZh/9PPZuCTJwNdT
 0YVtkSvqXkGL4vYi53cCUo33eKUAbZK76/Gy/uGMszVqU54+C2qFkk1XWdWznp7igOr0
 qntszcD5q/FNPcw1gLm5nbgMn7fP/9MlEoTfXCjvQO0dpmGYMCtalSfYVDk23dub546Z
 +8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795353064; x=1795957864;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vcv3579pCMC5AfkrwGJzxtSwGNIMh8bk6YmkNAVa0Wg=;
 b=uQBMPnszMsnyY5zlB2LGGeybg+6lsOGESjq9z9b5Y537bl+tbnT2+l4Z9v1vpS6AeH
 nsO0pwi5BthXsiso+JXC4Skha0+YebV2qO56OWMkDOs0NMk5FAnJPEotNOjgKfmraIE2
 mEGwzQkCwWazZ9nxWTdfnue58V0YhhV/yjd5I0Q0Ky/BCKl3FDbH8c6S1puw7W4fIYWN
 Xf39ooGmaqExj+1/PWjpwk28mtRuX9K+/LK9VUi1mUtroc/pejSs7F9MjqU/N9tmUMfx
 Qe+VHRhVmHFBi7PwlmbqE/DF0aRLfhSLMtTgYR5cRf9B9MTlFMcAF1ccZXSpdHG5+/a0
 pGWg==
X-Gm-Message-State: APuU4Z80+GOY5O/n4xwiqfty/+cMTl7oTqQkow/Pwrzvjz98y+/v0a32
 vZTtRXpKDnPmqJdKLQygmFs2xtjChSwYXWBuDbXe+7wYgn7VF7+UiDjyuH5ekXCGjluYlMPZiyg
 mYkztIXuXUOESGy/prr+rEFjAkR21utK4UWPfwPOShokVuU7ieLZQ/xQDjA4Pl0lfedSWbvJ6FC
 F/gueEfQ==
X-Gm-Gg: AZFdTZdwY+QU2MxWu79/19Fao9zzEMhVcbL3DnLIhSbYXhRejr9MWRQHt14RPuMNYuj
 gLjlRJUcOQlUoAwb/Rra7EAY1iqI3S19I0H8mqybeGZ7Coo74EG546ZHR+Sf4MpLY7NGT0mYBRs
 rNFBZbeMSrJ0OS+5dvQlHBrkOvn7XmfztcloU1mPKUOnB7XgX9rs+d5rsV6Nvt0Aru4AWo9tI8W
 bEYi7/ZT5VnCeQ9Aab4T+VYu0sB0SQaJb5ASQB3CvhEgsu2qhaj6Iz0o4UloIV1VqEH2UNEwiL0
 H+iii6cuBR0YAvTsYXXoXCrwteMWdFdFYpb60DHBXBjHiLO8lzKAOss4ZeOrMNKoYJPr76PAhqr
 sAWrVRnuWm1anVZUAzodpljiaCsT1oO2KtOECUQ+YdZH3Z+fsH8sgv/LudxbKQ+Hi3JdUHkBTxQ
 rTI2MrINcTJ3p00ktZkz+JHfNQOKZiHgYz8t+WBfSsoqTEOgTixe30vLOgxigQdAcuql4oeJZNo
 xvlpnRnQ8hgzJdF1Gpvl469zQ7JAyqTLK+Zz5WjcBocyu9ArxmXY04uJRnCPL5UCdZBcUbG8wpD
 BpBg0ZB+4QKvPj6m41GMXP2YKRtnOHYAvScxTou0ZF6T0FAGXiEd0LiG2z9KMFhtv7HcG86F42/
 yx0loHzABf6R9v4OOO/LBjiIdb6M9A6jbTKVZtHCeaTY+99SDGtmP47dTK5yd68qCW+sQJ0AAas
 L6H8qNBUrAJaEdKEr8
X-Received: by 2002:a05:600c:5487:b0:4bb:5de1:e92c with SMTP id
 5b1f17b1804b1-4bb88813157mr185303695e9.26.1795353064302; 
 Sun, 22 Nov 2026 05:11:04 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b2c5sm269465665e9.5.2026.11.22.05.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 05:11:04 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 13:11:03 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I58b88ca3934e52cfc5140a564c9ed7260857ce80
X-Gerrit-Change-Number: 2238
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2238?usp=email>
X-Gerrit-Commit: 28cf00257af563148e87c13274adad29a482fb3a
References: <gerrit.1795353062000.I58b88ca3934e52cfc5140a564c9ed7260857ce80@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MzUzMDYyMDAwLkk1OGI4OGNhMzkzNGU1MmNmYzUxNDBhNTY0YzllZDcyNjA4NTdjZTgwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7a3201e2574ef1da64d374157b65d0e5f1a04316-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xV7Lb-0000000077d-05EW
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: drop
 redundant NULL checks
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1977032253464385907=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1977032253464385907==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Tdlm4mftq+c="; charset=UTF-8

--Tdlm4mftq+c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2238?usp=3Demail

to review the following change=2E
=


Change subject: manage: drop redundant NULL checks
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: drop redundant NULL checks=


man_need() already guarantees p[1] for log and echo, and
up_query_type is=
 non-NULL once "needed" holds in
man_query_password_base64()=2E

Change-Id:=
 I58b88ca3934e52cfc5140a564c9ed7260857ce80
Signed-off-by: Razvan Cojocaru <=
razvanc@mailbox=2Eorg>
---
M src/openvpn/manage=2Ec
1 file changed, 3 inser=
tions(+), 9 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/38/2238/1

diff --git a/src/openvpn/manage=2Ec b/src/op=
envpn/manage=2Ec
index 86c498e=2E=2Ed5b1ff8 100644
--- a/src/openvpn/manage=
=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -1051,7 +1051,7 @@
         msg(M_CLIE=
NT, "ERROR: no password is currently needed at this time");
         return=
;
     }
-    if (!man->connection=2Eup_query_type || !streq(man->connectio=
n=2Eup_query_type, type))
+    if (!streq(man->connection=2Eup_query_type, =
type))
     {
         msg(M_CLIENT, "ERROR: password of type '%s' entered,=
 but we need one of type '%s'",
             type, man->connection=2Eup_que=
ry_type);
@@ -1684,10 +1684,7 @@
     {
         if (man_need(p, 1, MN_AT_L=
EAST))
         {
-            if (p[1])
-            {
-                ma=
n_log(man, p[1]);
-            }
+            man_log(man, p[1]);
         =
    if (p[2])
             {
                 man_log(man, p[2]);
@@ -1698,=
10 +1695,7 @@
     {
         if (man_need(p, 1, MN_AT_LEAST))
         {
-=
            if (p[1])
-            {
-                man_echo(man, p[1]);
=
-            }
+            man_echo(man, p[1]);
             if (p[2])
   =
          {
                 man_echo(man, p[2]);

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2238?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I58b88ca3934e52cfc5140a564c9ed7260857ce80
=
Gerrit-Change-Number: 2238
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--Tdlm4mftq+c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2238?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">manage: drop redundant NULL checks<br><br>man_need() al=
ready guarantees p[1] for log and echo, and<br>up_query_type is non-NULL on=
ce &quot;needed&quot; holds in<br>man_query_password_base64()=2E<br><br>Cha=
nge-Id: I58b88ca3934e52cfc5140a564c9ed7260857ce80<br>Signed-off-by: Razvan =
Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/manage=2Ec<b=
r>1 file changed, 3 insertions(+), 9 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/38/223=
8/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</s=
pan><br><span>index 86c498e=2E=2Ed5b1ff8 100644</span><br><span>--- a/src/o=
penvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><s=
pan>@@ -1051,7 +1051,7 @@</span><br><span>         msg(M_CLIENT, &quot;ERRO=
R: no password is currently needed at this time&quot;);</span><br><span>   =
      return;</span><br><span>     }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (!man-&gt;connection=2Eup_query_type || !streq(man-&g=
t;connection=2Eup_query_type, type))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!streq(man-&gt;connection=2Eup_query_type, type))<=
/span><br><span>     {</span><br><span>         msg(M_CLIENT, &quot;ERROR: =
password of type &#39;%s&#39; entered, but we need one of type &#39;%s&#39;=
&quot;,</span><br><span>             type, man-&gt;connection=2Eup_query_ty=
pe);</span><br><span>@@ -1684,10 +1684,7 @@</span><br><span>     {</span><b=
r><span>         if (man_need(p, 1, MN_AT_LEAST))</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (p[1]=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                man_log(man,=
 p[1]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            man_log(=
man, p[1]);</span><br><span>             if (p[2])</span><br><span>        =
     {</span><br><span>                 man_log(man, p[2]);</span><br><span=
>@@ -1698,10 +1695,7 @@</span><br><span>     {</span><br><span>         if =
(man_need(p, 1, MN_AT_LEAST))</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            if (p[1])</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                man_echo(man, p[1]);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            man_echo(man, p[1]);</span>=
<br><span>             if (p[2])</span><br><span>             {</span><br><=
span>                 man_echo(man, p[2]);</span><br></pre><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2238?usp=3Demail">c=
hange 2238</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2238=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I58b88ca3934e52cfc5140a564c9ed7260857ce80 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 2238 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body><=
/html>
--Tdlm4mftq+c=--


--===============1977032253464385907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1977032253464385907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1977032253464385907==--

