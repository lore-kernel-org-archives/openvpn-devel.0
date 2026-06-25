Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD878CDE000
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ga2DRicNLi279cPJG6yn2IMCevL1hCLEgs2rlUE0vo=; b=hQn7vNkF+t0Vc2ShNoIbVljxV2
	Q16LTUMhZR1h6Z/ILYDK/lE9LG6U7uCjFqLMkN957V326bl3OOXTDxu5hukwv5Fqx/k8z0MDhokCJ
	61pB/KWoZvR/eW5vLA/kkxvyAmksj7rFL3q5nN8n7Acqqw6S+1F3viiiH1BIroR0PBsU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcjHZ-000398-KZ;
	Thu, 25 Jun 2026 12:34:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wcjHH-00038T-LU
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 12:33:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UVg+C0nJjInPXN/6lvGRnPBEynhmvb+lpczOcDFwMhA=; b=GrAi4tS4g64tXmTDK3f0xHyFRk
 3yFWoYl/LlifeE960pGcjswSukl1hyNwQpBYj/P50Qbm5bh2IgaX2kBclpptVQGl5BT68V3/KOP12
 gsAIcsPNBYnTx2QQQ5a2PwbKqbfuzL9O9fD92xcecXdxWwANAWY9zKJCL/4tuy2+hFkk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UVg+C0nJjInPXN/6lvGRnPBEynhmvb+lpczOcDFwMhA=; b=b
 ywtkG5tLQ2zLnFFveVfQW4j/HNcK+awQbfrIhKXEeQ0Ajg0jCW0jyY6mqdrYlI7lt2c3JMn+OpHuQ
 o8zuYK1VG7OOXQ7BTKiQ6JnZO7+Ii8FIrZgLzV9O4yJLc5Xon2kJP/CnAaD/Li/qlR/duD6RWpUSM
 DEzztY1NK1uz75Z4=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcjHD-0006gR-St for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 12:33:53 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-46cdcec58c2so464719f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 05:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782390821; x=1782995621; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UVg+C0nJjInPXN/6lvGRnPBEynhmvb+lpczOcDFwMhA=;
 b=Kd7ypKV1b3/sGa2GO9R0U+M2Oe4U81Tz9XL/SC0XW5GsvLGvlGo7DfMEdYl3YtEq4S
 jW/zYVMhjftp31vUn1b2o4h4S0nllVKXsG6h0hIKdbwShwnPc714G2gNclrUf2WPU2SS
 fEh9NxOBJ2QF5GzE2L6v8Blu5Ft/hCWhVLcYLQYwElmuFiobo2jU6tFD4Uid55VUYID+
 Fcc6DPBcOHpVRyMzOHiKj2VXwqIL7xUiZxEXjSIyc2hbKPYoEF3yI+rqGioa/r0yFIi3
 ozEGTi3wzd3GKMvJqPrskbKgR4RmdQtduENGq2MUEflqC/cG7hEN0c50lhkOv7xCucuM
 KNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782390821; x=1782995621;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UVg+C0nJjInPXN/6lvGRnPBEynhmvb+lpczOcDFwMhA=;
 b=UN4wtk/ZxudWelFygGMpmitwS3akIus/hBU/3oAHPF20Gn5xb6WIkuTKi6DDR62VTG
 ldWxeuTOgZgHgnf1ID/26nIrpjQFUCyfXKFWLArWGbvuv2864fX4Ce8WyLmGlc5+GR81
 3YfRtFm0Mo4djxxwSALKJg/KCqu0epKzx3MVa/VxgL7jRCAkp6oFGA0jgJOmT4N/wqw5
 OHdFXHY2jnwLOsM/QaDxPJc5Ei16SS8jeZrsF8Vh6EWqkJsvPr5I7ovz9Dp0nx3IGRDj
 lSi1OnOxECWYfLgE5MPXm1HwS9gH8pbEV4AnTlOCMOWouumBFZQBtgyDZyuqKBFHS+r7
 2Jng==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLrwBYbRIk7GJ53bjMxy2k7G5llZPqEZED2T1irimf8m9IYIpAA+ccOfWEdmqmCm9GdISxPB0G2OkmnRMz@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxWxAaDswfDF0NHLZ6ygkmXzV2uALDrNFld37O6ST6NJsRR/k+g
 j4U+GZvzuQYiuMD/y58ye+wHxBCiyrnP0WsnTpfImz5pHMShe5Jx3eGefoCUzlLH/7LT6Un43D2
 U9XyJuqEwJohn2w77OlFNWN4KGmSeHsuypR6bMF3mKH8av9fY6inkaQZ+bCnKXNXUXO+1n6yLrh
 egGMNjpw==
