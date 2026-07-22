Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9B4C44539
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L9YbmVETTUerhXOpRd0gg+GrO7tLCYzU6o7ln7uEOXY=; b=X5cni0F8mC9ctzaWj/jTsW6xbY
	J9kr+CKcqvzpBZD0Ip9aB89DFgdYHIsIhXJDazuy/ibG1rUmH6OkPDDCZtsAsx+zr7YKUjNl0+bjm
	OzrNIb/RgmUZB2lQ41cfvGpV7YAcQigU5FAkTUXtDBdINIHaKV0m+PXqNTnckl3/8f+U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmWGW-0007Ld-Gw;
	Wed, 22 Jul 2026 12:41:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmWGU-0007LX-Ny
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 12:41:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=udVq2b6ZXcZy/5FxHBkfEAAyQ0qDgCic9OdXqB3XNKI=; b=MT/HF6YEBHqZFY9U3O65oorcMJ
 6jK8w99BofNMgyyQd8MrBgH7DSuyMmudzWA+eY5Qg5x/Mf+rQARe5SYRYZReDxWz/R3Y6iBaew+zd
 lQUWk/LYeqviuKn0DiRnYXDAYorBFBZsst6YYPEdzf8NMpZUSYreAq9XWgrQgh2SWQ+8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=udVq2b6ZXcZy/5FxHBkfEAAyQ0qDgCic9OdXqB3XNKI=; b=C
 rahC/N1nTwCOA5e4JZ3/ORR78v4Te+w4x9ejCfjOhnehFl9siofXE32164Ab569qDgMqpoMcFyRNi
 SNK2umrTTYF7DV+KCS3c/HqpJzu+hS0XFEKB6nxey6ipMZgPJTUSc0/vJUN0KoMB2ZrCarggLYfau
 By78+DRVIZiqX+JQ=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmWGU-0005Hj-5l for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 12:41:34 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4955158f26aso26811445e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 05:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784724088; x=1785328888; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=udVq2b6ZXcZy/5FxHBkfEAAyQ0qDgCic9OdXqB3XNKI=;
 b=Kof6qYTNzl1qN/VXFaUHv+rkyx3G5vf6WRNPFgOP9OEgFCS99tVBwt2Xyh5FIIM3ey
 wL1zhTK7UaUjorbZqTZBbolzEJS3BzG30WIeHMmtPjek2rpceDgQKgkGrzMWtQ0kHXWG
 U1+f+CH2LdVCvouSSWXJzfl5pvp6FTLus9Pl/9H/BawCUcDj3dgvRyumjHe/8tf5WDTS
 ZWh3mlKBCI02/lA4tpZArPpPM6C3pDyPWMiGOP2h0TIID3mXMLqCzGRGJhFOaYw8d9I6
 5Zx2FtP8JVU3ln4PURXc/ajYxB8YzYtE1sT7aEzG8ztoohxlWYBR1KnalE6+idt5b12b
 SXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784724088; x=1785328888;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=udVq2b6ZXcZy/5FxHBkfEAAyQ0qDgCic9OdXqB3XNKI=;
 b=E2Mr1+jmto+HMbuUsbYG+jJ0onWvorV2HyJU7j3w6zCjR9V+A8SR/6fnDUil7IvnVl
 s6QhmiO70JSCXO0bCIbnAQ3iT95PDirBfG1WM0nBaxseg+rdkeymuCiuetdFk7LX69po
 Lx5W8KmcSgJ3wSlWke6mW/IawdOTIvZURyIGIKmwmJM6P6BoRbkzPzdDLttQq5Hrv4wY
 ed3IENwXacsIyIklTAzgCVSonG5MOfezPWEBrSJzvVFPXUyCMZHoB/ZTOnAZtuWAw/Q3
 zBX6etse5jDAOfsDVlpfqmjh2AluBHgPvouDpIRtQtFKzWU7ZG13C5w6oQgKyQXTgGd3
 4jGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEVdgi5BoHlhHE6AEc6MjthM8glf7fg5nBTai+jAeJFlbDZnkISIJbjQCUiZ1K3x9xlDQu0E1RyPrsUecG@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwUItwOvRqGs1T56NPWWNw+Rcs4SXXxYQqJiJ3XQ53OaaeeVG6Y
 Mavz6zlNev0vNi4cyguEFzlpM8pwIPRVF0dGCJJKtuvYbO9Dz0X0zo4ncJCLX43HquHdGcaa8Oo
 tyIcVn7+68iu9nvsPTvjydN+kupUwnCkYJbaWIRZLO3GNyfImZr9/jEe9o1Ovi6fSVp6D
