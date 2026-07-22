Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70E3C44539
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OoUWwGjFxuuqcd3SUIzTq96UcCXuQpZCbDcDqsP1MqU=; b=DM2hcUPq57+24G5m2hoByF6DZS
	HYJoXtNht7a1g3JRxtjFLnVdOtb9aFz/oIRVHD5bKoXhL0nZrkOE0upr5dytfukeXDGQc23p6PGgo
	n0j82tClkRGZL06AiHckKZNF95tfS39o6iOBCUa5XWqKkJ4ZODyQoZe+RZVfGx3KAcQ4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmX0s-0008GJ-0b;
	Wed, 22 Jul 2026 13:29:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmX0e-0008G4-41
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:29:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TDOcJj+6CrHfP320eelDVd7ra/2GEhpZdsecRl9ewT0=; b=jmFLgGc4IPB+AMFDZBLljEtDrw
 gOGTUA5+Rmx89ka1Z6ft2th/Lfko1FOilIXPCwYWf18AA1DLFm0Gp1cdcQmDV8Swzzguw8pmYVyM9
 e9eUA/wppdDSkMhIe11Q3sKHYVBFuxq3uI1CJ3UkM5LlqGSTdpUYOlhKzgzUOyML2t7Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TDOcJj+6CrHfP320eelDVd7ra/2GEhpZdsecRl9ewT0=; b=m
 woXbJ4KFhKMG65KxZCQzCVXWrjTEEuPz5cfoAKwKSC96v+uSAWB4HERJU66xSyZmfJVYeaTOCEM25
 XWEeBxSWCOi0Z5l2+fM56TCXGtINyQ4gqLJMzBwImifKoTCNQwA2PYSeOnmvYPRhzrKCUdzJBTc/N
 IoaU2t4+bvFU7Tms=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmX0b-0007W0-HG for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:29:15 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-495437bb891so51401085e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784726947; x=1785331747; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TDOcJj+6CrHfP320eelDVd7ra/2GEhpZdsecRl9ewT0=;
 b=RFUX/ckbR7G5r9xZtQ2qmWi5MliyM4FnZtggQ3dTAsC59DpWRpkORcDA14d1nVmqDD
 SuR7WLEssbcv/HTydOh1pyFmDWTqUyAynUL5lqWrV+5icvL8ueKvuRxsotQqjRnQBUpM
 gvC9bFXnRlfRzNwqT7ByLp7GvZM4tUIIOLG0T8SOX/CV4+ZX8GeUr5JdkfYJq/Pe0qkK
 /g9IARt8JUh+cdCTPgJ5D4ct/aKlidOvkNWYv5f2y1M8o9SAbIulAV0774BNZwChyv7A
 rSFbbaTKDZY/4/OS+trmmICZYyeU/AJPddfdbr/XIc8xq4JkW39n0uD6NGqSwlgC8IVm
 MRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784726947; x=1785331747;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TDOcJj+6CrHfP320eelDVd7ra/2GEhpZdsecRl9ewT0=;
 b=MliNGFGJqLI8IXtNilHMFZMvikbNOQHpv1wWh9kex5Kf1PwQA0wUxlPs3as1EDFPAf
 RdVpZIipaVJygp+jMJAowwlSp04QuJ1dcz6U9WVn78EqYaJiWqMYEPh4TWDi4zaz+yUV
 ej8uRCfNwOyMh3BiLCihHuqmBGD86np4ElMU5Gagkj7sInreCEK1pB0WB09eBteN8omu
 Ybk1zXIqukrEGc2iI8h9jAJbovIDeJFh+CeTCGES7G3w275jQu8d9+BxpI38RPFMUset
 86i5jgcG3ba3F8z2CJp4eG29nnDHh01ZwVFUeYHoMNxLi9WNnEHO+eSsECWYDv7iENSF
 wmHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZLCs1Q7VjOobtroC8R8seOXqwfL5vido1jX49Cb7ly9ihcv9C8BQd3kY1gRQ2gfbyDG4ZPApQYG96bJqZ@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw1FMmwG3O0dCLvQUsq3NZK0q5vEHMl+4ZRlv9EAta6NSFwvel5
 7+ydk5nsLdRt19gvwcd2oMzZAd9WGJR+6QS/G2syv5Ls6f4rM9h8ZEtbeMC9qA6pp/a2TNisBwq
 J4FAZ4xbwDMc0bmhYwp30djcC2CjeyPapjqBYIFpYPBe2F9mY3GVdO5JjK3k4tR1DsB3l
