Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CEEC55182
	for <openvpn-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vIii9KLgvJPKakqNH24tsKD9CliONGPsT0W1nP8V244=; b=fbBQcpeWJHVQjoh0MZVIM0BCtB
	XcciWeToYFrhuKXFOmUgwfdhz2sPKk3uI/mlggpfwv1RMq/qi48ILY5Ag7ICaMR32ftZpVSkkc+FF
	PFi2PbkzG1U0RTYnpNlYLDJCz5eIS3LETLQymu7/+6txMy1GA9YA45aVVjvdqQYInSPc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wqsPW-0007DI-3P;
	Mon, 03 Aug 2026 13:08:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wqsPU-0007DB-UJ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 13:08:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vLmVSPjWsrguy9p9we75o0YxSfC7dbBeVE/F/ihCBzo=; b=Lg0lLnMScbftqx1Dhqqj0Gnp/E
 i6VzRaxZU9eAIY6WK1TQ3zr55Aczul+vKCZl7emtb2rGAkI2yTFF6ZMfyveRi1EBik6Uf4PoI2HqI
 ocnRu4cS3+3OJntuYo00Un24EKhNdTIF4GDJWarMRriv+kxzMX4kPWbYTdNWao/VJmHs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vLmVSPjWsrguy9p9we75o0YxSfC7dbBeVE/F/ihCBzo=; b=L
 IZD2zF1mfzDlrUGr8WFquoSQCmxKXfZN9+dUI5NLMg3LiSEF6Vpc6xrpnCC9kduiRHiaePTBmTGgy
 pTF+lVAxtKQL5grHe4c6koytIzBONrN6Y1E6PQNwsxjLfRv3qfhEFbwIEDkHh7Cl9u25cjRsOJ//E
 iJ9wRKMQehXVnHds=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqsPX-0002lP-Dj for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 13:08:53 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-472326ca506so2354393f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 06:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785762525; x=1786367325; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vLmVSPjWsrguy9p9we75o0YxSfC7dbBeVE/F/ihCBzo=;
 b=HuEZczhyNiArFySfWof5HDx7PJbt2D2uMFf9GT1oh3GgpSAMLwcsT66aBO005siVBR
 92nErsIVPWXyATaL7ixFoUAsW97C+sZZ9r5WxnhlG9F4aphTaoy/z36PCcQAV0JFkdUP
 MDzdNPEoI+ctwP6Gvq3UDcCpMxGUmjUktcXSUNdO8+dklHhWNKz2Njb5Hb55VFp7YkGn
 GwPn93dSaTmdrOATKn5Cwox4UANOyJ5ItXPyQzJAzLB8Enf5+FC5BNHPR1RS2cGtB7L/
 YJs+DCFOyMblUZb+TXGI09fwvZsKsm6/udm7MZROxqlketv3uOK+xVFMnwmMQ/7DWsfK
 JTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785762525; x=1786367325;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vLmVSPjWsrguy9p9we75o0YxSfC7dbBeVE/F/ihCBzo=;
 b=RKCXTAr3gFXhqc9r46XXclaAPMwKS4BQn29O645Ra0pQ6vgassBVI1oAKanAqnmCrV
 r4WV0RfZTCJo95yxvwE3o0BDPMH9Nn+tRp8pEmZ4jFd49gNEYQ3p6sbSr6HT8YN1sT+2
 HbMIBoeqyL4OJDAGS+qf5WG5hh6Oe+Ju32OURUSVtuRQslgT/Ttj71MAjGDQipwBJfuB
 knCaoCnOxfljvaSOx1O6gysx6ifRL2gDADLbw3EQDM8hvxepyv3al5WH6n5VNRkeAPhi
 MZ0+B04GDlSBn4ItUbIBAVJ5t97/HTi7mlagZW0zNAAtQL2JwbfGfYq7mZ8SdkZP03cs
 uMGg==
