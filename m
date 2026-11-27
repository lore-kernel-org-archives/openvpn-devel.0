Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C850E606A33C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KexhCPYp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IATBlUjl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=l6glAOUW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HD/rE88B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DwmUqGTiGkvDccrcx0mE5a36AFBAGYPIq+J3mv0fepE=; b=KexhCPYpnWmF213PgwEhO5capy
	gHSwMLvMXCn1fKcZ6nIaNvtq/ahwVapZcoDLTEJXzV8C6TqEKZH+J99IHYiOBGdwlHWFmJrn3agda
	Iha0+6BdrEW5T9rc+63ZZtQ0htVy1f9pia6TjWUe9QyNR/21GePHN7sylHROA1kotcIo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWwKY-0000000046i-1Y97;
	Fri, 27 Nov 2026 13:49:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWwKX-0000000046U-0L2L
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 13:49:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pZWbc0biMpKdwiRkN16VnrvbxdgcC2p3YJKCcjsDuK8=; b=IATBlUjl0Lm2cUBFWP6CR58eEu
 xHm1/TbYXRUTz6FCtejY3aONVS70eEwzi7izW+UU8tEnhfAEaDTkyQkqqqnj7Jj17wKvrDEBagidr
 oA21fFW0rE7Z1U8phPMcMQMicJc1imCSt5p/Lpi70RROWNXK39cePZRnTqPLohk5RRlE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pZWbc0biMpKdwiRkN16VnrvbxdgcC2p3YJKCcjsDuK8=; b=l6glAOUWdw9vsL4VcDBj2A6gMn
 ak6dPaQCBmn3LujT5llkuQwZS5NvjCohfZaHefUGDHM3kWJNBYYVGjtCzx1gRxZkhShArl/cbBpbD
 EjPtSYHRKq69Zd9bzHoIChmRVMS4NTRLPCXJN8DEdNqccCz3/Q3AxaObVEtMN32Kieuw=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWwKV-000000005Eu-2c6q for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 13:49:37 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4a42b34e930so7109917f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 05:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795787369; x=1796392169; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pZWbc0biMpKdwiRkN16VnrvbxdgcC2p3YJKCcjsDuK8=;
 b=HD/rE88BrCkdCOs2eDE7tG8semacSr0+Xk0+XQ0k9tiSJEZ1zWu1CcEIpHXzrDhjHJ
 gzb9Bi6HLjFMnboWqr4S9fQCMiznxKLtohntM1n9UVScXJ35w9B51zTvAlErEdn4hkZg
 PXTKgIagZq0+jpowwqYGzjbITVIQyLHdgrw942Qjt3N8dxxTCfn5H16lxc2f0atRLIy+
 xWQmu800nvMfwe3z1y3y/fXCtHdJpeUkHYiTf3SOU90XWC2eG6oQTmgtk+vnLVc6Uavz
 i73OjFlV0QFE3dRslh01huAQwUzrvqBqF4ltE8aOE4qGxXgJ0R5zDXBaKG0lVQQEslfw
 GSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795787369; x=1796392169;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pZWbc0biMpKdwiRkN16VnrvbxdgcC2p3YJKCcjsDuK8=;
 b=0Xw70xp3g1egsHPAso950+0eynvVsVv2h3LeI23qvrq1xCGm+EUN+KuafIgt0HUqNn
 0k7LBjxBk9myassr7oTCL6r1mTyv3rl47eRaPImRr2GmdjZiUpuTSCwayMNNOOW4PQeO
 gWrKOjz++Y0pSKkQIDoE7UEKgyG8J2mgWo+mmRb9ULQ3CbQGE514twD8J27Wrkbn8+ZH
 DBbLwZoJlkmC0XHle9EhuJYXcCvVgkDqT2gYWApkKpTQxGidRR4c+pDJv/j9kPm7QBHy
 PG+taSKBIDAybZih0O4j7PAsVUBUwd49C1J+qTrC2UOiSQ3OL0ukX1uEl5yOcrcrvz7S
 ntYw==
X-Forwarded-Encrypted: i=1;
 AL+hErFBYHv91WVhDyX+CI3DgSSphxrP/ijhoq0M/M/wz+pai8UJtE4VedwNnN7P+wrYMta+tSh9IKw+XNik2OR3@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8RJwSBk/XA/5R9bmVLx3r8J6B/c8g/zSBa5X9VRpJVBYZwmT9E
 mHjXLdtEfQQSekSzQG7TDhpSfxpgwV5Ej5vm4xVhc3TtKHv4HYaISi/lde2iaifUFKJrYfGsZt5
 65PjAJvUddkmbYbWHq46NW7q+O++1wLAHAIchNcqGoWX5YrQVwKWnhkRRQdM6imdjN0k5
