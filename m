Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F89606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Tv5u9MCK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=V87neS/1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=foSGcI5S;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=X0T5yTei
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7hwF/mAkprU2UVtCN7rqPOxne3xeEv4lnEYebtONfQA=; b=Tv5u9MCKQBA6OPq9w3SbnQVtok
	gIiiGlbBE4grl4pW5z5Q6P8neyQseRYzy6ov7dQ0SuQjyUx9jE2xTLG1jC8+lO/2xWQC1KsoRUOQx
	RLAQLI1gzgS3ZCrwglqxZ+11JAjQNUg6ViS9mfzLxY5nRR8R+BzkmqOoYNeYLRngXDVs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWaKX-000000002Og-1tFp;
	Thu, 26 Nov 2026 14:20:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWaKV-000000002OZ-2TeH
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:20:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tSXvGYYj5MxBPKunmX3o/h4T+i4RHdBjpikv6DVIrkc=; b=V87neS/1cAWHradhjLoqZUU8wx
 BuWeleDbquAKaDjB20YRwfGzTLIffUuApLOK0c4aMV5+Haoc6dfHoVnISFHj0CDdv3tJ60AdePkpt
 1oIlqaxeIkB1UrvIk/xrJDwj/1y+E5qvREIhxcAlmI3CGTAA4OJ9OBeOjK7MJ5FTVsro=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tSXvGYYj5MxBPKunmX3o/h4T+i4RHdBjpikv6DVIrkc=; b=foSGcI5SiBc8fKsQIvlIi0+7TM
 08XWiEfZicR4YQXRguG8qN0yDtJzPqf+1AsNIEXnLBf4ez0kt2QO9xd84Yffc9CkYTUqiPy2ki3QB
 hxz+auPSpgzPk7zqQt3cNqC1G58kq5V3oeAgR2JkkTktwU5j/1lXMvrLzY/QhHmc68xU=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWaKU-000000005Ej-0IxT for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:20:07 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so4435093f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 06:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795702799; x=1796307599; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tSXvGYYj5MxBPKunmX3o/h4T+i4RHdBjpikv6DVIrkc=;
 b=X0T5yTeiN12H1pgBV12LKVRVR9f4Mc4tbUBrSJJ3mt2/dde+hCqrwj8u3sc8Ud0wFe
 Zdb0gC6sHCTV5VG+/GEeqkigY58X0QVO8lX4OEe39CHJODGPvuu1wkyu4+238g3kFqhZ
 7av4D/9qR0djPs42x+gLXyjHhBtrOMpHutNj2Q18xeJsqNiJvltWFM5/JrWWlTqDPnEx
 y4I/AarVZE7v9dvowHeN+tTJYEoPVc4CgeISCjDgyNPWoIfZ7UIzEQ8Liu8bo30MAku/
 ha84kz472kD9HIXxvMbteGNpW7us6kaPs4nO2R4E/DFmpqP97GqvKmR8XMgCZDrGxH2k
 Sw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795702799; x=1796307599;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tSXvGYYj5MxBPKunmX3o/h4T+i4RHdBjpikv6DVIrkc=;
 b=yzJfMi+yVFRyXaih6mVBhNrSGxnRalZm5Wf8UbtmqqcRxP0NKT21I6wL5IPeM1yf3R
 PUfpQPDUjX1f5aGwdkFLH+BlDoiyQ6HYtbpRajmfgN9zInGQjvfb0UtApzcXAEtTuOIZ
 GOIOk5S4D5mC00XxLsJoMDFBxaHvs8R3VdGglP6EYa8UQoCOCo1/V7Rn3H1QHK9MNZhg
 BT4FYTQngVFfTNsOAJ2GIYHOahPYi2vosAWnAuZcF3QzB+yjnhRq63pQDCFQFRCnr3OT
 rZ1EIBmZAdH2ESMv5Lnf1LFC5vj+Q/h085gwuhtmj+kpWYpE8tSzCaiBNVfNQZHcUiNM
 Cn/Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEAqfP21TxEtNCEPxM6qptsnjITgXBZvHkpvnig+qgozarN0Ue9dxR978lBot7OY9Mktr66bQUFa3V5H0Og@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/1L8AYmM8jy7Sc/JROT7gwG8py08+/uoruf/SZGEWCQ79D8aZ3
 fiKpeidQC76oPlHNBZLQfXBqWFQKCcUuQtssutxpyzNTo7SLTyeR29m5jHGKN2V1J8us/5nn0VK
 7x165u9T6KsuC4gOKbfFHqnuhwhjpw3fWE4i1PL7N3emtTpMj0lLiri7e1E+R3A6wDd/w
