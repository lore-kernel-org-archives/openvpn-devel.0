Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C2606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CesKXyeF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=V1TNqUa3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lxMMMBDo;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UOk+ifYs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=E4VvjMgJ3W/8P90oMlbo/FReMTDBsTGEJmKTVc/d+48=; b=CesKXyeFOPLz/r1rAFzL13prkc
	spLBG+MWOwfccDhO851MW7xZXxXAC0pQYbgWQKiE9OR26wWXXtDrrT8CBKk63ibjBa67N4YAyvIRx
	ZjW6Y7F7N5xCw0+DvM6cgN+lbAu3MN2i8J+hHAw9J/yQkjUxKHI396MSRat6HoLNgjWQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVE0y-000000006gF-3S7E;
	Sun, 22 Nov 2026 20:18:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVE0e-000000006fg-0rDI
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 20:18:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fEJuxbrxr26pbzRYy0XDCg0Cg81Je6YTtZvtwMX+Svg=; b=V1TNqUa3YC3ILCBUn77/4PL9XK
 +btRSkBA4Ua96EM6oC0PW0j0LL6StQq61tBllzuxz0DuWgQ4NGL23UmlDXvdapaEpTsQawx5V2Dif
 mMC5OEDQ8IVCoTexLoIwYfi7ixwG+I+/OY4xMvUVB8oFs8sOQDsF23/GhtAi1zBYz9jY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fEJuxbrxr26pbzRYy0XDCg0Cg81Je6YTtZvtwMX+Svg=; b=lxMMMBDo9RxjT4iTQC681DRUu8
 ENn3PhXBX6CuI5Dpcxzbgd+JGJQkf/RpaqwYCGDq1+yc93SLQsfG+d1HvLoyRHCRCeTKGZjwHZy4C
 hSY9bICBqMgHGIFcBFYkSWwOSuJSHihQOwKy+25Z/9f3vnw0qoRxsfXlso2+8tc5vxMU=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVE0U-000000007gm-445i for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 20:17:51 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so25148615e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 22 Nov 2026 12:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795378664; x=1795983464; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fEJuxbrxr26pbzRYy0XDCg0Cg81Je6YTtZvtwMX+Svg=;
 b=UOk+ifYsMrUe+HiGwg86Zt4+Vx2OI8GCSz5YKuphgzecIcG3Nt56FW5x+86SqTJR35
 sQUrn4iUknboNIukMkT0k5+sng7O29udK/P9Rs9qR8ViL2woDxhtRs45nG5+rwo5uDVZ
 /QlwG601LSGf+OUtMR3GCTTbWhwaANwkspShh+8C3/MOUR08X+v12K9fGUW4sO279Wbn
 IPFgBG3u/+2I3w1A+ObfHD9glKhSD3BPDJZgLWKcYS2y5VhyASOoUoq/++FYZLoKzBWL
 giSNonqeAfAI3CZIL7veT+hbckwEwTht/t1gIato6JQbWq9SDcrjF/0KL2k4JfkHg50E
 WtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795378664; x=1795983464;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fEJuxbrxr26pbzRYy0XDCg0Cg81Je6YTtZvtwMX+Svg=;
 b=hAHyyWvUsU/pZ74hoRTJrcUPaInbi85obx7wCPWF8Iri4DX/fi8G4dwj+f778tgXFU
 GxkBAVsjvsElx2PckD5inf+EEHpZLqYZtie4MDKSY+lD8SCSw7z1DIYf5pqfi9qmaj/a
 bYPxucdwRsNhWqT3O4aZVOieM+nwPZqNuWCN8DkL6c3PGjryNHtd8Gxz64Am+1tBBO+0
 Fz0AUbrgju3hkeQLjFuw02Bfe9gZw8Cc1rhedoki3oXwCZuoyTDu6RjJ5S+RPzVPtKsV
 WG2+N1RR164JIevfSZA3OSElANE2WJXQeIySAcvKyY9oFZAd6+BjKF7AC43HcFA9I406
 ixOg==
X-Gm-Message-State: APuU4Z9GZncPufTKNDil4aySa3m5vE/52/CbcdnRRe9XALvWas2BDVcH
 mTeuz20gYrOtm2TxV9eb018KSDXwHuxZ7W0WHyTHXBxr3gRgOKSTDN1V5oW8vvZAViM7KQHp0U8
 ynj6pWoT+68kyPnzNhdDFKDvie7y4K9gNNWEbf0pAJXlvRgPY/gqF3/NHC7jd/Gq9RdsAZQfBBE
 KRkKIjEg==
