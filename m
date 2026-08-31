Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B4BC624CF
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2JXE2nXfGF1UPT77Tz2CSfH4uk34m/n3alF0jb+H2RU=; b=eeHTysLatNlQjzeYq9N5M83Tfn
	t8l+3mDYedKFM5osL7+3nKh3PtblmYkjoty4qhT022hjAPmPdR/W/oTHLp5S5NXNC/HrAo8tWVppv
	1GhSq1u5gxWLNz4/d5JESbdktkhmGUfGGLj7yLcu1pWNvpc87Oh4iynmF1SCbvP7fQAE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x15Z1-0008Gg-68;
	Mon, 31 Aug 2026 17:12:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x15Yz-0008Ga-T0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:12:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=SnY710oznNWvGtQkIfIiDTnYpNON3pvGk50EMrU2Hoc=; b=g3p0J4z4SXunFKtw5KVenAoq9I
 LKkNKsF6F1bCKYnG6OB+NBpCweD7ouPKVLbz75JmXo649fSWskt7Hg8js73vcXY+zutasCV8Me4fw
 ZW31VKEr05bq/kUYCknzJDUjS8irnd7jRjhhjaYgBGGso+4RfxYs/zKnsiKK1SJy6/iY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SnY710oznNWvGtQkIfIiDTnYpNON3pvGk50EMrU2Hoc=; b=K
 pqlZL/m2Hgq64TbmYqHfWd1Q3hq5d0kZT0MfBRiSyy7tN5oksaYyXlsFyBP64OrbF7Vm8c1COpy0z
 AC0UZ4TR68KVD1WOCwWhL/3rYt+iyqRIlMB9UeemaaO6i5ozJ9RDPvrfF7zop0Hlu/zk6ITIn//XB
 9urRRkIel/m8IgDQ=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x15Yy-0002Lr-9w for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:12:53 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49b9320423cso37086805e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788196366; x=1788801166; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SnY710oznNWvGtQkIfIiDTnYpNON3pvGk50EMrU2Hoc=;
 b=gpNUyty7K63Us4aW6dhZwDnub70f45E1DA6sE0yonL+I9/q8OrHxFE9kzc75AshZpa
 F7GLf6/eYrnd10zhKc8xiHbotCyViPM3dqDYD7x141RNbem30ezBOzboXo8xKWApNrLA
 ZsQEX8FlBhXMh0Wzdgy3m2YvIA0I/4K5cbhzdo0Pu2J9xRfJ2Oby0qEQ32KPEAAoiZHJ
 tVh1iuE7NG4Tl9v9en0DyPnWQybY1qrVrPUPM1YfT8YeS8NWpUlgl2m/jH84dyxUG3JI
 3BrNKJOiCc6iL3+a82WnBrxBs2BXrrGQTor0E/t/eqdpytluOrbK72qh20l2z4c4Oy/m
 B9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788196366; x=1788801166;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SnY710oznNWvGtQkIfIiDTnYpNON3pvGk50EMrU2Hoc=;
 b=clWGwjlY0z1aT2IKqZ0/y5X49wXHYnCEPPS/OUSMZbODdbHP0Yk5b9XjmlsZPzlCh8
 utlOmCBB4RbzjEZj8/9McUxxssM1h1q752vjZZF6UAGMTzmxaZxwXC6NPwyXxbk1TwLx
 9/7xM200uPAfLmTD8cQVWQEP8kPxeRHAHyHd+n4KUgfDRkzNznFSN+NlYdEmsi1XnetI
 agz5EoWrX3L3N9R3CwxYFzRRU9075u4BPtz/xM8hQLTup2LaAOU0DKj2rNkZfLfy6FsS
 /F3JyrWMIqzidKJvGFi5M4HYme0ZKUOI1uc/mUpvO5ggXoxeaHQrtXSRFbGWxEtXxli9
 ACJw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOD1N+R3QvOhR9RqScuQcTeupUP3JdSmh55iadSewGFT0a+ZAZQTzZAivNpMKcUTvmrGuQfbscmJlmo7Ea@lists.sourceforge.net
