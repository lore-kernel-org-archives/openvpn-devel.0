Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9582FC5AD4E
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 23:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WsKTJmHjElO6xuuauvqpmV6n71PaBm6oRxHHOrupIhg=; b=JscQTqZI+V07pWPYGR+DR0cJar
	Muw1d2Rwvd8pWNSHG1IGZoziYfwkOsGuj/0RhZPDF/GP9qL9/BUZB9TuPLZRiYxrI9+obIX1D9t+y
	XXSVo/EtCmOsbAJgINKcfzOTO6V+JvQLe8tTPXR28hIAu5LFpIQZhpo81BYALxTA+U+U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtCac-0007cm-0K;
	Sun, 09 Aug 2026 23:05:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtCaa-0007cV-DY
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 23:05:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JZoaWd2cQoguQfn8oT6xt3G6yDkSr1axqFM5ZPHjA4Q=; b=GBHnH39Xy3YW9hS6o5ficl2hpc
 5L0mY39Z85Zr93dohdaG1lW3eWcXZB5UJyx6PjharUXLClqWAcMmsZiBuBZTB6BYChPxy3vJ/o4Cm
 /7wOR2J9B6OiWu0vHEUc6xPcXY1e+8ZwhpbJVldmTD7GBH+EC/MOhCg9Qo9qO7Y6PyLk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JZoaWd2cQoguQfn8oT6xt3G6yDkSr1axqFM5ZPHjA4Q=; b=Y
 CfJB6w5BU0XHLZ3/xTKkGQXt4FlcAWEcl8DVsEL0A8hdGwFQit9oG5xJ89PLFnaU4G60K9fs8w0zn
 Y4aPt2r/ninE0KNkGf2vM/bqtgL9Yn2+SjYLJ+0r7JooauQMP30X6BOB5+a4HfJCK2ZjiOIWOGzmK
 Jl2nxpH58uP6ROKM=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtCaZ-00069w-Rf for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 23:05:57 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso19978985e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 09 Aug 2026 16:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786316749; x=1786921549; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JZoaWd2cQoguQfn8oT6xt3G6yDkSr1axqFM5ZPHjA4Q=;
 b=GwxJDiXxr+rCqWnJWEPxw/uhH2ecmBOEQhWmtTiJprV3Lp61tz4gVt5d5ACYeg+V+b
 Zu/iGq9nI1GDgDWf8JoIU29fr6cLYH3cXvvP9qSOls6/o8ka3vAtGXQAWevEBWu/eJQx
 7g3/LEfc9MWqiJiHs4OY198rFeHx4vkwInmaQoBGe5JHr6lQSwvIvhaOE5tSXaybhUUp
 x9cjcQYvmzLvd1bqnbC0n0W7VTJGQDpgCgdaxF4ueRcPGwmBQv8ftcAx4F+QdlsLSGTI
 twZSf0AMtmUqXU5pnQFL+h8r2hlb8U+PrDtc/AihbzdgHNsQoJEO3l5+Cigf3MDLqTHa
 GEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786316749; x=1786921549;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JZoaWd2cQoguQfn8oT6xt3G6yDkSr1axqFM5ZPHjA4Q=;
 b=I8U+U+83seRZSCt62QdgNwFeCOqOYy5m9LwkSErXplCRqlkqwywHOlW1LAvTKrFfwV
 PwdV/i6sQKCYM2fyP6TmvdYC7BJJ9TUKZm18XJo67mzYoCqIqKSlG/U/YAjeNr+T5F5v
 6Qu/AtPi5mw4TMcwYvEnxoWmDikgN0u5nHJqnYv0jSt7h7Cpl2O9GbE8yREpBgZa+iRM
 aan9KMndaqLrMYZsjHxtlhyayBpQBqjxF+jL7GRz5HLs1hLjB7JtiG9zy29V/+9W6hoe
 4N2XHMvIb2Num+0qMDjJddTgflQP/+IqpREPucq37iHRJDdMziYrWmloZh81HcXcxiSU
 UE/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLrQe74OsidEGGFDt2v7b0keYcJI7WFo3smt7R/cpDtgTgWMGM2YLn46L4lwQHdXVvqXTYMOmUXU4q8BCW@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxvoThBEbN3MeajBX/VFtFeKAlZOfo3IbBOCf1eWBhMpb/teTHA
 +4e6m9diAZzOHXIXZRe7AdxA0ut8IBHAVZnsOp02Id/YZmmbIVgwCJDEFKCwKepY7dBsFLjYY+4
 0hzAVB76UWyeCv1LGH+MShwD3aNm/VZSbcAiRV2tWYBv2edBLq36pe+sUUoftir1+UlQNIg6Oid
 9egtDGng==
