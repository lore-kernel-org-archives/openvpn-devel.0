Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18245606A880
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Au3R8D/Z;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nUZgj1de;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bqD1HwpL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Iy55dKMt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=db7bQFCdf3uGdyrm5G2Q8Ib6AYIo+Pr1lIabpQw10SE=; b=Au3R8D/ZOqNx0U8YIKMIztzWr6
	pzsWLWo5OSgZcL/vIQq3DBJ7/771g7OYKvn2grLk4witWUyrkynifyc6oWbJnZirIinyHhm4j734f
	dyDh+WMMFLd5lGnqvPP+2cT0wTWE3D3rXJUyG0Us4jqRC+vj1MhlvBiXmN2xdaZ71Y3E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNq95-000000001Gv-0YWJ;
	Mon, 02 Nov 2026 11:24:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNq93-000000001Gp-2l0V
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:24:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6QfpEul9aYEl/KMNkbqQ1AORqE3JnYFkI0331bngQYA=; b=nUZgj1deWRSkFHtCqBO1gjjeoG
 skemlWsIUjlya+bYSC8mWqFJ466xF9Z9G+PrGCLuGQC5k8iRhEE7Wg+nRo94RDVkHbZXySipOC20I
 xsRXpwj8Aqn64SLeHFU+6hQgJhqe8JjflBLv3j+hztBshUuGN7fkklba4GMaI1ohslaY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6QfpEul9aYEl/KMNkbqQ1AORqE3JnYFkI0331bngQYA=; b=bqD1HwpLP6wviZnGoiMGJ0ASRy
 IEsxTHnOzUgwB+qWPmYLbO1B1RKo5v30iXXeykpNQoCjvXO+PZJtlH0BTzC8/ZXg/zB58Uzf6b3eh
 rgNvbqzTtD/2q2C2sD0ldSElV3YAQZYH1cJeng7pYz/a75uQ9eZIjq3ya/E6Gzht+Fd0=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNq91-000000004lw-43Eg for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:24:09 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so26836635e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 03:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793618641; x=1794223441; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6QfpEul9aYEl/KMNkbqQ1AORqE3JnYFkI0331bngQYA=;
 b=Iy55dKMtYumHvyQt9b1N9fDoM8S91HdLBCN/0OI8M7h7kzwiRxt8olFQR2bqQMgkoY
 Dc9rxBWMt+KlCuhxKZC8AI6bgj1dr8klPRISWT6eayhAi7EjWqy82j2dQ05exxzuCtdq
 u6+H8JVl+uM1OfuzJynGc/UCbTCJ05gag2dPiMUTBlGleHohwnV/8blohnwPZByXaOlY
 UkdzZ/tX6dEh9x1ClWX0GGdAETTpjsIg7AczYlZfQRq4hgXHlmK2upXMNTgCLC1V9XHG
 fODxpha0V5KLRMGtMIbwVfgD5L491ttb+z9PVazgS+o7HmZvUbDORxehiDzDi2t7JASG
 Zh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793618641; x=1794223441;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6QfpEul9aYEl/KMNkbqQ1AORqE3JnYFkI0331bngQYA=;
 b=Etp4SGKXDHAhz8pEX54IM1vzgxrJnxc0F6xe1ysJlCO1+KbA+epRvZBpNR12bXMxue
 Pyj3a+L5x7eEqKEuzv01MaiEHQzVkdgJvMnxyG0J4tiJ532gEWclMmcb4rofuN9sYqFm
 fICSF4nZJRWrSuigZiEAPxP9I7fkg2g572FyfyO+AIS994Ryxjn/rxn4zynE2L22mqnT
 h/XBOWb6X79IMAL1z7HhdSXC3E3arvjds1i3t2TfJ6M7/c2z8S06K32YIQXx6b9DnuV5
 6brBaqdN4So8flQ4N+Mpby1xwKeg21OUHCipY+7034viG8tCTXEgIYYAXoLiWghqnHu4
 z8vQ==
X-Gm-Message-State: AFq9FYJjZhIfAkqhttjAuuY4paqpEj3ECfLEnT1OPhMd2I1bcOVpPKWo
 6DygC+T3YHotJ4GoBFx94AXP3mc5U1+kOdBZEELqSrMklOelR2Ly8O2LD8sIV9/T1LcgWXiM3jA
 WZlh60eTd4b/IxOU3Ag8cLQArr4TPwUyoHobAGjAACoUJJaQSZKWIgLrucdY+IyVXylpj
X-Gm-Gg: AYBFou2G6DJKE2gpS2oVYsf7nLat0W/vfmE3ZIoTk4dxLuMq58l42ulPWmPK/BJZsrn
 fCcS7rc9YX0sIR/ICIvFrHehK2d4DJif+mEJvs2+V+SHPwSf1k8JFWyDygjVoVNvbC5LgSNF56j
 oLIef0HbZ+lU/K689Ancc7rkNkIJN8QrVtK1W0tGf+b7+bIbAnyQvYoIl50yMGf40oakLWltqw8
 rQqUpslIlH1EhtmVZQkpr5fiejYjxDg0/wO/MqAHgR9U6k76mbLJY8nU4DhvcUmpY3yv0cdmB7D
 MRd3ttfYDzFpXbnTrC1ez0yZfyFMw4tpfCE6o3ZAHTAiyQFVBKjUKWbmN6FgxO6jy2wCEch8+W7
 VP1owfsUpFcpVnjPDxr6c9UOwJeNh+iFCV4wo5smIYCCX6HejvZuBCWA19n7vRcekBNeAFo/9Wn
 7VrkKmfUhELb2iG1weIHCWNMQ96w1OnG1FGvubILgpm6rboBt/MsvqJ39jIlzcJpEpTAy3jzYK/
 CBVaoZVfONhwsCoH625bs1/EenUFoBnYH236armeC3JOV5oqFzAs2wP/yi7MECsicqh2T6LR9Nr
 q1Jqbe82LyXe/qN9ITBJ/a9rHLYLHmQRie8rld9wCGSFY1ltzNVK12O1GYV+Ihhl2Odbg0qIdR8
 YJ/B1tfOUrs7wA4gWDVqnHGgWv46lyrFkt6QiD9mjBZvGx/E3yLYJIid3bVQADzwNET1f0/CuM/
 YEaC4WSMOXrmICQQ==
