Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946DAC9831E
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=brmfx+kkqnXYsyiID9T2ArahxNq12WWTGZy8XnFc22k=; b=ctQfU7cAbtg8O6VYtoxcZa2cm9
	RN71Zqdmxsnjui7fN4z8n18VmkSJunBiT9cpszCnPt1gr/lIk0kXG/n/4sTrd4Yy2msPD4UybrVkw
	N5ppHaEe779GzkUZ26Vs5ELZcl5Qb5ZXgjE7uQsZ/bOfQ3NmYyJcBdjl/6qpLaRP3R+k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9vsB-0002Nd-77;
	Fri, 25 Sep 2026 02:41:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9vs5-0002NJ-Bz
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 02:41:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=eU0+C+JYfl0PY86Ey4WdZ+8cIO5C8kOyHsjrMGSKCO4=; b=ZFa5hCssYYmGJi+t5c+V8U1eog
 VWHrztmGrL3mD/qqO2CFaV0FsEvM6b2Sk5+L+0JtNrQZCtFo1PS5sb0sjpkT7Zb93YK1dBaJ6hilZ
 gQ38C5oOnaxVzw0hdT+9BRtr4SWws37VrG8kYTWGZccw9oj8yAQmLTBYwCLMpllUWkrg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eU0+C+JYfl0PY86Ey4WdZ+8cIO5C8kOyHsjrMGSKCO4=; b=U
 WYtOmVRxQIQZmCZJ1Xj2mAVUJihotKRfONbhHt3dX+ZeGk8qMJHl4yjFL12bBHlmnmHgfkTd+T6wq
 8sTENaqdaevvyDdrk+S8R1KTZGueiF4TV++Q/v6w4taQUEqKup88hRUIGxmEzadX0IFzGL/VEyYH+
 BCKSl66yTPO36qrM=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9vs5-0001kc-27 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 02:41:09 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ff23af865so601965e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 19:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790304062; x=1790908862; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eU0+C+JYfl0PY86Ey4WdZ+8cIO5C8kOyHsjrMGSKCO4=;
 b=VFN5FLXgGk+HazNqoxIhnWxXDDqBdo2UX6N7Ab2GKxZsaepT8iE4CLEoBVJehKEEc/
 xR3bD/hj69W5yg311JaJyn5DUViVPCYdGGHqjlqI5XKXQA7ERBGpBc/9ryBpzqJ74NhV
 LDIpsx5g/u1F34xlXd9F6F3ZhfXb7c/WvgYUmZBVp/785g7SBeCt5TkBzWitYAZiDtSJ
 oOxht3Ehhpvyl5YhKF4xAe5rFk6P+BbeUoBOwCG4Jrv+v9qa3NSGpvmUlK8aRhYtG0Uu
 2slAPKkcsRL2f7uPfFopHCBgj9c6wC3utMn6CTBLNUoKLtZJTXwL4BtArvRL3TA/2D3h
 7SGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790304062; x=1790908862;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eU0+C+JYfl0PY86Ey4WdZ+8cIO5C8kOyHsjrMGSKCO4=;
 b=pRQ5w+kgPyEs7VBYDWl5FMMKzwKRwhjD0Xbv5i4gM9479b+OamxXgTdAReml7VFds2
 FuMHattCGhV5GHOjCnxp7+x+fK3xLTFML81bEa1kPf+nF3dAhb009DrIUbv6flZ/QPLY
 3Pet3ixLxF3rAnw4uiUpuhGvjABTL/w/54Vg77P/RYLGwBGpxSd6bh3nyCj+qD8cJ5Zk
 Mbbi9WvHv5jF8Txt1IGY+IgEaYscRSSK6sdTXrS3slvM75hKpKKm8hYlgktk5ZWF9mVv
 ljxOcCNRHgRI7/GbEtRves0CSsrGY2aqH4ayPSNcbqwYnxj6vCP/sVVGSBHyuiyJirr7
 Us3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAzDQwy19VAKM15DQ/wB+VFF3Hoijv3kGOaQ+Cqx3NkcwTLb6iogJGsPhm590x3UJyQMzFMyp3Pr2s4c9c@lists.sourceforge.net
X-Gm-Message-State: AFuF++mBslwRtETptTshxWDZkY36NPTZidRSnPfhnfXggPNW4dXRGkjR
 idPGHQ0ekKgsuKwXnxWvd9GIOc86HNcgzJGTWaI1ZD5IPLZ+uvQKyuChUJ9OGVwWdMjHujPZB/7
 +2K93xkaZwPmALKJQ744D8YTZwzSiCHaQaqQ0Ua5d+1M/jcjluC7bvByi0PIP3DDVmRd5dmvJco
 9QU8PlqQ==
