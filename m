Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC63F606D80D
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=d7w/B36j;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SwLPYqMU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kc/+qX/h;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MvSzgycw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hyt54Z+LFt4YkkwAucN601EqA5YIuZgHYGfqyw9FNA4=; b=d7w/B36jlvehI/AH31xbDxm5tM
	keoGZv4mtJwRPBLY1KGEjy+9KsiK/YezbIXJYIgbQ8UUp1VPAYuoYBWEECS10pIYzvgl7ptAakiqx
	XStA9rcXOVhLwtRPwycKiBTfTTpfuz34VsfDOjCPWnnB5yE9t3Kw/prnYzGWUga/D5Xs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOdqF-000000003wq-2WmA;
	Wed, 04 Nov 2026 16:28:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOdqE-000000003wG-1Kmd
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:28:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dHYXsIGmhSC1k8Sy2TYV8XqO6+YNkMK5xWBP0+1P6x4=; b=SwLPYqMUK7iWepxB+l39vnkc6J
 naNOyHFvg1yaI+fLhgBeG8E66iKBfu6cEhtTZPsNjh4vwdvQyXyEJBLmGOpLrBoMeaWE/KDDYXLWO
 InsBYS+7tWUE+YqdjbUcuFpMo3oAJpFVf58U+V5lWDepWA9YKCNSicsuuvo09fHEyv8A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dHYXsIGmhSC1k8Sy2TYV8XqO6+YNkMK5xWBP0+1P6x4=; b=kc/+qX/hdwzgf6dafJLeb54EMZ
 EzMg8ojfus/OoYP/N3mioH53pH/nl4x7HNrZVpwkRS0GSoiP5NvNKaajM0h5wT3ASUexJNhKo6FwM
 owpT0+wzgaDjCEWkxh+qI9Dwh4d/uTY34gS6VZN9MwCnK0bKprUvMflggOTpjkrhf9oc=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOdqC-000000006Ni-2jtY for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:28:01 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso1208279f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793809674; x=1794414474; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dHYXsIGmhSC1k8Sy2TYV8XqO6+YNkMK5xWBP0+1P6x4=;
 b=MvSzgycwm02AdBvbdu+UA+LuygwyRTZBAHdRTWtN8uKDPh/bifQaplv1yO09U+rvRT
 Bw9t5eHC2pN73ErqKBEcBwNVmC/vpEDApRo/MZRI2JfpMLVEdEWNfdVo7yEk5IGf0scO
 4sK35dGCwoszdJHjPkBye5LlsttnhiTZC/5B2rPprNTht5mIBdIceJ7j4Dc9W6nedxqu
 FeeffVUoNosz2LN2MIUHLKOwRKswYpPkCoOzHRc6AQqyPWDuOl5Qslv3ibV5kbqnT8M7
 NI7Cfglpn8MkYJJwmDz1TCsxdsjnbi7CPDnPpvlstvKHNK07radCae+tgKC//CRpbL4s
 MCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793809674; x=1794414474;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dHYXsIGmhSC1k8Sy2TYV8XqO6+YNkMK5xWBP0+1P6x4=;
 b=iDJrPrJVW99wFaM95jD6ffWfTu0xAo5DmglwFOsq7KUI8m6mE+4ooHD5hfvf6xRLDY
 LpeDoqpF2GdKtHSjZYD26NPldj4uiLm1Zb82iytq/bMTl854NnUlpwsLvrH8S5ESqoo9
 uwt/VIp3534r2K0dYSD0o+RufwGpl5/g8tdu5us3mQL36DNQxfEAucTGFFyCncAfSnMD
 GWT93xKlOMQwYbJlgR8ezeFYgDrIFKN9R7M7UDHi3QjPmJw/XrgUGF9r3npkDxsMe12j
 1oeTA7BcCvPmY1jk4HzyimEE7OdGTNOim2ARTYnG/VRvIAEbgjE1TVz6bZvVl3UTCm7N
 0xOg==
