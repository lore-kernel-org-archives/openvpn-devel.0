Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEBC606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BEBPCJWX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QrfDDcby;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XcxVV5ag;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=B4s7OPrn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=MFs7AS0MHq3HCGODxEvXPHTgC7gQl0NJuPetxSJONfw=; b=BEBPCJWXWzzwVWfl4EkzJ0XYY6
	b3iFrB549UkkVxY6TvXwu7MnSnpHMC84JMuUVIq0mqY+yokyacvqD2nUFMO0O30CHP8QtJZmvMvMl
	9I4H0tcbXdxcc23jA00Wt9YpAsGiwBlDBEUWqsgKz4s6HQqldybaz8ZWc3sxZdVe1h/w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTEGt-0000000021M-2Te7;
	Tue, 17 Nov 2026 08:10:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTEGq-0000000020a-0njr
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:10:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+8Vst9l5XtbAd5ZnR0EcFoD+3JI9FsNsdEWTo7/xhXg=; b=QrfDDcbyg3BrlipJ7ids/OO3tx
 mh8q93Z4tBUJTYoOROXmRRGt7zkL65h5x9rT9VFF0BsvxDDe4rp7nN9DXKu1MH0UhzrcJfpbxgN71
 cJfXU37qw5q2A6Yme+PDHxqbxDUpAaVZ3iKoD4HidGgyNS9pSGCfn8/DkfTNPxFsGfvw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+8Vst9l5XtbAd5ZnR0EcFoD+3JI9FsNsdEWTo7/xhXg=; b=XcxVV5agtsrMirdEJIyNlHX1iH
 8CEJGbwxQKH3nLTSBp2ojIBky/AVPeVZrIFOg6+4tm0cjthqVzKeODhvv2wbbJYPcHaY7rwXLSwiL
 TBNMDavgS6me/ldzKApp+Xuf/JqXg5yQikvGJ8mQbK9i2DCGcY1/f9nuhMhd0N8WHHOE=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTEGo-000000004Rb-0gHI for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:10:28 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so28431225e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 00:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794903019; x=1795507819; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+8Vst9l5XtbAd5ZnR0EcFoD+3JI9FsNsdEWTo7/xhXg=;
 b=B4s7OPrnXd9aH2SALQimMjX1w+toPcE3R/suQID4fwTrYedffZb+/cmQIrH4TEYOZb
 741ZBlRLMC4TMMogCLuxThyrIuxD2iz/2qjK2fR1XIntfyZQvloQOa4sdGEhFWCD/ZOl
 pLryR6DV9j/2tkn8JHOZ9PlOVK7uRl6mskO3v8Yypb9UvlTdFaSpbBZqFyVOE3qQ0gsT
 89UMAOYl7y1WMCJnBFufPThGYrn6o7XMcENTgG+Oy7gGR9If065TAAVZusrE38kPYaDk
 M+yaOtEe5X46kNAiX3hjS7nlvDAQ5mAUfjqcKsfA43pfI+wiCtY6fnot8HEhcOLaAW1N
 /ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794903019; x=1795507819;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+8Vst9l5XtbAd5ZnR0EcFoD+3JI9FsNsdEWTo7/xhXg=;
 b=NwZEBxdMbaVe1aAPi2e0bPSiiW5l7Xx+fhfMdxeYekEWHwMSndu2ThPcL8BDQhGLmA
 e/Z6qoL5OwLO+Fdwju6eh7uFpoNBs2d1aQTXqiRcv9jatPf0YsLLrlEP11E5M4LqdYem
 me/OcnqhBdrqKD/ujdrc8XMpPoGHiyYyafJzbTiTd/RTuwbgfBHX4Vx8IS+YuHSJ6Eoy
 g2yL+Dg5Vz4u1HgcP7fy9ImojrS6hwvA6QZBZ28wQ8KliWQhQBC+10OhoQcxBqQKlHEo
 KHy7xWiEBGJTkxONwLciDCDL9rp9tXtXfUIgII7NVir53AlQgWBgJX6UHJzlmWit2FZ9
 N+kg==
X-Gm-Message-State: APuU4Z/uRUxirvwZBuYm7Cv94p8PMl4qdYEhZI2Yl+lgCNMesgNWW7Nf
 P7xAHxOXSkAmJjLMCoN4WvVR4NY4XLV+Fl1KmwR39FMSJLn5bIJZf1uFPkPHbVTBLOCZNok+zn8
 tm8tG/zI2GNCwopoKYpnIEAfGfnsEfsXaOwCDZvBUaZWOfXEyL2kcTD2JPalFEMFKRPYo8h60Ue
 R3AUr4FA==
