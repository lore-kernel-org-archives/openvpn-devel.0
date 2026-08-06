Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2424BC55ABF
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 13:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P0n0UHybyP8VY6uTWm55bXDkNPQEygyCXUHTBGRrE6k=; b=K9AY/SEDpnLOg47qbMjukuK/da
	5Yal+oPelZSSqbmRs276+MLCU1jQURr58lyh6suk/kjFMtmgJ74v+mxoR/OTJLYxnRQTkNLn0HuCV
	BorwYnY8AgIxPzdjxElTFcyf7F9OELGPzRmP8VIdFBhCWWnfnaGMkbIXITnGhQyHB8rU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrxy1-0001bw-Dk;
	Thu, 06 Aug 2026 13:17:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrxxp-0001af-C7
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 13:16:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YJhcv1ysZI5NjPbXUi6DvT3RCufagQ000R+H/VCQyOs=; b=UWZa8m5FuJGjWlq7OdTfWxCwss
 43W633BeeWTig6lccJPvYJ93v/w+zscXI5+pOF0chHbt2hZM+l+mVbWdbX2paIvsV55SjdyItFGkS
 +cE0+6yaWPA+axnup2DJ7F0q/F2w2IsdZjhYz/5o5va5mbmKfh2itQezjPEMmWlSjpQA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YJhcv1ysZI5NjPbXUi6DvT3RCufagQ000R+H/VCQyOs=; b=n
 TsJbrMjOV9SDfK8tcIx/bQuB/a4Yyo34esyf1zY/JsOngY9YuqbAyvP0ZPXQnquTW935ZQs5/oSPa
 e4841Yb8fk+rE67keqaivI7kNsYLqtfmcpqP9sl0FVBgS+Mjwx3657J/eTt6//Ar6D9JqAm7xrzSK
 sn3frrzR+5xiO9UM=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrxxf-0001dy-BP for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 13:16:42 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47fecbbafdaso679980f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 06:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786022193; x=1786626993; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YJhcv1ysZI5NjPbXUi6DvT3RCufagQ000R+H/VCQyOs=;
 b=Ny146ESIKcMxZG+p75W4qd9UdEFyB0NPw6Y7emWDWiGYjkB2Zv/JeFciSYuKFilBuT
 llf045GV/1CP7l/D9OoPxTJr9uzE6F5Z4MlqdlfD5PCSALWmqVz8hQ4DhC5QlGimH+x8
 EdY3azgOioe0nEqFIRQz6nz7nxNhQLM0gKf3GM9/1AFs6J2b2/TcMl7D0dth7fzlEThM
 Zb30nrHz9cnWd3u+2TPz2uWawMY6wf6MRmLbQ7VRiU4wHW8bTlH3wcEXm1sOgBxAKvTB
 CjjV6DA9ZcJJ80YxRlc4RiDNG87IlfsgUdI16iLUXSxmusXdYZeME6c26ljcJEr8tnbm
 mMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786022193; x=1786626993;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YJhcv1ysZI5NjPbXUi6DvT3RCufagQ000R+H/VCQyOs=;
 b=qXJ+XqUgQ9+bF7vwMaFzqG8NN6FbL9BDpO6pv3ZzjSyfJ1gUOqCHR8Ray8g6qe7C/u
 uSSabjTFtCFXgzQt3aGtINU9nau0lGm7M4D75/30zef+xpZamaQsGazuxBIDKTdy4p4P
 JwJ9gqF8vRbvleZcND24/z+gEdAzk1ZV3EzMwEjxopszffWlD/CUvl6qCjqlPH8NpgsO
 6g/9eakU7Od4cF7vMyooNiDktm9tPjkNfn6UOWPi8lE9FE9F81SdU9MePEGlEoILpOLX
 5c3srA62yOBfLH8M4/HMV+vZCqj6CaNjW+vKZizeszivicoHoee3JOIFc+O+irVtDdUC
 m0uQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcSUtBZrJ8Hg8BdFpZp/neaYEtWSfyvXUIBvvNxuU11AFz3pxigzodUp6hjKEm69p583lHnWuw57axsDeV@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy3xNS8vwd23kjMUl1YSMvjMMUz8LuUUVqnSkCUve7w/rOq/9Zp
 8FkreaYcjC6gqoeq4o2cVbRmKVy4s0kWJljlr57s0DF/6Nkeas5Bn/A/qMV49/arFYLMsHxpFH3
 /Kd7DJZsZgzt+RGs2UieqRM+RGm0la8/ufj1CqLYoqKSqHe/du4wyy5EkNo1FGHArE+Q0
