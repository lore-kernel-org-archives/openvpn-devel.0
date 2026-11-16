Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80FD606A880
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dU/rSpa6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QlYPCKQH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Qo8cnIv/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hIfbxgyQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zbZwYfHWntctLKJPpmpheEP1mekTIhDEqV+g1I/hips=; b=dU/rSpa6DtjcJkRtlU+6I0aLsv
	79KvRjzOc/0KNzg9TCEDmw1FQ4oy0Tc4KBQHdKEJaMx+ziXkOrSK9LwqRQ9mzKgRTGfgy+mYTEIJV
	kzxSAOZ17F0JSuwRM3Wigxb8ud2npsemkxbj8B+Y4kkTCjXk16tGY8HdJeIZjskruy50=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSyJb-000000002tH-0fxM;
	Mon, 16 Nov 2026 15:08:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSyJa-000000002tA-0V2R
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:08:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RlTggtPKdhwc3RK1y8KYQ2gOe98x0FzpqCXIb1CiddY=; b=QlYPCKQHJnWUJ73YB3pNdM9ERd
 94vcSAOP7vBj1uhXOvsj7TCwb3gsyTXlSB8SpLtl1Tsd91FXEyy4ME2Zg2/ITZ/RlwDky3YkcJ79V
 NDC2pxjCGmtHyEz5+xniH4HAGB91QN17aJOf3idFpkBtBq8VxM+9iKDinU1jWCSnnlwQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RlTggtPKdhwc3RK1y8KYQ2gOe98x0FzpqCXIb1CiddY=; b=Qo8cnIv/t2DEgRpX3WuTXWG314
 tBiqaW5CUjL6ImT0TronzJs+3lQtH5T3ttS+p9IpMTY2LWVi+UnXe89yd/J/U3HzJKnqj7X1brvxA
 RwJ/kihsXxJbr1i45qeTpM15MlumJPQS8Te17H0RLnkHOQcNT+bbcXCSt9r7l8E3rFPg=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSyJY-000000006y4-1Wv6 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:08:14 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so38039765e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 07:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794841686; x=1795446486; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RlTggtPKdhwc3RK1y8KYQ2gOe98x0FzpqCXIb1CiddY=;
 b=hIfbxgyQ79aBEnME2Cp1a1X+paCTbP20lWbQEBUKOnPFYfWxuDGO16yjp/Hh5MqxXS
 4LC3A92rwCxG3eHzJtE6hogzymA4IbkUggnphFNXGAExdjlUzAlnVn0lEi2ehVfKfB2L
 eT6QoCdKPqFAT5pWGie+gLjK8igzzD06sYvvK8cfIi8wzEM/o5KQC1J9b5wRg6jHhTNo
 w/TuD4TrCvET1xt4omdyorGpzhWgFhY5aO5ZGxMKc/o9EoapB+ZXwIoqEbTnoAZK8D+4
 DX60bLyX8TXgFqTMLjRJQDqagL1oR2qqJPdw+gkCx8X9gELfsIkfmuOBIBtK/4M5c893
 g/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841686; x=1795446486;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RlTggtPKdhwc3RK1y8KYQ2gOe98x0FzpqCXIb1CiddY=;
 b=S4tZSkvyrEaUEhu4+vaJ5OSY0aKbvLAbzmfKqImdU661xSpGxc4XN/iB8ebexuDuxF
 CE2+qRWPCr5FuJTYnwDCii852Nq8XZjxkMqb2KJXQ4Mx0mufi6w7rC40wFaGacH64NA/
 7gAMjOVGQMsoYyumJZgtX5e5AKjcPuZa0/rz/KTxTKKwOeQpx/3aIfUf79p5GA3Zpp91
 iWYJu9PnnTgs787DTpjrMgoM6eE3DFE5VKNuik0TGw6iDRQy2s6NtgtzeIitIlvfasGN
 X723QivMAxPvoAS1/hms2Oo6xuOxG0yeiqd8Qemjn4blJU9MvyRdZ5rSk+LgPkVpj+l1
 sSEw==
