Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D793C61DC4
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nXUPITMVY057kuOAyjgTXPI4VhNP89XWj0Mp6hkwGyc=; b=E+SrESz9qUhK+hxcTLfFpfxBqN
	qeIMP2VnXEqOfJmavTW1nKcIiJeWRppoKYjhJNVWHh3HcDSWgsWM8gpk5CypNAyy4FM/FvL0+ZAjf
	Ky4iPaDu5tSUWpdL/CGqsEZtRKZI/PoWKzyGjrg3cA18wdUunXrsEnD7TM3zHiT7zuSM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzJl0-0000QX-Ii;
	Wed, 26 Aug 2026 19:57:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzJkz-0000QR-Il
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 19:57:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MVN75ptJofpoif2WLd2kcKz5iBPlZCQuAyqhqZewgOI=; b=YnZ2P+WwmJlXxbrIW7tZt4I4Ww
 oCXi4mHqa2Ux1U8BdgRqFYh19HXoUeSQiFzmbJ88Qc0FCraoS2WFBRJM8wjtQaQ/6txtp7/45YJYw
 l2BTlIw4gD7kiwuaoeps0IaB+U6LH6UYSmuZdIdJLwBmvWwAPaKnadEID1AXjXzOlShU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MVN75ptJofpoif2WLd2kcKz5iBPlZCQuAyqhqZewgOI=; b=S
 LsKlOe6p9ONDval2+46LMsEoVSESWtDCLrEXnh6J2AP290uxvLoNlJalJSolP3Yuiw1UqXR+/mcyf
 jFnHzzlrc68HPtVq0gTlM9e7UwycT4Q9sng2cJX2FaQjomnuPYd/4ZhdR0s9c11n7J3F6E3ZAGUYL
 PyepHB2Y/D/ef2fo=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzJky-0007Se-S9 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 19:57:57 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so11222135e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 12:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787774270; x=1788379070; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MVN75ptJofpoif2WLd2kcKz5iBPlZCQuAyqhqZewgOI=;
 b=CVzZhgER381COF9jSRaT37TqmMyhIkuZwZ/hkyVHPBlSaY47k7OyuW/R9XY24HYdbl
 3wwOW9vsITAFYXjUz09iFpsVZE79e+0JoXlLvEDIdNR9pgDd+GS8H9jNCHTdBduZOuhc
 PJYxDIzj4rQrvwiPeUfpOXtVHmTibmh+p2Lwyh7f+Cm9MpCOXOgwbVWyOgHF17cPBCYa
 wDL4Bcv7O5IpFgsGbYDB6eMiNeOeINu0RGdO5BCvSo6XzU9U7FhJ/56Ko6N3+f8/zgBA
 zPRC9XzaQXOFDDQHqrXs1Y88eps+BqCHrROgnj7VSW4o5zuIKF7fD+jEXUtO+JMYonny
 xb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787774270; x=1788379070;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MVN75ptJofpoif2WLd2kcKz5iBPlZCQuAyqhqZewgOI=;
 b=XKBWXNZOYqIJe5w9IyXimUM+C2U7/ay6lrE6zp6FKZAqrUQSKQdZLKB2RhaagBtJ02
 6ggb7H5W8gaV+71THhn1XMwhOSAYWDIxCKYDWeL0HyHHS/Lco2FMh/Vmi5v977pk4MNw
 FzF0TTLcLCHg6XauRJwqN+K7tVejYplR3QZU9PRk9Fwx56PTkjWnsnv55xmdJXkXkJ6I
 GsaqRs9AqvS+y+5s7yDqNiHjEYkMoKtc45+yKN7Q/ZymjWdOMKSNqNk6kYJ+ptIEHbGb
 9clLPB+jzdUpxzBrA0K+zQcY78tjW8TtSIWs43SBWceHqfIR0/bUBS/S5KOoCZGej0Dv
 G8Wg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXGbyROTCqP7PwqzqFC9uble6IK5Jf0elL/qxArrc1krCRC3A/Qu2E43zW38XxrPKkjGGYkeFJYNHx1hSf@lists.sourceforge.net
