Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3152260A3807
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XB6tZ3uc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=f6pEb/JH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ch6VHoF/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MUN8ld+q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=PFehEVlAB+6+0xA/kn9b54kjoQrlq49HcX+auxFiZ5M=; b=XB6tZ3ucxpnCuGHQpX+IPlwda8
	C04gtGZDFwbPRC4RKprYy5CoKLCqMsH52piGcGkc+KUN5GZzjgk0o3ykUj6Z45RF0lhKMYMJye7LI
	PpiyyI6sQYCipHhVMOTbn/WCiuOsGNmamUY4w3DjrA5uqfX3+6SyIi2WUnNOiV6n5SMw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrgf-000000005iR-2RzN;
	Mon, 02 Nov 2026 13:02:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNrge-000000005iI-17BM
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:02:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VzHSYEGis6QSqyvwmLgT/UE5zaRffcL9W1yhgsrGMu4=; b=f6pEb/JHl7623orC5Kl3fn1r5r
 kRWf83BrsnP225eL1D2teLInG7dFOIsGlG95jv367F4oydVYiYpmD0oDLeQq4Mg3BzhPgxGeLzlpL
 2KzPvirpEpomCIXB0tQQLl+ClFnpQEybgti0Z9rGbb76xJxL7UwdyXS2cEVEklxsX09I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VzHSYEGis6QSqyvwmLgT/UE5zaRffcL9W1yhgsrGMu4=; b=ch6VHoF/hkGkuRnuRGJXr5BruH
 Ox0C572E5PnLydpixsKKxdjiruseXzLsT0WYAhpm6+FKpwW52PNfPoZlfFdt2VBJXgLz65i/HY8Bs
 oKVwxbE6/3HH8X4f1L4YjLGs+J/5pfz8x1/mzMfs0EzbiD5AVz0jRqYgOWwpr1ezu4rw=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNrgd-000000007kZ-2Ut1 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:02:56 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so2838032f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 05:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793624569; x=1794229369; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VzHSYEGis6QSqyvwmLgT/UE5zaRffcL9W1yhgsrGMu4=;
 b=MUN8ld+qMvAYFVbIA9lZ6d+SXTRvWvI565EF3gLvQHSitTOPuXsCWmXZ/G3Fsf5sl2
 K5pXm0nbo9JTMhc/isVkzx9alnBkbF7Mdf9Rxm7FMcChPWo7CNoD8LlZtRQHR9cf1PQG
 CDiQmuXDiQQSmRUo7741sQUWvUYUxkKquMpVZhJhwHnQTAkCP473m45qJCP0h9doN4ll
 wR/1xAYeXj00Z4Ek96A2p9Oa+Hn143yEYQClZbt97e/90WE6Xvip+DduMWtOBMAmyOiR
 7USP6Azqs4MFx/XDUMwuLrCxmPitq/Ohjb4InkMm1kV9RuMulaaJOJlVUTQs8CBZEMb3
 Uh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793624569; x=1794229369;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VzHSYEGis6QSqyvwmLgT/UE5zaRffcL9W1yhgsrGMu4=;
 b=IK3ml4rb6txeAfPFVdgxm7bOA53hM9LBa+96hN3d1pcyIZc1IOT+T4YUadl3hLloq/
 XqYk32xe8p2NusNmwwWSVhUWvovnsSE24lkDuDAoSlzQSsXaMJYVSZubkFI4l7Khhm4/
 B60Da+IJIVMBf7zz6lQpndMjMXwbbHbzghasN7Blyem2w8VJF/qbAivCPLHPwBbnvkoN
 7aXuWD6u0Z7zEIcFcldLGXjNbB4FstDSw2KPJbwPrkwenmluMQCgLdtvnfc7f05MPgcL
 DMzknpUK23JO1OKy0E9nC+VMkI1LlPV7dTjKAweutOB2jJo8sR+rIJPLQWrMfOEX4GF3
 K6mg==
X-Gm-Message-State: AFq9FYLZ3Qg8JvvXSDShaJF8pdowZ+lRWjvJWTJ0eKfzjlZE7wHroXKf
 YUHbfgszkLUYw7BIycyLqwrltoQWXBFboXpKuRO6eCpfqEvol21l/FDspp+kJdsW3sB0h3kMDkK
 nDjLZ/WBG+aO2Cw91MHdPihOa/3HVmrqnOSaJRr6Hl5U6f0IOSBl+kiOhdZpDPRfDxHVmHaScyL
 3YUoVX9Q==
