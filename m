Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4166AC5DF6D
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NFKkknTMSGFbczATT2S7KhNH7ahNiUIBHDDiE4+ZG8Q=; b=aSFd/IPueo49tRAxl7G6Ixqo7g
	/gBSPGh1iYxwzcde67GV3IhZy8W8q+cAR3lnzyyfv3tWSFXd+duPEpBQTRhzbCVhbiNYyZOmOcHWS
	P3uqxXKmkg6GselckAU2d+MkUak1i9/blIztMCHiwaPA7C93ZM/1nomgQ+JA2T4YHUiE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwgbe-0003ip-Sz;
	Wed, 19 Aug 2026 13:45:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwgbM-0003iR-Ss
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:45:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AxX0N/t5CKFoZLU5tBFTd/LJuEssZsj9Tt7HvF6VMEk=; b=RtY1/X+4jV5+RTw3trzTNuds23
 46ZE492koosicIixuyq0b+2+rTMBpc92JQoTn91FiW984es6k1OMono2M28IgRw86jyosagmPvkTD
 Kkbqju4O5LSyXjCCl5EwB7MpM8oQMjGEyxUWPud7/uZLbKuk8JWIh491lCYw3y/wVcQI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AxX0N/t5CKFoZLU5tBFTd/LJuEssZsj9Tt7HvF6VMEk=; b=L
 2mijxuElSWl5W593GQvvtZpdpoMHxiM/HPWC3ESa5xHg+SS+sHrXN93RmMvX+9WqUjudqgjRJ/Wt7
 POp9tZlAcGMfHqdDDltfvIDs0KJEojMCrNXFK3PP9Wa3I8THp/R4ULcLOIthLEYt8RMA3VY8vWbfr
 MHZWr207Eutjd2qw=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwgbL-0004IK-MA for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:45:04 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso8767165e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 06:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787147097; x=1787751897; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AxX0N/t5CKFoZLU5tBFTd/LJuEssZsj9Tt7HvF6VMEk=;
 b=PbnXzmFRpg86kSBsVz3wWvhfZ2jVXSFYAAWrqjnIx6sKnxwswatHn1UYT0vKH2x+ct
 4GGJxJHwk15qfp44v2m2huFWm/PbCuYFs9F6gDwWM+C0L4R+rfk6BVqOS4zl37a4B+AQ
 0NgwH35qlR99D3oXH/NySegIHcappRIB6mBF903OwgJPnMAvtQStGNBjKEiuzw6VwHQH
 eodHmwjJjdgYACbugu03HCLspBNhVo7MTwlXxinjM/5OHseWiVGUXjL2QeJJWyF2r0XL
 Sf+yzO0ZUwWUZ1zdrePuTLS27a+VgDXPd0sV01fNsHYsypHps5Ya/g9ES1fB3ANtLGas
 udmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787147097; x=1787751897;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AxX0N/t5CKFoZLU5tBFTd/LJuEssZsj9Tt7HvF6VMEk=;
 b=JOmuqLdfudczEwifXA3YOwAHvgMZu8PTqL33Xdwp5xqC5rxu2uuc1oatdtYwjDcYXy
 XX7gwuIKuHIdCD+g3M9KbSGCojnyQenBNHGBZx8yZqJ3JDMZnzrK4iz1u2usr+PjrhFz
 4P9uEMVx59qA9DE4+VcOZblMvD0b0pyfJSBUya4cK/USQaXwIJFW39Q2tDYb7iJSu6PO
 3zGhv5+4SxZRth+SHcU9YgjKpmS8k2l43ImxB9CxVL7j0IEWHe/FiUmmFmkqyDEEdOHg
 sN6zOUzDSO++QcEuG4JFMzvQU3+5IKevPmkZaWZD7b+OoxaZaXsCmY4UJ3RMK4UYpklI
 wdlw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRTNV2gsPdzfSMQMP/7c1WacHMrtbLI7DBj427BOKVcYFnxYChw8KDJ8hvaxpOKU8vi8hHiUi5QsoXlhed@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw9I0tdlKHnJZfmJj+RY/xwAHDQyaDfo54XHp9GWJoQN6rIYfFU
 5hjF6Pbh0qbAAhx/7sLDnnuyIqj3/S3lwjn/B98iiR0V2MF6DyChl9mmJtnYRMQq5fzoj7n5j2B
 5T/k/3FtLgXXPLFaa9mbSK8jS3ii1O/vuy6ku+Qexgu/fbl+iIGnq+SnEhgI45BoAYrUlqJnDP2
 pAD62ngQ==
