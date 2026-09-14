Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F293C88E50
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8tu586CfjG5o3oamRIF1Vjl6w1c1/Cq7t6CegSh4DHY=; b=YMjm5puZrYKQjkgUcjyexIgNgJ
	JN4ZXpxidyfK8yqaxOcfyV8X4lyzzvTDB0jc07hy95lPe+U3VDjUJktPlDgVw/WgFg6NKgmka5H0b
	TsXLiyrAnLo0XejRo5Q2BdTZorIG5jCCwlVlvnzSBtzMnDxJeGaU/4rP5rOygXusRKfk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x65Ow-0003zz-Ap;
	Mon, 14 Sep 2026 12:03:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x65Ov-0003zs-1e
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 12:03:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GI3Rv7ObpzYOMNGe1IKpKyfU2dIihWKscaYwXS1+JvU=; b=Kx3CcB6Sq/f0WIMXppFDWfomd0
 ++tc55rh7skHrd6LhsMmHW+/45J5yxXpacheOsYHCR69A+9r1syn3DYhXQYYqagPiDkmW5gXuiGx2
 6oio5VyrpGr2CgQhC548zCA7MpV5baZ+tVK5qNFuwczDmOg3bnECR6Zxq0q5SO26kKhU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GI3Rv7ObpzYOMNGe1IKpKyfU2dIihWKscaYwXS1+JvU=; b=K
 HfIaIYIEjQ6LbIHeenzWbxpSKtOL2zYEwhrkEhCouG7NaP0gaLQDkBgY5MSvXWAro6CF9D1q678b+
 YNu05MDv77F0YEB08Q6jGxFsXe7nvrXr/rSqWZ3qYncTfz4xlVv01JXZy+UlTTYgRaBjKSa9g3fnr
 vL5Y17aYH/Vvl7QM=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x65Os-0006Ba-Iq for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 12:03:08 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48434392b02so1592417f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789387326; x=1789992126; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GI3Rv7ObpzYOMNGe1IKpKyfU2dIihWKscaYwXS1+JvU=;
 b=MQABAJA/VwZiuBgwQiXwpLtAyqf0ncF4kc74XgmV70HWT/doH7Y5OfpW/uVF2h8HhT
 yfO350lF3nThUeVzaSfX9uS3fdYybKaspKFn1cxoVL0F2Cp1mOQvzcKrkBS26kOVYbZP
 z1IoYxVo7NM6H4+HlZ3JwAsmwfdJCyeD6wwHVtqvnLoasn396fm1JwnbaiQaHz3ScyHB
 qJlSLl2gldJU3I934qXCt1QaZYt85l5b6lH0gizK8Phav8F8jIVOO8heFKLzzQV58vq0
 GRffdm0sCSCO/7Dq6siKguO2Q2gxPBbnT+GqQuARtznqnGf0Q+rTg8URFFdQneuT5H1J
 63KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789387326; x=1789992126;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GI3Rv7ObpzYOMNGe1IKpKyfU2dIihWKscaYwXS1+JvU=;
 b=qn/DqIJRVaKOxSQNxHFqpCmZizfPTSKg7LpqNaOu/4eZTeCyAEyOFZFc3ERpye6mYZ
 zgd572JQzdBxO19jFn5L4ctC01r/Jnj4o029P9AII9O9p9qVFCVwnaNJpGILPiUei5hY
 B8T7oe20AjZiu2pvGyQZc4ZSCqKmDpGLxjtvy52UTHeUqXfguaAQqqTpHA2lmVV7CZCP
 R1Gce9ASfTesbcVrjfjVdezsScBDLUhT55SKbipltOoXFgeHxZ5889JbxTt8YxGH3Gou
 OzFTnqGDt3o/U44UDonVNX7jESLXPD2xb1+/rFOQMZzb7qygPSIsNuB0DZzmT2wCwZlP
 mwBA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2al3Xz/xq7/3sf/0SMgiZK1hsS6LYMmQwPrAltz5nR8g2KIT4XSLTyzAC+yyQ2BlfxhPmxI0h8koDhzWP@lists.sourceforge.net
X-Gm-Message-State: AFuF++myNvNVQIhevMEndyUy4euKlZi5ZTAe+kLfgGgzyndTAwo8uOLS
 MGeOVMM3E47d9izXTYRRC1g7RyJhv/7paPC+3NBgjW2G415+Kv2xcj5S4H5BPCZcsj2clnDIaCK
 oEEJKZBw4TkV6CoJurEG7BmurfnMCvpYWJgES8TRwUPw84DRkCDnE03eAqrXZBZP9tbmw
