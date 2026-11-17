Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C06606A333
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CpJ5o9yv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WLq8WQqy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fIXCZRht;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PKjJds2/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=V6HxSlUBMrMz7+MVKjJi1OD6yYV/Fya9ZgRDZqLIQbE=; b=CpJ5o9yviYVMff8Fcrq/GCnEo9
	zAPqNOSrQb2n0KvE0MJokXScfGrkGt5CoA4I2GrKPIQM1bGtHR63cX48IbU1nk3rBQCKEnieuz1CZ
	ONpQbtFuxVcktHe3nVLbBkHP29I1MNKan3ajviwmxzxID7m6WqS6LDWFrcci8Hr5dOJE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTKPd-000000001DP-1zHA;
	Tue, 17 Nov 2026 14:43:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTKPc-000000001DI-0sBA
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:43:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nT/4jPOevYb4d9hM+hKMUmB+97W/SIc0m32kSTduifE=; b=WLq8WQqymAihj7GsCez8UiOz9Q
 Ld32LK9uOFASpZeBbdV444TydUDcchqO00WhyDjlRjdI8CsINT7zr/+vcrZbIXZdvjkJpQ3ZhYazt
 ML9dsZVV56XvnptG6+QEJI6R7jmsR+tVKjoRcPkj7pJXOpFEySwzO/aY1t2ZefZ+Kmes=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nT/4jPOevYb4d9hM+hKMUmB+97W/SIc0m32kSTduifE=; b=fIXCZRhtNtvV2kg2KULIHf4h6f
 PUGT9cHHlzFv14wZiMmJ7yrS4NMSMrFSpIll+KcHqocYkB4hAt5ucKesaXu+ssj6GiJrDIlQsFhct
 /jOCsh95n3eU/rVUwRevVEOK1/LdgusR3+ArWXq8DNSdVR/D1bjWyCdjqjEIHvS/0bq8=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTKPa-000000004FF-2acc for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:43:56 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso4494029f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 06:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794926628; x=1795531428; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nT/4jPOevYb4d9hM+hKMUmB+97W/SIc0m32kSTduifE=;
 b=PKjJds2/n/k1gpiRFQ9R7Xz1HO6pNHebjb9MzoaopAMeJyzA+8QOipIz2+ujS0QzdV
 /hgiH8m/0+laY4V6QW9LdZ2ksw13VgjD0IHMkxx7mzTESztwvOmQboiofxR2O1SvzcBa
 3ZOUTHV0cRkWQONxVZ7K5qS+ySeIF7OfgKhcGWn6Frhc49wFQiLh7qxOe0UJ7ved2TN5
 SZ5csoG5RJQkI5qnkm/vKX9qUe0qJHJLN5o2su8qdvB+07QFKeHS5IpJKat4fvn1AXH9
 JzS0q4l61M29yTumEUJnUOaowHWVoP+wrw0JHknE4b5Rkg8Syzxz2bqXfLeZiVh4P3dU
 8Zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794926628; x=1795531428;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nT/4jPOevYb4d9hM+hKMUmB+97W/SIc0m32kSTduifE=;
 b=klxKwNJpOihfgA1zz+cCP+SiECl3D74Pb2bH1GR/voszVrYmjXO7owEnSTAE36xFsW
 MBnFHYxThLnHEdcYYCA9c1HVY8wUWLV1LazD5XmyTnvF6l1pjbVO1o4o/00NZtoMYf0B
 Tp+H5ljZdrLRP7jDhLYOYPCI+FVFh65ZthW4MmVC84Bvxs7xh6Uxrb3j3KsEut0pTxZu
 rETLgQ6gOhapZ+pZm6ApYCoan3F1Js2mrqdTQ8J/b8uK8gaO1ezlMRE0X8sgN+/54pn2
 4PO33Zds3rfdTq5SFMxgZMUjq8UrfsWKRu8HfxSShygon6SggTK2cIFr04xM9IJXcwxs
 4p2A==
