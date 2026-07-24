Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7560AC531FA
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=duHKe6XRf4eED5OSthdJg5wL1HZmlf3heRg1nJfmOIE=; b=jnUsxVggNkWzTEoRFUMycQhP73
	Xn+QqAQg7CmLSro+Fda1JZfYUvSoTZsQyPzfJ3brp3qPX+D2eNkbnKd/GBKZZZpAhHGGesVcxqW5W
	AQreao77i+7R3gdz0P5xlNjevmHexP5K/HFyAgUeMhEsl4IwacW3XSj1RQgOOp0Hxd2Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnDUY-0002Xo-Nm;
	Fri, 24 Jul 2026 10:50:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnDUX-0002Xh-J0
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 10:50:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VErPmWEg+coxfAQr0Cfw8jRUUc3piqlrlavpcekDUaU=; b=HsBxeI1UUhe0BAa4NnVQs2scd/
 yw0aAVB2XGibuerDMU0qKbVNMThVmGWYBpwSzELk4TKRFEB3s8ezoYFZgjKwqNTdY0t6t5vxhd70M
 A9O8xychJzbIlhmotdERKJXC9nzmdzwPSljGo9leTU3sPRAxZuOJIOlbfrcldMazblXs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VErPmWEg+coxfAQr0Cfw8jRUUc3piqlrlavpcekDUaU=; b=a
 Weny8SQWA+CJJZwSO/d4Nh+DRk7M6Ne3k36jtmktdvkQbe5DR/RswceqolCtJLIqqeNoJGiO+dUTQ
 4dzfoPl1oFY7aPLegTRqUbJ22a9kAFJwHMVRdR9FK+ffLvtxgEQb1ez2KjcseyCHn5zsi80ISG+tv
 grEJN4mkQ3rz3A2M=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnDUV-0003Rd-Sw for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 10:50:55 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4956869750eso2577295e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 03:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784890246; x=1785495046; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VErPmWEg+coxfAQr0Cfw8jRUUc3piqlrlavpcekDUaU=;
 b=EKhyrhAm1uDyb1kuJDkineF/1UHUwYGwMTs4uumKqcyNqHo3+5mabDTaD417k6ZPZL
 wOm70pKcqyhxGWtWV+fJpAR/Ik/thsw7Io/GFAxCNgjtNLb+K7RHkW2UzrPG7WfvjJbw
 uZakDZckYxZh3K3YgMB2iCUuLHpvhuSOWIUNSFP/qhxX1XHXKQbbQw0fvGU8a5j+Zg+6
 8ftBRwzQLHQ/DMMl+eWH+/twR+H69fTkONyfjEsdMOAwv/F6VWjRSz6Ao6SZaADoNeI9
 xbC910PiZXFEbydy1CUSFNORmd+McCx+phdfSO5SjJzq3X8QAmmoF97mn+ghOPdvxtnZ
 xa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784890246; x=1785495046;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VErPmWEg+coxfAQr0Cfw8jRUUc3piqlrlavpcekDUaU=;
 b=dHUT/pbOvdkNypLyOrJ0eLpqWuyW1iGukngIA6bLyJ9sNfThDJlCxbO6SsSMHQBgfV
 yXmxYGlmu6fPmliLv0baUwICruiiFt30KmFr7fiCbC/LXOe+XGnfNmtlHKaHc1CpKIF7
 wo2EM31JQ2fIbu8FlzDTaRiH6nPDPZ0Jy9r1bxHli1jbSb9CGWWB8qvJyz1R5cNn3HJq
 xnrX6R8I2dV6OpBLUKSKnmTrvVGRGW0Pfky0mzsGDZ/3TML9gEeA/GkpT+XdCg9Fatoc
 SGYhgq8ZR7qN92o3s+wJTUc4BnD7iiuB8htBovi4koOkJ2nxskugKptw41Fc7SIEDLTZ
 z5AA==
