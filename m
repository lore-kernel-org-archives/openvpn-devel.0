Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE81606A31E
	for <openvpn-devel@archiver.kernel.org>; Sat, 28 Nov 2026 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lZe8ZFnT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jZNoZ5mT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FJzF4AVh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Cq3krY6O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ihSSx/IcUuMO3num00kbDhzgs+qYeAdhkw8JP8ubO1Y=; b=lZe8ZFnTuz+nvJJzMqXfPgzV2K
	slZ53N3rOWhshbBPUfbys9rsiNmYWGpC0Pl+kOyqVE2dO6+YoiVH53wy3MyqkNN6SGnqaFzz37Re5
	J+syBDTjRUsMctTRbatHVa0QJsZkWQu3Fi/GtS+vNBvHGojEap3OF7zTCIZUQK9Hot88=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX6kr-000000003yr-2kuS;
	Sat, 28 Nov 2026 00:57:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX6kp-000000003yk-2oOm
 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 00:57:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i47t7kbX5IjMluc4ZsOVwW5JRyXP8Gho32vEVSG1nec=; b=jZNoZ5mTq4hHuykwqrVIjrX9EH
 pTwLm0Xq879CnWX/Ry7IbhSjORXQsMy2G8+KirdHzpVA5VXW6ATwA6XLtO/Bnle8AhVKWX+MxDgaR
 oz0qwwaKXbjVHsse942gXW5y1M7Db00WOI05zs4qossvUD2I9M6I+3RkSgAZkmWd7J/I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i47t7kbX5IjMluc4ZsOVwW5JRyXP8Gho32vEVSG1nec=; b=FJzF4AVhHw2inMbmaAqx8EgxJw
 8W+KpmLgNeDwyLQ2jVI0Y8M6PWQ5VmW9h23xCF9N6fMQSbpBT8gfMR+UhCh3MVpFEk0cvICS4u4Zl
 tXxIMjjcoSxtJbcI0rAjwtA7cG5IWmsC9MDAfC/n8HKzLrDieerLNMhkgil0I6X23ELQ=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX6ko-0000000073D-3pn3 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 00:57:27 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso83848965e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 16:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795827440; x=1796432240; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=i47t7kbX5IjMluc4ZsOVwW5JRyXP8Gho32vEVSG1nec=;
 b=Cq3krY6O0lIqaL5RMqDbC5Tu+tsxEs/mWGoh+3MnBw8VZDGzuhgA4tcr5Zz6sVNzZF
 JVPbFFQMdbWgEX+QXLfwX48eltWv0dY+WIyI9oEDe5NpmTKWXnjjIBTRVOWTGS/DLT93
 btqUO7yzCis4j3B5COpKAlFFxorb9RPw92VW3zxhM88e/N3DEFVHAZUyLkFo8Vh2Ixm5
 vMFCbfm4R1KqB/q/M+PN3owePSgclHbW/XQ6IkRrd5P5hsNWUG6GZVQYl2FRF7pn2R5x
 vyXlXd7xmLIB7JmXuCJR26eIJoZeZXK0J118/6JJpUJI4IQrvDFunHU+CaKTP4/5mYSL
 yXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795827440; x=1796432240;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=i47t7kbX5IjMluc4ZsOVwW5JRyXP8Gho32vEVSG1nec=;
 b=2Iz5+QI5YI5pSe18OBOT8b7UdpRw6bNfqHiUw8JvurIDOeL5Bk8XmZxH3AAwry/HeD
 npK3phJ9eVs5Gaf/yQdgoZ9v/tDG4dkob22EFX5WFhYQeHcyv3Z/bZBDrlutcEfEDlq9
 lyBTU9ZBUP4K4ruJFp905p8JH3732i2KL6xxkV0AB0brgMJ7X2Oe6+K6qGyqUMM0fRKB
 vtVI4rW8zhgIOepFuvdkHDy/VJrw3xo3qwqDZJ5Yw7drdLBfw55da+VX8t66kT94714K
 PxvJJdUN0GlTcIqUnFiaFEkX1C/QhEVlEGxvracbEtCZ8+oCnnF4RjZitGU1pKfpY6Jk
 biug==
X-Forwarded-Encrypted: i=1;
 AL+hErFmbWz+4DfhOoLH7K32dWkkJlSJxvGKkA2Jj/5hSdOVw1nRIWuSv9YuiVQsR1DiJjehjsCqEDMAQ1WasCkX@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8N+38/vzOAVXiuRvRAZ7aUHg7kfcKhhWLU5uH8Fupe3jXUGmm3
 Y+s28SQB3Nq9YzsfHCWECuBt1qsOs8Q47EVeUf9xh4TKdvZDQdXJ5IMLEmOkeROf8kUJ5z+uoNr
 u3FcUOo3eoWGXYbgm11B6nMEybMLj9hscOZsJRzJY/Jv2vwkY69EkPa9DU7NSr+abau+w
