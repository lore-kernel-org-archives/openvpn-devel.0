Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E20606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kXZ4piJu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OyVHRDSF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aaxkNelL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=P47aJS4M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GU5IsWd+qI7KzFD9cfuk+Rz+ohM8UczeRTDahAolO9U=; b=kXZ4piJu2M7LV0cRvkDOaa7wbx
	gry0xJX2HsR6VvFv07H49m7078pWcD75DSU7YCwiQ72o3fwf2u3DnZr6bxYWI/SXvcDV9PS5zzG+c
	7I6R0998Bnc+B+9g3Y/Z9o2ZDR77yQ0azSvq1an49Fn8HAtfhHWENPdapKkMRg4niqEc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJ63Q-0005nH-8y;
	Tue, 20 Oct 2026 09:22:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJ63H-0005mr-I4
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 09:22:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/eEcWPK6Pio6spuR5ORyqexN6KUZMPcNofKsL7mshE0=; b=OyVHRDSFVCKh1VsDnaW7T3cDLw
 s3wJDfMpLx2TW3UhU+5L8MoNolZtAuGzTgqYHsO8CqRcxP53XxVQKqTTjCxZdnVvE88CIyOs+24hs
 vIUr/h/PkqDJr5Ac5ctyTbh1zQvz3r3trFMkeAtwueOTJ1l8MBiEeNXnU3RILJc40kvA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/eEcWPK6Pio6spuR5ORyqexN6KUZMPcNofKsL7mshE0=; b=a
 axkNelLP2mtcQi3t1tkxdkr+cg2ZL8va83s1eKmY38DycR9vdaFO8R1tQBrixZazn9ivaYgsKFooJ
 LJT5RascdzlK8f2BkJqToOGB8GmPlTZp+f30MksPQTwyjxoY8qTJcv0GKL+6BWA9XOnJaHKriq+8W
 grwpVUHtpBAPHvTs=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJ63E-0007cQ-DJ for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 09:22:33 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a1dfd49525so18989815e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 02:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792488146; x=1793092946; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/eEcWPK6Pio6spuR5ORyqexN6KUZMPcNofKsL7mshE0=;
 b=P47aJS4M1kicMVpIgqgH4S4lx5MxuYoRAsD92lkrPv3P0CadAEQAQf2IIZOaBSzcLS
 yYP3iKDO2CVQZTXOrhIWaWfNe3f9qVU9HllC3K1i0aWjbWZQCf9xLVC7r2SKP4dFYDWJ
 3YMCHCzScplGvWnjc3rTwO/UdAfsPGG/DsWh688Vvp7ac/nCvYe18BHxH097Hfrf5BMs
 0CLGeAkZf90F/qsWkVkCUM7XaXmtdOnlpQUyAvtTEjwM8QoRAYkc3eSlwhCpjwfOr90V
 BwczYTb4gFErUcTmGenj3iWWAGCyln9ggv+Hm3eWK/G7w+S/8ZvhFR5CGXOPNvKXZkRP
 10hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792488146; x=1793092946;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/eEcWPK6Pio6spuR5ORyqexN6KUZMPcNofKsL7mshE0=;
 b=dkgU/qpqi6K6pWy4tqGFvI3Jeq9P0fbKOF5DdvEa+ROJsBWDJOECbxECt8iixLv/1R
 D4/7vsPuFPVn/t5MpbRP+SBso4t/wP9Y/6XCVvnyytXU7/EQZ+P6rnCWutwtK6Fav3Gt
 1k76o1ln7zOtPgT2sHJE+NDvvDdzw+BlZ2u8uaEXIsEcy71ua9joF1vmxrl2ZPNtjTVG
 0+4wS2c+UFXwnC8+dPsS+Yikw8KsRC3bydg+llruJTctXkCEvCDFCdE4XYV2ICFkRIYC
 XvcDfADL5FiVX97ni7sE7tQ+UnYYy/LnKQ9wxXweBCHYZws7hc4s946qppDYSUybOp6Z
 SghQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy39kj0Mx6w2Vt0PrahksUCAz83qwjGe+BeyNkEIVx28koPLMe5zfFGslGdxnJUsXU0Cn1T3TSD1UM5NbNh@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLZkDwhjy+f0fkCtFL/XOcVMbNYOXFRedfByfhtF+KAxsO8g4OI
 3cpCReCfwVwjZfoR0PvtYU0Cwxk6R1umIhBU8wJJCqrhRdT/nkvhthpZtJzyqyfgMdmRTlNWu+A
 vb7/duDTh7Wf7WodpYClgfHluvSUn/KU/Ef27LLbWu+7bIBt9M815jxCxGcsImNbdXMu7ZIw8nB
 5Sm+e/WQ==
