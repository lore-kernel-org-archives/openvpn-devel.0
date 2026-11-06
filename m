Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0240B606A32D
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eavf2iZS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EscD6OoB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=d3TNYTdT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QT/3oaRb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=h0LXk5TqyarjTLRQV/Cf6U5c1+qExjD9rGdNwMsDPTc=; b=eavf2iZSvLzqweWmi4mzDueYFS
	GYgkMTjjTXspBxGwvANMquwoP/IqJ7IpXwsUPc+JLq0hGO7duYaz1IKT6xeuKRCPuE3vfFCU3Lngj
	oYj4EnO8AC8TNeFr7uWKnuX+CETNj7AppM9NQezxF46/FUcCxEvJbLnK8xb4/CMvrTQw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPKqK-0000000082e-1Ctl;
	Fri, 06 Nov 2026 14:23:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPKqI-0000000082Y-3Y4D
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:22:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xAicnOXLZ6ENZf7iWvq64XYLYXjDJJEIaD8YJXoiJhs=; b=EscD6OoB5/uCHmqBaq0CwdXj99
 zvO8sl9uXoJgNDWuUZN18lUkyiZ4bsmsM6ZEancxFGEB5Im9DXfzppOQKH9VpExxdHem50XsCoFDM
 nn0oJ4OivjZ0KM6mV61yZUO74yPZ/iJDuFjeNcEt3uA+Ld2Z58PsqkSYHA8ZRyem3FFc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xAicnOXLZ6ENZf7iWvq64XYLYXjDJJEIaD8YJXoiJhs=; b=d3TNYTdTl2NM6QbtskzpsyipW6
 hAJmkVv9ut5PAJhkOILGbhwK8Y+EzcbQ0DPVk/cbr5+g+6W3kstS5+RvQTymioClQr/FYW/D0U7s/
 9R1E+MmcWleazteGRKeZzjg+D4ZSdeeTd2dM+OLVwOvZNtO9yr8IDpfB7tTnORYE/6Ac=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPKqI-0000000082R-0I87 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:22:58 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so6481305e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 06:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793974971; x=1794579771; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xAicnOXLZ6ENZf7iWvq64XYLYXjDJJEIaD8YJXoiJhs=;
 b=QT/3oaRbY0BVD8eyWTY2ucr3A3VJGFBo8Ad5DmTsWn15uxLltP8vynkx86bG9JGwRc
 cfUmG1iI9oJp4YfdY6mBAINPtHkVI7TX79QjnWfXN7KdecTVQkkyD2Jm/NsYfWqVtA5m
 08rT5JkZkdHeLxC6TvvkS0Fj0nVQnP/hTG2lND8iP6jB3Qn6iLhaQVWiDxREkgpCQmZ0
 3L32smlbifArRATYzIgmqK9Gjx264NtCoI99hcFIpr7tL+AUkq4NeiDmPkc4fnJdEHbo
 2dcfDOVHiq0/llRxBSwR4JVsUcU7muFBgJorBmC0nMETu9NijJdvuBOjMPd1j4SJtdjZ
 CEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793974971; x=1794579771;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xAicnOXLZ6ENZf7iWvq64XYLYXjDJJEIaD8YJXoiJhs=;
 b=QN3xPBy9zpXEmtvZ1CwySLNUXdk2Cz+SqKylcPQnz2Ma/OCy5gNRaaRLjTvsNWQY83
 6oB3OP8Qlqq/IUcaQ/g+bbBgYy5RSZ8QU2rRVC6Ze6pJ4XEUHsKCIZPfVhgP9nJSyRL+
 m5qIPDeUBKL33bPYPjXpkJS4GMVj3x0No8lVoYE3DI3ejUoWjSvPe+dPSA4mS/spDsFD
 Oi6Ec5l4qpyYfDdKxR1yBX+LyQ4/FpleTfC9s9Vo9ISoPDvRh60FlnW6G3XrQVQpQn0J
 9DvSEyAp4oi94qNDOq56SCplg1+0p3xtLnIVOhnIWQo1/tOFMZPrhqm3kalnYE5hRYly
 rXaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFAZb1u3m1x091DOyU8cd7iyZtUUnBEyAQtdYKmwi0sZ1Ybi//psI3aBlRiysmSjnDm9gE4tMB3diu6djG@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/l3YRUn71va+/tACo+O20x/pgI0BhRXU+rpMcNbk502FdFZex9
 gb0k8Wulh1U46jEhUeECnAOlfRIKXNUR3fYj9W/zOzDsJYjHiEFTOZVBzAMj75x7ZewDMmNllWH
 o2Lyhq2nL1ohdXrvdhNC2idsaxeH6Yfu0aqar5AZbIvMrJWaiATXUY9pcRQmmzsfzutgvZb6Cty
 Lt/H4e2Q==