X-Gm-Gg: AZFdTZcA16mKKOjeXN4sfJR3HuBor8CsI44+wxB3jNxhvIW1W8s2EqNXwtOJ/6GSul4
 xU3VWI9ULoG5urr+AkkUaOBlIy9irjJ7oVxeGmSG1fu6THlzjajB0Y5zvVuTJXq7eSySt8ypZOw
 S1gBOgQPW0/zLLBBfSDmhPSmssJ9tDYshMvkPrN+nyBzmVGh5gMYJt7GbUeMm9IUx/cmXVhUHUE
 jh5ZsQA+/RLuHVOX+D54Pl8WH0wrgATIN/n2l9tPrGyAnZfxqpa7DfXaXP58o+DEm1OOU5X6N9M
 QIl2G9fwqNdss9VeYws87c0Zyw+AW00khmC1u+Ft4s3Eyvv0pPKg5+GIWUGpErdlWQ4dnsgBJhr
 SI0WyJYh2r9CHbk0cU4LkvTaXbvWhPy1c/s9ncj9qApxuGf1rOyBCeU3cSYN9EFfCXhlA3MBGkv
 y3ddoB97ybeXRqJ/I76FWuY3zGLd93gF9Y6RMoXHgZylO5lGHl/U9zVgqlAjOADQTahgFN1KfJ9
 kB3U4A6blizp8K1ESFPJh36AFKU/YJ8njc0LQe7Wg43HtsWiFWEwecpEdIbl9HA3vNsp4AMMmmM
 lx7dOV+w6OO1EImNTDPtv4c5lyMIx5usDml3oKZbpfLhOMcodfVhs+jw+OR0R4+l4uf01Wpj6lp
 C3ETs/MUtXWmhPYgDK5Sdpu4Y2xMJzODdy9fdDRL4XsBEEuLJPbfIjANzuPVsODEFgddUzeaeMt
 oN2F8I08Vd0i6UHOQ=
X-Received: by 2002:a05:6000:2dc7:b0:4b7:6d41:eba1 with SMTP id
 ffacd0b85a97d-4b76d41fcfbmr26532283f8f.18.1795787368614; 
 Fri, 27 Nov 2026 05:49:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c340df4sm54131133f8f.55.2026.11.27.05.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 05:49:28 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 13:49:26 +0000
To: Aravind O R <aravindor@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
X-Gerrit-Change-Number: 2213
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2213?usp=email>
X-Gerrit-Commit: 28db47113dd19df5188c5f995d49c648e2c54c0a
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 13:49:26 +0000
In-Reply-To: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
References: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTMzNzI2MDAwLkk4ZmUyY2JlYWRkZTNiYWQyMTg1YzRjZWU4MjRlZDJmZTMwN2UyOWUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <72dfb11a78e7978878d1777f917e3a2cd74615f9-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWwKV-000000005Eu-2c6q
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
Content-Type: multipart/mixed; boundary="===============8194849413917188785=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8194849413917188785==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uJEdIyeDvnE="; charset=UTF-8

--uJEdIyeDvnE=
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


Patch Set 2: Build-Request+1


-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824=
ed2fe307e29e2
Gerrit-Change-Number: 2213
Gerrit-PatchSet: 2
Gerrit-Owner: A=
ravind O R <aravindor@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Aravind O R <aravindor@gmail=2Ecom>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 27 Nov 2026 1=
3:49:26 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--uJEdIyeDvnE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Aravind O R, Arne Schwabe=2E </p>
<p>Frank Lichtenhel=
d has posted comments on this change by Aravind O R=2E</p><p>Patch set 2:<s=
pan style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padd=
ing: 4px;background-color: #d4ffd4;">Build-Request +1</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">ch=
ange 2213</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2213 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Aravind =
O R &lt;aravindor@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Aravind O R &lt;aravindor@gmail=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Fri, 27 Nov 2026 13:49:26 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Ye=
s </div>

</body></html>
--uJEdIyeDvnE=--


--===============8194849413917188785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8194849413917188785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8194849413917188785==--

