Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9345BC44506
	for <openvpn-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EzIBYX5QbOULwA7XfjZQ3ExY0/vRlO/f4ZMYOX/FJXk=; b=kIE4WrTxMhjiAjeZ6Cap7a326W
	KldLW0cfhfGSJZlQUnF7yT/TsvveyTat5vBK4HskQsm1ycL2EgCnN3EzWDkVnoMQALNMRqK8ty/w1
	rSQ2meL+nMEmwZF7K28YInAoz7SMt9btKmUlovp7p2izk5RpJOCFZ8Zpfk3Dgm4Tej1I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whlg3-000689-G5;
	Thu, 09 Jul 2026 10:08:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whlg2-00067z-Nq
 for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 10:08:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ayGn02yRVFkOfVPH9ZveyXWdGjTTGWM+JAzKLz4fC/c=; b=GUagZXglKTRI5bDuPrdkEmcfQk
 oAr/VEeehJ+KVifwUbEeALk9NWyXlYNkWSIHEf7XyMDGjx4bWgNx57cUKa4nO2WFyXgRcpeDSbELN
 GuxIYg18f9bDuQGgtOJyVY1STACuJ5m86HFTGAAa5EWn0lh2xhjjC62Nj1MNaG8MD1p4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ayGn02yRVFkOfVPH9ZveyXWdGjTTGWM+JAzKLz4fC/c=; b=B
 XA93UGhpXVlI2RTYg0BKazYMfrShFmgzN858F2IcKcyEDzhUAFeKl9LCENcPpcJo5CNcz+ppWOOm2
 gKCMa05odUhbdwhWmyKOu65FZ3vY0WWFL36m1fQ8pbHKvHApN9Rgt3dRCdCNvUTMrOLO/LTk7miRn
 dZ7htW4up0pvUUoI=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whlg2-0002JO-40 for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 10:08:19 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493ce08a75bso6836415e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 09 Jul 2026 03:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783591691; x=1784196491; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ayGn02yRVFkOfVPH9ZveyXWdGjTTGWM+JAzKLz4fC/c=;
 b=FuRpwWbASRDLEft+GKzkY0bjeNiXtUYI4TMPsI1prpTmsfOeXn03XaPbJp+56dTnHI
 DRhx2z+4Dw37eO8tPMcOgjdmgqnQy0J/N3hTRXAiWHHL6JRZpxhtZ03KV6xkekabj8IR
 FB0qakq7zFY0o/TB8buwiSweOa5cmkSzPGFUduIAk/BxIgD98jZeZnlvtJqUAVu9addf
 fBH88n6Go/9YxGeXxrTMRDfPeWqrAoEpF90M9I+ZZqBom+i59PSejnpl0wS+WwXuOqmI
 w2eU4XW+gWpksQssqGDjzcH6en2m13vVeQ6MqnTEBLT66OBltYDcDoXmuEfYMGTJvdKT
 rFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783591691; x=1784196491;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ayGn02yRVFkOfVPH9ZveyXWdGjTTGWM+JAzKLz4fC/c=;
 b=jAGhsSEepFAqVLvVjRK14PAsrLl9WApct+JXB79JlcPEOAsGurJQL3mP9/FbG77fdo
 21cFgD4oPwsDQXCNiaVh5ivR9bKo2OcPX7Umu8+Dlj1ZDgREA9f8xo9ViiJaKiGYl95r
 28JW5HPkAJehi5wVC+pjFxWmvtcCkejlc0KF39rBQV7day9KWRqL3XGaa6QQyiEkxwHg
 4MY0ioW6YFoTvg4jks9g++XZXlaQDM6qH17oRjv8g7nT9lUsNpDuL21OVezYawIv5N3b
 nU+tAVOhD9VA3c/wFi7z8rJWsqIWynnKlXpPaIc/cEiNQ5QDjaip/3aP8xEWDqgn/5+y
 h5cA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9WLU+k0tA5fwsEsAUlWoGE52VyolZMT9kBVcy5RL0++EkO5mp4u+3ej22fXD7zQ23A9OFN750SBi89cha@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyTHPkAneWb+weK/nOjH0/9XW2QVW2wu+KI5uTKaKVvLRLvgXDv
 dPnm2XxanMnQVS9S1kpVJv1wRgVVD4yPzr4NITf7rvE6NljBcfphm+mFTYu+d3fDQsNGV2q9yyJ
 ViJbKcMFJLF32XoC9SV23rCWpnfqtx8UPgZNAm6TXM+N6gkysSaG/ZGnnIUv8LW8lwJ/0aD/cGo
 msFmvGJg==
X-Gm-Gg: AfdE7cmYKW2Njj740Rri4sv800o5aVuC7CJMyHa9XmgsmQauZCgYT4eRN0ItMQ922ou
 W9aR/Deteibz/ssKxjQdFBmNn70BHEoL0WA/k9vhYFFtFGKBkQ3XjTUZjFBNlpvwxi0Ks6Lp/RX
 FiZdEHjX2WrTkhnq2tygrhVuoSDIBl2rtcz+gbdL8fAPnDHdKtjsFNrA3Dj3GrQ3O9elbsmKFFk
 uXifmtTbz00/BBJ9+bpWUwJi35mT9Xg38iGlGo6dWNaysMWL1+9WosK/BtSD9aEE4fsyxlO0U3u
 3K6Ih+ix9z8QqVK6tsTAjN+TUslD+kWbWAkzydCC6mwrG24g5kVyXmeKxtL9HYdMpREJJvIPUvL
 vIpSfrWWJlibQKEzucCSyXzD7WjiDuEOaWPDJCa3icWL76c8qg8FDq6QY4fFLkDLV/GwvyupjY3
 wk5bBHHhPe09ObrlV3fFT9Icuh8IeDc+P5hM3aK6KtaC7Rtr9V39R6UJ2VFyHMjcXzJ5/pvaLY4
 VNqUiOyG5YyYF7VCRVeVbq3ZgOwMYhKPV/sO6YNsAWtXcgqehZtqlbmgqLtKX0yxnVUuTUdF5gI
 tECpByQFuiIceA==
X-Received: by 2002:a05:600c:c8a:b0:493:cfc8:12e7 with SMTP id
 5b1f17b1804b1-493e6874216mr63536205e9.25.1783591691389; 
 Thu, 09 Jul 2026 03:08:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e5a572c3sm142843625e9.1.2026.07.09.03.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 03:08:10 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 9 Jul 2026 10:08:09 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: c0c4c8c7a403a33c6432af04dbcc01428cb751e1
X-Gerrit-Comment-Date: Thu, 9 Jul 2026 10:08:09 +0000
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1e4d0df5bc7464ea976605ff5ddeaa8a13144741-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whlg2-0002JO-40
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add client
 PROBE_REPLY parser
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0462015970621981134=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0462015970621981134==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zmG06uU6pq0="; charset=UTF-8

--zmG06uU6pq0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1745?usp=3Demail )

Change subject: oob: Add client PROBE_REPL=
Y parser
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 3: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1745?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
Gerrit-Change-Number: 1745
Ge=
rrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewe=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Thu, 09 J=
ul 2026 10:08:09 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--zmG06uU6pq0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 3:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">change 1745</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If04ce09d=
4c353f5384c0c48f48f63e05869a373f </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1745 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3=
 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Thu, 09 Jul 2026 10:08:09 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--zmG06uU6pq0=--


--===============0462015970621981134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0462015970621981134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0462015970621981134==--

