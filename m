Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520EDC5AD7B
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 17:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SDhUyOANWYnp5KlyzRPk8Ic7baP9Qr738gqdNt0Hv00=; b=aGC5YNwJxcwwnj+laeLA8qRsaY
	y0owZ7gxMhkMjSIOv0frp1DQmxmjnH7XzmYJG6Lq/I60KOmiVU6kyHiZ2LfjY6TkO3/8XZdLcQVpn
	lPf9ESxYkFYmtVhZ7s5mT0LCp4myHbNlTAhwWvH2Z9S79PoTOtR8rJVVuKzaSg5ymiCM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wt7h2-0002r4-Ll;
	Sun, 09 Aug 2026 17:52:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wt7gj-0002qV-Dd
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 17:51:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NObHz3Y0ETsg10VMS/aW8sTLu5leLv7k5glICrn7yzE=; b=XKOXW73yR7NoYDrSwb/X1oJck4
 2/OsuqxviOaFfz8ccAnxcFfXCjkzsIVXyiJMDv+kCosUILSFUU6SoJWF9x3RuW8gMTmvMkGab3AWU
 /uUJqv6yp6yR58jrHsTtYtkhOQBvlSzgTqZ380Fxxv0dcduwDG2M1RxyW5F/AqCpvIGM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NObHz3Y0ETsg10VMS/aW8sTLu5leLv7k5glICrn7yzE=; b=M
 +WYd1D4RN1IG1sWvCepuiqRJD4NNoTnvj5IvcLa2J0/mpCptulfhWB2VXZfGJ6Mi0w/Jxm6Ys6WuI
 eCh0Pw/6RJE57n+zvwtOgyYaNMyV1Kw2tS3wnvvH6d0kf050th6Wn2IGh9hEdkPEj5g1mzKoZEZKd
 Tp+rrwV+7RQDroVA=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wt7gW-0001Gv-VV for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 17:51:46 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so557068f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 09 Aug 2026 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786297898; x=1786902698; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NObHz3Y0ETsg10VMS/aW8sTLu5leLv7k5glICrn7yzE=;
 b=NWJnPpCw550CfSZaWStoubRmJeQpfU5Wkt/NP8E6PU/6+WEvBDuMMMKV8eTKkYOzZW
 5M/+MEDATBlDGyH48X82d9AOmS8fh0GduVG22BoDY4snPZ6sEcCeOFoAEmU6w8/kkH2u
 drPnSQ++MMp1w2we5zJWkrTc4K+0GKtQmmoTSsWJQTM7MAChePnNnM/O3ZwYWpKc8w/1
 JV+bjlgVwMO04dDJMQWdxWsp7AQKAixcv4h0wjBlOwNPUdR7HlCzNAEHyckY++4ZxUPB
 pOsb3PwgrZ5ZtDMPoE3MkYj7HMikp1Au5YHddK+eDLjKFDSwQhEEpfy6EaN3jLa+AJ5r
 M77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786297898; x=1786902698;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NObHz3Y0ETsg10VMS/aW8sTLu5leLv7k5glICrn7yzE=;
 b=OH9/EjWKXGrIpiB2JCaYyW8UZQ1yyjNihwoFaVgOtToZpkqS8c+2OByhsQ5QeDwoIA
 J1PBLvbJ0RLpjS1ftNEFxo4etjtWb1Caexk3pwbJm63RA/Z/f6/FPrD6gl5cT6fKYgB/
 zTmyL5FZlQEkHteLorQW0R754zfy+RebYBTtid8JbTOXHJ4sqngNlhAslolTpYTT2SXV
 LXk4px8+pAKaC09y61hpCaqNjJRY6H3i97zaIsF5ecufrOwT4gpHzYti8fvWmz/149wI
 94fD7iaooZxjB5jJ0vR/A2sagQ9rcR2dVxcg06k05tDcMfYNF1/9jW7uuV9UlFtoaiGo
 VuOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXxXzPRqJd6Zg9mLASChR3lAZqyLfPBpTSNG41sYxNrPpGH9fxXjOtw0OIRxr+eWrnEAD8+s1dfLts0dnN@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyR7RFDkPsmHOFIndZWMS/4hHWfuFVe9opqNZ5L522Y9HjOBoWC
 jqg9rK8QvktBBQCfBmr9Co6hS9R5CW4lDvxrUuHa38v4mfVqYhEDjo0LaGqFdDdqi3ZTie7IzR6
 IiCC8ZSdvr7fcVHlVDejgxUZbbdoCgNy9XJ5nqq52A+gzEBIFMcnAx6QCU5B08YKLTfC2
