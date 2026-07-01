Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF93C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 19:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=j+gz2coPx+cbKv+5FSdujRQkWWhUoEEWV3owkU0LukM=; b=UyUrQDlUfCR6e0
	FZftqYzzOoVcr59qurhT6JIRhT1Je8UzQ25SBKRo3c2kLpvWrrAVdXcKftPi+GbyOcQ6XZmkT/m9a
	sDs5Epq9ReVhY0NC0vfCC5+WqGCgzM+5weP3Jab5VlXwY5D9eMoBocOPvsvDhTaKZSR4X+2Ga/x72
	8IM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wf0Xw-0007nq-J7;
	Wed, 01 Jul 2026 19:24:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wf0Xu-0007ni-Si
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 19:24:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h+UgkcTzqV5h3Jj3lqnRQr1YNUNes72S9XichDUD/Ao=; b=DkdM9LvaT2dRcCDCBme1o6O8ze
 tUAVtYkSLLOp+7g1fJYRwnkCwQ1+dt/DDDJjtBwQaZ5SnexbMtmFkuboXhQ9luSm4NZqqZbFXPZPH
 UgHXFnNcRr5QCoJOqTUhuSyKVcWfusrHD7kSboj2dEfVvW+Y21l4Y+Y1bhStO7/aecFE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=h+UgkcTzqV5h3Jj3lqnRQr1YNUNes72S9XichDUD/Ao=; b=M
 jOAGjxI/ExZQLeHjpQjLhHlfOvWrgLld7RnjKCPYA8TIaPckHfI0qtkgMgbjFKPKJ6dmkHkYrmldz
 ukNgE0Lt9JlvHToXP30UF4ziOLwjGxh/taZYOZzKGi9xgCvXOzZeSodayvht7tSyIQC1e5+8wxMKG
 5PmD4IG2FDrdlTO4=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wf0Xq-000062-Pb for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 19:24:31 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493b61b52b6so6904255e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 01 Jul 2026 12:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782933856; x=1783538656; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h+UgkcTzqV5h3Jj3lqnRQr1YNUNes72S9XichDUD/Ao=;
 b=KzqZ5lwfDU9LhXGeNRBdvzhV3ec8V8L899bO4aMzvLd8D4P5znd4U0iVbwNGra83kA
 0m4jetGVFEKtp33L8frDWwmcPuRceZ4rnWr7GdodDlYb9W38OV+50nf4ANfd/2aYSt9S
 4MRl7nKjSX9UNeW9v2qMg/520TM7+pAIhI6pgOons7XjEikMyC6o3sNPcS8Mjeq0Fe+u
 t2tuOAmKQnhIyaakjBdoSY/oo29kTc1RfoRFFvE9W5eOW+Lp5Nfe+0vDm7lfqvJUmfYX
 qALo/MEkEdLeGy5+tHRZMYwCy+9TOZK2cs/r883c5KcVGiQY0P1nLQHieKQnsXIng71E
 cyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782933856; x=1783538656;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h+UgkcTzqV5h3Jj3lqnRQr1YNUNes72S9XichDUD/Ao=;
 b=YbgMDlrMIBO+A1SKslXWBr6vYzry0yk6osttoPRu4pC2Z9Z+q6NcMCJ5eaCT7J2QfT
 9J08fbBfRWzzQTDCgl48c7XPyRZmTihgYWpQvD9GtWiDapLYj8tmKCP3KDTkQu9SLMjc
 4OulmK0GQCsWBl7I0h3XJQ0T4/NDsILqWO68gp2thFO599eKWnzv6nyzCyTBb1f6QdmZ
 aFNDW4Pb1FWkH1l4RuAr3UwAhkYiDyyawhSJ3rWDH4udrobs9W+mtNiGS7Cnb7xQ5kut
 61K0FgCsizo7veIVuQW3RfYIa+wKcl64c3ZHMYpkZnp7+Nt9NLUDH/mK7EgHsQIGIXjf
 1gwQ==
X-Gm-Message-State: AOJu0Yx/7hHr2mkB5ldX0MrD9PD7Czk8dC6mhh+kS8A55mEWAG4O1l6a
 CMfz1R++q7dh6oWAE46ymfEwgyxF4IBDyqRJXa5NrwPnman7f8efT/GhkZyCPgPGtC9Br3watVW
 5qWRuNZaU1pYVp4gyT2Tp9QW+ikKAWgXqUhbuHUNGp94YRyP2Q5aXqU71ZbTlr2adstC8
X-Gm-Gg: AfdE7cm2JndXLejAyFqJT0sWr0Ada7nlxiu4VyCnnAIO9fgeyymO/kTUSx5UyjIHqYJ
 yASqmPHRp4Ry5tcmripMG2yKIANiY6m+dmK8veyLk6BZq/riD1CotF33HQDBBdApUkX0PUoO5Pr
 Xtqn4DQD1UCphN4FoyWMxtRQJyPjQC62N5boLqlq+5Vo4/ezvl4ROVaoMTWZ22OCPJgb3vzVzbm
 8Wy6SoxkgdOK/JFY6E9LEoaelpVmbHJ12PtsUIiOcpp/BQ86QqIDi+RTCtTqndhtuocDxaACFBi
 fGkL5ILjVDlw9iSAiU4WkYrMcUV836fskYGETXReBhRLk4n7O3DJ2vONVttkLOg9pkFQdVOElkb
 pRie9I5dNYd9Rl5U5yfROMOSa1xr1kFgKLIAgIfTrQzMZl5ELrZ5RnI6fBEFxwoYImBfkpMmy70
 ktE8NqjS5ceVoTWrPrztSVCFh6YxZ22FMHTdcjojKNw8pK93Dmn+9VhNnJpGL7JnjTreKg4w/xw
 7nh1Q7CTyys9KnouOqB/gv0ZWyLaDE4/kdySdny9U2XjjJfOX1Ta5quZRJIyxe9z+gNZGdmJ2w9
 aEc=
