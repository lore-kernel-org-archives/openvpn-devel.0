Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6EDCA5FCE
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L3xbxw85+vN7yxvgH7NBjMg3dEpN3Vt/a0Q92z4GTZM=; b=UouwUvZ0phSdOVYSvhQAZInspb
	+a8tWJMqd+IHNy+GyL0qIvBTb8B+MuNKRyZRvXR32OxM1pOXjlqDfN6DuxPJMtMOzboryY5QhQMK/
	rRSdPVOpeG77Z9zfeAd7/r+s5O2bdwOlJL9M05IhF+le4D5pjPiq42ksnPXQA8YoGB3g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDJ1M-0003ry-3X;
	Sun, 04 Oct 2026 10:00:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDJ1I-0003rb-VP
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 10:00:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wJDZuJEoFCWgZ5SfwZDiA7SCQkmlT3YaT84fheGUzoU=; b=fYV5w7bo0GBcwF1agpzTnbTyAr
 8QaW7MN8J9DZ+qWrIke1t7zvP7H944c/SOYtC+KgC91my+gVa8mTtLLdfoKsQjMo6+lFp9943JFs6
 5RVs6e/Oito2OJCcRB0pLjeRZ3tL1iPEAWB/7h5VCeiLJZy9wP5cRSbhl7aLGg9Sidfk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wJDZuJEoFCWgZ5SfwZDiA7SCQkmlT3YaT84fheGUzoU=; b=A
 E1gQwSN7RUdv7yLMLGMgfp9fb12WQ34lZxksbh4lIIh8xLvJhBc7dbUPilqSWwj1eIjObDG0NFUAS
 Mn6PG04S9VlHVE3dxd6QzI2sudNvAu4yHIipek7jzsKCcCkkAeEpfHHQaMu4U50MC/G/UDgEBGIM7
 g4Cyyry6fNA9f314=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDJ1D-0003eK-6u for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 10:00:37 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso8411535e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 04 Oct 2026 03:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791108025; x=1791712825; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wJDZuJEoFCWgZ5SfwZDiA7SCQkmlT3YaT84fheGUzoU=;
 b=I76NcmYvZnhYhbc6KjGhEHXg98pgou3LZCnpWHCr6YUzw5QczcQnf5v00ALuwswDcv
 VVhwJQtGFN2F79Ezu6QpFO7pM/beL1Fc3FJUNCZFhPu/x886FQ3qQxcIhDhgd0R9mfUM
 hxsVoLdz/vMlmHCMBoFvaR+gCNA5887DieRZMqQbmSxWOJo6dsXzVeWQREg4Rfac8ukd
 lUgkeo08Lc6cfi+dowbtomqTbP7YIIkPl2nDD90hcvToIL5XAa3k3qnnRB6iEOfhj2Js
 +5jFcNIBuV7/BGNijEk/q7kvlwe5blZeMfFWYlYt8m3IpGt78F+JzQh6wBHjgH6TbbHR
 EWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791108025; x=1791712825;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wJDZuJEoFCWgZ5SfwZDiA7SCQkmlT3YaT84fheGUzoU=;
 b=vXqEQuFV8V7pFBmqew9UvF9pvewVHcXbQouwWbEY3cDD4wj7Y7Ba851BBs4/OvIoVq
 7KQ38j1m4Kpx3x++rN6PD+phprMUmGJBc5OHMqO4MrQ2tUPBlGGwS4ae1UBjC4KbvJvq
 vTSydd7D6rfeqfpMUCoQNWeNxedqPri6RmghyM8OPXEigY4VGnj4j7q2oGDu2Ihd8GjY
 PAZW0UD6Ps4g/w5ws99L5JXGfZkcFKm8sn3YrZUJwj+SUsiWwB3A9Z62fCWS8DjdeBgv
 lDc9zxV6DeObtxmrlv6r8omO9ypBMpaU9TQu92WHCP7HFO3mh+FyDi6WwYDAkr8J5BIb
 dk/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaygICZGLhNgcfUzS68kpy3uJTuGKLkeEf4+fAsYMEmNubV+1HZNu+Sw7IZBwbpOjVais3sa1qr5bMaR8x@lists.sourceforge.net