X-Gm-Gg: AYBFou3X1JKzOsoCktVTuGc4ZnjZcYvvF63hfafy7e89fjXxfpruWY6DiVRNhhC6vDQ
 heqo43/hHIM/ThxwO3iApAX0/Ct/XViqVVjLxnBRA4mew3WmeTTRYQLrIHMZpC0Bv1YxqQsEwL/
 LZ5YKQSMBwK4rsPfkw2BxBaiY2xwsCkn8vlZxYSsc7LBes4I/0sN+PyTvas7bdBZ80ceYuIl4q/
 WToPk2Z+irlHLT5HKl73ja8Epy9JUsVaw8uwnAP7+K1ZobihpmUv69C2cS9WHXJnWhx0usfv3BF
 aXk9f7V74uoh2TkzsZ2OTpd+zKcXmKozKop2uV5ybl1eaDQXzsZUHXGdesyX6qzFiuP7yCEoJLU
 s82VaOTkptrBmJym/ZWpZ6M1NCnvInwNiKTv02TQOnKXFTcUYTk9j3d97nAQhPOD2zobcO5DxYq
 JyvSVCuxzjB+s2pHM1pExealKIpQPRjCSl2zjppOULYg724UuLl9Hl8t4CSl63OYqD0BHyISL4n
 GBjatqFPy4X8ChNEnFGGSIEEUBjfJDMfuhMkbzWDhppeIXX2oohygao8QHSEJTfTpX1sLBVaJGB
 3EZXEQHtIrO9E5EBxjivjJ58KtjLeo7+pMUIjOuFc8CaE+zUetKNsadT3hXK
X-Received: by 2002:a05:600c:1912:b0:49f:cbf1:e765 with SMTP id
 5b1f17b1804b1-49fe667a597mr76065785e9.0.1790304062558; 
 Thu, 24 Sep 2026 19:41:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd4c8dsm131503395e9.3.2026.09.24.19.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 19:41:01 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 02:40:59 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9e45c0edbd2cb237f27e349f2f9d7d9b8d826690
X-Gerrit-Change-Number: 1947
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1947?usp=email>
X-Gerrit-Commit: e2f21c35ece9c04cec0d9a6651696768eb0616db
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 02:40:59 +0000
In-Reply-To: <gerrit.1790212215000.I9e45c0edbd2cb237f27e349f2f9d7d9b8d826690@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9e45c0edbd2cb237f27e349f2f9d7d9b8d826690@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5ZTQ1YzBlZGJkMmNiMjM3ZjI3ZTM0OWYyZjlkN2Q5YjhkODI2NjkwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ffdb91eb1c7b7391339a23f771b72aac0af928e3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9vs5-0001kc-27
Subject: [Openvpn-devel] [M] Change in openvpn[master]: route: implement
 net_gateway_ipv6 for --route-ipv6
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
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3254072429792804251=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3254072429792804251==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Weyc8995v9o="; charset=UTF-8

--Weyc8995v9o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

chugly has posted comme=
nts on this change by chugly=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1947?usp=3Demail )

Change subject: route: implement net_gateway_ipv6 for =
--route-ipv6
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 2:

Folded the man page change from I04974ac in here, and docu=
mented that the
gateway parameter also accepts "default"=2E


-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1947?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I9e45c0edbd2cb237f27e349f2f9d7d9b8d=
826690
Gerrit-Change-Number: 1947
Gerrit-PatchSet: 2
Gerrit-Owner: chugly <=
charlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment=
-Date: Fri, 25 Sep 2026 02:40:59 +0000
Gerrit-HasComments: No
Gerrit-Has-La=
bels: No

--Weyc8995v9o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>chugly has posted comments on th=
is change by chugly=2E</p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Folded the man page change from I04974ac in here=
, and documented that the<br>gateway parameter also accepts &quot;default&q=
uot;=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1947?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
947?usp=3Demail">change 1947</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1947?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I9e45c0edbd2cb237f27e349f2f9d7d9b8d826690 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1947 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit=
-Owner: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Fri, 25 Sep 2026 02:40:59 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--Weyc8995v9o=--


--===============3254072429792804251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3254072429792804251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3254072429792804251==--

