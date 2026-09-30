Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7330CA5FC5
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GG0VnkXjVf4zt7b/nsytoZHVxKfvXdmOrWIDqy1Yn40=; b=U5dat1mBCadb3Pn1SpruDJujpX
	oGJ23KluDMtzSeWYCYy4JKMp8zBcK9CLEZXOpFRoKlQLiz9jvNOCbcWZcAFOSGJx0E09YqmwKSlG3
	vxXRcG9Z8mTFbHQ+1k+uU9S0KbfGhoVBker4Qo0mpFKUT4uBCzhPPnkrB0qUCkP++74g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBuHD-0001pI-KG;
	Wed, 30 Sep 2026 13:23:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBuHC-0001of-Qi
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 13:23:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tdMZuzub8A4N3EBDo2WN3JIiIhflHPoHX52GZ/IpEuA=; b=d/tsFIWSy9GzfSqPygzgl957HK
 6xhItUy/oWuFVy88EOqTOeSKigdx0fNrJu2HiDOOwztY24e7MeMBUm/i4HkIemKJeVp40hOT2d3KH
 V3Y5URxLzhkYFTsaRtBD8lBcSLvlhkY/GZ5qpdT5wthJlDULWYqnT5slJtBQtY/6yRKo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tdMZuzub8A4N3EBDo2WN3JIiIhflHPoHX52GZ/IpEuA=; b=f
 BCKFHK9T0I/muPiGZICTZoGUWDk6gRtqQwqEoScB5d+jGrnEc2PLOtlp6gUL88PcaSxzqUdpwy+q+
 eNV6H6uuvUFVKNyisnov+WKlFaiKCw/yE9UXbBR0X4WTwnQn7u9MZCny1xHOXGXwJLzy0uBrpy7Xg
 vMKFslAme9SU05i0=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBuGm-00051p-Ow for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 13:22:50 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b24c3so3383657f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 06:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790774562; x=1791379362; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tdMZuzub8A4N3EBDo2WN3JIiIhflHPoHX52GZ/IpEuA=;
 b=TFjv7XXYNQFPIm/1F9v2cwWqBLRK7oo1iMZ8osEnwGDbMmsgLi4SJrpXkCa8q9L+wX
 i9KpYUTZIxnLOWgz2AzyoHBCEvkV9BW5MSdiup4DZPPxN1wBwooanGpTx8ptNkg123w+
 /okTe774QAvvvilfEp5NuvU9/hgFzEu7RFwTLxfepIsfYSUUwLt2uXVIebr0lh2xKcp+
 vEhqvlx8v68QG2elBX3H8TPjsZjxBLATBhQdeUto3qNNvJysIos/TQb2y2rzGL6oh+JH
 DDO7eoPRDhKHcK2Dak/udnzY38svW/Ahx0N6/swdCYth33ZEVoZmUGLAJbBk9nsA0RQr
 vZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790774562; x=1791379362;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tdMZuzub8A4N3EBDo2WN3JIiIhflHPoHX52GZ/IpEuA=;
 b=jvOqGDiajGTKMCdBN78diy/XQIup2E0yKQ15y4034LJRcH675O1V/OGaOokb2PgFKq
 KfYmWIVBVM++1NB9xwY85wpwtFmrmq7JaQVJXg6tMgZeFojnHE1+Ms8LOPC2b2ESRVnr
 j6h5v6KNa3eJZMM+Ya7G/F1Dv1FEJqS9Erzx2cY7GYVHUUoXtfX3DGRWtKZHWx0UATy9
 hJbCW0pa2q1QGiV6ZLvIp24FuGciALaoo0pwGnatQwLL8OLxs6GhjVpMsg5mUGrTVwuA
 6GklNgV8vUMcur8OC/PbvE+st9rBndfMcQ0LoT7N2H5s7wATvGYMpTMdJYRLQs+2osY7
 GRUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDHJCVoVAI3mRqaOtZnUI+y392nNwwofPXjbyGQCn0+/xmxu7O5o0cRchDufsHeZjHxfArVjH7bUB3irzJ@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIioqEwM/Wdoo2NrEXX/IznfJoDQ77ezghrgTqdJloxXFkZzVhs
 Gaw6XIohW0vHKmcvgNTSNiFueVk1zY95WVP5j5YUAavQttbE1K/DNv0kXlyCW8E98JB0LpUJ0/F
 ukVfZFrTOKaUtFF3JkRf/C/ttNTmuwHaK4HCD0ckkikT6mGhYnD6rP+oL/JlSYDRghKg0