X-Forwarded-Encrypted: i=1;
 AL+hErHt6JfiRKupi+fm1Mwr1jhx8ZcXst6TT04oSkp4RKfzmYLNq5nxB1Dj2yDrUxmmP5WwPOkbS1t/89AP0OA3@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+061/+y/XymaHc94B5P25uwLCcqXYh/ZO2C06z8lsBPYNEPABj
 JZ3Wj7fCo2hB21G1VVB0U7ZzYQ9flMS+HVPchFXnokNtENSsXdNYlEXFIjfdHkqOFYYaEWcM/x1
 GDwjoD+k0Osj/H3rlS2tY8WoMHuAPdQcMmBUvtPYHyuXywLLQiekiIqhg56T2fHxFuEE1
X-Gm-Gg: AYBFou2wpZOblZX7lRutaYo+BXB7KIdu7mWROj1t2a/RlQwPfDctadmIklvk4MLYbR1
 vAmLm134Cre9Nq4fJTAMBp7h6IaJ0sgcVealymV0e2Qfmkqq+uULW12wEzbIx7J5eZ2jH/Ii8kx
 JTD/29W2p40+/CJN36hE6UO+wOYCxxsV7+uSVru2LyKbe3dOtTZbJmXdjZM72iwFi/KwDjQzKK1
 UHA3VWnsWMu3wr2QpUkA8PI6LwjH1iwfr3yeohIbY1bwRaxwk1eowt6xwfmDIV8HHSSjLXyMOhO
 bV3sHUI9SPRXOZwKms+sJDFjjXMwBqixy3ky0nVRb87Aoz1fFijUJULWHix7DsGerl2ppKhGz4B
 /y4lInPeknjwVvdzZYkCXAxgRiABkxKJyqMHjI2Bg5PSBOSDfxeB+c6+33sjNgEiwBdbmzTUqIh
 joMyUHzEdLtDPR6BvbtCRtPMdG8m6mRn6V1jHou2UmNdr6MuN1oJ3OHktAOQG7A/cMRLvUlYCc/
 PaLvs6kcdKpD/LY97kniNnUyrtNmoZYP6nuRR7cFFhy2xjEDml2lgWRV8RwfBm5UTHBbvPCQXir
 NOPB2rSlY0jD6kxIRde6VEADC9n+TapDZ38OvNG40VNS5bslZiImoa1Mai3JqTC2/A+MZSXpaJE
 a4qA+4g9lU9a1b6j5QNOxRpQ0pPZ8yl86gkLhKLSU2eOAye04USG6k8xcWziZ48LWC60tGOKExA
 KUwESskxbGz/PJUi4=
X-Received: by 2002:a05:600c:3551:b0:4bb:534b:ada4 with SMTP id
 5b1f17b1804b1-4bb55abdc18mr239132645e9.33.1794841685566; 
 Mon, 16 Nov 2026 07:08:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb6caae30csm114461665e9.2.2026.11.16.07.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:08:04 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 15:08:02 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
X-Gerrit-Change-Number: 2177
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2177?usp=email>
X-Gerrit-Commit: 2abd9b62969ee9b0547291057009cfd7b4f7d7db
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 15:08:02 +0000
In-Reply-To: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
References: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkk2ZjVjYTUzZDQyODhiMDkyMTYxMGY3YTNmODRhZDU1ZDJhYjQ5MTE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <663c1cb9c36614e9bdc52149a872b757833be72a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSyJY-000000006y4-1Wv6
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking_sitnl:
 Reduce boilerplate code for parameter checks
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3273348286449107613=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3273348286449107613==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rwt9mW4bHuY="; charset=UTF-8

--rwt9mW4bHuY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

A=
ntonio Quartulli has posted comments on this change by Frank Lichtenheld=2E=
 ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail )

Change su=
bject: networking_sitnl: Reduce boilerplate code for parameter checks
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2177?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6f5ca=
53d4288b0921610f7a3f84ad55d2ab49118
Gerrit-Change-Number: 2177
Gerrit-Patch=
Set: 4
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 16 Nov =
2026 15:08:02 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--rwt9mW4bHuY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Antonio Qu=
artulli has posted comments on this change by Frank Lichtenheld=2E</p><p>Pa=
tch set 4:<span style=3D"border-radius: 3px; display: inline-block; margin:=
 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail">V=
iew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3D=
email">change 2177</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2177?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2177 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Da=
te: Mon, 16 Nov 2026 15:08:02 +0000 </div>
<div style=3D"display:none"> Ger=
rit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
Yes </div>

</body></html>
--rwt9mW4bHuY=--


--===============3273348286449107613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3273348286449107613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3273348286449107613==--

