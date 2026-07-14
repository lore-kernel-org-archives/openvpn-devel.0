Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76CCC4450B
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oB98QnGG9iU2ll+OisOCIfFc5QJ/yd3fsn+bgU+UOK8=; b=FS3KWA+E5j4AlqrnWpCFgB00e5
	8cvRCHoaZsTuh8UQmfja1dXcE2fBqWa6ZoacvcUSvDolpMBkhKDkV5e/20zTeeiAN7Z811kIriJLs
	o4oeHy1KOMMfLGZcuiwcT8ec0dn4B3j+xutflMEL7DmhbKjVKSLvdXcPKa3k6LtNbabM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjcla-0003va-VN;
	Tue, 14 Jul 2026 13:01:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjclV-0003v5-N7
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zQBVcjhfwS+Bxd0Irmrp5fzs3deVRXuCBK3FtRsIGfM=; b=PjuzgU/Tn2XNa+LaKuBiuOQ/On
 4+bE3Lnynjx8VklehcVWbfXBbif31Hv7wFZsqSRmRq86TC14DaVGWwplQ9EnBBKi2VOX5UTUN6F8b
 4mgdLqcx5OCoFeJzIMzFFPUHnrkR2dN1w254AZU9tnjHawWRzkYeAPjS37f0AcIzGBMg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zQBVcjhfwS+Bxd0Irmrp5fzs3deVRXuCBK3FtRsIGfM=; b=K
 0Mdtiww5lp11PFe3bjQpjXj1oUdbLy+lPVG3Hovx4X25HJ9AoWejTLXfP++IXiYbrq06ekIOfOKaM
 j7tQK4VJcdGRVvXaj8/2G0yaS7NzL1U3mjDsXBxLz3lFQd3d2QjvRVG/TGaQH2yiA02gIqqEY4eqh
 OXb/tUF+5vLSalSY=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjclU-00029N-UT for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:38 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-476d8e647e9so4235983f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 06:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784034088; x=1784638888; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zQBVcjhfwS+Bxd0Irmrp5fzs3deVRXuCBK3FtRsIGfM=;
 b=Z2R5SXXg1vpip0m6iPZNelWAkDM8xILqa7nZ06oEvZot+MbZaGkv8v2gFprBbwh/+n
 VKPa9j2cixbmnsCSsbaIV31izeZ7bKREK69w+fSTQ8pIhWKVkubPfYi6fGb02RwZ8OZ4
 WntRrLp4wn2w5qJR2sXBh/doav4K6jN2eBFLS26sI0Ig0aX5q5tREot/+wp/AyiptNLs
 hTlbSJL4HrijSoNNEFpl3U7vAKFrmbOqX9GxbK/Y/uJ8HLSGQnMlqWHwvu+/ZmU18Hm1
 SQjj4Ms0gRu8wu4IWfd0tYvPWSYIJrs5lnMUaL0fASSdsPhgEidynlts5cyZV8nzGcS5
 TWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784034088; x=1784638888;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zQBVcjhfwS+Bxd0Irmrp5fzs3deVRXuCBK3FtRsIGfM=;
 b=YvOGfqgwpBOnOLrEdhjuA7PjMTEt+hQuZ0Pt4gLBTJFI49xS9ms1SAu/aD5VAtoG0o
 zc+QR8u6J1HwLwVW8OT/qV8fEIsVk+Cn/wk9p7NWVf4qIap4cTKQJDtPGLxaQi7AeYeZ
 aMiPdVsZSGsxBTXrI84gvZuDC3dlF0p5WtVYw4Dx6xhbP+oIQJ/eGTt+rR/vNmTrkKvM
 YdSEVImgeuUaUhXTKTOHkBA4hgS/Kt7rdkNQ8yKLxheQRO0sNbka7/EUIFbVtCe76v59
 4n5aPHZ0UVSgZgbdeeLYmIQv7Q9e1KUYI+osKn9XT+dwotCJiBvPyeGijVSNVHgUTD3x
 Qmsg==
X-Gm-Message-State: AOJu0YwgCgB+V8m+z0c/S1Ur0dbgvXFriBD7EZKdvXOGvkLOYPUwQdHr
 n3/kMwttO4M76+lrsqeBf5dVc+dESql4yyf3boJo6wh2FS8hYdYr2Zo2VcemLy5UWkdoMOzngcC
 NZe/ayaIIKl/pN6LY1nsvnrtMP6BC9vvFqlqqGHI6uhaJQ29tyZX91vt6/QxkSjEBXRT6XO+CSP
 iPi1b/SA==
X-Gm-Gg: AfdE7cnWSET9JKmXh/nvCgJfSOBLg/88SdNHdDaD5G8TieSrDJ0APw2K3j+pna0sDcU
 MgI7FAM8wSejgEo3qtIHpG4whKAX2hhdc5fPVZNWLFOw95uiR+tzR7LgbiI1ho5p0nyYZVg61A5
 oKX+ccsBGUr7O9/eLvpVfkctLMgyx5IUchw4E607W/3Wg5s4wm1Inkw8gIvFyo3XVLcTF5YDqO7
 FqhyanGdzp8pOlgmJGkJ/egyteT8kPq/PgTy/QiCNyy4p7AzeercB0/oJrcQ5UAF6nCUcaKvs9o
 TQWs1fES3nUBsKGtsHZj/ZghQgRwc6DpwXV9IjRmWL4QJbc3Sa2SVcYqnEQW0FoY0KzOxq+sxVN
 6bBW0d2EghDe2DAq9NX/k62bAufpSytJKviKCK8BHRq1OTy6J5YOXiSqlND2IZBuujrQX6t73Dr
 gKcZJT18jjaNhYk36kpHQBLwwtcdzwtUMqSAuE8eITFT9r+0Mc2mxu9PvmiM6GjEuWjk6QiTSYZ
 8VluLTcjYZAPKNtCcJAi72VuSVCOxy/vZLAJbsDAH/pFIDOh+TGdwCGo9jw89hoFwFhux3UoC+c
 Z4c=
X-Received: by 2002:a05:6000:41e3:b0:47d:fc33:df0d with SMTP id
 ffacd0b85a97d-47f488c1dc9mr3122954f8f.58.1784034087637; 
 Tue, 14 Jul 2026 06:01:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e036sm9317250f8f.5.2026.07.14.06.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 06:01:26 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 13:01:06 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
X-Gerrit-Change-Number: 1724
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1724?usp=email>
X-Gerrit-Commit: 8c64a42c5459a4b9bc7577af4931c1632b787508
In-Reply-To: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
References: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkllNTUyMDg0NjM4MzIwYjNiYWNlNzZiZTJmNTg5MDEzZjEyYWYzYzQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d36e998e29a45926db76dcbb2ae3fccf67c94de4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjclU-00029N-UT
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
Content-Type: multipart/mixed; boundary="===============5286269346791916562=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5286269346791916562==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fAU4UyuoigY="; charset=UTF-8

--fAU4UyuoigY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1724?usp=3Demail

to look at the new patch set (#4)=
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
hanges/24/1724/4

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2E=
c
index c40ebe4=2E=2Ece6807e 100644
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
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--fAU4UyuoigY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #4</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
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
/24/1724/4</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec</span><br><span>index c40ebe4=2E=2Ece6807e 100644</span><br><span>--- =
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
tchSet: 4 </div>
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
--fAU4UyuoigY=--


--===============5286269346791916562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5286269346791916562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5286269346791916562==--

