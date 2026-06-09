Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC679CD8CAA
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j2iUB4HZmikiPHYT4KJkoK3lgYAnnrm5lbCKSILCBy8=; b=D4NvW0PvmWQbVZe4TPpNo2m1ya
	sQdleRCqvgA4ZaLgyOR0OnsWRT3McXmTTtdNaebCop9y4Ll2gGXz874Rq411AkqMInJhxg/OyAzAF
	jLoYHucz4EWw7Cm37tFTTsI0/xXTg81fSFwY3b4ujHC0lWOJpEDVr4PP6tA8od8wEdrI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxsh-0000XJ-EC;
	Tue, 09 Jun 2026 14:56:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWxsc-0000Wt-Ut
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:56:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=7LyDt6tPU40W7sorbFVUstp9VOn6tLlaPKM4p3Id+bQ=; b=P97yK+X+O/peFSq8/NVM5Zh/VE
 flTc9UnkIqEBw2g5P1GI5PhhZgc92zFxQaoI+CL5LWEhwGETC4M9ZfwDwQvgV11FxuVwKRgk6ApVj
 RJb4V8KwPquIe0x6w8wEIxQlmf7yNxXNoCZjyuwUhPpxIvZuUN1y9c90jcOClVkKD8tM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7LyDt6tPU40W7sorbFVUstp9VOn6tLlaPKM4p3Id+bQ=; b=H
 l4t87ux+qn7sdOrRXDR55T9qYZ/8P8yTSxJpUQpH6eMfalxjfIwcqO9AQ1WDTxlySWqHQLU7acjBO
 gI5wXrNyz8o+KhRNQpQe1fq4ALHnTzesuq5c3QUdo70J2S5ZjpuCrSGQTM0FRsHpq95Wq4auPFEiK
 rI1AepkSDSIiPA8Y=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWxsb-0008Cu-M7 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:56:39 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-45efa80e0afso4363081f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 07:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781016986; x=1781621786; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7LyDt6tPU40W7sorbFVUstp9VOn6tLlaPKM4p3Id+bQ=;
 b=hPjwufZNwRsGJChz2gqINGxTuZbyOPY3z2eJAN7qDgapjcLlWOj9dVzKVtT0Z1amy+
 Xtb8xtcyKLFN0vmspiJtpsqPa4tdCWJOiIfImddWN2GrR1I2zJTc4kLjanqvw7XMwqNx
 y/qV97FiDO1P7Thr2biTjRgj08KPed8bHncmYC4xs2zE6RgCjx5rTErLNmK4enEuRE5G
 sOyBQyplNMtn3SpFeYOj3Cp3ZS/S6MCosGEhdaRLhRmWe0lHnth40Yrt1sWdV6KrhnEZ
 ak5ELv00nN+DRFpgGN2WZ/ZZHM3mG3ldYbXdyb8w0r6uUElPxKJKvvYn5tgz2dib54ON
 8Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781016987; x=1781621787;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7LyDt6tPU40W7sorbFVUstp9VOn6tLlaPKM4p3Id+bQ=;
 b=IFgLLExq7uQ1kYCzLtzwLeVUXOXC5VulCgMwsCHewiPVq6WzzovUOOlEnJWAhf0jWR
 e2CL73cy6zt+97SMQvJ2iFE+IQuw8rSa4K0ZHcotQO3ZlCFjqxUBsmuVySBkRa+vp6dx
 9WdwSuEKzhxSuiiA0oUOVk/ixngH7gqtfR1tnEuNMxEB/wMcS7PPfOuTRIzoIadb0G6i
 UcgQjm85WUfWXUpwK2A62fQFnyoq/jXaievgCck8j6119ElkEuQqEakT9YqL3IU/HR6t
 e993qGvHmjEi6/mvWXv9oSf1mbVC9mpvb/i3sEnOEcy/o+qSAv2HMDeX+rFF296lE3fU
 yssQ==
