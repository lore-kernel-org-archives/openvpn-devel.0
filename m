Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B0606A333
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MYC/AP6n;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Cb87m9Dp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ThEjpV+v;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FiEJyIRR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yOQVtz5jSzS4t+xtfQi0qodTIH6eqv7i2+E3OghD648=; b=MYC/AP6nBjGcHI0gio6sgj4uIQ
	O5aHuh0xZGoaum3gUa289xIpvwLuchRgdK5TQykV2maLabixkH5x/0sFr7xGcHJXagPuWB+KP7lVW
	LgEHrG3J5OI53HsohKkjPTAj765Z+GmRtgqDMeCaoraqVa2DjnAefvDKWEMj0oi0CBfg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTNPX-0000000031q-3ziD;
	Tue, 17 Nov 2026 17:56:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTNPW-0000000031e-3IPS
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:56:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xokbLxaEWg2K1uBYYGbvUgr+Ga4v/6sB1PcK62jc8rw=; b=Cb87m9Dp2VvIR1BAxPYMe522uz
 ftlW1wvIkvmpKOMNHtcT7QuWOgsBMSKuBhGK1Uh599ZZjfoa7pQXKL/rLie9mhrmF1Ho1bkaXhtU+
 jxDmwBmvONstTflxL/hLUPx58BDsvNyhnaTTsas3JxbBRRpNWONbfmeMxulUBZfJ4kA4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xokbLxaEWg2K1uBYYGbvUgr+Ga4v/6sB1PcK62jc8rw=; b=ThEjpV+vCuusLixsvw3W87Knns
 zaDquUEZImskalTVJS4rFaepTHM3NnXrBIlf0DTInYBmwkTVdVi2tQAo9Z58dnO3bmycD9zukFDCS
 1RDcPIMHQTtMTkloDnKX1pl/TRd8gnY37/PmEufRP4ODUsE2G7tez2Eg8dM75YfW3bZ8=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTNPU-000000000eL-4657 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:56:02 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so1040621f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 09:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794938154; x=1795542954; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xokbLxaEWg2K1uBYYGbvUgr+Ga4v/6sB1PcK62jc8rw=;
 b=FiEJyIRRlxORfN9PzIDYbXssMjIHq08WGU6o3tmrUqsI9GAeCuY4OD35kZfrcMdmh3
 y8TAA+TN3dxx/sE+lrPCCkTKnHlcmmss9zpHkG3k6VEIRDPFpdilCGnJZWBC2GEII5l7
 NquiM9CwI+2buXl2oY81C9WmLKgPbQ2GbDyDmO+iJ2pIBfTNRd5OLoVMD+MEtFoq22RO
 yXlQ8F5P6vAZEaFjlcJ0HzOgWR9F3a6LVkW62ACmsJxwOq3oL+/uujI+DEFPC+jmFtsx
 3QawBKuWnNL/g0CzYL3r93/p4NLpKilTyHPjhLJpndRrf+5fBYRqimQ10sYdq3P1Cq6r
 baBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794938154; x=1795542954;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xokbLxaEWg2K1uBYYGbvUgr+Ga4v/6sB1PcK62jc8rw=;
 b=TGht5ePJ3fHwXYEnCPJzM0aSsURTEFgtT9erGcIcADPSSJbRlZ3gK3oT7rDv3YHhPC
 7D002sPZpfglNuKsLpEKh5hYIwG4F+Hccylxk2/wapMwBPSAKGxndZ6J4EP28ypRDdHM
 qq7Rrzp2gO5QOD5Ep7WItqtW44ZqYq2OdYfJLlZqgnMJAXgKH+G5EAm/1IYLYz+Zrzyv
 GPhbgZrfy1X4A5hEk1fmhYkFYa7AmDgoQDWaDpgCQKuzinGbV5ifEH4DzHYTz0fQUTa3
 CibR0HkYeXllhgGKdiAmBFehkEHtaQUIWhBKhLwpOp5FZgfbcZQJmBro9yZYQ1/utGoN
 sQlw==