X-Gm-Message-State: AFuF++n7F0IY8ujv5uylvMY1GczAMFoVZvM4G/0JMkmCgxzjECJS1EsI
 AVVZzOCzkdtxNrax5d3ln1nUPro0xaIMBGQ1cGuk0uogywC8skrAsaJpNU8C9+N1acrCckFDn4g
 h3ozt62CPHqrjPKnZb7gJJHT0imf5tQfafm3r0atChGhf+dWD85NKnW2xiK5l6cyIQR6iR1p4Eb
 zlXjY6rA==
X-Gm-Gg: AYBFou362C5Bfr0a+LR2G4XBMCTZ6MVko2QWwbr6kH0rwZ3u0FyBIfOotmPg48WNHgX
 PTdC4wM8cjy+Oc8Ew68J6CAJVfafcNlr7suM2AIeL6S9MkBar2f90v979JU6a0yaIHLT5bxm1HB
 rOyneiEzzF9VQGFQHev8EjMhTb1E3uqtJlQ1nFET0rUCc+Wcp+A4+64M9E6HQVTEPjIqNf7qpcI
 0yY36nkBTK0iI8FlH0K/nb0OSgP2gj/W/IQWNDsrjjI3CkOo9YlKxSvCHUQdlh1aS+jJ43aS7b8
 MIEfa8QufEZ9g65/EsqGZgidPxidCmX8LTq9K37JKIM412G6zKm0O9T1JttCxj24CTcRRlW7Iee
 QSG3GAaHTb8XWdz8lW9aVRNcNWdnbXfcUZPdV5abVRSz3YcOnqsnmZZ7hVfS3HIXBMMO9mZdkhK
 SqCjlUPmyKWhh6kwI29WaSjnyTGfIyoCDbuPmQYlQgxKJo3iws7YQLa+5O92CV1wP73JF+nskbo
 q/nBZa6/1MBCumN0n2rG9MG9ZM40SxFlrZ/Go0AvTVzGKShdFWjaik3v7KFSFqjE5deO/Mam8Tn
 zxeA/GYqGlgv958oInRUnIijYoMJKQ84cH4wmK8u7zAjqBjLXOOl99sdDCS0
X-Received: by 2002:a05:600c:8b82:b0:498:943:ccc0 with SMTP id
 5b1f17b1804b1-4a027566388mr136749695e9.6.1791108024558; 
 Sun, 04 Oct 2026 03:00:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380faaf9sm18312569f8f.22.2026.10.04.03.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 03:00:24 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 4 Oct 2026 10:00:22 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
X-Gerrit-Change-Number: 890
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/890?usp=email>
X-Gerrit-Commit: e064870a823d64266e703fb724cb088f366f593f
X-Gerrit-Comment-Date: Sun, 4 Oct 2026 10:00:22 +0000
In-Reply-To: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
References: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzM5MzYxMjA0MDAwLkkyMmU0YjczZTc0NGM3NjVhNDNiZGIyOWY2ZTE4ODEzZDEwM2VhNzU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <87a017a178228da58d3d7e1f13cbedb73529a886-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDJ1D-0003eK-6u
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Always use a
 0.0.0.0/0 default on Android instead of def1
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2533178023474185720=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2533178023474185720==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ihrFHutuK7E="; charset=UTF-8

--ihrFHutuK7E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, plaisthos=2E

Gert=
 Doering has posted comments on this change by plaisthos=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail )

Change subject: Always use=
 a 0=2E0=2E0=2E0/0 default on Android instead of def1
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I22e4b73e744c765a43bdb29f=
6e18813d103ea757
Gerrit-Change-Number: 890
Gerrit-PatchSet: 3
Gerrit-Owner:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sun, 04 Oct 2026 10:00:2=
2 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--ihrFHutuK7E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, plaisthos=2E </p>
<p>Gert Doering =
has posted comments on this change by plaisthos=2E</p><p>Patch set 3:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail">change 890<=
/a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I22e4=
b73e744c765a43bdb29f6e18813d103ea757 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 890 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Sun, 04 Oct 2026 10:00:22 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: Yes </div>

</body></html>
--ihrFHutuK7E=--


--===============2533178023474185720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2533178023474185720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2533178023474185720==--

