Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280ADC55162
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 11:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uvNLw98UP6jVWICV/3vLNkxiphReQ6BuOEJIcpn/Kg8=; b=k8HXK020ls4IXJtgzQcovcuLwe
	0zl/scup4avp1N1pMiobZc5Acb1uPY0FAEMel/bgY/E9jL2sh9MRo8zCoFN7Ncqnr/2m5NbFkj/JD
	Sg/vZP3jMGHlCLaGgZg4NJTuFnC7KeEpeXnpfZUKmiaT3mdCknwvwX6uDLa22r7vr0h4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpP47-00010Q-GH;
	Thu, 30 Jul 2026 11:36:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpP45-00010I-BG
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 11:36:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZggAqGwm+8m7logCVMUD6vf+TY3xxbVt29tDYn/Se84=; b=GLCbALqjxGL0l7Hu2zPlD9DB1B
 UhqTVI/SDEVJV128tDhf8coaJuV/S+Q3yXv94VddNpLEIRLDjDcN64NwDHAcfwIm48WkZYHrdr/m9
 L8Re+Nm+vzaduCgprhg0KRIOlc0s/Yspdm17wu0cDUNS+cykRUe65EqMSU+ZiqsiXgHk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZggAqGwm+8m7logCVMUD6vf+TY3xxbVt29tDYn/Se84=; b=g
 bJHOYDDZPOO1qGV+ESfaSLYGpKaxUoWYqZffaZYqZLNJSEH5ni9J5trchUzsOHzl4iyRXzYYEt8ws
 ZvBtNklaumm8sR7iEDI7oIwgFAwIIiQeU4sD18znQh7YI6khxRxaZhsrHB2I8mQUUz9SnsOYrk6Us
 +mji7XZIAysDJzyc=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpP43-0007rG-EG for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 11:36:40 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso18041545e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 04:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785411393; x=1786016193; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZggAqGwm+8m7logCVMUD6vf+TY3xxbVt29tDYn/Se84=;
 b=N6OrTF9RSwIm/ABzUA01ItDxElvgujTyX0FiIF+I9NTZq0vc/N/7UOgkL9ZiAdS+Tr
 GwAAHHa8OVUCZyfgTkANrm2/SRWXwA0Dyf0TJ5TTJ8Qinyi2O9SWLrfP3NSmZzL1wP4h
 7qS47q1K7qB5tBqoazEkEbYSInTATsv3Cz/DkBqUgfqR6papaBOgee268P07Kcy031QB
 sEZkjaWwWdtReONBtiqKsTiO+3KC0qkN6gD2xYguyikPBORloTtHUzWULdvOGLtM0QSq
 NvJozHAHfEXRn0rw96+TbjTHe41N9avXwmoGeT3hxT+QCiEGtZUZRSoFWxEtzGFxQttg
 LPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785411393; x=1786016193;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZggAqGwm+8m7logCVMUD6vf+TY3xxbVt29tDYn/Se84=;
 b=lg5+DAK5ID5udBCoailsOdHoA0ZEphs+Y7RA/jUoKO9U7x8HMXkBl1v4ll9DIdvDqV
 UXVKG8wUdUJLJj330NNMf0eyV8FFguEjBdiwANQ06zYGz7r9ChKm+k4B7pLH4wvnRub6
 uUnqlNRWj12sqry4Sl8bUoiN2jmy/Vfz+tiLzXjPclzoPEqtWbZZH9MjSDTz8NUkOInA
 Da9lMpR4tTWjIBPalcbbeyA0TZDTUfxl9JB0nx/BIXmbu1VEPS8JlJnKxg3RRxv4Nvl4
 l7eRFwwOLxXx/eK6WhzH/uPXQ9+RFTTtc5MMBu11z6vNp/dNpLnYITS8h/U8LIzWwrBe
 AAgA==
X-Gm-Message-State: AOJu0YwmQ0W269ryTflobuZTOfhfHg5lvRhFQXLYXH3U4jzvfIMbR9Wp
 4anPLRZ33OW12rl5lU1bqU1ADfbjwwiEY0moJuLa9omBBRG9Xm5CL6udCXfhyquDIwc5LgdXCJ/
 o8LeCcqzsG5+jUQMxUP7BtqQTWq917xJry9gwAIu65VcUYpMOtq5h+Bt+p3cHAMXEt84eMrdzbQ
 QWJoyiOw==
X-Gm-Gg: AR+sD11tOAF+PTrcRFHivkPBm6l5DaiSnWIu4FSmYXLGjqdjAP+6MKI381Y4Xgaj76v
 LJouS8/dfzt8YpkqI3eRMkr7fDFruTWm9IMpwynFGRnC7yV7y51mSXfyjDaKC0lykyGrJpLp2Mx
 wqwaXyd7gjFt4KkK8L7uEDHNFrDnX4PjF2kE7VpAVW8dCC2tbqUMNzWmW0KyqFhEiADelsKt0nj
 GRHzaivqtqRvvPVuWdYwZA/LIyCUJSdloZ1EqsnHpi6viVEBfaD8aVq0+hpkBrgOzsfc7zH5n5W
 7qYbkc35qHsNf0mNj+Xx205QjM6VJ2ALg8zMcp3JGU8GyLKTnxSekqar0PmGQzoN1d1CRKio+0c
 hA1SG5eFMJK3FvSMOrsQqjpH4a1IRDitUsNC4+L7HPwMrS4KkR9zbiofMynHdVz6WZw62Mn8//O
 whSZ23bN/CXDtrqN+g79ybPCwIAUnhgsX27DDucC//GwT/MqJ70RH5f4Cjt7bFA1cxlXa92MAs2
 w77gDJ14I35r/zMOT5qyAXY3BdwSA7cyYp1LVr4G2LihrrdH3HEFpw5d+ie0N/M0bGRZDZlZTrU
 kVAFFnnHZEmfEXEQzG0BKhCHBtby7kuv1HtyEWPRFKn4eGgmvh/GZOgBi+neog==
X-Received: by 2002:a05:600c:628d:b0:495:7739:4e5 with SMTP id
 5b1f17b1804b1-49800ea9b31mr25895685e9.22.1785411392548; 
 Thu, 30 Jul 2026 04:36:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498010a051csm50950675e9.11.2026.07.30.04.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 04:36:31 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 11:36:30 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 23
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: c215d4d06117b113e30b234ca4e102e05ca28f8e
X-Gerrit-Comment-Date: Thu, 30 Jul 2026 11:36:30 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e7441bf825e9f5ae4dffd99ba9496a5a6790d33a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpP43-0007rG-EG
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
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
Content-Type: multipart/mixed; boundary="===============0754196151463098939=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0754196151463098939==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ek0Y8V3+q/I="; charset=UTF-8

--Ek0Y8V3+q/I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

flichtenheld has posted comments on this change by plaisthos=2E ( http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail )

Change subject: Add lo=
okup of multi session by session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 23: -Code-Review


-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Ge=
rrit-Change-Number: 1727
Gerrit-PatchSet: 23
Gerrit-Owner: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Comment-Date: Thu, 30 Jul 2026 11:36:30 +0000
Gerrit-HasComments: No
Ger=
rit-Has-Labels: Yes

--Ek0Y8V3+q/I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Patch set 23:<spa=
n style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddin=
g: 4px;background-color: #ddd;">-Code-Review</span></p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><u=
l style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb59e=
cd119331b198792ad1379bec8600211651b </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1727 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 23 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 30 Jul=
 2026 11:36:30 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</b=
ody></html>
--Ek0Y8V3+q/I=--


--===============0754196151463098939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0754196151463098939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0754196151463098939==--