X-Gm-Gg: AR+sD12kW3KxVN5hwNqEx7a5cPp3URs75q6s3jp5ZKa8Y6yDvcFP1sBuHjTJzeVA5TF
 b+H5JzYE14vRV/BfMuVJ2SVbBMoOdaP7t3L+YCV5pWEVpsxT64/0b1p6aW2Wau3Oxa7HUoogTqP
 Pjoh3PeFLB4ZIsYIlA4VsUiiaJIfM6vqSFSReyV1246z6aQgusPQOZ6eI8poJYW9RLKA3zjGwwp
 bQ9BLdAgAdfvfeQVKzn8Q0zZij0fYtirzSgTBvKH0PJVNgqZJBp/FoNLPWMWbJQamqdbm998KdN
 UKWJv3An1HCSsc6Y6n/LT+g6l7lNTpmY9X8yfoWvbZY5zBGZfIbtHKWawjbhCKUIRu1YPYtubCu
 2iJDy9grqzyOG6tuZSY+KKmKJ20cXgw6wsqimsHbeDKhunF+cIZuV8lkdSsZtYvyc/pCWTETvLR
 jRlQHqzVqn1D6c1oWwKbJr8mpzfGjDKgc8fstF71w9e+GobPW04wC5vrArsFOkJPG66Ot3qTK99
 SAOYUMvQvFZ5lC7ev0dFyXWbw7hWPKeHy2WbTJjlCLUrzbCFdo3/TOcjlvzm/gVikJgFzJgwpI5
 LNrknjHrZ2MYepHhEIjNKK/lBO2/bSz5FkkNGrriEAGcxtbmTaI=
X-Received: by 2002:a05:600c:4fcb:b0:495:5890:8f6c with SMTP id
 5b1f17b1804b1-4995e084875mr202896225e9.7.1786297898298; 
 Sun, 09 Aug 2026 10:51:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995ea2dc4esm243625415e9.13.2026.08.09.10.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 10:51:37 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 9 Aug 2026 17:51:34 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534
X-Gerrit-Change-Number: 1837
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1837?usp=email>
X-Gerrit-Commit: d8a9c1d752e81e5aeaaeaf74f73a56130b97d7af
X-Gerrit-Comment-Date: Sun, 9 Aug 2026 17:51:34 +0000
In-Reply-To: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
References: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1OTMxNzkzMDAwLkk3MjgwNjdlZjA4NDgxYzg3YzdiNjkxOGM4OGViY2FlZWVjNDY2NTM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c953951fb7e9846b58c7498404f5eebf67c1c675-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wt7gW-0001Gv-VV
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0646083073421894943=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0646083073421894943==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IMrlWJRSKt8="; charset=UTF-8

--IMrlWJRSKt8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

MaxF has =
posted comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1837?usp=3Demail )

Change subject: Reenable xmit_hold when=
 using p2p tcp-server and tls-server
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(2 comments)

Patchs=
et:

PS2: 
More complaining about the commit message=2E On the positive sid=
e, I can confirm that it unbreaks my test configs!


Commit Message:

http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comment/c5fc23a3_25b71309?usp=3De=
mail :
PS2, Line 11:  
Spurious whitespace after "allow"



-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec46=
6534
Gerrit-Change-Number: 1837
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: MaxF <max@max-fillinger=2Enet=
>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Comment-Date: Sun, 09 Aug 2026 17:51:34 +0000
Gerrit-H=
asComments: Yes
Gerrit-Has-Labels: Yes

--IMrlWJRSKt8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 2:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail">View Change</a></p=
><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?tab=
=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">More complaining about =
the commit message=2E On the positive side, I can confirm that it unbreaks =
my test configs!</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>=
Commit Message:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837/comment/c5fc23a3_25b7130=
9?usp=3Demail">Patch Set #2, Line 11:</a> <code style=3D"font-family:monosp=
ace,monospace"> </code></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Spurious whitespace after &quot;allow&quot;</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1837?usp=3Demail">change 1837</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec=
466534 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1837 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@max-fillinger=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Sun, 09 Aug 2026 17:51:34 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: Yes </div>

</body></html>
--IMrlWJRSKt8=--


--===============0646083073421894943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0646083073421894943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0646083073421894943==--

