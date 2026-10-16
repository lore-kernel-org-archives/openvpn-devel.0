Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACD1CCA464
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IXV9VbdFmEylEs5R8ms7Y0rpGNZa8Rcy6cSnZ5OVzqc=; b=H/ITFSXi1G7HpRNPPqHTwK2QVm
	vE8PrtjdB/vNSMhgaxxM1bB0Ulbyv49y71yU1M2VTtv4kBxJcEgknvmE92xjTzBrOY4Zn/0GVq9rP
	i/z9quE6ANXd89UoU9gv6XbnwTIsMVkHJOXJqg1DBTmD5uY+hkRIRnE0y80e/noapGAo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHce1-0004nu-Bw;
	Fri, 16 Oct 2026 07:46:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHcdz-0004no-LF
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 07:46:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dck+5C2rY70EBmNT7/MJ/NXRTu8v5iInkh+8eshcB/Y=; b=SL6Udc89KVXZLFkkNG+BIK0PF0
 ur8fB/d+4ZRF9xsJeAtwezCMYbxMWPnz6S1irDZHtDJtxY5f/8vd35SWLKnZtZbjx0q9AV5QW+8ZT
 MI0fRjW4Aix0AEaCbHYvTVvpI20XTjmInNi77cbTkMCt+qr8EV+9NAPX8OE9sLU9121o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dck+5C2rY70EBmNT7/MJ/NXRTu8v5iInkh+8eshcB/Y=; b=i
 fdKR+XpDKtePmLGiHR3s+OK97JSr2xBwpBjQ/TRT9w/kmS3BOB9EIuLayMf3viq0BkVuU9qd46hv5
 R7bPixTNdgpe/Z2p8m3dVu0NoW8ZOU3IcHkKarLr03l7Q3aAycyq1VuWkCpcYVQfZBD+f4NsrhQpM
 DqZPDY+0KIVjzzaQ=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHcdv-0005mz-DY for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 07:46:21 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a02667ccebso44938635e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 16 Oct 2026 00:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792136773; x=1792741573; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dck+5C2rY70EBmNT7/MJ/NXRTu8v5iInkh+8eshcB/Y=;
 b=Yr6aQZXeTooNLc7GWj2FsiPDI4Utbvacmi7vMUAhnqNUJqFjx/TWvutInE+CKAhFcP
 Y57ShYPhODgpGV6G1APb5PpI6cXMRzB+i6YZi3Oql+Q8/IafrvVkftUDTqOP2X0fP9xC
 Vh+ZzzFgdRvl6cMr9WZku4rtiNKCRfhCOgCo5Ve0rXVAI4EpcyusOSlnynDhinTFeEgx
 bdig012CFiWF3UkxXP/aLswSjUClHkLUTqFP7vLLlKwbjfS+HkBRzHu7sStu+OfViuLY
 ydYZ8Qh/NbVIv3vPKqqht6wM3m1ZkHoB0fUj42aL7vqInUziBo1iwdQnvx93qlMVnL5V
 IPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792136773; x=1792741573;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dck+5C2rY70EBmNT7/MJ/NXRTu8v5iInkh+8eshcB/Y=;
 b=VwQ/GgjwrbyJGd0I3OpPsybh6Y/mPZuLu39d9+6m3KeiZDkPT2Q5JiLMIVj76Efmwb
 H+SYEbuIip//GU0wANKDOW68Y9mccEd50KkZwoIfVB674IzOvAIzfdYRx77vjX3viyAk
 jmWT0KTaMsFqKApJptdGNzsK/X3jWxrbswXaztfn40ZKvxIcmufj0E8zRttxqv0XoLdy
 kuIojNKzwjABc+OzA1UNORY/4OZl3OepLTjqiwxZw4gKdbuC6jwNmcckt3UVfteEGmLz
 cKkL0pZYMxYa0TGCXcQOPJox0v5IUgq/n2Kdv6ortzhrXcRw1B+zHnom5hp3+rqHSh83
 auIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9/eKInyaBrvrvMf2q1WqYniPWGvZZb1o5J2cix1N8oCx8duGv4J/AgiCCuwhttYfX+I7JVmp+96fzooq+@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIryIEcYmwffsE4l+pVpdR59FaJ0VOTR8ogg7kOqox1D1dHF7NL
 1qH41xUs1BmsOB8KOYppb1HyGZMyIOcLxejS5tBo++bvMW1IkBBWVBCph/UA7+LjeIL8d8dRl46
 IHMswUGEnjDcH9UFfKEGnPHvTiH2ojnT7ZsiF3jVRFfbjsXzYbxaXX18vqckHmzEJFr4CutKM0a
 TJ2X6lig==
X-Gm-Gg: AYBFou0qx2GBp09jOXTcUkRhOyTvQbL1XxsCiuf8xYmDQ4ATKC9zQWevkvfA8OBu3XP
 HlNqec2jvuQIcwEg2ZeKHIeKwLgedvZrlj20iJY78FruT3TDvEV71w8UjGNodQFshTQ6pakrz9o
 2yQt0H0yCq7x8SXmBh1/1Jt09+zs5sWZ0TtYH9ilHQuAZGL2aGa/G9T6nNP/FfUvYkeDKbrJi6C
 fnq+9CavQasWz6iWo5l+9xkrhadCHJ5BUc3AKKiL+dLcEbfqHbW7Z1XiAZQzVcc0uy6uOW/c28p
 xx4VNGZpIqy8wrGORB/LhyUvWVoQ+SC43Q2qE9VvQwUlUBoFMZkVmwycFYGJumQNX8Nz8h1aN+l
 9nWSdQzCYjAXTUNf9cgpWyqrKe3C1+YB8AcO3sxB8515Hv6Wz/QRKXuBxWdm8A5gezgYp8rD/WC
 /yDZCk/HUYoAqURa86NioULOWY+m1DRrTeIzyI5jpgiRUFJ4FnFlKw+PQ/d1HauT9TOIkMIowqC
 fEbB7uZL3Xd1kY0A7WLzxhOJs0P52l55JrmKGZbN0DBYt+7ve5CsoubohJQ3G/5rOKIPVBRNoG6
 ++kj+nRY1/Rbv/4I1SSqwKvhzehDTzLzOMgSJIGHycymcAtIejjeEN8Q/JDTNBxG7iaqp8I=
