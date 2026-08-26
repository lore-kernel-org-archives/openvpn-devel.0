Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386C1C5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8XZGg4X8GG/mauHYCf/tobQc50V6xnwCdJ2Yk79/KLM=; b=FBpsvvXRcwdz4ajt8/1QSTfqJK
	uMGyyOmpQ5v1twVlyL3ZDsqvZDN0+xNr0v7k7lIeAMlckVPW5P337tyxfoXBTiY48K//qwl74tV9D
	nz9wCbDQOzQwqWSrAFiyrgsNgIO92J+T5RMg5027xukcRvaHgVwV7h7kcXmJ5e/y/m4s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzFi5-0001uk-4W;
	Wed, 26 Aug 2026 15:38:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzFi4-0001uZ-Dd
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:38:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VNP0rAMNqKUhD7bWbC+SeC18tNHyruEmqaTRGm/19c8=; b=XUswXhLKLYBtGfplx0LAYviWyu
 xT1YO03hJC6sGX7y5InROGL7wOnx/EWmbyO/0RLEFGcsvZ/MllBuhSw9ta+Fr6bmHbF8IdaAmQogp
 twQq0lfoJVxxdQ6DRr1FfwG62RZO/eyMrq9Uta/K+tQn8YhfcSiTTeIZGZHmHaL73VL0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VNP0rAMNqKUhD7bWbC+SeC18tNHyruEmqaTRGm/19c8=; b=N
 2BGQWDW1wN6Bfl1nbEiPIDlPJCjaTsnvI02VNUvP+ZtTmf2VA2XB9O3BaSVNEAQ2Jae6gokxR+ytm
 tYEoto614bZCS4bx+zK/KSotOmrqgBNUEGl1zgStpAvxUMQ8HbISgnZsXi9TBJbELgbFCOQrxSuQW
 GmTgGcTwi0mtGBoc=;
Received: from mail-lj1-f177.google.com ([209.85.208.177])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzFi3-0007en-Ki for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:38:41 +0000
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-3a1eb6fa0f4so9138351fa.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787758713; x=1788363513; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VNP0rAMNqKUhD7bWbC+SeC18tNHyruEmqaTRGm/19c8=;
 b=JcsTsWWGz+6NfsFDZ4di6V+QEsbnWZiqX2ApQngf9iBJ2I/8EZ6RKRkqZbPlZZx1+5
 detXwl0r4JXLFrRSA0plDnUDdjUDvAVyL7QT+zifcM+1ma/AITTJA55x+YHYk/hKDDa3
 n2qbas1Bw7YtZe2hms1v/ZLfq0ukLj2vidhaR+2zm2HfrcldtGTJdBMiZDJFk2VXydPh
 ikYdnYUqWvpIhy1AgAHY2SBEdVMeQmvKyaMkOq7pq+nyIUoZhZuJVCKP0fSf9eNCQy/7
 Me5069Q9YOHbKHNVEOfzyZ2Yp81mVbrGFrtctHW0qzKTcfU211IL+yQ3/MKmkXld+Bkf
 gviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787758713; x=1788363513;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VNP0rAMNqKUhD7bWbC+SeC18tNHyruEmqaTRGm/19c8=;
 b=CK3XTOE0sDUhPGaQmgV6u9ChojWorSnJE9Nl/HTyPT7yoaq7E+Iy03u4x81GZP5o96
 V1jHqpnA00iIRgG4Usc0v7Wkf4fQ6in5TL97kYxmo2LS4zuemzsvYI3gdoKNkMNF7F2E
 1/vI/8OPNMO79FAzYGiHOvTTQAKuWO0/szbmBwjXuMSWQS8P2WpsRWC7KppaeQMGoxgb
 MRmpJojo8slF9zqEvHxnKlAV74Bo7a6ZCSb4HQicU2Ces0+g3+1FAjCJbk/OX46dXovV
 9tR3xUzjbSBulikj086M7AzsMfDAAo7pkYvGempXevlJiqqxoF8kd8fnPNHG8x7VnXBl
 eRQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8V30KYWNHgRELxznCUVIONyCILQSgAgIH81ABb2jHxvHCxEaJ7HbAfoVWwZubSjeofyOVolkUjyeFG+yr@lists.sourceforge.net
X-Gm-Message-State: AFuF++kq1hyOaFekhNkQNC1KM/9ka9I5keuPM1jM/8BatOdL9aklrknM
 giQFl6bFY1jWvpEmsHBHuceI8OYgdSIQjVC9BDyTPmnvIio9obnfo97Q8URW4MFUph3yf/NGnds
 TAuXJD6ZfXNbk9Wot3rSmQFIwKRYelyaJNglpdSQQObXnl0fi/tKgpX4JlwnPpP6OCXmOG4G7uW
 YideP6dQ==