X-Gm-Gg: AYBFou0nxyfomulkkqQRRmdaikX1ELIMqPAuHlqL0QbsV7oM1afi+S/VPLdDZV7BXcz
 0XZXZzV2y2/vz0j/tBQmoudZ5QJq3hFn3pDHTkmIUk9PApcykjWXo4waTloDdicTWNBgJJl2YBv
 8ZR2cKhZwM0NARivQnFvXReE/bujdx0M9QsQgjQSjXFdH4Pd5PwsjKgH953VoIPDE8JQSkzy1Nx
 EWPUARcYjGmuYr31sJq2oIubjMuLVBHmCApBC89SrF9ZxOvJhowCcsrmXPVx8BufkOAJQAhAM0o
 IiZnd53SkivKiPy6xWd99p2uVywvC+CSneno0bQ9rlnDtp+QfSJgz/5RUY6SYkLTxUZgR8pSZEo
 eN5lkDe6wdwlO1r2jCUf0m5LkZoVq40abeQRoHVzJ7qymn9kJvfcIlWBYB1wWDkaeiXBMmuBpC4
 xHKZUJthhZxjiwHAo7I0eM0OL+wbav4adGwzu08XjPlpL6tLazjg+hKqio0v6bAyBaRmeMcsoki
 vclktGHEmGyiCUFWWfMLz5lvcfSx++CoOxF9kjB+vpDiYgTF/y7sXGUNU+MZww/eB4INkpPqkui
 uqKz0bEUTSkHmHk7k9QRlvgfDg4oi6S/qetLaJSQFwxYyQyPDAJYbthuj3MG
X-Received: by 2002:a05:6000:46ca:b0:48b:515:f75 with SMTP id
 ffacd0b85a97d-48b051510bfmr257155f8f.28.1790774562004; 
 Wed, 30 Sep 2026 06:22:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029bfbcdsm3846067f8f.6.2026.09.30.06.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:22:41 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 13:22:39 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
X-Gerrit-Change-Number: 1955
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1955?usp=email>
X-Gerrit-Commit: 5f771fbfdf43a76d572bd3eb510e88358f56b7e8
X-Gerrit-Comment-Date: Wed, 30 Sep 2026 13:22:39 +0000
In-Reply-To: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
References: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNTk5NjY4MDAwLkk0NGQ3MTcxYzdlNGY4NDk3YmY4YjkwMjM4MGRmOTJhNThiZjhhNzlhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <41c6e46c58b804e5fb20fd0273a399d2772c391e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBuGm-00051p-Ow
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Build against
 Windows 10 API and remove some backwards compatility code
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3695322286182906084=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3695322286182906084==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B3BITvu/ttM="; charset=UTF-8

--B3BITvu/ttM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1955?usp=3Demail )

Change subject: Build against Win=
dows 10 API and remove some backwards compatility code
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

Thi=
s change is ready for review=2E

Patchset:

PS3: 
Fixed issue in CMakeLists=
=2Etxt



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I44d7171c7e4=
f8497bf8b902380df92a58bf8a79a
Gerrit-Change-Number: 1955
Gerrit-PatchSet: 3=

Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbo=
x=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 30 Sep 2026 13:2=
2:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--B3BITvu/ttM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>flichtenheld has posted=
 comments on this change by flichtenheld=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?tab=3Dcomments=
&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Fixed issue in CMakeLists=2Etxt</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1955?usp=3Demail">change 1955</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df9=
2a58bf8a79a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1955 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D=
"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Comment-Date: Wed, 30 Sep 2026 13:22:39 +0000 </div>
<div style=3D"d=
isplay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> G=
errit-Has-Labels: No </div>

</body></html>
--B3BITvu/ttM=--


--===============3695322286182906084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3695322286182906084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3695322286182906084==--