X-Forwarded-Encrypted: i=1;
 AL+hErGBM94pUxvwi2vh5umW3FiVVFsFXREB2unLApvTj8KDUUHdcvsw7ZkAFirZPWafGSxzyDOwtHPQvc4ZarWN@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9iS/VdNEReR9gKBcwf468RDTLHBu4Jb1ry+bME4jtkbS5jIdMS
 xnlFFleGava2cCQj4IGV/uzlmnNSJepO5OaqO6OuBPS7VQhJB2RLKUNDCVru8z5sgGDw13UTLkX
 EJiiQ1B5RSnXtosoZl1x7MlOtzl9tV3rUJJHVUX8sNLXZV9R5VFWmqJMykAym+mCRhIfDvFM9un
 /sNygqmQ==
X-Gm-Gg: AZFdTZfQB9um9OalCvgrFTSzCup1nr2AWzqd+FtWQqa5VLPsl/zv+Pkx8eEXKY8XF2b
 SnuFxR8zagxuuAmaDaqNd5tfFAHszmZq6v/qXYw1TNWMNyt/457aptSQeXBAUahhSMMEK73G6TC
 90sbk4bu7jGp1QXriyCLxv0k/mYRL5jqe6TEqTpcZmyIcHFy+HH86/zDvxH9LN2L7oaM14x3A7X
 M2jC7LLQWRM7aXWZySq4B9GtOixmOu/42aXPymQQL5i7z6s9L4Ncv/JIMtHFgq06XbEQANNPMtk
 FhBNN8/Rv1J7T67+CP3wAIUvR/crevCUho+toqyscS2llo0/aSMC3EssaP0HdPxhEupzWDfdM19
 tNyDSDIvKRzFH9jQW6R1t1MduKqpL3BDSPVuL2X57nD99WITdNanfHv00Pk/X7bKEnx34wK4LQJ
 DjZy25bPa6qAgkc8jxqbyTXgMbE7SIr15hcqAohGfypwsp3OT0vY/zFOKwZT9A3IL5e1JMbD+sd
 KmqKIrJt+Bo6FXbiOlwoJLCVCkUx5DL8DkrCHYgNBhNSfZTK6mzdrbq8itJSxKbv5/IF9wtwAAH
 OYbaCw7l5ywF/cXk0r3PEpI2cf4GTKQ72bzgQXXwYODWiao45c0oyn5Liv+igkR9XrkHjC0HHxq
 i1AKAcf7XilcqrI24FLGXsmTCS8jN8lrx15UaDNRUTRv7BxhhkHwNHdgwxNpMTLMTmdfUxS+SGP
 fEHGL5GeKkU6QVplVu30BsLbaRYpjgSgq6K1xL
X-Received: by 2002:a05:6000:4b0e:b0:48d:f852:c66b with SMTP id
 ffacd0b85a97d-4a3771eebffmr7213343f8f.22.1794938154268; 
 Tue, 17 Nov 2026 09:55:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6560962adsm24885f8f.41.2026.11.17.09.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:55:53 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 17:55:52 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib645e0bf5c8941f4b1e14f13397794be15eab68f
X-Gerrit-Change-Number: 2189
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2189?usp=email>
X-Gerrit-Commit: 4cabb2ea50a57404d2e89c7d016cac8fbc800d84
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 17:55:52 +0000
In-Reply-To: <gerrit.1794827563000.Ib645e0bf5c8941f4b1e14f13397794be15eab68f@gerrit.openvpn.net>
References: <gerrit.1794827563000.Ib645e0bf5c8941f4b1e14f13397794be15eab68f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODI3NTYzMDAwLkliNjQ1ZTBiZjVjODk0MWY0YjFlMTRmMTMzOTc3OTRiZTE1ZWFiNjhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d4683e19bbadfa2a5785abfb6f3f18175bd97982-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTNPU-000000000eL-4657
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: remove obsolete
 preprocessor guards
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7875223510987032808=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7875223510987032808==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D9nK6D/mmnk="; charset=UTF-8

--D9nK6D/mmnk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2189?usp=3Demail )

Change=
 subject: ssl: remove obsolete preprocessor guards
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2189?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib645e0bf5c8941f4b1e14f1339=
7794be15eab68f
Gerrit-Change-Number: 2189
Gerrit-PatchSet: 2
Gerrit-Owner: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2E=
muc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue,=
 17 Nov 2026 17:55:52 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--D9nK6D/mmnk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 2:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2189?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2189?usp=
=3Demail">change 2189</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2189?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ib645e0bf5c8941f4b1e14f13397794be15eab68f </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2189 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Tue, 17 Nov 2026 17:55:52 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--D9nK6D/mmnk=--


--===============7875223510987032808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7875223510987032808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7875223510987032808==--

