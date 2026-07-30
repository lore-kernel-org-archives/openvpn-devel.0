Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994A3C55167
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gBRIhZc88fW3W6Y7PV2mWMEkKckUvl6zpA1u/HmDfk4=; b=JwWOstni3knaf1MUP/04UkcYD0
	AFt220payk/RjUQTLqLmMf1ks5yK2h6m59Y/ms/IRTa/OXwPE9YeQWWbnoFhYv0L6mRtqq/5Q433j
	X7VXMNQ2HRcjfMGNI1HCU0Tfc4IYeUe8w4egYBiAqtRk/6K9eO73ynlJjDRdXSIfDS8Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpPUc-0000dp-O6;
	Thu, 30 Jul 2026 12:04:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpPUa-0000dS-QD
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 12:04:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4sZ+SCK7q6X4E90Hex47eV+Az9NVvZPGi3/neqGvxxA=; b=Uh6mFQw8a6weDYroV0cYvEwkLx
 6LloLvA9AneX2fVi0ZVfCUxJyk7BfDMnPWNp9EIMzDSGGUm0aZSkle5jYF2KiDMuWHOtCrKllZC+m
 Jb2X/XVubiVi7nbU9h5ppjMcp6XpzGcr1efmL4SRW1i6f425/r5wFkeG6brSVSH8jzrE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4sZ+SCK7q6X4E90Hex47eV+Az9NVvZPGi3/neqGvxxA=; b=V
 0f8muJqm1laIC+WfSiXQGFIV4KlAUmeo8/rn3CvXZqc8DCa8FlaB+N1wRXE7N/NdEpOIBdwrwBXUJ
 1b34ZB7rvyIYF/HXwBq5NVHIZxu/0MMWCAem8b/Toep30bYY2yrutcHK8pwce61AwL7jaoxQ+igT8
 RNxFiBqvqDw5h7uA=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpPUZ-0006Et-GJ for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 12:04:02 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-495590dde14so19954645e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 05:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785413033; x=1786017833; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4sZ+SCK7q6X4E90Hex47eV+Az9NVvZPGi3/neqGvxxA=;
 b=WeOSZIFiGtWZ1FS37YDd2sBWk6KpXEJ2fRJz/s9htdvnPzwRfE1nbo/D96HBzhz8en
 acepQwDE5SjyB+aMvKbWvJWJMnEz8SgKRQ6s+ZSovH7WPLJT6W8KgRA0I830fDq6wqfO
 wenpz0KID4Q+WCFqaS3IyoKbmPJIXNiuh+ylnD12WD/PdqMy13f5LWWj8J+UzfpQMrLn
 QO0ZO3QRYFmC1iC/W4xjCnsHWhqz9nXVoXoEHePkd3hyVk+Mh6er/XoakPYH3TPMxaP2
 OPGUpFAsFbCqsMt20MBeckWxKjBPnCP+gwSM8TLYZnXohoDlakb4X2zdKCye3OvK3Jla
 tPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785413033; x=1786017833;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4sZ+SCK7q6X4E90Hex47eV+Az9NVvZPGi3/neqGvxxA=;
 b=A1QwmdHQKtqoLB9tvCM8tX5wDnE8fypPFRalzbQPBG/Hnk1S3GQRzUoE3S+Tp6nOXF
 Ib9TC4m1fL7OFe64F1Edk3mW9dvoVM6KxzP2knn5qfbVaxhBQkM07kQcomo43LqvNRG/
 2tD7icE2QNdZ8f5H1epyyRxF20DRzbMUajXLx60+ct6ha8bd4mUqiOM+sYF9zoXxt2zM
 3IEvC5gOGas6HFmA0vbJyhwIjzX7AEl7fEReuQw5d2CkfFfTB9gYj35qOMDCw7Rz77+S
 TflFlejhGKFymZ/1RzNaKKANpbYTuwRNDiPVqEOno8d0/71YO2T+HADAVkIx75K7yZCP
 oUSw==
X-Gm-Message-State: AOJu0YxLQHbznlfmt4QK23PsnzvGnDItUaIQNXJDiYeTMdMqRHqRe8Bc
 l9PLwWYYm57dpYBMIPekOu/kP0v2ztH3eXofAhO50njpwpBy+8OIjf5pPQmnS1s2Hv43K0OFxhm
 dLZbchEr03oEk7XC1S253RsdtQDk2JsUca1c91qHOkbtywRoUQyE3gs99nP/17xbs4B+SoEwdrz
 TWSSgHpA==
X-Gm-Gg: AR+sD12JcVyKiPgJ48o8bQYnCI/yy0U9FJlna56iAyvKsIlj2yMqgEtJ3y0obtj8d4K
 YdmL04RJSBN6+/6hZkw3xzQLl4YbcvVk2aqCl/KFOs4SaCKzC06QCjbpx9n19OWIzNXpiIH21TE
 H7XEvVEWECIkyt0P8zp1+l3RG3avvteTs7zKc9Z094ZSUuftCUVzYAcq7S/BeIt0vzo/X47jt0G
 SanGzN3+vxo5EA/G8HRSdYtDE6V7eMeABUQqdUfN71NDQE2Gtxm19lruXN3wexLLw5w3lU2DpwW
 J43uKBi6zbjleLiv1rTy6F1F4ccmuUiMg0mcPXDDl12LavfFTKrUXhiHPppKn5/dywTEw9R+m4c
 hxGe1dNH85EDUrF50U4HVpRZ62q9aZJq5HT5CvRS3I139W+Sh7RQ6/LH9kS8fv4cUMb3m32s4Z3
 HVS1uHBx11tvA42fhig4mPaH9Sg70WF0QaBJvUGITiKPKzdgrOr3SbFKLuoeY+bI19gLSX2xniI
 Up3e8ZqPaCdhwaEMjsTv5iyz0wCJAEK8pIZxQod+7CR4FKLMNVNJ+wfE3ykroDkLQaBGvPRJler
 LyZKfntZHYiqAteZFr2bn1qFEXvMj8uG4liFfxvhA0UVJo+g3Vm11bmdwwjy6g==
