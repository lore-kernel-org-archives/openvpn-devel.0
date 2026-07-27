Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB8EC531D0
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PG7fm4n9N6ekd/blWDnvupaXq8TYKMWkFXTC4ceSnP8=; b=H4ea+g2Sq1+FUuI/TMoyiAjrJm
	6Mtq6vMWpotStZjPOOgnF8l34P6HNEmWeWt6qMEczFRT6rOIkcLTMkfWRHceoN+af97O+M9Xus2kS
	48vjTwiLuBRRV+ztHSacgE07cCdkpeGGhUTfqdZe3n7OoyLzsO7qT9fQvSbmWb3qFAI8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woMfa-0004ty-JI;
	Mon, 27 Jul 2026 14:51:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woMfZ-0004ts-FR
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 14:51:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LVYlD5g2V6HU8o4HDi6WZCJJidVt+F/Tjnn1Rr0nz0A=; b=G9jGtBfR4ytoy9NKzwMz4ZKzVm
 tibeIWIC8ciMx2o6TBAQ2Q/VDMMmqFiP0t78Lo5OzJ8p4Ppp2K0AGinRDJ2/7/DGmYOCypv7HgPo4
 Mr0iEaaQ85ZqQPQIkJgoH+aU96hX6wb/UnxkxCrGscpzMHMEUeCmpVT+3/gcEe/XdU5c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LVYlD5g2V6HU8o4HDi6WZCJJidVt+F/Tjnn1Rr0nz0A=; b=N
 9z6IZ4W+oIdiyrMQgAS233WmCVQ53m+l/w/9XKVBlUFIuwdwb8xRuZWnCbcLarjnAK9l+O8P5OTR0
 s5FcEJLxYFQFg55PUyI0VVoYkGYlHMdkcbbY/zehl+F0a0POZYXOgFddHJwbMH4st07Dv7hNi0krG
 WGi52a8FRuq3lCwM=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woMfU-0000Z1-CG for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 14:51:02 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso33058285e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 07:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785163854; x=1785768654; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LVYlD5g2V6HU8o4HDi6WZCJJidVt+F/Tjnn1Rr0nz0A=;
 b=Z5dG81p7GYaDLQsZrwtFNzjkxmE8BK+ncUcmCNHvPza4GdWPH4igRGw4g8FUCk5EPW
 zRfMvqX+QYd+O7497uXrvPHQ3Ri76qHCB5ruzvZzF4SMvPm/ov18H9yOBBBQ1J/2B6Kg
 sX3rS+AmJPsBFQb69B+ZD4lVND698xCpSVbrJ/SZcLnxugVJX60Xz8qF3bwzTPGSrJ1a
 kIpLQetAWdQKBNQqtfBDfENsVgclOBriM+c+b8Gyau9/D9O753dVkGTOcjJ9idWtrLts
 CZM92kNqQN+bv8ltD4Eq27/X3rjY37QOioCjh6ENHoXkBm2AWibjTjeB2SQA0SjvvLCS
 JHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785163854; x=1785768654;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LVYlD5g2V6HU8o4HDi6WZCJJidVt+F/Tjnn1Rr0nz0A=;
 b=Y8o+nh3zpEgE1xKJXb6jU47Z5qgweibKalrT5WNpt5LaD2DQzqv4CK09bMAoTpDwQL
 s37J4Lu1mUJsTzGtDxsClFHez+49hMyjUEHYw555vgysjmoYlywjzNzHxJyMR4tqWbJ+
 WyQhOQp95+Y5jW1mnFZn2eUZFCW+BkJeMK0TgoBIwK87UFxB4kaEpZKwj4aigB3z2h0y
 kVdcDk+1URhDqJT/YUyRsAh50+HnVUvtVqc+o16TrA28AOFdwtwBmfXqnlBl+6hRbuC8
 4+Op9Z8GekcCBM78MG3R+oMFTAREEIqXOGHcqkjijShQFlJSm4imWVjLhKX2Sp1WwZ6c
 RBVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqju57bXnC/BJtIaF78ZfrG74EZjpHasOL2ulBlRxOE6ca6B6COwS1yOeN2LSpjdOFfxTm2ksWoXGu5SqOq@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz2dG3TBizafRcm+SL2pxgCUzcFFJ61/6aKsdQfvJLKFvQhsOxy
 kSxG4hg8Y+vTmGv0DpwFrUaFD6Wd8LecyRYmQzqZMgRfF8G9xOc0akNg7S7wcmBvBGSkPrg0qRp
 JSsYI3vbegJq6TLV+tJiqbA9i0sGdeBDNaA7aLD+IV8+kk/LfLHLFIXHKZObGr9RV2OTk
