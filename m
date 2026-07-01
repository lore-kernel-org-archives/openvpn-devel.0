Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C645C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 05:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=1oSqDACc8xb/0O121Xc9Y1Sfx7AyHS03icyp6XGvLSk=; b=aCe0NsaWKKLeDG
	tdhuwBl6uzqZ5RbByzvHKxVxSJUFmappUy7uE4wK+nZwl3QOEm0ieQFFyR+2pZxovs2I9zQJTCVul
	aufWRL8VtIFoT4zjil6N8JihVvsz2hIQrf3NRXdqxT6y+d562/4Tvx4HpRZxtTDTsVGRskEwpfSzF
	oR8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wenXp-0003pk-QD;
	Wed, 01 Jul 2026 05:31:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wenXn-0003pb-JI
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 05:31:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GtxnK6ILR0aYRJIs8rIIwMBVUM02XISGZ6ZG5xZN7lg=; b=WwUHwA9uOrh2RrEjq8Qx+uqKtN
 TRVaNnTmXXIXdd9ZNjdgHqzW4FF4rWNazXmhZmiPuj0nF/X0LE6TAO5r8xAPOdmbOJZM0ZR+uCQMy
 u2JLUaF10WpsfpzHKWzl3a1vY/4rcM3Boe53Uq3/JM3LHitzBoK9DAmvSLnHDwalGxtI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GtxnK6ILR0aYRJIs8rIIwMBVUM02XISGZ6ZG5xZN7lg=; b=N
 7CB17eeO7lZWr/jMi5tRBxMq2rVurNPqI6CmuUHmvLeJ+S7PfI9VtZIvnePYVxt9ncXWtf0rsQAF0
 cShqXNPHglQqYJ/VJtwbRcjNei3ndtgDyZnWWYpq7en4SrZ5EwHmHOhs8r3Hb5Pxdp3LIUgTdsyfC
 +hfPpiTvhrcelDE0=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wenXe-0005aq-RQ for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 05:31:31 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so683895e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 30 Jun 2026 22:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782883872; x=1783488672; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GtxnK6ILR0aYRJIs8rIIwMBVUM02XISGZ6ZG5xZN7lg=;
 b=EbWd5jG5DEqsJYIRixvxdhD9MsI61GhIlWwAZ3fxqnaVbKjpaNuy+N7LhVxt5LR1Yx
 jIzBjf5aNJYwoHOfZwxAWBeTygL0gnz3ghSX5K8WGzuqXvcBye74oTZxRkmPlhIH38S7
 SSredHIsQOUcKx3f8GWZ/HpxMee9+oAUxXKfDne+4rMQwqB6bfoOtHQxpu2eberX56+U
 oDJGI6k5Pb8SjADEd8wkKEy3diPPsSX38zrncC3SOrQI7koc2t+3yqbFuhTDvlla2osO
 kc6vI9rD2iDzYi9Y838a3deNuq8KOGQzqObVc/4+Q9F0NxS1nCTVUaAg33j5y7sv59ET
 32qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782883872; x=1783488672;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GtxnK6ILR0aYRJIs8rIIwMBVUM02XISGZ6ZG5xZN7lg=;
 b=bMP+i5QZZI1m2r6E0HdbrTYzdanfNKDoPEpNuW6RvRxMQGz7W2UDCBxyStc+J9ITTR
 93sBG09BgPgSWTLGfebTyNGo3zX7CANOSJ7K55JYfoi5NnyDnPQS3NmLfWaAtgRZEkZw
 DrDn3E5UcaR98qSCYq3yvy27KsHeWWBySzM3rQmxmdlLbQGRMHwRYM3HMx5Ig3N4lqi9
 CxdjBPonTGJ3QPp0EXMe1s9WyhjCdX0bqQmaBfdV+qvbqkBqqeDbTp1V9U5SltKkPgKm
 bSclcv/K6oGUiGrmhcXHaySjHvXPV8jui95e7YQkDfLRP0hs+/g2e6UZKzmWVPQFcvys
 6LZA==
X-Gm-Message-State: AOJu0YwNcf7sXtRKHdCVzF//ggb/f3NyfN+iwIH+NrA1xvC9sWbZjJ16
 bRjZ7KobaQ3rUgt9mBSLlwfycTudb1+oFB5yxDmmgBO7Aac63cty0cQTWlkkJK/aXloIQAAfuJH
 Ez+J41qtVNoL7mZZhN5Wk9YEpbKWHMC/JDE1BA4i4GYRtf7u5Dgrf0aIH8NND3fug+cqwBEGM2d
 d/c/rEwQ==
X-Gm-Gg: AfdE7cnZkshrsM9WQFR2L/ARVO9sIrbcgm6eS+dZ1f3NQDwGbKDTGGKsZajrzFZeDOL
 YXl7QlxcWKb5VzuyPk+KoZxXN+mA4iLS01W3BsVQwEqSeqBIPuv9eF+4ZLaH5hLuURVz6ewzvyr
 mvMf7VgMmoCYOdDlMUvhXhNsUIUNQFEanqppApAVwytw51rSliZ5o0Dk2r7s4GjrFnhct1sctt5
 kygZJ6p4RvbQj9CXC07OxKvqvON2CSqqP0HeeL0p/jCryWAw2Dpkv1/cBA1lqPTMmnmJftiDEI5
 osLhTg8x+2yQ1MDCWrQGNpydz0pSr8cRw91oPxY+9HwbhaKveipkC8no1nYRgDd8cie9/CpsEIk
 y3O+bwinAw8nmiy0Y3fOnSRV234Lk8og51JIAL5y2T3pgJMEuSkE5OQfUNA1fqLil9sY/CTw686
 KN8NWJOkMk9DvFy8wH7e49odq1rgU5cdCsbqT1i+ydAzJs2VUQDkupG09sn5mJWWJoybi0Yt10s
 vGqrz+hzTNIeRx+oZOYKJwEacM3oaPAOQFj+QPdI7pKzowa8jJf6DuUCxvSVBFsNHnjKRAt2iBY
 YP4=
