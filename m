Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38989CA5FED
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 14:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tF4RegVkkDzywOt5oFrrFbaVk+mufDOvv6LstYn2e5Q=; b=SRE1mVBHB+buQkQmshHB5oIfwS
	SG4J9W265OLFA1xUZJnV8rbKFQUwnXuRZm9ZBx3JhBiImHFgq2hh3chDIG+CcXdIXP/32aDX4AOAs
	3HYne+dj4NGItl6EXCmxCOB5y4xsVvA0ESjJkNCKjKOdfH9NKoq7KojVTC1qrujRErLU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xE5yb-0001lw-BV;
	Tue, 06 Oct 2026 14:17:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xE5ya-0001lo-Sb
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 14:17:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=k2BzQF77gI0BIAJ2Bd+0oKaNQ6ix4swEzvN7JHIh+Uw=; b=eD0g2F04MDvyS4eWG7yJEYS2jc
 487g7rLxnRiuAcIBRaou9AXyzggunHdV7uodkkw1eLZY6IiDcNbDX6tfQCAciLaY5X+1PSjK47zEc
 UzDQujW7I45tjd5b7ublOk/WKM2+65hp0nvVlQySLcCHcBJ+ctZpdM+AlGOyCy6M6Jmc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k2BzQF77gI0BIAJ2Bd+0oKaNQ6ix4swEzvN7JHIh+Uw=; b=P
 5InhEdaFd7AlWDr96rVPp225dm+xuWR9MQrD+qsyPVw+dydokBDdONcckg8ohuZLcHmRwfpTSAtsm
 a9I++2bJZnZd3cP97pXaF/0bkwFHC+iUIi8U2imxhTkTkUqy/f8uyNbiH6GRJo0KyOFCpBNOqv/z4
 bnYzsxmiYgOMQv54=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xE5ya-0001aq-6w for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 14:17:05 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso534068f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 06 Oct 2026 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791296218; x=1791901018; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k2BzQF77gI0BIAJ2Bd+0oKaNQ6ix4swEzvN7JHIh+Uw=;
 b=efs/nN3AZYtlXLKNCbcue+9e8S6zZlEhtu7rxfKHVlLxeGfy17KJeXaJWfXrK1lwpA
 3B+u/LUQYjpzMwFPqNcXY1+Lj+8ThiDdxFi5GxRilnCNHL5YXGAhoZ3ENDSyZxVWhSY+
 DvLs9Vk6jr8uK778uakfS5BQx1mhq6h2R58pXGBhpRF6fPRPosdXLIx0HRms4+DELp7m
 WHxAj3rqD719dHvw/xz4OpdahzKFfsyEYfkHxaYo4kkIlPkVOCjmj55Hh5hjQtAhEu2I
 oJd5GxTqATGdCH0uTTaeHeToO8oQ/Ul80Fghag+CyLK+W6dp0LtW00S2xp5ouvwfJz6U
 Y8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791296218; x=1791901018;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=k2BzQF77gI0BIAJ2Bd+0oKaNQ6ix4swEzvN7JHIh+Uw=;
 b=2KekL8pQ0+ortVO8xY5GqR2N0fm3tHi1LXC8L4H1qbB83ATu/uN+XA2fPhEat+MwuG
 HxFHi/acOAnkABJbnPyTFWQd8BgirW4CNRn08KyoB5FWWpLdcuQYexfHXdumnkp1jbLA
 Pdopj4SmfNATVH0/tksjXHH3L84zDV5olV74TUcP/wwzKCHawV2ZuXLl7ndE0RM3hpdL
 PzTCCLnA9WhZ4u/gzB8S9ZEGDExQ3H206wqMCZHPtDW92JEQ/2gElSIjvy+AUXaMqztT
 nqwZR78oLC8BDD3Ct19zWS3WvNqVdjY7T+5AH4fkA1Z3RXByhBFBRPnuxsG7JnH+LAyn
 3fwg==
X-Forwarded-Encrypted: i=1;
 AKwUvByZV0afhD1erz4oZ5STLzp/sCNp0VL2eASDr50yS+mkRbuMPUNILZ8svlMKqwW3izM3u+/f8RRXso1rWht/@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJRfCeKyAI4l/DKoiGEUYUx79LE7v8aORX+fiTqtvZflSOhQfPi
 yvUP0XUwR5PkgXStcpIPfkA7HVX8vKdEBHUjbMMjL8oBhAON1vsR0ihw+xBUt2hymdFuLg9+79Z
 /0Ntz3aNk9qvvtfpQ3M5ALixgIl5hngiYLVIXnFVAzI3pUHf96wcG5kAoa16VRqhQq/Gm
