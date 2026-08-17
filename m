Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265ACC5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z+uIazIQQWskoSvFxkytUvqle1QXIra/slfnALivm8Y=; b=Egb46xSsYTiHbPhEmSLXwTx71o
	5aWofxEFbQTFdIIBG68QW89mcJr2BPbxIrTjg2Hdb+owwTXT/Kd0eQcmeMyv53fWcz+a0OlK19rro
	lWbChn8TYlTU4TBy7JXFL2pMUCIx8P9l/r3DyUH2wPA0wRFuTBmP7fcdZmDcn47ooGvI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvwpp-0005hS-VI;
	Mon, 17 Aug 2026 12:53:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvwpp-0005hI-3t
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:53:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=heya6QXEBuabdDiA4R+OpsiQM/lSah8R7IaFHj7NTG4=; b=b55Ueqoft31sc9OUb6DxIcrXlL
 tO+YPYTwXqBSeQiqUUj+myq8UWBi4DBTRQBtDntJMYgdsWUkwsH5AfGvXeXxgAzGkuq5QrWJPik4M
 dqBL7EkGaaqhKq6NsXFmigELYINinqIykZlUsHFNO1zI300hKlPr+CpyNnn0UGQqBPuc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=heya6QXEBuabdDiA4R+OpsiQM/lSah8R7IaFHj7NTG4=; b=F
 5i8Te3+R3bWlUC2ignaXjS4YTbZpv+feK0NY7a/OEve/dj55HIJo8nSDwIVMNU2wzdEaHEhx2LISi
 eb1uwYLrdKqnshsA5cSe7jy5SuQ4ti0xK38ziHwmkHlzjKAvo9KRoBbyTF6cytW3bTKmL/cQKQWld
 5xK/dpTRrN4v9DI0=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvwpp-0007MD-45 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:53:01 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so17453815e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786971174; x=1787575974; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=heya6QXEBuabdDiA4R+OpsiQM/lSah8R7IaFHj7NTG4=;
 b=gJFNbDd6lDzmyQYAcFRCtGq49MQav7rji+vullMg407iXDc0W9u0c9DZ8p9Cv/rtAJ
 E1ZD9jnGB+owMqokwsHbYs1CRBBbKRHSYc5MUzypElLK5MNPs8c+ZEqDlKwyKUqP8Pji
 WEV69YAEqZt1Ws1wvtpxTD9bYeAN38a3H/8uGoi3HwH0HMwpOm/a2o2xdvFwehmKyNdo
 jwUQlZivG1vM0aTs+80/iTxjxxP0AXps6v3lGawIWwshcj0JSMpd7F6/LA6mr9w9PMzj
 Z4aag6FIC1Vg73h13GRZ90RFI24A4pzsOja0NHWN+8B6ifjyKUlEdUfoOTiMrhlKpch7
 Jnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786971174; x=1787575974;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=heya6QXEBuabdDiA4R+OpsiQM/lSah8R7IaFHj7NTG4=;
 b=aJXSUm4DjSW6N58ue+vplw07GzkHT6PD/FRULityEg8pmYKXzXtxBGRODmwryqRGtQ
 OEOqkU2eYPAHIhqkPYYbg/hlo+dKaFGAF4oXnvLyWk32nv4oXL7PgB1IJSHX/PNw7WrF
 wkoI0/t9Zm+5jSUsB09x8346Yp3fKlkJmzgXds44yRM8bahVogIH4jE0G1viy3IscJb0
 gakUEatXkvsXIYACyLFYUwxlD2PJlKZ9HJZMhRcMeVoAa6U14WrkYogXLcVoNwy5b3s4
 W6xxjdCV0Syc/jIYsHb0BP6x8p9Sb50cHn7u9ffpIBRRwL4HPni56m1VgwlvwnBnXiVC
 E6Zw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrf0kmBGYm0Q7KPS6/VeOjHdXOdOzIiof2tttFvmhj1n1aO+3sJYeMKsagOozbC666/2nZpAzAf91Y8ZGJ0@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz5smL/swkhLxkdkvRfpmyPPO4QCpMMXpgbtO7NjhxjrDayBX7j
 GlRWIFUuv3h2LhZ4tVetZJY+kKoDHOnoXRp+ewBCBnwDlylhnmuNqozAjLAlvaCUlZMi+3u+N4a
 15SBYGP0f9yMnU9kCCo1yi6z63L6r3vBAITvcAZr/781XXMLuP6wFZ1y1HyKnbKJJePgL
