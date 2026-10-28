Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CA3606A322
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XZMdR3wR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bOupzaDO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=O1U6K0TG;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KjO/yfGQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VUO3OQ5eHUmqbYU4QFYXQuBAlsva5M+yXgLNwuDU0iI=; b=XZMdR3wRM3ArB81a/ydrI/25SA
	KAvUE0VBZNNTyq1SDkkzfLGxil08SmSYQCILhprCMUbTgfj4W09VmbUvYOFPxPvAWzXeot4IQ6OiG
	bjygqNRN8KehCNEGTuC9m/QvAarJ9xtDobMDULTnJl8gi30oubjvjYOrVajnMDPFxg10=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM9M1-000000005im-0GLg;
	Wed, 28 Oct 2026 19:30:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM9Lx-000000005ie-2T2D
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 19:30:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qmwuuuTyStEnK6PvGcLKHc9Oc/mSkaq3Le7C/XrN3U4=; b=bOupzaDOWvWfYXXkHC+O9Nl2z7
 mfXBFOJTQIclxICLJnNc95QN5CTmA5TrkMVdtayTiROXPJLwbqmrKXipNkvGHYTXZhcvZkJSvGIlR
 TPxrrevn0/6oJJLRm/KPNtt1mzfBTFXKm43FpBBnfmPGjZaEZgBF2cFNT4FG6wKRWoP4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qmwuuuTyStEnK6PvGcLKHc9Oc/mSkaq3Le7C/XrN3U4=; b=O1U6K0TGS+qh+0PdsJszNWQ6uI
 LzCdSO+bjr0W97O/4dZrEH03aRdunDA5EzOYQoVYsuqWVe1Kq6mFtloU4rmt0Md3AgV137kLR1irO
 NMx3j0UiCienKvEDVWiZMRDHGCecKkKRDcnxt3cdEJdwFisqES6J5TmK4m6TRgdvhks8=;
