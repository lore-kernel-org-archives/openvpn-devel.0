Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18103C5DF6D
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 08:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oif5LdBLfcgCBHRHz8HQHQG6eESNPhxy7TttUJYJdYY=; b=RowGDtpUbfINATmzt9fHwG8wbb
	79zenBJ7FlXvXmf6NLrrgnIkOXOntDmNeYDtFw0nh2KdnyKZaQb3PCmH03c1gGkSSvebv0OjIrPED
	x+aOCutZrevyJ6yMNwhr4JFk4sJKl+WDkOvuR9BR8k+LRz4fFDTEB90UiPaJneRXnNP8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwbR3-0000bz-Iy;
	Wed, 19 Aug 2026 08:14:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwbR1-0000bj-UG
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 08:14:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rnyAsaQ19mfwSuoCYZkbT4v3aYSIBoUWfJRe1kTHZQw=; b=kbIHHLeTmGWdmCisGKiXD7KBcT
 7olwdC4EfDdyahFPb8+kg40Rl4UW/jZeoKTp6s5UMl9cuo+qwWiTEcsTpGElPQ4C1n1QItHwo60u1
 VFWk1Bx44bajruWHspikzr4HRj108H0U5k4qjug/py+LWchbBAjL51X4foMkgZud0zd8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rnyAsaQ19mfwSuoCYZkbT4v3aYSIBoUWfJRe1kTHZQw=; b=D
 SgX85ue9MGrJVzHM+OUVzwErVqWgbMOc58btSnnaS/u43WQkxOPgAlQfP5JsDh1bdHop+H9AyPXZJ
 e9+mzFVvSkMvPdSWNFKOrd2UPYAhrEXsCSK7o6CzqYuSJ2eZosT575g4+5A0o6X8swhnirl3bWCaq
 7CpclLWg9jw/I53s=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwbR4-000498-8i for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 08:14:08 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-472326ca506so477374f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 01:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787127240; x=1787732040; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rnyAsaQ19mfwSuoCYZkbT4v3aYSIBoUWfJRe1kTHZQw=;
 b=INvkGa7IrcWyc62rSzkwXoFxnD+WnfvAbKsD/nj0iksg44J+TsNTeY4Vs9K8M9YLVS
 xDr9urEoV+S7qqEjke3hz8/ytj9xsecSWgC6C/eLf/vKe/8LTaxLh92i/VD4yJpIBcKg
 rZjt0Q5excnmbrzAQFxDNempi2jtXiNnLv7TI7yCjpOY0MKcUZFeKjv9oRXv0nLJAZxm
 mZeBXdwek8bAFIt7aPifEfYk/AiOumZtdHi2XawCyBGRMunMt+tWNaitESPrXhOzhveo
 AbLedcwsEnAEPnnAmWRu6Rezk3WWD6gPlKJ1xnBCwXWC/AHA8jttosJxkHKoxX9Rj1Fg
 w3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787127240; x=1787732040;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rnyAsaQ19mfwSuoCYZkbT4v3aYSIBoUWfJRe1kTHZQw=;
 b=l46feStriySNHiHuTMlUhTfkhbKL9E9I/k+J7zVb9nRrx2IotS8pqwbcBFcoAfSLXH
 Xos5MbqckloI11TRRjmIGFfj1LXsVxh4AcNJ/K0ARBpI7TOm0Kuuk/Ur8wfvFCmm7mNW
 scOwYgJf3zPsbnCYVsXQEEHrWp176NK1980eU0l/mXwIIKGAOsRZWWD0E6LVg/+fabdr
 ZMy3oP8H1adIy+fMiIJUadGYauSOrstEm1cXkyDHyzzdBMTrCs/MuhFYMAV1iutNk45t
 QYC3DDjVJGB+v9Mgh/DLwv73RL0HOKUf6BGzscNY3+mAE36vH33Jkh2NZe/1pbJ/Tc7+
 grig==
X-Forwarded-Encrypted: i=1;
 AHgh+RpTaZIqZGAQdCOdt08zw8fcHhubTQy8axSA3TEpAp5o9loCV0o6RcBLrnQNUpOLYiIFBqZcjKnftqvKPX1f@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxD3ummtwXPJigAzj0GxTdeEQ2jrl+zI3BePcOwubxnZyzLVH65
 SizgGL+gn0KGNGmQ8ZwMKIjTr7Kc7sSQvi7i+iuV7H5Poxf5c6CT4lmMoHYnh3yuJBhWkcGboK+
 2fyunmfoqgCUreGKKBuZ0j0ejnVlG7YeCC+Dxswm2g9gawkDe04/AYh4QeKuCJ+/WmhNj
