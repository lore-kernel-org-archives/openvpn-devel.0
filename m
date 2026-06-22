Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F152CDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=vfR8K7SLK80zVEP0IYShPi/qG5DGPDP0JglUnQfdE70=; b=eHSsRqmoKFN3yv
	dnpuevaC3Jxz6ENPnbcaf7qdt5ICy9ZYh2bXnd6eZCV9CJxIC8OZdMOq3B8lmraDFOqhvyucRGk+p
	nyMRe7ZD+83ZmjqEyiOXsOIyKTpWMQvfUSUo/uO5OcIP35kafQ8ck4ikFlJIeU4KcWWvCzWi6uQTz
	vcE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbed0-0004t7-Id;
	Mon, 22 Jun 2026 13:23:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbecz-0004sc-5V
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sYLehPYNdmL9SI1W57o7WEoKfu1NnRfes1JeLgXI/Ww=; b=flBNV6hHCbVBx0N2vfK3a48fHl
 1WaCyd1tUxvhC6Qy9lquAQD2kPEE+CeMaw+ttsdNlu1kQ6EvEgLptut3zHOd77FwVtbAUJihkD4Ev
 GXW881E/R5FMTRbaqyaRxowVvOQfvH0PNx7zfhNmUR4TJtcZCUk0P2K38BMmHQL+OOdc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sYLehPYNdmL9SI1W57o7WEoKfu1NnRfes1JeLgXI/Ww=; b=F
 EyiqKulbbpuvfcP3M9cTu8ddOduCgNrmH7glN4jiYr+lR3h1wCyXxTpN+cVhEg54ZZMWhIN8GaRKb
 SAuGzWOn0GEEwB3xnQVOiX0HVw4FK/O3VIIcXu0hAKdvgFEbv35D6ZjNDYBl5Hlge4dnK7pW1hcaD
 PPm1zpzcs7LNguLQ=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbecx-0000b5-8u for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:53 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso2618728f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782134620; x=1782739420; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sYLehPYNdmL9SI1W57o7WEoKfu1NnRfes1JeLgXI/Ww=;
 b=b80jaT9puW+C2iKlUt7ajRiUyAcV1SKwuLrKqaRiPtE0s/hU2wiLBMyR9LPvvnq3ty
 lTdBQu8dnXG4ukCyLbMHvDjRu6jNSzBRKofW5lyKXm5l5MtAim/NH6xFtZxo9lbuKxv1
 KV+y5IXS/K7C2zl56HYUSm7V6xrjkFsvNA3HqyajVxN0O2NQD+G4KkCqHE41XK1rhtAr
 7BfVbkEAjs8T8rHiasOxiGBxvOB8VXFaQrHPGeYiwC4QHzmUfQGjs3PPGnoy4rNt4Zov
 U7pDwFViOCt4keOCnZe/KeRPw/JaB0qKx73tY/M8gA9NSl//4d/XoyJmVZYvrWnoVNTF
 qQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782134620; x=1782739420;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sYLehPYNdmL9SI1W57o7WEoKfu1NnRfes1JeLgXI/Ww=;
 b=LrUSFzFOGlNE73QnE5s/O+egnSw2XB+Snw4czSNNmofBWwgs+QDILZSKvLDqo1H+xN
 BMeUYSE9Ed0GCcYIiODjicmxlttUjSQ73aHRrO61TXhtdct0uk3XTBl5u1Hm0bhvxELV
 PtdMg3a4TXm/fXQwI7GGEonpnrZkT1f3DP/c60XR3B6G5+/22StB3MRT40edAA6kfS2/
 s8iQapp9/vnlKskeKhSOe8Ik7fUALLV47n+7zlhh1wRGPhJy8fZ3iVmLxteO7hKm0F7w
 DzePfHLw9hYCv2JWkfTSwxAKBcBXt8TfrLF2nk52OsezY5IkddU6ook6kJPeZptWo6rS
 dZHg==
X-Gm-Message-State: AOJu0YzO00WWSJaLVzqO2gYrilOoehlJaaByNflhhS5wPp55qxVZPD2y
 W3mZ3B6pH9OY9tFtHduHOWyMBbtwNuALsd/u8Z/2nQ8905MoDE6M7rlyh+xDGn7GwwRWy9aBgg2
 ygq5m4oHVf7K8x0sOv52oNhaKSiv58Nzc+H9NZugEjtT0LHlIWnCOobwPADtLMeZZU9QX2GbZke
 o5Yn7AYQ==
X-Gm-Gg: AfdE7cmjdJaE4toP4eRqP93/7lc+QcQvjhuT1k7lvhValb0gvPLW7vSpvX+FFt/QL2U
 GByRCk+8+V9lCeiXPuR1yUsNZriMkWHM1E+MF5YdllcDFwTMOj+mIbYMamA/RroPhRk5z8neFrm
 DSE68bkqeXX4mgRKTyHKCxJ9gHdPML7Nh/eQxkKEctwy2LP+TQECporNhO4r3meKC/GaYcUDe+Y
 NrgRSToCywTsZNODvrKAiMH1CFV/5xH+fFlTQb7S9LX/+Fc48751ux6HkVWQh2tHHjqqGWZLjkA
 O02Y5gaK+ZsLdj1F8o+nUPbHQ6mfspPEaYJ4vRsYh+NJmUagKm81xhhMJrCRq5PbyrlwXIjk8B8
 iNCx0fZKGGsAcv82ukpUxNm+vimVeBFp5fHlyEMeYBbeHYQQBDBtnfzy+f5vtCDfJhyj0Shm8gr
 baDERxtLQZs2DzTsKYp7bO0PSV8MnflolCi/R+roEbyoMGDlm8FRzejnI6lO8v0wMLj/Lxz3t3p
 XjcjqhOxNhWaaU8Z4IJAaLZC/stLGRc0J3Slm040FGuLe5sX4h/XVxhEsqt3Un5IxtVXyoa92mz
 PVgC4KnYqGWIqg==
