Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0209FCDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y+11qAPEzsAvbtwgKijVHx7og/Gt/oeiaOWFQDU0lsI=; b=l0/GJ2cn3Vv2I9dgf/1eUBT3hT
	wZDEiKbopFNSNwdpn7Ebv+h+3CCJZrHLxMAuPo3JHbpzIOUpAc02BsnPfGbvxdly58znOoLJBh97l
	x+Wls0wivU8fXgx/+E/NrakWOvqcvdxGxFfL5cVtqglygUhd5m4J71NLylNUncpq7rHY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbgWr-0002ON-GS;
	Mon, 22 Jun 2026 15:25:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbgWp-0002O8-HA
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:25:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EMRXWebWpyfMSeedDXb0RxtYwqAMreFXi0ZE92qtBu4=; b=h4s5XceebHe1tcHCu5d8w8UZFC
 2d96+ZpD9u5l8XG0rRLGAdcrBZzln3UqVYhOY+42yws722aPziTHonj8HW5RHbt15hkPzpUDifSfb
 2pst662mzDJSrRnRl7ERDOuYnCBnxoDUVVGOm0oa7sEoVOGmVAiysv7LZpgazgVHKtzY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EMRXWebWpyfMSeedDXb0RxtYwqAMreFXi0ZE92qtBu4=; b=X
 l3YGa5zYTD/+Y3tPGq6anCqLArQIcKM1tUmuzn42yX8tjmVqcShsSYll5LbCwXBVKYMEptL7TWrSX
 OWjYVPlrycZlo1ZHygBUZxURuJlJ+EhZoLKUMvySEN9QbNSxFLUJgViSLi8swLVB+KrZGwE8o7iMP
 rM1IMqTSr7z0c4Z4=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgWn-0007XX-7S for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:25:40 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-460662fcb4eso3057568f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782141926; x=1782746726; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EMRXWebWpyfMSeedDXb0RxtYwqAMreFXi0ZE92qtBu4=;
 b=MibL0zdcoAX9+sm9cl64KZcRiT6HE+dI09v5Vm5hhez6I9wqY+LerotkEXoE3GAqzN
 Xg1XtRkEVLo0WxPkinZyU+lM2nn7kPlMGU7/8pnjJr7naP+lwYiMHUUZMhNOTYjmnbNW
 d+bGTBSbZ1eHacYHqPpwOEBtIPzLjPFhVGW404Ow6+xsFMom5m6KbKI7PyjhCiFz8HQj
 N6HN7Gg25FgwEEl+yvacfqLzivu89YEovbuZBVoRCGElSjnXPm+C64HHU7dgPo+tkmmQ
 Vmg0QoS1v5iMCk+JGGiPQgdnAH958DzwW+6gT4wzVBI2pko9SZD7stmk77T74wQBXL+c
 aX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782141926; x=1782746726;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EMRXWebWpyfMSeedDXb0RxtYwqAMreFXi0ZE92qtBu4=;
 b=fivMW2hc6zgf1ne/sc9LnLQzkK6xVMcRFonMG7gCKv3oNNB1HKrJfyyUzczFEXQlQj
 cJOakrNy9gvef295z+lBM0K9Yb1AGAeVrpDstEqPqO2qJv3nJryDgKOw6xxASZuXV9qf
 zDynBfxAA2ujymiX6WsDZsBZ6hgmj2+HnxId9bLmEqNMeOTUDmJROsf8a4JFvT/ctXEM
 9sRhLLG/iy7vquBG10DWzqYSnp5Kxyz8AaaKUlPkivHjBns5lY3kF+6fgbHw+8rPzk26
 nfJQGNhQCE76irsFxHKyKjxUM8J+a32ftIraXDEBYjb6IofHT++pDSHtMwsZZeN0/baN
 HhIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFnyMiVo26ZsO62I32aZENOSlaJGSLn/PYJzeU+lyEEmfe9SnRwuWcGVgYEuIkUWqRlrmH9vhGVyLewFyd@lists.sourceforge.net
