Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157A8C5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y2Sky8fL5jXLREIexrezAVKU0A6QneT/Cg6iUDo0xpg=; b=megxmh2owy5DYeLtRKbd6edMna
	lO0JdXm3iSM235vZBTx6wflFLesdBFHuJV5qybDny4xAEbM9ddkvhw6MMuBuypCJ/E2NeaZe2IoEk
	KGVkDj6ITWtl2k7XoxXAi00BkRSwgt3Eej3HOoxeXBIL3KsX+FJh+t4pPSILammYzKJE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzGTQ-0003RH-Jn;
	Wed, 26 Aug 2026 16:27:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzGTM-0003R9-SY
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:27:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vgALU5PADVMFRUH6d+qOJF/5pfK3fEV7ZFtYEs7qr6w=; b=I+ayLoXAwV6WMcYMJ3U31IIpwE
 UbJiHIULrOSFAD3cmyDsF/FEpkMHwHb2uofKd56v2KupG7E4XAovYW2F2UiBC0evinBKEy2KUn68J
 8axLKt5YgmcLOAAak9/7HR6cDQdRuZfuwkoIH8NEEjiJnIkKpqRamfsebHXq+F3wx9Zc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vgALU5PADVMFRUH6d+qOJF/5pfK3fEV7ZFtYEs7qr6w=; b=J
 kpNNL0O5+STYYM342tx1Zv2ZLrIujEZcs3avqT76fhcwCUoY0LxEgkJUDsPYsC7dmSIuduvM9iUcS
 ClNHEeURKJtFND8kqykBTX2wjVJYVRKO0cPKxW8YS2SUYZBPKHJuRzeHs/RE6OdozvvdSPJ/Y0cn7
 Pqbcr1nWCr26PpSI=;