X-Gm-Gg: AZFdTZfqs9h8c1pzv4HSED3fBXT4ZqEiqY45ylxU1NLKdeB9j6cnOqIFiGk9q1KhXRT
 tncHFGS5voLjsphiofXM+OtfqXG9epQsIg9kFcVSPmS9d9LOSb/tUp9Wg41dVJsn9/GalHMLuQA
 s61kD582kugK69UBDN6e5fAkVSErOnlUhglFDRAwEa+wWg8fxE8VH3jPNejV17sKd3CEju8QSEE
 7y3A8B/3C3ZhacGxGsbQPYMxPJ5C3luGjP8QLdkUYwB09UlYzzD7emwnkW9CDhLNzO7sYkZzG1o
 uiwWbkl9kf5V/0/5NP+I1o35uwJgJ4eDQ2QiLFpC3E84A2omH9YN0OpKChQ8CvjyMLlp3PXBAIy
 lA0AIBLtKRdt5XLRdvRxqmkTm/YBiU9ERT/ZaxR2+lo22n+Smj3l7mVO83JG0Ux8T4r3irtx5eu
 BehXj5I7A7DhzUMwYOv602kK/pIwc2pP+wKItOaLy9MT9fOfiaBHpM+G/2qMOm5qzB1tGj6gyNt
 udJVb/GP9uYfww3sk+WALK9m4FgTS9LW44piAu4cVwyNbg1onHGeiO2vfYDmKbxHcl7nLWTFv7o
 Xrudx4JjEK7Kv9yOOhkd4EkK4qSp/r+AWAIYvk7FieM5QhJS1GBgcdsi1X8GK/NFtaCuhQksaxv
 fL+ZfxDCfRHOBYrd8RDFCjetHG3bbeuAmPyvJN2ZQe4JVwTwOd+SEIjmvVr+njvhUvzlPHRIlPH
 qejP7+FVvqLmAW/K4=
X-Received: by 2002:a05:600c:3547:b0:4a1:c27d:e1a8 with SMTP id
 5b1f17b1804b1-4bb8880b88fmr521835835e9.10.1795827440341; 
 Fri, 27 Nov 2026 16:57:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm670075805e9.9.2026.11.27.16.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 16:57:20 -0800 (PST)
X-Google-Original-From: "Deri Haerudi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 28 Nov 2026 00:57:18 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968
X-Gerrit-Change-Number: 2349
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2349?usp=email>
X-Gerrit-Commit: 674feefac7d74f2a9fd4b0f38d763f77bd958f27
X-Gerrit-Comment-Date: Sat, 28 Nov 2026 00:57:18 +0000
In-Reply-To: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
References: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkk1ODQ3ZDYwMmEwMjQwNDRkOTEwOWY1MjFkZTc4ODVkNTVkMjhhOTY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0e3686ed461b690153b967034fd083296a953b29-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xX6ko-0000000073D-3pn3
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns: restrict dns
 var names and values in the updown runner
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Deri Haerudi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: abcderyscreenprinting@gmail.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 heiko@ist.eigentlich.net
Cc: "Deri Haerudi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2501040572942257146=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2501040572942257146==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ArjTi/1couM="; charset=UTF-8

--ArjTi/1couM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund, R=C4=83zvan=
 Cojocaru=2E

Deri Haerudi has posted comments on this change by Heiko Hund=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail )

Change=
 subject: dns: restrict dns var names and values in the updown runner
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Co=
de-Review+1

PS3 only adds the Changes=2Emd entry; code identical to PS2=2E=
 Re-applying +1=2E


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2349?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I5847d602a024044d9109f521de7885d55d28a968
Gerrit-Change-Number: 2349
Gerri=
t-PatchSet: 3
Gerrit-Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Deri=
 Haerudi <abcderyscreenprinting@gmail=2Ecom>
Gerrit-Reviewer: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: Heiko Hund <heiko@ist=2Eeigentlic=
h=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Dat=
e: Sat, 28 Nov 2026 00:57:18 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: Yes

--ArjTi/1couM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund, R=C4=83zvan Cojocaru=2E </p=
>
<p>Deri Haerudi has posted comments on this change by Heiko Hund=2E</p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">P=
S3 only adds the Changes=2Emd entry; code identical to PS2=2E Re-applying +=
1=2E</p><p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-b=
lock; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +=
1</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?u=
sp=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;">=
</ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2349?usp=3Demail">change 2349</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2349?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2349 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Deri Hae=
rudi &lt;abcderyscreenprinting@gmail=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Sat, 28 Nov 2026 00:57:18 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none=
"> Gerrit-Has-Labels: Yes </div>

</body></html>
--ArjTi/1couM=--


--===============2501040572942257146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2501040572942257146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2501040572942257146==--

