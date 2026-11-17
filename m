Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F0860A3816
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HMABfmvQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KQYPiCuI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NA9sQ1X/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gW3FPYXK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TS4n0QJHi+cpco+iXLI0GgwB1jnoCSSu7wx1ckTqFak=; b=HMABfmvQ5hx5LKl2lTzBFi1y5Q
	NQpQyong0VamZG38vLzyeFop/AtOu+57eM7XKgQGpCB3D1KoVzQ0n671m6Tt60viLKPawGd+VPSOY
	Hl4xZ7ntOvVcme8kd1z4bE/PD+04MN3fh0sl+03Pql14jdReOp52l6d8BJ69iKCaySpI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTNyJ-000000007jj-3QQu;
	Tue, 17 Nov 2026 18:31:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTNyI-000000007jb-1Iep
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 18:31:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Us9a8HyAfCrEjaDaxJ+CNU0mt3CTq1EaYs+EE9D3TLA=; b=KQYPiCuI0eoiFcS/GJdrBueqpD
 07rYKDky3Dx0H9/n7ZDIbVh42/FqSRHbjTnq/f8ZzanjA+qWOj5ODR2y2vEVPYqCFW0v0YXjqjAfe
 FrIC1rBR94V/mxxMT2HO/Xh9Q9xIutVLo3mAbI+JbBVykFQFBwFgoNFJ4fYUmVjypba8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Us9a8HyAfCrEjaDaxJ+CNU0mt3CTq1EaYs+EE9D3TLA=; b=NA9sQ1X/jqM7kJY9ajWQ1QQzjZ
 7lPbphorXdPC+icd9PRTpoeIJwDv9yUI1mV2qxWfj8k2sVpqz/Wrua5pF+NnIX3fe57bO3+JPGKAn
 EUYhABvG0+sxIUHsxfriVY3HjWMlc590KZGVPnPGQRyUjlzQuQJuJ0DRqP4DdRLBwgz4=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTNyH-000000006OM-1w29 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 18:31:58 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-491846221ffso61674f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 10:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794940311; x=1795545111; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Us9a8HyAfCrEjaDaxJ+CNU0mt3CTq1EaYs+EE9D3TLA=;
 b=gW3FPYXKOHdAE1C3ZMmIz5SrarGP2cCFSmxKqrEnRqVDiYqo819uVzcycwhiiTzmeO
 fQsDxle664e7IH9acOfMRkcwyvppmWDjXccP9HgBA7cUYJqD+xjQQOmA1ZJb7heJ4Swz
 ZUQTMRbxz+rJO9HMbt20vtIgi6o0QuXUGOlCyy1F3BsOEJPZbempvxsR8k9JBdZk9fj9
 RwzgWRhohMIM6S0amO7QquSnpJy5K9/HVGYJlOdwwQ9gdHD6y/bR2yh2HJhuOzXXXau5
 C1QdZkTzi2pbx/X9gMRdwy5Fi9TqM3mvtJju6cNXmiVypDXj2MwuU3oNoTLb5T9i3H+n
 IQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794940311; x=1795545111;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Us9a8HyAfCrEjaDaxJ+CNU0mt3CTq1EaYs+EE9D3TLA=;
 b=orEplAaAhk7QhnN0z1UH55QektlIfLVmN60b46qicNKlzM0ewlxrYuIs+a/d530XYr
 OivblkZk87leLE+IsIQkoVmYgNwlTR/LPWZFBK8eYKh1Zop4NqjlZn+zL9nSzlEe0juA
 SvTF3yrRnTeDsGAQ6vZefOrdT5q6MY7bo+d/wpDE6JHZg6/WQyM0wZh2RIxYzZtKCJ6J
 0CxvXTavxRBMxINkmQ7tscJpOg9swe5atQsHG7K440lCJLisXqPzBvcQ2TkGFzvH/i3A
 NX7FuBc08bzDiV5f8HIfRfGZLO9XcLCQDqIG36O53kjtQHIcMT7IMbd5HkAvmaLsgTD6
 11Fg==
