Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8D1606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lP6DqQQv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MmvT2DJQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=feZGlBCv;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=N7KE91Vd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DYXWNlEUQcs6D72ylIvdfSplUNtj+yiizQ0QOr1ABq8=; b=lP6DqQQvEQJg4ZKWam+uvLzRZy
	He8bl93mFNtTEj4MPQ1vWpBehiqMbnKo0j8VyFS5nDTORvW/JL2t78mkveKmODsfJv1yypKebJ73G
	Sy1yzRePJ9VfaRpRsrby/v9el1l2SXx0WR2ob2QFccKLSQVGiRaq0eXSJOcNNnTObqY8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJZaM-0004jr-E7;
	Wed, 21 Oct 2026 16:54:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJZaK-0004jb-9F
 for openvpn-devel@lists.sourceforge.net;
 Wed, 21 Oct 2026 16:54:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bxyHBO/KPkRPqNLYw6UdmwWw2ZkKZZLuCqRTh1kOWHw=; b=MmvT2DJQAKHxjnoNo0Q07pp9Mn
 kZQ/bIT61ExpkOacq8CCg/k58L+Q4fKerLIsxo+E8/5rSQ0rtX03oyN4AXwb4i2AGnFgCA6qj92xH
 KRP/oPDQ4pLSy9PDjGCJW1z9FC0059ihiHlMTBGZTflF7hS8RAsQygCw04Kai/3MFLpo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bxyHBO/KPkRPqNLYw6UdmwWw2ZkKZZLuCqRTh1kOWHw=; b=feZGlBCvv5TLRw3kPZpniObZDF
 XKpVQY2vOAQ+hBtWjr2ZhXUCr0pILDh1dfzvi/e2RYtEWjMkh0aPbRgPLwJPyuSlfeHRWWzq4rYNu
 R7I6fnzoVltckHjGxRh18QMR6ZY9Zvoeisx8Pm1+NJXlkRT9CnoyiZ9sfNm++PHqA5i4=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJZaH-000000000wD-3CGO for openvpn-devel@lists.sourceforge.net;
 Wed, 21 Oct 2026 16:54:40 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so838441f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 21 Oct 2026 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792601671; x=1793206471; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bxyHBO/KPkRPqNLYw6UdmwWw2ZkKZZLuCqRTh1kOWHw=;
 b=N7KE91Vd+lqwrrERloKfPBq43zCGQ1ulkTMouncUgE7fvc1TQcP+HorSch0FRl1gFx
 JtXh9+5e8Y1OMDapQvynlL/NW0B2FnqpSkRrkffLTyAHgyItxxnC7p9tCBN7FxkHd0aS
 ANsc+3upGGdYl5tOWeFLf34xWoFRfyStVld/6cpN1GOWtQ78Gt5ziYTTTCH+h9Jm6T/f
 Cbb3ZzoRMMcNlJjRewWde+u28N8Ayw9VPeGfj5rY89uYVP6f32IhJWpWSEtINFsP+iah
 2UFtkNV2ecQ8y9nlBMNVfsI62i81PtbwZzueRpO8ccMeFMMhqgQGFKBRrO0n8EWq7fgA
 YtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792601671; x=1793206471;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bxyHBO/KPkRPqNLYw6UdmwWw2ZkKZZLuCqRTh1kOWHw=;
 b=Cny0tZnvO0kPcKAJ9U+KaoiB4hM0ATs36BH1ihx4/AaF/DCsZeRVByDtwOWVvhFOOx
 EzOhbYgivOpL5bwevhu46jbc8sQOy8K1klLYLK0ArjcktbqWPMz3lestQpzheDSmRIep
 SsqR0F4sdC+Y0a870Ie/o5hYSHh1O+CIZtGKv4fQK/PPP0DrL+QnpEXruPO9uoL5k9jh
 QLUUeQKw+6sWFmpOxSLcxu/4zhYPOlgPSzcwxNyXnQCCANsB3DQqbvM73hipTzZm6nD1
 wLMRceqQvvkDt4DXvGcJIKw5lP9JraBXkzMfe1uasqYBQbljVR02Y1ScGfroWqqFEWyG
 825Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByGkfa0gfXej5czFCQP8+wXTVxjf4/FqzKN5GlozPCMprjshn/hgej2rTIa1ZlM/l3iVPglJbxSqniWToO0@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIdPNe1oEG79UjQcSgUx5KKeKZx8f+TJY7DqGru3G5mbMtAmBL7
 7Wjcmu0Buwp4MkpqILkobZ9918M/wGrU7Fc1Nb8XU3+VP7L0W7gvpcHqrVVDVXe3xdc/0Qkx3KK
 JRVi3GknO7HCre07onv1kfzQ1XTE2lb4V5PjhBHhsM1mASmdarZD5wo+2Gmi1leeBZhx+