X-Received: by 2002:a05:6000:990:b0:466:6ed8:1e1b with SMTP id
 ffacd0b85a97d-4666ed81fb6mr15923875f8f.21.1782134619054; 
 Mon, 22 Jun 2026 06:23:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c579dfsm25988391f8f.31.2026.06.22.06.23.38
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:23:38 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:23:38 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
X-Gerrit-Change-Number: 1724
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1724?usp=email>
X-Gerrit-Commit: 145a1e97105a790e6d000936180ac22982b9e6a8
References: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkllNTUyMDg0NjM4MzIwYjNiYWNlNzZiZTJmNTg5MDEzZjEyYWYzYzQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aeab7192a3d2649c2b0e16fc45b7aa6619c3c253-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbecx-0000b5-8u
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6346489190882588135=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6346489190882588135==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o8uqCYXQFYM="; charset=UTF-8

--o8uqCYXQFYM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1724?usp=3Demail )


Change subject: Add check that user=
name is identical to multi float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Add check that username is identical to multi float

Th=
is adds this as additional safe guard for setups that do not use
client cer=
tificates=2E

Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
Signed-o=
ff-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/multi=2Ec
1 file=
 changed, 12 insertions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/24/1724/1

diff --git a/src/openvpn/mu=
lti=2Ec b/src/openvpn/multi=2Ec
index e2c0405=2E=2E8a8d742 100644
--- a/src=
/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3140,6 +3140,17 @@
     =
    goto done;
     }
 
+    /* do not allow if target address has a differ=
ent username */
+    if (m1->locked_username || m2->locked_username)
+    {=

+        if (!m1->locked_username || !m2->locked_username
+            || =
strcmp(m1->locked_username, m2->locked_username) !=3D 0)
+        {
+      =
      msg(D_MULTI_LOW, "Disallow float to an address taken by another clien=
t %s",
+                multi_instance_string(ex_mi, false, &gc));
+       =
 }
+    }
+
     /* It doesn't make sense to let a peer float to the addres=
s it already
      * has, so we disallow it=2E This can happen if a DCO net=
link notification
      * gets lost and we miss a floating step=2E
@@ -3156=
,7 +3167,7 @@
 
     msg(D_MULTI_LOW,
         "closing instance %s due to =
float collision with %s "
-        "using the same certificate",
+        "=
using the same certificate and username",
         multi_instance_string(ex=
_mi, false, &gc), multi_instance_string(mi, false, &gc));
     multi_close_=
instance(m, ex_mi, false);
     return true;

-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
Gerrit-=
Change-Number: 1724
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>

--o8uqCYXQFYM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Add check that username is identical to multi float<br><br>This ad=
ds this as additional safe guard for setups that do not use<br>client certi=
ficates=2E<br><br>Change-Id: Ie552084638320b3bace76be2f589013f12af3c46<br>S=
igned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openv=
pn/multi=2Ec<br>1 file changed, 12 insertions(+), 1 deletion(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/24/1724/1</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mu=
lti=2Ec</span><br><span>index e2c0405=2E=2E8a8d742 100644</span><br><span>-=
-- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</spa=
n><br><span>@@ -3140,6 +3140,17 @@</span><br><span>         goto done;</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* do not allow if target address has a different user=
name */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m1-&=
gt;locked_username || m2-&gt;locked_username)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (!m1-&gt;locked_username || !m2-&gt;locked_username<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            || strcm=
p(m1-&gt;locked_username, m2-&gt;locked_username) !=3D 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            msg(D_MULTI_LOW, &quot;Disallow flo=
at to an address taken by another client %s&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                multi_instance_string(ex_mi,=
 false, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* =
It doesn&#39;t make sense to let a peer float to the address it already</sp=
an><br><span>      * has, so we disallow it=2E This can happen if a DCO net=
link notification</span><br><span>      * gets lost and we miss a floating =
step=2E</span><br><span>@@ -3156,7 +3167,7 @@</span><br><span> </span><br><=
span>     msg(D_MULTI_LOW,</span><br><span>         &quot;closing instance =
%s due to float collision with %s &quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        &quot;using the same certificate&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;using the same=
 certificate and username&quot;,</span><br><span>         multi_instance_st=
ring(ex_mi, false, &amp;gc), multi_instance_string(mi, false, &amp;gc));</s=
pan><br><span>     multi_close_instance(m, ex_mi, false);</span><br><span> =
    return true;</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail">change 1724=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"disp=
lay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerr=
it-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie5=
52084638320b3bace76be2f589013f12af3c46 </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 1724 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body=
></html>
--o8uqCYXQFYM=--


--===============6346489190882588135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6346489190882588135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6346489190882588135==--

