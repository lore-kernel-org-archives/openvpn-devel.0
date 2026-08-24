Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AA1C5DF94
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2eRbyCyVISIAyOS55hdppY8H2gszvGUL50qCmmuOaNE=; b=PQoC76Bxc4qBXD/AwuJCYszrzV
	KWsM9x6oqPbsl8ac7KWq9RrZLHU7DLG0u75K7lRr1TUGnyruR6nWCQ2WjZLbxDEAjCTJJpiEGgWZp
	E0nPRN+CITTOBaTuT2R0zANh7Ne32xrMzVuvgfzn6ObgtArO4IEvJogHMCpT7binsESE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyTCf-0003Ui-Dz;
	Mon, 24 Aug 2026 11:51:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyTCe-0003UW-HC
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:51:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=uEz+QwA6Q63ONfUjhPrIJ8WLh/z7bFiBPsCtn02rf+k=; b=b3VJ3X/xyryB5FA1PQDqN/9j5C
 QfjkqVJRQjUqTrme8TriyaW1nOfrdwN1xpmDxbZeuxDRfunLTz4/l8JZJwxfY0u9vXGaj8YkOd3/C
 WKtNo+OVvDe9iCcGrBqsIy9EgqFHzY0tNYsD4LvxQf34TmrcYrAkUlsZitoTimAd3Zz4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uEz+QwA6Q63ONfUjhPrIJ8WLh/z7bFiBPsCtn02rf+k=; b=Y
 fLusEKdD4mUIJtsaVxF37oFNMsPBFKnjdvXvJzRCtpCvGeyYw0Se5H9NnT3LsRnkXMJUBjQ6EbqBe
 jb2N9mRDnu2TxtSbWsc6k5Uun1WOVr1NrYsgMl2XOEJydyleujULqZ/+3J3srhSEdTsMirD10VJ6s
 frI+vDnffAATXvTw=;
