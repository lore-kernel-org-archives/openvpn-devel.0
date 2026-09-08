Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD34C79FA1
	for <openvpn-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tzc1gYlaa9ycdJxHhyuMBiBGQaXJqZB09913qRXR7sM=; b=Q4/gRdRP+rCRTZjSJnaEWrOpQ2
	XQFHkUaH3/Ed3YUQPmKF9WKaBm32IWusVT3Ki0gvPcUU/7OKRGG0So341qUXgStbw3x0NtO0taCsC
	cB4dnjxnEUAqqyAeIV+4/DGQTBQi6qmBLnKfUvacrv2DYhpce8DPQzNe5D6s5nI2OKGQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3rr7-0007T0-K7;
	Tue, 08 Sep 2026 09:11:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3rr6-0007So-Ji
 for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 09:11:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=RydgapTDi+6hbFUfb8fIxhLsNRCbhz6OfVdMsm5Vd74=; b=TuArdadF3Haq4NUovjVnGTT4d2
 1u10OBL45oTyTrfUyjuMETkHJpPfNBKcO2HtCQvLiNGTPDMnHO5Lb56VpSayHxitQtCTQqKyEBs1c
 lSP3JWNg8pw5d7MWx9pY/FFR8j0iNfljIEnjoPfAeQPynyp+xbemPN5TR6FaXYI0+HD0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RydgapTDi+6hbFUfb8fIxhLsNRCbhz6OfVdMsm5Vd74=; b=H
 njJQyeHmVN3Kmk2bjdyps7CW3F++FbFOVgJ/StUqr2oUgWAn9sh5Gg4SLb4hjjugD9vWUJdmoyZiL
 gYvz06g5TP4IxVvUJsiGIIEYuCdEukPbdwt8xlLABcF3Kilww3+dF1PMaPFoRS7sDlfc2eraU5cvI
 8+LNjY1CW76pEnXM=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3rr6-0004lO-Oy for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 09:11:05 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso47401645e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 08 Sep 2026 02:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788858658; x=1789463458; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RydgapTDi+6hbFUfb8fIxhLsNRCbhz6OfVdMsm5Vd74=;
 b=dsu1IDqvpJTk0n0jAtiHTsVrl5soxXL6p1le2s+zhbyrLo9ZbgxAc2J12GxqjG3tsr
 sV1xmPIRpiEYpBU9hu2iGeusoUc0D5CniEDDxLIAokfPNKWmT9PTRg5AfHopvThy1Lzo
 54jvS7vYJSQCZ8GINdrdi6KkDnL44okm6jA5ELc1ecSbguhbJwM4y9EyzjBr0CT5nv2T
 lIHeMHEZibTeyuOW54TWGva4836ot4MH0miPp7eA+I01CI+erwAITQLgEdw0icZ04v63
 BPtxA5ZejalRsjp7pJJF/4zZ2prTitzodX3QmDqtfbqZfsMzBILII/1sQRcbJLfX2d6V
 Slew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788858658; x=1789463458;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RydgapTDi+6hbFUfb8fIxhLsNRCbhz6OfVdMsm5Vd74=;
 b=qwXB1v1S6kgXQKz2yAN629OfetsnJrPAXK3GsFpry2vSL9+U0ORdzdmQSIBqx9APAw
 UxrviRkzrNEbrPeSuMAPx6gWhtUHs78Og5/lAkSFs6UVBt0djgKBVAdnDrTQK+erBYhq
 G5R7mz+18YZ9KygG2kIli58Z6F3rolaGezkAJOsyIQeaCOQlJQYZiCKYBLMNEqo4EuxS
 HaMyt0lHYL8Ti+v/kU5QhvzpjIPINMGSxdskqIMJInBHONzu4rNq7I9HgvskNqtGaMnN
 XaCL7SI2vI0/oXzngOVeAcMuaL07Igp/9evH4NC+NfScJqXlcwmQp22qeALIP2klkNcQ
 UcnA==
X-Forwarded-Encrypted: i=1;
 AKwUvByhoGj8uUi9CR30+nZZXIw78Z2YUzFw38KX/ewM8uDONWwHJeCxINI4Uo5uMoO68cqXfeUdpEpGhImyNHHC@lists.sourceforge.net
X-Gm-Message-State: AFuF++kPQnLtXHkvIAtgkKkgXcikbloislUbLwQixNfI6DY1hV6aDal3
 /qxm69X4vkR26xerSxcnEVtMFuCasAoYbRAu/gvHBpeQwh6txM5/hKI4tiDpl59vtcJS7XLr64G
 bibM8Gpv6jdeXMpyLwLxPNtzvCo6tlHuoilFgtGtaqQVoYR25aOndm+JjzmDXKVljlv4R
