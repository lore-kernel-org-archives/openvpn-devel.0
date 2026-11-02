Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0909D606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=j2tCRZIG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=d8SJkgHW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=nHsLD1XY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QmmIg2Lw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qO3cep/trUaKCwusn6i3lCBZNPoYL8DM0EVKZhaMqZ4=; b=j2tCRZIGV8S7P0UlsY1yuNmUAx
	z8tHTPaPMxv9AzRaD0wjl5eZQGSY7iEa5pm+g/7DhEj62fuzPg0xaS9BnptMYW0EmTcWJbnpq5rzO
	W182fnamdfJA0hgk2SM+h+OKTcY7pQgGSF4fYGk/7agitP2o7r9GDiWY9ibBUe1PNdEU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNsOu-00000000491-1daa;
	Mon, 02 Nov 2026 13:48:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNsOt-0000000048v-1d0M
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:48:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kx8AdgeN2WZyT2FpJD3S48PK6IC6aQP3UT2MuxoMPeI=; b=d8SJkgHWBMcBFkv+zYaIL47UZO
 S7sJNwl/yDdlbhFxObjhrzYBFQFzxp94KiZUyApCU5UV5nCOJDVq/rF/l6KxiN50BowrWXxFoSqkc
 JutNh+0lXQFrWdjepvO8vR/rIGxshVZ6Gkf+h3/xq5Hq30rOWpOSxiPXDK4fBuGYMF/k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kx8AdgeN2WZyT2FpJD3S48PK6IC6aQP3UT2MuxoMPeI=; b=nHsLD1XYGi7y25iQZ4lDrqV3Vo
 MSndrd+rfLemRvbbvITXZYd+34oTQX1Wwvk66ZOj69myGhnCFkwm2Eoj0ZqdqWE83c/NIrcAXMOIH
 /CT5xxekioSk/2XLS0xdOcCjOwxox+ONJoGQG/MwqyxWyPB9eB7pYFN7XYgWHWzAOukU=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNsOr-000000000Vc-15hN for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:48:38 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a4dc547987so15707215e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 05:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793627311; x=1794232111; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Kx8AdgeN2WZyT2FpJD3S48PK6IC6aQP3UT2MuxoMPeI=;
 b=QmmIg2LwT7zSCfFgEM2t5NKX/tzScA6qBi+FiNDgR9FRWtuFeZUi/If2/wZAh4kMVc
 C78w31cJ4I/Mcy6WsCJ4qpARhni5HhR1uubzG9e3n0dAEMvUqUF7NKjStG4S6lU3Dlst
 yz2AJ0n6qAMVeIRbQp9IA2/9u1u1j0mvZSOE3kQqSXixXoaKedb8y57hc7Ix9QKoJQZP
 KZZlhaU66iwVZjwQIPjmU0qcCzOsm7dLtl8b8jKEGqMX7YtSYGaoJ6Y+Fdha6bvM6GoX
 Z9QZ+G197FB1x9U0Q+8qa7vbNDUkLN52KUZcJ4y4RLv9opwWr6kVPFV+Muy/riTD2CF9
 6huA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793627311; x=1794232111;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Kx8AdgeN2WZyT2FpJD3S48PK6IC6aQP3UT2MuxoMPeI=;
 b=bIn3MoXPSlWGp5Uyu/xFq4GgrUM1FAfRXrpMoiYA1AiucmrBJfI6K75x12z16uyQGG
 EaOKf7LIrTRGJOkPw0ZQJQ1qiVyVkawNrbPpXmvwG22QHjNjR8PLkrGH/xdN4ZWLqNF0
 k8SOR6bbipsarff033S9C3UdZLIxFeP2VuP4pdL2P/qxEKXJEdRK03VlQkTqo9uhbPZb
 T3E7WRuU0fT7596CKzmhrDgOY6k/AvrJHqK6NU0Z0WfVNKwk3E+6NyEq3HAAS7EyLFwl
 VHhT1WZVEUVgDnrvsRWVC2uNi0UxrrhC1eWUP3y4Fd5Fz8cU/44+8tQV7S5gGm9LlcdH
 NiEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5Fu++01hQx2oep4gmH4cRe3NcRvetURgqE2j//K7P5tKK1kIsS9ins/nWwpnjmLeV+c0VGkQO5nuP4h1Q@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKNxYq540TIUMlT+OZm0tLEy15+UmPCm+XP05GqYvmimFePwp6s
 moeXL+2ImgteA6dmswFAVOUElT5w9dLemDZI/kk2fv/Es9TalLnhyS7Qx+6/q7e33z5hA9fDjJZ
 /k8RgTT6UwOsnmFPXbQjpORcbrq5gJrrgcQU1whGiF4ym3xFYDuxXkh40oB93Tt/xXVgf
