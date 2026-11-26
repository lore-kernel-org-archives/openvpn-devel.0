Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564F8606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HvShekih;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dZmE4/m4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ir2fNjOH;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DXf8mSSD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=2qrOaIYRKJvvS9ocS5xjS+9qh7jwUZRHYJDu12vQgHY=; b=HvShekih9xCzAf2G2sJKdOHjgr
	/csd2XzcJrIABHuKh6jvyQ52xwZtX9XfO8V+Kn+xmHHUntQ4ihzObrYEsLA+NdFWbxRf1WRhVIBZi
	w0BQA4eAUmhzN1SATtu4WRMJ0dmeDUvnOJyUrqY4puMuKLpMM3rEhG2KbRj/BW+KjX1U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWXHD-000000005Db-0X1W;
	Thu, 26 Nov 2026 11:04:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWXHB-000000005DN-2dWZ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:04:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YnzzD5/bMCjF7+TuX6aTllkl1qs8sdGaB8d7FoZstxk=; b=dZmE4/m4KGo6sTjK2Xi0FyUh20
 TLdGOmVCwq6vcgrrld8WkTyBqw4vRbiPk7+xm7Kp5d56ypTPaN20FQRzcFA7wukxB5rNIE78RSb1u
 HDJSIONMbfYP7OdX/02AsBiF3NCH6z50o/clSabU2sZ8c6RH8ZzcszV3SWmnHFiXYCeo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YnzzD5/bMCjF7+TuX6aTllkl1qs8sdGaB8d7FoZstxk=; b=ir2fNjOHbH0Ykracu14ionjVF6
 9Zt2se5uuhOpVDOiadXpb65/6fZC/1lzI4c6wGYv8BWJfQpxL/wfSytHN4VByAzxn/uw6zY+fu1JW
 O2zbsrAt+ANL6JcnSKrA0GSjG46NiZDemlD9a+5Y36fhcv4TkhYlVAgN0ypF3LuFhZkA=;
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWXH9-0000000083t-3fGc for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:04:29 +0000
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c5198302d38so436079566b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 03:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795691061; x=1796295861; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YnzzD5/bMCjF7+TuX6aTllkl1qs8sdGaB8d7FoZstxk=;
 b=DXf8mSSDIWT2SQbbZcZd3MeuF8LNTCmwyziLdzDhpc0kopdfmZdDjGdt+k02L5rDja
 5hHmKPiOXWyuOb2U4wAwJ12T80bAbAD5Ha8ISezoskMd0lOnBk6rG2jC/VnY6buLy4hD
 tCmwT+h6DSaGmHbV2SFBmAl/laJ7JV7G+4aqUHO88uve/vHKKiO0MXSvj4/CtIDEhlBf
 f0PtsSknB8Hq7zVPBVvEFlYOXvrtySCXc1NHum+4nbICm7cOXXmoPau4Anb4TVJ4O4LL
 qNIw3oK1zSp+9Hzj5OFM05FHcYGFwRf56211t4PTDI0xw3ZWbhcas6Au7uI32hdRX1QW
 HnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795691061; x=1796295861;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YnzzD5/bMCjF7+TuX6aTllkl1qs8sdGaB8d7FoZstxk=;
 b=M2XHFiBtSqeN6squ3flRr7o7x8CXOTigkRFY0wMfnXIK63DLqhiUR2j0gZA3TpN504
 qNCszp6dB1T/a6JYFEZzUvXIy8/9xVcFkRNiY/LZ8cFORJTTPE3/INL3+G2/rUMS6ug9
 4OBoEGTyoYgBKQFz1gpzc/QF4vgMP2eXIYYI4rNABsiUAy5Uo9CjKVvTaWWjlJlWNen8
 o3oWPvKtP86yvmoHS4yOCCg/OHr8Ll8gEw6yXQv2rQ00ip8QJfwy6/j9aRusJ735MkVM
 v1ZDngtLZ/znU/OGCFTIHrG0ATTAy770IsR7sRKK0S7pW3d9PdNxDC9V11UXrhr/W93U
 FViw==
X-Gm-Message-State: APuU4Z++bxqt/+d4qRh1OsV6c3hNeXd8spDROb5II1cJkjGLUKuDDE0O
 LZDkaza1l6GhiHXzAAtf2AqupniuUwkOsN0yOiWupx0f8Lxboc9bEPmH8C4IANexrH246wNGqTg
 aaCxpI8cj0SrRdvUt3seTvwruq1BwOfT6PXfe9lW1LNWB3PuFjD6wMxtSTip/MP8Wyhx8ToD/3e
 LX0kS/+g==