Received: from mail-ej1-f46.google.com ([209.85.218.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzGTG-0001ba-Fl for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:27:30 +0000
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c250c6a6a9aso165109166b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 09:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787761640; x=1788366440; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vgALU5PADVMFRUH6d+qOJF/5pfK3fEV7ZFtYEs7qr6w=;
 b=guHAMUrHLjqMvI4lot5HRdRT+g5DRX4GhzAMV0LDEn9GaKKFvL3sAV5H3lFRU4ef0O
 dVKhvvbxk4dZpxgafWAGwGEFLGJxlqzHUJBapHUQ+1IQeZl20U+cNOKHm++csT5KphyP
 Em5aqQ0LyTJjT3xViw0ukbaynzG1Y1wwh3QKNXhkpJQV7a7Yjsxw8URyQYtzIFweav4D
 +c/STVZ7KgjEkHvLnBcsuh+wa6KqbA/+IPFOnIs9eiI1y+83KdjoKLqCNUckLYWK2Q6M
 Swo+58vnwSRvc/buRyKZstPq4mBXmkLD6XW/YhnyJJVxBbulexombLpum9nvxpo3Q2uu
 PZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787761640; x=1788366440;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vgALU5PADVMFRUH6d+qOJF/5pfK3fEV7ZFtYEs7qr6w=;
 b=Rwm29IBgM99/lA429muf3nPdScmdYN83VvLC0Tcrskkk3mzfcU0UyQjUtFawxLzUlo
 XNuY4pMlwHw4LsyB4GbCxyNrhqDJM3jwEXKrxandIL5CkwmmwzlmyJ3COY+cef4Vj0SY
 XbLUJkC50W8F8NJibA0/Kkr7t2jkrmddLeWzgWb1pYeCRNumb1M7lJwZOtsChYRIxWjh
 bJXdjMLiGEAB8o2DS8LVmKcMA7RV0UMweb3ccysWL7zBEjzpcVFj8jE5gXb4rm36nPlZ
 3O6poxQooNwUaP6ORWWOnfhOPSGIzzIUd5lRNR7eRndQCeuUXLLIEBiGdjnJH0b3rfnP
 t1Tw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rps6bAN1V1ROE037aqT3jSf+8JHhFmoOKqFkkesvrCJo8Z1StZ+gRbozys/wDmutd8RM8/DxGmq4D1KWANK@lists.sourceforge.net
X-Gm-Message-State: AFuF++lTUQxrNsgdMgD3j2ftDj6q5hQhJT52qYIqDfkOjZyn2ba286CJ
 l2hpoEXb3crdLEXFyOlxfk4gOif8iaa4nI3e06FptdXnY+KO6f7RiqOdVoDCviCzm/orR5ZzSHO
 LRiZxm9bmGZLXAbIt0yk8DF5xQZhONrb43NNMoEei7BD+PuWZ4tSl+QlnefRtgdevJtfUC54gGn
 YUe37Shg==
X-Gm-Gg: AR+sD11SqHLFb3dHwtugPP0ah3ixzIuRUtC74FddUwEfn5rzTv734dxWP5xq9fbKzIN
 oItml8rNllNn4ilnSvmseSFNq8H/QHaSmMYxhyAYJfu/lWtNTbTy0R7yOoiQRrLHpZ0RConb5z1
 yIeYvnUCYRbF0n917GrVDOH3KoPij5qZazTSyhdc34gaW+qjyZC+wAE+dvQl7ZlR81tamba9Y+o
 Bla0OXOUfyHJu+N04XTV9tWMKJdwzEvzTdELvCbiPHN58pU4mpFhF+ZSX6gDx3fXfObgvnTXv5e
 B+qHfAcU+rZFPb3EgbsMnuTdwr1yK+Amk30rBeHSy6kC8N2QXnFsPjT/7rK7Fi7aAIKDT5en/RR
 X6myofFHqH+Uy2PlnBKOaAIIjNHDoWpFQg+NG58kfEbsuDycO5SuYfqvUq7kna9iNE+TPDsubnM
 8MymVzNDKb8GLgKx5IDeh3Hr++7JiXvstS4SasoDoGpLYsyBGRlGlwNcZx5jLSS/lThXHTyyLY3
 5Q/XreLnxrET4vdt1Byil6cJSobn8UARgzwWpyJ0X3hjukST9UOLuZhlrM+4hl8nbBVRytGA9jk
 hRFbpxUkx4DmPMV0eFT21ujNWMZPrE8kua0zcwidJjB56b4jU58=
X-Received: by 2002:a17:907:1b0e:b0:c1c:6f0d:5b22 with SMTP id
 a640c23a62f3a-c250bbd3f1bmr1122965566b.11.1787761639725; 
 Wed, 26 Aug 2026 09:27:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b43absm567474466b.51.2026.08.26.09.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:27:19 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 16:27:18 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
X-Gerrit-Change-Number: 1856
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1856?usp=email>
X-Gerrit-Commit: 1e7ef53850e82f41b9691003c30f1f125e2a60fb
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 16:27:18 +0000
In-Reply-To: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
References: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MmQ4Nzg1OTU5YzI0YmY2ODgxOTA5NjVlNThiOWI5ODI1MWI4NTU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <636878743d62f7ad796963d1ced70f23657582f7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzGTG-0001ba-Fl
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Introduce
 get_key_by_management_key_id helper function
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6742177485961609033=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6742177485961609033==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="igC11Q1O+R0="; charset=UTF-8

--igC11Q1O+R0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1856?usp=3Demail )

Change subject: Introduce get_key_by_manageme=
nt_key_id helper function
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 6:

(1 comment)

File src/openvpn/ssl_common=2Eh:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856/comment/4ac41449_d0f050da?u=
sp=3Demail :
PS6, Line 764:  * Gets the \c key_state  object that belong to=
 the management key id or
> "belongs"
Done



-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
Gerrit-Ch=
ange-Number: 1856
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 26 A=
ug 2026 16:27:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Commen=
t-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--igC11Q1O+R0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1856?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/ssl_common=2Eh:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
856/comment/4ac41449_d0f050da?usp=3Demail">Patch Set #6, Line 764:</a> <cod=
e style=3D"font-family:monospace,monospace"> * Gets the \c key_state  objec=
t that belong to the management key id or</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;belon=
gs&quot;</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail">change =
1856</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
42d8785959c24bf688190965e58b9b98251b8557 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1856 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Wed, 26 Aug 2026 16:27:18 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--igC11Q1O+R0=--


--===============6742177485961609033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6742177485961609033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6742177485961609033==--