Received: from mail-lj1-f175.google.com ([209.85.208.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM9Lw-000000002FY-3cec for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 19:30:29 +0000
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-3ab4c608a6dso14097111fa.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793215822; x=1793820622; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qmwuuuTyStEnK6PvGcLKHc9Oc/mSkaq3Le7C/XrN3U4=;
 b=KjO/yfGQ8cl5HT33p7tw30hyp4LItKah5F5tac5BQHk/lGTtTxdT0FPhERZ+UBHCa5
 W/3qUMXp4MWyh4DGc/t1QM6+8zdIIhqQ175rNWspZIOox0TXhtsmtVAXZABYiHUcF1gC
 NaPlG6jORY6sPZ8EOlI6svn0HkHQBXzbweGWr5WjN/GSqkZLVFibLfy68qSSMDlPdEIB
 P4Wzl7Lb9lYdf/Y0reUrzgAJ3wMaPEXstUeOJKVorTM/QGFMj+CzSJqCAm1EvR4GNgom
 JogWGXzxGN/E9Ty0tfKnK3FujZW0U16KYBJNasTCh6g8qbBfnL17rs/7dDK00PiDaqjV
 zp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793215822; x=1793820622;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qmwuuuTyStEnK6PvGcLKHc9Oc/mSkaq3Le7C/XrN3U4=;
 b=ObKILpzhCamrlGymjjUPJMYBPn5SkDaiDDnFQewiWyU/QVSRvfFWETfbtjJcmwQMvK
 vn313gKuHYZRyR1YEzVyBTt/HJU81sXlweVKzKVgVHMtpEkk6CofuhTkrLjq3cy5tTdF
 2Q0kpOioO432Z48c/pARrwBiEAgZG+HGtuNNUzhIicnHQ+DGWDuv7d7PMBTEhE5plPy1
 sCoC4Rn6zxPjo0BjxMsvSHrdPTj3gNwh2/gqgPmNUebTw6kbB3v9ovImhdpbuZl38Mk4
 8g2OgRK+VUwXPN/pVcbZNbn32ar5cqyzbVVFNUv2dAzjmAPaR4tMsYYl+PKmAT5kJAEh
 /FFQ==
X-Gm-Message-State: AFq9FYKh1pePzpgZeIrvNcXYUYn5OAtbwiwcEaI7RHTfaSXsienWvCYL
 qIjCeMojjoJyJHfbIB8pog7UPcJgWCgfYmnJdNQMy/EQ214NEpDLidd6Rb53CfNNdKI5vo7CA7f
 3EdTbFF3wf1wYiqM2QnFX6A0SJeBf8ht9xxSmGIbFUAc4HqosTQWrhmiYsC4AKAsRfFlUBVZWXx
 xHcp+sXA==
X-Gm-Gg: AYBFou08/+RrtdWt4vvU/GO/lCXchu1ZbFBzD6E5esyb+fHlk1SxqWqAqyUhMJ3/eDu
 GBnFOkKa+m5bsdWUskwFaCIn+7igXH+vTbCCfQBL9drakZeygHvBCsnxPEKmREd4bxPqrRYi3xK
 X8N1ZH7R0lsWwPbs4isE0kcBGRd1Av6ImEl8bKZX/Ap/2Wwp9Pu8VKUo5h+zYoB1CwblCTkiHJy
 IQcet3y2p9Jem9V6Vxmg8d+H1mR9eVvrodA+EBt9gE6wAxeysOKcfM++f90mVbWLOCd42WtrtVz
 sDs6c8fXgx2uYHolh17sG7BewS2WsUN8A//TD4aVibFyrl/W+nXGNKaVXhphnjJo1CiiHkNbbfg
 XfB3vX3lt9eqSIJN034qJl+essH77KBuDboXGHBJOZr2mUWJvYZv/PZGc8UOPJBrA+1o3BwJFt5
 +hiZMV++3q1Kv+u3KqAmVLJFhXFGHI74KZYF7mlYHRFxEmijpmVg6fFtg+rXFDUbPNm7+nXBiWJ
 zBW26P5gd8YgDETrAxWjTEdNTQpcB2M/jUE0kDtFBfpho7zAPzBAPOLbyGhLhiTjwdC6NZz98P/
 odRV5enG6JV/GcuBXh9tM8espo4Isnp6d+SCePXdcHMWEejp5b8LjW3juo6emn+h6MmybrvZsU0
 yfHs6YN2dgmkj7aBlFDrS2GPFnHFywGtPbht84EP6S2apui2pmuBoo7OKuSI0LYaDJYs9E4f58U
 4TOT4a7Cw2+6Tjajk=
X-Received: by 2002:a05:6402:528f:b0:6b4:12df:3ee0 with SMTP id
 4fb4d7f45d1cf-6b49cb8e260mr2308631a12.34.1793214208398; 
 Wed, 28 Oct 2026 12:03:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdd5b3sm29910993f8f.53.2026.10.28.12.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 12:03:26 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 19:03:24 +0000
To: Selva Nair <selva.nair@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I464672facb34de83930eddc4e86826d3b1cd3edd
X-Gerrit-Change-Number: 2068
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2068?usp=email>
X-Gerrit-Commit: 988fdee9ddb81d4e5d54232365c1345975ceb0b6
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 19:03:24 +0000
In-Reply-To: <gerrit.1793212962000.I464672facb34de83930eddc4e86826d3b1cd3edd@gerrit.openvpn.net>
References: <gerrit.1793212962000.I464672facb34de83930eddc4e86826d3b1cd3edd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjEyOTYyMDAwLkk0NjQ2NzJmYWNiMzRkZTgzOTMwZWRkYzRlODY4MjZkM2IxY2QzZWRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b5717b2d1d666ac86ae1fe3e990e57bfeee4769b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM9Lw-000000002FY-3cec
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix numbering of
 examples in management-notes.txt
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3554935042869737111=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3554935042869737111==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DT726zKCOJQ="; charset=UTF-8

--DT726zKCOJQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Selva Nair=2E

Arne Schwabe has poste=
d comments on this change by Selva Nair=2E ( https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2068?usp=3Demail )

Change subject: Fix numbering of examples =
in management-notes=2Etxt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2068?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I464672facb34de83930eddc4e86826d3b1cd3edd
Gerrit-Ch=
ange-Number: 2068
Gerrit-PatchSet: 1
Gerrit-Owner: Selva Nair <selva=2Enair=
@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-Comment-Date: Wed, 28 =
Oct 2026 19:03:24 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--DT726zKCOJQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Selva Nair=2E </p>
<p>Arne Schwabe has posted comment=
s on this change by Selva Nair=2E</p><p>Patch set 1:<span style=3D"border-r=
adius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-c=
olor: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2068?usp=3Demail">View Change</a></p><ul style=3D"li=
st-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2068?usp=3Demail">change 2068</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2068?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I464672facb34de83=
930eddc4e86826d3b1cd3edd </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 2068 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Selva Nair &lt;selva=2En=
air@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Wed, 28 Oct 2026 19:03:24 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Ye=
s </div>

</body></html>
--DT726zKCOJQ=--


--===============3554935042869737111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3554935042869737111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3554935042869737111==--

