Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54F6C531FC
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zNBnSGASeJhE4TJl+kim7KLlgMI3Q+WG0GGP+XiK93I=; b=J6LAF69CGvKBl7vw2x1tbQfQQF
	KqksDgEHd1RBGsxI2nH3XDhgbM4Jhfs7s8qZPNaWmOXKDos5bq8bm+0JStVCQhXB9z8GF75f8+wjV
	pTd18YM/oBrdQiRBN9Vk5yKdkANiW4uxoHqTR+7wPZOaQBgTmFvhz1NFAoZVauLZN39Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmw1n-0002P1-O9;
	Thu, 23 Jul 2026 16:12:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmw1c-0002OW-0e
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 16:11:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8U/XGAAqg2Cxy3BkpPa/FxvuIo1EFfn2r8aJtqUcwSY=; b=SWh/7yTkkRpClYyedjuKL7iJDd
 EWRnL1r2vtpHXZUHumHvRlRXVyU8DH0EKKO8Psg8jDkzdxRAzeub+yzbHVo18NnrUPyUj5rmFh2dB
 IX+hkUQateTRCa/hYznZzRW+F1WZ/yoEtogPUH3uRO6NDN7SGYq76Tr8muSrD7+c9isM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8U/XGAAqg2Cxy3BkpPa/FxvuIo1EFfn2r8aJtqUcwSY=; b=g
 Oz9t8Grfm604a3xH7a9DtBaO/7r+P6zRzvBUTKY38QgmEI+Es1jJHgSx4ZIg3Yf72nCKNcbAWoOHm
 A0KR5kT4aWW3COAiDkFmWIccQfv+LeP8nrPM7K6D8dLM8BHlvreZNbtQJMTi7rW6YyzejmBqYQsyk
 EihU5iItIeKPfJbM=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmw1Y-0002tE-3c for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 16:11:53 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso363157f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784823105; x=1785427905; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8U/XGAAqg2Cxy3BkpPa/FxvuIo1EFfn2r8aJtqUcwSY=;
 b=PI34TAv8kmOc4oJEUn8c3wtr41UbL6NM+SyfccbhkGMJZVM5C8/gL4wR7/rEpZbgX7
 uLJVYg4Z/KaCex7k3Hik1iotMYcwnT1fcFThxuZk5D9GRssTjCfmLz3BN5Rxsh9RFd+9
 ewG1i0/2jbJ7Et9SrXK8rvEDTIN1MgCDMI5EDj2shPxtmuGkumTXo8kwIcst+uh2gt7i
 AHB1Reo8p/vB+TRHHZVnm/2TvvVLfmPNcLKmt9tHuhhpmnrqai4sVfHkDpT0xFDFxjjx
 yPK4NBVNDRGlZZ+T3fbmzyTrWU29xZBS5PShMSYKBc5DT3zNQXBagj4TJVi+/WA8dUVb
 8l4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784823105; x=1785427905;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8U/XGAAqg2Cxy3BkpPa/FxvuIo1EFfn2r8aJtqUcwSY=;
 b=kgqwSf1t2IgprOfIaALoETSOos9zNfGwYouHDbesXpbGEaWvyqkF3nvfrzXFEhGQO3
 5LC3+mdqCrjTkfZ3CNa6ev21igUM8wth2OZsYgmmMmajUUEAaRKzJnmAKi/AEC6FZo9P
 uBtq1Q5rN92fSvUIZwb5Zse/Fc1d6DmPZjJbqfEnOagQxV/WS4FvGaV4W3zrwpAVD2jT
 tS5NjxSN04K0cnuCMxzoIxa8aXX3n47AuXhNJB3t8SWNWI1DpQAt3jh8L0XZLVnzDrp7
 dsDCahc3XHSTFk+beFpp1i6C+7fToTw9Da5pRx6/vaWu1x0e8Gy6Bil2ZkY6Dyir0I+5
 IjpQ==
X-Gm-Message-State: AOJu0Yx3KayCGq0ZAtWJduCMgQSU6dyXuLNPuzzVwOCW/xVnV1qsZW5Y
 WcHjnpZKqcIbIi9SSdPuKwao7hic2xkPb6zNLFFMcXOPNWcqDa8maeui5jjSH9eGg/o1FFwveS/
 ID5EUcsjwcRdt5b2VxOVtdOH3OqavdsNqiApcVOna7M/lcTgnBWtR0P2jvlfoHsJ5MGJqlrgkiI
 BsYcH/bg==