X-Gm-Gg: AR+sD13xuRDJxbLf8K5uG3gwVA5uAmCE0eaWMMMR0fGjgNaYirs9a4oqz35Zca9CXuk
 4hzg523iHgtMlfEJgvYumlMrbCGc2JgENfWtmn2LnmXCWx3PW1Xvys5X/3mslewhzNZFR02HazX
 XuRHRpLHWrI/FCr/+9ocsH2tO53MnPcmqaUUHpQRRB/s0jU0aeJ6JddqqUCtfUN+Esl8F6KNhMa
 OJ85OrFNwQadB8CP5exoZBGZmtQUvZBj/T2/pprtUOJbbVWqCSdHwf+TOFVuMHv3VAhaS4xn/GO
 OOJ1OIAfbyDaNBBkpSTydAQlkSS1guOekEkaXCnXVA9bAxk/ohh7mHcID0hTKNBxprEDm+q6ACc
 uDgnbTBJc8iuvdyBnmdWA3aqOtj2OKEfqajQzuGDK00XXFARbSQDqPlZxfw7Uv1x/qzD2R3YYK1
 dr7aTOHZC5PYp4ugJ5u8a+6N3U7S8W2Hnxen3nco52C0rgMFpEPlN6toYTMJ0xgco1gcLIjnhOl
 K7HfjjLZ5anS2hVCd+g8VXuf4cGBgOWpBVf7bZuPEULyl4d5b1+4My5n6m7Uc/U5zYATd8VIJaA
 rR2Vuvv0vIaEgI8g5LiRnuLp76nBwppbw/ey16CmoEqLmWkVNLA=
X-Received: by 2002:a05:600c:6287:b0:495:5fdf:2075 with SMTP id
 5b1f17b1804b1-499878ccf00mr352299475e9.0.1786971174511; 
 Mon, 17 Aug 2026 05:52:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d063a68sm35441525e9.2.2026.08.17.05.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:52:54 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 12:52:52 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
X-Gerrit-Change-Number: 1772
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1772?usp=email>
X-Gerrit-Commit: 16f746e22115b096bb1e6f1723cb4f63f0f6885c
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 12:52:52 +0000
In-Reply-To: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
References: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2MTc2MjM3NGMxNDE2NjJkNTk2YmJmODhiNjRjYTdmNzQ3MmI1MTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2b52da41f0b893ede8228ed5f0ebcefc64abd2fe-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvwpp-0007MD-45
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: options: Factor out
 options display code from options.c
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2240586188173989545=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2240586188173989545==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k4z1spqJDgQ="; charset=UTF-8

--k4z1spqJDgQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1772?usp=3Demail )

Change subject: options: Factor o=
ut options display code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

File src/openvpn/o=
ptions_show=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772/comment/e7=
173510_1a8e660a?usp=3Demail :
PS3, Line 29: #include "syshead=2Eh"
> I mean=
 "recent"=2E=2E=2E
I wonder if the traditional way happened because `-Wpeda=
ntic` complains that ISO C forbids an empty translation unit=2E Either way,=
 probably not important=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1772?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: I61762374c141662d596bbf88b64ca7f7472b5149
Gerrit-Change-Number: 177=
2
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@=
mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: =
Mon, 17 Aug 2026 12:52:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: =
No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>
Comment-In-R=
eply-To: razvanc <razvanc@mailbox=2Eorg>

--k4z1spqJDgQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/options_show=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1772/comment/e7173510_1a8e660a?usp=3Demail">Patch Set #3, Line =
29:</a> <code style=3D"font-family:monospace,monospace">#include &quot;sysh=
ead=2Eh&quot;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">I mean &quot;recent&quot;=2E=2E=2E</blo=
ckquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">I wonder if the traditional way happened because `-Wpedantic` =
complains that ISO C forbids an empty translation unit=2E Either way, proba=
bly not important=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">change 1772</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I61762374=
c141662d596bbf88b64ca7f7472b5149 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1772 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3=
 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Comment-Date: Mon, 17 Aug 2026 12:52:52 +0000 =
</div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:non=
e"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mai=
lbox=2Eorg&gt; </div>

</body></html>
--k4z1spqJDgQ=--


--===============2240586188173989545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2240586188173989545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2240586188173989545==--

