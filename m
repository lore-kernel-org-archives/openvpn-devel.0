Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB97BC982C4
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v+Bx6j/r1KyMsL82HdYeiUrcnz0ZAHvnhUJhCy8BSfk=; b=Jqua8AV38fNl3CzWHc1ybheNbB
	3A/6+jY0L8pY2Z9kM8Dh52tr4r/q4wfSBn/roUJ8S0Zg52zI2CqqEnYpI7KiOWbQF2nG7XdpMztKJ
	KlPaWurywzFIGDEMPLZqS8CgrJTt2OY8qcwFAjpsdgRAiw7mvyNqaKFXaUI9laD+lHHY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6rWp-0006hm-Ty;
	Wed, 16 Sep 2026 15:26:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6rWo-0006hb-Ot
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 15:26:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=u6wLFrFljfMSpOleRyG0mZ7qTtk+PQh7I40AMC9HIFk=; b=CMxE0lnYYgWRjkeA8IP0CJ0ZcE
 jse56d0C+E9N2qT3OmVm67NKnhZhhxlqtmpL/6BeVfwWmAELLSM0Djwo84FuRIL8mRdbaH5Hzl9vK
 94TGSlhMsnWRxe5eyq7Ch85AAcOUyYWyGMPC6UlaSbF1Je0m0VQNyV/Tb04E8rfEiRH4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=u6wLFrFljfMSpOleRyG0mZ7qTtk+PQh7I40AMC9HIFk=; b=I
 JWACBgA5MVqMWAmAmiLPgxJd92S7SVAGxsdikv+Q1p2r3RWxl1n9LCFiytj3D+8oc2MjYM5cVUkIL
 kXKid7W1v9TolP3q7NLXbikgn10xQbJzbook2S5NufXZiaYXaNH4J4utlnQslWwwB3ik5CxmXrdzY
 nADWIlJF+Pd8rNZk=;
