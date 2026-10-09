Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959E0CA6019
	for <openvpn-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n44Y0MeeNtUKIEGtGGIbsF5Xw/AYk0rikDimo5JLppg=; b=QZRAgLjrnKk+Vuvts2JNUgIuOm
	FaoibVJHOKHCj5F/Buh0HsS4ndnZf6rBWSnbQ4JCpqzFF/3XTyClYCZV3WLZI08NIkC2LBfv3LVjN
	cDRU1t/+6JTja6Jlqec2Fq3OyG3zx9s0YUyDOTV9WqaYiU+x0WNJv27PBzmGYm82Z8ZM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xF7g5-0004be-MX;
	Fri, 09 Oct 2026 10:18:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xF7g4-0004bV-MW
 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:18:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kH369FZZ8qCDzpIClIgc0jE8aEmPHRlGPNvGt0ThFhk=; b=CFUqb+XLeXn/Sbs0EDnM+E8IDM
 /2+CbbU896LXhMCWObMxgZkcFhMfOSxu5tAhhgA/9IEWAfMEilxYeAaZHpnVD3a8a0OyDe8aLRvGh
 uybN0xKvhtd7gsdZ+Yfasurl4nvK/XkPMW0soooIHP/vC8miFPvEW0BM63AnXmXruUTQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kH369FZZ8qCDzpIClIgc0jE8aEmPHRlGPNvGt0ThFhk=; b=n
 BXh0UHx/8wCRmb5PM37NZEdymNisCM/1FezYwzTDW23V/Ihy7wwgwGLHfz8df8TKuueUWL91dRfcU
 APEWHM2oEnMix4POzb5QtHhdAfDEi/pXK7gKCu9qsmGCG5oAYIOpcTk52TqHoLRTPY0avAmUGA858
 FwQ0gckK3p4W/X5k=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xF7fz-0004A0-2n for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:18:08 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso2306325f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 03:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791541080; x=1792145880; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kH369FZZ8qCDzpIClIgc0jE8aEmPHRlGPNvGt0ThFhk=;
 b=QeUxJ45C6YCpInLysAF9cIFbWsF7kuQ7O26gvhJuCRWyEHlmqraVRPlNWzzZxmwNMG
 8PvXXgiiidIYNrOj2gWp95c2EXcY+q8Ez2UOJXIr7PMt6Rqg2kFM/6FF4C2+rm1LYbnQ
 6gPNYSbMNXWgeuK82bQEOm7dnQJKdcQspCFz6EZOggnPHU26es3kRSbY2ZjTur7vlpfR
 BUgdAZfgBIi37bemHY/EgoYW4izKIJhg44fdjH8jwVJs6Tcu4YHkz89XQ6Axv5tWpa3b
 jI/B/F1TcRNK8jeFEiPPjLTQ6XaYMrzWFAtzCjdiSVL6UGwjIWyZGii4amtcUC8anKXg
 5BcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791541080; x=1792145880;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kH369FZZ8qCDzpIClIgc0jE8aEmPHRlGPNvGt0ThFhk=;
 b=AEUYet5YW7hu6GX19pTKxd5pg+Xp9IoYMfGh7NxjXVvm3ml/b3GP4Bjw1PtAsGJw5A
 Hfyum9KuPPxt5VyPSxDvRNJgveG2yv1d/VlF7dXjS4d6bBvm9ESnnUqfb4Xk8FSx1Enk
 9BpMGJD8Tad9+ipf9Hfd7wXWd/v9G5TXSUd2zv7eCgDSB4oAE4EGcwbc2WSltHMieVJI
 nGxO45s4KIvyxgbvTkP85vylN0JvR2egGozqMHSihQqbTyhCV+MIy5kxoC5JMTPuA+9u
 5TMUbXvRzQvpzmXw6do+i9em8MeOQpRRWir1kis5WVp5DmoKiaQbn8LbJh3itMcqQ3Wj
 uhKw==
X-Forwarded-Encrypted: i=1;
 AKwUvByPtMmQG9LsSBh0klvkX5lzxJUUUg2lA/ZNkXi4848A3+EAwOXAs4RNiAQLfld0a64W99MaVINo1Ihl4SdI@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIRsGfOnN0nI1KAqYKo1alAiMXk7PMWhBKAqq/xvNEnagJEEtMg
 4fJlaRkAowd8lLyUp6SxJV+BCap98+a0tDs1AcZgz+CV6BrWUMiA2wY0ed+BawWr181MivzGp/1
 zxBy+9Xn4XFAJAiK2t78VGomsYGY/txNLFuUIjUXlz1E8q5QKHDDIjr6agyA8eUbokYRv
