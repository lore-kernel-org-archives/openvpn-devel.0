Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7E3CD4F3D
	for <openvpn-devel@archiver.kernel.org>; Wed, 20 May 2026 20:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pi8r375Z/Pm8HXy+rKZ/vKiwkmNYJ3Gv6a7i8+nSir8=; b=KQG6ou1ed1qw7xGtfk5kCiD3St
	xMQDpjcdZlJraJi9cfWmMzMNPZazjBt7l9seuqLXOhiRZk9G/UY+yE1PMGB0R9wiZEM6egNDoWNu9
	tze+UxozSkROiRzMMpcp7dsGaFjD/3thl71vf6WnOIKNAGVMpAdSZfebXqX3EN8ltZZk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPnR9-00014T-Kp;
	Wed, 20 May 2026 20:22:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPnQw-00014E-Bm
 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 20:22:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=y8aX2J4ZOijLErcCkIkVPX8hkQvqM6/eg0cAMHMSM+o=; b=heQgiT4zfz5P7y6e1tQbA4bP4I
 LpaAgMTgEnNkv0oiP+/WmvJzEqFer20M1igINEShyDs1VKisyuGqYaIG0BH0k8ksw4h75ocfd0VMu
 Jc2q9ZQXdtaupTwYetaoD9AuX2FXKLu9Ywnc/tjnmHzjzoRiHNzOBq/44wZOthVlNlpE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=y8aX2J4ZOijLErcCkIkVPX8hkQvqM6/eg0cAMHMSM+o=; b=g
 EJEPq2rZJAwmI2ro/U1CiuDgbKY2VsY6uL4ISX6EZtIiVerl0K+XdRX7D2NjKxgF9Gvz0/C/U3c6O
 nlG7DjoCqqdxdryzxh2sM+xGVw7jMuXM4e2pixEzzJ28ibCqj8makE+GXd6HAwDoywwUfXKCk82IU
 5sYmCJMEDMcqQZsQ=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPnQu-0005kq-Ar for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 20:22:26 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso50641175e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 13:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779308533; x=1779913333; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y8aX2J4ZOijLErcCkIkVPX8hkQvqM6/eg0cAMHMSM+o=;
 b=dtAQ2nCMW+gt0CuSeujSOPvgi2TMKNX+l8by5uHDkyhYqclSjGjIpQ8Q0ICvXBbk9f
 AgvAI0TrPM8aScHvufOcVMYoLAC5ZhQU43RCBgmQAJF8Cff8qKD5Mz1K3xn8nCmPRXYn
 lQ2I7KtCYcTZpoH5VrmhF1N6q3IjgGMDgG6VEjNPchVrsZLW6SAsm9NkCsoVANNdJHtY
 xiE/imPZBT6S2qWW0Ej7aBLYtK5c8+XxDnWGkFtTZ+soQ7+aN1futDubqWruX/5EahOK
 pIe5X9lDyLfzDlhgQOGV/vYlHaoros+Qq61vTdrRtjQI9e2vtyFSV/4TPThiy4imbw4A
 GY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779308533; x=1779913333;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y8aX2J4ZOijLErcCkIkVPX8hkQvqM6/eg0cAMHMSM+o=;
 b=CXnkHvbEf3wgnntSHe72qLXQ1UYyzfa6qE1O0o9L2Wzc3yBHTdgJXI4SdGGVJy8A3w
 A/iFe0+bkf4uXXBIWlpHdorzD2MMxZTOLqlxy6AwuWfwwlNkW5hRNykHfqwRhp3r2xpZ
 xr/Te1ux4nntIcrT/hZvuvrcD5OOUvLQLZk4ccHs/W/BvvjbBWhpUwRS9OKbSq88hlXB
 jLQ7a8qz2sJwFQZp2gqE29ttaBKmiDvbQwLEwATG8stDYWYub+ftIgsjYjJWfb9RRZqQ
 1wTiignyXBTXKa4C1EqIevMRk1ciwpt95iIoPnSfyqHHCJRL/7qgsF95s3rvlQaIIzUi
 1WBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8yg4V3/hTBipJ3sgRYEOeR7uG1YC9NMZUOl40BRB1cuVDWhTH+C88jSaxsBypkLQalF22AnBwOUcl7YhPf@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw6bQY9K6fiVS6Jn1/kq1KmaMPRPNvscD1BzbIgP8Gg2Jdm45td
 LAVYG3rpw6Byo7cpWRhXTcfzFnhI0MpN2HuIZU3apACorh9Ec2Gq5LRqrvGPbUWnOCsw7ZnlxXM
 DJoUS6N1NwjTMgH2zwGRUfOSh0FYAJptHcUpUL46DT8TzZldkfYpdY5xtxVapav2wGxMl