X-Received: by 2002:a05:600c:190a:b0:493:c068:db11 with SMTP id
 5b1f17b1804b1-493c2b94615mr920915e9.26.1782883871697; 
 Tue, 30 Jun 2026 22:31:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4dd77bsm45667225e9.10.2026.06.30.22.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 22:31:11 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 1 Jul 2026 05:31:11 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id8945dce437da11e6fecae9550c3be52e393d4cf
X-Gerrit-Change-Number: 1760
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1760?usp=email>
X-Gerrit-Commit: 14c1af739c6041b7e516c1aee425610d4969cc11
References: <gerrit.1782883869000.Id8945dce437da11e6fecae9550c3be52e393d4cf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODgzODY5MDAwLklkODk0NWRjZTQzN2RhMTFlNmZlY2FlOTU1MGMzYmU1MmUzOTNkNGNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <54ab5812338830b3921ff7270c57c8b193291aeb-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wenXe-0005aq-RQ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco.c: fix argument
 order in dco_install_key() log string
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8256263344931619398=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8256263344931619398==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dAo9+CTzQJU="; charset=UTF-8

--dAo9+CTzQJU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1760?usp=3Demail

to review the following change=2E


Chang=
e subject: dco=2Ec: fix argument order in dco_install_key() log string
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco=2Ec: fix arg=
ument order in dco_install_key() log string

The debug log in dco_install_k=
ey() has the epoch and dco_keys_installed
arguments swapped=2E So a line li=
ke epoch=3D1, currently 0 keys installed
actually means dco_keys_installed =
=3D=3D 1 and epoch =3D=3D false=2E

Use the correct argument ordering in th=
e log string=2E

Change-Id: Id8945dce437da11e6fecae9550c3be52e393d4cf
Signe=
d-off-by: Ralf Lici <ralf@mandelbit=2Ecom>
---
M src/openvpn/dco=2Ec
1 file=
 changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/60/1760/1

diff --git a/src/openvpn/dc=
o=2Ec b/src/openvpn/dco=2Ec
index f5b7081=2E=2Ee944547 100644
--- a/src/ope=
nvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -57,8 +57,8 @@
 
 {
     bool epo=
ch =3D ks->crypto_options=2Eflags & CO_EPOCH_DATA_KEY_FORMAT;
-    msg(D_DC=
O_DEBUG, "%s: peer_id=3D%d keyid=3D%d epoch=3D%d, currently %d keys install=
ed", __func__,
-        multi->dco_peer_id, ks->key_id, multi->dco_keys_ins=
talled, epoch);
+    msg(D_DCO_DEBUG, "%s: peer_id=3D%d keyid=3D%d epoch=3D=
%d, currently %d keys installed",
+        __func__, multi->dco_peer_id, ks=
->key_id, epoch, multi->dco_keys_installed);
 
     /* Install a key in the=
 PRIMARY slot only when no other key exist=2E
      * From that moment on, =
any new key will be installed in the SECONDARY

-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1760?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Id8945dce437da11e6fecae9550c3be52e393d4cf
Gerr=
it-Change-Number: 1760
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@man=
delbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--dAo9+CTzQJU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ralf_lici would like plaisthos t=
o <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1760?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">dco=2Ec: fix argument order in dco_install_key() log string<br><br>The =
debug log in dco_install_key() has the epoch and dco_keys_installed<br>argu=
ments swapped=2E So a line like epoch=3D1, currently 0 keys installed<br>ac=
tually means dco_keys_installed =3D=3D 1 and epoch =3D=3D false=2E<br><br>U=
se the correct argument ordering in the log string=2E<br><br>Change-Id: Id8=
945dce437da11e6fecae9550c3be52e393d4cf<br>Signed-off-by: Ralf Lici &lt;ralf=
@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/dco=2Ec<br>1 file changed, 2 i=
nsertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/60/1760/1</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index f5b7081=
=2E=2Ee944547 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><s=
pan>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -57,8 +57,8 @@</span><br><=
span> </span><br><span> {</span><br><span>     bool epoch =3D ks-&gt;crypto=
_options=2Eflags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer_id=3D%d keyi=
d=3D%d epoch=3D%d, currently %d keys installed&quot;, __func__,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        multi-&gt;dco_peer_id, ks=
-&gt;key_id, multi-&gt;dco_keys_installed, epoch);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer_id=3D%d =
keyid=3D%d epoch=3D%d, currently %d keys installed&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        __func__, multi-&gt;dco_peer_=
id, ks-&gt;key_id, epoch, multi-&gt;dco_keys_installed);</span><br><span> <=
/span><br><span>     /* Install a key in the PRIMARY slot only when no othe=
r key exist=2E</span><br><span>      * From that moment on, any new key wil=
l be installed in the SECONDARY</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1760?usp=3Dema=
il">change 1760</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
760?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Id8945dce437da11e6fecae9550c3be52e393d4cf </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1760 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ral=
f_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--dAo9+CTzQJU=--


--===============8256263344931619398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8256263344931619398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8256263344931619398==--