X-Gm-Message-State: APuU4Z8q/slwsnYCmQnc0VLNufVJvID0/3cV82OC47r5y9mFpx3GsYz5
 G+F/R3/Ok3sjZ1wKM148JLNhZArbyhsynovv0w23iS0GpXQ7zrF1SbCoDrreik2vZBryoeboRWQ
 9vc4Bmg+LbVx6FH+XE7eaYZaWMqHPRIX3W3y67E+OA16ghD1OTCfhzL7Qss9j4xTKJ0pc
X-Gm-Gg: AYBFou1AeG+EF7anJGgiLh/L8refIVxB9U7lXzxX7AhMOYfG2RGgtmWg9EVFAzhoOeB
 HvbgKQrlC5zcwtXxUBBdaUZp/lBYEOTT1DGXO3j63z8LEYJ/BIdYdKepHBl9+QmMex2IG7Na9vC
 3xSCVna3bm1i/dzdkc1epLp87nhs/ZdoACwqV0shxhzPGWdKadkv53o+GtF1xc5z2iucy5lOW16
 W54NbBfsUy0qly01xHnfKllZGTK/wcAmCV2k/U8cboTE7IZtcAAUdMSLnhN4LSS1XRAHmzsChgq
 k3G+Uc7uVKWNj6CWfvpYu+Tn9S6kaGEnzEgA6f3YeGS1PKJ03hckKJRXdqgkwrwujGPHI+MrGB+
 UIUqR/MGQXWbYoBb9zihCFNRmx7zivaAZQzQ9YXEroPREMfkQEaNYIGwP9/0lJWAEmvIfNZ2zuM
 T1hyyEWxab6gKWxkp6fNGS8U4dR6ZJr/ujH/dqLvTzyrTU3YU4rAH5E6ufqV9Qmxqy6eJdqfe89
 6XK4w5aN0y9fIuQGLPbRuCJCGrwc7D29BKE/PVdY0uJVhZOCJ7Bnr4fuoBqw/rzrFWDkgNLG9fM
 OrmfHuiDBQ62Zk0wF300m487AwpLN98kGVyVQ/xiMJCKln2JdRj2kje+oKKXygp3/Rrt8rEilXg
 EPPFVxmeyPbi1JMwRaXYwLiV4fNo6lDOZDny0Jsgj23qGKDKi26hmjrfCnR7rHXcHLgF288lwJW
 J5BCDSMC3sdHyhwQ==
X-Received: by 2002:a05:6000:178f:b0:48e:4ad2:32e0 with SMTP id
 ffacd0b85a97d-48e64d038c9mr44948529f8f.29.1793809673786; 
 Wed, 04 Nov 2026 08:27:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea180ee1sm5582782f8f.4.2026.11.04.08.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:27:53 -0800 (PST)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:27:50 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib1f78af0550ee9ab47a9598bc8055dc46c1df138
X-Gerrit-Change-Number: 2059
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2059?usp=email>
X-Gerrit-Commit: 347aa94405ca171f30b2ca4cf8d9016779c2bd87
In-Reply-To: <gerrit.1793194671000.Ib1f78af0550ee9ab47a9598bc8055dc46c1df138@gerrit.openvpn.net>
References: <gerrit.1793194671000.Ib1f78af0550ee9ab47a9598bc8055dc46c1df138@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkliMWY3OGFmMDU1MGVlOWFiNDdhOTU5OGJjODA1NWRjNDZjMWRmMTM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1c6b376d519da8f57e68c8d7f502761183bc700b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOdqC-000000006Ni-2jtY
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: skip DCO
 route installation when address learning fails
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Marco Baffo \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1509744128871537881=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1509744128871537881==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dMowDzMGyO4="; charset=UTF-8

--dMowDzMGyO4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo=2E

Hello A=
rne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a change=2E =
Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2059?usp=3Dema=
il