X-Gm-Gg: AR+sD13sQRFnBii3DWYyKQ39oBN1kErGiUN8V/6A2mDRgeBtVj75WPW43fdTA42NUrq
 tz7aW9IDym1baVlTmVdLxqFiBdXfCDAfx8juMrK0n749fagBp5SRfhWzN2HUOj4o7Ay60mBiPnr
 LluHcCrtUv624MLCGiTokcbdRsAxrRhKs4vUGlMmpeVHcVPPp3Y59n8WvegXbudpdwDHuB4kipZ
 RqwRM17BpHbv5PgWDEOcmD+/10O+HcMFnAZtGHpK2qePfOhFCP7dXjuQYKHs2twRfgGkq+t9mqD
 A+Pxo9yp0EF4/Lae5x7vOU6/01JJRbqyqUhmfb/t013wuAyJDjGSB158giJhqD4H+eyJ2TkZdbU
 KKC9stbNbaWcR0581PDIXfH0xF2WlrTX+MGUcSCZD4mKuSo2mJR77YvV8ET7Z+h622C2nFNs4mg
 jCs8xBvytd3bJvTI/dYEx7c+BGI/A7fQWmZIl51S9k8wsI+A8iHifX59flQ1lygHuPtrf1xzRZ7
 aMUfN8AEx9ukXr7AX4C2KicIg82VT/7hME5lv0RJ2rZCAEZQ4aIB1ffPZWDTXDDfGKd22/v5Zyw
 2XY0iyecpDf6MqgkSnrJzkxccg3DBTOs8y/kleedQG6xSgNEnho=
X-Received: by 2002:a7b:cc0b:0:b0:496:cb48:5eb8 with SMTP id
 5b1f17b1804b1-49959e38ecamr258407015e9.15.1786316749209; 
 Sun, 09 Aug 2026 16:05:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995c7a56c5sm257674305e9.3.2026.08.09.16.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 16:05:48 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 9 Aug 2026 23:05:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534
X-Gerrit-Change-Number: 1837
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1837?usp=email>
X-Gerrit-Commit: d8a9c1d752e81e5aeaaeaf74f73a56130b97d7af
X-Gerrit-Comment-Date: Sun, 9 Aug 2026 23:05:45 +0000
In-Reply-To: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
References: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1OTMxNzkzMDAwLkk3MjgwNjdlZjA4NDgxYzg3YzdiNjkxOGM4OGViY2FlZWVjNDY2NTM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <114118c3e682bcbbf18ac911d89e867c3a6196d3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtCaZ-00069w-Rf
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Reenable xmit_hold
 when using p2p tcp-server and tls-server
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
 frank@lichtenheld.com, max@max-fillinger.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 MaxF <max@max-fillinger.net>
Content-Type: multipart/mixed; boundary="===============6865785239750518957=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6865785239750518957==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+OiHuIJvICM="; charset=UTF-8

--+OiHuIJvICM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld=2E

plaisthos has =
posted comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1837?usp=3Demail )

Change subject: Reenable xmit_hold when=
 using p2p tcp-server and tls-server
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

Commit Message:

http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comment/c35e9e3a_0c01dc0e?usp=3D=
email :
PS2, Line 11:  
> Spurious whitespace after "allow"
Done



-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I728067ef08481c87c7b6918c88eb=
caeeec466534
Gerrit-Change-Number: 1837
Gerrit-PatchSet: 2
Gerrit-Owner: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: MaxF <max@max-filling=
er=2Enet>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: MaxF <max@max-fil=
linger=2Enet>
Gerrit-Comment-Date: Sun, 09 Aug 2026 23:05:45 +0000
Gerrit-H=
asComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: MaxF <max@max-fi=
llinger=2Enet>

--+OiHuIJvICM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, flichtenheld=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comment=
/c35e9e3a_0c01dc0e?usp=3Demail">Patch Set #2, Line 11:</a> <code style=3D"f=
ont-family:monospace,monospace"> </code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Spurious whitespace=
 after &quot;allow&quot;</blockquote></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=
=3Demail">change 1837</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1837?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1837 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@max-fillinger=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 09=
 Aug 2026 23:05:45 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@max-fillinge=
r=2Enet&gt; </div>

</body></html>
--+OiHuIJvICM=--


--===============6865785239750518957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6865785239750518957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6865785239750518957==--