X-Gm-Gg: Acq92OFc/Nu+WlAdH2GVAlBHXgDAwNl9khMRsj13F9qv9v5qI8G+DjWAyI6XEzgWw/e
 l+GlV1R2v6Q5/R3VtJqECPgMq8VE74SbnqXgPuIYYHBJnNIa1IqfgfklEr5ni8CrNN3/C/DoZGf
 Q/R8usQTGhU725nyviCOWfkA1tA3urtXuDyze5n1yK3la/mrv0MJlJ6tbYounHBZoR2HDNtHfie
 /+ReOkS0bCge/uCKbTNtbaBO40VnGffGCbyOZcGa4OgDIYvg6jjBZvif617abujxpOVIb/E8YDE
 SAb+T85K74fTG59xDCzvD5AOHQfgWMpPsA9u+SkIXomyov/KYUFUALOGCzc586U7ceEzMt4s1zM
 gTeJvm9TcsGtDY/8Q4b2vYggn9xTa0ZGoIteDECLDgGczHOCeGNCKKAEMoVbvCEyBOpiDywQV9F
 XUh1Xx9jCXOqotAuKMSmUFLsYPeOLa+2kv0ahka5D+38cVplOzYfI7HQzJtWxM7TLWnRsaN4Oin
 IksxnHWPbNULbT8LHCn3IwRJUcW/RF8XeOB+C7jHXvqIumiwVsBBJuboMChwpncFMoNisn0uiEU
 YwwpRT73SVrCfg==
X-Received: by 2002:a05:600c:3656:b0:48f:fed7:d5f7 with SMTP id
 5b1f17b1804b1-4903537c7aamr1756945e9.17.1779308533187; 
 Wed, 20 May 2026 13:22:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm52000227f8f.26.2026.05.20.13.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 13:22:12 -0700 (PDT)
From: "ordex (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 20 May 2026 20:22:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
X-Gerrit-Change-Number: 1682
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1682?usp=email>
X-Gerrit-Commit: 913767cf436841f1e605089e1b7c2ba5021a335c
X-Gerrit-Comment-Date: Wed, 20 May 2026 20:22:10 +0000
In-Reply-To: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
References: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkliNTgzMmRjNTZlYWVjYTFiMTcwMTYzOTY3NjliODRiZGYyYzE1MTNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a4d9ad306bcf60ef7aa5d612fea1b2f8bdc2ccdc-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPnQu-0005kq-Ar
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi/dco: simplify
 dco_delete_iroutes call chain
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0703637786048756823=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0703637786048756823==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8I0Dj1vhC7M="; charset=UTF-8

--8I0Dj1vhC7M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

ordex has=
 posted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1682?usp=3Demail )

Change subject: multi/dco: simplify dco_de=
lete_iroutes call chain
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 3:

(1 comment)

File src/openvpn/multi=2Ec:

http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682/comment/cf5888f9_7bdf2f6c?usp=3Dema=
il :
PS2, Line 4378:     struct options *o =3D &c->options;
> yap, that mak=
es sense=2E I went for context because that was enough for me=2E [=E2=80=A6=
]
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib5832dc56ea=
eca1b17016396769b84bdf2c1513a
Gerrit-Change-Number: 1682
Gerrit-PatchSet: 3=

Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 20 May 2026 20:=
22:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-=
To: flichtenheld <frank@lichtenheld=2Ecom>
Comment-In-Reply-To: ordex <anto=
nio@mandelbit=2Ecom>

--8I0Dj1vhC7M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1682/comment/cf5888f9_7bdf2f6c?usp=3Demail">Patch Set #2, Line 4378:</=
a> <code style=3D"font-family:monospace,monospace">    struct options *o =
=3D &amp;c-&gt;options;</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">yap, that makes sense=2E I we=
nt for context because that was enough for me=2E [=E2=80=A6]</blockquote></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail">change 1682</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5832dc56eaeca1b17016=
396769b84bdf2c1513a </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1682 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div =
style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Wed, 20 May 2026 20:22:10 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display=
:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-I=
n-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@mandelbit=2Ecom&g=
t; </div>

</body></html>
--8I0Dj1vhC7M=--


--===============0703637786048756823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0703637786048756823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0703637786048756823==--