X-Gm-Gg: AYBFou1yVQD7iq6VX/Jh7s73RPHwfS9v+3N3V1DeedKq+K2F4kHr8vJcwdktb2OoxyF
 Y+oF+pSc+D7PLBUAD1p1m854WG6uMNoi3qP7gNaHRyJdimdVq7+36RnYuiiLZEaxZo1swaOozkp
 423Swg91pEpq4pppOj/7qqR/a71WAEZn//yGOfSI1whCONRYxOaER79/+daRxbYim8ksq3zpwWa
 r3t/HHE/MJYcw0ZtnMF7tAW7FaWfPlFjXPyI8nuyr1ZlKCMVCilxqjLY/46G1UilvtnOsKjPkk6
 6fOS6fxukhzQncCBxBNPb5NoHM04No11Vvyxw714r06w/K+KETGlvQ+QkbizH31cIhvE0iizL+c
 dusPF5nxFmfLY3BTWZYu+RDwM1/B6j3e0IyY7F9KY6LVc7AhUWUkbNWJsPzz15fLqHuFW4fRGSe
 1GDkEPRSvfI718xXvFLY1ml9/auiPVX8pd9Zatl/KQEZY5SsOuTXkKy5fWK4E9ZHMOTvFBrjf5p
 SMCC8yZr8g0ygf+ixGy3gotw7DBX9F5pYXUPjNiZv1Ne+epe1+IwUo3epLq+dnsDQnVrlDBUcBM
 bHU/G+901Z8J3a+0yHqkWgyTrEamYQRgO5zssZNas6JZBhKuQOqkqRsjakA9
X-Received: by 2002:a05:6000:2307:b0:487:af3:836 with SMTP id
 ffacd0b85a97d-48c6d1a7ae3mr3130384f8f.45.1791296217478; 
 Tue, 06 Oct 2026 07:16:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c63550d1esm10317731f8f.18.2026.10.06.07.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 07:16:56 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 14:16:54 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 30
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: bb42ebff0e89714804fc9e73a6ca70d831e23218
X-Gerrit-Comment-Date: Tue, 6 Oct 2026 14:16:54 +0000
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <435d2fc8d47cfc0cec33f62a40e6c16d116433da-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xE5ya-0001aq-6w
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6943439268944296192=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6943439268944296192==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QmYxTLF7AGk="; charset=UTF-8

--QmYxTLF7AGk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail )

Change=
 subject: Remove instances of constParameterPointer cppcheck warnings
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 30: C=
ode-Review+1

(4 comments)

Patchset:

PS30: 
This looks good now, except f=
or those stub nits I've commented about=2E


File src/openvpn/event=2Eh:

h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/7479dbcd_235ee5d0?us=
p=3Demail :
PS30, Line 196: wait_signal(struct event_set *es, void *arg)
He=
re the `_WIN32` version of `wait_signal()` no longer matches the signature =
of the POSIX stub changed below=2E


File src/openvpn/tun=2Eh:

https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/49edff09_6a07e3d2?usp=3Demail =
:
PS30, Line 467: void tun_standby_init(struct tuntap *tt);
This `_WIN32` v=
ersion of `tun_standby_init()` now does not match the other (const-ified) P=
OSIX version in this same file=2E


https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1663/comment/cd40b76c_ee1a342c?usp=3Demail :
PS30, Line 469: bool tun_s=
tandby(struct tuntap *tt);
`_WIN32` version of the stub now stops matching =
the POSIX const-ified one=2E



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1663?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
Gerrit-Change-Number:=
 1663
Gerrit-PatchSet: 30
Gerrit-Owner: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 06 Oct 2026 14:16:54 +0000
Ger=
rit-HasComments: Yes
Gerrit-Has-Labels: Yes

--QmYxTLF7AGk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 30:<span style=3D"border-radius: 3px; display: inline-block; mar=
gin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span><=
/p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demai=
l">View Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1663?tab=3Dcomments&amp;usp=3Demail">Patch Set #30:</a> </p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
This looks good now, except for those stub nits I&#39;ve commented about=2E=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn=
/event=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/7479dbcd_235ee5d0?us=
p=3Demail">Patch Set #30, Line 196:</a> <code style=3D"font-family:monospac=
e,monospace">wait_signal(struct event_set *es, void *arg)</code></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Here t=
he `_WIN32` version of `wait_signal()` no longer matches the signature of t=
he POSIX stub changed below=2E</p></li></ul></li><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/tun=2Eh:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/=
comment/49edff09_6a07e3d2?usp=3Demail">Patch Set #30, Line 467:</a> <code s=
tyle=3D"font-family:monospace,monospace">void tun_standby_init(struct tunta=
p *tt);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">This `_WIN32` version of `tun_standby_init()` now does n=
ot match the other (const-ified) POSIX version in this same file=2E</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/cd4=
0b76c_ee1a342c?usp=3Demail">Patch Set #30, Line 469:</a> <code style=3D"fon=
t-family:monospace,monospace">bool tun_standby(struct tuntap *tt);</code></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">`_WIN32` version of the stub now stops matching the POSIX const-ified on=
e=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1663?usp=3Demail">change 1663</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I56248cf6d199c2da77077=
4b8fd1e5daf2b116f58 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1663 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 30 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 06=
 Oct 2026 14:16:54 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>=


</body></html>
--QmYxTLF7AGk=--


--===============6943439268944296192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6943439268944296192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6943439268944296192==--

