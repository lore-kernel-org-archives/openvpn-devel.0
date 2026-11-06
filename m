Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDC6606A326
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Yf0Y0hNu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=R9RxXN5Y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NpgjbL0t;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UUF9d+kV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=sBah6xu8SyeMKqWXu4TVLaP69fTFisKqJ1T3TegzSOs=; b=Yf0Y0hNu9ti2i71UTSdguJdWS9
	TytV8lrXtWwJzbuFCHtJi6E45WdaQ28F1ru4CycjEmqvVaSpHE1ncOzBsySo61AsbiL0eIApBI3hQ
	IhOohV37xa2yVbIvVUpGhiOaVH1N50Bio3sYngwpWuyIt6y5tH0quyyWyzrhiFO/G5LM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPFrk-000000002ul-0tin;
	Fri, 06 Nov 2026 09:04:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPFrM-000000002tG-2mvp
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 09:03:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R7BdvVGWBdmzS7nqM7NbeXHx/bQ669f47XgLbQtzbUA=; b=R9RxXN5YMq63R3QBC8JCs1QSiQ
 A76PBU5SHDwLhNhN9xsLwLMpgycMFkfuQ1AyGHbr6ptGoy3fzvDTnE9qkpgV24yFQATmSimAo3Dqz
 MhrHlWBzMmRlWlUuPXcyoilzpfZxTwTaSfbbT2aUB0hZWdv+hK11bdX6iTGq3jUqyeug=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R7BdvVGWBdmzS7nqM7NbeXHx/bQ669f47XgLbQtzbUA=; b=NpgjbL0trwVf63OA2F+lfN9pRn
 07SCQ3kGXg68C1l6W5uK4Vq6nelvzr8Yu9uoDZPhNYJSQnZcFVkGaUJo8jfxibvXhaH+EPp/NG11g
 uGYSGBFHyD9w/L3i6A6jzCxBkIr4agqPFwCQNFpreCC9nt9jhcbdcf/dZJWfInLLZioo=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPFrB-000000007XA-3j1M for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 09:03:44 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so250420f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 01:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793955807; x=1794560607; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=R7BdvVGWBdmzS7nqM7NbeXHx/bQ669f47XgLbQtzbUA=;
 b=UUF9d+kV0DmG5F00STPpLzYAfIbgS+jP/7VoOO7Q6FOMq2GU169buz/DlSFTAf+dxR
 9XrBHG+Ta0xTgI5laSTi/bN6RMgwKYdM06Qxz7xcNjjqZXiD5R8uvtSMFE91pPWwsoei
 /i3cx1a2T/IgXDmiGXqWB79lj79BoUWEalSu7OV/SkYGNvH6GvJz9tJK1HDAz38xWDiG
 4tLe1X6rZy4XAh44T2jxNZXTJ0KWftahnCcCLRZuQ15MzfucqW9cVnPVE4GEX/MpHOhD
 LefCnsZj9+QLORmDUPNaWBeZi74sVe+uRNevkgkTOP4PBoJBEqEBY3R/YoBpxwx57dej
 899g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793955807; x=1794560607;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R7BdvVGWBdmzS7nqM7NbeXHx/bQ669f47XgLbQtzbUA=;
 b=qX3Gw/2HRvsj1Rt2++lgsAFr7oEvRV4QzZN5mqK79rF92uu76mYyp8mqVaaRBpNYdq
 bJVxi1/RtV8Gs6i/CPhuyotyaViBYuk6RrYWaMC8e5w9+sqbU2t3LuIyLZ75pIBAiKME
 nTsMeXZi8/PXbJNum5ShilwJPA4+/0xby6LSDLiVHYZkzkCAYtnfX5qZi4hMABNIxrWM
 cPbvpECcn0PPJAs4s3HCfBsTt3U5f8+443ZPa+olwTVbYSHTYwJXCI5GjZJXB79gAnTF
 0uVRNQ6E8n5lJGWXNDRd5kdrtTrBSpsX/qyzaKirU2rkxtjJGTSiUitW2w84jp024UGl
 dhfA==
X-Gm-Message-State: APuU4Z8XV3UK8OJYOZplxA9xvBtk6pKIohMlzvxVXT8J/Ak6HDXvdhkh
 vb3vrq64uJlWo0uAajns8ql9mGasZFhPUg066GhO5kaTXK6yXxiU6CtXrtd07/TBvfjfVrpxPpj
 yHUqIaD5Hz+sKL+NlVEuce/ussk/ohuUsx7PyfFrZvzgmNPCiml+vdqT7ao5eL66fB3GdXoKoGp
 653fJD0w==
