Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9FE606A319
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MGRuueBG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Lt2yZ4zh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=j4yBvtie;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WtvgO/DG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ye3H52omZkEULwkYPs8RKJeS7oC8lkxVEPWoHqOjgag=; b=MGRuueBGLZ5NhQ9jhVJbVRxE0A
	H59yrPaw88/vkIBdEbNm1gnbEE8WWg4wyHxeaWlueBJtW4Lq6O1nqL9iIE1U/XxbTlXRPJmoxA3FL
	teiR/+SZkQj24tqA4MoTd/Q3pARl8ssk05y1W2jshCCYvIDPKmvl0X9hbvy4Jm0k2jGk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJrzZ-000000007Fq-17aB;
	Thu, 22 Oct 2026 12:33:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xJrzC-000000007FO-1wie
 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:33:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iUzX9xwwMUNUBLtKlT6qNYB/YUb5gX+9jTwTs6hWJ84=; b=Lt2yZ4zhKzVl0jyFjHOVrwDh8n
 vvFfJdY3DdWzuyh+GZcZvjw2SLWTS1xx0JM/zv+fqpyAiU2CukVB5T80eutaY0ENjiQf83doS9VGv
 zsddavgIkpaZEirOAZg9xDT2PXrylblHXrQQI8QCEIcMCRCoFN/Q5RIWqURGxNAPLGkk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iUzX9xwwMUNUBLtKlT6qNYB/YUb5gX+9jTwTs6hWJ84=; b=j4yBvtie+KuBQ1XIorfU3wtWgt
 EiTsSgi+ITZkhhJRXl7zFGYeGUb7LYA+LfUlhKSIPxl79YXhqw9qzfCv6XgtCfGcvJvFkU0ZI0EPy
 kgqEv4CcnIErkVbFqhi9wVOSbrhMNIkCUpGMdCpj2b6m/ZdzU7abvIFLk9Y79yr3SXas=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJrz7-000000006Mh-0qWS for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:33:32 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so1102172f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 05:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792672403; x=1793277203; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iUzX9xwwMUNUBLtKlT6qNYB/YUb5gX+9jTwTs6hWJ84=;
 b=WtvgO/DGeeOgy9b7jaHENFOTChwBUvT463Qtlx7oFYWuINkkOQerdO+hQMaXy2QNxu
 pT9arXsK2dUID8vKXj83qeu/kPGfIkNt+iL2zKqBK9n8TkccFvF+WrXf6PFhpOe+2ckL
 0nAeIhS6z7jNAxhkcHHww8XL0WuMx1y9EHZ7Jvz+HPG6cUndWRz1o9zQI0iEpxe65Esj
 6OOnrj4BDRL0uNJXmdGS7bXAi3kK0s9fb8D3WeGM89iESrTKTOboO9/lVej0Ju8W5Ewx
 YzuTRzHnwLtEHaNIadH5HdjGUW6wj+jzByCSv0RtRob6Mldwk5bjvGfT0w9P/HMCeYXW
 q8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792672403; x=1793277203;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iUzX9xwwMUNUBLtKlT6qNYB/YUb5gX+9jTwTs6hWJ84=;
 b=hNFRnr/Ep+8YC1dTzCG9vO7cta1HkwxN9WUb3Q66iWFP2Xbr0CoMzbCEw6P/YDdy2L
 9IWG8B9Dxdr3h4pvoKEylIn0IfjkYgiCdP3dafxeEbhkoYz+ujHLhAcPd8cpQ7oi70wA
 2VmANUjXdzvajtPLax8baJbxU1WmuCm+/AlXfPot8b6uniDzNS4unIFEmRbYUPBHYJkH
 4sotQFeBsGmBXxjXPVoDVj7t1cJ2f0c5hSbQg6olIxvpm8lRcaRjFDOgtObXLOUqXMV0
 xskdAgTZK7baicgUGiLoa0oFwyrZrYP9j4LzGHMYF8NLGQYIRSyePW6SKVIHwnWEBtaJ
 Gw4A==
X-Gm-Message-State: AFq9FYLR/spb2o/EAIUB+IFaOHNegBWOjCKzR7OdQ1FOSNLgcTpuS8ot
 lB4cP/ZkBXFxcZFj2Rv4O29VtaqhtKU/YcOB8Bgcdzw/slEnc5mhxKIlLBkzzE+j3tJXWuCSNUW
 oTLPfD78naNz/SoP+c0otguX7vnh3U8URybVqbHbjrRVqNwuXjugvDPqI1mpxRaVuWwOk