X-Gm-Gg: AfdE7ck1st+uK93vy+SvWp29TlePogQm9D5QtBtsQX+/8u+VGlW3jOSSvQlg4yrA5cH
 6LJ3xsVp6V49Zdjhloh0HkRYAJZ/7QNjuME8UEhRjgALxTpK2KwLJMTQpAE2E+3TCPkP+5ytH+6
 YrXUG5Ip+lyYL1nm4yRxF5phrDaR8htCypdWFy72eRoWmpu7m/ocXZoYH+RTtY4FwEEKyFMG2EF
 jgj4dgpYwZ5tCfps1WfdUyDCgvLGhhqJattpH+hN6iuJIMy50onR74JyibSH6eqcekfoMT4daGm
 wB/oqlVTbRk42OAPnHIjNPozL3MbLIFeYUkoDyTpdbs3H/PVG4dfSb/Mj97KE149w7TqzlgUAFK
 MS8y/NVqPvr/vA+c1c2LQ+Q2ZZKDC1NnFDZEbX6gGrDgpjH9X8p20Y1fvH2dlEWyeUmWUQ746vg
 vr6cpzjj9B4LlQ7jXKGEA8N9R4AsP0jdckKir7/fzyNDXJt3c6G41dPk4+myotLJfq8CRKE1uXh
 dgj3q8USXVGMGI9gScJyhBYhGE9IXyoA51FtTo3xcp1BIscM40KqsHIzxEs0KavCkr4VYX16zqO
 mBs=
X-Received: by 2002:a5d:4577:0:b0:463:6211:db6f with SMTP id
 ffacd0b85a97d-46a806bc976mr13687890f8f.19.1782390820713; 
 Thu, 25 Jun 2026 05:33:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46d86960983sm6965795f8f.4.2026.06.25.05.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 05:33:40 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 12:33:38 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: 6157655f2875cb95875b2fc9181c2c596c9e1780
X-Gerrit-Comment-Date: Thu, 25 Jun 2026 12:33:38 +0000
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <027d22aad7c2e9e9e28d09da5cb4510cbeefe76f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wcjHD-0006gR-St
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Replace custom
 hash_func with siphash
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6768758155801352756=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6768758155801352756==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nSsJUu9k/v8="; charset=UTF-8

--nSsJUu9k/v8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1573?usp=3Demail )

Change subject: Replace custom hash_func with=
 siphash
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 5:

(1 comment)

File src/openvpn/siphash=2Ec:

http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1573/comment/dde83c0f_316cae27?usp=3Demail :
PS5, Lin=
e 46:     if (siphash_cryptolib_available(ctx) && false)
> Debugging leftov=
er?
yes



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/157=
3?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I807f398903=
ac2047530800c29949793c6f4f0ec9
Gerrit-Change-Number: 1573
Gerrit-PatchSet: =
5
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-Comment-Date: Thu, 25 Jun 2026 12:33:38 +0000
Gerrit-HasCo=
mments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@=
lichtenheld=2Ecom>

--nSsJUu9k/v8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/siphash=2Ec:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573=
/comment/dde83c0f_316cae27?usp=3Demail">Patch Set #5, Line 46:</a> <code st=
yle=3D"font-family:monospace,monospace">    if (siphash_cryptolib_available=
(ctx) &amp;&amp; false)</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">Debugging leftover?</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">yes</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail">change 1573</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I807f398903ac20475=
30800c29949793c6f4f0ec9 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1573 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Thu, 25 Jun 2026 12:33:38 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>

</body></html>
--nSsJUu9k/v8=--


--===============6768758155801352756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6768758155801352756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6768758155801352756==--

