Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2714FC5CFEB
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bhu2El5UeiB9zNfQmE6mi6KFjZdUnN7F0QiU3U3d+iU=; b=VnXX4y3sA6xVWK9XMktGD8vExe
	qZj8iCV+Ih3G4dmkXXQJgHjVzHeKL51Fo0QDPnN/CLRmhQ/jeggGp/0D3g04CC7CP89/tKoLSsTst
	x2ZCd5uYEM6vjYtLHzhVOcu20DGW5B6sp/IdtTKWmp/tYwEKCB765wIIrODlIN6xmU5U=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuWtc-0004GE-4y;
	Thu, 13 Aug 2026 14:59:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuWtJ-0004Fq-PW
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 14:58:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+hQRgWJB9dNcmNB1uPDPBHKqSpJb20iq3x9xcFOyDbQ=; b=Wk8B9jyhiBRBH3a1Qv7v2Ex2X/
 U39JRECLGs5j1JPAf0wu8lAIOVhqRrCgIBj4jka5DY6IPVKSj7R00Qv8dYx8eiqjlpWQz7ByclhPy
 3U8BtNR6N0eMIHzUslDBFAahwsBQwEmAtN8GuXsrEZq0WeNTBNZpu8PwISwavQg0yI8Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+hQRgWJB9dNcmNB1uPDPBHKqSpJb20iq3x9xcFOyDbQ=; b=i
 GW01v+t44zmnQ/YTgprufyMqr+DTUg9XdKLgBOOj3r2+r1IhLmo0yOLYi2cNCDPUjT2hpf0oBE7Q5
 LLKOYeOjCNnqSzL69XhA09Kxfn42/blouLfh7TAQ/uXYuI0t5IuHyiwSPDbWtyhnWLzhVwNedu8vF
 Yn0yUGJ4R/YwWRa4=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuWt6-0004F2-KE for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 14:58:31 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso387112f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786633102; x=1787237902; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+hQRgWJB9dNcmNB1uPDPBHKqSpJb20iq3x9xcFOyDbQ=;
 b=fq7PZiU0XsaIepcTOPOCyXSZjj8MHs512SguIJ7Q3gSxVTYY1V+4grYm85HJiqiKkW
 cFuW/0dXaUmohDNfcE5Xy9RuOPUuPx0CjaZtrhR5O8xOi1J1mBXpUw/TRIOKTC8qZTIa
 xbddmeCW71/dlzWtp/hbympfB0yhss4Nn83vi2/kwfFA5d2othHqWZLJdL/IlrZGOe32
 zP1sTLwJ0OuN4QHdi9rS9BgOjRqzY2T4mAvsLmxMttDKlAXOZy8cCqr5rxnhH1OggHjL
 jjWOyN06p+7/zbQ9gPFJu7k+TiEQ+qT/xkdS8UQVnhevPQG3gJnBoYo4ZFDHDULBSvve
 pauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786633102; x=1787237902;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+hQRgWJB9dNcmNB1uPDPBHKqSpJb20iq3x9xcFOyDbQ=;
 b=gLqKN/mFQ0ihED1n0XZXlnMbgQivlyoUB8Y74SSlNh4bPs77WXA40Z2oeLr/3HCtWU
 EkOreEOusSFmTeZu1PrzlsgAejMy9NiccYClyaREmghXsM5MyfBVxCRtyLLDMGfjwKaY
 DUhdNLZgx+LrSmLnUiYP2/UpCi3gtCG6eg0wU6tbt+Q/rIfDnnZcm6wkyL7RAnB/WBqq
 Ad7PtMelhIiE3qe6MK96SnS3VNvYjpcOnd3Pul3JmHn0Tpkb761B7IHcM9TSkQNmcPcq
 x1qn/iPsFnb4kkSgr48pfx0GBzNHmF/iZFq9vT/7vtNbpcNnMmf8EF20zAHwpM1qwMvi
 WbHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNymPNBTR16cv6vxRgik79H0q+7HVpEcfXT18dOhd7I9T+6Rp/sP0GHkv0Ett861unjej5jObwa5HzVHY0@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxtyYL1dIYNGVLIbxsBdDR4vXw3VbDUJXni0p7K12kaBVWIbp0c
 BnW53wgX76lYlWLEHAcGevUmUtXINUHUU43pViwBizllIGnRS8cnzBFqLtLzGf5LQ4g7zs6kkv0
 BkmunLASmmVN5jjaDIAMRDbOsH1jsH5Km3m+TbpKe6f+/9fIe2vM3kPJxum1SLHaA+D4l