X-Gm-Gg: AYBFou1GJ+YXVqF8LWwP4lpW4NTBKjn29TvWrHVD48tsKd7aMzpkIPX7Q5O/4YIR5H1
 gPasZtKcWeKQsM2wxOcwx3oos/BXEFehaiJQVrLtDYBzGSAJG4She78NGOTghWGtR/0n2iN4xTO
 aq+HiF75Nu6FNGW36LVAY0+AFSpx4M/K6dWpG9Wg9/nvbmDqW2WhI29Q12U38xb5cNGRnp5+czp
 jM5M6VXkaZhVZZKs0Ys0LPBI5gOaf7Gk/q3s3vHSLF02c+w7P/l0XXoFLS9WY8do0fE1QpL3S5T
 IN3uby2IIbeqLDPq13G2i+m/GMXOnn0cvmLizgI8mNSs1HXurv5fbpQ24uJGHz4yGLztIGRSb4v
 2SckRQzrKyjSVNAT2RsmAotIcS0lkt5YxR5J3DIoBPXopBE+4WZM7ddB1ePBTG9rhtg0I/gCUv5
 KurcW6YyixQpnIVwliasLa5YaLT16vV1e8ajUEph0/VML876yZCWI+39qSrAz6lQ6XSFS93tY/v
 t12pwr/LjkapBCoRjlGHFTk2BYgaPfjlurmNLfQsKDTj6imPeNJDDAEpwzdPXSRGXinbaFD47Ey
 HLRln0n1lnYObkfcWfyOvHJKNm1vYlf1is8Uu+tGuDmgDhxUnMw=
X-Received: by 2002:a05:600c:8b09:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-49cf823f57fmr568324535e9.10.1788858657853; 
 Tue, 08 Sep 2026 02:10:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce4761dd1sm326395835e9.0.2026.09.08.02.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:10:57 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 8 Sep 2026 09:10:55 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: e7f2021d892ea700a998d25f87b8059cec160049
X-Gerrit-Comment-Date: Tue, 8 Sep 2026 09:10:55 +0000
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ac6b7e557ffba80fb5241bdfe2bfbddab06045f0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3rr6-0004lO-Oy
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add client
 PROBE_REPLY parser
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0352918634803911589=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0352918634803911589==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QGbSKlPEb40="; charset=UTF-8

--QGbSKlPEb40=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
lf_lici has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1745?usp=3Demail )

Change subject: oob: Add client=
 PROBE_REPLY parser
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 12: Code-Review+1

(3 comments)

Patchset:

PS12: 
just =
a couple of nits, the patch looks functionally correct=2E


File src/openvp=
n/oob=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745/comment/d765ee75=
_21b72230?usp=3Demail :
PS12, Line 137:  * oob_server_probe_read()=2E TLV t=
ypes other than probe_reply are skipped=2E
nit: TLV types other than probe_=
reply *marked optional* are skipped=2E


File tests/unit_tests/openvpn/test=
_oob=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745/comment/1dfbe153_=
a08b8504?usp=3Demail :
PS12, Line 479:     };
nit: why not include max_late=
ncy_diff here as well?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1745?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
Gerrit-Change-Number: 1745
Ge=
rrit-PatchSet: 12
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Review=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Eco=
m>
Gerrit-Comment-Date: Tue, 08 Sep 2026 09:10:55 +0000
Gerrit-HasComments:=
 Yes
Gerrit-Has-Labels: Yes

--QGbSKlPEb40=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 1=
2:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +1</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">View Chang=
e</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1745?tab=3Dcomments&amp;usp=3Demail">Patch Set #12:</a> </p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">just a couple =
of nits, the patch looks functionally correct=2E</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/oob=2Eh:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1745/comment/d765ee75_21b72230?usp=3Demail">Patch Set #12, Line=
 137:</a> <code style=3D"font-family:monospace,monospace"> * oob_server_pro=
be_read()=2E TLV types other than probe_reply are skipped=2E</code></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">nit=
: TLV types other than probe_reply *marked optional* are skipped=2E</p></li=
></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/op=
envpn/test_oob=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745/comment/1dfbe153_a08b=
8504?usp=3Demail">Patch Set #12, Line 479:</a> <code style=3D"font-family:m=
onospace,monospace">    };</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">nit: why not include max_latency_diff=
 here as well?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">change 1745</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: If04ce09d4c353f53=
84c0c48f48f63e05869a373f </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1745 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>=

<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@g=
mail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue=
, 08 Sep 2026 09:10:55 +0000 </div>
<div style=3D"display:none"> Gerrit-Has=
Comments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </=
div>

</body></html>
--QGbSKlPEb40=--


--===============0352918634803911589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0352918634803911589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0352918634803911589==--