X-Gm-Message-State: AOJu0Ywkeb9nM2+II+1lV4wz5iWZNomhaYGPKjckN/G7TKYXK6o3RalQ
 UGXEiIBi8e1FZVH9XGX6oAFIUBVOb5RhYLzu9k2hSzehTsQiU61SwKLaksqIVkKzULZ0+c/JNYE
 j1UuElV9Yl1HdveN1GuIPn2EY5zjR30u8gUha/CfRroDnSgdID7YChoA9PFwxTVrFAyE8MSn368
 g8O1F2Jw==
X-Gm-Gg: AfdE7cn1YgK3+0pqcUFnIHypMYBHb+ciQowTP0qZBBpQPIMAH7S4fCbtVJV3o4Epdkd
 xKFPStxCczywzy93vRbOgFSEBKQ7JyBiYAOMoCyxKWpNco1QxbcZ7ERjHOmeJiE7Xi+cWO2qx/K
 5iZTZ5LUaV3OCHS6Czt1zw8+pqawKpfObCSe9F3UUZFbUyOlNFnTSnvDoNJMJYdzhGkDiTa9oM7
 fT5gdDE+Y7E9Xc66yYJHRxknabmshZn+yKHZf8OID5n2DRSfo7e/KgrffEl6Xgk2alK+J+86KBO
 FnlSrey7N+hAknhCT/284YegY5oZPEbYwZLJuP62evEH9Sb4i8dNnkbEs3i+vQPzdCHQUq8Szsm
 BOODFLsKBFkgV7s24l4bQwOQQK81+m4z1oNLe4bzSk5rJQe6mq7t2bOe/VsTCEj7kguPcGkT47K
 iDrw+oUyQiWT51GB7qZ1EIkMrkJWgeoWtt3uJicDfxtWzhXMnENbVSQBJQOha0cU9KFNHHg71+9
 Y7YFRVQ9TaDsErAyFOuBZWvhT95k8iEjQrk2OCadqKZzP4h8iS8oZg1IIcccfaP9RobcpdEa1Gw
 6PEJqT+wcTfDGw==
X-Received: by 2002:a05:6000:1281:b0:461:e355:a969 with SMTP id
 ffacd0b85a97d-465078b3ff7mr17644560f8f.13.1782141924919; 
 Mon, 22 Jun 2026 08:25:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4d9csm26698632f8f.4.2026.06.22.08.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:25:24 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:25:23 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
X-Gerrit-Change-Number: 1725
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1725?usp=email>
X-Gerrit-Commit: 3781532897d6feea9b358f5d080706164878e175
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 15:25:23 +0000
In-Reply-To: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
References: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzN2FkZTU1ZDc2NzRjNjhkZDk4Y2Y0ZGZkZTM1YzRhZDQyZTIwZDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e1a44498cc925e2b58ff9e160a4cca2e12843e71-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbgWn-0007XX-7S
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Extract
 multi_get_instance_real_udp_real method
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
Content-Type: multipart/mixed; boundary="===============2439903000524652514=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2439903000524652514==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tkb/cYMeDW4="; charset=UTF-8

--tkb/cYMeDW4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1725?usp=3Demail )

Change subject: Extract multi_get_instance_re=
al_udp_real method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/multi=2Ec:

http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1725/comment/be4c9e04_182fecb3?usp=3Demail =
:
PS1, Line 3111:     struct gc_arena gc =3D gc_new();
> this fix belongs i=
nto #1723
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1725?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: c=
omment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I37a=
de55d7674c68dd98cf4dfde35c4ad42e20d39
Gerrit-Change-Number: 1725
Gerrit-Pat=
chSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Review=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 22 Jun 2026 15:25:23 +0000
Gerri=
t-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld =
<frank@lichtenheld=2Ecom>

--tkb/cYMeDW4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1725?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725/c=
omment/be4c9e04_182fecb3?usp=3Demail">Patch Set #1, Line 3111:</a> <code st=
yle=3D"font-family:monospace,monospace">    struct gc_arena gc =3D gc_new()=
;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">this fix belongs into #1723</blockquote></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</=
p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1725?usp=3Demail">change 1725</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c=
4ad42e20d39 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1725 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D=
"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 22 Jun=
 2026 15:25:23 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div=
 style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>

</body></html>
--tkb/cYMeDW4=--


--===============2439903000524652514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2439903000524652514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2439903000524652514==--

