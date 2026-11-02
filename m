Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E07606A93E
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QCHefn0Q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lPygMKrH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=meaAtN0k;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BkgztUHZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LujxRUhd3s6z6sIM8mdTqwp9hLnVK9UESo/+Kcc0uUU=; b=QCHefn0QVrd+/psIiB/2anx+F1
	Zjc5U4llY0g2gdE4gbL/0zeC7KyhbwCPjB6i3m8nck7jtcySyOsnzoXjBoj0YoLPTYT/Su/Tak7vU
	mCoxNr2IUIKktXb6Vb70X1CHN5+/ai7EQJblokpX+aKHq0G0AowkaMMifm4ESoov0hoI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNtLP-000000008Fj-2w3j;
	Mon, 02 Nov 2026 14:49:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNtKx-000000008F9-2RfH
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:48:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uRck9Piae5ilMPaGLcNLy/q/LFvkSGe6/a9eQY9MV+8=; b=lPygMKrHenEs4zBdVL5nY18Zzk
 0Qr807Oq+124oUhnz/t/HWeSkr6G/sZyWz+I+magH7A69KMMYSlFZ7wYZ8MC7ajVRjoWMXmXI3Ay6
 014D6Ohnp7n5y9k+WzfQYVm1dgQhsX/i8IiIsfCJC93L1he84erk1q0H18BjStUskDFg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uRck9Piae5ilMPaGLcNLy/q/LFvkSGe6/a9eQY9MV+8=; b=meaAtN0kEhBPmTewZArOp0omSh
 PTHeEIhTa/dBIsUwRJ+DQ/d9U0fzDTQJViVXEeG8+a+cYXyyv1v5Sf97MTkGjdKMMdB85LzbufGo4
 BoUlSuZf7/cpixPHoJFr7pGj3+eFCY7HxqG8g2GwM7LVYfWiX9qy4PXTJpkcG996jebs=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNtKv-000000002Ft-3Rxs for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:48:39 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so19871185e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 06:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793630911; x=1794235711; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uRck9Piae5ilMPaGLcNLy/q/LFvkSGe6/a9eQY9MV+8=;
 b=BkgztUHZA5ugdQVTXwzqd7nwq2rLEw6wLZerCEdh2j0mMbHr/piaOq4jn/rJigfG83
 wtjog6gGN7WOmtElvcTe0wrrYiqVTZ6ivuz1VfLjHIh9qejMmZ46lPAsBVe8AKcRVKsR
 UVCL72FvKdncW/YnXhTEM9XaT6T4zpE8a/VRn0bv8K225iOZjjR9LpqNBDrGfaONg5e7
 JaXST4Zld/idNfrwx+DABo67QR6pzRVeUgYQjC3ONPYiQ6/wSewEwCzT0+vSU0CWqerI
 wvn8rndQ13O6IHAwnTOuK7nRxWZcQJAS6mgDbRlJPmRmyrPgHbzMKEwILDdsafQLtFpO
 HW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793630911; x=1794235711;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uRck9Piae5ilMPaGLcNLy/q/LFvkSGe6/a9eQY9MV+8=;
 b=NqGo7HQ2ddvdPdvNFQBeKYrwOrvp2qq0krFPRsw1bNSW2Anav2/EAVxTLyRYhp/uxI
 GyYWTLBIDoh+205jgFcYFIMbrM/DzoIiAJEl6o3xHPpz7N4ijQxKJAXxjE5vMgs4GONk
 fhBykfeE/eexIJvwnjowl06uzsoffFSTieg+roL5Ja0/qubUM+Qi8Zuic73set/FOfGd
 stlvzNHFtA4w3S4vSGQ85Wflh+a54w2KP3gsITUyU2ljh81rASvmexs8tcgA/hzmTvC6
 dSRt0HTxI3NbsEGuvCJyUU/zzMbDbBW1tPsvYh68gMSdVtPBx2uEbD6Z9Znb/3YXzwFS
 b+tQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxt68aevUssVlORJuOu/yFdfrkTowAYPHDEgMU0iSuvbuwHzqCZ+bkputt/TCQZGKQMePhQ5/Q957LUnjIg@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJ6uZ+fWeed5RTriBHRTJRqw9R1wB3doEmOECUYhsPcD2v1Oaa0
 CmKg4jfnczAo/tUP96dig1VH/TGBhB4fQK6S9pTJOoqOoY3K5M2h4h10UgIDGkR6zlJe6sttlHK
 BItHdUPVWI9ELNb2q3PRBxxhFso5x1q0ts1UZCWcQtS6jYb3FoSgUbDtUPeIpLkUq1N8Q
