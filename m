Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F7606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MV/XFoFf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Sboh6CD2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WXs7rmkL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PbQpwOY1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kUSjUzRl+PPDxHfsZBq+s819DDCqxKsIBzw+wxKcJDI=; b=MV/XFoFfMksNrjkAitj6qojn1h
	C3Znxpu4jcbxIutGDD7XmI08p5QHAyxs+9sGA3cY6p/LQEbrf5OD9saD5lwJb5JqjKyzUiXWkpANr
	P6nZ5aUeSDTaV59SVEtvJV2zscvFOygLJYCgctRD3BE+mStAf/FeG9zx4nylGw9tEGec=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSuJF-000000008WP-2ws1;
	Mon, 16 Nov 2026 10:51:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSuJE-000000008WH-0ZmL
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 10:51:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YkAReniKe7TOxlI8XkcrelVATEIPLZPq+O6/LBWicQY=; b=Sboh6CD2VpvZ5VU/FE280j9Bau
 3Zqr8SpOfl/gtXjoFFSYlKKttEv3JJCe1eUEBdBc88w88wCsLwCjhN/iEfxU4rW92yEsBRzeWH+jy
 r95b7LPNa/wWPolJjTU8eB+AK65qsXlznx9BR2dY6nInWibTvHuFhc1EF9sTdO9zFQug=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YkAReniKe7TOxlI8XkcrelVATEIPLZPq+O6/LBWicQY=; b=WXs7rmkLKduC/Ehq4N4gC0KYQU
 nEVmX734BHkkknS+xZNW1zd+uEX73G8qzxU5dFq78IIIqV0eBxzCB3vTXwUx7DXGRJm4+sgTneyf0
 qVp6kwTyZsMSb414MA8/U8tr4kfMJVmgXUAQp8P7TynDm8fJbnaB7vGaFhTlO4bhsoRk=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSuJD-000000003ix-2PhI for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 10:51:36 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso19564415e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 02:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794826289; x=1795431089; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YkAReniKe7TOxlI8XkcrelVATEIPLZPq+O6/LBWicQY=;
 b=PbQpwOY1T3mWhVIvlBcDauYChKNPx+4AlJnxAa78DDqfp9fhXW/t2O462Vs6lEnJbP
 VAFcfZJPWBuOts0891QlJRuRhVKWDdbewz3K/pGz/Sb+ewfVnzGhoMDRHD3DEDit3XGn
 WzETEYV55SOoZsZDD+G42HIYOCI/Mlfsp+JbU4sm0XAwXzhnqQAvkBQxjnqfkfZ7OS3C
 77uFx/ciVSKdhUMr97AdnlmtAdN/9hSK2BPkkmKlY5VKpY2ZvhyUgsMxAdpgvgEGEF+o
 Wt9+ogSmfmHc0pseOzILSE0EgT55muTe4CVJQl5HInPs04Qb6n+DS0ZvifKLWdGNrWk2
 mrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826289; x=1795431089;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YkAReniKe7TOxlI8XkcrelVATEIPLZPq+O6/LBWicQY=;
 b=Ui7lSPcLWzyzEeA8SgoDWp0AlcKcCRvCMRzkogcgg3MUsjr3vLWKFOp+gBrheb1yRf
 ufpwRyB8yNWy/+53rHp7q144gYerbOlSIFVVcXGuCipMfE2UUIFXeCu+7Rxa5aDHrCSc
 0Jow6Rxvq2mONDlPT3O8TTMzcNJwnH793z1C5/A1oTrejxgM1urJgEHFQw9pnLirOQ8F
 RvXaofF+toezVamTn8xL/mg7xyLeVdOlq5n+DU2t/LkSE6xyJ3u0rU6/KGoqD2Wl2m3n
 SkaHIcN70qKeQLct4CtbDWkJDDtM/p0WdckFhem9lxQ/pDGz+SM3fGsphIYpdEq50RPe
 AUOQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHMOrDKrpILP8vCuOHWlUEHvhrfg5QmdV8y0XTfQndSMxDITg6bAqXhrPk+EEqHaQFlSNA9EDKrHsFyIeO8@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+GwmDwbdNaXNWOXeYnnAbgDEmDPiCuZjNsyE2375kUtUrtoxJr
 I6GrjU7PhqFhlNKlcH18dvc6v8H9uNTpAt+Tiw790vfETYK5VSLnBk6pB5YOm921BK5gOwdQOzL
 Rwu9JQ2qr1btb/Plc1au9BuSNWM1uauhsEYZyeEim9flRmv1rVBTFyOt2GZ/l4Dae5ynu