X-Received: by 2002:a05:600c:138c:b0:4a1:f90d:6f4c with SMTP id
 5b1f17b1804b1-4ac17ffaff2mr212806755e9.7.1793618641138; 
 Mon, 02 Nov 2026 03:24:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f3229dbsm331562465e9.1.2026.11.02.03.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 03:24:00 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 11:24:00 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia3f6dd4ce35869c92619ce0c56eeda8796bde006
X-Gerrit-Change-Number: 2084
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2084?usp=email>
X-Gerrit-Commit: b85c15846fe9d108e67157b5725c666d260a70d8
References: <gerrit.1793618639000.Ia3f6dd4ce35869c92619ce0c56eeda8796bde006@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4NjM5MDAwLklhM2Y2ZGQ0Y2UzNTg2OWM5MjYxOWNlMGM1NmVlZGE4Nzk2YmRlMDA2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5a84c7e26ee7c3ac53c60932f579b92473e56988-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNq91-000000004lw-43Eg
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: check_file_access:
 fix --extra-certs access check
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
Content-Type: multipart/mixed; boundary="===============7084899430030280557=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7084899430030280557==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8SpXw46LL00="; charset=UTF-8

--8SpXw46LL00=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2084?usp=3Demail

to review the following change=2E
=


Change subject: check_file_access: fix --extra-certs access check
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

check_file_access: =
fix --extra-certs access check

The file name was passed as the is_inline f=
lag, so the check was
always skipped=2E Pass extra_certs_file_inline instea=
d=2E

Broken since cb2e9218 ("convert *_inline attributes to bool")=2E

Cha=
nge-Id: Ia3f6dd4ce35869c92619ce0c56eeda8796bde006
Signed-off-by: Razvan Coj=
ocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/check_file_access=2Ec
1 fil=
e changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/84/2084/1

diff --git a/src/openvpn/che=
ck_file_access=2Ec b/src/openvpn/check_file_access=2Ec
index 83654b2=2E=2E2=
5d7f90 100644
--- a/src/openvpn/check_file_access=2Ec
+++ b/src/openvpn/che=
ck_file_access=2Ec
@@ -267,7 +267,7 @@
     errs |=3D check_file_access_inl=
ine(options->cert_file_inline, CHKACC_FILE | CHKACC_ACCEPT_URI,
           =
                           options->cert_file, R_OK, "--cert");
 
-    errs=
 |=3D check_file_access_inline(options->extra_certs_file, CHKACC_FILE,
+   =
 errs |=3D check_file_access_inline(options->extra_certs_file_inline, CHKAC=
C_FILE,
                                      options->extra_certs_file, R_=
OK, "--extra-certs");
 
     if (!(options->management_flags & MF_EXTERNAL_=
KEY))

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2084?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia3f6dd4ce3=
5869c92619ce0c56eeda8796bde006
Gerrit-Change-Number: 2084
Gerrit-PatchSet: =
1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>

--8SpXw46LL00=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2084?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">check_file_access: fix --extra-certs access check<br><b=
r>The file name was passed as the is_inline flag, so the check was<br>alway=
s skipped=2E Pass extra_certs_file_inline instead=2E<br><br>Broken since cb=
2e9218 (&quot;convert *_inline attributes to bool&quot;)=2E<br><br>Change-I=
d: Ia3f6dd4ce35869c92619ce0c56eeda8796bde006<br>Signed-off-by: Razvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/check_file_access=
=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/84/2=
084/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/check_file_access=2Ec b/src/openvpn/=
check_file_access=2Ec</span><br><span>index 83654b2=2E=2E25d7f90 100644</sp=
an><br><span>--- a/src/openvpn/check_file_access=2Ec</span><br><span>+++ b/=
src/openvpn/check_file_access=2Ec</span><br><span>@@ -267,7 +267,7 @@</span=
><br><span>     errs |=3D check_file_access_inline(options-&gt;cert_file_in=
line, CHKACC_FILE | CHKACC_ACCEPT_URI,</span><br><span>                    =
                  options-&gt;cert_file, R_OK, &quot;--cert&quot;);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=
=3D check_file_access_inline(options-&gt;extra_certs_file, CHKACC_FILE,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_fil=
e_access_inline(options-&gt;extra_certs_file_inline, CHKACC_FILE,</span><br=
><span>                                      options-&gt;extra_certs_file, =
R_OK, &quot;--extra-certs&quot;);</span><br><span> </span><br><span>     if=
 (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br></pre><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2084?=
usp=3Demail">change 2084</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2084?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: Ia3f6dd4ce35869c92619ce0c56eeda8796bde006 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 2084 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit=
-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--8SpXw46LL00=--


--===============7084899430030280557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7084899430030280557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7084899430030280557==--