X-Gm-Gg: AYBFou3OJTY9xy9LoRo7MubB5BvJ/P8kfLLg4e6OIMbs9TQT8OWs5FEIlF63MwpxbdN
 5CMlaO/VB5z6VV5g0KNgMc7fxAAsJZ48ip3oTM82iACfdOdfZ+jYl9Oss4AaQnLQdgjxDE35AnA
 e08zCJTERTQmUaVyLge2Nd0sHqBGCS4QBg4Jam04ZNuvMQym+2x70Um7KBi8HMS/0W1SBfCVMnk
 GrX7JzVdIjgxe02xIr4xW0uiV2MJqBo5u708IU1A26WeG9IRLGf1a6i6l91MRMNtk0PUNcglXOI
 BLQRpcTkN6ewkXNqL0SAvbvKmcSTryYyNrmy1Y7WPTe+NusT78lO+HJwq500x2GDR43ciiK9FQF
 ybJ6rgYahc0I0KhJ/ewNKNwheGJsxE5drdKMSGH2hqp3H1IMyYzR8Ka6ylLG8twPybRC5vpn4DY
 WNaRTToDjL5IimQEu5gJ9BXXy3AFD6nWoM77SzsjoCDnFFf2Uqah6WLGwenxncnPYJlPAWlTBVU
 aOCC5Osj2VjW4K784K/wnn55MuaZeOhlkoqJ1TOKjDoo3DA3TPhmb7osy7MSMCZV81DgCjITotB
 RociQM+87JzCRZNyvBaM2j8bBmy5uyfg32x/pKJInanDmxkT3w/lkHI+hqEPADrqWilMf1sok5a
 J1J0W4Bv8bWsWI/feZSmyEvnzw0e2e3tIyluHeAqDYg==
X-Received: by 2002:a05:6000:4549:b0:487:21be:dcc6 with SMTP id
 ffacd0b85a97d-48e264b2a0amr3834339f8f.21.1792601670616; 
 Wed, 21 Oct 2026 09:54:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254ef1casm5173658f8f.7.2026.10.21.09.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:54:30 -0700 (PDT)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 21 Oct 2026 16:54:28 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I26fe14053446dbd215f947910565c20318c34627
X-Gerrit-Change-Number: 2027
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2027?usp=email>
X-Gerrit-Commit: e8e290fbb50ddd364bf6b40873bad982ca12dae7
X-Gerrit-Comment-Date: Wed, 21 Oct 2026 16:54:28 +0000
In-Reply-To: <gerrit.1792566915000.I26fe14053446dbd215f947910565c20318c34627@gerrit.openvpn.net>
References: <gerrit.1792566915000.I26fe14053446dbd215f947910565c20318c34627@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNTY2OTE1MDAwLkkyNmZlMTQwNTM0NDZkYmQyMTVmOTQ3OTEwNTY1YzIwMzE4YzM0NjI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bcbc87466059bdf8e907dfe1bf48955145800fa2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJZaH-000000000wD-3CGO
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: interactive:
 null-terminate iface.name in address and route handlers
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5476818161567229016=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5476818161567229016==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yGxCqCSeRNA="; charset=UTF-8

--yGxCqCSeRNA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Lev Stipakov=2E

Heiko =
Hund has posted comments on this change by Lev Stipakov=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2027?usp=3Demail )

Change subject: interactiv=
e: null-terminate iface=2Ename in address and route handlers
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2027?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I26fe14053446db=
d215f947910565c20318c34627
Gerrit-Change-Number: 2027
Gerrit-PatchSet: 1
Ge=
rrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko Hund <heiko@openvpn=
=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 21 Oct 20=
26 16:54:28 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--yGxCqCSeRNA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Lev Stipakov=2E </p>
<p>Heiko Hund has =
posted comments on this change by Lev Stipakov=2E</p><p>Patch set 1:<span s=
tyle=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: =
4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2027?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2027?usp=3Demail">change 202=
7</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2027?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2=
6fe14053446dbd215f947910565c20318c34627 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2027 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;=
lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 21 Oct 2026=
 16:54:28 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body><=
/html>
--yGxCqCSeRNA=--


--===============5476818161567229016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5476818161567229016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5476818161567229016==--

