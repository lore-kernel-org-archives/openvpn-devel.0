Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E259EC5DF87
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 12:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hDhrf4T3U1dDIfGnH+9XpPBT6QRApm2/OnwQ6vZLC84=; b=fCcOlTRYgjKzAPD+6z6G3Kau6p
	N87bNhmVGnq7oLbTzkt3XUjmAgZAvQHG1Xnw+XLRQKWZRCNZJpRESAXfcCcKEOtUflsViyO2UvwMt
	KvfYuwwmXeBcCd1cB6FAedUU4bDIP06MXeJ3oWyBdmdgFfQ5TfzB65mCCDdgiVBUdGq0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxNyT-0006t1-Ea;
	Fri, 21 Aug 2026 12:03:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxNyR-0006su-Go
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 12:03:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8H+O1PcYSkoivE64yRBJNzeAeEVIfyHNo1qob+99tqI=; b=IneCVtX2rxOpOnLC6FT+ciZxvZ
 gpLqJrdsvZTqHbgWkwutVr+CnJ4zHQuE69XN7Do8ka/HcCdfUezD9A5EFfZMkbO8Vsh75t7vMOYQX
 ZmvI6zhwN6Wd0aQodkeCbx6dkbIWVhJM4v+TtNgiwOFOfQT1PxBBxjLlXcGWuhm82xDE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8H+O1PcYSkoivE64yRBJNzeAeEVIfyHNo1qob+99tqI=; b=V
 MXmFF77GQ7rxEWjXKWjJ96simccUL4v0iRMDofkLGQjam0rWWHa8erpS4AG+Hr2K4Hy8CkUcF5koV
 n2x/XRqL6Uzv8zmHEI22fAGFjG3swiD0hrytukBvm3s/oYq77d991j4AEyX5wx1CdEj6W5wdKHRsh
 +5zlAimOVpcElmJc=;
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxNyO-0003mp-0x for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 12:03:48 +0000
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6a3fda88184so1660203a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 05:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787313821; x=1787918621; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8H+O1PcYSkoivE64yRBJNzeAeEVIfyHNo1qob+99tqI=;
 b=ISeg8PpYKw/1nGvNuNXWFAgIuVXA9JmZFBi44B0Q/tmSlbznP8Wsc3uYIaHMXPexPe
 iYQeRpPfdUq4Wkda0hMo8H9IECy9xazXh5nqRFgIyOXdyl17AUIffKC06e/GbzD+Z2l8
 qe2rETbzYFb14RjmUkC7myRzF+tIRhp3lR7034MYEgU57XLgOIUI5mePBQNr4ItBaXFm
 XOaYjfErIhaMPMnVIhShYN8JleLauzSmKSLa0+fxtRhTiio0SgXNjZHsBux7GfuFARTP
 foidbEXfF0eSiBocJsBVc3ltbVrZUguwHWtdJCy0wGzPEZNpyIBuLA3DCQhAfXVjqBfx
 us8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787313821; x=1787918621;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8H+O1PcYSkoivE64yRBJNzeAeEVIfyHNo1qob+99tqI=;
 b=lVV+QBig4T6jTGVuZuw5T5OQOLzx6wQEkZr1ryQlWIURyDV1UU7IPXOli/na6nCQEM
 XD45en5LaTzTA1H22/AdtT7q0swsCHrnP3mLdLsleiTWO60e/R4qMCLcWB0NfjJ83VsU
 4GFNXnZc1fwyhYvFqbEGTQm0VmR/Ehzlsua1wu310h2DHNID5LZtEYax4SEeWOZlrReQ
 PsRMF7U/6E+Ovq/2mlbBagRVmj1m88TZ9Q/xYsYkuOtKpG0sqqH/5C4MqVgJMt0Gtrop
 zq2r+E8wH5B/bYLiPCelvTFzJDtlhkfgSDMRznYMcbdBx4zujp0OKfkxyi1EJ3lOydnB
 jShw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrbj2k9q9EBb2FeVK7UTs0Xwbp0+nYnCtaJYT+ecbnJyuHMqJ8QH44u8e91EKhjQ7nGBK3JZbWKqMVuslSI@lists.sourceforge.net
