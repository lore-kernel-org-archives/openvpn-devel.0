Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301D8CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 23:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BEN5onMlX1lzJk2TOywLtE7kisACvk3bZE954kTqsuc=; b=lXNjLQo7uV4FrDuQQ7/yoyTlF9
	Hy9KyrUJz5T2AeIvdLrSvY4SX3iVwUdnJsornlV1EqVBpjnyXHMQ18yp382ox8snvvi4/lOYa0fOO
	IOE2WkFLZV0mocXQ9T3v3lEN32/pb9ukyYhTegTVO0uCemmMF6FP8KC9IOT/+lfFaFrw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIEF4-0007xL-3u;
	Sat, 17 Oct 2026 23:55:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIEF2-0007xD-UG
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 23:55:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bxc7niFzj5iq3BahYLl/W6WHH8hgWwxuqs6PXCCU97Y=; b=ZMxIH6YfxqaiTA5CdzTWk+ZhYC
 l4Vaj5bkUBoaaqktaVliNiP1ZgwhIVbLR/8FwbzDtC/UbIqsoAPAZ/+9dhr3DVahyU6S9LmeLrd6x
 ZLjteuC4W7g+BR0/oXI5w/KKPYKPdEwvb8xMdrzdP2Ls3W5GejJ8jS3Nu0HY3A2z2BQ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bxc7niFzj5iq3BahYLl/W6WHH8hgWwxuqs6PXCCU97Y=; b=m
 NspmDyRk3JNf7nn64YvtHHtZKXtYGZXHnEIFagXcMN0+63+AFydRIFx1wqWobFHJrDivCCjkX1xB6
 Ws3MK8ljBI8W4b7AGauiRacEayo2G/n6t9DfM11mYB8A37IFcDfWHCLtv17uBnYFRxkgTGeeihu3T
 VZ0/joTqYem84sX8=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIEF2-0006nW-8Q for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 23:55:08 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a1e3b87ac5so72715e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 16:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792281302; x=1792886102; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bxc7niFzj5iq3BahYLl/W6WHH8hgWwxuqs6PXCCU97Y=;
 b=cN0xhB2LKym34xCsPgOTq0Ar5pNMLXZR8iLT9z0siNdToV4uZD21Zo1mkntlcMPsWy
 9K8jS0fBMkQ9Ro35LiO7l2MrJLmIlal/8q1mmiU2ig6BHQeTq//HUhaEhGrdnrcX1r83
 FchT7zJEUzXSMZ0cY7qLAUdI4K88XROSzg5IoXEe+4SxYW8s5scX3KjNzZ3bn83XdbAH
 dD3u+OgPpqv/e8TVvmMJgOsvbpcp7WDHaQEHZedFD/1HIfaidLWqk5MPwXJvlhqlTLoz
 t3ThQdIUGl59e4s5dJh/nb5NBUQzyNikHUhzZbWD8puEMrP0aOFifberVVZ6oiQuwZby
 eGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792281302; x=1792886102;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bxc7niFzj5iq3BahYLl/W6WHH8hgWwxuqs6PXCCU97Y=;
 b=A5g6tJiSfMkATReiT9miof68nzci8e66T8y4Iwrn01kvoJGYSL+BUW0XhQaevEkosw
 lFx51UwDXhIq3f33srkvIcc2L+P2KkXGb30en5iHaSDyhwkNd3k5mNyIE9nR6fL6v63K
 6E3Dp6w1sjZTp846BfzFKn7DsMvHo97sc2RiR35hi9bfZBRtBpYISutr/ZIsdoCKp2oS
 zxxmM4JZIYutrOU0JoryukGpGud6q/nJTZz362qTZ22M17Iae9abvY3JJBSbcmfxTzGb
 1znBYah2kFAOZIUEpoX3/yfCtuu1Wu1QG71jGOH2Oa3ltH+ZjdhcWdoYH1CoruqltRhU
 2ugw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSZvFsT971y/m2/vpPxRxyDLJ+AOx1QbPddeBQWZ84A/KRQ1msTGX7cPLD6bRkVxBRejnF38qRUsrilRQ4@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJUfJionPDcKCyVyOBzuQKKhcz4fWR7YY4Bmue6dZZPxf+RMR8t
 GZxN8TZ/y7TQ6z5LGaDvRt8q7b1rFQefam4JEnylXEWM5YR1C3MOlAYWyWVeY8OOyPd6VzsNUEr
 Pw6o0vWaLRiqpQHLwo1uZbkIFkSg0GI3uMU6q1SfIrX9RJ9ujVXhLvoAVYCbxBYGiPij5
