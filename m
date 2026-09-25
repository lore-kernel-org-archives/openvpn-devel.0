Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44E7C9830E
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 12:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=aNcgYCGxYet7P2M9GAJi5SfzL2+5W/GDlMVWKpdBlsQ=; b=OdYruwvj4KAqrl
	VJlZGaDKUngh0DJI69Ho1JKdyQWR+noE3QGmgYHZ7x5sObO5OdqCqeR+ViqWUsqZL6/W4lPNXDunD
	F+wy9vbNuka4EhpvTgURIktMxkcCi/Npvb97sID25tN0GZumsHePPm7xAxbVssafgFFznMD1L26By
	/HQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA5Be-0006qx-Tw;
	Fri, 25 Sep 2026 12:37:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA5Bc-0006qo-Mi
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 12:37:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i3VZqJxOsAiB5Eav4UwkXwsRkr8JE0H+k267iMUT0rc=; b=TAtVehZ0cqNomi/uMZYlfpmfLf
 CwhXFxEJ8i9E56ZM47FLnhMx9Hv0D5o8THU8OQd0YAQnQhYZSKthJnpvJN1g2uhX9wTABndyqIyVG
 8H3PUe90jtQPI0tiZGJG9Il7uxMKP3Xxl5ql1Y2Uzq6woAd8nij0w+t7ASr7CppVlvJo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=i3VZqJxOsAiB5Eav4UwkXwsRkr8JE0H+k267iMUT0rc=; b=O
 jcEicJadeXjut24DVGUwdFVm1VZIRkngv5mU79tWfzbcr8ST3Wfz/sStqB22c0GO7pTdLPtxg8FLX
 DqWT7vaLE0cnlJUwBMU40XukRe17VAkF7E9QRP9usbeQfuX81nZVjfLsbsRHOf9+mH++dVHo2+zCA
 RUOYwMviL6mgLGSk=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA5Bc-0005IR-NX for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 12:37:57 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b2522so731066f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 05:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790339870; x=1790944670; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=i3VZqJxOsAiB5Eav4UwkXwsRkr8JE0H+k267iMUT0rc=;
 b=afcvDzb8AccMnIsFWOw8VvMdeyMprgQ4ff163UoeJr2Ry1orY0UstZHs+fQIweTdO5
 WYSI9tjkRf4BZluDG3tduzM+mccMjjZFOjpgD+jCNWxf7KRIwHBxshmjNdYkFK5KE77c
 jyVJ2CqzNuW/WGMpXT+RV1B0I1JRwMNuZfguVJb0uLXk9IYHY5LYoUI8lhxNQXvvLjr7
 bmwE+Eh9TylKbtWzuQfUsvD+WF/ghK9wWHlS4c+jgaAJxQIip3gJOdMimlQD3h3bcswf
 MASCj3BRclmZoDZHU+3RussDg+PmxeG55N9KwPQ4a2eP7Rq0PYzgyWcGtiUTOsnyYz8z
 pSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790339870; x=1790944670;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i3VZqJxOsAiB5Eav4UwkXwsRkr8JE0H+k267iMUT0rc=;
 b=Ys3ROm05YcVxKcUOme+EkB9M8tveqvkVNkWU8ySByB5mFi3HPykddmTodiDGzd4Fs2
 eUPUJ/HsjcsANGobPa/L9qq2Ow28riJxGuHAQ2C+hLM16TqWHrRjUtD2MXtPVMiNB6mV
 gVuvx62qEbdQ3xVIg1POfE1j3/lyGWyqT7Kq40/xJoZnLgfKD84RLKJEV/SrJ3bN7Qbg
 eSY3LVPnhbjdNHCq+fAM/bfCnzERsX0A67kec7lj9ORGmaiKI4lC7mafeHtwrjKY+nfG
 lCVHqhn+pL+ikTNRWpupWDjR1Nvf8tCy019cLLAqk8ORED/rvC1fYQQF1iy0wrWWCE1m
 Rxuw==
X-Gm-Message-State: AFuF++ndCiGLZ6e/vMP8NA5p/kF3z3eWa0e8ZEFABEvkjp1crY/QnwRv
 ii+mNQcgqif51xDIzgdgwc90DamqW45VubQmUgWEWT6ieqg/ncVrl1xDpx+W67ZuogeVyIW7m4k
 Ljw3Y4F+TozAHKd0dw6Rfq59QCSgzmJmd0fLD+5O+d7oIIk7bK42b8tBtHp02ucFaLawNZ5I//P
 nodbafxg==
X-Gm-Gg: AYBFou1s8NkDiCRiUImAoN3sf8nHsTUQPhIf0vnT1NpgBTIs6jnndvZ6KYLd48Lecd6
 DMyfWd4Q1LiO8NR3BUc8cRUdtuWns3Hp/ubdBxaCTcLGmoUQgDH0j4E0bB6wYKlOMMRsWbb//H+
 AJtPg+5FThoOyiKdYn4W5OtuHbemwElDjkwq2Glp6rs1rHwvWa0n74YBok4vira8UxahGTE0rBe
 7QIhvq8vlrU3mwnuHm11g77dMJ7jBOiTQ4ENbyY4/1JKEHMtr58vtcbn2Jrn/wU8Gxtp0wjR6rj
 bNDUOLG+Q3YC+MX+P3SVbokDx2wnzH+IzdWPpnvKbHk+zZBceQchYzWGbWF8cJWeR9N4Zoq+mFf
 l5DHGzrCEkVqvfPrXBRGFcK0A/rn6edjU2sQkNszAiazs5xp1MuqdNo5ZbBvoHpZjWEQOdmrs3s
 TiMXLS3BngveX9lQZtm8sPv7UBiL5qyiqVYgC0aM8nVd8ppyrEOwxKKfRfTAerzsZGkCrZbgw4Y
 SUIFERD5Y3nKO1v9kuXrpAxkIHKSQ1KH+doSAN0FGLQZQ/GmTNwBPHfoUJKZvUO2JhdG2e4fR7K
 3OSx712apSU5rKmCFfM9n9ZkTlxwV19avQUUvBSQk7/y5X1ievBuukHpi8y+9Clr/iJNUAM=
