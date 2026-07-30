Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE700C54FDF
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FFNc29oOQ+pU6CDPCGxwOe07lz16bzXTfTBAv5CugY8=; b=VORlYhMIpsCOTui44mKgpjdMB+
	1x82KL/Uk5ysGvhkIiKQyu50WvdMbEzuOyVw29nTRftRwv7IKAkxFkG2f+kS2XJN+wKZcUdwbSQ/F
	LImzjs/MKcNudNYY+6FLzsq+zgKaUzHDyvSSK3TdYli9yezfbZkM3MR6knVl80eogg8Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpNkl-0008PV-Dx;
	Thu, 30 Jul 2026 10:12:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpNkj-0008NW-R9
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 10:12:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=PxffNQDBxqZPS0rUUIMEW5ENmwfSjd4IV4XhREFrA9I=; b=m4CRd8rs6gLBjpLfQKw1SmiVdG
 5mYuYs1h2x5hM5dpA8B1GGPV3KUzcJsNq18yHfFRO7bdNp8owuoSwNzqNaTSXpvr5nh4q9N1Taulv
 /7g5t4ThV2uCAousRAeAsrZIahW8TJwuaJxKdKGWBO7QN9z/oxIWF2DgZKojQZeMZEPE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PxffNQDBxqZPS0rUUIMEW5ENmwfSjd4IV4XhREFrA9I=; b=Y
 FQ7CV4kwBpgxF2II7arj1YbEpcTz92uT21YEqlDwlYCHyzeic1mhFByegpSPRYwf9uJTPMeCZUadD
 kO/1kW8c4fG8/D1lZY7LxHZ433uHQIIvnfQOhgQoxJ0Q2SwXtuAfxTYFUWPdTwb6TTRF/ujNDSXwF
 wUvKMJmed4ZpfZ04=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpNkh-0003fi-VZ for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 10:12:34 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47f81a3ccf9so1537375f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 03:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785406346; x=1786011146; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PxffNQDBxqZPS0rUUIMEW5ENmwfSjd4IV4XhREFrA9I=;
 b=d0QvdpxabGl/gqdUv8VsPMV0Oksryzk4+Ao/SkKaDThNT3AheRRQ9RyFCnpiwCx0Ir
 gUg2tUEuATcxC3SnOJ8g6OW8rw5pb2GpsTLkR+4aZDHg4F6vWpTVV6CvWEalQfQM4ijI
 L8QXI+cVqbqK8rGlnVmpEquHDAc+57kdK3oIW2RZD0wNJo6h9oQDSooeKWmuK9TdlxAL
 6Vv82/ZcZ9PncCqJkKno6bkLU8UYyjb3e3C1vIN0DKNjZbNsDHmsf09uwsKfD6LeTXkC
 35vsdkogW3WAXK/IITWWHV9wR/HikEao6gkAKvQkJPFdjZCPT3peTsC9JOIKe5Udo0fn
 aRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785406346; x=1786011146;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PxffNQDBxqZPS0rUUIMEW5ENmwfSjd4IV4XhREFrA9I=;
 b=lfAh81zKrhAU45C8TG28NFLgPAGrFQLNkTqofpdlYt+0blnFtx8shs68p5ZddN28o6
 mpOA0bSPZ2AuZ+kriICU/8DYT15japzWnlnUKOjfVDdnX4K4jet71/z4TDU6h1IdtbWm
 tvLO5NBB34s5nbvnNLCN6lVHFKE6/T56mkM9KY0PHU5l2KrpXh9SeA2TydQN8kHs3g5k
 IIJgY2dgSNj5QpFWkSyuSQnRvmsSHEjeTaIBH6Er5cyvGtkJcYe4NNnx8P60RfRjbRMl
 0hCBnkLxC3vNX+mAgah2ueVb4xriFWzSI65DV8tuRWSN4KPbwmSkbiYVLkODhN6FubEb
 eNNw==
X-Gm-Message-State: AOJu0YzpVD9gQyyiTZeqPHWlcjRsSIJRwUjcTFZ277PO5GnokzHJ5psJ
 MQuENqBnbe5qPp7wT9kfIgQc2S3vW3HMUGT1d9LEwTrEZ6UC+6q1LK08kiu78yi3iVc1b27zD8I
 eiWx8ReFyoG9jdTGWlkLcyl639Jy/peM1szEBOyz5sAX8Az2Lp8HphSEs5RCyxej0ZBHl