X-Gm-Message-State: AFuF++mQSfJzakrgEbMHRzg2ZEsmcFJiZFqlJLSTUTtkEcioLrl+iZBi
 PZs/8XhwpT2jby25EQVPWhwtOz2ZjOoxymZPjZYby1UUFrrl3bguMvGhXe1CFDbzMxn9gvaoKAM
 ljcvP/TgJM4YGxWgPDMuacbZVWZN8qkLZcVosuo2y3tts4a5Fr5EREILRqbKAd5Hfh1l/
X-Gm-Gg: AR+sD13xYrwBdtPCAZaSWJ0RFv79YUSVsWmGP+CK8QFeeOXXpN0oTLKGeAAEDDpI/my
 WwAwUKD60FZz7gw9oZnyxwxP9GR0CAHsiB890tRvwdYK8zzQ/uaoWyV1wuktVa4ZkSaNHWVoOCb
 sqfMp1H+/Rrey6H3oEVfZSQy0eYc4sblCEkn0oFnxutii6xhnoRFmJwRihBfw8ooiRNUqXYLI/z
 h1BXu4sc2WXf3Qq5gicJMIW+/8U5JXAvW7gMY3QfEceygW2OoOlOpER2cgfYlBFZXRp5o47PsAq
 pJ0QaZsJbZd7gNLGXmwmwj8uLDnfindKYcB1Iu6+yVh/as3iq1ibYqvWz5lSLNz6BQyd9cm+F4D
 sRgxn46Soi7csZ5aiPtfbiLK0uVgEed42sVwmr7sPEJlyeI1kYFo8RAJwJ1I2ullgLrY9xVRTIf
 3rOj84DMazbkzQKbiuApf8EQTr+k0bCnFxvpGdrulVIgFSWmZ8jXpmDnPjpvsCqt5CS8unqGEPi
 /SEP5SC77odGi3s3k8kzDYFSv3HxL/A2IcmzR/YwsKgQaHLHHX+rni9HfndxN1vt3HCs9UyTaH3
 +3ZFP32mSZgVQbRWYNXTaDwdo6rul1uEXyrF4bR2RCuVm5Y5uHU=
X-Received: by 2002:a05:600c:c178:b0:499:621a:2ec2 with SMTP id
 5b1f17b1804b1-499dc6efe07mr89728975e9.3.1787774270266; 
 Wed, 26 Aug 2026 12:57:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dcad0cbasm35922875e9.10.2026.08.26.12.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 12:57:49 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 19:57:48 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7217d87a0f133e0bbee7896984e668cd28db73bd
X-Gerrit-Change-Number: 1864
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1864?usp=email>
X-Gerrit-Commit: 683a099e6356b0bcf6a217b2b4e7ce069f6c2b56
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 19:57:48 +0000
In-Reply-To: <gerrit.1787570563000.I7217d87a0f133e0bbee7896984e668cd28db73bd@gerrit.openvpn.net>
References: <gerrit.1787570563000.I7217d87a0f133e0bbee7896984e668cd28db73bd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLkk3MjE3ZDg3YTBmMTMzZTBiYmVlNzg5Njk4NGU2NjhjZDI4ZGI3M2JkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <37031fac5a8e34ba5130eefd32c7d4a26fa3cb0d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzJky-0007Se-S9
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: Remove unused
 function route_list_vpn_gateway_needed
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
Content-Type: multipart/mixed; boundary="===============3176203490925644651=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3176203490925644651==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7IF0d6pN68A="; charset=UTF-8

--7IF0d6pN68A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1864?usp=3Demail )

Change subject: route: Remove unu=
sed function route_list_vpn_gateway_needed
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1864?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I7217d87a0f133e0bbee7896984e668cd28=
db73bd
Gerrit-Change-Number: 1864
Gerrit-PatchSet: 2
Gerrit-Owner: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 26 Aug 2026 19:57:48 +0000
Gerri=
t-HasComments: No
Gerrit-Has-Labels: Yes

--7IF0d6pN68A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 2:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1864?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1864?usp=3Demail">change 1864=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1864?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7217=
d87a0f133e0bbee7896984e668cd28db73bd </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1864 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 26 Aug 2026 19:=
57:48 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--7IF0d6pN68A=--


--===============3176203490925644651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3176203490925644651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3176203490925644651==--

