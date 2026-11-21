Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D72606A320
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EHNPwB5p;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dBQGFbdZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VMOIlahP;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VtHxjxbl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=30Q9o9TTwlm/mE7p29bmgumklQr/cCNqm6Pbilx8MNo=; b=EHNPwB5pR7ICAVxH4E3rtpIgbe
	SURUFMxPprsWur75RUrPTHxOLexPaX8JqRojG5OJwGAghftjdQRxmQeGnQpeL6pMxOGDdvFOW3SWP
	C5TnIZL0LplAjeA5GI8YC9mvT5YPUO82WZOl611vVpnIQdSndAzPHYUyJeU8qtkS5it8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUmS9-000000005fi-2xQe;
	Sat, 21 Nov 2026 14:52:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUmS8-000000005fc-14rR
 for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 14:52:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OSONWgPA9dGhbMYYt242mlTTGu9TnD7BV3wFQ8O8aPw=; b=dBQGFbdZX0L6cePEq1IhDY1wCT
 /UWW5E5uLcEzKRQIEsA7/rOvywmA4B74+a5imS6kHYVBg+Fx5hd58VzKWe6/BZ7aarrTEx3QHC0GA
 3A8E95CkkntLnFeGPITLjEAFp6GZkjHOBmDXULxoeMEX7h1npAjvHS+SlydRJysyuIaI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OSONWgPA9dGhbMYYt242mlTTGu9TnD7BV3wFQ8O8aPw=; b=VMOIlahPCYV2KRwVD3qQei9fLu
 qA06geGwHAyR7YOycVy546h9r2IgMofDLM/s53oUmXrIuFA4609EWmiACH+oqpKKIftshv28uFHcR
 eD388OuJZD+X1BGeMpjj3eHBqmwALp0vPYtOUhpYtqtIphLSilcV83K6Pn19fC34z2vU=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUmS7-000000008U4-2IkY for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 14:52:32 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so12909745e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 21 Nov 2026 06:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795272745; x=1795877545; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OSONWgPA9dGhbMYYt242mlTTGu9TnD7BV3wFQ8O8aPw=;
 b=VtHxjxblDLr2w1f3tayJQm2PBlZLZpAONK8khfW9FGsau0/rdXo2qQvX5vL1klVRp9
 G/FbQ2ZAafXFL4OVqq/j5oF0MbWyLVMOSu6MTl61QFZdiXVmIWkIwvbm+P4fssuhi39y
 bQ/8tRKo/vl+6MJzTytLclLtLQwWJ54duNYQ03iic5OzBXPACUyn7FizbR5NxdSHQjkM
 LKujgoUPJeHC+T9I48gK2E0c6U/jeSFCh+4QcoDD0R5+e1VNZUU9GTXp8B1sTurVblT5
 jpo6coC4K2PwblAli20jhZN5b0JpxMfHjIKFokhj3A0vrLKinpWBIFvvfXUfmE5vdCZq
 iDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795272745; x=1795877545;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OSONWgPA9dGhbMYYt242mlTTGu9TnD7BV3wFQ8O8aPw=;
 b=imokgYdJ/bFHsYnxIC4Aer8LY7+lt8x/z8Mjm2soymfM1IAdYsnaqDvIeTEsdpbDHP
 jhuNGF7bBl6VE+RZY0XoOibhB6W6HYr7KfZfyNyACwzrdnvJlJzhWgmt517nuWJkiFeb
 unja039OQeiO0O2Qh3llT5lFA9xj+lWtMtltPRWSnfGJtI4Uodaz4CN+/VphJUf4LUlq
 e8fByFULBczUN9npVrzXLGWgkiYkrcmSz51xwdQgObjTgO8zShATc9jRbAV5jgdaYMsU
 DrAdFm3TGIUkXWLm4ENxiaHvd7bi26XaPRNB9oAP04RrwFZG2uw5SCNAu17VH81qiI9z
 KtYw==
X-Forwarded-Encrypted: i=1;
 AL+hErH63Iqb9fVP5bsb3O6fcVCiyr1tN4vkAsu09QfsU8qK1AWvjwoHwz/WVjJ+5idng6IjW6eUmFhV61VpeELE@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9zrhzYwuoY3nYsv2DmnTWxYBqx2TE0jzLgB9TKd5rsGQsl6mH1
 0z/QcEi5Y2/+m4HiLe0Y6hFID5fjW/T7cYLVFgosCPIr6oeyoBZNzG2Z5DBG9ItFA9i8rL4Mrki
 txZ5sZKb1cyEalIRP9wFyFgE56XEQ/gPgIlHE0sbB+mfnGP5Tk+nC8HkcHQoiB7vMY6BxT3Y0Ss
 0c7Fv3oA==