X-Gm-Gg: AR+sD11S+eOmoHR8IWwZgnXlNbCtqfxs2wZiyc0yqdG9nKbVDUJjOJ9kezpCGKwy31l
 B+09Bb8kHeS9jlqopvUg7P5TvHMqi1hkiJ/+dAGaxF8cNp5w8JrRiMwJuVpBbyfWz6cb7otIkIu
 8uNnPtSajLA7vV/JdD7SoiwywKY8RhP0BWwwRTfgh93Fe0iBkwXCtMbP4j41QKXdUOlGFpHtp3k
 JHKey2BGGU1lxjuZ0MVpZOTRv3Ej2ywfZiXIEipuXDE9Oe9xFL2cN12Y00Htssxef1HWJvHJgu3
 Z4aFpVezciG4xoWUtMHasRkISYGp/HiR1FvCg218PUCxngEoFyICl2/v+q6ylx0IUSuuKHCjIio
 q5Ylq7Dzggce/01bnvZA/6uKrr2ogxkUq+qDXJn5Oui45aS/knRZcfKFpi3S+pMbPBvfBgLlebF
 TOQpm0U4P08GiWHvo9rZb5mFJItYbEORInOwQjUNLXs4x4NIcokp1+StZVsbKHX0shdedZDykA1
 EtWSqblloXoJWaf8xrxvp4YrP1Cf8e4T7KIWoealZZSrqkE/n3OwK6Bil86geU/IsZaqaAzH0LF
 4ysFFxg7a1tmhZp0qldInBZYIwCusAcYVpAcL4BsY2+iawXZgaXFBF+UEGZskQ==
X-Received: by 2002:a05:6000:2c12:b0:47f:7005:2893 with SMTP id
 ffacd0b85a97d-47fc821ab12mr2877815f8f.58.1785406345641; 
 Thu, 30 Jul 2026 03:12:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc89347bfsm4197944f8f.28.2026.07.30.03.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 03:12:25 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 10:12:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
X-Gerrit-Change-Number: 1828
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1828?usp=email>
X-Gerrit-Commit: b9fa635b36ee908de21fafe2e474f288c8d31ecb
X-Gerrit-Comment-Date: Thu, 30 Jul 2026 10:12:23 +0000
In-Reply-To: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
References: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjM5Mzg3MDAwLkllMzNhZWEyNjAyNmUwN2M4NjBkYTdkNzk4ODBjZWY2YjI3YjdiMGU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <448253b9eb9cc817c7591460565354ab7b524e7d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpNkh-0003fi-VZ
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Move schedule test
 to a unit test
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
Content-Type: multipart/mixed; boundary="===============5827852425151572463=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5827852425151572463==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lvuC9n43AN0="; charset=UTF-8

--lvuC9n43AN0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1828?usp=3Demail )

Change subject: Move schedule test to a unit =
test
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 5: Code-Review+2

(1 comment)

Patchset:

PS1: 
> I don't think we need=
 more test runners=2E We already have a quite a lot=2E [=E2=80=A6]
Acknowle=
dged



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie33aea26026e0=
7c860da7d79880cef6b27b7b0e8
Gerrit-Change-Number: 1828
Gerrit-PatchSet: 5
G=
errit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Thu, 30 Jul 2026 10:12:23 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Eco=
m>

--lvuC9n43AN0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 5:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1828?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?tab=3Dcomments&amp=
;usp=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">I don&#39;t think we need m=
ore test runners=2E We already have a quite a lot=2E [=E2=80=A6]</blockquot=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Acknowledged</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail">change 1828</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie33aea260=
26e07c860da7d79880cef6b27b7b0e8 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1828 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 =
</div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Commen=
t-Date: Thu, 30 Jul 2026 10:12:23 +0000 </div>
<div style=3D"display:none">=
 Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Com=
ment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</bo=
dy></html>
--lvuC9n43AN0=--


--===============5827852425151572463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5827852425151572463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5827852425151572463==--