X-Forwarded-Encrypted: i=1;
 AL+hErFAPi9fQf6VYuepq20UTzYjGBr+iWxgc/RyJXkUNGy0jS+3a7RxVb5EM8wc/QUYQLHo4b5sQPXsl6Jfv3w+@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9zPFZ8lUam89sjIGoq+tBkz8klG4GfOp/2RgNX0PIKImefqQTB
 bRe1IRqPGzrkN+ZrgrWLXk8M1l8BD5fo9hkQFMLDFsP2sLLoxUBJyIe3GbAD8EjA1ZR7mDR6oUK
 MzVWd6T18Y2qCcep65ZubVbXk2uaBiDBMNduclbPSWYXEYlabw2Hkh3HXdAVHFte+CcgQholC4G
 HzzRJ3pA==
X-Gm-Gg: AZFdTZf8xNtc5U/b/2oF+QHtDUKd427RyQc0wVqh7H/qE+FDH96Hpc3XLVbk14cPElR
 jMmaG274W9Lk4uR4I7Fc7wH7j9EnlhRzkzS9OPIojnrs1ib8oqSTu2G8MLeNVNu+Falw9dMnDD+
 XNfJsSodpDhWm07FuBaD87rb6t8XYVTDZl0nRWq4X9btHPY5n82Zsh8bEyfij2za+Dp8ILT4wxn
 EXOEQ9MOgK7NWMOXy718wZs0ybbov6Iqe2RLW1KYz8yPT/INsRqGHZYVz8tAR1Od7WqgjQv/bAx
 dVa/OpO7YYnitIKAwsLn0FhIuTktf3JXf2qcOSG+XjBXb3VInnF2jhsQF9PiDFaIsMStqiuDJUS
 aFyIm0xeJ0bXzkJThxabD0KFeXso1sqFMmSjjE9de2O0KD59duBgnnBVziAw0Ry3LIYHZ1lFPxa
 IFWAZ7zC7nIFsMMWS/yDiOKt9Yl7swTksVcoXavkH3Q/b4fXEOQlHqD0lv5P5SVE3HMnOYYXZ1q
 a0bQo30drW6LH+qqKrVQWTicJCq+GEkXyj8dmynkvc/3/lQ5RNQPqisfmn/UnXmE3B7zdup7Gsa
 BhZdVGI2YtKXLIGQo2WMfI3apVA5mNZ8J4ENmDJplwoRXecFa/YwIejjvMj1gpcSD+oY1VTKzYe
 mZ1ZUydG6O+TVDDsgMT7An2zu31FqTbwk2UkmuqUXlY+SNL0/+5pKVqDDxfzQD1voGYCPW4HIro
 lAvCk68fzfMEEveIQ=
X-Received: by 2002:a05:6000:4011:b0:490:9af:d49b with SMTP id
 ffacd0b85a97d-49c71e3e1b3mr36323852f8f.53.1794926627947; 
 Tue, 17 Nov 2026 06:43:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d03b104sm29348665f8f.6.2026.11.17.06.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:43:47 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 14:43:45 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I06302e82cdc7c98503430500daa4ec95f5ce961f
X-Gerrit-Change-Number: 2212
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2212?usp=email>
X-Gerrit-Commit: d48e8499aa189cc2e576dc15f7e7dd142ff51e4b
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 14:43:45 +0000
In-Reply-To: <gerrit.1794924454000.I06302e82cdc7c98503430500daa4ec95f5ce961f@gerrit.openvpn.net>
References: <gerrit.1794924454000.I06302e82cdc7c98503430500daa4ec95f5ce961f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkkwNjMwMmU4MmNkYzdjOTg1MDM0MzA1MDBkYWE0ZWM5NWY1Y2U5NjFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ed631e32f672fa04d9da1f6e0059772e3b92b502-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTKPa-000000004FF-2acc
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: stop polling
 the listen socket while a client is connected
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7190033439076426401=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7190033439076426401==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8mLY+/iDnkE="; charset=UTF-8

--8mLY+/iDnkE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2212?usp=3Demail )

=
Change subject: manage: stop polling the listen socket while a client is co=
nnected
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2212?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I06302e82cdc7c98503430500daa4ec95f5ce961f
Gerrit-Change-Number: 2212
=
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gian=
marco@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 17 Nov 2026 14:43:45 +0000=

Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--8mLY+/iDnkE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2212?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2212?usp=3Demail">change 2212</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2212?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I06302e82cdc7c98503430500daa4ec95f5ce961f </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2212 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Nov 2026 14:4=
3:45 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--8mLY+/iDnkE=--


--===============7190033439076426401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7190033439076426401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7190033439076426401==--