X-Gm-Gg: AYBFou3BE8C8hO0CWdXOcpobh2Wrmfb125jj5jmp2C4BJt8lQ76TFOvmr7Ar5A/1UBN
 Gmc1ianV/NYLUbO7AW59AHRgTOtrniEy4qvDfNj+xTAi1LOWRQwMazJR9TUaz6OkY90BF8lmpOg
 GLa3LeLFwORqdjucJT/OdRXPUXaNMdLFBsxf7Ts+bPWecMW3ch/8Jyi+9+CIqp9fttGUVwOqBXZ
 yjfgUbmoMnPqgWHUdKykQVtNkKrRLRoHMy5gCVwcIdVffVZzpkD75XJIGUl0hd8eQ84APKEB4/5
 /rLfUqjo4Ajrmjm7DlkFjIxOTNLXFs6BQab1ZXV6zUYPw0BoaRvNnmyI1nLbj/eUPB5sw/zRvYL
 UzWgCAsK0kJAwt8jvFx7/zDk2fd3xiOe4bw1thLa0ag8+rQktXn9SQ+mLHhEeoE2e3QyQvD3mnL
 0yvjHD7q3v8h1aL9WTsb4DOgGIdfinNlTtJ9Vr2sFLn3M6fhEdMSnVxElqmnaTfaOxmsjdoodp1
 7B2mIup4uaXBB14ecUznCSmdiIRjHYU+C/UajcsnueidceH1QVL5Hb2VPIl4wp9yqq1n3c8gUB3
 Vsw9yKFlyqNgCg2MGgOp+hk9uelWIXP7UcsTwLAOGKiApnIStqHohUsRWji3mg==
X-Received: by 2002:a05:600c:6207:b0:4a1:e3e4:c438 with SMTP id
 5b1f17b1804b1-4a1e3e4c4efmr137982225e9.26.1792488145422; 
 Tue, 20 Oct 2026 02:22:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d6e2dbsm62159135e9.13.2026.10.20.02.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 02:22:25 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 20 Oct 2026 09:22:21 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I10326c787cd8149e7617279e45166073d66b9101
X-Gerrit-Change-Number: 1897
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1897?usp=email>
X-Gerrit-Commit: bcd5ef323aa524e5fc02aff083a743917b95fba0
X-Gerrit-Comment-Date: Tue, 20 Oct 2026 09:22:21 +0000
In-Reply-To: <gerrit.1788477047000.I10326c787cd8149e7617279e45166073d66b9101@gerrit.openvpn.net>
References: <gerrit.1788477047000.I10326c787cd8149e7617279e45166073d66b9101@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDc3MDQ3MDAwLkkxMDMyNmM3ODdjZDgxNDllNzYxNzI3OWU0NTE2NjA3M2Q2NmI5MTAxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3237e1063e86fb8d8237147f9c1f2a6da16b4ce8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xJ63E-0007cQ-DJ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_freebsd: don't
 destroy pre-existing interfaces on close
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8384501385223238993=="
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,MXG_THREAD_INDEX_BAD,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8384501385223238993==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="d2T4O33RiKw="; charset=UTF-8

--d2T4O33RiKw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Antonio Quartulli=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1897?usp=3Demail )

Change=
 subject: dco_freebsd: don't destroy pre-existing interfaces on close
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review-1

(1 comment)

File src/openvpn/dco_freebsd=2Ec:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1897/comment/4c8e43fb_434c9576?usp=3Demail :
P=
S1, Line 349: close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx)
`clo=
se_tun_dco()` doesn't appear to ever get called for FreeBSD=2E



-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1897?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I10326c787cd8149e7617279e4516=
6073d66b9101
Gerrit-Change-Number: 1897
Gerrit-PatchSet: 1
Gerrit-Owner: An=
tonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-A=
ttention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tu=
e, 20 Oct 2026 09:22:21 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Ye=
s

--d2T4O33RiKw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Antonio Quartulli=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1897?usp=3Demail=
">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_freebsd=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1897/comment/4c8e43fb_434c9576?usp=3Dem=
ail">Patch Set #1, Line 349:</a> <code style=3D"font-family:monospace,monos=
pace">close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx)</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">`=
close_tun_dco()` doesn&#39;t appear to ever get called for FreeBSD=2E</p></=
li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1897?usp=3Demail">change 1897</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1897?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: I10326c787cd8149e7617279e45166073d=
66b9101 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1897 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Anto=
nio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 20 Oct 2026 09:=
22:21 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></ht=
ml>
--d2T4O33RiKw=--


--===============8384501385223238993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8384501385223238993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8384501385223238993==--

