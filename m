Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63919606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ewsfZNDH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AO83zqg4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DGCnj1BQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LTNQJPJ3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IckxbtzXLalyB9mhSm5dlUdNLolAxklVI+tDP9sopOQ=; b=ewsfZNDH3Hzcp1CWF47/jjwYVn
	Jni3WTfrzfHGM41+Jnl6x+Mf4ODsuO2aWCjaye5D411TqeZMrDmo4RNGlrSNSzbrqtL7uI4bjNBVf
	LVQRGUACqmEz+GFiiySZ2kddgN9+SvBpxotVkgHNhzwQSGLhyxPFwCdrI5UakiX1VDFE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMBMq-000000008Nh-2SSg;
	Wed, 28 Oct 2026 21:39:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMBMk-000000008NX-0f1X
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 21:39:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JPz5aPyPxH7eAsAUZfN2TXXvzAKpbmLuynDwOdw3qfU=; b=AO83zqg4cmjwQdZ0fHr4nbwK25
 2GXlHjIDLc+7zzRvAjFnBHYsJKbvtMqjnzYObCmg2z85/5fG8vdd0gvurmcWytF1rVEaAlCgZbQhB
 bdlq+zBxaySwZ/lPkGNKAU30+6lmlCnjsSwHf0ONJdnesQqg+MG7rQ8r6qodqyf1XK70=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JPz5aPyPxH7eAsAUZfN2TXXvzAKpbmLuynDwOdw3qfU=; b=DGCnj1BQmBw1aUm7DGICu7u+4Q
 rqBsMSnjnGICc98yXZP15X9Zh5yAJRgWeHFaXomEKXk2nqC+Dz5RGxbTJGQiBFC2wysMOVZapl7LU
 3RPYkJvUlYADYRWJHLp8DVHQvYb/lLcYv8MGzJBffQ6yBLtN1Sa0ZK6+txucgfPMkTp8=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMBMj-000000005Ab-2IHQ for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 21:39:26 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso939158f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 14:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793223559; x=1793828359; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JPz5aPyPxH7eAsAUZfN2TXXvzAKpbmLuynDwOdw3qfU=;
 b=LTNQJPJ3VFnm1bW4m2MRpOXv2tZYbhnRFrMPfXWAl/Bav+k3G+ss60NT8r4cDE34YZ
 MgiR6Ox6kfgxQWu5c5V7fQF4QlCJmyt5M5MFuSxX5V8lXLI6KmUd9Ka/49MIHbiXPUw9
 r1wYoEzDXh7oEBcaaCyNuU29JHkyBgIyH5p3Nzcayv6I4MKUvBcxRxU96YTGtGRnMj8O
 gK76JsFule0rrfDyfwCdz64wsCZz7ln51XzEJWZrvtX0ZfZolTyJX9frQP+osy9YYPXk
 YkhMdwCEvT/Zb6M8CAviGOYemL4YLBXxCFvYBjkRlHsEh4lmhEW11rQb2nXxiV+9woDg
 Lxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793223559; x=1793828359;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JPz5aPyPxH7eAsAUZfN2TXXvzAKpbmLuynDwOdw3qfU=;
 b=Zmd7D/Bi63aJ7Lz4xN+wqkmS8m68425QIUUvqMlQxzdSQwttdLkSSr1SWaDx9rZyoc
 +SVH8XDVkGKufSte9ma4ERweYRKQlYyyYk67QLibxY6QBtv995Z36DwxOwEU2KnE5xQq
 N+xp7z+URXy8wcLcIS+cwdcvZslBrRuTEFWUS/Fp5/gg10JRpioLI4VfWuFe2SFb1xAc
 Xel9ElrUlEO0OzPlCeO9L9mu5ECy45YAl4G+v8tv3eOGdVJmbx/sFKWbiPHHT2ciQIMk
 TjBV2zeGDT3c1j6Lz4QHAzzFvCk6lppEoh50zzo2wiUag5+lBDcgJOaG12CAnxZ3gfmT
 uvyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOKJxlAaojY93PSBwU7Tyrm11O9cZpyiP6+oqfx5MSMJZezBaIz6ulN2Bto6P5u3upbcTAbBUeHFonKT3M@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLRbofQqi476x9iRrk42Gjl5L0cOujADo5vTkQi7RG/ecYgFAMX
 qdkLBEpSw7UELAgoKqYZFzknKIFi4XmnyU3tfKmaqwA84K23TMQYqZyWedff+wI2ITKDoHGkXnZ
 ukhQTarBD3nuvl3k+Vq+Oz4w464BDLDIP3P44mpf2dM11Fs0XML/cZxkcxC/iws1fQSoWeuRi12
 tGNQYwBg==
