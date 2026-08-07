Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BEEC5AC7A
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c3u4CEqYlyaMvrTuBPF9JuwSC57KFejUfHCsRCbBseY=; b=ebwpNpY5EIMr3mh32Hzk3W0ews
	gxLs/OLAFa2HsnWPgzgqxQl40f5AOgxmZNLAPAQHC7rk9PhUiYKT0/BRb0gYyr5nRiU+oahDVxtPA
	G8GZS0CZMkQL0VUkqoLUUFaHPKGZdWOMC3ZIvXBAMi5blo527eInNXRCnt+RhZyf1/ok=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsIu3-0007eW-JY;
	Fri, 07 Aug 2026 11:38:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsIu0-0007eI-Qy
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 11:38:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=PirmboRslmzNhiXRswTP/aYOosyZASfYh/oT2HZiLjA=; b=TdfhwET9NMK6nxs+Kv6i0BiDqB
 Aq57DQvi8ADnqY8m/8EVklFWr9ZfvERlYslmVrB8fE6vlEyklZXRuaKQmWgYUiLGJBmJbodoylME5
 e2mMtc3s+8A9/OeOPtdBvFWW3BLOSdS0lMEwxgjBuk7PlX5L6M80Ww128WnAOnTY69/E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PirmboRslmzNhiXRswTP/aYOosyZASfYh/oT2HZiLjA=; b=j
 dLfL7x8DX6S/zJ+uZ2hEwSAKoOXwylLcZZaDy0hKtbB+hPg83/aTSBwP4Bq4ieH4XOAfr2Lfb+phQ
 64RM5cGY4QIVEAf0ES6Vnsfqg9PchGS+kozSf/V8FzMqNHhCcf9xprrmvottrYsPNoCIjeeoApyiX
 z1OkTlWTU52PMN1s=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsItz-00026g-LN for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 11:38:16 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48000c5d6d3so275997f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786102689; x=1786707489; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PirmboRslmzNhiXRswTP/aYOosyZASfYh/oT2HZiLjA=;
 b=UWCw491JH8zReOovpef/mEPy/O54BN6wqExfx+oU3cZSctXhjryMTeQCYO5m3SMb26
 D+LlH8j3R/GutTFBAX8bPr2U+rmWdLH4hxa/R4LRQVhX8qOchTTpI8bG9iAB5Tk2XBCO
 lonljqO+EdicR6X308ayNVHsG0Ps/4pDid4dO7ocQYHsY7xtBmb02zCczE1oASqkdvh1
 6XH+wFlpdIF502Iz25/mbCeLNxV3cRC6khULacOyCpJrDp7gfPTXt6g1s3OZ+vEQXwZ1
 Kz+AAVgmgqUzfFig/EN/9YDhjK+Nv3pIS/skNJN2VYaYi6g6M7yFnaBiGcXxqClXuMFg
 eizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786102689; x=1786707489;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PirmboRslmzNhiXRswTP/aYOosyZASfYh/oT2HZiLjA=;
 b=my9rKx+/7HU2rw4sSRjK0kG47RYlFynU63rWNaQeus27KwfHK20dJE2be+nmUKstg2
 yUO8MCDZoWo8cI8k3KSybSphlKq3TjinEWPE9Ku980KxcoHZUJOMD/5DFZV8l17v2lmz
 anR7h/c8tWzPoWWoVpfU3k6pB74TluY6hFhz6DWsMOy7tq7GTOX40vZRaAjPV1PcbQby
 hFrC2182xFCQRKVAltt6qEF+umMWNVx06SqJNAb0jDJqSbI1SPTjpKAZnFhnwrds9NJv
 2riC/aHEfrlth/+oPSztpUzwo/6koKkP5Z1xY6J0kblLaV6K9rYKubTdd5HeWgAyf5ox
 O84Q==
X-Gm-Message-State: AOJu0YxEHKugEZlIsncZ0DfwSrxycfSOIT1SbcFG/Jbs7LGgRJmD3O0R
 WfH468fA2I0oH8VUe9D+tESZS2zvN9IpHMp80pVmtPbBoz3A5gYhBVjxo2aYtpvSaxd8aqe1W9t
 FhQ4F3zq57bzr4vjSPjO0eevQeNVgm0gFpk43f9PbAZ+rpD9FU57QND/qkSVB1rrGyG2qs1uVmi
 TGsfAvfg==
