Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8BB606EEB4
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MDYXZNrO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BkxdlKG8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NrQwS5xP;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cikhpt27
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uSq1vVKXcOyp8k2m3sxW+vvqkxznUqvSCbrMWvu22no=; b=MDYXZNrOpCmCrX/ljfPVOpTpqX
	30I/8ZqSvkp7fNeYdXDkmCetGpyBjD/b+XDMSlEbsk1r/Rqq9egx5O3YxR50S/BFx6JgupOkF39Jr
	UV2dzgmqdVYfaSXU/v7ucak/VhA847ZfPXsnlQBpOoTCsb0xJ7sBJf4jtqHwNd/uXiBw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQKtF-000000007J6-4235;
	Mon, 09 Nov 2026 08:38:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQKt6-000000007Il-10KU
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 08:38:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nj77FNEGwkE04iGsZmgJpDsMmQTQPWGBpqcYunZ5G9I=; b=BkxdlKG84fkTWW74PXdIQ2JWac
 OJzkCHky7CzhW28dCbNCbUAoxL8FB6PS6L4tdU+x6nrBBIO5Q8yGA0SGRpi6HkUSKCSjOxN8bMbzz
 hu8K8BYWfdg7Ot7VvYWObrQeJlXUT3iC/l7e0udI7k7ODD8TFHMvfSLraENjWa5L7XUA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nj77FNEGwkE04iGsZmgJpDsMmQTQPWGBpqcYunZ5G9I=; b=NrQwS5xPL9p5bIjPQewABpCRcx
 WMeqUVOjad1cTBXHm80sG4Otm+cqBMSyGX7gOVkYFPt9ICAMEwIwq/7WtqQo/WrXdvd9HaTagJ6t2
 3eUuotVkZ3av6/rzYwmZ3SLs30Kd0F3L9WGBwECgHlpjkTkJlRgw5E3bekOqbpBmhOWc=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQKt5-000000008Am-2WGs for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 08:38:00 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so8864385e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 00:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794213473; x=1794818273; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nj77FNEGwkE04iGsZmgJpDsMmQTQPWGBpqcYunZ5G9I=;
 b=cikhpt27k2FTd8qAVG65W9DhoUTmxe2XgsZoR76L5cPLdn2rGAAvwdub3u3JYNFEN0
 w3KQ2FFtPXKxhzCHPWhfHf1JX7R2qyLsgE6rzAoQWzrkzvN8ERK7q5C67BFHNy4IVDdk
 VRLJ6viKNktEFF2Cax4EiO89fDG5C+fdcWcQPyA2ipkiRw8sDnTCG54I9PHd8ZOyxz9m
 5Km9kh3qKaH6LKpaJXnPnWsOUt+Ig/lkVFGenQakbV7d5/HcQ70kMdE7mlzK/Ifbjpxr
 31ZPEgoUU/y43kkBvsLqvod3aZug1bwjbG1Pqvusg/ZYkR7dnb50QTSNtgq+Rx12TnuX
 b0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794213473; x=1794818273;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Nj77FNEGwkE04iGsZmgJpDsMmQTQPWGBpqcYunZ5G9I=;
 b=ukH4xQLKa4NejanGIX8i+0t7XAJRF8ocIeIBhoL5RpR/JNxK7SdlRNHGXuS/3Y51jv
 //dsrmBsQxOrXI2YCLxZEYIV5aVixsM3VoSjFtti5Pdwdw86CimCbfsdiwTr14YfL5N9
 AklCfFPeIlvwHf2aJ1bgj6lTHm494T6zOMmt6WA1+W7kf4c86RDGnyrXtMscfhJNChQq
 55+EAVdqJTWQ/bNbKk5IxhJbpe3jEBGOjgd0merCGWaWw7yG1UDb5nWTh1RFED+EgjEr
 a27EeIVRtmsUi6OL/o87XvxKT4KbAE12qAuDIiN6rbM34j37hmszDdC5yQNCgK3KBLE8
 f0JA==
X-Gm-Message-State: APuU4Z/AApXUd/pUX9FWDIEsFODh/Kx1Y2BwyaFRYpBnSK8b6Jkee+Gd
 LTmxypFk5W6ieDam0vz5tnGWfcI+2DL3nwBkYizfmQ7BsOjcdqNc4UrJvxt4dWhBSynqpLtpdZY
 jTvPqwiEiQ3UMNY6s72eqYvYWR9POYA5aCGpcY5Hl3kvnXyoYd2Gcd/SVDNOH19AGyAJZ
X-Gm-Gg: AYBFou22eimToe2pwB0L8RPi6j7wVZz8i/YkDEhmn8Ig3RxsHKjlZ/bjtmKfFiFdAKi
 oW6096Lxd1RJn3DuDQVsgSGpSfdqC2rcM+bqo3jUh4tZqeYcqaK8OOTOFzEo0+XVqwcBw4w3dJe
 cCeAu8QWkDOX28drr8OkAWLOHjpEo9So5Oce2Wlwl8FMo9IOvNFavJ+Gf32KiQgKlTfDhpeoPT2
 P8mZZNPr65zdRZn4bvM+rXIZVoNAhX4ggqBZrdDHjSdGL33S/JPrOmXGTZ+AwrzfScLaCKSJGle
 UfYFYWpEdGZA4Oh+6npHY1xCk90fTJe6RwYDH+1ay2Wt2dRYtG6SiiJmaCimHmMVRMR3UgQaVU/
 /yBMfQXjUKiiIMOYYO7qMHPJcVYB69Nd+gAi6UsE/3ZcxMxMjd5b12PguTYrENBc3WIroNtGTTb
 lnHiOmDMRMnEKdvh+Oj8xRCttR5thZbR6iL1xfYS4VpyDdYTNe94fYb6JO3J0ZLNDLOrp52rN/v
 jmdvgT4AERwoi0x+cuop7FIeZSyyvt4bUYI5dQPa09zYoRxENlWLz+LPrtBmih7f4HISYyK/iIm
 ayH4XR2iPatUnX9Wym2S/qWWAPx+nYvM6TSNSbKYH/ZT6TgiOgkU3CtMKd1DXW/tSVy3OPz0tci
 tWgz0aJCKpUf2xEgamJPm8w7adal1vfnWnvgSIWGjnBIo3S8IEDCQqgpSiofRjnXEugz4Y1Gdsy
 iMFOVySa3yQP1g9SJpVHzKCToR5lfRAeeDlCI=
