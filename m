Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05199C5CFDB
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dpDxXf5og3dQZT/QQRuAH1TEFHPQEWuiGSHBiO4AFI4=; b=Zs8M1taSoVDeivpRhnC+NaHNoS
	Iq0fg+cImMAm6j+1BySyQVGSUkULnHfSymYTToclqSc3T86dpdpVuFjCvjjWb7yYYsorOsfpALz+h
	aEp9W4E5zvDu3ccOzTXqHgUEl33oiTxmbgUoq8aUiPudWmVM1+E2PT//LFWsmMp3vC7A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wus1F-0006hV-SK;
	Fri, 14 Aug 2026 13:32:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wus0y-0006gv-Oj
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 13:32:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=uSYmfx+tqw8Pn4Ihn2FvhaXm3nwfZ08btgPnjpUkI1k=; b=QcEwxQJ0apY5DUyy7I3P4hqpUR
 u+JuKeRE6orIjNT/GCnQ9TB3wFZbIsxTpzwe1iSLb33131D3cqM2GQ1YgTsUi/a6U9nAiu05O35Y8
 9HgViWuy0NwY0NWMXeu+VxByJsbdLgtptUfSWyjgJLb4b6NrELNvs+E0gYBjJ5tdM83c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uSYmfx+tqw8Pn4Ihn2FvhaXm3nwfZ08btgPnjpUkI1k=; b=C
 pJyKhv69CDzlBn2n+0lQAgjalw04AR7BZCsgUS0R1+TWPbNw/J5yQur/i31XPQt6HhLrekPxW1sTU
 RGzdNXho9BvL1XauAUTtEK8/kYCl2v56g4dV1rr8US86tZObnpRsYgL1vIqkxN81fQZJUNmMWJaur
 BwPPluOXPnHksa3w=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wus0u-0000gn-1R for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 13:31:59 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4956869750eso7274905e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 06:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786714310; x=1787319110; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uSYmfx+tqw8Pn4Ihn2FvhaXm3nwfZ08btgPnjpUkI1k=;
 b=M9KmccqEz87tCwm2IZpXlLla90lPem88K9gCZ3YM3RudO8qWtGCMnj9jpKsk9+5/+b
 OipxIxwLi1Y6p0eMM5n9BuMxrOldlg73VPNsF+iFBEjIUbBH7cMsomOoJLycUSWtiQrF
 DeEEdh3qCb1WD7ECD9v+IN4EZ1AmWMTCB9P0p0P0hWRqO1zC5JUHDPU3lF6VH5KKzYRh
 bRbrD8tCVeKqoClqYnF4UgstDDs2rVBi8GNl/Nl/rVcxGICAKxmEybhnSRDqUMWgtbQU
 l+OAYUub+45TYXXeVC1lsJ4c+C77s+5Y7GkIc0IPiD8DvuuIUGhdfcccTwwBIW0Y2+bW
 BE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786714310; x=1787319110;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uSYmfx+tqw8Pn4Ihn2FvhaXm3nwfZ08btgPnjpUkI1k=;
 b=FNsgBxrbI7UioYnZ1E1F1ynYVPThl+tjcsIRiH1mDynkLpjPZoSig2WoWQpawhyWfX
 RZZoKcuRV5bgQL4vOR2ceGRw7xl9cXLmZLK7loxjmMLDh5sLagp75VcTxBbL9foQ+ghp
 eHq996l6bsH2SWMolCqZraoryIKu4qmV+NNcY+5O45qHSFx3TEF3XULWgOJOecdLIZ/O
 F/lg0LCpHRffLkZ6ioEYNRz1dfb3KdrOyw0pdkp2I6jIFU5ek4tzM9/DKqMop2lz0t82
 3exNh6pnZOZRRQFE3kpY4YhntBZ4KNZOZm1THfYR/3icE9rSK4UALqAMWgWjKgirzLjh
 1Eng==
X-Forwarded-Encrypted: i=1;
 AHgh+RrF78Qj2gU1SN941kmW84wZLeZbkFjUMZwgCSyl9UtxKamgawLgWyhiY8J4X7qsVLZuMQhRExSz8YRWGr5V@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxPZ4DSjAqk8EailIVzmnGq63bNhedmadiLrvyxMc5PPQupTx5t
 AA3Q2w9OxMfZCnt2tpUo54aBknaON7CuevtK7eEv0Sj3eIgTasbzuwyM4QfM8nPw8K9/74lVZwT
 VEulXChzfjcUam97qUpJ03wEmFViuS3+/hfKdDlSU1YV97b1hXZDCXgd/5HteN+wNZFXetzYmKY
 xwYH7tHw==