X-Gm-Gg: AZFdTZeZJJIHN8BrBsNAgHysAioc/Szxq38MFeoTB0VDzjT8NXcptcdnVXkYLpTl719
 S2EVQC1Q6ESkcUSs1/jar1DwZ4pWw7OXH558thecVkOa/k+ZXqG6/DTpiN15AJ86QoK5b1JaesV
 PdTmpzaBoG+aqKXlBf3wVvTtzTqTndJ/x6aDumXyJiw6s8C+cNwj6yCwfpmBrg5RGJbyEljjJYs
 GtG5DUhSS370cp3JoWG3g9BA4dI175pmeSNHQZhNQD9fvJZhX91htaT5mxGF3dDDlqr9CqTk1To
 y/HekBEzSSB76p2Q7Kk39yP9sMUmiEK1v2OyWA0QfSa44Ufp2HErL7r2Cte8OLlwEssm+iSe3H5
 lnktUhp1yyxSNnF7kbM8HOfYyZyEtIA1D7CYkX1XJW8zJfnUjpz7d/n1xli3eqNyui/5XMTtjno
 YT6Rx5YKoR/i/HsA0YF7VNfFGAtmFOiiQLpwDO8bQPnnG36siQnaB1pTR7oPjeUNMfhgfq1lNsU
 uwWyHTtVR4vBH2bP5+Y++GPUzby1fiNZ0bft86bh/xGfZzaR34ls6wEgaj5h1uXf/TAJssO8pGg
 HoLae7k2bRYIH5KYlu8GdFdihwZqFfAP+o+ATxM/Q1HaCe1tQT6LIgrud8IDe/FBZAZPK/z+tot
 0wZi6aWVnMIhRN7CXCOHiPOGtYxLUnYY8ghpUZQfqMmHr20hPrZoFPPpHqd4tNS1AbchB2ry1C3
 jVagjHWq/nxBobA2EWbK4JAVGxY+KdTZr8vF+e
X-Received: by 2002:a17:907:9111:b0:c4d:31c5:cda with SMTP id
 a640c23a62f3a-c513a8140bdmr1238822166b.21.1795691060962; 
 Thu, 26 Nov 2026 03:04:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f1b2sm36935699f8f.25.2026.11.26.03.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 03:04:20 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 11:04:20 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ibc58b9c3029ffea4f87093178cf52bbb46f6d837
X-Gerrit-Change-Number: 2352
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2352?usp=email>
X-Gerrit-Commit: 873b2cd4bc26da9fe39034cbd8b7add1a858082d
References: <gerrit.1795691059000.Ibc58b9c3029ffea4f87093178cf52bbb46f6d837@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjkxMDU5MDAwLkliYzU4YjljMzAyOWZmZWE0Zjg3MDkzMTc4Y2Y1MmJiYjQ2ZjZkODM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dfdb7dfe27b6faa57aced7165333293cf42a762c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWXH9-0000000083t-3fGc
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: fold the
 post-event-loop signal check into one condition
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
Content-Type: multipart/mixed; boundary="===============6801062620295851278=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6801062620295851278==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gHwXPTlfezg="; charset=UTF-8

--gHwXPTlfezg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2352?usp=3Demail

to review the following change=2E
=


Change subject: manage: fold the post-event-loop signal check into one co=
ndition
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mana=
ge: fold the post-event-loop signal check into one condition

Four standalo=
ne event loops checked signal_received, called
man_check_for_signals() if i=
t was unset, then checked it again=2E
man_check_for_signals() returns wheth=
er a signal is now pending, so
the same logic fits in a single short-circui=
t condition=2E

Change-Id: Ibc58b9c3029ffea4f87093178cf52bbb46f6d837
Signed=
-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/manage=
=2Ec
1 file changed, 4 insertions(+), 20 deletions(-)



  git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/2352/1