X-Gm-Gg: AYBFou3CTj5crt0YRZSrPed81y6UBI9Y6XZH+vgHhAF1PTWMs397erz5RXSt5d4BSD/
 6j4mAvxOL1mlPolAzFLcrOe0javS8NRF+1EyaZOzUJ3bJ3jASUYtYTsJr/RvJjTVg7c9MSCvtbJ
 Qm4ZEMa1hgFInFseT3jixEIpmiVhbxk2b3NxBKf4SUkmsC1dlEek2SHJIETLYN4RMe4190Pv4v3
 dAL5ESZMsnV2i5WL6yN1BSYaFMv2QbmOx9ljm22iW+vCZbaO7DM62JoSTOV34/B70/2RSYdFlL5
 sVjcLnum3NSQCp9NVh9KMkhNZzJlCiJD2yPuuPEHrW6dayTIvtra8W8o1oqjbBFpfd7IWASgs1a
 aqz3o/oVwkc3L4w0K8l8KUOTiUG4N5fiftafR1lG/0S0EWOiePrmm4i2GqG34n+Y4sVHe+kha/A
 0CSqqudonpVYNgX+FGxdjduMKZeFqcx98qh2yeLOnQ/T/tqKju0t9j+GC7k/de4EMqW7NVVkhmB
 aCW2iRBUKFtkEoKcEZatleLrz1nHVZ6OIAACIqo+KEPwvm5UniyqE8pFQYJe/QLzguAi5HFnTWm
 kE9G4hTx9LqnE5TTNkSN+ccVv/hGQYX9zYDHfIxOCGdhIOmNgSZYIJGug1tYxBlvWCceRdP0pHQ
 EhvjriIEIo9lj5IY0zc8jCeRtID0dZ4vsPwPmANw7uA==
X-Received: by 2002:a05:6000:41de:b0:48e:dee:52bc with SMTP id
 ffacd0b85a97d-48e2639c95dmr10844047f8f.0.1792672402450; 
 Thu, 22 Oct 2026 05:33:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2584c3b0sm13605167f8f.57.2026.10.22.05.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 05:33:22 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 22 Oct 2026 12:33:18 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I20d367dd8251bf39856ae521f380cfdc8df64177
X-Gerrit-Change-Number: 2028
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2028?usp=email>
X-Gerrit-Commit: 7c0460a0682aeec8dac618cb8bb053a6d90b8a5b
X-Gerrit-Comment-Date: Thu, 22 Oct 2026 12:33:18 +0000
In-Reply-To: <gerrit.1792667802000.I20d367dd8251bf39856ae521f380cfdc8df64177@gerrit.openvpn.net>
References: <gerrit.1792667802000.I20d367dd8251bf39856ae521f380cfdc8df64177@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjY3ODAyMDAwLkkyMGQzNjdkZDgyNTFiZjM5ODU2YWU1MjFmMzgwY2ZkYzhkZjY0MTc3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2cc7ac8799e054725f1fdef948693a3df87634af-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJrz7-000000006Mh-0qWS
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Call
 AC_PROG_CC before AC_USE_SYSTEM_EXTENSIONS
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
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3383206997980519951=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3383206997980519951==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4e6A7U2lBa4="; charset=UTF-8

--4e6A7U2lBa4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Arne Schwabe=
 has posted comments on this change by R=C4=83zvan Cojocaru=2E ( https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2028?usp=3Demail )

Change subject: config=
ure: Call AC_PROG_CC before AC_USE_SYSTEM_EXTENSIONS
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2028?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I20d367dd8251bf39856ae52=
1f380cfdc8df64177
Gerrit-Change-Number: 2028
Gerrit-PatchSet: 1
Gerrit-Owne=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit-Comment-Date: Thu, 22 Oct 2026 12:33:18 +0000
Gerrit-Has=
Comments: No
Gerrit-Has-Labels: Yes

--4e6A7U2lBa4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>Arne Schwabe has post=
ed comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Patch set 1:<sp=
an style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddi=
ng: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2028?usp=3Demail">View Change</a=
></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2028?usp=3Demail">change=
 2028</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2028?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I20d367dd8251bf39856ae521f380cfdc8df64177 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2028 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Thu, 22 Oct 2026 12:33:18 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--4e6A7U2lBa4=--


--===============3383206997980519951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3383206997980519951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3383206997980519951==--