X-Gm-Gg: AYBFou0iKv670jXfElntICxn62cCkkLU6D6LCaTt44v0Q7lv0T6u1NylqYAUN0T8L1z
 WDA5kF3ekxCM6JJTd6g/wWAbGbVD1mLtxajBJfBSVLQMFGpWcygIno59zNrTWNgCtuGUJTmoHkb
 eUIdpbYSU6FrOVhZVTrcR5ug+i/pGiIO5IxWAq81AH6yd03puW0Wdbmz89777ns1YO2RjHpIcVs
 aAnIokhsGr+pX9HrjuMpDef1aKbCx1UCtxEB8C594W05zikPc5pG9ZQvLwhQBz5hoMW0q6N1V7l
 tjT7pQZV2MxLOQX0XN6p8aBaS6Mc98vKx/6aUsz19MF8oD7P2NsEFMZb/K+cICux5xa1lC83z+G
 6SQNegkK1ZH44urVyoSBd0UfwPN+np2h8nIghVY5L4mhAWl3jEDCQogrh95lcforQY6zN7jmDTw
 cb4wgTVL6E0V+fhyn/FmcpbwHw0tC/UwfZJqMv4FaK5CuSZxjb2I+UlNQXqbg0hZK6VtESUydhr
 SBHjtOwUVunygAWBWthrGooo0EYDqFPetGJZi+9Xq+0FgTg0coG+tr6naA9eKUJAwfUESttCAuZ
 QjKK4QEukin8srs9GeBAhzkvUxHYenpmdWnIL7D8Adoh5Cf+ekJ3zyFXIa3Kai0zLjWih+8g7OM
 faiKDPRdWHTX4GwGGX/GIo4CdXAUFdxwoymIkNeN4viIpxjp12KoUr9fkuyuconNpoMNRqSnlUf
 Lb2aX2rQMScpPvMR1G0vzqKUATBt1b5A7qzXDk
X-Received: by 2002:a05:600c:3e8c:b0:4a3:59c9:a750 with SMTP id
 5b1f17b1804b1-4a965dd3285mr81566195e9.9.1793223558872; 
 Wed, 28 Oct 2026 14:39:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94f05f168sm55848575e9.4.2026.10.28.14.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 14:39:17 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 21:39:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 3f0211e80590dc0a4b7a4b972877b12fc58deaed
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 21:39:15 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5837f9cfbd91f6b405c85e43af5c3be7658e1c47-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xMBMj-000000005Ab-2IHQ
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 chugly <charlie.vigue@openvpn.com>
Content-Type: multipart/mixed; boundary="===============0642072581349239020=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0642072581349239020==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AkEQbmPE8us="; charset=UTF-8

--AkEQbmPE8us=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

A=
rne Schwabe has posted comments on this change by Arne Schwabe=2E ( https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subject: Imp=
lement sending/receiving app custom control protocol messages
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 19:

(1 commen=
t)

File src/openvpn/acc=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
858/comment/50ef7d53_f67c201b?usp=3Demail :
PS18, Line 206:     if (!payloa=
d_len_str || !((payload_len =3D atoi(payload_len_str))))
> I don't really f=
eel atoi_constraint really fits here since it comes with own logging and we=
 don't re [=E2=80=A6]
On the other hand the double error message for a case=
 that should never happen with a well behaved peer is probably nothing to w=
orry about=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1858?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a=
6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-Pa=
tchSet: 19
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <charlie=2Evigue=
@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date:=
 Wed, 28 Oct 2026 21:39:15 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels:=
 No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Comme=
nt-In-Reply-To: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--AkEQbmPE8us=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Arne Schwa=
be has posted comments on this change by Arne Schwabe=2E</p><p><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Change</a>=
</p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/acc=2Ec:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1858/comment/50ef7d53_f67c201b?usp=3Demail">Patch Set #18, Line=
 206:</a> <code style=3D"font-family:monospace,monospace">    if (!payload_=
len_str || !((payload_len =3D atoi(payload_len_str))))</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">I don&#39;t really feel atoi_constraint really fits here since it comes w=
ith own logging and we don&#39;t re [=E2=80=A6]</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">On the oth=
er hand the double error message for a case that should never happen with a=
 well behaved peer is probably nothing to worry about=2E</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1858?usp=3Demail">change 1858</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1858 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 19 </div>
<div style=3D"display:none"=
> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 28 Oct =
2026 21:39:15 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments:=
 Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div =
style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-T=
o: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--AkEQbmPE8us=--


--===============0642072581349239020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0642072581349239020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0642072581349239020==--