X-Gm-Gg: AR+sD10Ow9RI9vobaxHD9QBfI/3dLZdHHw/74hLpXHHPIZL4x5UdjFSjoHBuij/WywK
 /KloVlOIDblbfE7F+00/IcxU5T9xVmyK8cfc9Nx3mZLy5rOG3xQQtW9qLQcX8iD/AoJlqOeDLTv
 KzLVQIwzOVWMNAiWAx6rXR7yAZpEofsPhjlBOXX5BKX1DHyYs/JeWGrpFI7LolxS2oW6w6ntlJT
 DJbXjhguCwHeO7BTJDdH20lMrq8VmtvovT1zVVkAB8en57Sr3oR5mb+S8KyqMmh3Kg5AYl5bhuY
 L0cd9mvVG0rq29aNssYH7a0WuiPuWQfFm/uLVwzFBWeZS5g9k9nqoOHJVCaWuCrg9DStwMsXa/Y
 LLKJBD5YC/y2X9lGwDlUyEHV0jNKn4CvDgvfeletrRsPnPhyl9RJlUbECYXy+xsf9NQMIMG2/Nu
 GjYW/4dVmBHEMQi7KQTdF/6fvYcW2BgRTvk1sQoE0GNjeec4n3qhywRJ8r2uSEDuSZf4gB0wPi/
 jdNDgARHmtBx+gy6vN7biAPmBp88e1TKDt/R/Fv5lmBoXpbJp5ztP8+plFPglA45Ns/UX5pinxf
 ADkdKFJRa7mdxThnGoeccz6n/EBQqV92EUtvsPHxMW7N5mHi2kmb9LRG
X-Received: by 2002:a05:600c:4e55:b0:499:a07d:a482 with SMTP id
 5b1f17b1804b1-499aa1a28efmr105526545e9.10.1787147097449; 
 Wed, 19 Aug 2026 06:44:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa175d0fsm63603395e9.9.2026.08.19.06.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:44:56 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 13:44:54 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
X-Gerrit-Change-Number: 1793
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1793?usp=email>
X-Gerrit-Commit: 79cf63c31de059817d36d8e0c8b32d2ca45b0709
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 13:44:54 +0000
In-Reply-To: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
References: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLkk3NmNkMzhmYzRmNDNjMmI3NWVkNGNhNmI5YTVjOWZmZGJmMzMyYTBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c560c72fa1c8dc381944b6adf446ae0a3bc30ff2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwgbL-0004IK-MA
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Reformat all
 shell-scripts with shfmt
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
Content-Type: multipart/mixed; boundary="===============7796578256633628259=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7796578256633628259==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t7LBXMlOyes="; charset=UTF-8

--t7LBXMlOyes=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1793?usp=3Demail )

Change subject: Reformat all shel=
l-scripts with shfmt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 4: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1793?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
Gerrit-Change-Num=
ber: 1793
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Comment-Date: Wed, 19 Aug 2026 13:44:54 +0000
Gerrit-HasComments: No
Gerri=
t-Has-Labels: Yes

--t7LBXMlOyes=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 4:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail">change 1793=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I76cd=
38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1793 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 19 Aug 2026 13:=
44:54 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--t7LBXMlOyes=--


--===============7796578256633628259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7796578256633628259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7796578256633628259==--