X-Gm-Gg: AYBFou2eESZuUM44KMDN2BJw3d8kDL/lptg/MnZs8ANK7zIvOVsQSqveFUVRaqlDSdM
 Q2ZTonp1wpxnkPbPsDPbjT6AJWBhD2E2w1voZKLzKsWQAb5Qji+6cHvbiZ242Dzjp9O51wqZk86
 xcNm7LFriszMwx70uzIFRjrkTIFGxBnpKDjC6dYnZMhEi3vnG8sIfNOgd+BDcvFI1VW/lJCHVHl
 xZnfHP6dubpAfJw3eBFnCQyCJKJnxugl75sXDqdFWdtTTwCoaUBb5cLDh3xzzebOc6jvbtqvUEp
 FkjVTXON5wXoBKnWNTzGOhXabtyZndLkxPd0quLWl0UM2+1prWXMTKDRftvq/ZGqaYk6Fs7QNv3
 UsSxkCz1SdZ+j8ioxUValu74ftC2FlPnHtfFTD1Tb6vvgfHw9WdX1YBT2LjrmujCTQO1WYKaSnH
 l6XWk6Ru/jTxEEc3ZSt+A8w2P+2Kn7ZUhQA2gKNfnNFW6WAFjYt50tLclHffgpJwoaf75tC9K1o
 rcsAM+Ze9FqYuaJf4jMR77XSWfx79CfFY182dLbIK8czKupI9j+psZlMrbHXyl4XtolTpyJmb7g
 iXJHN3K+vhpI5bloZSXM46Ayxu8RbLoggPOGwRXvoHHiLiREL5ey5gMO8jqsUfU9JwDpKDQbx2P
 o0u/Bl2GecdoJSRH7FWu9JpDXm7HX+kvVhZyP64VM+DXeVoIbCecalYHEyII9wbohJEuD4cN6KE
 fyunnwDuH9sr/nNw==
X-Received: by 2002:a05:600c:1907:b0:4a2:1a:a116 with SMTP id
 5b1f17b1804b1-4ac16fa15edmr233959215e9.0.1793627310435; 
 Mon, 02 Nov 2026 05:48:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf723b5dcsm276273565e9.14.2026.11.02.05.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:48:30 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 13:48:28 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
X-Gerrit-Change-Number: 2080
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2080?usp=email>
X-Gerrit-Commit: e2794cef559a966b0ea1407060e7c5f051da3351
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 13:48:28 +0000
In-Reply-To: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
References: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljNWNmNWVmNzIzYTMzYWQzMDRiMDgwZWYxOWRiMmU0YTBmNGJiMmViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e6c00793e04049e435801c3e32806a4b193dd02e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNsOr-000000000Vc-15hN
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Clean up weak key
 check
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7588794605609684416=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7588794605609684416==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+FvetHUZ0nQ="; charset=UTF-8

--+FvetHUZ0nQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

S=
teffan Karger has posted comments on this change by Arne Schwabe=2E ( https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail )

Change subject: C=
lean up weak key check
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
Gerrit-Chan=
ge-Number: 2080
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 02 Nov 2026 13:48:28 +0000
Ge=
rrit-HasComments: No
Gerrit-Has-Labels: Yes

--+FvetHUZ0nQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Steffan Ka=
rger has posted comments on this change by Arne Schwabe=2E</p><p>Patch set =
3:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail">View Chan=
ge</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080?usp=3Demail">c=
hange 2080</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2080=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2080 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@ka=
rger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Com=
ment-Date: Mon, 02 Nov 2026 13:48:28 +0000 </div>
<div style=3D"display:non=
e"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-L=
abels: Yes </div>

</body></html>
--+FvetHUZ0nQ=--


--===============7588794605609684416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7588794605609684416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7588794605609684416==--

