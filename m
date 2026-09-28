Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9F7CA5FA3
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eOf33fqeco8q97zP+nN9w2qRMkcdB62zrdJLwRVsLtU=; b=OG1iSZyyGOEkuHBoYRLmBHkY77
	zl17O/OmkPXdDbLWxq+Tz7ZkKbacqZN1iG90q9hD3D7sxpomt38KAqOLdyMXfONkC06CwSrbA8O3u
	mQ0j0FegTH9y3mpGEDn4uftqdk+SyoUBt5MiB57vF1WqGoLgZnQIKFecnFqHiGP0eMIE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBGYj-0002SG-OJ;
	Mon, 28 Sep 2026 18:58:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBGYi-0002S9-3X
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 18:58:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HJXzQ1OUF9hWzp/CFoNdo2aCtmLau7yulWk0B9Ix398=; b=DJ1CY6YweSNYfT7iLoGo52cnBh
 w+LUaifV/8Ej/bTbFmbM+blOP5UG4nqy9z2HSMs6oDJb5xtqjZv4rG+0AmatTBFQjVK5dtTND4oZ0
 uQ8Q09kEC7z06+Uz6mcegU4lOhVs0rdD0V0dTmqYL5kk9fAKOYHEWlqpZt6RuqGEXIFo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HJXzQ1OUF9hWzp/CFoNdo2aCtmLau7yulWk0B9Ix398=; b=e
 ng+ydK32Gvk7RZTbMY3LbffqByQEn2OX0ELtCx8EtZArwICsVFQZWQ/u56RFDP7+AK9IMRohKAhHT
 GlLqaNON7qAJgOLDAG3ZMfLHL7I0SwogXgiLsPGY3XidotIkjBbvwVBK9BDCowGlJaS2NlLxpq2/n
 dUGxN2Ke+e+SwsWs=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBGYe-0004jw-O9 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 18:58:37 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so2024806f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 11:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790621910; x=1791226710; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HJXzQ1OUF9hWzp/CFoNdo2aCtmLau7yulWk0B9Ix398=;
 b=VBgwjhPH99HTiTX+jAFhWKT/+UdKRpDQkn731gJfeUoFaEJSSlVEdKziNxq+Y+LYJv
 T3MoloGtf648kwIqcMnbQtVa+hz07xWOt9MiT1vkyOSIxFMo8Fgr21iDSsdCst3WqCCV
 OG4ryVTwZCYHl4dq2FuezU8CI008a7CubuqQeTdeOud0T5SjasTQ8Z30tyVf21tW38PE
 2GYOANhbeF6zjHQH1x1xvT2L6JVaVhn3jqWNQOUQxlo6L6kLiIQgNm7AdpQtfQb3Re2j
 2FnNK7VZx39MDS8+Oip3DPL3Oly3ab6q4LjkidoXZHEF3MnIo+q7mbzaSpec5h1nrXdW
 RDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790621910; x=1791226710;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HJXzQ1OUF9hWzp/CFoNdo2aCtmLau7yulWk0B9Ix398=;
 b=ZSg0haHsB3eWP0Jg4saoZyGAzu648zFW3iJVdeeNWbwTg+xed4UXpuiX8cFKK3qHyo
 N2Wjw9Ee72t61J35w1WKhTf2BjZkSwUfx/VUmbxSQ5A03BCUHUFB/JzddE9aLYcGtqIP
 Ka+0qAeRKppMMhasSAI2bmbvcWYDwNeYJJWY+BZvvkoVe6uWp3n12+vvkDG0fbsl51oy
 OlcfpmhlCkvQHcNKlKNywKlfB4GA6eJmyvAKlwharcybR//HYpKfyhCBlOXdkP5RR6ZN
 /8vKwfvkZlJ6LuuDxcOZ1QQsWbkwO9GmHzA7i7HMqM8ItNxcSynWrfqxjHhhsQa8k1Al
 zMvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy30N19PPkxSAJxSH/5SCkYA/TWwSlApgl5aKKhKhU+jqPGtyECRHCIN0GxQiBYYZHRrORT+rqBpuqM/EHE@lists.sourceforge.net
