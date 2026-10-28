Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C243E606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=m28H/Ng4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KU0OEC5p;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NEwziyFL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FOqdKvFd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/59mE6i3dps/XFsWsX9xvCYflhlxuXhaocjFw1Y1UpA=; b=m28H/Ng46WKAKCFq+vxTaxoq5e
	LCUjxyqPrr3H3w3ZwFWHAU2rtcRw5IWCFLmOnc/smAqxVsSPP+lHbIYGlDyxa9gZz88Yx2Z3ydlmG
	jAUIxSzYe4rreDZFGkr7TMVVeI4YlYpm3KyfIFiYLuPowmtwBd4D57pRbcctIygdhA94=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM8yD-000000007Nj-0m6C;
	Wed, 28 Oct 2026 19:05:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM8yC-000000007Nc-2UXL
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 19:05:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LlKLifBE68DdMrevSCuw/CuK6bW6bAejJijB02Ea0aQ=; b=KU0OEC5pK+pCKxWhLhr81LHtu2
 hk1FBNNnb90C1apUa3As+58/zH6oTw4CN/5mlLWN5lGv6c8BVZbhVT3tn3dzC2LKbdEJF3cB4XJhW
 i7sgLtxUHKaINizJjOmNA/LnjI0QrXhCEBMMeYv1Q9nzw2hqG5jmorNNjfiVfIhdO63w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LlKLifBE68DdMrevSCuw/CuK6bW6bAejJijB02Ea0aQ=; b=NEwziyFLYVs/dPeneX817idlAv
 DIVLT6SZ6suGDxNdsVX6S8YwhUAzfZDfxLuh0tBJhZOhGt+pOm78vBZevEN9wmZDn6zfBG4wwFIpC
 mhqsxf+zohQJv2YdpxdWfoPRGTjT9UF9OWUM3VJhGUq3L+I/TM9ksgLUdf2ETMn6cmEs=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM8y9-000000001jV-31j3 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 19:05:56 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso10526325e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793214347; x=1793819147; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LlKLifBE68DdMrevSCuw/CuK6bW6bAejJijB02Ea0aQ=;
 b=FOqdKvFdNvEstde6jdg+sSbXxGyszn20BFJ+V/kI1l20t8QAELJHdwy0+SosIH12Ke
 M7iGIURQl6e4o8hryEnYGws43l0QaiAm5OvX5qDEkoDPqByD10AV2YepDuAgNaUg+LG4
 2n/AYkv7bpnvNuEyUOjnqUeA73ceEjduiVJEpjyEPrw+I7EXDwApDJzVoXqtjqekOJD2
 ytwRzdKTSpaACf3NUr/3/BOIkQpUCB3xrumxe8D2WivBBPj8OHBOHGADI5v96o8+WuCJ
 RE9zoLI7haAcNzO5JYIrkI6coDxoPaZGI6xQxhvmG8cljMCJdWRUK8gYzCF+9JkmDbKT
 M6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793214347; x=1793819147;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LlKLifBE68DdMrevSCuw/CuK6bW6bAejJijB02Ea0aQ=;
 b=F8VTRPLzgmVOvpwebhdUlLJRQJMaDdtDIfdiS0cbQQjwQsthMPvbEUKVf7Nd3f2eLP
 llDm6QKhUw6GqAQX/O0D4vyj7nwvzRz/8EbJ8ClPJglIZKuxJr+IygSbg8ettiGDI6Zc
 Jm435LYWodALCOgh19LXEZHoRoHsRYfyhpLxJqOjgjPCpO+yP6Ut//Jdk71AnkXkQYhW
 UxBNwV7Ib0tBZzseD9PohfPhcfylOSYTkbxnOM9c7vyJgGYHDFjQZgtsk/I4JqBdYcmQ
 O9GQuAb/VVeFcEeSX7ekF31CKXWHkcZK/NgKSaBU5mHpbfKzYP/g//isMtnHIpJEmQvt
 YNYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4+FeG3sQ/qiUUuscLbZMAk8/Y91TLnchdqJbzo0WBTcmZg+4LKYSiFmsCDnileqGFNnBAPP2PTVJXpIer@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKWQ6qTi7hasS/vIQi+fnARAg5df0utxIz9hoo0NOZoqj0Qfwaz
 jnqVB5wgFS/CwUBTJ7wsVOuylCEPbt7CEHrOWgTVj0GctshsUjD7MuFkXaiw5vr1Th+eosZD4zR
 IYdcuQAycDBiSJi/FU0UBEqv8+Aoxs4CUdKJORTTc/X3SlGSyiDrM9VZzGbjHqmb6SyVi