X-Gm-Message-State: AOJu0YzLNeeTUf3JJtjDpkRVlnkiAMXMwGYRCGMUOqALTsZcmR7Di330
 C5AfRXXsSwFlMP80lAkZt4VU9yB0RDly79PQ1cXraaVK1OD0T8YEy96moYwqq3PwruMBIkGRvBU
 KU2NSKYN3D8SantB3KMLqmZctK/cCDeFN3mdK39Xhj5TZEP0nDd4tJ4v6BOyF3o/VD3ByGTCo/1
 n9JWQnOQ==
X-Gm-Gg: Acq92OHyDoeeVu9Pghbzj9H1Jp9IHsZjSPsrDoty3IwRRyj1sXyHhr6+s5CieRShXQ7
 cUMQQoynKaDdaCvaGCPadPlIGU5XjjnLz4GN1Phcl/d1AUSEeF6ZuCwf0DFhfW2Kj/CFN6sNRbk
 ap5DfgC3qQV2NaSdfkkum4ZOPRf9Gbj8fuJKo0KcOI5LzTbNKSBfh00ftmbZrm5adX/bdGR4kOX
 YokkO6NasAr6cUfTqzawywgISD7UaaVjK3p+EOCsrMAZZnt3AWTZOHnhbP6hKflFWj+UTXDdEce
 r70tki1athZOCxko5O47pBDEpvOTnsx6Q9hr8fHhTv/qUpQGWyGy8fT5xJVyvfYHWy5h6ZHNkMl
 Dk8G5apuMR+SfYVgG9UHXYGN/Q7CsguniLUYxx/zQ4yHss8SS3QXLSwkuXRqoiPnCEbEAWx957V
 4OGOpU69Bo4IAx+D/Q64TOpJq4lp7ENc8ZE0pKuEvoZj8rvf/vzvFCzXz0yiRacfIE++uGw5JUN
 edL6S/GssfdRzmvjL0U7sCh8ljdEuJEEDFHOXxbmFROE8irD6YAkBy54aMtiqKG3Rgc3lfgWZs1
 5y1QQQ7BBNj8KkGH9aXgM9Dk
X-Received: by 2002:adf:e5c3:0:b0:45e:ea71:c6e1 with SMTP id
 ffacd0b85a97d-46030643980mr26190737f8f.21.1781016986384; 
 Tue, 09 Jun 2026 07:56:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35fd33sm68934946f8f.35.2026.06.09.07.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 07:56:25 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 14:56:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9
X-Gerrit-Change-Number: 1627
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1627?usp=email>
X-Gerrit-Commit: 75911ecb9e24ffc6d5850db6b695267a9b7a4e09
X-Gerrit-Comment-Date: Tue, 9 Jun 2026 14:56:24 +0000
In-Reply-To: <gerrit.1776168708000.Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9@gerrit.openvpn.net>
References: <gerrit.1776168708000.Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2MTY4NzA4MDAwLklmZDI5NDg1NTI0Njc0YzY0ZDU2ZmM1ZjdlZjhiZGQxZTAwMjE1ZmM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4b92914c6883242ac55f13d178fd770e3ba7ba8a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWxsb-0008Cu-M7
Subject: [Openvpn-devel] [S] Change in openvpn[master]: AWS-LC: Use
 openssl_stack_size_t for declaring stack size
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
Content-Type: multipart/mixed; boundary="===============9193659093377922241=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9193659093377922241==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lWpfsnepVbI="; charset=UTF-8

--lWpfsnepVbI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1627?usp=3Demail )

Change subject: AWS-LC: Use openssl_stack_siz=
e_t for declaring stack size
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1627?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9
Gerrit=
-Change-Number: 1627
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 0=
9 Jun 2026 14:56:24 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--lWpfsnepVbI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 2:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1627?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1627?usp=3Demail">change 1627</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1627?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd29485524674c64d=
56fc5f7ef8bdd1e00215fc9 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1627 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Tue, 09 Jun 2026 14:56:24 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--lWpfsnepVbI=--


--===============9193659093377922241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9193659093377922241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9193659093377922241==--