X-Received: by 2002:a05:600c:6095:b0:4a2:150f:1601 with SMTP id
 5b1f17b1804b1-4b960da5640mr60928985e9.12.1794213472884; 
 Mon, 09 Nov 2026 00:37:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76cbe9e31sm179187745e9.2.2026.11.09.00.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 00:37:52 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 08:37:48 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ied9e36d45b30a88610cafee668ecefa98b29eddc
X-Gerrit-Change-Number: 2146
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2146?usp=email>
X-Gerrit-Commit: 9067f9bb8aaf22415cd231537f59353095b8143b
In-Reply-To: <gerrit.1793970201000.Ied9e36d45b30a88610cafee668ecefa98b29eddc@gerrit.openvpn.net>
References: <gerrit.1793970201000.Ied9e36d45b30a88610cafee668ecefa98b29eddc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTcwMjAxMDAwLkllZDllMzZkNDViMzBhODg2MTBjYWZlZTY2OGVjZWZhOThiMjllZGRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2f5557646bc320f00983cbe9f92ad05ccdeb185b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQKt5-000000008Am-2WGs
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: reflect_filter:
 initialise warning_displayed in the rate limiter
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0824414757889468833=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0824414757889468833==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JLVB8LBuBhA="; charset=UTF-8

--JLVB8LBuBhA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2146?usp=3Demail

to look at the new patch set (#=
2)=2E

The following approvals got outdated and were removed:
Code-Review-1=
 by Arne Schwabe


Change subject: reflect_filter: initialise warning_displ=
ayed in the rate limiter
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

reflect_filter: initialise warning_displayed in the rate limi=
ter

initial_rate_limit_init() allocates with ALLOC_OBJ, which does not
cle=
ar, and assigns every field but warning_displayed=2E The first period
reset=
 assigns it before anything reads it, so nothing misbehaves today,
but ther=
e is no reason to leave a field undefined=2E

Change-Id: Ied9e36d45b30a8861=
0cafee668ecefa98b29eddc
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---=

M src/openvpn/reflect_filter=2Ec
1 file changed, 1 insertion(+), 0 deletio=
ns(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
46/2146/2

diff --git a/src/openvpn/reflect_filter=2Ec b/src/openvpn/reflec=
t_filter=2Ec
index e5226e4=2E=2E953fff5 100644
--- a/src/openvpn/reflect_fi=
lter=2Ec
+++ b/src/openvpn/reflect_filter=2Ec
@@ -95,6 +95,7 @@
     irl->p=
eriod_length =3D period_length;
     irl->curr_period_counter =3D 0;
     i=
rl->last_period_reset =3D 0;
+    irl->warning_displayed =3D false;
 
     =
return irl;
 }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2146?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
Ied9e36d45b30a88610cafee668ecefa98b29eddc
Gerrit-Change-Number: 2146
Gerrit=
-PatchSet: 2
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Revi=
ewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>

--JLVB8LBuBhA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Lev Stipakov <strong>uploaded=
 patch set #2</strong> to this change=2E</p><p><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2146?usp=3Demail">View Change</a></p><p>The follo=
wing approvals got outdated and were removed:
Code-Review-1 by Arne Schwabe=
</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">reflect_filter: initialise warning_displayed in the rate =
limiter<br><br>initial_rate_limit_init() allocates with ALLOC_OBJ, which do=
es not<br>clear, and assigns every field but warning_displayed=2E The first=
 period<br>reset assigns it before anything reads it, so nothing misbehaves=
 today,<br>but there is no reason to leave a field undefined=2E<br><br>Chan=
ge-Id: Ied9e36d45b30a88610cafee668ecefa98b29eddc<br>Signed-off-by: Lev Stip=
akov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/reflect_filter=2Ec<b=
r>1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/46/2146/2=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/reflect_filter=2Ec b/src/openvpn/reflect_=
filter=2Ec</span><br><span>index e5226e4=2E=2E953fff5 100644</span><br><spa=
n>--- a/src/openvpn/reflect_filter=2Ec</span><br><span>+++ b/src/openvpn/re=
flect_filter=2Ec</span><br><span>@@ -95,6 +95,7 @@</span><br><span>     irl=
-&gt;period_length =3D period_length;</span><br><span>     irl-&gt;curr_per=
iod_counter =3D 0;</span><br><span>     irl-&gt;last_period_reset =3D 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    irl-&gt;warning_di=
splayed =3D false;</span><br><span> </span><br><span>     return irl;</span=
><br><span> }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2146?usp=3Demail">change 2146</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ied9e36d45b30a88=
610cafee668ecefa98b29eddc </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2146 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>

</body></html>
--JLVB8LBuBhA=--


--===============0824414757889468833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0824414757889468833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0824414757889468833==--