X-Gm-Gg: AR+sD13Q83vtmg/cEmsLDfZzUvY/kSRG2j8aPCdnTaOuF575Zw9z3HIxPSZ2kOQcKTj
 BVjxTuTY63MCGQw4KL3n69L9wE0oWvKnyERE01Guvoije+Kn8f7871BbqNs4FlnGRoAs2wTa+cL
 1KS53uibtH2TeihLwNuRrSDHQRm1/cZgM6uV2b0Ct6aGp269ALewyOXiHRzXPq3cD70vU2/C45q
 IH7AlmzMsfGy9E2uvlNmdrYelkwNbTasc5cO8myQskfl6U3QU3WuG7nMBVODskJuvKWUFV8dEw6
 mUVCyRRjdkEdJO3IQsFA+aevVOz5hb6YLrYHnzeNKLVKf5Z/q7ygRfMim+zwUCRmo8TGSJ5GsYA
 qisF7lGSJGBFLbP0f9zVZUUUzry9jm7DhZGimpYseyOCmBSbcq1tCCR0jJqOZQZkoZP/Uw4d5zR
 GncoqkLXwfAqmKQYa08prXIzTwHzmX3xYDLbxL9RGyAcmTqZYqryF3zJjQohKoXHz68oag0KtEl
 Y/aWNMvObTlzonGVABo45vC4w9R6AqEidPO50f6uOYXF+1ALdW7+NYaMTCQLq6DOfe2BIg3oc3Q
 04CZcg/D3ilFmMZA6E5hwXI9FvOnFIrx1rZDqiBjoAFj5nkWUCQ=
X-Received: by 2002:a05:6000:1a88:b0:47d:ea8a:d224 with SMTP id
 ffacd0b85a97d-47fec62e439mr23506614f8f.23.1786022192612; 
 Thu, 06 Aug 2026 06:16:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b3279dsm5843242f8f.36.2026.08.06.06.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 06:16:32 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 13:16:30 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
X-Gerrit-Change-Number: 1835
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1835?usp=email>
X-Gerrit-Commit: 031918103f2e8e2063368d0e347a72ae8b95ea1c
X-Gerrit-Comment-Date: Thu, 6 Aug 2026 13:16:30 +0000
In-Reply-To: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
References: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkk1NjRlZGM2ZTBjYzE3OWMyYjhiNWRkZWY1ZTgwODM4OTQ5ZmU5ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <71b8cbc7dce51d6de59258059b3ef3d395dd78a4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrxxf-0001dy-BP
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: do not exit the
 process when installing a DCO key fails
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
 antonio@mandelbit.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2184477986767602371=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2184477986767602371==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2zJZJdVWTLU="; charset=UTF-8

--2zJZJdVWTLU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex=2E

ralf_lici has=
 posted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1835?usp=3Demail )

Change subject: dco: do not exit the proce=
ss when installing a DCO key fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
Ge=
rrit-Change-Number: 1835
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@ma=
ndelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: flichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Thu, 06 A=
ug 2026 13:16:30 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--2zJZJdVWTLU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex=2E </p>
<p>Patch set 3:<span styl=
e=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px=
;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">change 1835</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I564edc6e=
0cc179c2b8b5ddef5e80838949fe9fcd </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1835 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3=
 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 06 Aug 2026 13:16=
:30 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>=

<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--2zJZJdVWTLU=--


--===============2184477986767602371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2184477986767602371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2184477986767602371==--

