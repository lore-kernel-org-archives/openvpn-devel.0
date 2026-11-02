Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726E606A32F
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=C58rykZN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HU3Hnbp4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ve1oHvPY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LcTf0MrL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RMa4rm0AnFRcJLDcOvJXY/WRuUArPh3dxU2EHDtKs+Q=; b=C58rykZNlx6a6HGo/p7TFlcKdK
	JhLM47gnespgynZAx5hRjRnBVHpr4s/2r/J67kdhfqi9XEtKqfICLdCD1/qf4wdDyG9Mm2Q78HSxb
	KDqVxEC5HFeWYYcvs+C9NrHJDr41xKUdBVvNXOzCS90yfvuclyHfzWSkK8ukIkIVpuM0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNq3W-0000000016u-2IqV;
	Mon, 02 Nov 2026 11:18:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNq3V-0000000016l-3Dj7
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:18:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rq2TD8SgzAx0ibIuUYqaUQQFdWYj01UBJycCKYqsZyU=; b=HU3Hnbp4jHfWDS1FfOXjTac3PF
 TGShnk0Eh6XEzZWynh648buavCO2SkFhWi0WtjCvYppFi12gP3lYCb0x5lDmDbS2fAZAWpurQZtXi
 RLQl77Al1IIraBKA619UElb2Wqtk3BfTyf6IR3FqBxpDr+L2yrRUdPngg1LpDZ0Dfq+Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rq2TD8SgzAx0ibIuUYqaUQQFdWYj01UBJycCKYqsZyU=; b=Ve1oHvPYypQ05MP5FnDSPkE6/x
 OdCjXE9z/XauZIJNG+3WAjuGV3tGSku/TpPfvodA3CV26B/QWnvmJARpsYuUndffp++hO4CK9gaCI
 Sqx7TfFGldVktUQXdOVmUzqluEkgdQQ4z/BO1c8lCr8gQIaKpk2iCbA98bKMPPLd7/dk=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNq3U-000000004Tt-2HEd for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:18:25 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so2448973f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 03:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793618298; x=1794223098; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Rq2TD8SgzAx0ibIuUYqaUQQFdWYj01UBJycCKYqsZyU=;
 b=LcTf0MrL8hl0khQi7hrkIWEaOz8mAGkFiq4N8v7GjPo+Y3XmV/bm6CFMmvVnTJ/ldM
 MN78BDOrdB7xUuT3bQ0p8GLdTlzrvxc4GkQsGgAKam9r74+KA9MJeOLCL+48esEiF58+
 i1XMtP8HQJ5vf4lF+5j5//A0IoAx5lc75ozfITON/VId/8SCTniZhU2LmRbR1JN9PtSY
 lc7D9gd1hC+EmPbvh4wpSgalMOo0K3LT6aPdnjcmccCciaGaKDpYwJPtJtsozTIeR5uL
 7hFxr1+tbZcIKK+2fyM7jR5NcNcZXnK3TIavqxQ89Ak2kYdD6oWy7Fgoxk/n4fvxLU7L
 rqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793618298; x=1794223098;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Rq2TD8SgzAx0ibIuUYqaUQQFdWYj01UBJycCKYqsZyU=;
 b=xvYfxkU/BH68JZ4M00S2DPBS6CUR0IDH+sC14LInxWm6/EkH9V9+UaglXUR5O4Wyw/
 kAH7REftvsDS+cwWB44w8dGdQuSPxWOmwHOcKC05WhPGXJizjL8UxaxTiNdJ+HbxQrad
 2Wl95c52No7rVUCy4Gd/ZEi5ApPxqQOwrinRIfxxkcWXHjB2omqN9jgD5bipUzJMusn7
 wgEA32n+NcP95G4cY8ncP0F8Iudpcg4eMViITTsBQjjh6XXNkb7LOJGxqq3o8E883Xpi
 V8sTDUOcOXuK03nMWkJusSSWO7MgpMI7XCH65pf3DXi7VX1wY+jyJyZ3y5vwk2gxtbqw
 IANw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLZrtytTTxq2pNHCH4595WtL4XA92JjT4Buo46D855E+/oqjG19/LKq/5ZRnUx/D8yaG7wOargIe6GOHvA@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+NXDxANevyp+r0Yaf1Fk+WgPZBgZvX3sHH4Z+aDs6sijaI19I6
 y1T5Cf0m86WHMX8mhOEQ4cQdgtwXKm8pnUdCVZYSFnds4Aj+G21d+dx2OMNdTt/oSSfalLZcv1u
 WMqDu126Iqw757sz4whh6ctfzX3G4sFRxSJmnnFgwrBX5lCVbpGekw5DUbRvBpJ3C7zdN
