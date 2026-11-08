Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFD5606A320
	for <openvpn-devel@archiver.kernel.org>; Sun,  8 Nov 2026 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZdOh4FJ6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Bjmphyrh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NBzpJ92t;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gAYnUiVz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kugIwCIkNDFdRbE7ChBIWuW0f4fe4TEjxV9JAbdbmf0=; b=ZdOh4FJ62R++FpJD1sN4HVlXui
	b6ElkT7zEdmO4qOTSBtls6xd4bxG+lDEOJIRGujt89JYZVXBwCzf0PJNbi1KjcvH1krGO8kc6gFGX
	2LmFnxz25dKVgb84bIXDJQo50y+hJnCsiYIEpY9GWbox7ZEj9K70H5kUbCQM0jNFDLps=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQ5W3-000000004Qz-3rc8;
	Sun, 08 Nov 2026 16:13:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQ5Vx-000000004Qp-2JzE
 for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 16:13:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mv0bp7khfpe/rxMMEGyc68Pjahp97aGoTHEXuWoBZ1E=; b=BjmphyrhGNFW3wi4Flxb4IPELc
 ePF9qMY3/yJ4wPML6AadOXdOYXddC0qloQqot/XzZFiYi4HxyTEAmkdAo1XaRlzKzP2InHRT9JcQ7
 qKtOTEfvuZ3d9oM5A/oPERBq40GAoc0clMWK3rSfdg8PABnTFyCN09uErkGvDtEtohl0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mv0bp7khfpe/rxMMEGyc68Pjahp97aGoTHEXuWoBZ1E=; b=NBzpJ92tpDgNFFRqj+WEs6wEG0
 B7YNVXjwUjfgv85VsjnZeCM1fwx+xZMYTLsyAB+1zF2CQzxJGqZ4b625TnsUrO8RQ9AykiUEiSfOf
 UxYCN83GCPYoxgA8jiTGu+JFQ/+hIm4exJJOFBMEDHyToCSIIzgruV2bhfPU97Bd0FoY=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQ5Vw-000000004tn-2amT for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 16:13:05 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so1194875e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 08 Nov 2026 08:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794154378; x=1794759178; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Mv0bp7khfpe/rxMMEGyc68Pjahp97aGoTHEXuWoBZ1E=;
 b=gAYnUiVzbN1lZJk+mmN49NZgOGZJSue5BMhuwU4bkKN6IWXLUZWAdwwq8ec46SiWUy
 Utw0jdxqCIqe+Q73Xtvs/SBoY/pQ2ziUb4mxHxNLlRUzUQcv7FgSvK+0m6BNLR56f4yN
 XOhWd5cFjVsA5IpU7JAdcE7tBFBnea192yXfMaobPZ+eQRhqEpuoJgM2yYq1D0sJjZE1
 +ysFRelrrjYfrsu+LgwVtcWvXMbAbf/1VQ/LnJ6XRdsYeM2UZLwSERAr7sgl9Hfjrz4/
 8aAAyRcx3vnTBTOKiMBGOPAK3AwKtMh30DL/+wDaPPGdIQdids0bITelcmhDA1liUm6K
 AHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794154378; x=1794759178;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Mv0bp7khfpe/rxMMEGyc68Pjahp97aGoTHEXuWoBZ1E=;
 b=wRiSGdscBe4lJyWBh5IQ9QiTyhNM7FY7IOoCgrE/XJDPo5i2hgN0upG75heOLI8nK0
 lJgrT/R5EgRuzvM89KnVBeV+rs4Cl4oONZC+BmUwGGXh1GqVTlDEu4Kb3BvFSopBNB3u
 yQXbYyQ/2zmajQ6h85jddKK4zoKkjjmjUb/gqm62hdnCiNfTfaftdjkSxOM/n3mJHhE8
 LkxBnyq6quw7VAojyHEVRCJUFOs+5XhPM2pPOIAeCWLyGF1zD2EgdnoMkzYBY3FbWUqp
 WKIx+skK4bfAOuUVRWBiF5JrAywJZmcsmLmd5zffm6v+p4dtR85pfntgeSuRgO/FndnJ
 ukkQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEvXpzmCsrvosd4LPnX7Qjzco1DURMQP4TcdgK57VJgsCuZBD/Zt9YjqN+Krg5cnaxdR7tD131gnZPe9dln@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8bcrCSrTZCQ6UTyTV1AUWNqdMNT5VyDin4szLeLjH92Y9CKk5B
 e3tMzDe4LYi+tEGmNcYwb2xdhvUrU4Jvft23Ty7D40dyzYoz2HcU1mBE/CwCCpARNT0/YVeg3Ob
 Gi/Zrkn09L5XPBgmpb5BteDfx6H8esakneDtYepkNNRqApVr9I7L1ET01b69E/lHYhbat