X-Gm-Gg: AYBFou3tFfAzED7eCPXPQc2c2ILAmN+AxZyILf5WU4i8KGCKLcmG19nzbQUk3o2VL2t
 fPBB/raT8EYD6iK/fiBsCW8RYRYhCPK83lcredAfWvUE8AyNpM53QKfd4lNUPLpV7h2AYFF1g5j
 Jc5Z2MszxWiRODwvvxtdx+EqtlsXZAnxOB6t5/es9l6Y6oBwt1c74yUGABtfRtZl2wYu0R7cNiv
 0RPL0a+GOR6vCalR40zie5qpSzSXLNGH4S8xcxxddp6IMX6qxanYE5pcSFjAp1b1HcwCO2JTiM0
 6yCmXpTcTxXoV3PaGoytyB0WKroB1JfI06fuCEK5NXy1PEDXsk6Zb/3667/evWOsK7D6fcbICWT
 ndOR82CaR3oOBovKmu3X2XYlSXF+o/rcDC8SLElTn0NiIhygPduqM4cSmheTl7KT8l/rwDAzAC2
 g43KtRIxzkAxiJQY9GnoTE6UymTG+qw+hi4+P1NKu3DqSiSJhzJnFOZfRbGNnrsl9/EO3i5es8l
 nZ10ibQREQVT1NqJaVAiRTDBl0pBzadSTff8K9ZeFhVanmYZN8r+uRjTspYk9Gkmh84llm9iBSS
 KnrV7VOOe8AVB4E6hVf6mtLIibUI1U0RVdK5c2NMviVOSEVGKHR4ZzHFmvqSeRT9lMdbzNjPVAT
 neQ/rGgMicYf0oyZnTQeabjGx0hfQg47/IaPndBUbQYzV7dO4gFwlm8TRkCK+laoh57uttmQnx9
 Q4d+A6TWJ0tE5ruw==
X-Received: by 2002:a05:600c:a5a5:b0:4b6:2396:7953 with SMTP id
 5b1f17b1804b1-4b623967c52mr60623475e9.3.1793974971399; 
 Fri, 06 Nov 2026 06:22:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d3d6085asm5598609f8f.3.2026.11.06.06.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 06:22:51 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 14:22:48 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: cdbf85ced0fbcfffe1527f249ed44aeae5f048d4
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 14:22:48 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b0f60f075c570306fa3eb4989613b2c0cb383462-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPKqI-0000000082R-0I87
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
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
 lstipakov@gmail.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9081923294593408365=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9081923294593408365==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="v0uqctKKxK4="; charset=UTF-8

--v0uqctKKxK4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, Lev Stipakov=2E

A=
rne Schwabe has posted comments on this change by Lev Stipakov=2E ( https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail )

Change subject: con=
trol_msg: Add a shared TLV codec and use it for early negotiation
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Rev=
iew-2

(1 comment)

File src/openvpn/ssl=2Ec:

https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1965/comment/8b8af8be_b86cc235?usp=3Demail :
PS3, Line 2665:=
                 }
> Removing the break would change the existing behavior=
=2E [=E2=80=A6]
Carrying this as extra special case that behaves different =
forever for no good reason other than compability with non-existing impleme=
ntation that might behave different does not sound very convincing to me=2E=




-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89c3133e009dc7=
5dc2c10c607b3f0a24c04e8146
Gerrit-Change-Number: 1965
Gerrit-PatchSet: 5
Ge=
rrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 06 Nov =
2026 14:22:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-=
In-Reply-To: Lev Stipakov <lstipakov@gmail=2Ecom>
Comment-In-Reply-To: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>

--v0uqctKKxK4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Lev Stipakov=2E </p>
<p>Arne Schwa=
be has posted comments on this change by Lev Stipakov=2E</p><p>Patch set 5:=
<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pa=
dding: 4px;background-color: #ffd4d4;">Code-Review -2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1965/comment/8b8af8be_b86cc235?usp=3Demail">Patch Set #3=
, Line 2665:</a> <code style=3D"font-family:monospace,monospace">          =
      }</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">Removing the break would change the existing =
behavior=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Carrying this as extra special cas=
e that behaves different forever for no good reason other than compability =
with non-existing implementation that might behave different does not sound=
 very convincing to me=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">change 196=
5</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8=
9c3133e009dc75dc2c10c607b3f0a24c04e8146 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1965 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;=
lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@g=
mail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Fri, 06 Nov 2026 14:22:48 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-R=
eply-To: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Comment-In-Reply-To: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>

</body></html>
--v0uqctKKxK4=--


--===============9081923294593408365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9081923294593408365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9081923294593408365==--