X-Forwarded-Encrypted: i=1;
 AL+hErGHXq/kxhW2UfZfnBiTMEfNZAUMEgdWOR+LRM4aJ7es3wZVwPq2GboZS+WbEVrFK1kM23M0D+mSu66RHkvX@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/pOpUdCMZlhcHCLVef7bMsqtcBVE/rvTqKDFggqI+Ync0Grdyt
 baCx/Ro2+KZpeVrfV7WxCEoXYrz1VlnaZ/yablPFUjgxYMRNJA069NBcLjFk1svF2gNdMmzi8FQ
 PLFPtVnUKlhRmMTBgVim6JW/G+MhVxHssMIS1D7jpSEMxmhGNOQz6uTiQvEVC+Qy5DP+aoBs54D
 IKkUVB4A==
X-Gm-Gg: AZFdTZeMlwoGBBerm+x+vN8x7A/t3dHTYO2FIIBmySKQv3/M82lxcNqaXNL4rP0D9uM
 tYzbbDicCsG0Rh73atv8dD2TN28u9RppCb4ApIrscLH/Vom6rAwTOOKKbS0iyuuVuJbhqNmGvZ7
 PieqDZ3K7tJMrZ57Tm2VKYyNEPncPLFdNMSGDdE4Tc92lLAT/3UhX6h2j98ZlC3+omgk/Vol1Pm
 Q0DSYCnGkSSaynrJJYbTI1rYgG6yMbm5psUWPku0WlV5h9BoX2fH2JRgvTWZHDUlqY4DChLKvfu
 pfIDFNf41vFF1Mmfefit2f8+d4D+1X6b+hUPRt8lAAKe8e1i0yPIREcvScHfB7mK12jQpFg+aNo
 QgVRsV9OyxARFRIG92onQUHXPBLBGQqNvKLmMBd/0CAvTSbZb+3xUcfsFxyKqhJPKcYZtXBzZpd
 w0pu36KufveXZdlCdZ7glCVg8phF0UGd1WUNo8cVuNaAlWmTMe4wgbnx2h65xCWncFveOrekuC9
 kdJzdBsTJrSheoEBvEpDNgV9gmJLpB2P0Q2FOxaoUibtH8htPBbmyRyfyxEIyFzaHhqvRYAWPml
 nBic/A5/U22WDJ7cYDI89dum5Cu0pSS/0DsuiLTnDxGApTYUTTITQHkxED48AkZfqJjqSddoZQc
 0uOApQPyXJwpeMMJ2nu+hhqdESzv2uS1g4pp01/h8E5wnRby7odtAAYBPQj6rVNGbSXSt6/BSTO
 rSmYO2NRwjzG6S+E25gYiR6D+2DmYXpQAnFlyx
X-Received: by 2002:adf:e00d:0:10b0:491:d224:aa78 with SMTP id
 ffacd0b85a97d-4a63ab754cbmr483841f8f.26.1794940310629; 
 Tue, 17 Nov 2026 10:31:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm220629f8f.9.2026.11.17.10.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 10:31:50 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 18:31:49 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d
X-Gerrit-Change-Number: 2121
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2121?usp=email>
X-Gerrit-Commit: f754481bd2c734f62d462748f7f4efa857dd18ef
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 18:31:49 +0000
In-Reply-To: <gerrit.1793777926000.Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d@gerrit.openvpn.net>
References: <gerrit.1793777926000.Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc3OTI2MDAwLklhOWYzMjhiMWMwZWEyOWFkZjgxMWE5MzNkMWZkMjJjYjMyZTM1ZTZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3d35615d6b5d24ec95025f409d063130f6fea35a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTNyH-000000006OM-1w29
Subject: [Openvpn-devel] [S] Change in openvpn[master]: pkcs11: bound
 certificate size in pkcs11_management_id_get()
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
Content-Type: multipart/mixed; boundary="===============5192022873903040068=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5192022873903040068==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NMUYAhxcL3o="; charset=UTF-8

--NMUYAhxcL3o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail )

Change=
 subject: pkcs11: bound certificate size in pkcs11_management_id_get()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2121?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia9f32=
8b1c0ea29adf811a933d1fd22cb32e35e6d
Gerrit-Change-Number: 2121
Gerrit-Patch=
Set: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doe=
ring <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Comment-Date: Tue, 17 Nov 2026 18:31:49 +0000
Gerrit-HasComments: No
Ger=
rit-Has-Labels: Yes

--NMUYAhxcL3o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 3:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=
=3Demail">change 2121</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2121?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2121 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Tue, 17 Nov 2026 18:31:49 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--NMUYAhxcL3o=--


--===============5192022873903040068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5192022873903040068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5192022873903040068==--