X-Gm-Message-State: AFuF++kfn9rSs7s7fgQ6M3ior5QfQLPV/i5K8KR8+rpu4uqOaAQLY6Xh
 KbTRz07VFnPEqjrNqiMZF0Kxkv9VNdL+PvSzPvcUx6Vch97bmItZtCH0paO4VKhSFA3vFtI3/p5
 vmWpIvoSyLerCR/Suop4+Co9dh9sqccgNHGcZHjRGUCyN6AQcaatXKcw4SXMrMwWn4HF5
X-Gm-Gg: AR+sD11g8eUIAYvaYRxRvfX4+vGrh/qG++tLHS6KBczO4e45zfxlyOzMMrLdG6QkaKf
 6i+Y+s1J3Kl8m1TnHTqkY0QGMxEjodiQmVni8GqiobszCx+tmke45FwCgAQkmG+E4f0oQ0I+sFd
 Q0eLlw2DW6wCkDdu9+b/i8jI8bWBHibw+/SOIVnvJfLwYfnsM0kX/f+osY53/hcS+Mw605vngRt
 e+mufN7k2eeAYmr7BNb0MPVfzE+b8D5XEln/yxbK7ZQpBJ+jNwKizr73yVUlyFNd/+hOCr4cmNd
 vphLtZFHYGnOkJNGrxu4bPeDNkGTmvsxJAzStcxvk/b03eLAsgKPcXI8hRDpDnaH2kl/GZwa0Sg
 iksAuDN8Lw4O+B41i2SeQtVtzVSQbpQ3KslwN/cyGOgLKhaUVYCGEhJ8OPfgE0EymX7XY/P+3du
 ItSH94YdnOvhekmc8bJSsf3pSgn6759u1OJt37Kl6DN4DAgJpxuQMww4ZgNA3BIq0aHwbfWhfMX
 ullJOql3oBqwNEULxTgMV8L2xgNJdGhrdTvWVRJl/osG03hNLW+/dAgc1mwaB1UitpJht6IC8JB
 WGcHVIlulC6baY4YcEUy1Q5yD45vh6+1MvjRJkH57iMXbngtOzzX
X-Received: by 2002:a05:600c:8011:b0:496:bbce:fc with SMTP id
 5b1f17b1804b1-49cdc5660bamr42441685e9.12.1788196365604; 
 Mon, 31 Aug 2026 10:12:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48432022ab8sm16984387f8f.28.2026.08.31.10.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 10:12:44 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 31 Aug 2026 17:12:43 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
X-Gerrit-Change-Number: 1885
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1885?usp=email>
X-Gerrit-Commit: c2db629bb5909a15c7408b3bca7971dbc3c8b1d1
X-Gerrit-Comment-Date: Mon, 31 Aug 2026 17:12:43 +0000
In-Reply-To: <gerrit.1788192180000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
References: <gerrit.1788192180000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTkyMTgwMDAwLkkzNzFhYWZiYTE4ZDMzNmJjZmQzOTEyZTkyYzE4MzAxZTM5YmY2MDg3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7ea81b0e09e3e08ea6624709ef230e95a147b159-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x15Yy-0002Lr-9w
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: don't
 allow '/' in config paths
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8566738354016276801=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8566738354016276801==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UcqFpX1N6cc="; charset=UTF-8

--UcqFpX1N6cc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, d12fk, plaisthos=2E

razvanc h=
as posted comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1885?usp=3Demail )

Change subject: openvpnserv: don't allow=
 '/' in config paths
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1885?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
Gerrit-Change-Num=
ber: 1885
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
=
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <g=
ert@greenie=2Emuc=2Ede>
Gerrit-Attention: d12fk <heiko@openvpn=2Enet>
Gerri=
t-Comment-Date: Mon, 31 Aug 2026 17:12:43 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--UcqFpX1N6cc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, d12fk, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1885?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1885?usp=3Demail">change 1885=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1885?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I371a=
afba18d336bcfd3912e92c18301e39bf6087 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1885 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@green=
ie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12f=
k &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@openvpn=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 31 Aug=
 2026 17:12:43 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</b=
ody></html>
--UcqFpX1N6cc=--


--===============8566738354016276801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8566738354016276801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8566738354016276801==--

