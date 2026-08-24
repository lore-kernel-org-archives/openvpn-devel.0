Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4CBC5DF94
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=85fz8nMDT+/kjy6YUd+CaJncDeJ+mleVVOIUqhmIpvY=; b=Qp8+bwEsmN53xQ
	48wxTnT1tnbuDbbrET0/NaSftmQeeFrVcJC6E4zq5FTfFCqBXbhcouRq+gbyUg66Lz9kSS6JNEpNS
	4198YHefTuAnxt+X3UDGpNcwz6i1xn9tJF1G0i0e8iA5QXoP8C7PJjGBijYrnJyPIPq74BeEPUAbh
	GCI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wySm4-0005TX-J9;
	Mon, 24 Aug 2026 11:23:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wySm3-0005TP-RU
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:23:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q/6N+3bfF3+EO+7ra5jgUcHet77OSLRyew7TrjCR+vc=; b=XsRu4DlmDyXZ4EFQ3q6G+FSz/Q
 U+8e1oTdDXuXqaPEdLpfK9aGAhzYDfJuDXBMZfWbnMVYyJTosayLZu2gavwDQN2XsQw8N7h/S1ra9
 m10mK3hs6kZEhu0ljXe78Bjb8LYADBNIPaV/kpoD+4Q3Q71GACfEquDjfLRqxfwg9rVc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=q/6N+3bfF3+EO+7ra5jgUcHet77OSLRyew7TrjCR+vc=; b=O
 6KcKSIHAo6Jn+cEd6vhq3mug12ehSiePCUc/rGaE59mMvdzXbCCkzwo3YSQ+6ONQCe281RAsYAzfC
 0HaFtJvWB3cVEuSpZwH7cuT9Mw5Fj0MYz0eVvgdIqwSNlhcbp4kPTqN5qcY6nbH1J37eRB3QfL5eH
 WEo4RMfn4GUoBP8s=;
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wySm3-0006zH-Ue for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:23:32 +0000
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6a082b3671fso5422057a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 04:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787570605; x=1788175405; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=q/6N+3bfF3+EO+7ra5jgUcHet77OSLRyew7TrjCR+vc=;
 b=cSOtJFSFwLfLa3BDxuB1LaDFkS976DTtr3zGp+qZIF5JI/xCQ7EC8v+pJTir9ICtY9
 3jkCZXLXPFItCIbpHFjEnJucNTj5+XQYRoMqmLHfOAvQSTELFlyenJ52WqJFme+q5sI8
 hv11c6vzHPznLkjAQ/5dTd+Ad84fOBWcPLrQn3ynehS4rvIFShcizcEtClS6eJyQHmrU
 9I6iPpmy983W4sq1ntXJBlpuHjshHLINI3Jqb+/z2/n81CqNHzcpDMZ+I80SQMu9qRos
 YG4qz7hZtE99TeIwnDeywNtn86T9yUts4wC6ivxj/1CaqgzL7NjU7+AdrJyYygbp6A14
 xAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570605; x=1788175405;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q/6N+3bfF3+EO+7ra5jgUcHet77OSLRyew7TrjCR+vc=;
 b=desinErHLcgo/SR0pzEvNC10EYjZAL9k44DoxB/W1dYRo/UK8P53XmLGXgBcL1WgtJ
 Gf+7nCGq1rlRXff5HK33AsRjLj6fvlCxN1jcVaaBt47Kbij5sSwOWTDqKsdLiffIZeE1
 GK5DtiKgJnqYrh2qLS+ZdwZD+sZtAc17Fw7gkmAft1w5H/SHEIhjoJP2vGfNyREZduk+
 U+TJkV2etZkdYlQHu1BValQ/WxuweEvIouNs3Q4zq8DizX7U5wir6SUKZcCSl9RRNZ4T
 LZSDQFhqQuSNl7tWEsgEjL757OkRMidR3exYOge/9y8GGqFEKq6ig3H9lh/CeaxmmM0r
 CIRw==
X-Gm-Message-State: AFuF++kSANPsoO6Nlky9UzTNyLaahVPvkfiUSi5An87JGxBi4JqKVe4y
 IjePjSJhmyGKtQhlgm/nyy6YpRnpPONf0+1DoGZXUv7Na34XIg1E6ui9syW+Y2C0KLn6yh1bfYB
 h/E+KVR6N5Xe6n05AVMexIETvccX3ZI5RhykoggtZtTYrIVsgpmjBZQBixQbQPIHam1C1gkixIk
 3ERYsNZw==