X-Received: by 2002:a05:600c:3105:b0:495:3b8a:bf11 with SMTP id
 5b1f17b1804b1-49804c6115cmr800265e9.26.1785413033177; 
 Thu, 30 Jul 2026 05:03:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4980120ba7fsm59504045e9.11.2026.07.30.05.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 05:03:52 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 12:03:44 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
X-Gerrit-Change-Number: 1724
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1724?usp=email>
X-Gerrit-Commit: 200db6e7bc03c2fba4610b5ecc6751f82fa2a6fc
In-Reply-To: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
References: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkllNTUyMDg0NjM4MzIwYjNiYWNlNzZiZTJmNTg5MDEzZjEyYWYzYzQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fa9497dd0f5154823fd28efebfb85bf95046b01a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpPUZ-0006Et-GJ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add check that
 username is identical to multi float
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4560949590963043255=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4560949590963043255==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lhiiztUH7/k="; charset=UTF-8

--lhiiztUH7/k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1724?usp=3Demail

to look at the new patch set (#15)=
=2E

The change is no longer submittable: checks~ChecksSubmitRule is unsati=
sfied now=2E


Change subject: Add check that username is identical to mult=
i float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add =
check that username is identical to multi float

This adds an additional sa=
fe guard for setups that do not use
client certificates=2E

Change-Id: Ie55=
2084638320b3bace76be2f589013f12af3c46
Signed-off-by: Arne Schwabe <arne@rfc=
2549=2Eorg>
---
M src/openvpn/multi=2Ec
1 file changed, 13 insertions(+), 1=
 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/24/1724/15

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec
index 9b64598=2E=2E0560ac5 100644
--- a/src/openvpn/multi=2Ec
+++ b/sr=
c/openvpn/multi=2Ec
@@ -3112,6 +3112,18 @@
         goto done;
     }
 
+  =
  /* do not allow if target address has a different username */
+    if (m1=
->locked_username || m2->locked_username)
+    {
+        if (!m1->locked_u=
sername || !m2->locked_username
+            || strcmp(m1->locked_username,=
 m2->locked_username) !=3D 0)
+        {
+            msg(D_MULTI_LOW, "Dis=
allow float to an address taken by another client %s",
+                mul=
ti_instance_string(ex_mi, false, &gc));
+            goto done;
+        }
=
+    }
+
     /* It doesn't make sense to let a peer float to the address i=
t already
      * has, so we disallow it=2E This can happen if a DCO netlin=
k notification
      * gets lost and we miss a floating step=2E
@@ -3128,7 =
+3140,7 @@
 
     msg(D_MULTI_LOW,
         "closing instance %s due to flo=
at collision with %s "
-        "using the same certificate",
+        "usi=
ng the same certificate and username",
         multi_instance_string(ex_mi=
, false, &gc), multi_instance_string(mi, false, &gc));
     multi_close_ins=
tance(m, ex_mi, false);
     ret =3D true;

-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
Gerrit-=
Change-Number: 1724
Gerrit-PatchSet: 15
Gerrit-Owner: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--lhiiztUH7/k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #15</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1724?usp=3Demail">View Change</a></p><p>The change is n=
o longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Add check that username is identical to multi float<br><br>This a=
dds an additional safe guard for setups that do not use<br>client certifica=
tes=2E<br><br>Change-Id: Ie552084638320b3bace76be2f589013f12af3c46<br>Signe=
d-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/m=
ulti=2Ec<br>1 file changed, 13 insertions(+), 1 deletion(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/24/1724/15</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec</span><br><span>index 9b64598=2E=2E0560ac5 100644</span><br><span>--- =
a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><=
br><span>@@ -3112,6 +3112,18 @@</span><br><span>         goto done;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* do not allow if target address has a different usernam=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m1-&gt;=
locked_username || m2-&gt;locked_username)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!m1-&gt;locked_username || !m2-&gt;locked_username</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            || strcmp(m=
1-&gt;locked_username, m2-&gt;locked_username) !=3D 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            msg(D_MULTI_LOW, &quot;Disallow float =
to an address taken by another client %s&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                multi_instance_string(ex_mi, fa=
lse, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* =
It doesn&#39;t make sense to let a peer float to the address it already</sp=
an><br><span>      * has, so we disallow it=2E This can happen if a DCO net=
link notification</span><br><span>      * gets lost and we miss a floating =
step=2E</span><br><span>@@ -3128,7 +3140,7 @@</span><br><span> </span><br><=
span>     msg(D_MULTI_LOW,</span><br><span>         &quot;closing instance =
%s due to float collision with %s &quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        &quot;using the same certificate&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;using the same=
 certificate and username&quot;,</span><br><span>         multi_instance_st=
ring(ex_mi, false, &amp;gc), multi_instance_string(mi, false, &amp;gc));</s=
pan><br><span>     multi_close_instance(m, ex_mi, false);</span><br><span> =
    ret =3D true;</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail">change 172=
4</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
Ie552084638320b3bace76be2f589013f12af3c46 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1724 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--lhiiztUH7/k=--


--===============4560949590963043255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4560949590963043255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4560949590963043255==--