X-Gm-Gg: AR+sD10LxG7J9KvYz9EQjaTm5LxeqKu0TCknznBagI1EWFuozp6FNdAmFJD1GEBUa0y
 a0DUCpsuJDl0hjdvS68KC6hSA3hr3OaWL/m3qTuD+wOOAUpxIBxU95fYZ3Es7wK+xTD/LvinOp+
 eJGxb4MCmTGHlq/57RENUpFZKCdvR4jiThLt/js3/OFcJ3gaA5E1c97IG+Fjdyk20h0jOMiZZPo
 dKQjaVkIBjSJiV/MQ+GDGv2aw+npma1ND8X0lyvF889YxNWv3IKto0brs93muWHJiVs/YI0QrvL
 PJ02VzjXGCYoaWigdXd1sOHlikOzUAbmA0LSZupN0klezwWIs2ed13a0+ExtHFDG6wgy2XvQ+Ip
 vAOLzsbTNu2iXA/PYFXx0T85XMRoqqYxcGC4aRXgO8MYMPGpOvX/t6gh52AXOBqqMvLIFhJn3A5
 7DqTd+P/miz0lvER7lrvWwpvsZ4iZCepuovrkIADQWiyy0jK/yHPlNKRGPg3jjRKOg/X7l0XG9E
 cVJ8F44yP0qqX2yaXX0UoEg/AqtKG574eTUcOrRNwetSJFriNoKwa+IpUR/Bhbs/SNOqlwgXMnB
 Xg+rvaHYmQA2+8dQibQSwrXpv1vR8MpQ2CAHu+c7YaB3UrKmcSA=
X-Received: by 2002:a05:6000:2583:b0:47f:c3a1:244 with SMTP id
 ffacd0b85a97d-480026f58d3mr4582613f8f.30.1786102688052; 
 Fri, 07 Aug 2026 04:38:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021506c0sm4910569f8f.11.2026.08.07.04.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 04:38:07 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 7 Aug 2026 11:38:06 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I752e03eabec085e47e8d74a9b4fa99e9ff267efb
X-Gerrit-Change-Number: 1764
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1764?usp=email>
X-Gerrit-Commit: 15b3e53d9d421b32b5f0c5ee093f8661e3851e85
X-Gerrit-Comment-Date: Fri, 7 Aug 2026 11:38:06 +0000
In-Reply-To: <gerrit.1782933852000.I752e03eabec085e47e8d74a9b4fa99e9ff267efb@gerrit.openvpn.net>
References: <gerrit.1782933852000.I752e03eabec085e47e8d74a9b4fa99e9ff267efb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTMzODUyMDAwLkk3NTJlMDNlYWJlYzA4NWU0N2U4ZDc0YTliNGZhOTllOWZmMjY3ZWZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4fcfe568eebc97dab7d1bb9a80dd83c40fc5856e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsItz-00026g-LN
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_client.sh.in: Do
 not try to guess the absolute path to LOGDIR
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2959055854717371232=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2959055854717371232==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Qzl4wXROKjU="; charset=UTF-8

--Qzl4wXROKjU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1764?usp=3Demail )

Change subject: t_client=2Esh=2Ein: Do not=
 try to guess the absolute path to LOGDIR
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1764?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I752e03eabec085e47e8d74a9b4fa99e9ff267=
efb
Gerrit-Change-Number: 1764
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Da=
te: Fri, 07 Aug 2026 11:38:06 +0000
Gerrit-HasComments: No
Gerrit-Has-Label=
s: Yes

--Qzl4wXROKjU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 2:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1764?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1764?usp=3Demail">change 1764</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1764?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I752e03eabec085=
e47e8d74a9b4fa99e9ff267efb </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1764 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div=
>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Fri, 07 Aug 2026 11:38:06 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--Qzl4wXROKjU=--


--===============2959055854717371232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2959055854717371232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2959055854717371232==--