X-Received: by 2002:a05:600c:19ca:b0:4a1:7e76:d02f with SMTP id
 5b1f17b1804b1-4a18e4ac650mr430360815e9.14.1792136772671; 
 Fri, 16 Oct 2026 00:46:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8ad6245sm40978845e9.3.2026.10.16.00.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 00:46:11 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 16 Oct 2026 07:46:08 +0000
To: Heiko Hund <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b
X-Gerrit-Change-Number: 2001
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2001?usp=email>
X-Gerrit-Commit: 1421419c2d3731d8d840acd085375c77d0c3914a
X-Gerrit-Comment-Date: Fri, 16 Oct 2026 07:46:08 +0000
In-Reply-To: <gerrit.1792128387000.I089e5b79600c535e3c0c5d1bb14319ac03f4144b@gerrit.openvpn.net>
References: <gerrit.1792128387000.I089e5b79600c535e3c0c5d1bb14319ac03f4144b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMTI4Mzg3MDAwLkkwODllNWI3OTYwMGM1MzVlM2MwYzVkMWJiMTQzMTlhYzAzZjQxNDRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bbc5e42214531eeea4a0175bfbf1c780794a1201-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHcdv-0005mz-DY
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: openvpnserv: add
 automatic service again
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5804283453482963313=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5804283453482963313==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e48CfF5zXuM="; charset=UTF-8

--e48CfF5zXuM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

Frank Li=
chtenheld has posted comments on this change by Heiko Hund=2E ( https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail )

Change subject: openvpn=
serv: add automatic service again
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(5 comments)

Patchset:

PS2: 
Added =
some nitpicks


File src/openvpnserv/automatic=2Ec:

https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2001/comment/13e5f53f_d35ee7d9?usp=3Demail :
PS2, Line=
 24:  * The automatic service starts one OpenVPN process for each configura=
tion
Could be marked as a `@file` doxygen comment?


https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2001/comment/6b9d3700_ad7675e1?usp=3Demail :
PS2, Line=
 39: /* Time we give the interactive service to accept our connection */
Ma=
ke these doxygen comments as well?


https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2001/comment/7c72c43b_e94e6652?usp=3Demail :
PS2, Line 107:  * @param =
pos   in/out position in the buffer in wide characters
- use `[in,out]` ins=
tead of staging in/out in the text
- maybe mention that pos points to after=
 the `\0`?


File tests/unit_tests/openvpnserv/test_openvpnserv_automatic=
=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001/comment/6276d1a4_921=
6ce73?usp=3Demail :
PS2, Line 215:         name[i] =3D L'a';
Why are you no=
t using wmemset here?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2001?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b
Gerrit-Change-Number: 2001
G=
errit-PatchSet: 2
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Rev=
iewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Heiko Hund <heiko@openvpn=2Enet>
Ge=
rrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Da=
te: Fri, 16 Oct 2026 07:46:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labe=
ls: No

--e48CfF5zXuM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>Frank Lichtenheld=
 has posted comments on this change by Heiko Hund=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail">View Change</a></p>=
<p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?tab=
=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Added some nitpicks</p>=
</li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv=
/automatic=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001/comment/13e5f53f_d35ee7=
d9?usp=3Demail">Patch Set #2, Line 24:</a> <code style=3D"font-family:monos=
pace,monospace"> * The automatic service starts one OpenVPN process for eac=
h configuration</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Could be marked as a `@file` doxygen comment?</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001/commen=
t/6b9d3700_ad7675e1?usp=3Demail">Patch Set #2, Line 39:</a> <code style=3D"=
font-family:monospace,monospace">/* Time we give the interactive service to=
 accept our connection */</code></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Make these doxygen comments as well?</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001/comme=
nt/7c72c43b_e94e6652?usp=3Demail">Patch Set #2, Line 107:</a> <code style=
=3D"font-family:monospace,monospace"> * @param pos   in/out position in the=
 buffer in wide characters</code></p><ul class=3D"blocks"><li>use `[in,out]=
` instead of staging in/out in the text</li><li>maybe mention that pos poin=
ts to after the `\0`?</li></ul></li></ul></li><li style=3D"margin: 0; paddi=
ng: 0;"><p>File tests/unit_tests/openvpnserv/test_openvpnserv_automatic=2Ec=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2001/comment/6276d1a4_9216ce73?usp=3Demail"=
>Patch Set #2, Line 215:</a> <code style=3D"font-family:monospace,monospace=
">        name[i] =3D L&#39;a&#39;;</code></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Why are you not using wmemse=
t here?</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail">change 2001</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I089e5b79600c535e3c0=
c5d1bb14319ac03f4144b </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2001 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@openvpn=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Heiko Hund=
 &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Fri, 16 Oct 2026 07:46:08 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--e48CfF5zXuM=--


--===============5804283453482963313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5804283453482963313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5804283453482963313==--