X-Gm-Gg: AR+sD1003i8+MpXTb1MnO9O6GWbZKxyJTG54XR0V7Tyjhd7p4J08JrG/BhF1/5vSpDv
 9WRhFjW80fnCi3Jclr7jS8V4gJgtIXusourre7ZdsjF38lN2mhJ9J7hHJWDJqfy4M8mwh3CXbY5
 ozeVf9lvS84nEu1cMNK9W2wnIm5ODogJh1IoDaY28QeSldcDDzblj+eUlAbU1uasHjCH2VQpJ21
 V8GhbZs3/fIeL4pd7nX/zbqKGt4lkTVpdqVDHoa5hNso+l7BLlh9KymDSvvnD4Jg49vWfsjwVDy
 XzVr/wcJMiZrUf5AAxI+fXDI2m8UNKzj/fkFAShxoNKUgznxqcV6qzQT0NDbZc4693Wtnd+8dIG
 VhHX2nQ2b5fvhViD1PYw2PmXEFm9U93ddjf8JCdF6Y2IcWNDjlxM45ZSv5cjBAXQcVqACWLHeKM
 lJ593OMy3DqIyD/pT2oQmBJZeVF7wCcQA3bKdmKZSHeeXrW4KXqyQ87xl0B/8k7jPAt3ivEhWeU
 HoUwXOiFxx/NyZXUUv/Pbjqa5lwmyj7h3uPaVd8hoEw9DQxy0KRmeRdDVBckppdJNDvYZNwvsoY
 9ncXhQw1DM1cnz9CowHwcEpxXf4h62upkcR8IROcSnoQ1Is9V9k=
X-Received: by 2002:a17:906:4fc6:b0:c08:417e:3696 with SMTP id
 a640c23a62f3a-c24d922ff39mr158902766b.20.1787570605119; 
 Mon, 24 Aug 2026 04:23:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b161sm1338828466b.11.2026.08.24.04.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 04:23:21 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 11:23:21 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54
X-Gerrit-Change-Number: 1867
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1867?usp=email>
X-Gerrit-Commit: d39b040ce834aa1f6cdab7005b01e8434601353e
References: <gerrit.1787570563000.I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLkkyY2Y1ZGEyYWE2ZmJiNjgxMTZjN2I2ZWY1ODdhNjQ5NGFjYWUwYjU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9991f08f6c1ec25bbf4bbc107bba91ffb64f64a9-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wySm3-0006zH-Ue
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: event: Remove
 unused function event_set_return_init
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0348357610969462914=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0348357610969462914==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3/5cECQACZQ="; charset=UTF-8

--3/5cECQACZQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1867?usp=3Demail

to review the following change=2E


Chang=
e subject: event: Remove unused function event_set_return_init
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

event: Remove unused func=
tion event_set_return_init

This has never been used in the git history=2E
=
It is also equivalent to just using CLEAR()=2E

Identified by cppcheck=2E

=
Change-Id: I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54
Signed-off-by: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/event=2Eh
1 file cha=
nged, 0 insertions(+), 7 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/67/1867/1

diff --git a/src/openvpn/event=
=2Eh b/src/openvpn/event=2Eh
index 40ed161=2E=2Eb784dfe 100644
--- a/src/op=
envpn/event=2Eh
+++ b/src/openvpn/event=2Eh
@@ -190,13 +190,6 @@
     retur=
n ret;
 }
 
-static inline void
-event_set_return_init(struct event_set_ret=
urn *esr)
-{
-    esr->rwflags =3D 0;
-    esr->arg =3D NULL;
-}
-
 #ifdef =
_WIN32
 
 static inline void

-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1867?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54
Gerrit-Change-Number: 1=
867
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>

--3/5cECQACZQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1867?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">event: Remove unused function event_set_return_init<br><br>This has ne=
ver been used in the git history=2E<br>It is also equivalent to just using =
CLEAR()=2E<br><br>Identified by cppcheck=2E<br><br>Change-Id: I2cf5da2aa6fb=
b68116c7b6ef587a6494acae0b54<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/event=2Eh<br>1 file changed, =
0 insertions(+), 7 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/67/1867/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/event=2Eh b/src/openvpn/event=2Eh</span><br><span>index 4=
0ed161=2E=2Eb784dfe 100644</span><br><span>--- a/src/openvpn/event=2Eh</spa=
n><br><span>+++ b/src/openvpn/event=2Eh</span><br><span>@@ -190,13 +190,6 @=
@</span><br><span>     return ret;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-event_set_return_init(struct=
 event_set_return *esr)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    esr-&gt;rwflag=
s =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    esr-&gt;a=
rg =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef _WIN=
32</span><br><span> </span><br><span> static inline void</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1867?usp=3Demail">change 1867</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1867?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I2cf5da2aa6fbb68116c7b6ef587a6494acae=
0b54 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1867 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>

</body></html>
--3/5cECQACZQ=--


--===============0348357610969462914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0348357610969462914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0348357610969462914==--