X-Gm-Gg: AR+sD1070akCaU2fygo3uKlzlL0dwryr5NBMslLghza/dLU724NmKWrhyMJS5D5XqVI
 PqnagT29IFeUYAlij+tzxdpd3PN9DiiCwABHTjRqjA/IweJmsilZFQB18Ec5kCzTyHec96DLiIh
 MpE+pdUGpFqPRrn74JLmrqZthQdkzqSf5kEs8GXBjc+UXvZAX9FXbGqU9LK3HAq3Ob/JLFYF9VP
 aSxyKRIltiphfZdI8MgKSWkXt0us6ppvT08d9rqCAKlJuMBHQ6P9mSpurwgFZAo8uWOi9c/HwHh
 /3GkRzyAw7ThlbHK0QHKSjQC6ulN9U5TTuRSEBhrlYA9oQ7S7j4ZbMA2kOOWszXhMMfRUaz6zIl
 DFldG9ZkZ24ZOaFsAFpezrq6KpA91fYuqjZpl5U5TPypzq+SoXSfORRa60C5UcOVrGnBldWG38I
 NAMVWZ2L7X9pkYNwSxVLL6x0y3l8Vx0zYUMGhI7Ks4twEU6+Dtm4lhxZrlxLaTvrbyfag7LPzQf
 ueE7X7atWeBt0xT4uqPmH/QCZW5rVPt+YDkuxxAm+ndpyoI9ewldNf0m3H0LqKprnGQhqpnHE9r
 ulMzYr0I/5/9qxD5g39blHXxX8i1zcFTGJjErdWmHE5crbG0R+o=
X-Received: by 2002:a05:600c:1f94:b0:499:8807:345f with SMTP id
 5b1f17b1804b1-499aa1b6994mr39479145e9.13.1787127240001; 
 Wed, 19 Aug 2026 01:14:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441725sm3728458f8f.3.2026.08.19.01.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 01:13:59 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 08:13:57 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
X-Gerrit-Change-Number: 1755
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1755?usp=email>
X-Gerrit-Commit: 0e63d0f06ae3b11cc8dd99eaa74ccc3a426f6dfe
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 08:13:57 +0000
In-Reply-To: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
References: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLkk2YzUxYmNkZGE1NjY2ZTBkYWIyYWRjZGFmZjI4NDA4YzliZmNiODQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1f22e9c8b0ffc5919514db3f0e95bdf5a64b4148-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwbR4-000498-8i
Subject: [Openvpn-devel] [M] Change in openvpn[master]: t_client.sh.in: Add
 support for expected test failures
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
Content-Type: multipart/mixed; boundary="===============2520522753344082552=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2520522753344082552==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OIBO5yjc4oQ="; charset=UTF-8

--OIBO5yjc4oQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1755?usp=3Demail )

Change subject: t_client=2Esh=2Ei=
n: Add support for expected test failures
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(2 comments)

File tests/t_clie=
nt=2Esh=2Ein:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755/comment/220db=
98e_4f9466b1?usp=3Demail :
PS3, Line 387:             grep "$expect_fail" $=
LOGDIR/$SUF:openvpn=2Elog # >/dev/null
Is this leftover debug code?


http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755/comment/e4888538_2e182acc?usp=3De=
mail :
PS3, Line 427:         else
Should we also check `$ovpn_init_success=
 -eq 1` here?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1755?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c51=
bcdda5666e0dab2adcdaff28408c9bfcb844
Gerrit-Change-Number: 1755
Gerrit-Patc=
hSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewe=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg=
>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 19 Aug 2=
026 08:13:57 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--OIBO5yjc4oQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File tests/t_client=2Esh=2Ein:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1755/comment/220db98e_4f9466b1?usp=3Demail">Patch Set #3, Line 387=
:</a> <code style=3D"font-family:monospace,monospace">            grep &quo=
t;$expect_fail&quot; $LOGDIR/$SUF:openvpn=2Elog # &gt;/dev/null</code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Is this leftover debug code?</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1755/comment/e4888538_2e182acc?usp=3Demail">Patch Set #3=
, Line 427:</a> <code style=3D"font-family:monospace,monospace">        els=
e</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Should we also check `$ovpn_init_success -eq 1` here?</p></li>=
</ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1755?usp=3Demail">change 1755</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1755?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb=
844 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1755 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Wed, 19 Aug 2026 08:13:57 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: No </div>

</body></html>
--OIBO5yjc4oQ=--


--===============2520522753344082552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2520522753344082552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2520522753344082552==--

