Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADBFC9830E
	for <openvpn-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WojqCeQ3JgVsEv3W02kbeqB0iEezjUMSruV0cdg/E1c=; b=CBBsqG0g7hUiHXTxWb9gl4vRm8
	3bW/zVW7zYzgziTdldMuOoKYTGYDAf5NNRfGQGnDMGOl8qr6OHxsTUV0adN0ZvltKg5QOIp0q90U3
	ZuOi19/FX3I4ZYd8ZHo6VoKvAjM4+BeDuCI32rnaGredC0hPQOcmRN7sCkdrG4OPBwWQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9r2W-0002j6-PX;
	Thu, 24 Sep 2026 21:31:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9r2T-0002iy-Vq
 for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 21:31:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MhnXWqfgWjAnzu6TbgZvmxqqPb8VFU5DVymuDxe2bfc=; b=NIjK8LZ8DgEDdWBYPDmy0CS4Hd
 71JWk33+O0jDN2vOnWLnhJdhnCYag/Av5uiKTimnZwdSlJudgp2bcebsN6/uLSpQbWwRmRextdNpz
 RVE3r08BxzUXyf4Guv6ol+cBsCCpJhdQ+B0TQKNCRTQTC1n0wtLLrJggsUWi1g7hKJQg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MhnXWqfgWjAnzu6TbgZvmxqqPb8VFU5DVymuDxe2bfc=; b=R
 2yBOZNI68+7I2sIwzB99YCG7OhpY/qLnA0JeJrOXwzboUHrYf2vVVd4Vmhp+JlvjhQ/StuhArVjWV
 bXb7azBe2RcmNiAtZ3s8cgc4P/J+ceqMXMgJWasfTcBumMW02FK0EITWkzKyzOGi/hIT8ycKkS+wF
 EntbCAG0Ef7d7CPE=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9r2T-0004Dp-BL for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 21:31:33 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so1364955e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 14:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790285487; x=1790890287; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MhnXWqfgWjAnzu6TbgZvmxqqPb8VFU5DVymuDxe2bfc=;
 b=eRlR+ZXo2kdUARYm1jW8sQTsFxNrT5ojLDDzlmSbJFS+eJu0rCpjT7xpnrVpMAfB8X
 K4vxRIpihD1vqkIz/mwHGuISEHo64G5o3VC7RDTwBsmcWHoyhdVfzVk5FGv2DzwK3whO
 HRiJ3zblkG1Z6qWQAxwXAXK294vj7JpXQ7Ak0QgK3H0DjvLf0HTzUCzDXNSH/iCvMVPV
 TdxDAqH2qXm8LXmvjP7hNw7NOk0AIv46Odasy0E4jGm+CElBWRzz9x6UnMOfgoxnu+xR
 G0DdfEZtBZMnle9E1AmxJWN5eSQFGkOn/IiXwfvqKZilXd5TgICNSvrQwJeun+uafBtK
 refA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790285487; x=1790890287;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MhnXWqfgWjAnzu6TbgZvmxqqPb8VFU5DVymuDxe2bfc=;
 b=gepJlShAw1xKZqZsDZwABNz3c0CCUwzS4dhr0OygoQBPyVuuSjKKwl/CETjw06CXsJ
 ZRcgFQvoytf6feufWv341wBY31Sc3p3fQxXOI4zN/KbLtS72RHT1+FuaMCk2LZqL0+i4
 yxcXCNPCc/czB8C9J3qIh/QJc4DH8+sXYqZveZeVWp48Cmj9/FyntD/pqM5MkmJH5a8y
 Is1qlGInqdlnJ5ij9a68jCYQnbBGkv5gNVwtmPQEX7FimhgBLrtHU1ybtvdzjygZPWxf
 szh1+pUPCSmPoi349ddbHdjMkkl3kay/azYh7tZtkBHqb1akRN9oiEr7WdHQ5obJRgMy
 skPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0MmtoovmYZrXyNJstVno09BSYH34soiQwNxLde6vTJcfUh23OJlPZOB2Fi2GNpJ2wvPiP0U29I3+oIApx@lists.sourceforge.net
X-Gm-Message-State: AFuF++m0rfDoaQisVsUFW33xzGtu7mOYHi1j5r4V+wU0OcgUMswDWnWK
 PoJWSr7Amnk/7hLbOLcquTE18B++hXUjsPlEUfCWRufEvJzBQ2kcTozkryiy6Q++AvcYFkvqSdW
 UOGvGlrr5nXZBYPbtCEVIY91y3mjqc6sCzNMwzWz8CykSIujpXexMfPL3seDUTNXAD40imMcwWc
 VqC425sQ==