X-Gm-Gg: AZFdTZdXgHwbPto3IoyofBqn0P1Kc58+ChbWlKVtge+ee4bBDIoQreVeIbdnTKriO6F
 WOm0UwAardgvgvgtXLVlpUhnBTGMvB6W4YYmpHygRk3uzDZZIz0KHiwrptkeP2bns3A/mfIEx+I
 QUNvCaMz9HDayRFYIQHD8CXmOZrmlpwU5XhdRmBw/4DFnUv8YYNJFYubGUSkbZrbLWAi1YzyyN5
 aTve4T8OyNUzyXjwb5myVmj51LSzHig1mpIQ44Yvn4d39BKhFR9H+caOVoDRaFdNhq3pZMk5sLx
 JYQCGzqVz+M5tcGBXPQYOYxnjg6A6YPQQOhplmZ+8BykFcRlq1DAQubju4WKjtYNQUE4t5g5a5r
 5z2Ih8zJNlBibLpxjvmdE9Hf/OFYKovrsSRWX+Bl7t1pT7LTTFhJp89rT6raB2eqSM14GQihSjo
 FCId0y52j74e2z65Z7uaj+XpXqtXWrrED2cSGhiSSOBI5/j/6BAS5G85VZZOsOemans3lgspNTW
 G+ro4UG0WWHP85tSmpypwSmC/a7ndT+wXCGWgk/KE5hc1fWkTM2nUdEAcEneovfzwkc0rKAjhUW
 LuGkGONfxO2VEKNeCjOBjWQ8zp95Z0lky/JiAOeJZl5Gd4JQrXBdVNVJG7GJM0UwcN50SCoqTSZ
 Jq07LyeYs3dTIEsScfHpDRdiWcafTlUvrFObicWY5N3WNheM3d9TQBF/dt5VTEq5nSEqljWlhOa
 UHzCX2qgmlfuRI1Iwf9LGXl24NhEip2g7zeghm
X-Received: by 2002:a05:600c:6219:b0:4a1:d087:f6ab with SMTP id
 5b1f17b1804b1-4bb8880badfmr191406615e9.18.1795378664268; 
 Sun, 22 Nov 2026 12:17:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849247asm285446175e9.7.2026.11.22.12.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 12:17:44 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 20:17:43 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id142eda108dd4385dcdc263a4842aeb314a12f41
X-Gerrit-Change-Number: 2239
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2239?usp=email>
X-Gerrit-Commit: e95844217da65b3cc1cd464b09ac5a0ae55c01db
References: <gerrit.1795378662000.Id142eda108dd4385dcdc263a4842aeb314a12f41@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Mzc4NjYyMDAwLklkMTQyZWRhMTA4ZGQ0Mzg1ZGNkYzI2M2E0ODQyYWViMzE0YTEyZjQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f01291fa9509008ddfb7cbb008fa49700ddc2b56-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVE0U-000000007gm-445i
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: don't log key
 generation failure twice
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
Content-Type: multipart/mixed; boundary="===============5614248767537455730=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5614248767537455730==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T5TzgB6Ycuo="; charset=UTF-8

--T5TzgB6Ycuo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2239?usp=3Demail

to review the following change=2E
=


Change subject: ssl: don't log key generation failure twice
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl: don't log key genera=
tion failure twice

tls_session_generate_data_channel_keys() already logs
"=
generate_key_expansion failed"; tls_multi_process() repeated it=2E

Change-=
Id: Id142eda108dd4385dcdc263a4842aeb314a12f41
Signed-off-by: Razvan Cojocar=
u <razvanc@mailbox=2Eorg>
---
M src/openvpn/ssl=2Ec
1 file changed, 0 inser=
tions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/39/2239/1

diff --git a/src/openvpn/ssl=2Ec b/src/openvp=
n/ssl=2Ec
index d5ae13d=2E=2Eeb6b86f 100644
--- a/src/openvpn/ssl=2Ec
+++ b=
/src/openvpn/ssl=2Ec
@@ -3504,7 +3504,6 @@
             enum key_gen_status=
 status =3D tls_session_generate_data_channel_keys(multi, session);
       =
      if (status !=3D KEY_GEN_OK)
             {
-                msg(D_TLS=
_ERRORS, "TLS Error: generate_key_expansion failed");
                 ks->=
authenticated =3D KS_AUTH_FALSE;
                 key_state_ssl_shutdown(&k=
s->ks_ssl);
                 ks->state =3D S_ERROR_PRE;

-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2239?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: Id142eda108dd4385dcdc263a4842aeb314a=
12f41
Gerrit-Change-Number: 2239
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--T5TzgB6Ycuo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2239?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">ssl: don&#39;t log key generation failure twice<br><br>=
tls_session_generate_data_channel_keys() already logs<br>&quot;generate_key=
_expansion failed&quot;; tls_multi_process() repeated it=2E<br><br>Change-I=
d: Id142eda108dd4385dcdc263a4842aeb314a12f41<br>Signed-off-by: Razvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file=
 changed, 0 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/39/2239/1</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>ind=
ex d5ae13d=2E=2Eeb6b86f 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</s=
pan><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3504,7 +3504,6 =
@@</span><br><span>             enum key_gen_status status =3D tls_session_=
generate_data_channel_keys(multi, session);</span><br><span>             if=
 (status !=3D KEY_GEN_OK)</span><br><span>             {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                msg(D_TLS_ERRORS, &quot;=
TLS Error: generate_key_expansion failed&quot;);</span><br><span>          =
       ks-&gt;authenticated =3D KS_AUTH_FALSE;</span><br><span>            =
     key_state_ssl_shutdown(&amp;ks-&gt;ks_ssl);</span><br><span>          =
       ks-&gt;state =3D S_ERROR_PRE;</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2239?usp=3Demail">change =
2239</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2239?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Id142eda108dd4385dcdc263a4842aeb314a12f41 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2239 </div>
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
--T5TzgB6Ycuo=--


--===============5614248767537455730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5614248767537455730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5614248767537455730==--

