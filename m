Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCCBC5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rz2yNGs3ooAodxt4BtPy92H6M+V4ydOR+W0nJq0iuBg=; b=TT2vKrekYHP2JuC6DLaJQB0sc/
	45FczQXANo2cpSgXZj8saOnbKD7K2wEJwpZjP8tjvsuLzZjfqE+Eo40yIakpiVgQzlsZmKb6oaPxU
	rz2LnYQajgbJ557Yna1CDmH3K0K+Myp/wB/qZjw3OqqRTE8fIhqdOpO/r2kI1i5bUtcw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuWmB-0003ZS-LJ;
	Thu, 13 Aug 2026 14:51:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuWmA-0003ZM-30
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 14:51:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zF4WtspJYzEahfcrd8m4lf+5eOA2pKQCwdHg8SWcQJc=; b=b5ksxixx2vhX/foJ2B5K3KvFVh
 7o5rqa2rxLc/8p5SlQTPpBGRm7onC5UrwgKTxHrh9f/upV6hex17Cn2wruX/3TlNnhUIc257sJXaP
 z2+3iFoIpaTSNATinnzZj3cdyg11x6fAEIumI7sgUci7xIIpn77KLoAs0xDnre8cug2o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zF4WtspJYzEahfcrd8m4lf+5eOA2pKQCwdHg8SWcQJc=; b=I
 7riT2PG5vzDOq4Nag0IzROFhkNlGBtcQz4JKCfyrOjfNNcnvzz8ujg7khTSbvvEO51H2IwsBrPJdE
 Towf/YXmOJZ5aa2VauAlMxACLaTViNCMyPBYuHPk6FwcDgxYkhqhDg4JOAARZ67xU42bvcjVYWniP
 WVMRld1sW3nuTni0=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuWmA-0003zG-ID for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 14:51:19 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so16607885e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786632672; x=1787237472; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zF4WtspJYzEahfcrd8m4lf+5eOA2pKQCwdHg8SWcQJc=;
 b=Xa2c76aCpvBF1oQwu8NnGXZXwlfh6xer7e2ineo4Y8gMc6q6ErmeVifaF7NPq0ckZB
 AXh+FLwwbPVstw/fxkxZIDVuBSb3i9QZAKwNDLhZJmKKrZG6CpvWe/dIeIVMIJo0tXEM
 Lbdlnajjsny0MpqJ8bIu0eZT8iuiQhHEH1XbrEuVD+baalwfC+MhgEec43EjtFPpF4Vr
 /E4w2qlo76xAKVWSgOuw/8ZvrXzIregNPyRZouw1tKvZeSoG7zo3vsKFZtTxwIq9vhzs
 feBswwUT5xvsC5r1w1av7rB7DOsw+XcXqlmkjZKIIZrcE084xmYGxNS7U6gU6g/0pLx6
 7q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786632672; x=1787237472;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zF4WtspJYzEahfcrd8m4lf+5eOA2pKQCwdHg8SWcQJc=;
 b=q8tOZohMP8jDPzWiM7Ti4Bry3iCAi4XkmHHaIUs9c3C9O9HsAz/S5jvEL2DDJ2087q
 OFb5lxVy6kZSCe/i6wI9qhn5PsQC4yqrqPHJbA80y+LW+eORtnlJFHymxGMsFWOZahZi
 I+iVMj0NrOMpx5cGPBrDdgpctWspyuGXPDrLlYG7iBMqfN4iaFqRlk9guVrMbJvH+8fx
 TqGVSbXbSvRRMVAHVmJQ4Xc9DNfBaQMbeM4uOP2DMhBfI586ZcFidq2BbEZocW1Pc+9j
 5SSkb/VMsb/x9bF3U4bqeBTA/5+W31D0WQEPRy8BYf2G5Nzy9bvXx6YLOnqWHpp1Lbyd
 j5qw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSZLMSYkX/RpjYqxE7HPUusTvoh1oA8A/ZPuxOpKOprcaLq3cb/d6BsTF8jdcBBC/MvrwCSi9tI957A1im@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwvW3f3dIo/Daw+k0E3QpX3ODopRFHvlK3QneQnj9+MjERHj8nb
 b/8AqmbiMBWDCrkXvsbUdZ6vrtHY8jVYTe/JvEyqZAMUpy8R9cpiFI9Z3tKuUF5KbpzjyW5/9+b
 hY+2OlELboTS2ATTc3PmNKS+53GeBOj61RaC1FMmJf+K+XBP7bqYh7rJidpaoVAzpo69E