X-Gm-Gg: AR+sD103jLIv+5XjVt/jjeRKc1nZMfYemvpK6E+TN73FZQpm9u4fLU1n8qjyuPJDI5f
 MbX2hzWVaapBqmlaVd68C1lIB8RTlUXyumJjlwUW9iLAJGJInzbUCWtZt4NOraWcOjTxZu6lb+M
 0I7bo99wv1KQx8zxuxW9id2zBs8Ak+TITC6gEdHAXXpgTdQ23uf2CJkSsGzPNrLOmman4LnqCut
 vSMqjsThqMtfyZ8ft1bSJPgd6mCmdqVNY3iwaHQ59SSeBxgWcH4gqK3HpA4IK6QrufsvSv+IDyt
 yiA2TnOov/3+KdQcztQZj1+xxX2lUVeb+1g4knVeHiEUc3iCNjI/jyp6FfaES6/K5ZkHYNYl/9n
 Ida2tXodAWL28Xs+7YXui5mhpTUIq6ihsqCmsPmIl0Wpt9dtHHtJ3calsDBq+Ijf1Z4oph0KZpm
 TWiatNSOOsPsWSztT35wfdxUnwMPBKhlT0/Lo5QsMcyxr76JkfB+sLgVlGqmURcMpilKapqF1Ch
 tP/bMQX5nRlEmA6Qh9gcIDiYPDbCHMdhqrrpu/+MnsjmZIxmZrfqu5OLsCQFEEfU7ey
X-Received: by 2002:a05:600c:4693:b0:495:3f26:97fb with SMTP id
 5b1f17b1804b1-4954a3e20edmr247775915e9.3.1784724087433; 
 Wed, 22 Jul 2026 05:41:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb57cfsm5700636f8f.11.2026.07.22.05.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 05:41:27 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 12:41:25 +0000
To: mrbff <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1
X-Gerrit-Change-Number: 1798
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1798?usp=email>
X-Gerrit-Commit: 392af324b9480eda6ea96cc2e1f4838d17bdccff
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 12:41:25 +0000
In-Reply-To: <gerrit.1784699722000.Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1@gerrit.openvpn.net>
References: <gerrit.1784699722000.Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0Njk5NzIyMDAwLkliMThlMWVkMDg1MWJjMGZlNmQ4NDQ4ZTYwMWQxMWQ2YWJhYTcxMGMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <db5c0204bf2ac18bae0f777e9bacdc20bc2c29ee-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmWGU-0005Hj-5l
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: limit ping
 and keepalive values to one day
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2201469877933499699=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2201469877933499699==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X185iuE5z5I="; charset=UTF-8

--X185iuE5z5I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mrbff, plaisthos=2E

flichtenheld has=
 posted comments on this change by mrbff=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1798?usp=3Demail )

Change subject: options: limit ping and ke=
epalive values to one day
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1798?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1
Gerrit-Chan=
ge-Number: 1798
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@mandelbit=2Ec=
om>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Attention: mrbff <marco@mandelbit=2Ecom>
Gerrit-Comme=
nt-Date: Wed, 22 Jul 2026 12:41:25 +0000
Gerrit-HasComments: No
Gerrit-Has-=
Labels: Yes

--X185iuE5z5I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: mrbff, plaisthos=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1798?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1798?usp=3Demail">change 1798</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1798?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib18e1ed0=
851bc0fe6d8448e601d11d6abaa710c1 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1798 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@mandelbi=
t=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: mrbff &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 22 Jul 2026 12:41:25 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--X185iuE5z5I=--


--===============2201469877933499699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2201469877933499699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2201469877933499699==--