X-Gm-Gg: AYBFou07H5NkVlsrRqoVwZiuCNE/f1ZTVqXzjLSU5KPPgbBBmhctxyEj/ZsB2Xdilqo
 4yks+UobPwy5Wfik6sQjyBwFWgG7pw+0LT5TVJEoNYLtvYhFm/A3NpEYoDTtdVXf3e5+/bp9vlR
 6hjrjihuIwb0+fkIorxsdnok2VHOiX1vEDYoHPXOgq5i7D+RrW8NZ24w+46IJNu1RfL0yu4IyOK
 zbs7Xpfdsznb3jYW+/jdOI6xHD5IryPS/VBBnr7EIlbZSJcqtAXinV926J71JcLBTuv/KNU66y+
 ipnmHktB1KOI+xyafZ68w/bBraTW/e/kaUuAYlEDiFPwWjgUbfDiTEkWWhsOSnwmFvh3RGyJNT2
 OdxSwGS77yHrOSy7LnKavZQGbsZksVpgwwCYk537ehUfuwr1hQV9+Ar90vvcc0vBSnY1jZhfR2Z
 FIu+LTW+mgVCebKgUif6+61XvbO9OTiS6ElwpcryV1fYBFdNWFw42jF52aAScm3uYJz6MTGka3M
 Q218uq/NfDQs/3U5Ew9Q1h1ukf1AACI5WEluVerl5XC8DZYRdLbG3yciVpDwe/t0Do/JGs+epSD
 FNltq/KYXMaetjJvQog5IJFY22UaVUUi6SAD+Ca6B0yBuNy1wYHw3IQdRnu2
X-Received: by 2002:a05:6000:4915:b0:48d:b8a1:53c5 with SMTP id
 ffacd0b85a97d-48dbacf8813mr2349036f8f.56.1791541080368; 
 Fri, 09 Oct 2026 03:18:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aac57fsm3167598f8f.23.2026.10.09.03.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 03:18:00 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 9 Oct 2026 10:17:59 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I8a5349f66f5c1b52889c2f593e01c21824f937f0
X-Gerrit-Change-Number: 1986
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1986?usp=email>
X-Gerrit-Commit: 1c7812a580e7d118f1a6ece8e08edae3b98bd208
In-Reply-To: <gerrit.1791458155000.I8a5349f66f5c1b52889c2f593e01c21824f937f0@gerrit.openvpn.net>
References: <gerrit.1791458155000.I8a5349f66f5c1b52889c2f593e01c21824f937f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNDU4MTU1MDAwLkk4YTUzNDlmNjZmNWMxYjUyODg5YzJmNTkzZTAxYzIxODI0ZjkzN2YwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b890994b0e675fb7123aaf19a70ce2f97ece1b75-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xF7fz-0004A0-2n
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: config.h.cmake.in:
 Fix issues with string functions
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8887657866867360676=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8887657866867360676==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SNBocRWE9V8="; charset=UTF-8

--SNBocRWE9V8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1986?usp=3Demail )

Change subject: config=2Eh=2Ecmake=2Ein: Fi=
x issues with string functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

config=2Eh=2Ecmake=2Ein: Fix issues with string functio=
ns

- Add missing HAVE_STRTOK_R
- Make HAVE_STRSEP a proper cmakedefine

Ch=
ange-Id: I8a5349f66f5c1b52889c2f593e01c21824f937f0
Signed-off-by: Frank Lic=
htenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1986
Messa=
ge-Id: <20261008205006=2E28086-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39794=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M config=2Eh=
=2Ecmake=2Ein
1 file changed, 4 insertions(+), 1 deletion(-)




diff --git=
 a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index 6c8660c=2E=2E8c3=
088e 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ =
-268,7 +268,10 @@
 #define HAVE_STRING_H 1
 
 /* Define to 1 if you have th=
e `strsep' function=2E */
-#undef HAVE_STRSEP
+#cmakedefine HAVE_STRSEP
+
+=
/* Define to 1 if you have the `strtok_r' function=2E */
+#cmakedefine HAVE=
_STRTOK_R
 
 /* Define to 1 if you have the `syslog' function=2E */
 #cmake=
define HAVE_SYSLOG

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1986?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
8a5349f66f5c1b52889c2f593e01c21824f937f0
Gerrit-Change-Number: 1986
Gerrit-=
PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>

--SNBocRWE9V8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1986?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">config=2Eh=2Ecmake=2Ein: Fix issue=
s with string functions<br><br>- Add missing HAVE_STRTOK_R<br>- Make HAVE_S=
TRSEP a proper cmakedefine<br><br>Change-Id: I8a5349f66f5c1b52889c2f593e01c=
21824f937f0<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1986<br>Message-Id: &lt;2026=
1008205006=2E28086-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39794=2Ehtml<br>S=
igned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M conf=
ig=2Eh=2Ecmake=2Ein<br>1 file changed, 4 insertions(+), 1 deletion(-)<br><b=
r></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein<=
/span><br><span>index 6c8660c=2E=2E8c3088e 100644</span><br><span>--- a/con=
fig=2Eh=2Ecmake=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><b=
r><span>@@ -268,7 +268,10 @@</span><br><span> #define HAVE_STRING_H 1</span=
><br><span> </span><br><span> /* Define to 1 if you have the `strsep&#39; f=
unction=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#undef H=
AVE_STRSEP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedef=
ine HAVE_STRSEP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you h=
ave the `strtok_r&#39; function=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#cmakedefine HAVE_STRTOK_R</span><br><span> </span><br><s=
pan> /* Define to 1 if you have the `syslog&#39; function=2E */</span><br><=
span> #cmakedefine HAVE_SYSLOG</span><br></pre><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1986?usp=3Demail">change 1986</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1986?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8a53=
49f66f5c1b52889c2f593e01c21824f937f0 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1986 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--SNBocRWE9V8=--


--===============8887657866867360676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8887657866867360676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8887657866867360676==--

