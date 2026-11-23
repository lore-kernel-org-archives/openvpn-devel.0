Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B382606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UEtCz6lu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=B3jt0O/d;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FaGGJPs/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CGlMyJ2C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=V8V88lO/DsykOohsoaLUmXgIxa0oSZdEacHqa1TOaw0=; b=UEtCz6luSFMMFkh7salfB14hu6
	rxBsuT/v3v4octFlhJZ8oU0yPv/sGJ014ti03cMf/iomjvdK9Vnl96+oOCFd/T7+VHzmU59hKH2zQ
	9PPyNatUmKRyG4G+0wqGjPMQKYkoFLvi7yZsBiocMgzWO4Bh58M/I+hx7k7aT1A8LQvU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVWpC-000000003ju-2cNg;
	Mon, 23 Nov 2026 16:23:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVWpB-000000003jg-0YfN
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 16:23:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z5OuSaFHqBUYQC3hyArwT34oauHj8GTIFAe/ffH/fCo=; b=B3jt0O/dVTv0HDcSseekLbXWLQ
 oeqBkseTJLndZy+BSYIeq4Rpk9lQs1l95kUhYKP36D8yC2IQ+i2v8YJbFNzONgzZTaK/oxZebf2C9
 alTyvhCD1mo/3YgSdOsKu69pz2yOiyA1WH5XTIEBmp1Th7UId9i2xhbQ58H6MOmW5Wh4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z5OuSaFHqBUYQC3hyArwT34oauHj8GTIFAe/ffH/fCo=; b=FaGGJPs/O1jmUNkGs3S2YjM1oM
 BmjWhxrAwdetIsdOp8eQmY8p66OXFDnDHNnUpKploHCFeCIwCJFtHhRnwNjMp4MqV6Dfk77x8RBSI
 x0pyGZym86H0G5jlMnrb7KISnLkdwwMTcU0j41C6MHTOG0d1lz5YipHl3kH4I2JqA5zc=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVWp8-000000008IU-0NID for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 16:23:25 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso2652176f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 08:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795450995; x=1796055795; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z5OuSaFHqBUYQC3hyArwT34oauHj8GTIFAe/ffH/fCo=;
 b=CGlMyJ2CLE7fxi1kf8eCYY25EA6Fh4QEvyAW9QGyukBCarDm+siC/P5zVBdz9vpxUo
 TDNKryvIpN3fQt7cuF2t5MTVcwkJAdFVWKgadH/su3nplouGkJSJStrc2nGckCwrQrxS
 jlP2tWgOtrqe8Slj0gboXKOXuBVEYsKBqYK/VKc/8MOigbhZZvMAb+cdBcLgyZKzQQur
 GqUkjCeEpkYVbi/p1xAwB1+KLwV5T0SsbArRXk5i24dlfdHlGZB+sYHHSKop1jEX/ic0
 x7FSpg/CECwvfWb+0AJ6ifFtuCipamKrtCdcaIfVr9zaB6X/YPLh2RuckrV68V0bVYv7
 571Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795450995; x=1796055795;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=z5OuSaFHqBUYQC3hyArwT34oauHj8GTIFAe/ffH/fCo=;
 b=UZa4yKuZoCjTXzx0+9efpXpv8K8kVkJsnB4AZ9Nc/9FVbdzy8ikcNKeGgqEbcohMvu
 wFOobHXxY5HoKrSTRDM5OsJQVQ8JhddVLHYb6xXoq7sgZ1UrnLaidjngRZwjtsOGndgj
 +ztLiZ7VxaWDmZAqDjqd98bPzUdEJFSlkFtdwVQIrN1EVju54RJ2OeO6Oz3Ll1WDawE4
 yd4B4jRTk57g6/3bNNl1M7VPeWAG5NgbR31eJTVAzitf9JGLFL0YkNK9iHlmklOZQpXU
 rrF2AiBRq37BonAj177AKJbf1h/gG5ONdYukKiKgI2wGEy8pGb5mVdHCOoU8xxbwLwoX
 mvPQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFEQGF3sIY9Rs90dhYLlSy/u6dVkPBG+L5YPcCopA1ExPYbI7JEtYZuhCGEwGkfG9mtrVQEYv/0+x/o5kJ7@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/Znvseep81eoiWL1JnRhLUJ1TBqvGJIrbl4vQtqmw55Ikn4ihu
 RPT5U9uorPyiI0pF+8cLSSKf2z0EJr5HfgjJhGcyZgIFAXtsDy2KxMVaZDMtW1ic4Ipgi42e0mh
 /EdjCANU8klkj4iQTtf/MVMgFGkiitQ+j83qr+KS5OO2cdsVkuK/ABu8HRIg9IMDmQYJzeMWoS5
 7K7nd17g==