X-Gm-Gg: AYBFou3C+eatQPkFEKBPOG7ujDM0Svaw5YquczJNx+zEfegxyI/V74+uaMjuohchwEE
 sI9KbUaRsVDJvtQocZf3dxuTMucSv4xsE5TaGHSQbXAuOv6yEkTS18hgo3mpQFXwglQtFj1oXWp
 iqAXNLaAl0MRheZo5XLQxfzuRw68tQy+YJcmud7AjbR88i5ggpYn8FxQWZ/dxMAP8v4f1lVAjkK
 NQneR1WjM1LlmCRvigS0G3aI30hSP4tEarwrWPWzJiwkvu3ob/+mRufIzIV0Jc5oP0sDSKByMmh
 xLqUYqrMJJYxEjWn4lJDtJRk469isgEmEHvlAV2KP1IQWsCBq026J/7kBomM44Rg3cMUEXwD4HG
 fP3w6ZTond2WJfte9+9pwMc0b46BlQSZO4hFZVg8urAZ+iNc32mHK7RZTGaJAIjKif1TcMavGTD
 FMhENvm4VCtvjymzm6OjF++abe8tgvb2JmWpYQghnSYbLGxaUY29t9Oz5a+KEht3g/PDTxwypWf
 oKbqWB7WW4lHHrM8JL2KN/684o0z+CwRr9zfKHb7r0pblDJb3dDcVoV7WMER7vYx68ELaf+re4H
 cGcXhCpZcRSS8X7UAUJ3ToIRFMkEwxgaM9xyt6vUlwll/c55BKhI/fQipZYhU8t6hnfW8axvbCP
 gvBLNI0pdjaDfthpg0uEYY9v6BqBCpjVkLa0bppGxKEIR2HgxlNxrWDyLJezgqaEIVIZKmVJAMy
 qUkul/I2SNwuU76Q==
X-Received: by 2002:a05:600c:4e87:b0:4a1:fe55:88ef with SMTP id
 5b1f17b1804b1-4b963c8dad3mr33153725e9.20.1794154377849; 
 Sun, 08 Nov 2026 08:12:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4959765218asm4829352f8f.42.2026.11.08.08.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 08:12:57 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 8 Nov 2026 16:12:56 +0000
To: opidopiopi@gmail.com
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
X-Gerrit-Change-Number: 2148
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2148?usp=email>
X-Gerrit-Commit: 2f0d22492f7753b0d6295f015471313e7f03e959
X-Gerrit-Comment-Date: Sun, 8 Nov 2026 16:12:56 +0000
In-Reply-To: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
References: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDU5NDM3MDAwLkkwOWU1NTA4NWNkZTZkYmMwMDQwZTExMWE0MjEyODUyN2Q1OTgzMmI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4091f57949d75896d10d55f055fe82a8697e69f4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQ5Vw-000000004tn-2amT
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement multiline
 responses for pkcs11-id commands
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 opidopiopi@gmail.com, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1977832719940434693=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1977832719940434693==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r8CYvPvkdxY="; charset=UTF-8

--r8CYvPvkdxY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, opid=
opiopi@gmail=2Ecom=2E

Gert Doering has posted comments on this change by o=
pidopiopi@gmail=2Ecom=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?=
usp=3Demail )

Change subject: Implement multiline responses for pkcs11-id =
commands
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 2:

(1 comment)

Patchset:

PS2: 
> I tried re-pushing this to trigg=
er the Buildbot runs, but got: [=E2=80=A6]
I have seen this "Missing tree" =
message on a different patch, which made no sense whatsoever (pushing a v2 =
from the very same tree, same parent commit)=2E  I'd just retry and if it d=
oes not work complain to @frank@lichtenheld=2Ecom tomorrow



-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527=
d59832b8
Gerrit-Change-Number: 2148
Gerrit-PatchSet: 2
Gerrit-Owner: opidop=
iopi@gmail=2Ecom
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-CC: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: opidopiopi@gmail=2Ecom
Gerrit-Attention: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Comment-Date: Sun, 08 Nov 2026 16:12:56 +0000
Gerr=
it-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Selva Nair <=
selva=2Enair@gmail=2Ecom>

--r8CYvPvkdxY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, opidopiopi@gmail=2Ec=
om=2E </p>
<p>Gert Doering has posted comments on this change by opidopiopi=
@gmail=2Ecom=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2148?usp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2148?tab=3Dcomments&amp;usp=3Demail">Patch Set=
 #2:</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">I tried re-pushing this to trigger the Buildbot ru=
ns, but got: [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">I have seen this &quot;Missing tr=
ee&quot; message on a different patch, which made no sense whatsoever (push=
ing a v2 from the very same tree, same parent commit)=2E  I&#39;d just retr=
y and if it does not work complain to @frank@lichtenheld=2Ecom tomorrow</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2148?usp=3Demail">change 2148</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I09e55085cde6dbc0040e111a4212=
8527d59832b8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2148=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: opidopiopi@gmail=2Ecom </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Selva Nair =
&lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: opidopiopi@gmail=2Ecom </div>
<div style=3D"display:none"> Gerrit=
-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun,=
 08 Nov 2026 16:12:56 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </di=
v>
<div style=3D"display:none"> Comment-In-Reply-To: Selva Nair &lt;selva=
=2Enair@gmail=2Ecom&gt; </div>

</body></html>
--r8CYvPvkdxY=--


--===============1977832719940434693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1977832719940434693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1977832719940434693==--