Received: from mail-ej1-f49.google.com ([209.85.218.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyTCd-0007yO-Ku for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:51:01 +0000
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c20e70a0962so503625666b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787572253; x=1788177053; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uEz+QwA6Q63ONfUjhPrIJ8WLh/z7bFiBPsCtn02rf+k=;
 b=Szgf2QZHAA/ePexMgzXVv+AsmCqiRacEzuA6QkI24ewiQm+h3CF81Tui88Hq5o9zks
 /TDY3nqqiBJAJtpciES6dVMY5+xHeNwfvxhNy7FYK4Jg+ASprYxeNTV7I7D68bm92/ol
 zClL1Z1AHZscJUtB0sKByX6avcJQvWMm3iVQz0YoDWWT3QFEtad8FJWIytwqfkzg1Seh
 A42EjJUevBOhiam8BSxbT8vQkGTRVGSkntySMwxccFa6DUslIUIWqs0LJG0Zg5H1QGDH
 HdQIzRXAlAtbyBk4C2pLbPqVKTEdHT1Dpl5L687bgpoQsDNiMX+TOGscbPKgmWOzdHyP
 WVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787572253; x=1788177053;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uEz+QwA6Q63ONfUjhPrIJ8WLh/z7bFiBPsCtn02rf+k=;
 b=DlzC4DvIqDF7s022i6SZO3J/zZbaONo0/MXnLJ+8nnvGYJHVvxUZgwQ57+CUI/Fn0l
 Ujfofb7fkS6Hg2tqbxEhlR7WvDOQWId5upqeNUb7sLUIze8MjuzHdugGoXVvHTGP9KhX
 M3o4m1AFJ1Hs/GT2h6QwdmkyLFzGeFRJY36tvJU6btBPFscShC/Ty1Ai7mzt9hyCWMXZ
 ued3LVwoctCshtDi2swfze1lys4E+YRymjMZd8hUh7x5+GI7PujjpGcJ9cwXoueZoZEO
 M5uGvZ4YBmqxIrUwL+aFPmW3e+IUPr01wDfDi+WLqmRbCyFjaqyd9sJiNG/Mv33r5pB1
 Ki8A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDmggKyyCtq14bSIicjN6ZDMVzdfQmzzABvfFxZlPAuP1iKvTArFgpNo3e18mQQNc7zavKvjlGS0OzaQng@lists.sourceforge.net
X-Gm-Message-State: AFuF++muNpljFkDAT+MW0SbsI32+BXJPHCfifCXddUDzKAk7xjFqr/Gy
 Ox6fipL8gnHCJSLrtU5zvkFy9L8wLZ/32T8SWbpZW5J3ZFqpmCdY3Mr7/HtR1dOMpULHrTzhoVN
 3DYu4PSBLVUc14oBdU3nARYKacPl/A47oibUoJKgcmdnEFSNxI0OJ8PreLMBeYfiy4vgo
X-Gm-Gg: AR+sD12mPcN/tXzbZ0LdS6UEbdVFe9up8dMTU/C2CULGpAtElab0FMJr9c6ww20R9Ly
 JH45sNkRIN0CkObXdMYqzxKaAoc1Tt3kc0pJ5MixO3YMyF1IUul0PqThAIac9NCkL8oKoJmXVXo
 8ODx+8+t+/304FpFVYcEbOEXwfUb33ZcsKj6nIooSNQBY2YK87WJwlQFoUd8+HJ5u94DriVnC5S
 wzVIqlKpACjnodLhU8Gs+8zAK0Q2osthRi9UvMaWvw0lcW8FaruHHkVVINBJvSf+C2NARIbDhWB
 uLhjB7YrUxvGI/0zggjhH7jzM7qF8zlDfClX2MghrzLzhFVbz3NO3Irc3sFUAB33VFBglFZOsOG
 IRC64Rv0jmNrw6yTRpxJdJahyF2lvu5Jh7nP5Z4m5y54J+s/zvD/zwE/1EDEyxtxNtqn3bTRULC
 8JbNz4BiPqCiAZjQFKCdh/UvluaLezIMDpdNLtcggZfOtnD9ewJbA+R6HQ8Fp7QuVlM1dLlhedT
 unsh01OcpIb1D+GpNTI4r7gKLbjXmOvPpTOQRCZVtYf1ujYTdRj002AAGiS91n3pF5VRR0NTx/A
 xiYhxMQFdC+rCW7vn9l3FsVBo4omYBZ2M+78oQC4seGRQqH7qyE=
X-Received: by 2002:a17:906:d8d6:b0:c21:34a3:4d9c with SMTP id
 a640c23a62f3a-c246a72174bmr2267160666b.21.1787572252999; 
 Mon, 24 Aug 2026 04:50:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606a8edsm1211794666b.6.2026.08.24.04.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 04:50:52 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 11:50:49 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
X-Gerrit-Change-Number: 1610
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1610?usp=email>
X-Gerrit-Commit: 580974871f6664ce68e8f5e0034a27970063d7bf
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 11:50:49 +0000
In-Reply-To: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
References: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MmE0ZTgyZmY4NzZmYWI3MTVlMDUyZGUxOTAzYzY1YjgzNTM2MGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ca21d246896413d3e37f77390e3bd673d9d191bb-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyTCd-0007yO-Ku
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 unused functions
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1672750481754671150=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1672750481754671150==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AMzBFq2J7Q4="; charset=UTF-8

--AMzBFq2J7Q4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
zvanc has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail )

Change subject: Remove var=
ious unused functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 15: Code-Review+2


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
Gerrit-Chang=
e-Number: 1610
Gerrit-PatchSet: 15
Gerrit-Owner: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: stipa <lstipako=
v@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lst=
ipakov@gmail=2Ecom>
Gerrit-Comment-Date: Mon, 24 Aug 2026 11:50:49 +0000
Ge=
rrit-HasComments: No
Gerrit-Has-Labels: Yes

--AMzBFq2J7Q4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 1=
5:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail">cha=
nge 1610</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I82a4e82ff876fab715e052de1903c65b835360b5 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1610 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gm=
ail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Mon, 24 Aug 2026 11:50:49 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--AMzBFq2J7Q4=--


--===============1672750481754671150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1672750481754671150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1672750481754671150==--

