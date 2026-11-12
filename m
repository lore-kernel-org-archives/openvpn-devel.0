Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88168606A215
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XMEm3VWN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jUd17Bld;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JaLzTB4R;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TjfhBs9X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RuMiXNh+TVQ+zMWnor+iekNhSdCOrFA7fYTWORucdgU=; b=XMEm3VWNYI2Xj4SbXwRhRJECMY
	WampzTLqRoUDCD8eJIrP/alr33QmvDUNCyp6PbgBxvaxuYdau+c5nwCEH0DxUlA4FbJimLlFzvnTw
	r3F+gMqk58tcmyE+kfTHWhq4BVPYmBx5NjVX4CnfAmXbE9RB4KszE1bVbv2uGR3Wy8Lw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYjf-000000005m3-0Lle;
	Thu, 12 Nov 2026 17:37:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRYjO-000000005le-0aCI
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:37:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XqJaMo4MyD1VjyO0Cnc8xyuPnr/w6qOpceYXkdiYKP4=; b=jUd17BldGCmiNqKpks3qBJJ96K
 JJPASdgw6Timmmu69Vku4IfnlhpHnLBcnwf283TQRzrpLMAwjYyqUSbTsu22GhpqbPs6sGknkIDgh
 38YC/e70dMKdLvfDYsXe2xyH3FvQ78BxV/b2T4xZPa8/ZKSp50hdSmMIP3RNhS/a4xQ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XqJaMo4MyD1VjyO0Cnc8xyuPnr/w6qOpceYXkdiYKP4=; b=JaLzTB4ReccsEU4R9kXqhqjq84
 LXZchylxtrXFklgRU0Zr/v14+j9w03hX7+bONB+BrrqH5svfOQRBtho0LXflFuiJJFAsCkTKM6kw/
 +M1ItCZDQ+1Iz6tkvsEc2f8zJywAB55oydYFktZmYay7o630rhFUQKpwWR/iAE6EW2mM=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRYjM-000000007n8-31Cg for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:37:02 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so609385e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794505014; x=1795109814; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XqJaMo4MyD1VjyO0Cnc8xyuPnr/w6qOpceYXkdiYKP4=;
 b=TjfhBs9XLS/sJykAkFjUAR/J57Y6tAovwC/wQqhjyeBECzlZ552FoZ9PD+dBzWLJ/Q
 A7zw6x3Je+hJ90L5nAyp/DcsszwmFvPu7k6uG88NBTNl+u82HbO+L0z79wajhFGyHmdi
 EB6lW/oY+TvwJxH6TmGw8y52uEx8sYbb0nFz0Xb/g9FUHt/HV1RJlv8bGu860wkLf0ts
 dM96nwcQoigD1fN91KVr0bbfXJSDLDoylJBvcd/nl361pwW+1iC2osMNwKzfAaAhjSkz
 Qj1MtOcGIKY6q0/nFXbONW/cUi2qZRA38+qpCQj6jbhrRXXjryy/k7PfTiBjojoibN7I
 /AVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505014; x=1795109814;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XqJaMo4MyD1VjyO0Cnc8xyuPnr/w6qOpceYXkdiYKP4=;
 b=QTn0aEmcds47EJCQ61/rz9BvLGQN0vOwAXTnMnRhr5gftCz2dpQQqVzw4+KYkVKO38
 4tbO6W1XTwqkgPaF0uTVcoWBWQa+fu+qFHjz6bfcnQnEvjh/bQbGd/r7ah9DrKTbwVQW
 w0dWWLyPj+KYEqtmsrf3IVGg52eQtPJbu7VWni/6OO9Hw9mq7cC+wkvWr2Ls6zsy7Jib
 6OID8CD9z/keX2QwX8Yqvc16T9GmL7cfEYmafOrYTN/rSRx6g6Y6atsK4v1fbDVuBN5I
 NcKEiXxDKQdijy+3jX3BFAzeDJ5fgvwpxOCIbI0OjjFpsyiTrlUhgj7QFcTRlgyPJx9j
 PKhA==