X-Gm-Gg: AYBFou0/bCOA3QU6ZBsgYpHuQCZ2QzBXbmSo5BNBrtXuRBw57DSJBmThBIDFO3PYeAH
 6Dtmk7pOqbwHQ36fmgkYlnWZk1rC41S1L1zczbEf3qCFfPh10sesNMc5Uw0FbNRg6g5TQxJ7G+4
 f239bRtWveblNj9ClEaFu4/ZfGeR8eB/l6m2ybJEgnAS87ngKtYhHOL3qx8hSF+IPcq5TzjRFWs
 yy1V/iv6KW2NxAtrBkOF5xcGDOkDPScDmQfFAh0QU3OEdp+VyqeXYyuk5DEmRVP5jEE6sYitYTA
 do7rltTZc++n0jmQoDn6CYCB0+w7aYns0EvXVW12QlgP2i4cIkZMCvWw1m5xPFL1ri+/9yTrNO9
 MQEGiYp2hNgaNAIYNGRq+M+3G2WVmrNfWoyyiqbQ/lkptjvTjh4ysNt1nkAI4qvjjbumSj584Ni
 zmGZJtzvDw3Cdo0+oavmckDCMcu0HmfQKoCNYkT2e1BFKirKiUte80oe0p/2vyVeynjMKzbj8TH
 dRcr05wwRQs5h2LV1liZF9AQWygcYXHZi690c/LyRQzo4ObaVe9kktefPc9HOYlzExj6HAuU5TW
 gqLvy08e0Mdb4o9p180kIFK48UwqX3eIXhjDLhRa7+h4me7WvwrakeBj/vER7g==
X-Received: by 2002:a05:6000:4919:b0:487:177:a992 with SMTP id
 ffacd0b85a97d-48702acea32mr6209397f8f.11.1789387326440; 
 Mon, 14 Sep 2026 05:02:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ee5csm26531587f8f.20.2026.09.14.05.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 05:02:05 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 12:02:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
X-Gerrit-Change-Number: 1617
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1617?usp=email>
X-Gerrit-Commit: a57e39923d55987336f544ce0c1b3b42c35f0ec0
X-Gerrit-Comment-Date: Mon, 14 Sep 2026 12:02:04 +0000
In-Reply-To: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLklkMGNhYTQ5N2M0ZmYxYWQ4NzQzY2IyM2YzMzJmMDAzYjJkMzM5M2VkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <275ba9e29d7155ebbd8410779bd25d0020d5417f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x65Os-0006Ba-Iq
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 useless assignments
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com, gert@greenie.muc.de
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4391803425230426769=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4391803425230426769==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a8ltyQ8QvTU="; charset=UTF-8

--a8ltyQ8QvTU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

flichtenheld has posted comments on this change by flichtenheld=2E ( http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail )

Change subject: Rem=
ove various useless assignments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 22:

(1 comment)

File src/openvpn/pkcs11_op=
enssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617/comment/8dec46c9=
_ec352a8b?usp=3Demail :
PS21, Line 187:             sigalg=2Eop =3D "Sign";=

> My cppcheck run also flagged this as an `unreadVariable`=2E [=E2=80=A6]
=
No=2E But that hit only occurs with newer versions of cppcheck than I origi=
nally used which is why it was not part of this commit=2E

I have investiga=
ted it and it is correct=2E It is somewhat indirect though=2E We give the f=
ull sigalg struct to a function that then also doesn't use `=2Eop`=2E



--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23=
f332f003b2d3393ed
Gerrit-Change-Number: 1617
Gerrit-PatchSet: 22
Gerrit-Own=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@gre=
enie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: stipa <lstipakov@gmail=2E=
com>
Gerrit-Comment-Date: Mon, 14 Sep 2026 12:02:04 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailbox=
=2Eorg>

--a8ltyQ8QvTU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail">View Change</a></p><p=
>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/pkcs11_openssl=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1617/comment/8dec46c9_ec352a8b?usp=3Demail">Patch Set #2=
1, Line 187:</a> <code style=3D"font-family:monospace,monospace">          =
  sigalg=2Eop =3D &quot;Sign&quot;;</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">My cppcheck run a=
lso flagged this as an `unreadVariable`=2E [=E2=80=A6]</blockquote></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">No=
=2E But that hit only occurs with newer versions of cppcheck than I origina=
lly used which is why it was not part of this commit=2E</p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I have investig=
ated it and it is correct=2E It is somewhat indirect though=2E We give the =
full sigalg struct to a function that then also doesn&#39;t use `=2Eop`=2E<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1617?usp=3Demail">change 1617</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f0=
03b2d3393ed </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1617 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 22 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;l=
stipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Mon, 14 Sep 2026 12:02:04 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: razvanc &lt=
;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--a8ltyQ8QvTU=--


--===============4391803425230426769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4391803425230426769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4391803425230426769==--

