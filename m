Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED56BC4451C
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fK1ZQBGAmIVGfTBcjBNf4MJy6h70AzHcN2EU1V/Nhvo=; b=lxHk73DLmNOx/IJd33GYl9McLo
	IYXNci94AFCPW48+wGK5CYX9drKVxeaA10ICqGOi0LVvwkvvEDn+xoVi+k3Q9lbkkzLYiHbhgGPFq
	36tbX0HIjHUalEMlK/Bd9CueOyPlJKJgiI1tH/CeftmtOrj0qyO4R2a3IQWE7xiwD0vU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wm9iZ-0005y3-Fu;
	Tue, 21 Jul 2026 12:37:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wm9iY-0005xV-36
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 12:37:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZWk1ZBCvkky/IW7DZVpUYtOLaSFCmimj++rtg0QAn2Q=; b=X5F3BIgnF0sZAjYoIj8Y2zpF/P
 7YgNkR/oCzV3sJDu2xsI8qxr7bSCE6UTTZx5LPizN5UBUxHxxso2piuaSeUgxrcIPZ48lyteNT6UG
 TY3Eu38lTu9Ki9r6IUdYTBldwIHamcn/apnBgOn+dYQNIq0BU/5duAKckycgCblI40Pw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZWk1ZBCvkky/IW7DZVpUYtOLaSFCmimj++rtg0QAn2Q=; b=g
 YuQv7/6+0XEIwuzAw9k803qjVTUXJui6C6iz5O8A+GQlsyV2EUy0GzZHUNPv0MCejw6jboVDIyS2N
 b7UHbVeKf0qheNJnGQkdNAT8UVZ2GzTF+Uy5GOB8HEhbhzeHAA/H8FX5nWlKGhLfmPiidTq+qeGHz
 v7n46hZhtsO9jYyU=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wm9iT-0001o1-Qj for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 12:36:59 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso29083105e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 05:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784637406; x=1785242206; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZWk1ZBCvkky/IW7DZVpUYtOLaSFCmimj++rtg0QAn2Q=;
 b=CsIty+TmPZmczr93I+zpAZzGDss28QgU8LEM5+BJUzONrhiqE7rlKa8dSaw+kDdf6T
 c7gKYXG8oG7dQtS8NX2agxp62WsxbgSA1LxSiBiudtbAJWvsrLtVeBNouuADvM5w30sq
 9s3VoohZjC9RmW0Oq/QuoFBIzChNZHY7k4wv9Ts57ej65Jm/UnrgWOBNcy+7mnzQt1OY
 FrREmXDHz47WlEuZWLOXVQuJo7V6VQWuiZIEysCn8r7kLOEFpFlS6snnGkeC6CD4sCzB
 BKve58m81Ul1q+zb5ZKr+ER8IIL5bObg+Vg/6iEN1j+7bA2upoO73AAYynlH01Wv9ytA
 TfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784637406; x=1785242206;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZWk1ZBCvkky/IW7DZVpUYtOLaSFCmimj++rtg0QAn2Q=;
 b=pLyYN5QJmjpnawslj8aXgw6iAKcnp9A4mf8OJ89WKPjrhvAxeUapeoiWiC6U3RB9BY
 nPv8MBE2MEC0svGT5zpMFQsGnCavVyOhjxSp1ne/j7ZkiB+Yn74X+ZA5gFXa4RHSToFe
 x1G8Is7/ljY2hzskBJbKXFiwiCa7LJZnJXO9NmasA2JZCcmZFF7J4jVZt64W8Zabhcso
 C0v5oJp22WXpTw9hLS3j5BrAju+O7o0SWKvBVlCsBjFd2hyH6m5JGjkPaGsyvXcHhx3Z
 cHnEASATY/9TcvyBghJUjienERZhyDGMQ6wsHtLttroHtLNaMy6LAf7ujHpSbKxCBdV2
 qh6w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq58UP07XM4ExmzvU0lBLHfSra9fJNJN61xAViCOiX92D4RfNbzHate3KNrU1XF6bhr4+IL/ACtie3e8uXt@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwS7juaVDR7VB5rpBWfgTYp/qK/X/dvZjcAPmze8wclZNkHjedm
 Uy3MMxL75yjkIHF8QvIXzFSt4fTAxYre666fvyKTqHq5NtZ0rdPM/Dacd8KgQwp6IzeXaqXipN9
 b48a/mZwu2IOq4SLhj1Ht6kUKrYibdB3TaJNPsQ40MkUAdBTZd2bytE7AjpKYGtzuM0lH