X-Gm-Gg: AYBFou3ssvyVWpA7yHCyqT3I/bgFoeSa2WBp03fR76jnIO/SyRaoYyC19E9OazQ+ctn
 VkSm8lZSfTfOSe2ZvsiHtQTmuvphv1Q8fHrhmMY2Udnds6momrDr+2HB7ePuebA+vRCSeBoZzJj
 4WNgRYXYiR8X1F1r8khdG7wkMTPNPIUip9bS10l9idEP6Aj57t8BrG0mTxtnIyy50TLWwOH/lxV
 Vo07uVp4kWrQF0a3rHMhVNAZeecKwWjobiep6SYlUUVB9Ssb0ICVKmKwGWOIfcQMbOuCfRWbAJS
 W6Zg+r5VJCUwOLBZbGXp/vvuqVNJLdHFjzs4WNNF2DoFPaYp6EowqJ/GDwtdzc5G9DMaIio2iv7
 pF1Abyv80cjbbQfkttfgwMyNxSCTsk3W4I9bI+7WiIykls3B5sBbkv1NUvlBO7XJKpdDyhvztQy
 XKbwsrlhLXiXQ50odVTMmbIsjmurRCdsOwA0YLWOuy5JFOur3ZCN8+m+LoUf+PMh6YYMoX0+iVr
 sRRIo2x6/TPh2xFdR95yICcwFf8J61IU191lRJsBylon4EGOu0lnIdJUFXzg/7XVsICyg3gy1QR
 1THGwopD0h35OxSfrdxsxD8ySusVMIRcm+BpJm8Mr7qZiKt4aVxf5Ryfyk6WtG4lse8TnUdxqPE
 OQl42LH4pRD/OAe3CHZPFF9gjcgTDitTagjpbyH16F92dgTGpwKBc+MwDKFlMkv03YganXTO5Ui
 mQNozY1LmGwZp2pw==
X-Received: by 2002:adf:e19d:0:b0:48d:ffcb:28e1 with SMTP id
 ffacd0b85a97d-48e6e4f570dmr21760000f8f.11.1793618297660; 
 Mon, 02 Nov 2026 03:18:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d511sm19158619f8f.8.2026.11.02.03.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 03:18:17 -0800 (PST)
X-Google-Original-From: "Hansaem Wi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 11:18:16 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e
X-Gerrit-Change-Number: 2077
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2077?usp=email>
X-Gerrit-Commit: d1b1dff10d81d0fcfd57a74dbadf2958e025c98c
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 11:18:16 +0000
In-Reply-To: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
References: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzgyMDAwLkk2YjQyNzg1ZGU5OWVlMWU2YjU1NWQ4YzVlNjFlYmUyYWU3ODQ1MTBlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ec20743b651ac925c8ac0b48494923aa0b047ccd-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNq3U-000000004Tt-2HEd
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto_openssl:
 Clear PEM decoded key data before freeing it
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Hansaem Wi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: hansaemw@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, gert@greenie.muc.de
Cc: "Hansaem Wi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4860568608120613662=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4860568608120613662==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="n1OaDf4EoLo="; charset=UTF-8

--n1OaDf4EoLo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Steffan Karger=2E

Hans=
aem Wi has posted comments on this change by Hansaem Wi=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail )

Change subject: crypto_ope=
nssl: Clear PEM decoded key data before freeing it
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

Patch set 2 makes it t=
wo lines, OPENSSL_cleanse() and then OPENSSL_free(), with no compat code=2E=
 Built with --enable-werror against LibreSSL 4=2E3=2E4 (patch set 1 fails t=
here with the same implicit declaration error) and against OpenSSL 3=2E5=2E=
9; the auth_token, crypto and tls_crypt unit tests pass with both=2E


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6b42785de99ee1e6b555d8c=
5e61ebe2ae784510e
Gerrit-Change-Number: 2077
Gerrit-PatchSet: 2
Gerrit-Owne=
r: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede=
>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Steffan K=
arger <steffan@karger=2Eme>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Comment-Date: Mon, 02 Nov 2026 11:18:16 +0000
Gerrit-Ha=
sComments: No
Gerrit-Has-Labels: No

--n1OaDf4EoLo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Steffan Karger=2E </p>
<p>Hansaem Wi ha=
s posted comments on this change by Hansaem Wi=2E</p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Patch set 2 makes it =
two lines, OPENSSL_cleanse() and then OPENSSL_free(), with no compat code=
=2E Built with --enable-werror against LibreSSL 4=2E3=2E4 (patch set 1 fail=
s there with the same implicit declaration error) and against OpenSSL 3=2E5=
=2E9; the auth_token, crypto and tls_crypt unit tests pass with both=2E</p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=
=3Demail">change 2077</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2077?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2077 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ste=
ffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Steffan Karger &lt;ste=
ffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 11:18:16 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: No </div>

</body></html>
--n1OaDf4EoLo=--


--===============4860568608120613662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4860568608120613662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4860568608120613662==--