X-Gm-Message-State: AFuF++mGRYOX87HNivs5HtvVP5L16LadV0g1vCKDHDoMcIii+N35dOSQ
 w0+1g1Y3TAy7dEt+ktBZf8Glbg/uDisp3gS0ViFFdefE7SKCvYYYOYsENbR/OtXfsRPJgBgFnXV
 HnG7h8VWb6af4rp5cIcTjn7/zAjxL8z4hpVwtvmDLIWd8GO5TurL6fuEj3g1l33Ttuwpb
X-Gm-Gg: AR+sD12s8xdSXttm2h52Bpv+mt8rwBBTuQEn7Sux4MkKz7Y2kUltve8S8eHk3/EpdzC
 Jn4WFFyJDFZUhoOPEBdypNOLYI9sYRK9dBLqeqCzZboF+/hH8hmfJT/6TRzRBskAwWxZS7kB97o
 P4x4wBJLVPRkUBynjD5qnaWUllmpRWQQWP2Hbush/5/dZO57Yki3wM1BNjcm8PbrDT3l9UW5Lw5
 jQk1dYyV+DeAOWUF5WxnMQb0q76fPsaGAJdcbplocgkmy+8/PR+ySI4E4UeqFemwwZNlIHUlzgh
 ILoHpjvrXCMvA4imeSXrGcXS4ZS84RbjUyoq7zpUA+LXU1GCwGrJ6nyvI5kcd26NsaHwggSZ0vu
 nsBQnq+Yebq7CnFpDzyxqhzJMIUNMwA8xthy8QqEVmDqh8Bnkn0dTNQVFFq+dcs6H4R0VHvJSvo
 jM4lOfr19JK0MZkolqd0iW717Bc3y1HSChyzUeQIUQzBdkayCmI5hAEbDj0ZSvcrkCqW7I0QJoj
 wLY4/R0V683CroN5iIT0KBrzQ7mbn7JjpIfCVas4tYwx2eN4uLUyH1zYAB0kyfHSG817Gcrv9cq
 g1c7rF5QHuwNDaKrr4YmziZ4gjM7TdzmiuZ+SylPuFQoxF8J658=
X-Received: by 2002:a05:6402:528f:b0:69f:b347:a681 with SMTP id
 4fb4d7f45d1cf-6a42f10d1aamr6854799a12.4.1787313821370; 
 Fri, 21 Aug 2026 05:03:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff0c3491sm6319554a12.10.2026.08.21.05.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 05:03:40 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 12:03:38 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4068bf8175c23151298d142dc920ab89f861a411
X-Gerrit-Change-Number: 1681
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1681?usp=email>
X-Gerrit-Commit: 23e9873e15a43ad7673628a6f7d9dadfa906b931
X-Gerrit-Comment-Date: Fri, 21 Aug 2026 12:03:38 +0000
In-Reply-To: <gerrit.1779197752000.I4068bf8175c23151298d142dc920ab89f861a411@gerrit.openvpn.net>
References: <gerrit.1779197752000.I4068bf8175c23151298d142dc920ab89f861a411@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MTk3NzUyMDAwLkk0MDY4YmY4MTc1YzIzMTUxMjk4ZDE0MmRjOTIwYWI4OWY4NjFhNDExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6aa4a57cc379317c5068b1a6cd050ed07b676250-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxNyO-0003mp-0x
Subject: [Openvpn-devel] [S] Change in openvpn[master]: clinat: do not
 adjust UDP checksum if zero
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8553117132473070366=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8553117132473070366==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AZCqQkSejzE="; charset=UTF-8

--AZCqQkSejzE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

razvanc has post=
ed comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1681?usp=3Demail )

Change subject: clinat: do not adjust UDP check=
sum if zero
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1681?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I4068bf8175c23151298d142dc920ab89f861a411
Gerrit-Change-Number: 1681=

Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <ra=
zvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Fri, 21 A=
ug 2026 12:03:38 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--AZCqQkSejzE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1681?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1681?usp=3Demail">change 1681</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1681?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4068bf81=
75c23151298d142dc920ab89f861a411 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1681 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Fri, 21 Aug 2026 12:03:38 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--AZCqQkSejzE=--


--===============8553117132473070366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8553117132473070366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8553117132473070366==--