X-Gm-Gg: AR+sD12l/yuH49GxFDcg03GlZ16aP78eh45Sk+YtXphxW2d1QJWKDxkp/o9l+zljfOs
 O33UT+56idDvhiYC/2U8I7hzdaafF0c4qhwkgX0EUrLGUlaU/3QI9aM7RLyi5BVvB+H340UUcYc
 W4avhS6eIxwPRprfPgPd2H5gPRVJFe3HvU2x12CR3h83fvM54IksCN9ni15UaV2TLgUB3FN8eQ+
 KxOwSSiEhqdgCkKqdcD9nbbxG3YYCyHnlfa8vqKtlfDpTDY6Op8/3QnO8ij5fhfdMpy+3jFc/xe
 vfqDgAysaRqb9nnB4xE2beHvmNhoRbLfmiJnXdbAPcGALTKUoDJKBRb9XuB0Tnet/ojGDB5GXk3
 cqT0T3Dppxsaqv3ykEbdiVBafUnW4UZksnMVcasugbs/Ar1jVqfXQmPoXsAcjD2fxk8wi4fBATW
 i6kS5CBdo7ugfu1Y1MdMMw0+jktoHeILNnhQMw8OleQDI5kExn+jJRjTUWf7kuK7aV98MNTumOI
 4G3OAV2zCc0zu0BLapXNIYIBb8ln8vhADqPKxmDaoeUIDKkLQYpcQyVV+RPw5fWHxBb
X-Received: by 2002:a05:600c:8012:b0:493:b967:178d with SMTP id
 5b1f17b1804b1-496b5717d76mr100896195e9.19.1785163853632; 
 Mon, 27 Jul 2026 07:50:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f9b8b67sm276233085e9.4.2026.07.27.07.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 07:50:53 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 14:50:51 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 1051a4ef164c3c97f42459c97e27384b2e500bf4
X-Gerrit-Comment-Date: Mon, 27 Jul 2026 14:50:51 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <73ce5bd46d08bf348fa9df3e139845e18301e61e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woMfU-0000Z1-CG
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
From: "its_Giaan \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com, gert@greenie.muc.de
Cc: "its_Giaan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2589614127393894571=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2589614127393894571==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dk03a+YAjng="; charset=UTF-8

--dk03a+YAjng=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos=
=2E

its_Giaan has posted comments on this change by its_Giaan=2E ( http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: mult=
ipeer: introduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 28:

(1 comment)

File src/openvpn/ssl=2E=
c:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/6494e3bf_2e1f480=
1?usp=3Demail :
PS27, Line 1193:             uint8_t peerid[3];
> I would v=
ote for the `get_random() % (MAX_PEER_ID-1)` method=2E
Done



-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2df=
f639bf9
Gerrit-Change-Number: 1089
Gerrit-PatchSet: 28
Gerrit-Owner: its_Gi=
aan <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ec=
om>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attenti=
on: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-=
Comment-Date: Mon, 27 Jul 2026 14:50:51 +0000
Gerrit-HasComments: Yes
Gerri=
t-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Comment-In-Reply-To: cron2 <gert@greenie=2Emuc=2Ede>

--dk03a+YAjng=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, ordex, plaisthos=2E </p>
<p><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Cha=
nge</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1089/comment/6494e3bf_2e1f4801?usp=3Demail">Patch Set #2=
7, Line 1193:</a> <code style=3D"font-family:monospace,monospace">         =
   uint8_t peerid[3];</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">I would vote for the `get_rando=
m() % (MAX_PEER_ID-1)` method=2E</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1089?usp=3Demail">change 1089</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1089?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: commen=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 28 </div>
<div style=3D"display:none"> Gerr=
it-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Mon, 27 Jul 2026 14:50:51 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-R=
eply-To: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--dk03a+YAjng=--


--===============2589614127393894571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2589614127393894571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2589614127393894571==--

