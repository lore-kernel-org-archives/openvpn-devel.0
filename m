Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3511CD98F2
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1s0DRPBsT5ODIiaWfOeVvj6qDBDhFRqOX4C7ZtSeK1k=; b=ayccC9+Qw3QPAg7+TL2rPq7Ve5
	lutKLaSb0O+ATkY/JN5EH9lDthL26Xdkj+6aj0GNt2KnhA6APsE0uCy0anjcfs/ucqLBLc0mVDm3D
	3xg6WwUKdFM41a7a7BqY84tpk3MteUazX/6npPKJotzcBa1IGZzETRkcydqN/ZsFz/xY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbc2T-0001Yl-0Y;
	Mon, 22 Jun 2026 10:38:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbc27-0001YF-EH
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 10:37:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5X8oIlmpAeYehAA88Ej8pyiYUkDNgbh0hrivI9IUdgw=; b=cVmiNm7kEpw2HRyPOQiDq/V1Lc
 5giqwpWqtBjpkROMipqlef3ozjEePQ/V15tirSBhc+0ShDflMPCKfCclA89jj/vthrl2cudgKj0JR
 1DQ9JUWOp4gyYgMI0RCqvuvE7H3ToEhWlrGxC2UuY3LTAfrPHzP+HI6FxY8y5pvFlc9A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5X8oIlmpAeYehAA88Ej8pyiYUkDNgbh0hrivI9IUdgw=; b=m
 knPpdZo/N01AP7DgRGMliT6VuOVsjDW0wjKCHWBbAKpuxEaa1AqiqtYSGqc6EnmGR+8gru3Cxf8Ay
 cdc+PSPbBhaKfqoSWHsJdgv3fKzZg+YrymL6b5aHl++qizqRnLxh0Q888KKB6+VtA/sa5Mfz8wuV6
 VrajOInH0/MCtPds=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbc22-0006Rc-1L for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 10:37:37 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-45ef6565cfdso1834106f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782124643; x=1782729443; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5X8oIlmpAeYehAA88Ej8pyiYUkDNgbh0hrivI9IUdgw=;
 b=SKeg7DAderClgFfzOaRC+CUKlLAnOJiq72cjKG+/vA+hK9IGxjmeJA+opRTEyYafF0
 3R6IHcDh3zINvj6uTMCM6oRJeLJrekAisbzHO4w+1PgLyfCl05LqXSiZPyii5QDyzONz
 A3bMGT4LqhX/A6mTb4MyHf8mvfXvEUkVXBrFTPujP84Z1nhAd7tAu40pszVLm5FY11GZ
 whmOaTlymgL35ZA/YrK03TjXe8ak/mOngnAGzFJlUXNrBqifTt/xUGtKHQnvK4c9pg2r
 x/1+8IxWFKh/32Bl2plc/ZHN9220fXENuVTkWJ+/8CmGVi5FCAoV0W8SdC9UBNSiwN6x
 rB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782124643; x=1782729443;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5X8oIlmpAeYehAA88Ej8pyiYUkDNgbh0hrivI9IUdgw=;
 b=r0ygSbQGJX9DKTV+fjWadlXTe/ikgKbY8Wf1410LPmonpSM/z1u3VM7v1RKA9HWYKz
 n3bg8IpQ1G2W3H7NYenFhDV1pizs6kj2iQd3eNHFfQET/hDJpE1S2dMcGuAJrJJXSmdx
 1a8zCxwAO+b7N92a7mB3EgDe7jhsmkudUGp3xRHVaA40ldajj2vC1F49CW6Qym5jl5N3
 Xt6seFm6tChyMebQSOZG9fdnhHBFelbwdoFGJGY1zawnueABukZ2YrqTkpENNe25jzRp
 6sJX89I1hH8SIpCngQdgnGMTHGGwB70ytIz7l2f5Na7JU1bzRdRQoA3tDgjKxrxJdc9X
 Nwmw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqo04oTQu9pJ8EPXXFUzWLen5xcRJaVYP/RPrzt0qv5TGDPLmBectlw5+VFJxXYpEuftql36NtlHHFMShQa@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwEKc8PYClVOSHUmhHFoKjeWV6pPuEAKxZhBYIQuqOBWeNBRLE7
 k3n26xz6Op9GDGs/ordM3zy8JxyNL9fc7p8OZI2OSiA5AA8pmQ/x94ZOJ9UOc4RVb6quYV5rIY7
 DHUMoNbRy4RWKscQXBubfZQP2mmBQl5KrLml+FMsxC2tpVtUz8jtBESaBMvf5UbN03WbE
