Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F192606A33F
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IZLHJdvF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WU4eshQb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kxdZLV4R;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UFXIQYj5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SphqiQ8abJd1O7rLiMmgby8hzyWl2DPN2dXnXRDE7WY=; b=IZLHJdvFWOf0xrI1xWFnf4BIKr
	GGAmXLC4jal1KSl6k6wtFl9h/soXBlhQgoIt2MlcemKan387y9pjm/oo4FUwBGWm0VlXWdazReMr+
	wQNVxuyBdMdj4X4nTqrdEBboNx2be3Z44pMvkL25hkyMgiJaxuJCYmoUZDEYe108zNKw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQOD3-000000003tf-0bPz;
	Mon, 09 Nov 2026 12:10:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQOD2-000000003tY-0Y8D
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:10:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=50i65YqaBO2GQX6ymLf4Y1MU1ktSRnFC+Qr0djsW6lw=; b=WU4eshQbwslTnJgPGjv9kdYZmP
 /wVNRrZZ6rI9DXEtkfgfoQwQcc4y/yp8yFlJvX9GGsTWP4paBDTGdEztUci89e5bjrJ75WXnc8qOw
 aWN5deq5tsW/I90e24ebP8Rm/KW3TTAk1evK3BDdJGmBCkr3LdIChxN1gSD+pTdoG+LE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=50i65YqaBO2GQX6ymLf4Y1MU1ktSRnFC+Qr0djsW6lw=; b=kxdZLV4RDYOPiAjPdIvKXW8EaR
 XFV0GADfkalSUA+FymXgPsRaipkRpllHxLspIKBFIxAOgSFUgMmfHUXN4iGWCAiH2O90VntOvgGRS
 lnptAZtYntNZmnHPfJUNLVCPBceojjk/wKSP/d6hCUi+aE8VYreSxoPmNOg6Tv3QavfY=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQOD0-000000004Q8-31IZ for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:10:48 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-49318428d98so409031f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 04:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794226240; x=1794831040; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=50i65YqaBO2GQX6ymLf4Y1MU1ktSRnFC+Qr0djsW6lw=;
 b=UFXIQYj5BxO4xCCn9J79L3SJjIDlGF96uLh85pw4cyNO8XvgV8M8V5zBehBRqjt1rv
 jJvYDW5SqDX0ESpuJeVPCgiKgIt9VfCRAj+4mJl3Hv3M03Mmb4hBc2l1K7DkA+qzQUTu
 aCdUCdI5qMoEQzVycRjQP/PJUlQCB+cfeCmjwleDeNsDsE9CQQoj/bpA41YNqt6ompEY
 1IOJfXteCJSRDfieMHzdVeDKe6Pzjn2vAR09R52GNiy9gel+3SdvtRNg33468YdkigWU
 4p+TsowCrm0ZATO0SnoM1pJEC1vm9nlSfuXxrewd4kGZ5v7Hfb6XwqOgOH3wIR8Whkd3
 WZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794226240; x=1794831040;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=50i65YqaBO2GQX6ymLf4Y1MU1ktSRnFC+Qr0djsW6lw=;
 b=MIvSamsLzm0CkoI99vY+jfpXE86Otqhgiz/5KK0Vt9OmNKATEds2OzgFGUa0aTXT/g
 wv1mVWKgTC0dNagziTlg9Vp0B6Dx731onugX4CVfpMo0T1Gp8Bjs4cf5oM0LaI+0xURm
 hQXuFfryNx3SCwLXBmKIqBPmaKSvR2V7v4EpZ8Bfs7uboERY6AEXpTvigjcg1yMyDaH/
 OLZL4Pho5EEtv61aPSVXgYHy0cgV5Tb3nbElZMkTLN4nyOK2uV/xWCTDQ5gT+Ot1NdjL
 qxqMfqW0Per1asH/d6DRStk1eoY1hhoKEBnEqK36YrFSPlsy4j+vvkpER4cEUYmUEwPN
 TXhA==
X-Forwarded-Encrypted: i=1;
 AL+hErFpNV+OL8ygdnckH42mcWGl5acmI+I7K1zUeYDi6x/autapJvjl6XQLqBv66XpcUC6lAq74FJ4WQX7XdCur@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/u4h9DXKVFKVeYA2LboF4TynAjGm3h83oSQP9spv8nsB1203BQ
 Su+06ILxBU+diFOgFjjtMhC2JuNBv+UQZ1RGomriJVGbkuPmYRo1gf82zpWxkeb+5OLubaOOUxI
 MaIilK0sUuy+wnsCqGPluKjw4sbs573I8FYyj2kajwjg8JPuhvf/Gk8/pAWDq0mIdhGiROqpMb/
 3nokD18w==
