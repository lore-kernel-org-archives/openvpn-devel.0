Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA24D606B0F0
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JcdDuMyP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RnEvi4fS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WOu1vEhR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eiimSxN5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=fbMh5LU7zV2RjIZb5Ci0b7o2QRi23Q4N7Q8FTVa6XHM=; b=JcdDuMyPuTQukszKA69XrVsqJK
	khHO4JnVehdbRm56flkAaQHDX8TCHcL5wh8HsjQMT8oL7gZAUAGpU/Et15amHgVJH8QhVPOGEYf3z
	oVztbj0BL9S2h883nCGMnvWkp7QqT6zhETtCv7uAoeqCpa//BVkDVQBmVgGoWLrG+S8k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNv0O-000000000Sn-3Qtl;
	Mon, 02 Nov 2026 16:35:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNv0N-000000000Sg-2zT0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:35:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H4rvyu+WMp+hw0i9UQdP3pwx1V+u5ijwaI+cHKe5okI=; b=RnEvi4fScENlexjrnwh3e5QTUq
 XDG/IT57j41UuqB5sztN0zS5cvGwXW9ZC63GI77hRrDrEQQP3+jUxPepOXeZvzcJ+DSo3IFn5mfxJ
 fk6paTubxwBBZcoL7XfKfR8dHMkcL2ZeOvJH/l0mcDi4ThBdjL1Lwuym2rwKwUCwpFic=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H4rvyu+WMp+hw0i9UQdP3pwx1V+u5ijwaI+cHKe5okI=; b=WOu1vEhRW4CzztCPtiFigSRzXc
 kg76TAv5Nv6jiZVTON6d6ZD5YEX347o5pOG+GB28pP83wLI3mS1g8FKbHCIX5pxkasvE7MNtOaqYc
 rJgtAWJv5KOZP++GnBuEnyGgWCkSw0QfiVWsY8cmz1eIwa2V0y8rX/d5jOR9FfsoYPZ8=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNv0N-000000005J9-0FjS for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:35:31 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so3407202f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 08:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793637324; x=1794242124; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H4rvyu+WMp+hw0i9UQdP3pwx1V+u5ijwaI+cHKe5okI=;
 b=eiimSxN5TU9nMACT1+hcdpeM9eMlCiFu2SLMKkncuYzyRMQEr8eoHvpV7gFWj5xjJq
 NQ/4XILHtxzzeEpUwv3HDCnWEcYJmz0jS1GEcXzvi6MGeg5eMbsORWwXYgyW1nBJG1T8
 HRmFF1MXnRiR+FAn+b6au0BJKKj8PBVwhSGoLdR5CdwDwBawUH3TtkIevBN2ysD2Sj8O
 xIvtuXdbfZCl8eCwavYJ3oF/bU99W8SeMMtdmZoR1woQYjNqo9oNfn6wAXNjdu+OTHo+
 10d7l7StsJdx8bBWcQR8AU937LdkeWd3+jc4sAz0rE58cXIBQVi6XOy0BO3TKljv3wj0
 x8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793637324; x=1794242124;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H4rvyu+WMp+hw0i9UQdP3pwx1V+u5ijwaI+cHKe5okI=;
 b=VVNiz/6BzT4vXsStXQ9QusOp8s6zn1yPVaEnC4lvGg0TsFDPpP8vrVGGYxht7EQ/8w
 qx9WCW7nZ5FKVoJYjicH1zBiJ8XN1TikR0tuu9eOHQO2l/9QoRESzxaR6+kufxY5gHzG
 k10EQ+JO8pg56fKCb6X7NGOyOdu83q3TlLPAyIwZFTLsfJZ1/2vBwo/gdNxs/CfYaqCH
 SlWX69lmhG1uW8qgI3M1HDYE2PvWpymHIuPSqY8drpS/0VipPwpF8UPYVg/C3PfqaIWd
 rIzJ8Nq1rdeMtyIaskp5a7xxN8Yx+/tjswRFMwogx1n8KUm4b68iISdMqDCdAJKz/0W8
 vfmw==
X-Gm-Message-State: APuU4Z9AhPCc0XQqqXB1u+3xSovniBekoaKXd1YnwzxUglsPCWl79Sx8
 jDuXXFLcmC4fF4WM7wkMa1zFLnUPfTzqf7wi238vEG3CwW1Q3GwAqIr3gjCeobHKHYBPXZeWOtA
 9NlL2x1XSqKzJvBi8V+jhPN0DkpTRrEK7bAYjUbV3jIjY1DJ/I6vWQD7eSIM+GlkC2B6Qthv/dL
 tRYlprOQ==