X-Gm-Gg: AYBFou2aFFJjQhCik3mkocTP7pS+i+LZ1+4ccSwtWVLyPlL1Uzb1fLwj7N3X/YxPQPC
 9mMkq2mFBySIZbFlmAplwJtfhifQwUBOMvG4/kvjLTbDfY1b7qLc6tM6onGGNg5R+hu0Tsjm+uD
 zF7yNIFA3/BemopHcg4e/1pksPhhUbpfRhBd5ERjkxeYhIxUPiJG8zsDxYc6kCW/WIZEC4rY5S3
 j9xy4FuLoTTYe2kQ2Rw+HB41Q0upiGl+v2LozSXjW12DQkxveNAJVPy+302m3mU30qR/OroxN1/
 Ek+8ckCmOrrySMSkP6/E2o4ABqatGY4XtPX1CcfqqIYTl/c5phNytq5c5Fmv/H0Zn8EDxo6SKG6
 XRq0dejKM6CphByN6P1wNXWco7NmBPafqFoiDkrEsTDGftX1edsiLpu2y6YmuKCjXzOgw9tOoTk
 nWMwEWRP7+lO0M1AP4DEK6A3UrRriXdDnLNqklvMhQ4VCN8hMyzMuRE767qG2fa16E/FvT+YtVJ
 nJr5D3U5Gtr+vAc4cEuWpGN7ugYbT5sseU25ASI6KhE3eq7afnX+iLw+s37AcGvc4T+oB15sSQN
 sF+YOyKVcZn0Y2uycFBS/y/A038j8vYyjooYPPr6JD7HoT+dbPb1DoJt07SEnoZKI8t0hN2DqjQ
 r3e/SB/fm4A+tXnywEBRXWiQxiOAfdxfNruxLohwhFL/DI4OaCikU35Cjo75Qj/LvtU4c+4sYfi
 QMawTb3wdhtJ1+U1s=
X-Received: by 2002:a05:600c:3115:b0:4a1:f7f4:7cf2 with SMTP id
 5b1f17b1804b1-4a966774db9mr73938115e9.17.1793214347045; 
 Wed, 28 Oct 2026 12:05:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a969e61f9bsm43685295e9.2.2026.10.28.12.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 12:05:46 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 19:05:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3878195ceedd75a1a4ba6adcbffd1adbfda66e66
X-Gerrit-Change-Number: 2066
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2066?usp=email>
X-Gerrit-Commit: c45fa1ff6788c201810b57782bc4ba55003410f8
In-Reply-To: <gerrit.1793206499000.I3878195ceedd75a1a4ba6adcbffd1adbfda66e66@gerrit.openvpn.net>
References: <gerrit.1793206499000.I3878195ceedd75a1a4ba6adcbffd1adbfda66e66@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjA2NDk5MDAwLkkzODc4MTk1Y2VlZGQ3NWExYTRiYTZhZGNiZmZkMWFkYmZkYTY2ZTY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <93efe0227dc19299f001e180060a2f9465d10703-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xM8y9-000000001jV-31j3
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Avoid polluting
 OpenSSL error stack for "none" cipher/digest
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7430073010047796568=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7430073010047796568==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B+CoYUcCCO8="; charset=UTF-8

--B+CoYUcCCO8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has abandoned this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2066?usp=3Demail )

Change subject: Avoid polluting OpenSSL err=
or stack for "none" cipher/digest
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Abandoned

Pushed by accident to gerrit=2E Sorry ab=
out that=2E I had this in a test branch when reviewing/looking at the other=
 patch and kept it there as remainder to follow up on the other patch=2E
--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2066?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: abandon
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3878195ceedd75a1a4ba6=
adcbffd1adbfda66e66
Gerrit-Change-Number: 2066
Gerrit-PatchSet: 1
Gerrit-Ow=
ner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>

--B+CoYUcCCO8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe <str=
ong>abandoned</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2066?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap">Abandoned

Pushed by accident to gerrit=2E Sorry about=
 that=2E I had this in a test branch when reviewing/looking at the other pa=
tch and kept it there as remainder to follow up on the other patch=2E</div>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/206=
6?usp=3Demail">change 2066</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2066?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: abandon=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I3878195ceedd75a1a4ba6adcbffd1adbfda66e66 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 2066 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit=
-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--B+CoYUcCCO8=--


--===============7430073010047796568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7430073010047796568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7430073010047796568==--