X-Gm-Gg: AYBFou3E0jTOEqeJ0rPM7hUdAKqT5c4nhu6Cx7/9lRMi//w076ErrVruLehKfzn/kkm
 wuy7nLy97iD8rMCHg5YU+dq96FMgTs+vPUQOh68Y0PY73741h+DigRcfv/5G9X0rjNbTlvUG39q
 RGUI72H9TTw3hfPPcJruzBzgvTKHfTWf0B1TUDDddwcRmUMYBbjYOsY0pJka8uO+na2QbkuucDY
 j5a9QOnlpcUVDUms2abquIuHwfsBy+z4H0tyNhQSrgBxCXgDdYvToIR/fUMCwR54rA7w8Dce6Uc
 iYdudaQqRDJOaCnFix1CAkcObZQYOG48IG86YzMCWTmVPlCwy+9aAIZ2YS9Z6RdI++5i3+uR4cH
 u5KHtrcbptHBFrmXt7qJgmP1IO4ytW/iOLwVhNaoT1xnMjSS2gQOpgZzCCyzNX1lKjpd4a/aSh+
 DxTYqGbPRJFgzJa0dqFoyRRWl8UgocnkAch2r6ee5WYorYgYucamTSeE+e31G4kYm43eVFcsGML
 DqvIiSFRwHz8zmHtGiA9lcpsE6vTBCJj0oQdDPuHDtnchRzX/s0xNdruVt8o0MfR3ShermffiPK
 Sf3O4jcJUoD6IaZYcpcwik8WrGeAUaxFuZ+yIv54pZ/kovBDmTp7yDSkHsHRyeipdY+I+EyflVv
 LJBab7fADOREWJZdfXd4DVJbYW6aaliR3P9brXssSYlt//n0G9mkUTKOKFieMM+vdhNHmxxL/a2
 wJeFNjd2E7jx+2/g==
X-Received: by 2002:a05:6000:2310:b0:48b:69d4:bb35 with SMTP id
 ffacd0b85a97d-49588623a45mr6969411f8f.12.1794226240011; 
 Mon, 09 Nov 2026 04:10:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-497be726d9fsm910294f8f.49.2026.11.09.04.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 04:10:39 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 12:10:39 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b
X-Gerrit-Change-Number: 2094
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2094?usp=email>
X-Gerrit-Commit: 15b1cd44d3275e178091d809b58cf4fa3369eab7
In-Reply-To: <gerrit.1793637321000.Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b@gerrit.openvpn.net>
References: <gerrit.1793637321000.Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjM3MzIxMDAwLklmYzEyZGFmZTk2MjFjYTAwZGMwMDIyYWQ0MjZhZmViY2YzOGZiYzNiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <615ef1398f9d35a55ce98b58edf51c44a6d4dfaf-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQOD0-000000004Q8-31IZ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: use man
 argument in management_query_cert()
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8400499077997028098=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8400499077997028098==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NHvdHhyO+m8="; charset=UTF-8

--NHvdHhyO+m8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2094?usp=3Demail )

Change subject: manage: use man argument in=
 management_query_cert()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

manage: use man argument in management_query_cert()

It passe=
d the global management to
management_query_multiline_flatten_newline() whi=
le using its man
argument for the state and input buffers=2E No functional =
change, the
only caller passes the global=2E

Change-Id: Ifc12dafe9621ca00d=
c0022ad426afebcf38fbc3b
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2094
Message-Id: <20261102170041=2E11=
0861-1-frank@lichtenheld=2Ecom>
URL: https://www=2Email-archive=2Ecom/openv=
pn-devel@lists=2Esourceforge=2Enet/msg40455=2Ehtml
Signed-off-by: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
1 file changed, =
2 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/manage=2Ec b/s=
rc/openvpn/manage=2Ec
index 58f63e6=2E=2Ed3b2e7c 100644
--- a/src/openvpn/m=
anage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -3998,8 +3998,8 @@
 
     char *r=
esult;
     result =3D management_query_multiline_flatten_newline(
-       =
 management, NULL, (char *)buf_bptr(&buf_prompt), "certificate",
-        &=
man->connection=2Eext_cert_state, &man->connection=2Eext_cert_input);
+    =
    man, NULL, (char *)buf_bptr(&buf_prompt), "certificate", &man->connecti=
on=2Eext_cert_state,
+        &man->connection=2Eext_cert_input);
     free=
_buf(&buf_prompt);
     return result;
 }

-- 
To view, visit https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2094?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b
Gerrit-Chan=
ge-Number: 2094
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--NHvdHhyO+m8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2094?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">manage: use man argument in manage=
ment_query_cert()<br><br>It passed the global management to<br>management_q=
uery_multiline_flatten_newline() while using its man<br>argument for the st=
ate and input buffers=2E No functional change, the<br>only caller passes th=
e global=2E<br><br>Change-Id: Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b<br>=
Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2094<br>Message-Id: &lt;20261102170041=2E11=
0861-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg40455=2Ehtml<br>Signed-off-by: =
Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/manage=
=2Ec<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre>
<pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>=
index 58f63e6=2E=2Ed3b2e7c 100644</span><br><span>--- a/src/openvpn/manage=
=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -3998,=
8 +3998,8 @@</span><br><span> </span><br><span>     char *result;</span><br=
><span>     result =3D management_query_multiline_flatten_newline(</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        management, NULL, (cha=
r *)buf_bptr(&amp;buf_prompt), &quot;certificate&quot;,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        &amp;man-&gt;connection=2Eext_cer=
t_state, &amp;man-&gt;connection=2Eext_cert_input);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        man, NULL, (char *)buf_bptr(&amp;=
buf_prompt), &quot;certificate&quot;, &amp;man-&gt;connection=2Eext_cert_st=
ate,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;ma=
n-&gt;connection=2Eext_cert_input);</span><br><span>     free_buf(&amp;buf_=
prompt);</span><br><span>     return result;</span><br><span> }</span><br><=
/pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2094?usp=3Demail">change 2094</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2094?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: Ifc12dafe9621ca00dc0022ad426afebcf38fbc3b </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 2094 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--NHvdHhyO+m8=--


--===============8400499077997028098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8400499077997028098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8400499077997028098==--