diff --git a/sr=
c/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index bbf454a=2E=2Edd72179 10=
0644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -3620,11 =
+3620,7 @@
         do
         {
             man_standalone_event_loop(ma=
n, &signal_received, expire);
-            if (!signal_received)
-         =
   {
-                man_check_for_signals(&signal_received);
-           =
 }
-            if (signal_received)
+            if (signal_received || ma=
n_check_for_signals(&signal_received))
             {
                 retu=
rn;
             }
@@ -3762,11 +3758,7 @@
             do
             {
  =
               man_standalone_event_loop(man, &signal_received, 0);
-      =
          if (!signal_received)
-                {
-                    man=
_check_for_signals(&signal_received);
-                }
-                i=
f (signal_received)
+                if (signal_received || man_check_for_s=
ignals(&signal_received))
                 {
                     ret =3D f=
alse;
                     break;
@@ -3847,11 +3839,7 @@
         do
      =
   {
             man_standalone_event_loop(man, &signal_received, 0);
-   =
         if (!signal_received)
-            {
-                man_check_fo=
r_signals(&signal_received);
-            }
-            if (signal_receive=
d)
+            if (signal_received || man_check_for_signals(&signal_receiv=
ed))
             {
                 goto done;
             }
@@ -3990,11 =
+3978,7 @@
             do
             {
                 man_standalone_e=
vent_loop(man, &signal_received, 0);
-                if (!signal_received)=

-                {
-                    man_check_for_signals(&signal_rece=
ived);
-                }
-                if (signal_received)
+          =
      if (signal_received || man_check_for_signals(&signal_received))
     =
            {
                     break;
                 }

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibc58b9c3029ffea4f87093178cf52b=
bb46f6d837
Gerrit-Change-Number: 2352
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>

--gHwXPTlfezg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">manage: fold the post-event-loop signal check into one =
condition<br><br>Four standalone event loops checked signal_received, calle=
d<br>man_check_for_signals() if it was unset, then checked it again=2E<br>m=
an_check_for_signals() returns whether a signal is now pending, so<br>the s=
ame logic fits in a single short-circuit condition=2E<br><br>Change-Id: Ibc=
58b9c3029ffea4f87093178cf52bbb46f6d837<br>Signed-off-by: Razvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/manage=2Ec<br>1 file ch=
anged, 4 insertions(+), 20 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/2352/1</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><spa=
n>index bbf454a=2E=2Edd72179 100644</span><br><span>--- a/src/openvpn/manag=
e=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -3620=
,11 +3620,7 @@</span><br><span>         do</span><br><span>         {</span=
><br><span>             man_standalone_event_loop(man, &amp;signal_received=
, expire);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (!signal_received)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         man_check_for_signals(&amp;signal_received);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            if (signal_received)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (signal_received || man=
_check_for_signals(&amp;signal_received))</span><br><span>             {</s=
pan><br><span>                 return;</span><br><span>             }</span=
><br><span>@@ -3762,11 +3758,7 @@</span><br><span>             do</span><br=
><span>             {</span><br><span>                 man_standalone_event=
_loop(man, &amp;signal_received, 0);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                if (!signal_received)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    man_check_for_signals(&amp;=
signal_received);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        if (signal_received)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                if (signal_received || man_check_for_signals(&amp;=
signal_received))</span><br><span>                 {</span><br><span>      =
               ret =3D false;</span><br><span>                     break;</=
span><br><span>@@ -3847,11 +3839,7 @@</span><br><span>         do</span><br=
><span>         {</span><br><span>             man_standalone_event_loop(ma=
n, &amp;signal_received, 0);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            if (!signal_received)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                man_check_for_signals(&amp;signal_received);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            if (signal_received)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (sign=
al_received || man_check_for_signals(&amp;signal_received))</span><br><span=
>             {</span><br><span>                 goto done;</span><br><span=
>             }</span><br><span>@@ -3990,11 +3978,7 @@</span><br><span>    =
         do</span><br><span>             {</span><br><span>                =
 man_standalone_event_loop(man, &amp;signal_received, 0);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                if (!signal_received)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    man_che=
ck_for_signals(&amp;signal_received);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                if (signal_received)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                if (signal_received || man_che=
ck_for_signals(&amp;signal_received))</span><br><span>                 {</s=
pan><br><span>                     break;</span><br><span>                 =
}</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2352?usp=3Demail">change 2352</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: op=
envpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div=
 style=3D"display:none"> Gerrit-Change-Id: Ibc58b9c3029ffea4f87093178cf52bb=
b46f6d837 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2352 </=
div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"d=
isplay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>

</body></html>
--gHwXPTlfezg=--


--===============6801062620295851278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6801062620295851278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6801062620295851278==--