X-Gm-Gg: AYBFou38UH5UJy2HJNpO672QLPiE6qDuMz5cUT3Bw+r86syJd71SUuInoFuL5Pf4SLR
 rhSbCQXAq0qcj2rZpilProcGshlqlmGmF1IMTe5irU+h5BH9nFRV1aaBJhH5hqiv12nZvwqEAE6
 /t/y+qekGy02yS725nCiqPpr6MX3l+TnBGTLoTbl+yVBmKVLEnIGpTFJWTeJD0PGgBkdcWJKzQE
 liGu5M921UnL1QNECNBXrecHGQPa+Gw99e5sl6gVXq7vN56U/3ocj0TA9tC9zZBf6Du+3Dp8o9u
 xQTfXVmfmyfJ889n5w/y337cPtNEEojR4WXC73DJbBwJmK/Lq3uF4Ga0OuP38WulecvUr2YdRGd
 dqH/2mnj/RbJEsJyrLL7SftPgz1CaERfa4ywhe7gBCaxo4oXUduHydfulstleViqu7vST34/IN2
 aQ3a/2gCVWNQr+1V73Zp6agTyYNyYScAr9MsC7bLzjt4WtD449ZNGwflzMWlUPLUdlNvzXNskKs
 0FxmxB7OzA3300kfQH3k07ebnBNNTGYsQsFV88VNkPE4knXYqLAhrGQpajV2FpPsx1r6XsmTXFw
 qUK485zwSUrhc91mx0RSP8f8eQFmCYvH5jnoJ+xBthOwaWzBupvY5B7znYzO
X-Received: by 2002:a05:600c:c48f:b0:499:bf8c:cfd1 with SMTP id
 5b1f17b1804b1-49fe66bdfdbmr69243825e9.2.1790285486628; 
 Thu, 24 Sep 2026 14:31:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff06b4d45sm7037355e9.7.2026.09.24.14.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:31:26 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 24 Sep 2026 21:31:24 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5
X-Gerrit-Change-Number: 1737
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1737?usp=email>
X-Gerrit-Commit: faaea4c811c3bc93b2121a96b2a4aef893259467
X-Gerrit-Comment-Date: Thu, 24 Sep 2026 21:31:24 +0000
In-Reply-To: <gerrit.1782693360000.Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5@gerrit.openvpn.net>
References: <gerrit.1782693360000.Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNjkzMzYwMDAwLklhNzg5NGZjMzYwYjEyYzVhMGY2M2ZhZDJhYmI5YmJiMWFkOWMyYmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6f9fe93a1fa72c8ffe2f486532722c00f7068d5e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9r2T-0004Dp-BL
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: read
 multicast notifications on a dedicated netlink socket
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2740447472860573435=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2740447472860573435==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SeCuSkX2wMQ="; charset=UTF-8

--SeCuSkX2wMQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

ordex has post=
ed comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1737?usp=3Demail )

Change subject: dco_linux: read multicast notif=
ications on a dedicated netlink socket
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/dco_=
linux=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737/comment/db71af1c=
_e735e27c?usp=3Demail :
PS1, Line 1228:         return 0;
> I am not unders=
tanding the question=2E=2E [=E2=80=A6]
if I understand the your point, you'=
re saying that with this patch we don't bail out, but rather process all in=
coming DEL_NTF properly, which means dumping stats and so on=2E

Yes and th=
is is the originally expected behaviour: shut down, update stats one last t=
ime, be done with it=2E

This said, this behaviour may be suboptimal and we=
 are already working on an improvement which will attach the last stats to =
the DEL_NTF message, to avoid one extra dump at the end (which often result=
s in -ENOSUCH because the peer is gone already)=2E

Does it help clarifying=
 the doubt?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1737?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comm=
ent
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia7894f=
c360b12c5a0f63fad2abb9bbb1ad9c2bd5
Gerrit-Change-Number: 1737
Gerrit-PatchS=
et: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-=
Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 24 Sep 2026 21:31:24 +00=
00
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ordex=
 <antonio@mandelbit=2Ecom>
Comment-In-Reply-To: razvanc <razvanc@mailbox=2E=
org>

--SeCuSkX2wMQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>ordex has posted commen=
ts on this change by ordex=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1737?usp=3Demail">View Change</a></p><p>1 comment:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><=
p>File src/openvpn/dco_linux=2Ec:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737/comment=
/db71af1c_e735e27c?usp=3Demail">Patch Set #1, Line 1228:</a> <code style=3D=
"font-family:monospace,monospace">        return 0;</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I=
 am not understanding the question=2E=2E [=E2=80=A6]</blockquote></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">if I =
understand the your point, you&#39;re saying that with this patch we don&#3=
9;t bail out, but rather process all incoming DEL_NTF properly, which means=
 dumping stats and so on=2E</p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Yes and this is the originally expected beh=
aviour: shut down, update stats one last time, be done with it=2E</p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This =
said, this behaviour may be suboptimal and we are already working on an imp=
rovement which will attach the last stats to the DEL_NTF message, to avoid =
one extra dump at the end (which often results in -ENOSUCH because the peer=
 is gone already)=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Does it help clarifying the doubt?</p></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1737?usp=3Demail">change 1737</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1737?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1737 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 24=
 Sep 2026 21:31:24 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: razva=
nc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--SeCuSkX2wMQ=--


--===============2740447472860573435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2740447472860573435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2740447472860573435==--

