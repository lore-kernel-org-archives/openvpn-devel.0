Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD077CDB479
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qmUeeUlqRJe+zt0b3WtM4VbnDFDgdac/yL9wy1GuRpk=; b=LhYsRN0UBJpQ7Mg4p22YlFNfpx
	olTyprC7HHSMejXsfUW7hxsvSTdYZt+G/zL5bAw/lrzXDe8hp763e5oZyNFeRg5Xwt+zIRi1l7BI3
	Z3k2s9a5kTA63t4PbQZgYHBTn7xnm42SQmKYOECisyXxghnwfcmS1WQcUVxnJQgWlJDs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wckGw-0001Jx-EW;
	Thu, 25 Jun 2026 13:37:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wckGu-0001Jn-2H
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:37:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DmUVW3SNpNXDdWJhSnixCE91PtHpeNES6B6hGiqgJzY=; b=VPmYIhhwJkX8DuzYpRTItpil/e
 xZBOGyDRzNh8al+JAKq/Zjwb1iZPw7M+/gLHlGFz0rhVPBpC7pOD/b37cqCjTZzbuJ4RaIMuXgFyK
 BePllajflFIHXLuZdWV2jEEo3hqK77ES9cDNqWewUEg+lyGHm0+kPurerILYBlBn9OFs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DmUVW3SNpNXDdWJhSnixCE91PtHpeNES6B6hGiqgJzY=; b=h
 5q0x+4t104R2PiSWM9PS6bdL9+KM2bAFwS9QUW7gNmMEmbjUwuQZaf3NbPjda+R1yxwmwb//mznPL
 1UvhOdTvsFhAvb5pgQv1DrqLmvIdAwzsRmEd/d4W11k3vGWy2e4rwX6H50NT5PzC+0OjT0mE/KpaT
 JEQ5kMy5OHWAV6yU=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wckGp-0001I4-KI for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:37:36 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so27783175e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 06:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782394640; x=1782999440; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DmUVW3SNpNXDdWJhSnixCE91PtHpeNES6B6hGiqgJzY=;
 b=YBgGA2zfcq74l+LgeJwFQxgsfQ1N3vMiSzAkxPlddBCb2zCjBsWe5k5LPNgFlHjkwG
 6ucXuVoCmCbyReA97Mv5Z3ro3ncUnqEudEfxTB8rCf7K1gWdiOXt+RtVV9gAbhgVdK+h
 /ymcDZpGYDoylSJ9Qj28KzzYP1EEzFI6cct7Ql7V9c8WHNHfDl83mGUnRdfwmT3ZKrbz
 J9nYpUiR4IQQlpa4i3Y6qwq1BlOniR2rkRMj61WQ6n+gHZfviCYEhBZHs+nHcLhC3nuj
 c+eBOdkrmohztCMApNJaKGGUgvrp44gK7gq7rThPOwuUliubxaeD2jKuYF9R15ch9VD8
 Vg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782394640; x=1782999440;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DmUVW3SNpNXDdWJhSnixCE91PtHpeNES6B6hGiqgJzY=;
 b=H6FOiFIwtw3JPScXzA2QYBI8UN8eMt8vkZpqCqqpuzuGRFWKBLG+asZ4MXGDdY9CnS
 jZpAYbiAbf4m4kzkbqSByc9sGiZy4qz8JAtbVWyWeJwOg9IRKRWu3YSqzUh6sdaburHA
 /RwMOuifVUrwbspI1B1gAuJtVXOQHi9oqXO8w7h0F8huyp+Xtzi+YJO7uYj0ORkj4isf
 LmTav9gqTUnV5vbQGIkyik2X7FC/wDUF69Mx0RlVk1gWepIZU3mgL1pE1SPhbIzk0Xsg
 5nasns/qahPzpg8FC3GGKp176tDnrI0EoE+8SPm2MnBI873wMfyH7HEJKfBdPyFP22dP
 OFHw==
X-Gm-Message-State: AOJu0YxA1sgzDok/YgLy4howfrP5/lz4dRVFpoMiVyMmVJYiFYDM4pS/
 z66dIjJopicYObFgvzYyJ+gu6SLC6Nb8AAXtwUlOiwwUm+dtb0lmf0rJ+eNlWFOs2vugIE3jW48
 /lErRwnXRTtVnESErJHBFt0AUQZ3AevZU4d7a/AsR/QFeyaT+5d4ekkEn0MHWTFW/DOu9UXrbAl
 XCrAvqjg==
X-Gm-Gg: AfdE7cnD952+GzafJtD7oYXjkxHkJQTw3D8aConmftLl7NmUCrLNBItpfIIKCosBf6v
 qpvVDbZtsEnSwQCD9HzW2OIYxQWe/rO01VnJXCbXJn532dx5RAXKbUR2GEE67mo6NXxET1wB74p
 kdejg71u9EPbo4Q0FxgQvi0eCofSkRD3lsnnojBZ/WI854L5Dcym9gKgLD1tiPAfVlCx9XktIBM
 KfPFOHoLT890Fs92pHHB/efWmLLdXbTqC0n1ionHnaycggTVruM9Tj1a4T5GzU7LECKPwN6dOGV
 QGAnv4+nge6G3Be7y9TTTKc8/Mdfu6yeHVQdfsjly6dgpWvO/z8UU0jWdhr7LX8chewxaJqB40f
 HuV5sGBH0kFMETaVOqHMKxO6wTUjlAY8xNB4nGBvhmun9+V/yemeYRH+PcSatFhZNpeH7TPXyOn
 WxCXhcqoO5fdOy0r2oNvqlfv/Df+dF/HnZMQt01Tvh+g4lpFq8bdYmj2idWCQNTih4QD6KnUfHm
 MNT1zcGzxIeVo0LYNAuaRU0fJH23+eDoHpczJV+Oe6zYI5h917GKHfHLbfXjoDf1yJ7Iqz503A1
 gZ4=