X-Gm-Gg: AYBFou39eoDtgZdosLq5M7bmU1h4H0zVI6qM0svlUpdKjVsyr2+FZQz5LE6v2s0YyO9
 ZupXs/eIp6FHdLS7xgsgr1IO6Ul/EuZKuY1j/XtVQ/1iEbvVvuWA9woIFs/Z8GFxw37sgPsHUhS
 EqOocL83rqcM21VLolNZA1AgWAsNfihe4cCV6X5xmE2FjFLPPpRdV6VZzDwTdziVfSSJi0qwRnp
 6UefWjUrn1Ys0St2JUhYyo5kWSiuZ6lcTFXwHW0/rPGIb7RSgFcZE1vY3AJjt3bjy2BiYsHj44r
 cxURYZiFeiYQ6RhV/3TBXe8YVFwr2m6vliJt4PrGqHm1NgyBRyWQjZvb6ut1DH5lTI2sF6O6EgJ
 3ZJnnoKHqXg3f7L9Y+x2nd94n4qWA0+HHfuKIEvt9xQNUk9nzHFXkzIbE9p9jTSDFXUhW/4FqoI
 Suq7gYBWTrxOlON0O8v3VPXZjFADx4YV75gaAuy8B9PvfPeT5ZBUjnryh1TTUPAytFNc48FXrp6
 vmpBtbXrSwWqDC9MPRNkDo/eQmAI3dZCR5BKUiJpCMNqDNtLQv+L5HeTMppKZ7V7LSUrH21go9d
 PhC+b3AS5jbg131djxRUuyB8qwTwUYu8eXp52Vmz3dZ4sfYHgAsCuRH/96yxdcbW+uWWZaUusj3
 Rn1MmBEaQqGqcz17EfcS9UZ2V3xZegA45495bTREjvpeWIp6XhQVc9LVVrCU97nubSBR1F1NeoF
 seGlnX+Jzpe39Tig==
X-Received: by 2002:a05:600c:34d1:b0:4a0:b6:4619 with SMTP id
 5b1f17b1804b1-4ac12475a61mr229270645e9.0.1793624568704; 
 Mon, 02 Nov 2026 05:02:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm21679081f8f.55.2026.11.02.05.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:02:47 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 13:02:46 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I97a14086258c08b47e37f07f103460a9d0bb9afd
X-Gerrit-Change-Number: 2090
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2090?usp=email>
X-Gerrit-Commit: eec244bae4925c82dc5d684144b27141225a83a0
References: <gerrit.1793624563000.I97a14086258c08b47e37f07f103460a9d0bb9afd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjI0NTYzMDAwLkk5N2ExNDA4NjI1OGMwOGI0N2UzN2YwN2YxMDM0NjBhOWQwYmI5YWZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <22c1a31b11720dda7a913a33fa2a2950f9a49156-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNrgd-000000007kZ-2Ut1
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: fix
 inverted inet_ntop() check in GetItfDnsServersV6()
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
Content-Type: multipart/mixed; boundary="===============5518907590282354948=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5518907590282354948==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zDNuFiuGS7M="; charset=UTF-8

--zDNuFiuGS7M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2090?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: fix inverted inet_ntop() check in GetItfDnsS=
erversV6()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
penvpnserv: fix inverted inet_ntop() check in GetItfDnsServersV6()

inet_nt=
op() returns NULL on failure, but the check treated success as
an error, so=
 DHCPv6 DNS servers were never returned=2E

Broken since 0f3b7d17 ("win: im=
plement --dns option support with
NRPT")=2E

Change-Id: I97a14086258c08b47e=
37f07f103460a9d0bb9afd
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eor=
g>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 1 insertion(+), 1 =
deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/90/2090/1

diff --git a/src/openvpnserv/interactive=2Ec b/src/openvp=
nserv/interactive=2Ec
index e2f17f0=2E=2E484f27c 100644
--- a/src/openvpnse=
rv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -2217,7 +2217,7=
 @@
                 s--;
             }
 
-            if (inet_ntop(AF_IN=
ET6, &in_addrs[i], pos, s) !=3D NULL)
+            if (inet_ntop(AF_INET6, =
&in_addrs[i], pos, s) =3D=3D NULL)
             {
                 *size =
=3D 0;
                 return ERROR_MORE_DATA;

-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2090?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I97a14086258c08b47e37f07f103460a9d0bb9afd
Ge=
rrit-Change-Number: 2090
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--zDNuFiuGS7M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2090?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">openvpnserv: fix inverted inet_ntop() check in GetItfDn=
sServersV6()<br><br>inet_ntop() returns NULL on failure, but the check trea=
ted success as<br>an error, so DHCPv6 DNS servers were never returned=2E<br=
><br>Broken since 0f3b7d17 (&quot;win: implement --dns option support with<=
br>NRPT&quot;)=2E<br><br>Change-Id: I97a14086258c08b47e37f07f103460a9d0bb9a=
fd<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<b=
r>M src/openvpnserv/interactive=2Ec<br>1 file changed, 1 insertion(+), 1 de=
letion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/90/2090/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/i=
nteractive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index e2f1=
7f0=2E=2E484f27c 100644</span><br><span>--- a/src/openvpnserv/interactive=
=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>=
@@ -2217,7 +2217,7 @@</span><br><span>                 s--;</span><br><span=
>             }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            if (inet_ntop(AF_INET6, &amp;in_addrs[i], pos, s) !=
=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (inet_ntop(AF_INET6, &amp;in_addrs[i], pos, s) =3D=3D NULL)</span><br>=
<span>             {</span><br><span>                 *size =3D 0;</span><b=
r><span>                 return ERROR_MORE_DATA;</span><br></pre><p>To view=
, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2090?usp=3Dem=
ail">change 2090</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2090?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I97a14086258c08b47e37f07f103460a9d0bb9afd </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2090 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</b=
ody></html>
--zDNuFiuGS7M=--


--===============5518907590282354948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5518907590282354948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5518907590282354948==--