X-Forwarded-Encrypted: i=1;
 AL+hErFlPTSF+3asJPPaA7txkyWQBmhV2stn8En9S3l2gad7nG7dTFdLVI6j9TnPhOBKzLzH9x1T/2l9CXZDsaU9@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8KvbWh1FKf8znGxltL8zwhHaDCe7DtrQ5peQSiFQWjZuh8PV9+
 LtfQzKtZ3AFq2yIqxFeVrnAQik2+FfXcsymRARPhI9xub/urgFK5gbBH9J1M/+REGNT1ifnJPE9
 SbEEhZEjdCKaLb2y7bpJdcXAI3U7oPkJkfYo3IYab1u0oWTcqS5aV7TJ82f0g6++MpjOWSQAGBA
 ArfG1Uew==
X-Gm-Gg: AYBFou2VkQlGS7xh981x3D4WtGTFUAhCg890aeOb0KLT/T2jaJoaxJ3QqKDnHjhcZ64
 aSaNEcZwla7nyWKMbmDp3rzWJFgSdkCkdL4Xjw76YHmTjkpVOqalYQYXSPc8qWwXIlwb3vOlrRZ
 mow3zG+KC7NYV/I8iTwWv7w2Qsua5/lbMQQWZRRS43QfK3k1yIXJ0FIfXMSY+lbIm1IzpQ5jclo
 iF4DYBvGv7v/zTfS/XXe3m5ZpyYOtNAI58WaBSOHmLfaG5X0ODQOiLX4sOHP2qGUo+fgPaYmHmd
 7UNJ2cpUQYygAtqb1a1pbbR4J44Hz4EEGzvLIoSG/f6hYd3C2Fpv9CUlC1d+RLf2sJKjNH9YCdu
 o5zV9Hrr19hALtfUFw13PoFxxBypQh4qNWV2IuDg9xFF44J2+ml/ABl2pOu1g9v1e9mBKrJgZE7
 hkh6L2AlC/bCsrMkEIY2EMihBTu2JGGAkvI4c7qjVQ8nzwj0zz5P5BHud29QP8j6h+sjCQAyFvV
 y6NGwRzQegyyhbS39Id9DymkOgCSnSa0sx6fgU4LUfHytWvfhX5DGg+/cItKAcu/2UI5elJbLxG
 41nVkdQEARkuKHsz613lPTqr3Q6IKOtxoCOs88UVoTfI2knRAi0+UPzTJBt5Tt4xufU0sNdhL02
 3jWcC+IXVz3CnaOqvKOYNIL4nDWm8rtdPXs8ZpNxcfg8rVvSunDaFI95mVG06sZqPa/pffu3dhx
 ZNFvgHRxKNEAFwjX4=
X-Received: by 2002:a05:600c:354a:b0:4a2:1050:aff with SMTP id
 5b1f17b1804b1-4ba0939cc9cmr119974795e9.6.1794505013897; 
 Thu, 12 Nov 2026 09:36:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c6451sm427786f8f.45.2026.11.12.09.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:36:53 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:36:51 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
X-Gerrit-Change-Number: 2177
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2177?usp=email>
X-Gerrit-Commit: 94d1c3ad8e783a6f7831b2d676f80a276bfc45b3
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 17:36:51 +0000
In-Reply-To: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
References: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkk2ZjVjYTUzZDQyODhiMDkyMTYxMGY3YTNmODRhZDU1ZDJhYjQ5MTE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e0dc47336f25e58eca961152e8c52749d2385360-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRYjM-000000007n8-31Cg
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking_sitnl:
 Reduce boilerplate code for parameter checks
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8647125731238450971=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8647125731238450971==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yh0XcWVZRDs="; charset=UTF-8

--yh0XcWVZRDs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail )

Change=
 subject: networking_sitnl: Reduce boilerplate code for parameter checks
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:=
 Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2177?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6f=
5ca53d4288b0921610f7a3f84ad55d2ab49118
Gerrit-Change-Number: 2177
Gerrit-Pa=
tchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Thu, 12 Nov 2026 17:36:51 +0000
Gerrit-HasComment=
s: No
Gerrit-Has-Labels: Yes

--yh0XcWVZRDs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=
=3Demail">change 2177</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2177?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2177 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Thu, 12 Nov 2026 17:36:51 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--yh0XcWVZRDs=--


--===============8647125731238450971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8647125731238450971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8647125731238450971==--

