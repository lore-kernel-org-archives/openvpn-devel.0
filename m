Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBF0606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MZ4F+Mae;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jlu5r7xk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BMAZdJ+k;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bREPB0bL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=v1vur1iZ1BlzGequ65ihmRERlluElKivjm3z5hltMZY=; b=MZ4F+MaeWa09HQBplscTqGnjf5
	7jgEUI9vJaFlE2aQeiVHAWVEY9Q32xZVse13wlalgvcZwwYkKfcTA+oQxajZ4HwLS4lBidWeps5dc
	EED3okfvaTxGE6ufHM580qejV6UGs/a8+qzskEWdHOClnW4TDmHdFH6nj+bN2xS9QzCg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOaGL-000000001QF-3Ben;
	Wed, 04 Nov 2026 12:38:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOaGK-000000001Q7-0Tps
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:38:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wWxmHnWeQty7MQpfEunvOcuUlSWGOxvTUts4FiV+zAw=; b=jlu5r7xkkkZkhcqz8YK1XhpUCJ
 3bDMKY3bzZVg/fyjmFVLEinSm+0ySaZvmVG1tjgNtj0RDykN/b7XxTDBzojgggkUgbsQsYNtBBi9w
 Yo+bdSdDtYoF2ylBJttSfy/xoO57S2XIorwqQqJe7+PDXCaH/B3VF6p+assSdkojU6/Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wWxmHnWeQty7MQpfEunvOcuUlSWGOxvTUts4FiV+zAw=; b=BMAZdJ+kilI4dvyo1X96h0JjSZ
 Sh6s5DPPrCFPPfbkKjIj4g6qsyCSxrYEcPjalOHj/RBt/WtdF5lJFB91thJBrQpi37whXrY/J4pR2
 I8MY69q2jGqGXd0TrWCvHKRD0cvBD9lyb6UpmOorOlgpVkLMfMF9bGUllfM7RbdY56lU=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOaGH-000000000EK-29HN for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:38:44 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso5051255e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 04:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793795915; x=1794400715; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wWxmHnWeQty7MQpfEunvOcuUlSWGOxvTUts4FiV+zAw=;
 b=bREPB0bLIlktJ+of/UB5prIeRJBfjn2+/fmRZ8a3gWsbrtKMJOvBMCY+UO2tE4lZvk
 BnjO+B0Sb1f135H4y2LPveEbyXqtgQLN4r2mU427tVj0//mij7wQ9zE195epJwqxziUX
 //TdCopWNYWYdlOsWANvLOSJPiICE6ULgJb+G9kwXfITdS7d5bPg4BPAMJ4zqaVowiNq
 CI0Ag/Bze/akGhCaobCRLuJ531CNrVNc6KugzLbte1TjbAo2/Rm3jdAVgcX88Hfa85D3
 NYK+jE/3yLJZ62VilMnWS/VkaEmwrc4OE3T8dhrIAKUUYZAuGOcenlxWZrxOn5kABpHl
 4A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793795915; x=1794400715;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wWxmHnWeQty7MQpfEunvOcuUlSWGOxvTUts4FiV+zAw=;
 b=1YlJ8tYAvdC4KacN2k5x3SV8Yn9Aq5W6Hx4ol8yO3m0t0iWEzQfIc5m0G91NSL2/SR
 kR2k+bhP/NV0Bl5cOhUMK/UcIREFWBOj61T/Tvs4s52DfJEx6ib0a9Ku02wBFc6IyafW
 tGg6VBrzIAl5sLb7Wh3ACnsArU9DoNnSrfSk3TcSDoap2MlwUkA3DZo+0GCsO/xqYzI5
 iAREF6Jx9BWjQxPCah68PYofoOc33EpVjl6BIYSu9lXPaLPbVUn4xzvUoXr8Y8uXA9Wc
 LntEPg96kaBma3eLVP9oY3zYCYC11CUFblyKWMRqnjvS6Dvvwxqq80joWdWwKkBdvTwr
 iA0g==
