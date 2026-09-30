Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF475CA5FC7
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Co+fI1OcnlMAGOH00W/z88jdP/q0Mio3diacfU5K3Mk=; b=S63mPcg//f0/CNn8vsPkJ6emyW
	I9YNIj8gx5IlDnM1P5A8lfI9Ii76UPvbyLXG3yGmn8b09bayd0NSVfiQ9jDTW1o40lzcX403bGWWF
	Cl5ivVrz50stPv9AFv0hKZqqsmVNKYAckBjvUcIU6BVXfk9uGdrM7TVlIeshAb836ngA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBvPg-0002qs-En;
	Wed, 30 Sep 2026 14:36:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBvPf-0002qf-3u
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 14:36:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=FDnG+KfMq7odOrpnuIrJSC3KOw1lTb6TASHFyNLFwDQ=; b=Z+K8AFTY44j6tSJm8/ztgyJMJ1
 LfY1WjSuKF+fLrJ6TCV882NZTmzxA/dwY2/YNQsP6jfMg3Ppna28dOGq7YYGrDIeI69xv/mJsleaC
 A8sjoPSRbsPqjZbGm9KN932x0glVGJVe8c5J0B2KoANYRI7HgqjhQhPXQNIJjGur3cok=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FDnG+KfMq7odOrpnuIrJSC3KOw1lTb6TASHFyNLFwDQ=; b=c
 2a4chRhJogAxe/Z6gwYXr0Zt6YUsDN/GtTybAVF5RrRj3q5Q12XJ0sFwHp8TOjGaFnU/Bv3Z0adBP
 3Bn1T3XOj5w1td2Vix4Q/+3noI+F1KAFmFSBMFGq57HaXFjnuxbQNugN4VQaZDR2vgGEg3KvXgDdQ
 AGtuk/jR3Nb73PbQ=;
Received: from mail-wr2-f39.google.com ([74.125.225.103])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBvPd-00076S-T0 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 14:36:03 +0000
Received: by mail-wr2-f39.google.com with SMTP id
 ffacd0b85a97d-48af929e59dso1204059f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790778955; x=1791383755; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FDnG+KfMq7odOrpnuIrJSC3KOw1lTb6TASHFyNLFwDQ=;
 b=ApAazeq54JxB5+dKZtya1icKvv/Kiw2SalTwZO3Xj9bN0koJz72tm80FsUcrp2ZdqK
 q1MkAhxn6jxl94Z/tSrEYKEVJlcXCjhMqJfG+xe6TJ87jlJsyoRRPJB1VHPrqwIwVXXr
 DlwCdapIdWg3xz0LYtvIhzJawUS1zfKxtdBDUJq41UWlo2h/xh5NCpIOK4xfYZT0+xsP
 SMbTBUODQgZOxVh8ggPOGf2WSOA9AJKaw3/ckfKeC3NEJdA0/tyzVhZXIx4XHHwGuJzu
 x8qBoLvqohKRrrAMA6Dg9Hgf8hZEVnJ7HjmJYElVMhFExPFSLIvlB5fx0H54+d5VfQYt
 JGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790778955; x=1791383755;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FDnG+KfMq7odOrpnuIrJSC3KOw1lTb6TASHFyNLFwDQ=;
 b=GmOvD87uKBPis6CvenpOEe6CwZDw+YjihguP3iuq4LvAYoUr8IxZgHmy+JlJduPCDw
 lvEx2M6ZVOHGs8gTqx6ueO6NVDC5SRxQ6zAdFcuM2ZYo1fSeDMwJg1Sa0g5y54rJu8FU
 lU4DNtrAW1AZmteG79LYqDM8BNdyVIXK+W2L5J4PV7lA5/bD9EKjyEbMkPgsiJtbGlcn
 D7N3aRguDhAdJB99ht7fUU0iOQAOLLugER/oniyARR8djcPyDbCH2m1rvCUMgqWaP9Pf
 4MYYX73yWk+bS/qoLl27Bed7YsCzcwWucGXHxaRMRyywTfW/XdwQyN1oF1zsIAMMhMn7
 gDvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHVSyPuB0qomrN2AzBBegXMkSHKT1PX4w5JMJWiVq+qIN5ZYI54zL/95d2DAMCIZ1P1+HfSLaN7BaV4ON6@lists.sourceforge.net
X-Gm-Message-State: AFuF++lelOKEcBtqinJX2Ftz8CpxIX6yJ1kZ1XbTlxxpisXDP4R+lzMu
 FqTFPpn1muQAFr4a6nysoViF7I05oIUS+ku65x+phIxKcoMm8KAyyaCnnvaX7alneBBB9M6d+ll
 0R8kIiULgY0rCVRRXycI6mHQ7QePsqOGegfs8xut01FpBOYCnONEfTd173DWIg8oqO3vp