X-Gm-Gg: AfdE7cnB8RSAVtI1xpJt1ISxsndu/7zQwHtWEdzjkstZav5OS3ix0Ay7n7H4W0SmQc9
 ZfuJAjiEaaY1h4njHdzX/LoHMQsu43wojDbisztsXK24vDC6lzBDiAgfF2PzNx+zde5CnJz8TvS
 WViERR93RNI58sd9KKrWWzRiIzg0M1j91SrXuZFWqX+yJauSfaPGVupVm9aYwwPRZ9kIFDYYRdh
 KtaNxg2b1DJS+OeSnOqAC+cVF8oZhdHtTr6qd0XsvuKitOPsd8XeY/qsdm1CaAgRSIuOgX1mBFE
 SOrfIYZtCuzrIULTfpw7gttUSejvc0M188r4Fo86VYK98FBxcHHJPudnSzmfSSHY1LsHvnVBqe9
 WaQQSuSbeXI8wcq7A9pKKgaZqIzbbrGxT85Jqmt7SuCIvq3kSSS3mgp5YhLWyG4tFZ28ghOvV3O
 1hToUJALj4MPJmK821Tbg4m9GIwJu2/YaePWwpwR6FJqas59RsM3dQDURD37GVqVpSs8MEdN1C4
 vSbmimGqdl05FqwLGZ8epcupIhCDuxbCFDgBRaUXgwdC+qL7UEkBUS+8vflFzCt1M4VghdFT8Cy
 5WeTUf7ViXjMvg==
X-Received: by 2002:a05:6000:2881:b0:460:3a90:b2b6 with SMTP id
 ffacd0b85a97d-46660c10621mr15569640f8f.11.1782124641756; 
 Mon, 22 Jun 2026 03:37:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466648c5413sm26205882f8f.11.2026.06.22.03.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 03:37:21 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 10:37:18 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835
X-Gerrit-Change-Number: 1715
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1715?usp=email>
X-Gerrit-Commit: bddd85297e4aa6c7c8560aa819d8ca3be54c5e52
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 10:37:18 +0000
In-Reply-To: <gerrit.1782077103000.I49b37b5a90554fa2d4a83c8fc5608dad2a36b835@gerrit.openvpn.net>
References: <gerrit.1782077103000.I49b37b5a90554fa2d4a83c8fc5608dad2a36b835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMDc3MTAzMDAwLkk0OWIzN2I1YTkwNTU0ZmEyZDRhODNjOGZjNTYwOGRhZDJhMzZiODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <085d3979227e45fb52a5e60e9cef906e640cb372-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbc22-0006Rc-1L
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: fix
 use-after-free of DNS options on client connect
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com,
 gert@greenie.muc.de
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5394658703074935828=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5394658703074935828==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RV1P8bWlVkU="; charset=UTF-8

--RV1P8bWlVkU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos=2E

flichtenh=
eld has posted comments on this change by ordex=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1715?usp=3Demail )

Change subject: options: fix use-af=
ter-free of DNS options on client connect
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(1 comment)

File=
 src/openvpn/options=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715/c=
omment/e035e838_43ea4663?usp=3Demail :
PS2, Line 1539:      * Detach both (=
i=2Ee=2E re-inizialize them), otherwise child's call of
"initialize"



-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I49b37b5a90554fa2d4a83c8f=
c5608dad2a36b835
Gerrit-Change-Number: 1715
Gerrit-PatchSet: 2
Gerrit-Owner=
: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emu=
c=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit=
-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Mon, 22 Ju=
n 2026 10:37:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--RV1P8bWlVkU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, ordex, plaisthos=2E </p>
<p>Patch set 2:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail">View Change</a></p=
><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1715/comment/e035e838_43ea4663?usp=3Demail">Patch Set #2, Line 1=
539:</a> <code style=3D"font-family:monospace,monospace">     * Detach both=
 (i=2Ee=2E re-inizialize them), otherwise child&#39;s call of</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">&q=
uot;initialize&quot;</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail">change 1715</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I49b37b5a=
90554fa2d4a83c8fc5608dad2a36b835 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1715 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &l=
t;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Mon, 22 Jun 2026 10:37:18 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes=
 </div>

</body></html>
--RV1P8bWlVkU=--


--===============5394658703074935828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5394658703074935828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5394658703074935828==--

