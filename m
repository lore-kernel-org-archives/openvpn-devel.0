Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7B6606A31E
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZmJQe7iD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SFXLij7Z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cr33rPvw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RK7c1kTv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rTOh/iIVT660hmrDccPzumRXRqu+8xOJhFHVvX88dtA=; b=ZmJQe7iDXLW1sHGgoK5+NhyP+t
	mvVbL7g3ZaCumiEsYhc0flnh5ZLk1xAsHW2me0Vg6rX12rUginMvbSjuNUundpd3kVC3GyrXq4bUF
	fkCxHh++Hg1oopS+iweKwG5wVKrFdk+H9vymSFFbg83z9m/0NWHk6EYYGf3Sz0mZHAH4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVTgi-000000006nf-34PY;
	Mon, 23 Nov 2026 13:02:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVTgQ-000000006nO-33of
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 13:02:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KP1WOGiWAGm2QdibQcUQ3nAILDMiWoFf897KmxOThNQ=; b=SFXLij7Z4x6DHBdfY645La6d0M
 AM1usX93Q1FkoUcD5PnN7Ua7qlVKGLDESEgNwmt8vE5gVpa0E3gyhlTZO0EsxfDeeRxuiuCW6rW4/
 ulcp2XQm0mdD+H98GuKLBfkPS1UbKcWg0lJu8h95b5cl/J4I5eQsDgSX5wXSHqiLslIg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KP1WOGiWAGm2QdibQcUQ3nAILDMiWoFf897KmxOThNQ=; b=cr33rPvwpbdmej801hIRD7VzFZ
 Mn5E59zmK3+ODUYG8trt028/mIvXDBE+F6jpoujS+BhXt00Hi95ewGcWfCaDwzK+zw5OeoeveKMcG
 Ts0H3FlRyo6anhNCl5iHlmR2hosMxeJgnAULvge0qWc/KMOL4ln2qwmrfhPr+KaT+QlM=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVTgP-000000001eZ-1HXF for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 13:02:10 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so22054445e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 05:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795438923; x=1796043723; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KP1WOGiWAGm2QdibQcUQ3nAILDMiWoFf897KmxOThNQ=;
 b=RK7c1kTv7Hdi5ulI2x95v5th8n9Fvl9fGX5Qy4RabefUssWINGxMmLAOOuEI6kPJDf
 OQi1jvKjgM8j89c6shznC1MdpDtds1b9FLsPvcukWN75DDFW8+Z7RjoYfD2pyrEoL/qw
 cbGU/nXE2luIF/UKftc4i0CT2FMewQOAoA6vJCcrXMQSLeJiM9m7C/esHA8U2w7g48LX
 7v60xjOGL8VB2nAjRdxar/e/KJ2whReUmvAPbp0Fm81PIq5NPsmVcyFb9O21WEFZahUo
 UNHTbEqpybufjH6lE16W0UUKKolO1Iw2hE7mskvKXxg+FzQvZ8ESVQeOAZbo2+KLmgeJ
 dHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795438923; x=1796043723;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KP1WOGiWAGm2QdibQcUQ3nAILDMiWoFf897KmxOThNQ=;
 b=HibGGphK5teXfAT8buVBfsnZx3plD2Cn18xaH/le3HO9Iczqf0R3IO+OzDepvx3nwJ
 8wEQ3mw/tdthmRJjeZ0x2Vp9PJSyfHWscibHcqCXYScV35cxPmq1nqqUN7iJirHerXyp
 lchqi3Io/6xQrLzCnDPojdlhSbHKJvnx2sz9PMbPjn3C1m5Itw4dCGB8ZJL/EXeaKBz0
 QtQJd6iHgF0xH8ATr2HB0wUJMFS8avcuGF9kbXDEy/nrNyT7y8Oaotqexp1g0Ash2fFn
 6AfbBMXkB0tPLk7LjGFDaOiCoTmGXcf8wNOOE/r2BNc+Qfm8hNPilZ1s6cApaohgdjSs
 gFFA==
X-Forwarded-Encrypted: i=1;
 AL+hErEFHMUAiTUSnrBgNl/t73ocWNLty5nug3+EPcOUUzyOx2XX/SDcxbW99Duv4x2NYTWLyAqk8k+GgOocUSci@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8lnvP61WqwYig0OYtAR1vL2D4DAunOVJ6xV1lvPWJwQl9FcsRF
 1ajS4maFotEJSN10vKDnmhocrcjLqkcfmO7jTfEtO/iEI1yQiycLyvkx8CU+dNq/t0KsggpCubx
 a7Uj7Go+TZiH9pSSJPhGE4P+32qeZagrdoTPVORzrhche/8cuy66/4CLQJUooqKOXIuku