X-Gm-Gg: AYBFou0O7q3c2oV2N2AySpab0238FxM/FEa9tW+AYF6LfOUolIljG83t23rWfp/8ZT8
 KGYvbF+BeCeTYBLVhmjAiMa6LscHKmyA9cB+RUP/jeUg5b+Ok5NU/WYr4p1i7AnM6fokG3/AWIY
 f6Rbo3vpK04O/Fs4KHqabuR2+qjzP4uuGTFPdo0DKv+AMctbLtMvoY88YHAPgOrYjFSW9YXYZZL
 vl8+jUCV3TpD5c3hXrIIXtjHGcSSpAz8aicno8BIKC+VltY7YeUsVdHtyL9RlQtxtoEinsiWpTZ
 Pv1k0y14kj66hWSQg/f96nPWNuGfe/8GIzi0d2xr/8iGX5+LifUAQvK2PxArISOHB2zMijfjzHq
 Elixpr0ZygnjPyfpfr0hCmIVZunyJlJMOzxg0MHi8Bj1dUS+fkF6myQ389iZ5QQ+hsb5H2yKEzh
 Tn7buvgPqKVa3Vfg9M1pY7Ygan6K0xXCxyfsFZIIqGLu+XQuVUEoOjXwIJpU5iEujqVhYT1fCh5
 BWr162E6+NuqwJ85eGgcm+TomIk/inqcsbQ+OQ8Kk/EFxeSyA6qNO+p3/z8HgmnU2bhnCq+yhy9
 ZW0lFlnLJz6FI8VyXu0/J+ADNTwFjhgf+ZC1SHVl3qT9XHdhrtH8e6L3j+b3k/zhtQOVspjBdP0
 IaJ5tgMUu8jkYJic0ZyjdWS2WE71GydyUXioFQP7CtyHe00BEIH7PGTdAW6ntNC7DCG253SE0/E
 u97TeQhoFEtnPjzQ==
X-Received: by 2002:a5d:5f85:0:b0:48e:20ed:27b1 with SMTP id
 ffacd0b85a97d-48e6e2625fcmr23912615f8f.0.1793637324340; 
 Mon, 02 Nov 2026 08:35:24 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bae0f4sm18505816f8f.58.2026.11.02.08.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:35:24 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 16:35:23 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b
X-Gerrit-Change-Number: 2094
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2094?usp=email>
X-Gerrit-Commit: 222ab299b8a40568240846d8d15e16d5cde45d62
References: <gerrit.1793637321000.Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjM3MzIxMDAwLklmYzEyZGFmZTk2MjFjYTAwZGMwMDIyYWQ0MjZhZmViY2YzOGZiYzNiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7812f0af473af83e89b7119f34e5a2b8b1884eaf-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNv0N-000000005J9-0FjS
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: use man
 argument in management_query_cert()
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
Content-Type: multipart/mixed; boundary="===============5739842897735916208=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5739842897735916208==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k498/EN7NZ8="; charset=UTF-8

--k498/EN7NZ8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2094?usp=3Demail

to review the following change=2E
=


Change subject: manage: use man argument in management_query_cert()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: use man =
argument in management_query_cert()

It passed the global management to
man=
agement_query_multiline_flatten_newline() while using its man
argument for =
the state and input buffers=2E No functional change, the
only caller passes=
 the global=2E

Change-Id: Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b
Signed=
-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/manage=
=2Ec
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/94/2094/1

diff --git a/src=
/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 16864c8=2E=2Ed391559 100=
644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -3937,8 +3=
937,8 @@
 
     char *result;
     result =3D management_query_multiline_fl=
atten_newline(
-        management, NULL, (char *)buf_bptr(&buf_prompt), "c=
ertificate",
-        &man->connection=2Eext_cert_state, &man->connection=
=2Eext_cert_input);
+        man, NULL, (char *)buf_bptr(&buf_prompt), "cer=
tificate", &man->connection=2Eext_cert_state,
+        &man->connection=2Ee=
xt_cert_input);
     free_buf(&buf_prompt);
     return result;
 }

-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2094?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifc12dafe9621ca00dc0022ad=
426afebcf38fbc3b
Gerrit-Change-Number: 2094
Gerrit-PatchSet: 1
Gerrit-Owner=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--k498/EN7NZ8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2094?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">manage: use man argument in management_query_cert()<br>=
<br>It passed the global management to<br>management_query_multiline_flatte=
n_newline() while using its man<br>argument for the state and input buffers=
=2E No functional change, the<br>only caller passes the global=2E<br><br>Ch=
ange-Id: Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b<br>Signed-off-by: Razvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/manage=2Ec<=
br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/94/209=
4/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</s=
pan><br><span>index 16864c8=2E=2Ed391559 100644</span><br><span>--- a/src/o=
penvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><s=
pan>@@ -3937,8 +3937,8 @@</span><br><span> </span><br><span>     char *resu=
lt;</span><br><span>     result =3D management_query_multiline_flatten_newl=
ine(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        managemen=
t, NULL, (char *)buf_bptr(&amp;buf_prompt), &quot;certificate&quot;,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;man-&gt;connect=
ion=2Eext_cert_state, &amp;man-&gt;connection=2Eext_cert_input);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        man, NULL, (char *)buf=
_bptr(&amp;buf_prompt), &quot;certificate&quot;, &amp;man-&gt;connection=2E=
ext_cert_state,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    &amp;man-&gt;connection=2Eext_cert_input);</span><br><span>     free_bu=
f(&amp;buf_prompt);</span><br><span>     return result;</span><br><span> }<=
/span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2094?usp=3Demail">change 2094</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2094?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: Ifc12dafe9621ca00dc0022ad426afebc=
f38fbc3b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2094 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>

</body></html>
--k498/EN7NZ8=--


--===============5739842897735916208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5739842897735916208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5739842897735916208==--