X-Gm-Gg: AYBFou2fwtHs5Hg9KsYtgAPxd7EuDoU2LmzxWH1h6aJmb81e/sA4JcrbVNE7FLa88mR
 10Y4574i5T9zQOjGJvYJA6MiJ1Z1e/2+meMQpyErQkUSMqgU9ngfNuANTscWh0GVDx0Dz134BtV
 OGpvseV9Mv9rouTn7/VKfqtYTe0fJgeZPnJL8QH0/jRMfzf98e5xxgIFm4/zicHwTgOj9VTcwqG
 z9x0j9Aasw9IcoBoct6OoN72a3Z/cYsPNyYSKW28nYDyYhWPaqr1vas9uXW0k7I82W9Nu2hoh5L
 OtJ1C9z4IF3kKMGplNw3Qjb04bF+oubne6kA1GEe1fcf+JTWGsdGQjwWA6tLEdyV6+nAxab7VTQ
 Z+MSn8wtFk1tkSQSa5RN0YFo0V0YhLihktYAL1GP1pErvxcYronknjUyRlIvVy6UYkBFeTV/B2U
 9LuhPK5gHpy8x5CXTgWR/NWocyhqHqU6pm6H471PXVOn0ND35S6pKgXkVeUN5uYR2Kj9GuLwrIg
 2KWqZKGZrNqYfuz4qXH7nsPTLzsWMt4OZ3aS2xrPu1wrwBMrhSOk8jAZS/3dV3apMlat9UMROs6
 0KK3H8JEpX8NcaXfvG8KE/uFuQUp68cF/UZpfMWrxkQtWbHWl/a18nVGBVmr0g4xNuNnPBRIUm+
 YmmjruvR+7YGMLOYfj66EGqkaVEiUwaDioGO1O2EHxzp1qvTBhO7bJXLQ36P/WvmAGb/a+GFzsz
 sgT/t7iqB17qTywQ==
X-Received: by 2002:a05:6000:240a:b0:493:1004:96f7 with SMTP id
 ffacd0b85a97d-49310049976mr1639869f8f.54.1793955807121; 
 Fri, 06 Nov 2026 01:03:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4932901d9c9sm1466417f8f.59.2026.11.06.01.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:03:26 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 09:03:25 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib7b9f2994ca828ea699bc6e5b08193dd30965926
X-Gerrit-Change-Number: 2144
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2144?usp=email>
X-Gerrit-Commit: 746f40f2de8f58b38c0c5ea1793a26013cc3081e
References: <gerrit.1793955802000.Ib7b9f2994ca828ea699bc6e5b08193dd30965926@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTU1ODAyMDAwLkliN2I5ZjI5OTRjYTgyOGVhNjk5YmM2ZTViMDgxOTNkZDMwOTY1OTI2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c503a8d279889de5219ad0f737d21e86cd01915d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPFrB-000000007XA-3j1M
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: close
 the NRPT base key in HandleDNSConfigNrptMessage()
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
Content-Type: multipart/mixed; boundary="===============5838545392993004451=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5838545392993004451==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/RcOeqEeSl4="; charset=UTF-8

--/RcOeqEeSl4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2144?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: close the NRPT base key in HandleDNSConfigNr=
ptMessage()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
penvpnserv: close the NRPT base key in HandleDNSConfigNrptMessage()

The ke=
y opened by OpenNrptBaseKey() was never closed, leaking a
registry handle o=
n every NRPT add message=2E Close it at the common
exit, and return directl=
y if opening fails, as the key is not set
then=2E

Broken since 0f3b7d17 ("=
win: implement --dns option support with
NRPT")=2E

Change-Id: Ib7b9f2994ca=
828ea699bc6e5b08193dd30965926
Signed-off-by: Razvan Cojocaru <razvanc@mailb=
ox=2Eorg>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 2 insertion=
s(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/44/2144/1

diff --git a/src/openvpnserv/interactive=2Ec b/sr=
c/openvpnserv/interactive=2Ec
index 6a83bac=2E=2E81205d6 100644
--- a/src/o=
penvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -3014,7=
 +3014,7 @@
     LSTATUS err =3D OpenNrptBaseKey(&key, &gpol_nrpt);
     if=
 (err)
     {
-        goto out;
+        return err;
     }
 
     /* Add =
undo information first in case there's no heap left */
@@ -3065,6 +3065,7 @=
@
     ApplyDnsSettings(gpol_nrpt || gpol_list);
 
 out:
+    RegCloseKey(k=
ey);
     return err;
 }
 

-- 
To view, visit https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2144?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: Ib7b9f2994ca828ea699bc6e5b08193dd30965926
Gerrit-Change-Number: 2=
144
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--/RcOeqEeSl4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2144?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">openvpnserv: close the NRPT base key in HandleDNSConfig=
NrptMessage()<br><br>The key opened by OpenNrptBaseKey() was never closed, =
leaking a<br>registry handle on every NRPT add message=2E Close it at the c=
ommon<br>exit, and return directly if opening fails, as the key is not set<=
br>then=2E<br><br>Broken since 0f3b7d17 (&quot;win: implement --dns option =
support with<br>NRPT&quot;)=2E<br><br>Change-Id: Ib7b9f2994ca828ea699bc6e5b=
08193dd30965926<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 2 inser=
tions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/44/2144/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><s=
pan>index 6a83bac=2E=2E81205d6 100644</span><br><span>--- a/src/openvpnserv=
/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</spa=
n><br><span>@@ -3014,7 +3014,7 @@</span><br><span>     LSTATUS err =3D Open=
NrptBaseKey(&amp;key, &amp;gpol_nrpt);</span><br><span>     if (err)</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return err;</span><br><span>     }</span><br><span> </span><br><span>     =
/* Add undo information first in case there&#39;s no heap left */</span><br=
><span>@@ -3065,6 +3065,7 @@</span><br><span>     ApplyDnsSettings(gpol_nrp=
t || gpol_list);</span><br><span> </span><br><span> out:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    RegCloseKey(key);</span><br><span>=
     return err;</span><br><span> }</span><br></pre><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2144?usp=3Demail">change 2=
144</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2144?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ib7b9f2994ca828ea699bc6e5b08193dd30965926 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2144 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--/RcOeqEeSl4=--


--===============5838545392993004451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5838545392993004451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5838545392993004451==--