X-Gm-Gg: AZFdTZcowa0Je8p3nRGcQqDyTKod3F1YovDMNWBe4AkkhUir8N1uOUpcKHH662GeJdp
 6i2hNf5ZBEsp5gns0wERGxvSF9qGw8wqTmpDHWDNSPVygT/z/0nk250U/W1mxg5U7tW4KbxPcWR
 E0BI9eXxJLGXeLA5Ah9OvFjA3gBIWJwmTNxyR5BBAzWIQBRjAfCIpcqzh1oOPaOT8LJCuGQXD/2
 sKRmDMdVPPZstDBv/cwJLMI7BL8u1uIUsrJq5ATjDSNXKCx13pXwgb0ziXrEJCvynAtn3YP6jzg
 1Sx2CSOh64y7S7ipwbVP6gI0TO6lZjPzkWObDeZAGbbZVMA1uUA2qrK3aKgV8fiCc9k9k9zkKZQ
 DjxHss/3M2X0U0ngyJkCmU1mMIuTmaK3WavREZWN25oYgnxg6MSwj8feQ7iuiezgKx1wWqbsajx
 sBfsAuewrgra419dr1OLaG85ZBDT09pU1j5XPy0J0fi9zBzKwiIH5supNjhFHe7PPx/suIJ0GAm
 Mj5dFJ/epdibA68TGU5zANMGs+oBOEwNqYJibfXnakjkvcYE63UqEzmbfWFvvPuTZl6Hpl/SJW1
 RLfmIH3I6hnwrNn49zmJgexoji76vWFBN+BojgNO0l/F58+nCU/2uLTAcc9Fu/npAZcl+2yW0tq
 OEHP/rZMdAacyhjyllM23i8YFi81vfqCNIP80MtPk3Nrt9plZSz+KoKPmBA37NyjlKItvsjWC7+
 LEXR5SRuUu5MlKH74=
X-Received: by 2002:a05:600c:b85:b0:4a1:f720:74cd with SMTP id
 5b1f17b1804b1-4bb8892ca5amr237343815e9.24.1795438921232; 
 Mon, 23 Nov 2026 05:02:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442693sm302281335e9.1.2026.11.23.05.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 05:02:00 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 13:01:59 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I48d315a38a653aed4b33d3277433cb8a6596942d
X-Gerrit-Change-Number: 2237
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2237?usp=email>
X-Gerrit-Commit: 860f760f1962644034e176ca1f0fc743c89a2a0b
X-Gerrit-Comment-Date: Mon, 23 Nov 2026 13:01:59 +0000
In-Reply-To: <gerrit.1795250594000.I48d315a38a653aed4b33d3277433cb8a6596942d@gerrit.openvpn.net>
References: <gerrit.1795250594000.I48d315a38a653aed4b33d3277433cb8a6596942d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjUwNTk0MDAwLkk0OGQzMTVhMzhhNjUzYWVkNGIzM2QzMjc3NDMzY2I4YTY1OTY5NDJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1e3b50c257d900b3266a863a408a63bcaae13715-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xVTgP-000000001eZ-1HXF
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: free
 ext_cert_input in man_connection_close()
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5462635008112525558=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5462635008112525558==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l9is9egnuuk="; charset=UTF-8

--l9is9egnuuk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237?usp=3Demail )

Cha=
nge subject: manage: free ext_cert_input in man_connection_close()
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 c=
omment)

File src/openvpn/manage=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2237/comment/aa29eb9e_07a7c816?usp=3Demail :
PS1, Line 2863:     in_=
extra_reset(&man->connection, IER_RESET);
> Can we change this to "mc" so t=
he code is consistent?
Done



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2237?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I48d315a38a653aed4b33d3277433cb8a6596942d
Gerrit-Change-Number:=
 2237
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 23 Nov 2026 13:01:59 +0000
Gerr=
it-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Frank Lichte=
nheld <frank@lichtenheld=2Ecom>

--l9is9egnuuk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage=2Ec:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2237/comment/aa29eb9e_07a7c816?usp=3Demail">P=
atch Set #1, Line 2863:</a> <code style=3D"font-family:monospace,monospace"=
>    in_extra_reset(&amp;man-&gt;connection, IER_RESET);</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">Can we change this to &quot;mc&quot; so the code is consistent?</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237?usp=3Demail">change 2237</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I48d315a38a653=
aed4b33d3277433cb8a6596942d </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 2237 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mo=
n, 23 Nov 2026 13:01:59 +0000 </div>
<div style=3D"display:none"> Gerrit-Ha=
sComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </=
div>
<div style=3D"display:none"> Comment-In-Reply-To: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--l9is9egnuuk=--


--===============5462635008112525558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5462635008112525558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5462635008112525558==--