Received: from mail-ej2-f12.google.com ([74.125.228.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6rWo-0003O3-O9 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 15:26:31 +0000
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254fa65080so148037666b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789572384; x=1790177184; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u6wLFrFljfMSpOleRyG0mZ7qTtk+PQh7I40AMC9HIFk=;
 b=W8u5rszvBFYaxKGgCWvdqjkoPAL8HQDrHnGpxiVvj3/hCGeOhKo8GqrCwq7c0dp6uc
 hpgBebjh1aDyLVqy0FcXcnaEBBg5vQXaUeJLUgFHSSnV/Nqj5yLJaZX9rRxc/LKU/Dc9
 JVdmVML3WV3Cj5JdrDIXTuytDvINjQClyK46pOc4zr1TCHKFv+cnxVlvzCtCGXGwt2Br
 6+1yR5hszj4/2P8mQuAWrsK424T/TxTYKV+P85FIYhKt39moE9r530+kU2/u9jzq9Zqi
 RiKW+VsU8XYVJC4AyHBH4WBG3zCC6hglYw+sLJFTUj24GNT0D7HAMOuoWjyF6oW0a7tP
 ykzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789572384; x=1790177184;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=u6wLFrFljfMSpOleRyG0mZ7qTtk+PQh7I40AMC9HIFk=;
 b=0GHoS4hMI02TfPXFWAGN34+DJ1188jqx3lzTZw9+Fx/SfBznJNfyJ5FlNvvOhAe/dq
 ni2Y629P7rIqeTq4Kn2XJRTwiiwe9K/qeIO3SgZA6aKuA7Q36oKNX0jIid2i3vy3+AJs
 EUGHZsjhKdgeqNsFp3RCYeIHW3Wnjim7XzyGK0kkGYhFr4TAl+KXTwn4H3izMletDKMR
 QesFdFnoA2X6jkN/v0eg362N3H1ISQmWGmomB9OtzOGKZM4l6jaeird+G/7y0Q4O1i0G
 TOeCkEAWwtpWOVYew/+Y4pm9Dx0NwSUmVETNb55NUndDSKdyqa7PduFzuulK9J39ZXk+
 sV1Q==
X-Gm-Message-State: AFuF++llZ5lnWLcyYxL9O9uKS0Aue37eqPyD/80Xs4JYuBmEy9DYMtlX
 8X1F37SBT8xs9L+kP+SldIKB+y6ELRtvT0Yo8sjCowQoZdy3uc/ZGws0GxrF08rH06+W+KgxZvI
 9R6gYF0EO1jTFGVke8DonYfAtOwcdOvLlF3QK8DSyfaf3Ts8zN15Uqlow+E30IHBts2XkjoDk83
 jwKbb2EQ==
X-Gm-Gg: AYBFou0ZCMUHdzRgtmvQQBX+rQU97A8LiR2EVBBa31nrNbMOLavK1XCSmTt1eYgI/Vf
 R2Vd5+u88hbriUf8289HOOT83COTOCJKgUiCjENkrQEj2KITrU0ZKUJdoqmWphEKDNe3kLqj8vw
 stGjVsIWgUrR4Fz2eE9TfmqnHYwE+GYYXM50ra5OYvZzI5f8DibLrqyfN6Hyc4A3EmyZsZc1bfN
 CTpAH6Pt060QxmEc7qH31Kw9e7GUMEZ2J1njrEhAAPOFjUBml/NuMfaHQmA5u/jQ9OSkafjAs3o
 Gf9k7S0NrmZ1GYFMVtudl/HIr0L+WI3CvJupDLOrhyIGjMO01uvfAtQ/s5K/y9KAha6kqZRGlDV
 vpU8Ql45wmHFMJV6iUU9Vw6NPAZed02zYMnART6slsLIBtwkxf34ZI7CIYjZccrQZl9WqmHhN9j
 ARzNrnJh7JF3YB82DhPEL6xbG7clb/I2f2b0JM+rCGwDgy4qwklD+3FmbUzSMc/Nu8I4S7tNO5i
 pnmc2tgxsLU8t35wfRnLPwT7L1ol88HcwaTOtyBHeTaCGXYomlvyoB3DTwQaHasTiFbK2mCGAXL
 0ZWljNNatgkUH8x7GAYwFLFEMPDA1SaFj8NMRGuzmxu0PGC0hlMKeT2WMAcePg==
X-Received: by 2002:a05:600c:3547:b0:49e:7423:687c with SMTP id
 5b1f17b1804b1-49eac46377amr26352645e9.1.1789560523327; 
 Wed, 16 Sep 2026 05:08:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83add98bsm86860705e9.4.2026.09.16.05.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:08:43 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 12:08:42 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4
X-Gerrit-Change-Number: 1916
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1916?usp=email>
X-Gerrit-Commit: d6ce7238774423b5d4970d502c554cff1d2235b8
X-Gerrit-Comment-Date: Wed, 16 Sep 2026 12:08:42 +0000
In-Reply-To: <gerrit.1789456688000.Iac6d49d064215510bde9a4cd4600ab3a50a45cb4@gerrit.openvpn.net>
References: <gerrit.1789456688000.Iac6d49d064215510bde9a4cd4600ab3a50a45cb4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NDU2Njg4MDAwLklhYzZkNDlkMDY0MjE1NTEwYmRlOWE0Y2Q0NjAwYWIzYTUwYTQ1Y2I0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aea7b37afbcb8832e409c745ebc00ec3a2cfdf78-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6rWo-0003O3-O9
Subject: [Openvpn-devel] [M] Change in openvpn[master]: ssl: do not trust
 the peer's request to resend the wrapped client key
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1334197393259057974=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1334197393259057974==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AvW/Ed2QNfU="; charset=UTF-8

--AvW/Ed2QNfU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

plaisthos has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
916?usp=3Demail )

Change subject: ssl: do not trust the peer's request to =
resend the wrapped client key
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4
Gerrit=
-Change-Number: 1916
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@gmai=
l=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Wed, 16 Sep 2026 12:08:4=
2 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--AvW/Ed2QNfU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>Patch set 3:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1916?usp=3Demail">View Change</a></p><ul style=3D"list=
-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3Demail">change 1916</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Iac6d49d064215510bde9a=
4cd4600ab3a50a45cb4 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1916 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div =
style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 16 Sep 2026 12:=
08:42 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--AvW/Ed2QNfU=--


--===============1334197393259057974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1334197393259057974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1334197393259057974==--