X-Gm-Gg: AYBFou0R3EYRYlF0rmrRyjzrjxcYCWbFmCZ5iVMu9kPi+nrKPNfkWjgAg6NhbIX8/C3
 /mND7UIJC4lS+DGZOH58lkfno31nj+6MLJsDHgZI3ubQcnjyvi+JbSZq9xOrbFw0K00mdSokghm
 AS5gAFv0Jlf8vx7306KDiHhMArPsnYFueXGxQCdekheWoFQW1ofIlP27P9sgSBeeBRRoQVpAcME
 dGZIRpPNCOd2DphYFChcObgas1lztzuqClkysZV6PRcE0ZJxWyYzBtMx54SBJ+315vg6ZkehuQX
 gikYr1foXfTaJTVQLUdFMggyBWs0gGIx0UtwciFjjFnpXpLFA7lEmTeasML7ljF3oHq1hr/2VrT
 IVkuptF9XHaWrpWyAC5N5WzMGM61SQx+BDhcF/a7rdVuYGhap7MBQ0MRGI8TLrBcK0ra8fPFpC4
 nhJrO365NxYjEyM0Dl0suHsNbMSpopwg6T5yH+kj5/G0+70OYQBVTx8kf4cok7yfjHXToG1igHq
 svnOdQv5jVGP123H6axci2CFjfw19HS1PdAg8O6ZKVwKtWO3dwKtJ73oE2OK8xPoob9kb2suAdp
 UZAt9by+wlYNvnMlB6LKCrjhdZ6IsJtgzf2Fksv8ip1H6KUNcWsQdW1Nbx0kz75Ru4nf+bM=
X-Received: by 2002:a05:600c:3b1a:b0:49e:81db:4926 with SMTP id
 5b1f17b1804b1-4a01aff3cdamr28464295e9.5.1790778955098; 
 Wed, 30 Sep 2026 07:35:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01cd5cf5asm10587285e9.3.2026.09.30.07.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 07:35:54 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 14:35:50 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: 09ca456f4fe87a0c765407eecd86e2b0f944a300
X-Gerrit-Comment-Date: Wed, 30 Sep 2026 14:35:50 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d68f72c418cb311b7a98483210246aae47b67604-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBvPd-00076S-T0
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add a shared TLV
 codec and use it for early negotiation
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8867303611983126534=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8867303611983126534==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ydSGlgmoxo4="; charset=UTF-8

--ydSGlgmoxo4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1965?usp=3Demail )

Change subject: Add a shared TLV codec and=
 use it for early negotiation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(3 comments)

File src/openvp=
n/control_msg=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/=
fd568f0b_59ce8397?usp=3Demail :
PS1, Line 34:     uint16_t field =3D type &=
 CTRL_MSG_TLV_TYPE_MASK;
Is there a valid reason why type might be differen=
t from field here? I wonder whether we should ASSERT?


http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1965/comment/df6ec7b6_9c4db79c?usp=3Demail :
PS1, Li=
ne 76:     uint8_t *v =3D buf_read_alloc(buf, hdr->value_len);
cppcheck say=
s this should be const


File tests/unit_tests/openvpn/test_control_msg=2Ec=
:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/0ed3b34d_0ab7fd43=
?usp=3Demail :
PS1, Line 107:     assert_int_equal(BLEN(&value), 4);
Any sp=
ecific reason why you do not verify the content of the buffer here?



-- 
=
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89c3133e009dc75dc2c10c607=
b3f0a24c04e8146
Gerrit-Change-Number: 1965
Gerrit-PatchSet: 1
Gerrit-Owner:=
 stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attentio=
n: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 30 Sep 2026 14:35:50 +0000
Gerrit-=
HasComments: Yes
Gerrit-Has-Labels: Yes

--ydSGlgmoxo4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>flichtenheld has posted c=
omments on this change by stipa=2E</p><p>Patch set 1:<span style=3D"border-=
radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-=
color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1965?usp=3Demail">View Change</a></p><p>3 comments:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/control_msg=2Ec:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1965/comment/fd568f0b_59ce8397?usp=3Demail">Patch Set #1, Line 34:</a> <cod=
e style=3D"font-family:monospace,monospace">    uint16_t field =3D type &am=
p; CTRL_MSG_TLV_TYPE_MASK;</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Is there a valid reason why type migh=
t be different from field here? I wonder whether we should ASSERT?</p></li>=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/df6ec=
7b6_9c4db79c?usp=3Demail">Patch Set #1, Line 76:</a> <code style=3D"font-fa=
mily:monospace,monospace">    uint8_t *v =3D buf_read_alloc(buf, hdr-&gt;va=
lue_len);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">cppcheck says this should be const</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_c=
ontrol_msg=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/0ed3b34d_0ab7fd4=
3?usp=3Demail">Patch Set #1, Line 107:</a> <code style=3D"font-family:monos=
pace,monospace">    assert_int_equal(BLEN(&amp;value), 4);</code></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Any s=
pecific reason why you do not verify the content of the buffer here?</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1965?usp=3Demail">change 1965</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1965?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn =
</div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8=
146 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1965 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Wed, 30 Sep 2026 14:35:50 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: Yes </div>

</body></html>
--ydSGlgmoxo4=--


--===============8867303611983126534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8867303611983126534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8867303611983126534==--