X-Gm-Gg: AR+sD13HBt99/DZtobC8siDmHthl7QscmEthWiZnWJUbKI7d3/2HJDqc3MkYd+gIakZ
 XrTUZyaSPaOlY3lwFDN+d27Tll7CVfIvxJSslUulhwMhVsNvEp5PXIoNLAhPy2iNHSnfFOONqJ1
 hyZOfW/jGXteAHr8F/vOeGfUKt9/tK8fK9hvFDlLIpeJGbfOYXL3x9zTgx1A8FWjVAxZ0ZTnbcb
 i49qOppTRJ54iArRL0h38oewmwKKWozgyVdRziahcRLSAW5ZALoVdLVCppI7Jn7y9GZMQ4j1Z/4
 pcWyA4rv+nVVwZM0488aSACl9ArX+6O/vvXzrdWthvftIDj9FTBsiq9xZ2OCqS5tR4ax9NNv++P
 KMCD3ZUn3YOn9GJVEkBomZ9Ab7NYxY4l38YgEg5IinidPqLLaGjIZqkNcG5BB5Bf1PHH1vw3wAb
 KopDlSLAWFyN8rSEG6r9Mx6vdKh2vVPhqT7VovJMKRafiex4Nz1VBh6f/WXqnsHrdu27ebZzbsy
 UVvhm5EDe6pOefPiRP9o8MT6UwBaSajXda+7K5LN+6ddZWAVTW6CvxmJdPQRUMK7yF8khu2zR+a
 mfUtKtVTd8wadJLYw9xmUXvOExO1YqGdMiPImCQgVzpZl+9hpnxBPy9Hly1LiFEy/iR6rbJ0lg=
 =
X-Received: by 2002:a05:600c:1f8b:b0:499:81ae:1020 with SMTP id
 5b1f17b1804b1-499821e7fa8mr78717045e9.11.1786633102399; 
 Thu, 13 Aug 2026 07:58:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981e47441sm51562775e9.4.2026.08.13.07.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 07:58:22 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 14:58:20 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id8524d9c36ea913d557d3f43f1f62acc4186b4eb
X-Gerrit-Change-Number: 1843
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1843?usp=email>
X-Gerrit-Commit: 053e6a74f801d2670d17bcd667d775f87eda4bfa
X-Gerrit-Comment-Date: Thu, 13 Aug 2026 14:58:20 +0000
In-Reply-To: <gerrit.1786632384000.Id8524d9c36ea913d557d3f43f1f62acc4186b4eb@gerrit.openvpn.net>
References: <gerrit.1786632384000.Id8524d9c36ea913d557d3f43f1f62acc4186b4eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NjMyMzg0MDAwLklkODUyNGQ5YzM2ZWE5MTNkNTU3ZDNmNDNmMWY2MmFjYzQxODZiNGViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2ed1e174ddc4b3f4ecf1037ec1234dd7f4ccbf84-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuWt6-0004F2-KE
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix format string
 specifier for size_t
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
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net,
 gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0049415912211505553=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0049415912211505553==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F/MBVitORVc="; charset=UTF-8

--F/MBVitORVc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos=2E

razvanc has poste=
d comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1843?usp=3Demail )

Change subject: Fix format string specifier for s=
ize_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1843?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 Id8524d9c36ea913d557d3f43f1f62acc4186b4eb
Gerrit-Change-Number: 1843
Gerri=
t-PatchSet: 1
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer:=
 cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: MaxF <max@max-fillin=
ger=2Enet>
Gerrit-Comment-Date: Thu, 13 Aug 2026 14:58:20 +0000
Gerrit-HasC=
omments: No
Gerrit-Has-Labels: Yes

--F/MBVitORVc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos=2E </p>
<p>Patch set 1:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1843?usp=3Demail">View Change</a></p><ul sty=
le=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1843?usp=3Demail">change 1843</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1843?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id8524d9c36ea=
913d557d3f43f1f62acc4186b4eb </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1843 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;g=
ert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Comment-Date: Thu, 13 Aug 2026 14:58:20 +0=
000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div =
style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--F/MBVitORVc=--


--===============0049415912211505553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0049415912211505553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0049415912211505553==--