X-Gm-Message-State: APuU4Z+cQuzfmWTAd/OZxMfWuABQKveDpELESOVR8j/hP78JfJq5kWcT
 25U89a3IAsI3qtfWRBFyXUGq5rSoC31NG20rFXQqxrChC99mHFWv/5iFHqXXifu78OZ/hIQH/Rn
 HYh1l4tYH9Ki2J5K9dCUN5/tzI5JMjQBithz+viNFNqSIWmkaUwGJ6P3lmhxZiBnHRmI6xrE8Y7
 N64cmjwQ==
X-Gm-Gg: AYBFou1SKaieKW10J+J4uwo+DO1OcWrQZEXQI524h3W7bI9mUCXVir4JE/bQ5nNM6Te
 TjOtQFwTWpd0EhZ8S33o9AuAkKyawIsnL/eO/bZdJ3PSRLcZHvWS46NyM4gDQe79npkgy73q0NR
 3mXTCuEtrQ0+lfy0aq92O5VUEURt8i8EoBObqimqEY6/R/yUxC2G2tzLZMQhzxDRuPD033/uwsY
 KSCneLL5FDZnvmAp2ErmPwwwncAA0IHCLic5hGSBt4uVQNKC6XxRqnVv+tMkbG0xV2kX+dHjKke
 pa6x0n5gFBg5SqbzzMgAsDYqX08DZe86N2a+/Z1hSv9FYifsR93TZRhZ8OCzAww66lw3lfC9Ayz
 LOkF0xlSDWOc4XxIG+ENz+/PDQBzJLj8FXg3xQr1mcTIgrYQvDSDBNYRmRBi3Sn7M+hSuzjcwwi
 lfPDRXfsYGZknNK+f9lQPCV82+nxIt0RSE8wQRYdjcAj4Ga6imGDMkyBwNaHjsSWs6uJMmmc52K
 32x5v732brzUP1aUi4+KuPiZPB+XcEPx74cgHYuiKPvuGDPepExOmqDlESNVqKFyNgSrTv/gP7z
 s5rzls8ZSJ2criRYbqUfYtnj/pdWUOP+6tRwke6Zv7R6qDBegI+uvkt0194zdrLVJgEM/RuemT+
 3GTERfjjrp0tjjcYgViflClWFbDdzmLmSKyMZfaTTPb71zo8TH82eB0TiKMgMZ+sot5s14viL02
 ezhxyAyyF1WFy21sQ=
X-Received: by 2002:a05:600c:540f:b0:4a3:18ca:806 with SMTP id
 5b1f17b1804b1-4ac17d1a1f1mr384688735e9.20.1793795914816; 
 Wed, 04 Nov 2026 04:38:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab010a66sm186631945e9.13.2026.11.04.04.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:38:34 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 12:38:33 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 4209c014003f70b1e0fd21f154d8eac8969d816d
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 12:38:33 +0000
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <479b2079e9a5dadc5bc675717468f8f28d3e77b1-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOaGH-000000000EK-29HN
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Adjust
 ACC_MAX_MSG_LEN to be less conservative and improve documentation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0944163858042838231=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0944163858042838231==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B2y2AbvCiWM="; charset=UTF-8

--B2y2AbvCiWM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Frank Lichtenheld ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2130?usp=3Demail )

Change subject: Adjust ACC_MAX_MS=
G_LEN to be less conservative and improve documentation
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(1=
 comment)

File tests/unit_tests/openvpn/test_acc=2Ec:

https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2130/comment/228c03b9_62755275?usp=3Demail :
PS1, L=
ine 184:     assert_int_equal(max_len, 2048 - 128);
Why not use ACC_MAX_MSG=
_LEN here?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2130?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3a268=
fc602e916bf54853c950761977cf3d7f835
Gerrit-Change-Number: 2130
Gerrit-Patch=
Set: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 12:38:33 +0=
000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--B2y2AbvCiWM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_acc=2Ec:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2130/comment/228c03b9_62755275?usp=3Demail">Patch Set #1=
, Line 184:</a> <code style=3D"font-family:monospace,monospace">    assert_=
int_equal(max_len, 2048 - 128);</code></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Why not use ACC_MAX_MSG_LEN here=
?</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2130?usp=3Demail">change 2130</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I3a268fc602e916bf54853c9507=
61977cf3d7f835 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 21=
30 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Wed, 04 Nov 2026 12:38:33 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--B2y2AbvCiWM=--


--===============0944163858042838231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0944163858042838231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0944163858042838231==--