X-Gm-Gg: AZFdTZedFbqhzP4GFoQskzFnq/wbNtt59pbH5tneb1f8eP5XbgFnaKAhsJ37yWQajeM
 T4oDuznU7p2eha+9MAJqvZcdhcyRLi8GObPuEPWOHP+nxqy6MlYRrL3SBACNeRrXKVYHua7idBB
 YyhsXpv62edhZMK/eiD/Q6X1drsM+TMCU64/XtCwN5kK3IEGYDpLd+ukU2Mr5Rm3tCJeaNUpym0
 FUGnPFcck9QgaKltRWBewkIRs+7Pm/12YKQAkQreU0gGKmOsoSp1m4QdFIN9mex+BwKbfLxWfNG
 HL3tqY64gIYmwsuUNhbTg8qbmX6Jdgk+qnpbpfO0I1OAi8KtwzQ0Y9Hu5z4dgAjp0Nf6+8X6TOg
 s5ynyJoBOMX7b3vT2z+l/xMG2fGutpdKEM3iysX3MOBNxEEcarKyRWL20MdBx9EPV1Q5dx1DDq3
 StlzebIcINehh73tg7BoaMtkkHJ+zNOqLNLRrjZSF7/E3KyzVHfrgBXMJXBCZ2x9MJnw4DAU3Zb
 fHKXYBqK6NuhIyfJI2PuUPhHnIOJqq6sTUpqzcLNHGLoGMp/g8abJruvFN8JtTvehUJ6Sdjw79F
 oW0gwpGTTtYQPQE/3u95D1f983MUEC5WvOnd8XY3b4IcKnNee5IPhkDeq/409m3RbZ6IFYRHfj8
 ihJ177DKkEK+CvisQL2TmdcGuSdMm1fXW9vRz4egjWsXRNfZnbDAUlTd0m1QgwpTZhB8ZNzpcyL
 gMwGN/596w6KOeNr8=
X-Received: by 2002:a05:6000:2c13:b0:4a7:9630:7b57 with SMTP id
 ffacd0b85a97d-4abb43dece6mr23472349f8f.44.1795450995219; 
 Mon, 23 Nov 2026 08:23:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a680355sm19997137f8f.27.2026.11.23.08.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 08:23:14 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 16:23:13 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I01458ac46a5948fccec4afa9fc358a36e67055b5
X-Gerrit-Change-Number: 2331
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2331?usp=email>
X-Gerrit-Commit: bc8290ed11515a0ebeac55a82d270debab89e591
X-Gerrit-Comment-Date: Mon, 23 Nov 2026 16:23:13 +0000
In-Reply-To: <gerrit.1795449639000.I01458ac46a5948fccec4afa9fc358a36e67055b5@gerrit.openvpn.net>
References: <gerrit.1795449639000.I01458ac46a5948fccec4afa9fc358a36e67055b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDQ5NjM5MDAwLkkwMTQ1OGFjNDZhNTk0OGZjY2VjNGFmYTlmYzM1OGEzNmU2NzA1NWI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a8187f99132951016f7696ccf9f75d5e870bbccc-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVWp8-000000008IU-0NID
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add buildbot
 configuration script
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8640843945382637620=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8640843945382637620==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MEeckGJxhTs="; charset=UTF-8

--MEeckGJxhTs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
alf Lici has posted comments on this change by Frank Lichtenheld=2E ( https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2331?usp=3Demail )

Change subject: A=
dd buildbot configuration script
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1: 
Sashiko pi=
cked this up=2E As always, I haven't checked the content of the review but =
I'm sharing it in case it's useful: https://sashiko=2Edev/#/patchset/ff63f4=
9c11a292d2123a9a5266c192c1f57e6a58-HTML@gerrit=2Eopenvpn=2Enet?part=3D1



=
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2331?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I01458ac46a5948fcce=
c4afa9fc358a36e67055b5
Gerrit-Change-Number: 2331
Gerrit-PatchSet: 1
Gerrit=
-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Ralf Lici <ralf@mandelbit=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 23 No=
v 2026 16:23:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--MEeckGJxhTs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Ralf Lici =
has posted comments on this change by Frank Lichtenheld=2E</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2331?usp=3Demail">View Change</=
a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/233=
1?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Sashiko picked thi=
s up=2E As always, I haven&#39;t checked the content of the review but I&#3=
9;m sharing it in case it&#39;s useful: https://sashiko=2Edev/#/patchset/ff=
63f49c11a292d2123a9a5266c192c1f57e6a58-HTML@gerrit=2Eopenvpn=2Enet?part=3D1=
</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2331?usp=3Demail">change 2331</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2331?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I01458ac46a5948fccec4afa9fc=
358a36e67055b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 23=
31 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Mon, 23 Nov 2026 16:23:13 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div styl=
e=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--MEeckGJxhTs=--


--===============8640843945382637620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8640843945382637620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8640843945382637620==--