X-Gm-Message-State: AFuF++m75vKKnApY0ON3BG5I/0UnVMEGp9SFPlONYpBMnjKa0DsSAaeY
 VW6OmRLtn1gkB0taKa8NlbrBO87MIta6UGD7ECfXeoCG8a+AYTXiwUkdXP+leESkzdVpSemydL5
 ec9ic4WROc1/HaqvujtWc9rK/9h1ohVWTtTHe8+YKrVsiTEq5aAW6bUYrvZlU001vGVAh
X-Gm-Gg: AYBFou3TmvODooAcfC+sicRujSzutfKfl3qKyMm8YfjXez0MP1F7QkPANLaCnmOOlyh
 PfmrvV61FmLA3alv0EoFakkT8tf2ipZbK+8aKUID5B4aLQu3OmN5AvCF9oieWVKq/gSp6R23C+H
 sk7cuwXkWB7dDAxMiLyjM/JkC02xzvkPrZ2a2MNXedcCIRHQANj3jC4EtG1vIGI5e5zMGsr4uhn
 L/rWb1TQkCqTgQJAMGQ8tNMWcBAbEh9wGciPC49+doEJkBVBdSvvfZHWUKFHuuh0eSU02Y1Lgnc
 G+VoAIYr+C4vKMdHpYVES8diqbIICIs+NgGkMC3qkKfoNeS3Iihan3h8i0T80AM1TXErkhMyVVO
 A9T1WWb5Z9WEU4z8wSzzAptr6AftYsLm8ubZnLIuSNigseSRMpGD/AHS4qV4xThC1XqPe2n+Yfz
 iDkpt7Qje73eCpUWyWBCJnwKBd3GUU9rkhfp+Hav6uGkyzz5i9sKZfo7znO4Q+yMfo0cWRQ/wai
 t7UF563xwOgQBVuoXz5wGymDxxMA7KB5rhtoCQUjbcPynOKLackGNXh39x/xHZALAVRWF6vhRyO
 kvOOcKyICbOHtHkyKg/ko3my3W52RvIMefV7/FqiXcIuzukIdGVgvYAZiNtO
X-Received: by 2002:a05:600c:1991:b0:49f:ffef:1db with SMTP id
 5b1f17b1804b1-49fffef0280mr100106395e9.4.1790621910063; 
 Mon, 28 Sep 2026 11:58:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf9b5e2sm20461175e9.8.2026.09.28.11.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 11:58:29 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 18:58:27 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib69b6c7a5f21f8552159c94560830f182c6238b7
X-Gerrit-Change-Number: 1963
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1963?usp=email>
X-Gerrit-Commit: 1b96c0f91875317822c953a905f38c2daf635294
X-Gerrit-Comment-Date: Mon, 28 Sep 2026 18:58:27 +0000
In-Reply-To: <gerrit.1790613679000.Ib69b6c7a5f21f8552159c94560830f182c6238b7@gerrit.openvpn.net>
References: <gerrit.1790613679000.Ib69b6c7a5f21f8552159c94560830f182c6238b7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjEzNjc5MDAwLkliNjliNmM3YTVmMjFmODU1MjE1OWM5NDU2MDgzMGYxODJjNjIzOGI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0dafc187f5dcc05b374cf019599c61455f19a95a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBGYe-0004jw-O9
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Fix (almost) all
 occurrences of cppcheck variableScope
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0750527156284214777=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0750527156284214777==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tdxdUmwZPc0="; charset=UTF-8

--tdxdUmwZPc0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1963?usp=3Demail )

Change subject: Fix (almost) all =
occurrences of cppcheck variableScope
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1963?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Ib69b6c7a5f21f8552159c94560830f182c6238b7=

Gerrit-Change-Number: 1963
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Comment-Date: Mon, 28 Sep 2026 18:58:27 +0000
Gerrit-Ha=
sComments: No
Gerrit-Has-Labels: Yes

--tdxdUmwZPc0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>razvanc has posted=
 comments on this change by flichtenheld=2E</p><p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1963?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1963?usp=3Demail">change 1963</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1963?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib69b6c7a=
5f21f8552159c94560830f182c6238b7 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1963 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Mon, 28 Sep 2026 18:58:27 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--tdxdUmwZPc0=--


--===============0750527156284214777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0750527156284214777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0750527156284214777==--