X-Gm-Gg: AYBFou2TGLQy9cSvQkmpTnPoEYEVCoftci4S5ztfgwFTXiiD7pSw90Fvb0NpSyYKyVA
 ntxRRNdp6fha/vkl337UyLxIZubBqKxLnQGlAg4Ad3FN5rj3d8m0LzekBZAv0o/ZsSEJZe5bp3k
 HIDvoT8yYwsK103bT4vAQP6+0/vDwOgjqQP/iSvebQT5NchtrVc4bwMzqnemKJs9WEmkxdlZKN2
 nKyCZ3uWfi3sZp6fS5xpEtdjBZVlGhqZ1c7WlfLWjN3UiVDGaxLR/dhOiuwUFKuFscNhaUqiQAw
 ez72yZj2B62n7eBqIUuAtQ1b1dUuil3K1KJcD929sm1YNDrFTcXdpnPpP1LXDs4bdLG4u9dHOj6
 p6Cuid0n+55b2f/sbZT7w0992H0epvLlqcMBudUv9VFC4ZbOStKNYEPsoKdygRyNDvjjbtaAf0G
 mwYVzXSEgwBHjSe8Z4A5FxFMfGg9zUdrKpbrSoGI4kII+N9HYlC4p9ajNuVLGC8ZrUVBiPLIJdf
 WXMPcvxfHOwO4b/CwqfZtA8m6k00jDXvEtlkrOApsWUGeeNcusROJ1UTk6+UoayBWCYz+wk4mQU
 mJwZZfqhWKNqRHS7Z4VlfnpyviHETbGRX4vY9rbtzeCW+shEUruGUeVuae8/t7qi+UGR55z3tij
 5gwQVMhtvqkXuAX+7N0dOHUwycDZsY+uMyHm6JKPKr0jHzxchFJ/JKCOEMe+VLWTaMxwbNHfQiV
 f2bVwek1eP4mbtAKQ=
X-Received: by 2002:a05:600c:4f4e:b0:4bb:6f45:2a77 with SMTP id
 5b1f17b1804b1-4bb6f452d39mr86680875e9.11.1794826288867; 
 Mon, 16 Nov 2026 02:51:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb732a2a9csm46278085e9.3.2026.11.16.02.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:51:28 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 10:51:27 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7c9e123a458b9d3757e9de93f401e4e421741675
X-Gerrit-Change-Number: 2143
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2143?usp=email>
X-Gerrit-Commit: 45bb87ff21bbf6320ef25fbe398d62c30385dd7b
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 10:51:27 +0000
In-Reply-To: <gerrit.1793955112000.I7c9e123a458b9d3757e9de93f401e4e421741675@gerrit.openvpn.net>
References: <gerrit.1793955112000.I7c9e123a458b9d3757e9de93f401e4e421741675@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTU1MTEyMDAwLkk3YzllMTIzYTQ1OGI5ZDM3NTdlOWRlOTNmNDAxZTRlNDIxNzQxNjc1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e4c60a697541206da88c1c965aa78810c2eac645-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSuJD-000000003ix-2PhI
Subject: [Openvpn-devel] [M] Change in openvpn[master]: comp: share the stub
 compress methods with LZO and LZ4
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
Content-Type: multipart/mixed; boundary="===============4451691893451086603=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4451691893451086603==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kpdDjWSzvoQ="; charset=UTF-8

--kpdDjWSzvoQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Gert Doering has posted comments on this change by R=
=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2143?us=
p=3Demail )

Change subject: comp: share the stub compress methods with LZO=
 and LZ4
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 2: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2143?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I7c9e123a458b9d3757e9de93f401e4e421741675
Gerrit-Change-Number: 2143
=
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Review=
er: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Dat=
e: Mon, 16 Nov 2026 10:51:27 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: Yes

--kpdDjWSzvoQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Gert Doering has posted comments on this change by R=C4=83zvan =
Cojocaru=2E</p><p>Patch set 2:<span style=3D"border-radius: 3px; display: i=
nline-block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-R=
eview +2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2143?usp=3Demail">View Change</a></p><ul style=3D"list-style: none; paddin=
g: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2143?usp=3Demail">change 2143</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2143?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I7c9e123a458b9d3757e9de93f401e4e421741=
675 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2143 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Comment-Date: Mon, 16 Nov 2026 10:51:27 +0000 </div>
<div styl=
e=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>

</body></html>
--kpdDjWSzvoQ=--


--===============4451691893451086603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4451691893451086603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4451691893451086603==--