X-Received: by 2002:a05:6000:2dc8:b0:488:6dae:1966 with SMTP id
 ffacd0b85a97d-4887171811amr9674854f8f.47.1790339869851; 
 Fri, 25 Sep 2026 05:37:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a349731sm7309236f8f.12.2026.09.25.05.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 05:37:48 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 12:37:48 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id999691f74d291f4b902b8ca224a12d9bc7e6046
X-Gerrit-Change-Number: 1951
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1951?usp=email>
X-Gerrit-Commit: e93012164d7ab0476efc41aa8bfe034b40bbdb7c
References: <gerrit.1790339862000.Id999691f74d291f4b902b8ca224a12d9bc7e6046@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzM5ODYyMDAwLklkOTk5NjkxZjc0ZDI5MWY0YjkwMmI4Y2EyMjRhMTJkOWJjN2U2MDQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4a31763429c5d9cc656a62b31915f11da7524416-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA5Bc-0005IR-NX
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: multi: make
 multi_add_mbuf static
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6576836673324727298=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6576836673324727298==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jjBP8m7yuHM="; charset=UTF-8

--jjBP8m7yuHM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1951?usp=3Demail

to review the following change=2E


Chang=
e subject: multi: make multi_add_mbuf static
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: make multi_add_mbuf static

This fun=
ction is used only in multi=2Ec and can therefore be
declared as static=2E
=

Change-Id: Id999691f74d291f4b902b8ca224a12d9bc7e6046
Signed-off-by: Antoni=
o Quartulli <antonio@mandelbit=2Ecom>
---
M src/openvpn/multi=2Ec
M src/ope=
nvpn/multi=2Eh
2 files changed, 1 insertion(+), 3 deletions(-)



  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/51/1951/1

diff -=
-git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 3e72b92=2E=2Ec1c=
eb34 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -283=
3,7 +2833,7 @@
  * Add a mbuf buffer to a particular
  * instance=2E
  */
-=
void
+static void
 multi_add_mbuf(struct multi_context *m, struct multi_ins=
tance *mi, struct mbuf_buffer *mb)
 {
     if (multi_output_queue_ready(m, =
mi))
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 6cb86=
c7=2E=2Eac6cb78f 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=
=2Eh
@@ -354,8 +354,6 @@
 
 struct multi_instance *multi_get_queue(struct m=
buf_set *ms);
 
-void multi_add_mbuf(struct multi_context *m, struct multi_=
instance *mi, struct mbuf_buffer *mb);
-
 void multi_ifconfig_pool_persist(=
struct multi_context *m, bool force);
 
 bool multi_process_signal(struct m=
ulti_context *m);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1951?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
d999691f74d291f4b902b8ca224a12d9bc7e6046
Gerrit-Change-Number: 1951
Gerrit-=
PatchSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rf=
c2549=2Eorg>

--jjBP8m7yuHM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1951?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">mu=
lti: make multi_add_mbuf static<br><br>This function is used only in multi=
=2Ec and can therefore be<br>declared as static=2E<br><br>Change-Id: Id9996=
91f74d291f4b902b8ca224a12d9bc7e6046<br>Signed-off-by: Antonio Quartulli &lt=
;antonio@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/multi=2Ec<br>M src/ope=
nvpn/multi=2Eh<br>2 files changed, 1 insertion(+), 3 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/51/1951/1</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/=
multi=2Ec</span><br><span>index 3e72b92=2E=2Ec1ceb34 100644</span><br><span=
>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</s=
pan><br><span>@@ -2833,7 +2833,7 @@</span><br><span>  * Add a mbuf buffer t=
o a particular</span><br><span>  * instance=2E</span><br><span>  */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span> multi_add_mbuf(=
struct multi_context *m, struct multi_instance *mi, struct mbuf_buffer *mb)=
</span><br><span> {</span><br><span>     if (multi_output_queue_ready(m, mi=
))</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=
=2Eh</span><br><span>index 6cb86c7=2E=2Eac6cb78f 100644</span><br><span>---=
 a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span>=
<br><span>@@ -354,8 +354,6 @@</span><br><span> </span><br><span> struct mul=
ti_instance *multi_get_queue(struct mbuf_set *ms);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-void multi_add_mbuf(struct m=
ulti_context *m, struct multi_instance *mi, struct mbuf_buffer *mb);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void multi=
_ifconfig_pool_persist(struct multi_context *m, bool force);</span><br><spa=
n> </span><br><span> bool multi_process_signal(struct multi_context *m);</s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1951?usp=3Demail">change 1951</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1951?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: Id999691f74d291f4b902b8ca224a12d9bc7e=
6046 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1951 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--jjBP8m7yuHM=--


--===============6576836673324727298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6576836673324727298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6576836673324727298==--