X-Gm-Gg: AR+sD122+USnM1sNnVRteBFfS9nn0RpCv8uvnH3Tjfio8sl76DQlKCi/hzdoNHYQy4f
 Zp+91GFNKQm8u1vXpZFjyrkfuEuI9wW68H2Qj8V8rGxWkcK/BHpTXSZAlRGz5b5o6mkRQeqpuMu
 8BLGeOeTT6Z/AB8pNYP+7W/fxbeT2PiP4KcES8KsmkpUvV5FCY5oorEpgCRznXEpauMZqyPLEVL
 m/uIfmcm+YPp9GxroxfeOWhoSt0QbbnPXjgWuqZ8/NROxzVv3qHchitqQ4YD3Iz+ZUQsehSPSJf
 k1V4hV0SixK1OMgCBqCyxI5JIj0wIVqhUiQHA3DgqLx+FeX68717b80TRVFnkY9RDgtDICnBLuk
 12xYvAokidAnv39HUDp62jT/4ne2rsw9K/V1ouvzsLIdM5UJmV310SyLHM7mkwv1FgbiVgjYlk1
 0HqyIT2GTb+zyEsUtNIG6FOQaDZe0lJKvnwR0LAVp2z2LXHYLYnYVw5Hqp/BojpgXAmEOtUYUXF
 7Nn9/urYulXMIfQUfw3czDOcPQP20reYCKEWX3iWNVbweyljYYlhHrMRPD5J74HUV+O
X-Received: by 2002:a05:6000:220b:b0:47f:6dcb:3737 with SMTP id
 ffacd0b85a97d-47f8dc96b96mr4467121f8f.29.1784823105387; 
 Thu, 23 Jul 2026 09:11:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a6d7sm18103252f8f.2.2026.07.23.09.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 09:11:45 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 23 Jul 2026 16:11:36 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
X-Gerrit-Change-Number: 1724
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1724?usp=email>
X-Gerrit-Commit: 7edbe7fb5724ac78dc4dd0cc46bd62b994c37059
In-Reply-To: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
References: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkllNTUyMDg0NjM4MzIwYjNiYWNlNzZiZTJmNTg5MDEzZjEyYWYzYzQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <894c2b42097a7682298705bce4cb7c1cd12713e2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmw1Y-0002tE-3c
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
Content-Type: multipart/mixed; boundary="===============2319420886926812370=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2319420886926812370==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/+W0RgJgRrE="; charset=UTF-8

--/+W0RgJgRrE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1724?usp=3Demail

to look at the new patch set (#5)=
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
hanges/24/1724/5

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2E=
c
index d47a09d=2E=2Ee6d8712 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/o=
penvpn/multi=2Ec
@@ -3115,6 +3115,18 @@
         goto done;
     }
 
+    /=
* do not allow if target address has a different username */
+    if (m1->l=
ocked_username || m2->locked_username)
+    {
+        if (!m1->locked_user=
name || !m2->locked_username
+            || strcmp(m1->locked_username, m2=
->locked_username) !=3D 0)
+        {
+            msg(D_MULTI_LOW, "Disall=
ow float to an address taken by another client %s",
+                multi_=
instance_string(ex_mi, false, &gc));
+            goto done;
+        }
+  =
  }
+
     /* It doesn't make sense to let a peer float to the address it a=
lready
      * has, so we disallow it=2E This can happen if a DCO netlink n=
otification
      * gets lost and we miss a floating step=2E
@@ -3131,7 +31=
43,7 @@
 
     msg(D_MULTI_LOW,
         "closing instance %s due to float =
collision with %s "
-        "using the same certificate",
+        "using =
the same certificate and username",
         multi_instance_string(ex_mi, f=
alse, &gc), multi_instance_string(mi, false, &gc));
     multi_close_instan=
ce(m, ex_mi, false);
     ret =3D true;

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
Gerrit-C=
hange-Number: 1724
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--/+W0RgJgRrE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #5</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1724?usp=3Demail">View Change</a></p><p>The change is no=
 longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Add check that username is identical to multi float<br><br>This ad=
ds an additional safe guard for setups that do not use<br>client certificat=
es=2E<br><br>Change-Id: Ie552084638320b3bace76be2f589013f12af3c46<br>Signed=
-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/mu=
lti=2Ec<br>1 file changed, 13 insertions(+), 1 deletion(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/24/1724/5</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec</span><br><span>index d47a09d=2E=2Ee6d8712 100644</span><br><span>--- =
a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><=
br><span>@@ -3115,6 +3115,18 @@</span><br><span>         goto done;</span><=
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
step=2E</span><br><span>@@ -3131,7 +3143,7 @@</span><br><span> </span><br><=
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
tchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--/+W0RgJgRrE=--


--===============2319420886926812370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2319420886926812370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2319420886926812370==--