X-Gm-Gg: AR+sD10dKzgAyOCUVUX/PcQ32r1COvKV4YStfRQpD3nQg7lwPeEhlotYGiG62rAxVlb
 pHRoOni8R5btWYp790pZZVwv84ARjLKVLj4XbHUp9f9/joWIKYN2uqqzDJYHhQ1g8lX7q12ASI5
 HjnUIHbcRiDAIv5wBEkQBPCVDLgw60y7p9kBodNmGuz+Sc0YsjZCtI4ViMZdNK/nR89kqvf6jIv
 aZ9DaI+SpSBx4gayd5mh9ZNanj9ke+27GvJfsU6Vr9kff0lhScdie9RG8t0zGK85UepBJRxNzKr
 078/kJ1RfrozqKQlyj32WQwK8uhgdIvd6qGr8CKUqPJU3yGSgWfxBEe7RTkCurCdSHlWfoYxIDh
 kx2dZFyAI30Ve8rw3h43GccvfOcERrsi3PxRmdzQJajeFRl5R26okY4WU54/EbSZNCk1Rkw03D/
 UBNbVeHDOw52mXpgOpktoBNJvc9r6Xi1LfylkwH/LSS/bzY1cphSZ8KwB4r0WadhBTjEM8IWJd+
 v9CDOcohurZYcVQOaphHqzyFoqvP1tYI4Jt7Untp3TfX3QEn9ejEityX0EZK1fcbMQ+mTpIJdI/
 9ziNJo8gIUkL0UJMLkAVYHGZIJdPx0pXqlxbc+E6npyDJD8gDP0=
X-Received: by 2002:a05:600c:8b16:b0:499:491e:4b0d with SMTP id
 5b1f17b1804b1-499821ee720mr72129395e9.19.1786632672284; 
 Thu, 13 Aug 2026 07:51:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49982130365sm74752155e9.7.2026.08.13.07.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 07:51:11 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 14:51:10 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id8524d9c36ea913d557d3f43f1f62acc4186b4eb
X-Gerrit-Change-Number: 1843
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1843?usp=email>
X-Gerrit-Commit: 053e6a74f801d2670d17bcd667d775f87eda4bfa
X-Gerrit-Comment-Date: Thu, 13 Aug 2026 14:51:10 +0000
In-Reply-To: <gerrit.1786632384000.Id8524d9c36ea913d557d3f43f1f62acc4186b4eb@gerrit.openvpn.net>
References: <gerrit.1786632384000.Id8524d9c36ea913d557d3f43f1f62acc4186b4eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NjMyMzg0MDAwLklkODUyNGQ5YzM2ZWE5MTNkNTU3ZDNmNDNmMWY2MmFjYzQxODZiNGViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e4694222390f1c17991167bd3b6c6feb933a16f7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuWmA-0003zG-ID
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6318372226560426830=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6318372226560426830==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QI1BphU3Vlk="; charset=UTF-8

--QI1BphU3Vlk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos=2E

cron2 has posted =
comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1843?usp=3Demail )

Change subject: Fix format string specifier for siz=
e_t
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
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: MaxF <max@max-fillinger=2Enet>
Gerrit-Comment-Date: Thu, 13 Aug 202=
6 14:51:10 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--QI1BphU3Vlk=
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
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Thu, 13 Aug 2026 14:51:10 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displ=
ay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--QI1BphU3Vlk=--


--===============6318372226560426830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6318372226560426830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6318372226560426830==--