X-Gm-Gg: AR+sD12+jegVxD8yI3eFItqm5O1r1NEdaW+/15iKAJ34jVVWN/PKSfRKNMiuNGfKwq1
 9q7ZC9FgPfW2IuvxsurFJxpnDohGpo8RObMmvmONPqxRfT8DaQ/oM2W+kcoGQPKY5bFK7VPQBk+
 fd6MU5BoPjjw1XzBL2kvtI4m25f9JwNq80H0OSWBBZu0nCScQnDQx9NZ4MrK4AJH0gEJJ375Ftw
 nEkkWGq5yLqbGAXJBVF3MQQX6SKkMW13Dhn4MUToNvGJI9/KiNQYGr56DFrha51n5LvkD5taUSg
 DUM6ZsWK6kcFv8k0FONPTZ2sMogdFW2g6rYalToZs6knPU9BDMNjN1y+lRQOQhTKFMxVDTO3zPQ
 gHVn0hqRcbiQqo0uObNuxlcubOmdcaffMHy4BTnbIJ9x4MDp2y5rkZocVHl0FGHJUdqddOsB73D
 Ma3ZPK5NGBq5PD6IG/oVRNkLOyNY1+HbsErUTeznSr2DE4iDoBFr4W4mqe6oPo6zMSSJhJMXjQc
 rjm9kgLmcAwdx0+aH4SLQT38V9YpZi8KLaD5Z2ugh4O8yXmB1tixTI1J3oCFr0/vNzUbhhGAPCR
 IIB9asG6qt+e+48C6kHDNmFGWUWqlYULRRkfmyfjJqbailHZk7M=
X-Received: by 2002:a17:907:948a:b0:c20:f95c:907a with SMTP id
 a640c23a62f3a-c250c318b25mr711913366b.17.1787746030520; 
 Wed, 26 Aug 2026 05:07:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b43a0sm450816466b.52.2026.08.26.05.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 05:07:10 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 12:07:07 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
X-Gerrit-Change-Number: 1855
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1855?usp=email>
X-Gerrit-Commit: 08677f114c3ac26073656d1be4ba3ce62e3583fa
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 12:07:07 +0000
In-Reply-To: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLklmZGQyMTIyYTNlNjBjZGIxMWNjOWRmNjc1NzBhYjU2MjhiZmNkZWVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <487e820a2600d9500becd7552586bb467db8e2de-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzFi3-0007en-Ki
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add helper method to
 extra a field from a buffer
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1840767843074560363=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1840767843074560363==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+UcvucH2nTE="; charset=UTF-8

--+UcvucH2nTE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, razvanc=2E

plaisthos has post=
ed comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1855?usp=3Demail )

Change subject: Add helper method to extra =
a field from a buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 6:

(2 comments)

File src/openvpn/buffer=2Eh:

http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/cff76d91_c29b5657?usp=3De=
mail :
PS5, Line 2261:  * returned string is allocated in the gc_arena=2E I=
f the seperator character
> Typo: "separator"=2E
Done


http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1855/comment/aae836de_235676f5?usp=3Demail :
PS5, Li=
ne 2264:  * The buffer is also forward to the point after the seperator cha=
racter=2E
> Typo: "forwarded to"=2E
Done



-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
Gerrit-Chan=
ge-Number: 1855
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc=
@mailbox=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-At=
tention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Wed, 26 Aug 2=
026 12:07:07 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In=
-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--+UcvucH2nTE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, razvanc=2E </p>
<p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1855?usp=3Demail">View Change</a></p><p>2 comment=
s:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/buffer=2Eh:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
55/comment/cff76d91_c29b5657?usp=3Demail">Patch Set #5, Line 2261:</a> <cod=
e style=3D"font-family:monospace,monospace"> * returned string is allocated=
 in the gc_arena=2E If the seperator character</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Typo: =
&quot;separator&quot;=2E</blockquote></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/aae836de_235676f5?usp=3De=
mail">Patch Set #5, Line 2264:</a> <code style=3D"font-family:monospace,mon=
ospace"> * The buffer is also forward to the point after the seperator char=
acter=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">Typo: &quot;forwarded to&quot;=2E</blockquot=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail">change 1855</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifdd2122a3e60cdb11=
cc9df67570ab5628bfcdeea </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1855 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@g=
reenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Wed, 26 Aug 2026 12:07:07 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: razvanc &=
lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--+UcvucH2nTE=--


--===============1840767843074560363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1840767843074560363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1840767843074560363==--

