Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A63C5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=udxSiZdVg8oAw1tZ84qQBdyw5s/DGs+chvby5Dg46p0=; b=ULNH+pPf0GIhHaiTNfGbM6VAZd
	PxEKw0UH2THPh1aroMXjLi4pS30c1Dbz26OSvTrUW2Jv++X9Ax4o/keGOcYwQzIcdJMS1VsKqJIun
	XdbAB36ouOqla0JJaAj/aQJhHVz5h5DpCWWHUiUAoGclS65Sy7zdyztuB48ByXvao8+Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzGwO-0004Ly-2j;
	Wed, 26 Aug 2026 16:57:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzGwM-0004Lq-6A
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:57:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OIkmkgPx9PLcszUuPwBof8+Mf+GWmjCHMDZpfkqbyAM=; b=DKMKOGZHHfv+TelRpZq3lNwDua
 c5wzOP0nmVcvG2a4gHGWL3K5INufzK2reJkFEEO8T0VYcNDeDZhCOR8Lcv80Ml6VrgU2iw7GwFl25
 QH0ppriL//jrg08O3k3GHI4UclTSVcRQLQ9XP0ZKpqZOZxK683+lMUfnabb8iTyFkcsw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OIkmkgPx9PLcszUuPwBof8+Mf+GWmjCHMDZpfkqbyAM=; b=D
 DbzTpzo8z/ByO5CEDG6i9dNR/QZUuWpxXr6ZvXn1axFuQfQNPg75w+AFW0OsdeG5YW6HzTELUc4Er
 WniQQcedRtkf3wAtO9SNN+RB7OQZoK1MnOMf2JS7/50ek/vViNZs9egQGzNAzfNuL2RxntZnHUAuQ
 7zJNXVg8BDoPY0U8=;
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzGwL-0001gS-BS for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:57:30 +0000
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6a422090b2fso1652625a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 09:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787763443; x=1788368243; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OIkmkgPx9PLcszUuPwBof8+Mf+GWmjCHMDZpfkqbyAM=;
 b=VwfHrsaFwYkoKTVsqrXdqhCfUQnXlnLJeeB8LvBnUuX0ozF25tiHwK865hoZ+pjwLu
 fTsq8MLR+jK+ksFGuQomHrvw+/sRcSIQ+WAsvvXRnz5o8NYZ5DYaVvKOiS6vDK+tthLF
 aqucFUfOvRputCuN4QAHb9uJHsaZjI3V9vtT6FBXDxjGKb3zir0sjMALYmFalD7gwYZC
 1VaUH+12+5j9mKDUXvx88pnhV14ZB1v9fxcUyD/FD219UarJFtZbEDlJDZzVZ9dm1N5C
 uAiIBtAjrIoGaXWGcZ9tUG1HuLHlA0prEhg8o6De41iIX2I9SaTFiS6CMB95N35a1Sce
 FIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787763443; x=1788368243;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OIkmkgPx9PLcszUuPwBof8+Mf+GWmjCHMDZpfkqbyAM=;
 b=h44l6R5EnFIFuMP2doW6GuvWBsl5S3lPSjAcKDeCANG0bQgE2fxQJZ6nSbnJvS86jc
 RSAQCtFUPsJ42qIG6+2fL0p80lWcHOtqcePSwtUkXbYHwNZgJdD2suVDjHlHLmGFWpzm
 P+opRezAqe4TR+wIl4ip+pqbIxQ4NO6GobysmOsRg6XX7NiSqxo+0nx1NaJS7tu5FWkA
 31yGoy3g+cVV39lKtTyXKhG/oqOXM+u2ZEoHZOYI9+gdj/1HXouV+2UZ2Z5/vYDQ/GnL
 T7ias7aVm3rua8nLM1RmgZYLBDM98Nm+87P0bKeeU+uCM+Ov7OVlMLEEn7xneRwbdmhs
 qB3g==