to look at the new patch set (#2)=2E

The change is no longer submittab=
le: checks~ChecksSubmitRule is unsatisfied now=2E


Change subject: multi: =
skip DCO route installation when address learning fails
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: skip DCO route installat=
ion when address learning fails

Only notify management and install a DCO r=
oute when the learned address
belongs to the requesting client=2E Apply thi=
s to IPv4 and IPv6, including
the initial client-connect path=2E

Change-Id=
: Ib1f78af0550ee9ab47a9598bc8055dc46c1df138
Signed-off-by: Marco Baffo <mar=
co@mandelbit=2Ecom>
---
M src/openvpn/multi=2Ec
1 file changed, 10 insertio=
ns(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/59/2059/2

diff --git a/src/openvpn/multi=2Ec b/src/openvpn=
/multi=2Ec
index 3f514d6=2E=2Eaf8b1c7 100644
--- a/src/openvpn/multi=2Ec
++=
+ b/src/openvpn/multi=2Ec
@@ -1215,8 +1215,12 @@
     }
 
     struct multi=
_instance *owner =3D multi_learn_addr(m, mi, &addr, MULTI_ROUTE_PERMANENT);=

+    if (owner !=3D mi)
+    {
+        return owner;
+    }
 #ifdef ENABL=
E_MANAGEMENT
-    if (management && owner)
+    if (management)
     {
    =
     management_learn_addr(&mi->context=2Ec2=2Emda_context, &addr, primary)=
;
     }
@@ -1260,8 +1264,12 @@
     }
 
     struct multi_instance *owner =
=3D multi_learn_addr(m, mi, &addr, MULTI_ROUTE_PERMANENT);
+    if (owner !=
=3D mi)
+    {
+        return owner;
+    }
 #ifdef ENABLE_MANAGEMENT
-   =
 if (management && owner)
+    if (management)
     {
         management_l=
earn_addr(&mi->context=2Ec2=2Emda_context, &addr, primary);
     }

-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2059?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib1f78af0550ee9ab47a959=
8bc8055dc46c1df138
Gerrit-Change-Number: 2059
Gerrit-PatchSet: 2
Gerrit-Own=
er: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Attention: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--dMowDzMGyO4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo=2E </p>
<p>Marco Baffo <str=
ong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2059?usp=3Demail">View Change</a></p>=
<p>The change is no longer submittable: checks~ChecksSubmitRule is unsatisf=
ied now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">multi: skip DCO route installation when address=
 learning fails<br><br>Only notify management and install a DCO route when =
the learned address<br>belongs to the requesting client=2E Apply this to IP=
v4 and IPv6, including<br>the initial client-connect path=2E<br><br>Change-=
Id: Ib1f78af0550ee9ab47a9598bc8055dc46c1df138<br>Signed-off-by: Marco Baffo=
 &lt;marco@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 file =
changed, 10 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/2059/2</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><spa=
n>index 3f514d6=2E=2Eaf8b1c7 100644</span><br><span>--- a/src/openvpn/multi=
=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -1215,8=
 +1215,12 @@</span><br><span>     }</span><br><span> </span><br><span>     =
struct multi_instance *owner =3D multi_learn_addr(m, mi, &amp;addr, MULTI_R=
OUTE_PERMANENT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (owner !=3D mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 owner;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (management &amp;&amp; owner)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (management)</span><br><span>     {</=
span><br><span>         management_learn_addr(&amp;mi-&gt;context=2Ec2=2Emd=
a_context, &amp;addr, primary);</span><br><span>     }</span><br><span>@@ -=
1260,8 +1264,12 @@</span><br><span>     }</span><br><span> </span><br><span=
>     struct multi_instance *owner =3D multi_learn_addr(m, mi, &amp;addr, M=
ULTI_ROUTE_PERMANENT);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (owner !=3D mi)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return owner;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (management &amp;&amp; owner)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (management)</span><br><span>  =
   {</span><br><span>         management_learn_addr(&amp;mi-&gt;context=2Ec=
2=2Emda_context, &amp;addr, primary);</span><br><span>     }</span><br></pr=
e><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
059?usp=3Demail">change 2059</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2059?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: Ib1f78af0550ee9ab47a9598bc8055dc46c1df138 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 2059 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Marco Baffo &lt;marco@=
mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--dMowDzMGyO4=--


--===============1509744128871537881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1509744128871537881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1509744128871537881==--