X-Gm-Gg: AYBFou3zWKCQ7eHT6oE7oA4zXJqvfqDCFEbsxogiNQd5k4k3lD3wRgXcIu8h+elnwBx
 SHOz3KJ1Knjz51syHVyJgXNT6ka0cBl9Y43VAY/rrGilBZghkEr7LGHgvoSQ+i2RJVt2/cfPB99
 rom6BjCkurwZMozAvFoc9lblB2EP9XXR71Lma5tUUOYjXVlqUI1bibjHqp2Fbg39K2ekIQMKHYY
 EBukDZKUIz/xm8mzUFQkv/JprgAKHTy6kWPky/Z3KzteYtxBZV2sOlvJyrtRBEct3wdIEaXT5t7
 WzYM2mpeJtmgv/uEbMsrKLfA8SkOKKk5ZIOjdeCsIxsBXFCg8XBEBOvBtwJNd7PJFogc+2In9A8
 6dYrIT13pIQvFRPrL/Alhp7g2ia18aEjMHgzOTC1c4pqKXI6jgEE8dQD5wV34iw5IaBrpkv5wdc
 BE+r9lOubseaCQNa4dfzn1O1A5mu8hPqRlI9tFt2wwaTc5BMhYjZEcOaNWD7EEztpt+hnBybvAj
 16fsXo+NxN+V4ID920rGv5j4RQG8TPTBhn00uKP4qJ1uWIGjs7/MugNkdtDoXpFSx4pHuXDZJGo
 68pU/3SkwPO0gvv/XccGq6qKlMrq4WuAd4y/yXQHrlqebakGBhibCCQt9X5qx5je1EblRgPPvxs
 neSc4b7f9mSakKR72R2z4jlfHHuN+Ka45kfO7sAefbW18O3gzwU7WKuixKbXOmtWR4KYQkI7jM2
 7feVf9NFFojoAfkCc=
X-Received: by 2002:a05:600c:1daa:b0:4ba:2bfc:c8ab with SMTP id
 5b1f17b1804b1-4bb55a4801bmr278974355e9.15.1794903019402; 
 Tue, 17 Nov 2026 00:10:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7838c912sm44747175e9.4.2026.11.17.00.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 00:10:19 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 08:10:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic49db236b36014ea6ee621a09252a534e3d05ef7
X-Gerrit-Change-Number: 2205
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2205?usp=email>
X-Gerrit-Commit: da2af8f6ed7b79f35c683e95a55774982dffed2f
References: <gerrit.1794903017000.Ic49db236b36014ea6ee621a09252a534e3d05ef7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTAzMDE3MDAwLkljNDlkYjIzNmIzNjAxNGVhNmVlNjIxYTA5MjUyYTUzNGUzZDA1ZWY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6c22869185325c0c11d50e2998fb1aeeb1a9e397-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTEGo-000000004Rb-0gHI
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: console_systemd:
 treat read() error as failure
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
Content-Type: multipart/mixed; boundary="===============3662875026638180315=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3662875026638180315==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zicPqFvrOeQ="; charset=UTF-8

--zicPqFvrOeQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2205?usp=3Demail

to review the following change=2E
=


Change subject: console_systemd: treat read() error as failure
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

console_systemd: treat=
 read() error as failure

read() returning -1 was taken as success, so a fa=
iled read from
systemd-ask-password yielded an empty response instead of an=
 error=2E

Change-Id: Ic49db236b36014ea6ee621a09252a534e3d05ef7
Signed-off-=
by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/console_syste=
md=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/05/2205/1

diff --git a/src=
/openvpn/console_systemd=2Ec b/src/openvpn/console_systemd=2Ec
index f0ca7f=
a=2E=2E059686f 100644
--- a/src/openvpn/console_systemd=2Ec
+++ b/src/openv=
pn/console_systemd=2Ec
@@ -76,7 +76,7 @@
         return false;
     }
    =
 memset(input, 0, capacity);
-    if (read(std_out, input, capacity - 1) !=
=3D 0)
+    if (read(std_out, input, capacity - 1) > 0)
     {
         cho=
mp(input);
         ret =3D true;

-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2205?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: Ic49db236b36014ea6ee621a09252a534e3d05ef7
Gerrit-Change-Nu=
mber: 2205
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--zicPqFvrOeQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2205?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">console_systemd: treat read() error as failure<br><br>r=
ead() returning -1 was taken as success, so a failed read from<br>systemd-a=
sk-password yielded an empty response instead of an error=2E<br><br>Change-=
Id: Ic49db236b36014ea6ee621a09252a534e3d05ef7<br>Signed-off-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/console_systemd=
=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/05/2=
205/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/console_systemd=2Ec b/src/openvpn/co=
nsole_systemd=2Ec</span><br><span>index f0ca7fa=2E=2E059686f 100644</span><=
br><span>--- a/src/openvpn/console_systemd=2Ec</span><br><span>+++ b/src/op=
envpn/console_systemd=2Ec</span><br><span>@@ -76,7 +76,7 @@</span><br><span=
>         return false;</span><br><span>     }</span><br><span>     memset(=
input, 0, capacity);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (read(std_out, input, capacity - 1) !=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (read(std_out, input, capacity - 1) &g=
t; 0)</span><br><span>     {</span><br><span>         chomp(input);</span><=
br><span>         ret =3D true;</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2205?usp=3Demail">change 220=
5</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2205?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
Ic49db236b36014ea6ee621a09252a534e3d05ef7 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2205 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--zicPqFvrOeQ=--


--===============3662875026638180315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3662875026638180315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3662875026638180315==--