X-Gm-Gg: AfdE7cnhE7IxDd12SScD7xgBgP4cLfSemHQNmre4Bun+J+VuWs9YtulLum8D+SOQY+G
 MiC1MHSq40kOILO3dhpKje5KCEXDuUJHkZI3keuQ8QcXYNGhj3P4/B9RTtAxgNguZHQHDfM978f
 w6zHo3Mk3GKR7qoiB0YMeVLd+ty1p/kxSmGKnIYsrZUSZtJu5uSQG9OD3WQBcijupFUUETKaJeS
 k/aji599NUW2NneTu/ChfzYCiX+hQTs3tmWxNrId4vMgJ1S6m+wcK5NePt7es96y0ZEsUZ41mKI
 T0+cJRYo+JNWNkjV2rSjFXlt8a77c6LzDFE/zFwWb7enBhpL4D2LeyM63kl/xHgzKmirOFQltuK
 aQzBuQtiiXG2dmwKCwj9lXhyqeWJXD4lRZwMI5RpmNXP31F8eVsGhriAbQPaAb8zqTnnw7pYfRq
 a5JUA7zKJ6hZhseaPrmKVOhXLoTPxX1mexo4F2tpahTb+V+ndB5oECIod3ru+FKwYyJTOpc4k4G
 ewJqo0CVgUBCvBXaY6g41gWvsllKIbI0WU/mwzFQ80wtYwR+AOCvhdrXYAIllpsX2vE
X-Received: by 2002:a05:600c:1d15:b0:495:3f26:4f30 with SMTP id
 5b1f17b1804b1-4954a3e6e08mr207980995e9.6.1784637405992; 
 Tue, 21 Jul 2026 05:36:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec7c69sm41198297f8f.17.2026.07.21.05.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 05:36:45 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 12:36:43 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: 2e79a47e4bad09cf3952c4df0be13742908f2437
X-Gerrit-Comment-Date: Tue, 21 Jul 2026 12:36:43 +0000
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <37d9c614c8b19ced6eec5f57befae065c5308e44-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wm9iT-0001o1-Qj
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 SERVER_PROBE parsing and the probe-reply decision
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2528799371765773770=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2528799371765773770==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cQAlrcyIE10="; charset=UTF-8

--cQAlrcyIE10=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

stipa has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1742?usp=3Demail )

Change subject: oob: Add SERVER_PROBE pars=
ing and the probe-reply decision
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 8:

(2 comments)

File src/openvpn/oob=2Ec:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742/comment/2e88f7a7_bfed1fb6?u=
sp=3Demail :
PS7, Line 187:     while (BLEN(payload) >=3D 4)
> Instead of h=
ardcoding that 4 why not do `while(oob_tlv_read_header(=2E=2E=2E [=E2=80=A6=
]
Fixed=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742/comment/74431fc=
d_2182b6c0?usp=3Demail :
PS7, Line 232:     memset(reply, 0, sizeof(*reply)=
);
> Should probably use CLEAR() macro
Fixed=2E



-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
Gerr=
it-Change-Number: 1742
Gerrit-PatchSet: 8
Gerrit-Owner: stipa <lstipakov@gm=
ail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Comment-Date: Tue, 21 Jul 2026 12:36:43 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@lichte=
nheld=2Ecom>

--cQAlrcyIE10=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/oob=2Ec:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1742/comment/2e88f7a7_bfed1fb6?usp=3Demail">Patch Set #7, Line 187:</a>=
 <code style=3D"font-family:monospace,monospace">    while (BLEN(payload) &=
gt;=3D 4)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">Instead of hardcoding that 4 why not do `wh=
ile(oob_tlv_read_header(=2E=2E=2E [=E2=80=A6]</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Fixed=2E</p>=
</li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742/comment/=
74431fcd_2182b6c0?usp=3Demail">Patch Set #7, Line 232:</a> <code style=3D"f=
ont-family:monospace,monospace">    memset(reply, 0, sizeof(*reply));</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">Should probably use CLEAR() macro</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Fixed=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1742?usp=3Demail">change 1742</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de=
810a8c2f68c30 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 174=
2 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=
=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Comment-Date: Tue, 21 Jul 2026 12:36:43 +0000 </div>
<div st=
yle=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In=
-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></ht=
ml>
--cQAlrcyIE10=--


--===============2528799371765773770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2528799371765773770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2528799371765773770==--