X-Received: by 2002:a05:600c:3f18:b0:490:c6c2:52 with SMTP id
 5b1f17b1804b1-4926686b4c0mr36250625e9.3.1782394640358; 
 Thu, 25 Jun 2026 06:37:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492660fe717sm53588845e9.14.2026.06.25.06.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:37:19 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 13:37:02 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
X-Gerrit-Change-Number: 1724
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1724?usp=email>
X-Gerrit-Commit: d642b9938c4c502b162b72b040473201841eaabf
In-Reply-To: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
References: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkllNTUyMDg0NjM4MzIwYjNiYWNlNzZiZTJmNTg5MDEzZjEyYWYzYzQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9b2d8cb04d6f0ae703c4911cd1ba85c9f0aeeba3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wckGp-0001I4-KI
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
Content-Type: multipart/mixed; boundary="===============8458668047112285703=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8458668047112285703==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mX0FbIzqock="; charset=UTF-8

--mX0FbIzqock=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1724?usp=3Demail

to look at the new patch set (#3=
)=2E


Change subject: Add check that username is identical to multi float
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add check tha=
t username is identical to multi float

This adds an additional safe guard =
for setups that do not use
client certificates=2E

Change-Id: Ie55208463832=
0b3bace76be2f589013f12af3c46
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eor=
g>
---
M src/openvpn/multi=2Ec
1 file changed, 13 insertions(+), 1 deletion=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/24=
/1724/3

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 0=
5a9dd3=2E=2E78c4693 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/mu=
lti=2Ec
@@ -3116,6 +3116,18 @@
         goto done;
     }
 
+    /* do not =
allow if target address has a different username */
+    if (m1->locked_use=
rname || m2->locked_username)
+    {
+        if (!m1->locked_username || !=
m2->locked_username
+            || strcmp(m1->locked_username, m2->locked_=
username) !=3D 0)
+        {
+            msg(D_MULTI_LOW, "Disallow float =
to an address taken by another client %s",
+                multi_instance_=
string(ex_mi, false, &gc));
+            goto done;
+        }
+    }
+
   =
  /* It doesn't make sense to let a peer float to the address it already
  =
    * has, so we disallow it=2E This can happen if a DCO netlink notificati=
on
      * gets lost and we miss a floating step=2E
@@ -3132,7 +3144,7 @@
 =

     msg(D_MULTI_LOW,
         "closing instance %s due to float collision=
 with %s "
-        "using the same certificate",
+        "using the same =
certificate and username",
         multi_instance_string(ex_mi, false, &gc=
), multi_instance_string(mi, false, &gc));
     multi_close_instance(m, ex_=
mi, false);
     ret =3D true;

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1724?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
Gerrit-Change-Numb=
er: 1724
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: f=
lichtenheld <frank@lichtenheld=2Ecom>

--mX0FbIzqock=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1724?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Ad=
d check that username is identical to multi float<br><br>This adds an addit=
ional safe guard for setups that do not use<br>client certificates=2E<br><b=
r>Change-Id: Ie552084638320b3bace76be2f589013f12af3c46<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/multi=2Ec<br>=
1 file changed, 13 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/24/1724/3<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><b=
r><span>index 05a9dd3=2E=2E78c4693 100644</span><br><span>--- a/src/openvpn=
/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -=
3116,6 +3116,18 @@</span><br><span>         goto done;</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* do not allow if target address has a different username */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (m1-&gt;locked_userna=
me || m2-&gt;locked_username)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (!m1-&gt;locked_username || !m2-&gt;locked_username</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            || strcmp(m1-&gt;locked_=
username, m2-&gt;locked_username) !=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(D_MULTI_LOW, &quot;Disallow float to an address=
 taken by another client %s&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                multi_instance_string(ex_mi, false, &amp;gc)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto =
done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* It doesn&#39;=
t make sense to let a peer float to the address it already</span><br><span>=
      * has, so we disallow it=2E This can happen if a DCO netlink notifica=
tion</span><br><span>      * gets lost and we miss a floating step=2E</span=
><br><span>@@ -3132,7 +3144,7 @@</span><br><span> </span><br><span>     msg=
(D_MULTI_LOW,</span><br><span>         &quot;closing instance %s due to flo=
at collision with %s &quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        &quot;using the same certificate&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &quot;using the same certificate =
and username&quot;,</span><br><span>         multi_instance_string(ex_mi, f=
alse, &amp;gc), multi_instance_string(mi, false, &amp;gc));</span><br><span=
>     multi_close_instance(m, ex_mi, false);</span><br><span>     ret =3D t=
rue;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail">change 1724</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie55208463832=
0b3bace76be2f589013f12af3c46 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1724 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>

</body></html>
--mX0FbIzqock=--


--===============8458668047112285703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8458668047112285703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8458668047112285703==--