X-Received: by 2002:a05:600c:34c8:b0:493:a5f9:d345 with SMTP id
 5b1f17b1804b1-493c3cf0a35mr28253655e9.26.1782933855665; 
 Wed, 01 Jul 2026 12:24:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be493c24sm64792915e9.0.2026.07.01.12.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 12:24:15 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 1 Jul 2026 19:24:14 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I752e03eabec085e47e8d74a9b4fa99e9ff267efb
X-Gerrit-Change-Number: 1764
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1764?usp=email>
X-Gerrit-Commit: e9a83808369172092f8f25b19a9deb8f638776fe
References: <gerrit.1782933852000.I752e03eabec085e47e8d74a9b4fa99e9ff267efb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTMzODUyMDAwLkk3NTJlMDNlYWJlYzA4NWU0N2U4ZDc0YTliNGZhOTllOWZmMjY3ZWZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c6f4e4cbae095719366f76eaf8a62a64b673719c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wf0Xq-000062-Pb
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_client.sh.in: Do
 not try to guess the absolute path to LOGDIR
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
Content-Type: multipart/mixed; boundary="===============8588288251886961039=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8588288251886961039==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0/ST35YxaKU="; charset=UTF-8

--0/ST35YxaKU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1764?usp=3Demail

to review the following change=2E


Chang=
e subject: t_client=2Esh=2Ein: Do not try to guess the absolute path to LOG=
DIR
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_clien=
t=2Esh=2Ein: Do not try to guess the absolute path to LOGDIR

We know it, w=
e do not need to guess it=2E Makes it easier
to move LOGDIR around=2E

Chan=
ge-Id: I752e03eabec085e47e8d74a9b4fa99e9ff267efb
Signed-off-by: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
---
M tests/t_client=2Esh=2Ein
1 file chan=
ged, 2 insertions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/64/1764/1

diff --git a/tests/t_client=2Esh=
=2Ein b/tests/t_client=2Esh=2Ein
index 78c8bca=2E=2E1234215 100755
--- a/te=
sts/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -126,6 +126,7 @@
 =
fi
 
 LOGDIR=3Dt_client-`hostname`-`date +%Y%m%d-%H%M%S`
+LOGDIR_ABS=3D"$PW=
D/$LOGDIR"
 if mkdir $LOGDIR
 then :
 else
@@ -383,7 +384,7 @@
 	printf "$o=
utbuf" ; continue
     fi
 
-    pidfile=3D"${top_builddir}/tests/$LOGDIR/o=
penvpn-$SUF=2Epid"
+    pidfile=3D"$LOGDIR_ABS/openvpn-$SUF=2Epid"
     ope=
nvpn_conf=3D"$openvpn_conf --writepid $pidfile $up"
     output " run openv=
pn $openvpn_conf"
     echo "# ${openvpn} $openvpn_conf" >$LOGDIR/$SUF:open=
vpn=2Elog

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/176=
4?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchang=
e
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I752e03ea=
bec085e47e8d74a9b4fa99e9ff267efb
Gerrit-Change-Number: 1764
Gerrit-PatchSet=
: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>

--0/ST35YxaKU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1764?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">t_client=2Esh=2Ein: Do not try to guess the absolute path to LOGDIR<br=
><br>We know it, we do not need to guess it=2E Makes it easier<br>to move L=
OGDIR around=2E<br><br>Change-Id: I752e03eabec085e47e8d74a9b4fa99e9ff267efb=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---=
<br>M tests/t_client=2Esh=2Ein<br>1 file changed, 2 insertions(+), 1 deleti=
on(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/64/1764/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/tests/t_client=2Esh=
=2Ein b/tests/t_client=2Esh=2Ein</span><br><span>index 78c8bca=2E=2E1234215=
 100755</span><br><span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ =
b/tests/t_client=2Esh=2Ein</span><br><span>@@ -126,6 +126,7 @@</span><br><s=
pan> fi</span><br><span> </span><br><span> LOGDIR=3Dt_client-`hostname`-`da=
te +%Y%m%d-%H%M%S`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+L=
OGDIR_ABS=3D&quot;$PWD/$LOGDIR&quot;</span><br><span> if mkdir $LOGDIR</spa=
n><br><span> then :</span><br><span> else</span><br><span>@@ -383,7 +384,7 =
@@</span><br><span> 	printf &quot;$outbuf&quot; ; continue</span><br><span>=
     fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    pidfile=3D&quot;${top_builddir}/tests/$LOGDIR/openvpn-$SUF=2Epid&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pidfile=3D&q=
uot;$LOGDIR_ABS/openvpn-$SUF=2Epid&quot;</span><br><span>     openvpn_conf=
=3D&quot;$openvpn_conf --writepid $pidfile $up&quot;</span><br><span>     o=
utput &quot; run openvpn $openvpn_conf&quot;</span><br><span>     echo &quo=
t;# ${openvpn} $openvpn_conf&quot; &gt;$LOGDIR/$SUF:openvpn=2Elog</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1764?usp=3Demail">change 1764</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1764?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I752e03eabec085e47e8d74a9b4f=
a99e9ff267efb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 176=
4 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--0/ST35YxaKU=--


--===============8588288251886961039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8588288251886961039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8588288251886961039==--