X-Gm-Message-State: AOJu0Yyu0XAOe9cUQWdhzIq12sva0pTgfEGSLJ1C4TUsZQ2CJSqeuKui
 Gt4MPtAlADYMHkfR6iAcxRV8EEBqsNWXjTmP8XH/77rcAvEBEKUvNgTButXc3O314DTrIU2O38e
 wxlIAEUL7X/VGi+Iwf8hR/9drkh0ZdLSMED3sLUZJPyKKAl8fC7JOu8uul28cLCz7BAkHbCZ656
 fiF1/i2A==
X-Gm-Gg: AR+sD10J8hHoMYOkJPo1u7L21QoIjUIDaltCTgQx8l7/aaBeGlsdl+Ty3FiVZh/G0XB
 0XwfGMtmRdTf1nsQqWjxolowtffEXcvdLPspodNAB1LRJJHG2Nw+ShnGTJHSDLleNA4CB2aslDF
 fdy3MchBc91aaM4bBayEYUV2IhtgKb/Zi6dXqSQLzK5diLnZdYp5shC+TgXJQtXOt/AY5PTnqnR
 bXY0p0tPrXctl/97ORj0YeTng247p93/QaHXmWiIS8iACviLn5KCj5Zu0q0GtLnNtPA3OKqIVzQ
 aZRb9yTnK18tcd8otMfOxvfvb12t0TaXhZaNUugewgK6kFe29tQW2bQqF2zTLy0hNkA4Nak3qUi
 jt7JaaZD+++yNjl0MGiLk/OSh8KL3DClWsafe7CQ4ZKLGhkow5zHnHtOMlZytZM9NBWvReRI/UC
 koWwqYv//EvDLNkYfXyCtvtJvKm1JusvChJsBx1BhtJMqqG1RrlvXnit919OzrFivRFj8/gfA/g
 eryqAlLMvRIfXlGJtHCsL1ZLpjh8BQLmqBFPFgDjewTVFf/ek3lMY2FAyJK5JtVRbG5
X-Received: by 2002:a05:600c:3b92:b0:495:680a:ed19 with SMTP id
 5b1f17b1804b1-49573d20b9emr72270635e9.32.1784890244891; 
 Fri, 24 Jul 2026 03:50:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b5f35a1sm41615925e9.0.2026.07.24.03.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 03:50:44 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 10:50:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: 7f223f70b33634472d7e5329855567546ce327ff
X-Gerrit-Comment-Date: Fri, 24 Jul 2026 10:50:42 +0000
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b46457002e657ea0f261bf6dae599a046639b136-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnDUV-0003Rd-Sw
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Allow to use
 OpenSSL's SIPHASH implementation when available
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
Content-Type: multipart/mixed; boundary="===============2336760586698548748=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2336760586698548748==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sQAc3o17LZk="; charset=UTF-8

--sQAc3o17LZk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/31?usp=3Demail )

Change subject: Allow to use OpenSSL's SIPHASH =
implementation when available
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 20:

(1 comment)

File src/openvpn/siphash_open=
ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/2c678f38_a00=
49ba5?usp=3Demail :
PS20, Line 82:     ALLOC_OBJ(sip, struct siphash_contex=
t);
Strictly speaking this requires buffer=2Eh



-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Gerrit=
-Change-Number: 31
Gerrit-PatchSet: 20
Gerrit-Owner: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 24=
 Jul 2026 10:50:42 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--sQAc3o17LZk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/31?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/siphash_openssl=2Ec:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/3=
1/comment/2c678f38_a0049ba5?usp=3Demail">Patch Set #20, Line 82:</a> <code =
style=3D"font-family:monospace,monospace">    ALLOC_OBJ(sip, struct siphash=
_context);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Strictly speaking this requires buffer=2Eh</p></li></=
ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/31?usp=3Demail">change 31</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/31?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: co=
mment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0 </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 31 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> =
Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Comment-Date: Fri, 24 Jul 2026 10:50:42 +0=
000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--sQAc3o17LZk=--


--===============2336760586698548748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2336760586698548748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2336760586698548748==--