X-Gm-Message-State: AOJu0YwEHcVKjH/WCESlLV9xB1rOJUUe3KQsitdWe0V3ad5Nqo429s+A
 0h0javtkblRFngq5ADPtyCSx8NHxu99Gfvy+tHqWxOcuJ+wqvCmX5rzYedN+S+gro0g57ZP6u2u
 Gbwoelrs9HtOjqSLK7Dvxo267dZo79o+m7zrFT+rMEIN45Z14J6uMoCGO+b0ZsOdjk4CB
X-Gm-Gg: AR+sD11jHMxgI4BjboQDaDk5x3f/Z+4VoL5yKQPP9EJAY3I6UCF6ASFXf1wSv/VQFR7
 cqOMNB//pbt3Ujy3hEoHnJI/0haSH1TXO4Axw/tuU7SPk9Ao4pKbunDtHK5T6tq5idDsOUrRbiQ
 fwbr+eJ2wm/i59YS33i2VwrOFgWjsftzayK1rJFz9jiU7uKiGXhqe833RhjTXo+pdQL3Ij69u2j
 CPPbl64cyg7jQrJrzK1vKwNhhvrWD8VGIZh3dE1h9exxkIam0drIr/EZRSIQCQuMsGTP/NVgTcJ
 74EJSu78OPF9aAPCR8hoYmAFH9fK5G7MAhgQHnpu1BTfOfCMOr0O4p0USLt+ll3dOSBkxvhyl1l
 quRtl3/W79g4QLO1BDE+IFXgl8330oUl7uFxtgzCApU7YSTSVhjLdgASEJEv/JDK31/a+IREbuZ
 UGDoontIMoC9BSl+mNVEiGGhnSAECeJySoS46ISkKRZCU5wLEVE6BD7ky41ay43ae7QW7bmvNNk
 0d1VvPHAP5cFaIHimya2a75vTFiYZClf3tbPnEe1cGYOwL+qUcgMzMSP+0TSAWDu+cRASCZN7ve
 rTPu8fmHcXG2PByem9QjTsHycDk86CyUVsp1caFpZf/9WNU0b9Q=
X-Received: by 2002:a05:6000:2284:b0:47f:93b9:d071 with SMTP id
 ffacd0b85a97d-47fd72c68b8mr23898787f8f.19.1785762525187; 
 Mon, 03 Aug 2026 06:08:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1756sm31736467f8f.4.2026.08.03.06.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:08:44 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 3 Aug 2026 13:08:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If458a3362e03630ce699bd122e957169601657a5
X-Gerrit-Change-Number: 1833
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1833?usp=email>
X-Gerrit-Commit: 1a3b086e44f9eae781d82779dfbcc2952c9e5207
X-Gerrit-Comment-Date: Mon, 3 Aug 2026 13:08:42 +0000
In-Reply-To: <gerrit.1785762169000.If458a3362e03630ce699bd122e957169601657a5@gerrit.openvpn.net>
References: <gerrit.1785762169000.If458a3362e03630ce699bd122e957169601657a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NzYyMTY5MDAwLklmNDU4YTMzNjJlMDM2MzBjZTY5OWJkMTIyZTk1NzE2OTYwMTY1N2E1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b0f6f527782919e3c65439ebfcf492a601abaad9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wqsPX-0002lP-Dj
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Replace
 ASSERT(rand_bytes(...)) with prng_bytes
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
Content-Type: multipart/mixed; boundary="===============0185628969640562614=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0185628969640562614==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y1Kv6wS8Iro="; charset=UTF-8

--y1Kv6wS8Iro=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1833?usp=3Demail )

Change subject: Replace ASSERT(rand_bytes(=2E=
=2E=2E)) with prng_bytes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1833?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: If458a3362e03630ce699bd122e957169601657a5
Gerrit-Chan=
ge-Number: 1833
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 03 Aug=
 2026 13:08:42 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--y1Kv6wS8Iro=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1833?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1833?usp=3Demail">change 1833</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1833?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: If458a3362e03630ce=
699bd122e957169601657a5 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1833 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
Mon, 03 Aug 2026 13:08:42 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--y1Kv6wS8Iro=--


--===============0185628969640562614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0185628969640562614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0185628969640562614==--