X-Gm-Gg: AYBFou24AegasvXTUGtdixFH2BmgL5L9R5Z0kZQVmP+288kz8sr0WfMjdGG7hNuXyBr
 5/B8e8RlTpTb5N6W6kDT3X0aMaSFmbd2ktzW53miSovZsu/2wsFzQn6i+G6mSE4lcyGLIIXx+wj
 IbYZp6egODFJaTN97BGM8tgtTEwQsdVD2TeOIDEhvuEcIRSf69t/yMDPms2jMBJY3a4igt+FTg4
 K02BXqMp4SYD0IMHACQAC2gWcM3D16l+fPVZ2LH3X14P+gc35chY37ONiPq7GOeYb+VYrF9U0UJ
 czffLHfMCA+y10j/4yR9cXcxbMjUwb5E4UtIym6aJLx2VK8uImr5tc2YGm1lL/qm77/oDf1ET2C
 b+m4hG7op21NyINxaE1h+WAb/FNZ5IvQwR6213uPe6a/xGICZ/mmmeaGDxe1Q7XnHU25trd2xMD
 TTSPGkX/5mRz2ci24i+eXA6/C2Zq7o6N1YSbMo4fgX2ed3Z3hEM83q5joDt2IHIgZm4x9tdrJDQ
 63wq0I6ze/PLzdqNH8MPljHsisTF/cpRRdxtO+V4725fF2OrHXw3qsxC7Zp5+gzxEOaDEXF/Xej
 w0lkefdbFfNukytye3l30pmFiXL2nnncrKVPGwc8piY52rjeUlzhT5SHQ3Lq
X-Received: by 2002:a5d:6ac7:0:b0:48d:fed0:ccbd with SMTP id
 ffacd0b85a97d-48e07fa702amr4810735f8f.34.1792281301564; 
 Sat, 17 Oct 2026 16:55:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd503d78sm13319516f8f.50.2026.10.17.16.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 16:55:01 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 23:54:59 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727
X-Gerrit-Change-Number: 1786
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1786?usp=email>
X-Gerrit-Commit: 8a3b7286141a31ae051b81d827cb398480f3394e
X-Gerrit-Comment-Date: Sat, 17 Oct 2026 23:54:59 +0000
In-Reply-To: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
References: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk2NGUwODUwZDQ4NjQ3YTJjMGUzZDM4NWMyZjIwYTlmNDQ1OTMxNzI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b14b84ea5dbd3d92983d5b1a1add6c5694bd7858-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIEF2-0006nW-8Q
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multi: assign IPv6
 addresses from a tagged subnet-pool
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2382986714973418250=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2382986714973418250==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qZyOVbP8syc="; charset=UTF-8

--qZyOVbP8syc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Antonio Quartulli ha=
s posted comments on this change by Antonio Quartulli=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail )

Change subject: multi: ass=
ign IPv6 addresses from a tagged subnet-pool
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

Changes since PS3 (PS4/PS5),=
 rebased on top of the 1783 changes:

- --subnet-pool-ipv6 is now validated=
 when the config is loaded: network between /64 and /124 without host bits,=
 gateway a host address inside it, unique tags, no overlap with another poo=
l or with the --server-ipv6 network=2E It requires --server-ipv6, --dev tun=
 and --topology subnet, and is refused outside server mode=2E
- The IPv6 ga=
teway is reserved in the pool and never handed out (IPv4 and IPv6 of a clie=
nt share one pool slot)=2E
- The remote end pushed in ifconfig-ipv6 is now =
the pool gateway instead of the server's own address, which is off-link for=
 the client=2E
- The IPv6 tag is resolved again after every client-connect =
handler, like IPv4=2E
- The server routes each IPv6 pool into its tun devic=
e (route-ipv6; on tun this is gateway-less already, so it is fine with DCO =
too)=2E
- New unit tests for the IPv6 validation=2E


-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727=

Gerrit-Change-Number: 1786
Gerrit-PatchSet: 5
Gerrit-Owner: Antonio Quartu=
lli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Comment-Date: Sat, 17 Oct 2026 23:54:59 +0000
Gerrit-HasComments: No
Gerrit=
-Has-Labels: No

--qZyOVbP8syc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli has posted =
comments on this change by Antonio Quartulli=2E</p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Changes since PS3 (PS4/=
PS5), rebased on top of the 1783 changes:</p><ul class=3D"blocks"><li>--sub=
net-pool-ipv6 is now validated when the config is loaded: network between /=
64 and /124 without host bits, gateway a host address inside it, unique tag=
s, no overlap with another pool or with the --server-ipv6 network=2E It req=
uires --server-ipv6, --dev tun and --topology subnet, and is refused outsid=
e server mode=2E</li><li>The IPv6 gateway is reserved in the pool and never=
 handed out (IPv4 and IPv6 of a client share one pool slot)=2E</li><li>The =
remote end pushed in ifconfig-ipv6 is now the pool gateway instead of the s=
erver&#39;s own address, which is off-link for the client=2E</li><li>The IP=
v6 tag is resolved again after every client-connect handler, like IPv4=2E</=
li><li>The server routes each IPv6 pool into its tun device (route-ipv6; on=
 tun this is gateway-less already, so it is fine with DCO too)=2E</li><li>N=
ew unit tests for the IPv6 validation=2E</li></ul><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail">View Change</a></p><ul st=
yle=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail">change 1786</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I64e08=
50d48647a2c0e3d385c2f20a9f445931727 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1786 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Antonio Quartulli &lt=
;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Sat, 17 Oct 2026 23:54:59 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: No </div>

</body></html>
--qZyOVbP8syc=--


--===============2382986714973418250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2382986714973418250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2382986714973418250==--