X-Gm-Gg: AZFdTZdSpTqrDZ6BC/6dpzdC1rdk6B0S2p948vVd5RXliuz9XkYyTvaEPCenWKIcR7H
 h6EuMK9UrxHPQH8pi0iisI9ArJ3Knj/qHZ+B0+cH4EFa0NyIpEpZ5cQs2EEY15TQztQXcGRnqyO
 74vKA2d/xMxdDfS0jvDqtKq0PP9XXQdf5fHcXen15WvRVZwUUGo4j9qLsL8ucGPozfX5nILagIT
 rncJEbnO6+lO6J9v2Jt6NjNQejIhZd3MCINLXoegJ2eNC2cyEKTJDnmBfukObg/m9/X9QjKZ7rP
 5D9rQhaek8JS9xWibIBegW4574r4lX8seGc1NXTGuoMUbHyyDzbOOD8TN101kLsRN4PBKBABOkj
 JrEnzHAM2inaWhbMxeRfMPMG+LBfSz4nxo3vgOfRex1nX8N0xvQHOL4ENvswpjD1SZxnHAxuUZ4
 mG3lSu0vbo/Cp5qlSytZSQsw7SuGZpFWOrN6sQYuEYQZD1UDdzHOZtrgEYvvWqpIPSS1Aid69/o
 WisSZUxOGs3ntmNPU6zoyJef23Bu0ov48zYXNW2Af968UdyupYJ64q+W+XWgzKOFn8BZJa/ixUC
 sqRkZjEZcu9KTh/ySloN38P3Ox/RCXkv2OMdOI0zUm3RB8au4nJ9veXr6eIS2xvedAGZZAtdflW
 g3SzMT3hZGE++9PI5sl9HZpUAsBfAq02sOc3XELvYh3H22ipUFzGqFK/vLtdLYGKdBheuNiQ1an
 9vYuKBMT4zk3tNiTKe
X-Received: by 2002:a05:6000:111:b0:490:71a7:6f51 with SMTP id
 ffacd0b85a97d-4abb4c7aab0mr32334204f8f.45.1795702799409; 
 Thu, 26 Nov 2026 06:19:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b5f6sm38602402f8f.34.2026.11.26.06.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:19:59 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 14:19:57 +0000
To: Aravind O R <aravindor@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
X-Gerrit-Change-Number: 2213
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2213?usp=email>
X-Gerrit-Commit: 28db47113dd19df5188c5f995d49c648e2c54c0a
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 14:19:57 +0000
In-Reply-To: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
References: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTMzNzI2MDAwLkk4ZmUyY2JlYWRkZTNiYWQyMTg1YzRjZWU4MjRlZDJmZTMwN2UyOWUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <77d5691dcc723c6b4d317fcf6ec64f10bf0ff146-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWaKU-000000005Ej-0IxT
Subject: [Openvpn-devel] [M] Change in openvpn[master]: configure: add
 compiler and linker hardening flags
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, aravindor@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1857856958592942190=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1857856958592942190==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vFy6OmpAs14="; charset=UTF-8

--vFy6OmpAs14=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Aravind O R, Arne Schwabe=2E

Frank L=
ichtenheld has posted comments on this change by Aravind O R=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail )

Change subject: confi=
gure: add compiler and linker hardening flags
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: -Build-Request


-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824e=
d2fe307e29e2
Gerrit-Change-Number: 2213
Gerrit-PatchSet: 2
Gerrit-Owner: Ar=
avind O R <aravindor@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: Aravind O R <aravindor@gmail=2Ecom>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 26 Nov 2026 14=
:19:57 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--vFy6OmpAs14=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Aravind O R, Arne Schwabe=2E </p>
<p>Frank Lichtenhel=
d has posted comments on this change by Aravind O R=2E</p><p>Patch set 2:<s=
pan style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padd=
ing: 4px;background-color: #ddd;">-Build-Request</span></p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">View Change</a><=
/p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">change 2=
213</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2213 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Aravind O =
R &lt;aravindor@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Aravind O R &lt;aravindor@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Thu, 26 Nov 2026 14:19:57 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--vFy6OmpAs14=--


--===============1857856958592942190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1857856958592942190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1857856958592942190==--

