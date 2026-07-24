Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA85C531FA
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K3dJ5z9WnnerMamGtl9QFkhZe6Uq4+LI+Ra52jOe+8c=; b=QXmAmzRPoeIQeAHhwVedvAovM1
	Rb5Qs7fhOiHm3eGFQLDViETkSCqaZWpbcHk6DKUnpjheFyFocnz6r4N4WQRFsrERgJ4AqTZf22gA6
	YdaNdRShjtxF6Q63fgD5eeDZrjyt4y57iJvJ3eXcppLfiHNGUzV5Te02q45zQcd4WGw0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnINp-0002uN-BQ;
	Fri, 24 Jul 2026 16:04:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnINo-0002uG-2w
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:04:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=PKntaPljmcH2dvnA8t1xEPdVF2m1NMi/BVMgjlSXfS4=; b=bTJstIKSN7EQ7GDoh+PZgYPnQR
 dM5KsNA/4Gt2u468Zmsdq70hEpAqaRY1aF8VH+uEL1xZyiZCZ8yP8c/8CyOBcGiB9g9Hy7tc78YFh
 VVc3tIFMf13xl29YUbpkRYPhtbG1nN2ztN2cbolzLstmJiLhKTDqW4hj6sN3jbtRt7Jo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PKntaPljmcH2dvnA8t1xEPdVF2m1NMi/BVMgjlSXfS4=; b=H
 YzOph9ULnpOucjYcJw8zpeTTWVzFVx5AO+ejN9QcNaIHu3YShWXab1zKjksqjXOmGSRof7hl0B+Ml
 nyxtUqnZbGI3eo50Yglye6iDHJiOInv6wYkS2P7kmBFWQpRunaoMvguKsZZe69eeADOqZzRFXx8ON
 TwHVMcueAT0Akwak=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnINr-0005hs-0r for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:04:20 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so5807035e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 09:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784909053; x=1785513853; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PKntaPljmcH2dvnA8t1xEPdVF2m1NMi/BVMgjlSXfS4=;
 b=bSoEdgm1DpYU1U1T1j2Pduxcr6ruVmzJ+cTyJowf3Kr4tzvo916jdFtLRo04bxbww7
 bT5qlQW+RcNmmk1+E9yM+8kK5Favq8W6mSG9062TXnN/rJBT6gf2wyIp9geH1okpzKti
 DpFJXZdOe9Q2I8dkZaIJsXrhIZvv05RpBDZmYscifawaAtxEDcpzPUCeT3S+VqhrI7rk
 +bYCcBm5k1rO08rzAw4dK2Pf/l4UPIy+SOQDghXmdFJLVkqTwJqd1fDw9JduQmm2tKID
 h7g0gSVgk/HiRolUekMSYiCA2rAfh8maS6CWdlFkD6Pb+IaAqX0rfaZWZlYIgTKcESNw
 Dhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784909053; x=1785513853;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PKntaPljmcH2dvnA8t1xEPdVF2m1NMi/BVMgjlSXfS4=;
 b=UDyxSe5HqpB7wO3xRG9WAkAMmYw8a5EJDdPJYP/6HWUZQrhNBXKCNBFmA0diEmg5qm
 SbODxyM/0L6aWMfj+9MMkv5VVdNJZSu5d1htPBfqgGuzPd0KbqtOE6K2NtuST0BJqk5E
 rw0Gs4qGJjU31bBC3HX3o2LZUSnvkh7PsvMtIzlo/tIHh0lyuc2ZRyWG6LSvoqXJN5Fu
 Ce4DmFZ9DPu9z6hCjAJoXe0cyUu72fmxPs3II6WYqJLR2IKuf71FGT9vyf4eRMs5TfBx
 MO+gg/6mWPDfjBubFfi1tZajr/o+vDbxrLdbDKTMZuP9azF6f7PXZ75sXsbANZrf7yMl
 zfOQ==
X-Gm-Message-State: AOJu0YzYTe3vbgMd47XGeXt9DQ60eaaaF/9C/8mALKc94gzxBMVex7/D
 B/9P7Gxeddd/fTlbr6Mb9UG+3KjGjdMCDyLlfHVb/Y8ZfAzUOlk9yAwSEVuReXeGjqRpIle/C77
 XIjdkbL8aolxfC0y5mynmyU8yZCEsjhJ84G/SCPmZoSgzJAj53F4xwM/UbEj/bMeMK8Bt5U30dd
 Sl9ZH3qA==
X-Gm-Gg: AR+sD10Nnr4uL2HxcXwYTFSZQL8Vp5h9xtr6stTNs1FrFgeNkLHiDmDUgUNelfrUJ7s
 3Q2zj+sgUqRwMZ1h2mH3no6kRUDxlrRACwfvk4Q+hitf28YyEKXhkyN060bqV6/19Eu/y8JvaWu
 u3AX/eFQY7PYqRNYPij/pebPjbDwLop/tokbocdowAGiW3Rfha20u6az0Z178BFUl6uwuO4KdRf
 3p9UyranTUqBOY9ffO1tbz9sV4u5h2twEB4XEeTZxuu5ms8dZ06nwSGs0dW1ouydX545/OyrxAm
 g7OBM1XyjzZq2Fn+bZE5XT+N0Y9aFOWz8b1nU8x9afhE8BegWICN7zH4mvWxeWLPHQsryTIM11y
 NTjUwnEmzoO81FY8rIt4socu3TNf9vq/4wdzjRAc1RKyGFailuz71hTAwAHLjQntyIO/vFoH8iC
 Tvj+tK45uExW6tOVC5ks+H/nmd/fa4jl5fg03iGvDXEvu2Y9+AB5rjXiKtkRA25RugFBC4mY3Nr
 iNABu+BryiVCgYczz7xwVpNX5jpR+T0+ZMWq+dMyln0Tgx9v+w9Q9rc9JxjVrrQMyt/
X-Received: by 2002:a7b:c016:0:b0:495:6c44:633f with SMTP id
 5b1f17b1804b1-49573cffb02mr74289985e9.31.1784909052687; 
 Fri, 24 Jul 2026 09:04:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b487a3f0sm616035e9.13.2026.07.24.09.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:04:12 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 16:04:03 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
X-Gerrit-Change-Number: 1724
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1724?usp=email>
X-Gerrit-Commit: ca38b38dbbbdbf90fedb18b7aed03ac782d1239a
In-Reply-To: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
References: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkllNTUyMDg0NjM4MzIwYjNiYWNlNzZiZTJmNTg5MDEzZjEyYWYzYzQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <60f72d0dd282a0ba1099fc1f1e976c8e50daa1fc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnINr-0005hs-0r
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
Content-Type: multipart/mixed; boundary="===============4288543122711819941=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4288543122711819941==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rwMhaKxlwJI="; charset=UTF-8

--rwMhaKxlwJI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1724?usp=3Demail

to look at the new patch set (#8)=
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
hanges/24/1724/8

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2E=
c
index af2b1c5=2E=2E2fa3b2b 100644
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
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--rwMhaKxlwJI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #8</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
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
/24/1724/8</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec</span><br><span>index af2b1c5=2E=2E2fa3b2b 100644</span><br><span>--- =
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
tchSet: 8 </div>
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
--rwMhaKxlwJI=--


--===============4288543122711819941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4288543122711819941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4288543122711819941==--