X-Gm-Gg: AYBFou0Togv5ldnmwVy/9y5Jo9+AuMtCaZBDcf85FeAW3+0Gk8BjBVClP1ZfVGj64iQ
 vZ/tYtNRo8pZsNWjMDb1lCMJRYCe1+C82CFWn0gw5jqVXlwVemrsZzLv2eHYv1I1PQtaMJaPJ/L
 TZnIKpjYY8cD2DR2M7+gdGpKJ2S4Hy0LX07Kt7froyrRipdCIF24EpHsStyDD4so9+/0rTLdCn6
 5hi4HWi+7FADwGSPJwoPLk94UoWjWuP/IY84oXuzC0kXuiAYcWJ32cw1EIZ5SyMbvYtsIbu0q0X
 dT6L+LxcilNGQ4ziHmcfalUlSn91ICy9WtOOukWErvOhCyR9lMMLaG/ll5H9oXon3y/7A0UpGyV
 fuOsH7/0RrqzvhBBHLdG/UYttuDv3SxjT3gyqX3Y37py+wQ1CNPJ1rj1u8JINih6vy4ufp2GWAm
 M+hBL9FGDEOp71PywbVSRs5FcBvHHegT9Ax/tWiu2fvT3uO0Jr/7uynZOLtNb0dp47MiN2thoWE
 4NW1Et+uvQmJcjv/SuZao4JyGDPK3PZjJ8yiwyuu1H4H/T54bpxU1e/0qJdkXgjf7O2U4E5pv0I
 3loV9FM+JtQWYbl5mMWmA7eG5i/mKGsXUx75OhbnFSHVRnlxjjRrByIQTy43zod56Ch4QIewjMi
 xZIL1bZ++8Qv9pF1Wv8gFzAsm+cQUI7XO3rHcSpmWgbClgerHyIjwrT66EH/CvsPqQr+wuiRBgM
 2nfTkN6iLCazySDQ==
X-Received: by 2002:a05:600c:83c5:b0:4a2:148b:c88c with SMTP id
 5b1f17b1804b1-4ac17191017mr222082015e9.8.1793630911137; 
 Mon, 02 Nov 2026 06:48:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81a896ecsm366221535e9.9.2026.11.02.06.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 06:48:30 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 14:48:27 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I80b9969f555d670bc101635318d245d1b2de8ec5
X-Gerrit-Change-Number: 2092
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2092?usp=email>
X-Gerrit-Commit: 5d99227da88a5465d1e523b974104e88c599ccb9
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 14:48:27 +0000
In-Reply-To: <gerrit.1793629964000.I80b9969f555d670bc101635318d245d1b2de8ec5@gerrit.openvpn.net>
References: <gerrit.1793629964000.I80b9969f555d670bc101635318d245d1b2de8ec5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjI5OTY0MDAwLkk4MGI5OTY5ZjU1NWQ2NzBiYzEwMTYzNTMxOGQyNDVkMWIyZGU4ZWM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0acc9e072ad66aa4d4a2840ba268414f1c3230d0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNtKv-000000002Ft-3Rxs
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: free gc arena
 in windows_set_mtu()
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2069191157679976861=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2069191157679976861==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CaFKmP2+60c="; charset=UTF-8

--CaFKmP2+60c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092?usp=3Demail )

Change=
 subject: tun: free gc arena in windows_set_mtu()
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2

(1 comme=
nt)

File src/openvpn/tun=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2092/comment/271ab542_01b45dfc?usp=3Demail :
PS1, Line 5239:     gc_free(&g=
c);
> I would move the `gc_new()` and `gc_free()` both inside the case wher=
e it is actually used=2E [=E2=80=A6]
Done



-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2092?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I80b9969f555d670bc101635318d245d1b2de8ec5
Gerrit=
-Change-Number: 2092
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 02 Nov 2026 14:48:27=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: =
Gert Doering <gert@greenie=2Emuc=2Ede>

--CaFKmP2+60c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 2:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092?usp=3Demail">=
View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun=2Ec:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2092/comment/271ab542_01b45dfc?usp=3Demail">Patch=
 Set #1, Line 5239:</a> <code style=3D"font-family:monospace,monospace">   =
 gc_free(&amp;gc);</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">I would move the `gc_new()` and `g=
c_free()` both inside the case where it is actually used=2E [=E2=80=A6]</bl=
ockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092?usp=3Demail">change 2092</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I80b9969f=
555d670bc101635318d245d1b2de8ec5 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 2092 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: M=
on, 02 Nov 2026 14:48:27 +0000 </div>
<div style=3D"display:none"> Gerrit-H=
asComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--CaFKmP2+60c=--


--===============2069191157679976861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2069191157679976861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2069191157679976861==--