X-Gm-Message-State: AFuF++lucZCnqOBOq8Iqu86SF6LlXu1O4ocHCaHFx64kSrtu+0hQJzqk
 tBxNvHP5QAEmh95KsdgIuTGJZ7myHyHB0OUO8pNKJ+jn+Ws+Z1xxLfAFMJ7RQlzo+VOmemznVnn
 jZ7Hch51UxSP/FIgNvi/rr3rvdRZimAMUn5/FhYq/StP4B1gVGzVOSpSE+v6y/T9W4KVY
X-Gm-Gg: AR+sD11kZex1EWfZwHK/xHKGljNY2jhzWW0WSCbgjXetadtZ6gcuo4sF9eTXtRgPhh7
 Way+y3zwROjt7200JciTUuAwAuOTPpzjaEtnZ+MC9jQjOz8IvPXy8qW4frAc8e0hijBXHxo1Obr
 v/k46s7XFjbK365JwkAPgeawjpHOYk+MpUtecb4xIJ4sdTAKrpUhZDf9TERDipWOZabbIkgwCOL
 jXglzLbUSP6cU59T8XWDtVoIm+b2ltSttCG6//bHzMv77QK+ENPikWY4UTSbYxxHjQnH6/0Bqkf
 x3rleSO0rGbckgPfUkgDiICBnnqQPAQJnks0B0A1P1IiIx+nhKZiGxQCtT5I4MYrnLarfNSaInu
 SAvH6aTL1aUy6EdXXB5K4JizKCW8krPkGem/ZFgyuhmp5LWnVVyYh1sBJ9574VZTke2+IufuD02
 jMkMa6cDgXuoyk6Fl6ISaO+i3vKhSvLMKhSkgT15wvm4UEDOiRreCMPt78QMlr4Jw2k6Z9rTHqC
 UFmHnH0jz0D2TcptC97I0x+pgCEu2TEGLo7U1PoSOkPu8wYvwkDd6MZho8W7FhKBA+Si0qkpwjh
 flC1ZGlzn4EpwxFZRZ5mUTsMaWstFXLluLOC81JaVLSIzMhVRro=
X-Received: by 2002:a05:6402:2742:b0:6a1:4fc7:94b3 with SMTP id
 4fb4d7f45d1cf-6a5df5b04b8mr10613185a12.1.1787763442583; 
 Wed, 26 Aug 2026 09:57:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa786csm5236830a12.20.2026.08.26.09.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:57:22 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 16:57:20 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
X-Gerrit-Change-Number: 1855
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1855?usp=email>
X-Gerrit-Commit: 33918e36eeecb15d723666909c3a168ee96ff67a
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 16:57:20 +0000
In-Reply-To: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLklmZGQyMTIyYTNlNjBjZGIxMWNjOWRmNjc1NzBhYjU2MjhiZmNkZWVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <22c0d78e0397f8f0da3f5f854b6df47d7b8e9e00-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzGwL-0001gS-BS
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add helper method to
 extract a field from a buffer
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4980603851556733918=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4980603851556733918==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xpcMPv2k7TA="; charset=UTF-8

--xpcMPv2k7TA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

razvanc has post=
ed comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1855?usp=3Demail )

Change subject: Add helper method to extrac=
t a field from a buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 7: Code-Review+2


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
Gerrit-Chang=
e-Number: 1855
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: cro=
n2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: =
Wed, 26 Aug 2026 16:57:20 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Y=
es

--xpcMPv2k7TA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p>Patch set 7:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail">change 1855</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifdd2122a=
3e60cdb11cc9df67570ab5628bfcdeea </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1855 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7=
 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: r=
azvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display=
:none"> Gerrit-Comment-Date: Wed, 26 Aug 2026 16:57:20 +0000 </div>
<div st=
yle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: Yes </div>

</body></html>
--xpcMPv2k7TA=--


--===============4980603851556733918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4980603851556733918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4980603851556733918==--