X-Gm-Gg: AR+sD12D737rvd9DLkDnGq/S+mzhFnVV5iFMcaFWmvhHBiZO61pkdWYfc7NkxJqhGob
 2haYra780UTjAilWFsK8DfNhtaayZF9Ns5tPIjimMcuiKHppWrNmMfL0OgEe9SPOx77MoUA6B3B
 pI685aIOk38H3BDPdjd378I1HGEgak0+NmihzxVLzNwWZtVEpEeYgfpD8IOq9I2ulM8rW31mJp+
 Q0++O0Ax8C7UcFeWRoXBy/S7wmhKzAyRIKHqZxfniLurALZFoEvMiTJwqZYrf98EFahzt4wvlK2
 QU4mWv/712onyALWdtkMnUj6cxhsD90IF8EG7+Z5Gs8Ml6fIUAjxq/BJfDa/EvkIbSJcfhPNxdS
 KsJsnYaZe3pHlqgaDBuZvApEi2bgM3Xszv5F1JRBjIMM9uWGtxocZya4t0RkGVp6+xeMusLeB3U
 WmUF2mOqh/t2e1e4njcqp+4bt4gCReFPw8usp4LiZeDGMDyUKJVVz5bfWrMyK3nMQkZZ44O7Mrb
 VW3SOADx6S45nAz+mWYhQNZM4LQAyUMA1fzCSrEFR+nXp7AgIIxrJxMOLO7K890iQJB
X-Received: by 2002:a05:600c:1c13:b0:495:4f84:7280 with SMTP id
 5b1f17b1804b1-4956a4e5a7cmr45371695e9.4.1784726946805; 
 Wed, 22 Jul 2026 06:29:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c9d99sm152890825e9.12.2026.07.22.06.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 06:29:06 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 13:29:05 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a
X-Gerrit-Change-Number: 1801
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1801?usp=email>
X-Gerrit-Commit: c2377404b5dc4a9c545ab38800bb5af606130c82
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 13:29:05 +0000
In-Reply-To: <gerrit.1784724772000.Ic183f1f1f90561454b7b1128c95255368427cc4a@gerrit.openvpn.net>
References: <gerrit.1784724772000.Ic183f1f1f90561454b7b1128c95255368427cc4a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzI0NzcyMDAwLkljMTgzZjFmMWY5MDU2MTQ1NGI3YjExMjhjOTUyNTUzNjg0MjdjYzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <301a0a4a98cb5f5e451eda7e84678e1e45b9c3a2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmX0b-0007W0-HG
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make
 --x509-username-field work with Mbed TLS
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8664528881017448241=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8664528881017448241==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4fqzeGBt39E="; charset=UTF-8

--4fqzeGBt39E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos=2E

flichtenheld has =
posted comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1801?usp=3Demail )

Change subject: Make --x509-username-field w=
ork with Mbed TLS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2: Code-Review-1

(2 comments)

File src/openvpn/ssl_verify=
_mbedtls=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801/comment/eefec=
eba_1fd4e696?usp=3Demail :
PS2, Line 245:             if (cn_index >=3D cn_=
len)
Strictly speaking we can abort here if `>=3D cn_len -1` since we alway=
s write 2 characters


File tests/unit_tests/openvpn/test_ssl=2Ec:

http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801/comment/320a3e9c_7e456dd6?usp=3Dema=
il :
PS2, Line 844:     ret =3D backend_x509_get_username(username, sizeof(=
username), "serialNumber", cert);
Probably should add an additional test to=
 exercise the length checks?



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1801?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a
Gerrit-Change-Number: =
1801
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit=
-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>
Gerrit-Comment-Date: =
Wed, 22 Jul 2026 13:29:05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: =
Yes

--4fqzeGBt39E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos=2E </p>
<p>Patch set 2:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1801?usp=3Demail">View Change</a></p><p>2 co=
mments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/ssl_verify_mbedtls=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1801/comment/eefeceba_1fd4e696?usp=3Demail">Patch Set #2=
, Line 245:</a> <code style=3D"font-family:monospace,monospace">           =
 if (cn_index &gt;=3D cn_len)</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Strictly speaking we can abort her=
e if `&gt;=3D cn_len -1` since we always write 2 characters</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/te=
st_ssl=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801/comment/320a3e9c_7e456dd6?usp=
=3Demail">Patch Set #2, Line 844:</a> <code style=3D"font-family:monospace,=
monospace">    ret =3D backend_x509_get_username(username, sizeof(username)=
, &quot;serialNumber&quot;, cert);</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Probably should add an additi=
onal test to exercise the length checks?</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801?usp=3Demai=
l">change 1801</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
01?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 1801 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &=
lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 22 Jul 2026 =
13:29:05 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body><=
/html>
--4fqzeGBt39E=--


--===============8664528881017448241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8664528881017448241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8664528881017448241==--