X-Gm-Gg: AZFdTZd1nBh98x8r6g1/mKKsb+P3cWjfhoZEpjqvEMmaHcauwQEe8JcxJceptRLqyrD
 L3ow7Crpjba6KfnbLJq3nGDqMi7tYochbu3EqsWUOqd2bi4Y1lEIkZXTW2mXSNVDGCf7PvQLCe4
 KPaHmpPKxVyPX7n0V70FTJyfT92EanxLtpDZY5QsSJuyDcmE215atIKt96AYLXptQcza3s+yVGG
 P1Wo5R+53loWvaW4h3h9xz9M8J60LKESv+zAaDhcsoSeGSryOCQfNVeR1PWRWYsxuTlkn+qkDZU
 /VQ7wjeuk5GNoNuYq4I46CGDBj9BqwaSnf9Vj42tgbIF2HFQS/4gsxtCh+XWFZaQTQkL10YvgcI
 yXe7sJ4OSdtGaLABP1dMhtb/GyryQfLgY949haS7jZhiENUnqhKYz/C84QZxAVib/Hsvr8AZJ3C
 IsKd3Uxott3xCuyZLvllpO1FuH+XUWmXV6WwnwY7/OlJcmkIr4XJqDnt/kw2Ug3vE9rNN48Zdj0
 ViW6eTYY6fCGpZQHCdFmswv1/ZF0Ds9ucZaDtwwJHglAxqW9dldCJdcJ0FTNlAoa+viiE14hOVQ
 +HPzc5/WNDYvhXkJ+0EvE31UJVfbsSvXMWu9nupZdM8EEQvm86w4WBXJB2jjyI6KLyMimoVr5AU
 2QcpENpin8kdZTO8TzXHR4lf7mK5KWwnffV/RjMty+5VupaS+YHja3xPRau+p4REQT94oVKU/9l
 PsAQnYVzA46QWN4fQ=
X-Received: by 2002:a05:600c:a15:b0:4b6:267a:dd6e with SMTP id
 5b1f17b1804b1-4bb88938a62mr143372495e9.28.1795272744902; 
 Sat, 21 Nov 2026 06:52:24 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906635c7sm57557755e9.2.2026.11.21.06.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 06:52:24 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 21 Nov 2026 14:52:23 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ifc72b3677056dd089b8c6cfae4bd07911b6f8407
X-Gerrit-Change-Number: 2228
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2228?usp=email>
X-Gerrit-Commit: 21bfcbef5fec36bd8d84d368daff0c58664b5c6a
X-Gerrit-Comment-Date: Sat, 21 Nov 2026 14:52:23 +0000
In-Reply-To: <gerrit.1795176368000.Ifc72b3677056dd089b8c6cfae4bd07911b6f8407@gerrit.openvpn.net>
References: <gerrit.1795176368000.Ifc72b3677056dd089b8c6cfae4bd07911b6f8407@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTc2MzY4MDAwLklmYzcyYjM2NzcwNTZkZDA4OWI4YzZjZmFlNGJkMDc5MTFiNmY4NDA3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a3337a3cba29189bc2a45a1076b99734dd7db51a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUmS7-000000008U4-2IkY
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: options: check
 permission for --route-ipv6-gateway
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
Content-Type: multipart/mixed; boundary="===============4668019261785663559=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4668019261785663559==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D4xN6uX7eVM="; charset=UTF-8

--D4xN6uX7eVM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2228?usp=3Demail )

Change=
 subject: options: check permission for --route-ipv6-gateway
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2228?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifc72b3677056dd=
089b8c6cfae4bd07911b6f8407
Gerrit-Change-Number: 2228
Gerrit-PatchSet: 1
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <ger=
t@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Commen=
t-Date: Sat, 21 Nov 2026 14:52:23 +0000
Gerrit-HasComments: No
Gerrit-Has-L=
abels: Yes

--D4xN6uX7eVM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2228?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2228?usp=
=3Demail">change 2228</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2228?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ifc72b3677056dd089b8c6cfae4bd07911b6f8407 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2228 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
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
lay:none"> Gerrit-Comment-Date: Sat, 21 Nov 2026 14:52:23 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--D4xN6uX7eVM=--


--===============4668019261785663559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4668019261785663559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4668019261785663559==--