X-Gm-Gg: AR+sD1001rIfZsT0JGpD2hqXUn9YPrdeX08k44UcupsRj9q03B7BnfiRsaxz72C/HuJ
 81rzi+7pyNvJsTv9ro0YitVnFferrc2Tga35sUFvmeEkk5FT67kyj0AXerfeVmEMlP4/6rUYw5h
 fEmRVvrwPotMtrYiz2LKdWZFt+PXPI/xvO6j9od80klQUICFedQE9NhSA+aoMBFWLdNkTR3ieI7
 RxDare/pN4mgXGqTIQRH1lrCzWfwWhQu8GEE+ZKQm7hYd/N7O9TAZPk8jOc56O9uBROul7UEgwo
 R9jEixmIfxqrP7OdTbStPYbPhR9chtagP++Xeg/tMB73aGOCdLcwwJraeInehKX+S8UMmzOlPvC
 PNiv1VyDURHKzR4zQ6Iyob5AWJZbcfZVieOS70bfiwdnQlfeNKqPg+HcGu83+mpnYpg26eKf/+D
 g0ZLwQAZkUwzUrZCvo63+jTxOS3Ez586qDQN9RsusJ/ekiCXvA6NXj+AL47Rt1beMUWSMCVQVG8
 oQyMhXEF86nuPCYOet49l8ueN2WmHSlFPY48HyshkUi3tRs7YoMG8WuLKbb41q3BQz/Y59ZFOzr
 kLn4i+xzTguk22YZycG0rysq3HFlel/kG8HJHgS2GW5ASAhhF+E=
X-Received: by 2002:a05:600c:4e89:b0:499:516b:83d5 with SMTP id
 5b1f17b1804b1-49987961bf9mr66901445e9.11.1786714309769; 
 Fri, 14 Aug 2026 06:31:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998777caebsm64934025e9.0.2026.08.14.06.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 06:31:49 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 13:31:47 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I8f3545f703126dbe96f809e69ad351749b14b1e1
X-Gerrit-Change-Number: 1719
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1719?usp=email>
X-Gerrit-Commit: 05458f819cd4616f46e2d080d6017fcf19dfc501
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 13:31:47 +0000
In-Reply-To: <gerrit.1782134588000.I8f3545f703126dbe96f809e69ad351749b14b1e1@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8f3545f703126dbe96f809e69ad351749b14b1e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZjM1NDVmNzAzMTI2ZGJlOTZmODA5ZTY5YWQzNTE3NDliMTRiMWUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6f03e2ff548b2934b721ed4919d969ebb23bf56a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wus0u-0000gn-1R
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Support p2p NCP
 negotiation in p2mp mode
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
 frank@lichtenheld.com, lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0563430553332342735=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0563430553332342735==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2G2yDDQXwno="; charset=UTF-8

--2G2yDDQXwno=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, stipa=2E

plaisthos has=
 posted comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1719?usp=3Demail )

Change subject: Support p2p NCP nego=
tiation in p2mp mode
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 5:

(1 comment)

File src/openvpn/ssl=2Ec:

http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1719/comment/8b4fabb0_8f3063db?usp=3Demail :
=
PS5, Line 1896:     if (session->opt->mode !=3D MODE_SERVER || multi->use_a=
symmetric_peer_id
> If opt->mode =3D=3D MODE_SERVER, this requires --tls_se=
rver, 

In p2p mode both sides are expected to always send peer info=2E But=
 the multipeer follow patch als enables MODE_SERVER with tls-client=2E



-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1719?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8f3545f703126dbe96f809=
e69ad351749b14b1e1
Gerrit-Change-Number: 1719
Gerrit-PatchSet: 5
Gerrit-Own=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-CC: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@g=
mail=2Ecom>
Gerrit-Comment-Date: Fri, 14 Aug 2026 13:31:47 +0000
Gerrit-Has=
Comments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: stipa <lstipakov@g=
mail=2Ecom>

--2G2yDDQXwno=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, stipa=2E </p>
<p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1719?usp=3Demail">View Change</a></p><p>1 co=
mment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
719/comment/8b4fabb0_8f3063db?usp=3Demail">Patch Set #5, Line 1896:</a> <co=
de style=3D"font-family:monospace,monospace">    if (session-&gt;opt-&gt;mo=
de !=3D MODE_SERVER || multi-&gt;use_asymmetric_peer_id</code></p><blockquo=
te class=3D"blocks" style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;"><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">If opt-&gt;mode =3D=3D MODE_SERVER, this requires --tls_s=
erver, </p></blockquote><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">In p2p mode both sides are expected to always send=
 peer info=2E But the multipeer follow patch als enables MODE_SERVER with t=
ls-client=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1719?usp=3Demail">change 1719</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1719?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8f3545f703126dbe9=
6f809e69ad351749b14b1e1 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1719 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@gmail=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Fri, 14 Aug 2026 13:31:47 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--2G2yDDQXwno=--


--===============0563430553332342735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0563430553332342735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0563430553332342735==--

