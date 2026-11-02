Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A5606A337
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DQac8jOg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=S69adaMc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kv/C7nRS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VNYUsgNb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TZuP+DKV9BPaZFQ7L8qVsCW1/NTPPOB0BI+kBtF1gi8=; b=DQac8jOgMUhdyD8xC6ywxnOhyv
	YaGI80oJxqt62r4Gw5KL6LMdAluNb9pec3Zmgop7PPQIfVGvi5mJSV98SixOyof87GZNa90otENod
	1GuAmzaUUrL1QLOa5RvcGOeWC6s2yvT1pSZxP+zHZCs/7Y4VsKXrXDbzchyd5hEF3pCE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNqfb-000000001vO-2ACF;
	Mon, 02 Nov 2026 11:57:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNqfa-000000001vH-1uKZ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:57:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2c0AI9bPxq1KQx092hdFXAHFsDuXJOq/C3TA+tUPofc=; b=S69adaMc7EGcm7A7iutORbxB4L
 LEy8IfcRou+EWlxDhT+jNmMypmY2x7gXR7NuCFXO5uy8U7KM+dIHdhKZR72YqCepmGYLYbCaKJnPi
 48fDgbpRrp/7BFqYD9e7ECm/YjmagMCbgHGwflnNQItC7AhWK50+kecjLymeKQFRGrnM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2c0AI9bPxq1KQx092hdFXAHFsDuXJOq/C3TA+tUPofc=; b=kv/C7nRSGSAHcLJCIMzJEHcGAI
 wa59BZAXI/0GZjBcLS4TcgQ4RxfaKehim+lbFsR9rBLJVla0MJ3WQM2+zl+ljPz2SEJE4juGBhTV6
 zq1sBHKV6GmoUseRzkJlfAWE6qwjxuJ0Akt/uGPn0cqaTc6hwHU+F8Zb+ptddN+BQSLA=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNqfX-0000000065X-3jLy for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:57:46 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso28633085e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 03:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793620657; x=1794225457; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2c0AI9bPxq1KQx092hdFXAHFsDuXJOq/C3TA+tUPofc=;
 b=VNYUsgNbMtOpMWWgTDbpFkLULNbpr816DD/RI8Ji4KRfwXeoVnj2jNSrTICOIp9MI2
 aK0Pvd1LHw316e9B46F60KOAO01nKEnWV0temrYcTGHfuxL5AVwCPNXEZOEdxkM6hIpX
 8ox+mNbNZdgchCt33nD13p1nkuL7vEBtNQf72HApFxH+zGiKeZc+i4NLshvjSzE21VLb
 endRihhfJ40Y+NVCMjv2mTb9fER+p8g34ZT8/9o8LLw31kA6EBBixPu8LwPtsD+k2IYR
 52uq51o0yTLHHQ7I+YLpLQw4y9S4Zng1wkSD53iHh58/JoH/+GQCqfIZyCUdaj0RqLXG
 wr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793620657; x=1794225457;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2c0AI9bPxq1KQx092hdFXAHFsDuXJOq/C3TA+tUPofc=;
 b=oU6920LGiWt5xZnPEZ5eoMMCMnQsl6ckotry3l2NfdVrvmuXKgDz1mTvSMwyPsI8Y7
 emt0JWjMNXCTdVdv0D2BQEzAvBhOfAncs94qd37DigDW9YFpnrmBOFSWFHngATg3Bpv1
 +xsEIqHVHD5ricIyYB8EGBXCyCJZIg0/HCTmtevXgsf1dgxdIbE4VamapSwoTfE4uW1b
 jNVuf0kI/5E2SVTEioNENypfZYEncRq5p8TYQoN5GMVi0dbqSLFHiuN2wxWdPAKTBGRQ
 kHi3wnZwwqVepvdlxViO9Jd7JlrnUZOTfKQKGtflZZPzr4CZ523c0QsHlmx9wqS/ADXl
 DFxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjaQzI5bFTlgPj76J2nGEqVsGUBnToMmfkX4U0amEn+4gmxG3SBd+/GamG9YgbHX7IgndDwbghlJIyeRcW@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJ6nw1V5jCJvtxH5kWj4SNplCJVdCTf4sncA33Pqh2cDVK460MU
 0m3cgD1Dd4kJkQjkgTsQIxiMy5tqbTOA9GVt7XigPuJ/haD0pdWYlY0FQcD4IBP5asDO8iB0pJh
 GrLBurXIZjyW9UhVgRKInD+jjwVkjQ099WpZzukY+AN4jZePNBw9Faq2XFDwlkPout7OT
X-Gm-Gg: AYBFou0ZpVWLpA4d+RTBj/dXXnXZXsDs8nmtlWvI+S/slcOOj7W4MAwFnhOv+aR723X
 mOyc4/fRhybjDgVFrMtbqQuHlcHdml1AX9jcHsyHX5Yr9Y1Eg5pjwJa13/xr9V0x8A0HdjcvXyV
 MjzqyPlXR5cgAld5sQLASPCuxIctnfR7D0uyQCNrHa7Wndqg6SD1UVARnf3MqJds42vLTh+8WqG
 h12+K0ZgGZJlTHPNxNAwgDN1A3KPsbgOGzn1V/QSvBw69Foe+Ag3AG33oS0xME9sozKd1uqIyLH
 k7vkpzM+qCZI7cq27CL6oF4CgW9q3OPy3xBE5koLz4YhSxbudpPmTy5UXVHJXh0r7Lg8kOuYqNe
 uTqsMcmpzJMR2pxh1IpXae3nBi4OSqhvRcyl27wCwVHEJX8VHQFTQdi4ZiykVr4pqwFN1WGRRTh
 2AMJg9X4U09l20WvM2pwjWUo7mZfQhE0UJ1rhTkjgy92OzrqVup23z5X7QQJ4Ap0Sa9nty0tbPL
 DGS0mTwMR++/fM0Rj0Nq/oNdFL7mxl01Xpd9lI8ftxZTxvsbKXNSyWAyx+YYnKhU1BjjZEDdJaz
 1xvoOYtNsQVT/jXQF9PgHnlhumS9snd9mnXTSrDUc7OMaCmbTS4rnImsSvQ7Sh8sZMPVCyHmprr
 JlNszpxOBnp1zfE7YKIrhKxzqu2Bh9jKzYgkkikcL9xfw+9rXK8b0dyYqZoJds3e6NUe90NBSjX
 P8x9xxPZlgnAXPI9U=
X-Received: by 2002:a05:600c:354c:b0:4a1:9663:7639 with SMTP id
 5b1f17b1804b1-4ac18c7389amr236977785e9.34.1793620657295; 
 Mon, 02 Nov 2026 03:57:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f3229dbsm333664465e9.1.2026.11.02.03.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 03:57:37 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 11:57:34 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia3f6dd4ce35869c92619ce0c56eeda8796bde006
X-Gerrit-Change-Number: 2084
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2084?usp=email>
X-Gerrit-Commit: b85c15846fe9d108e67157b5725c666d260a70d8
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 11:57:34 +0000
In-Reply-To: <gerrit.1793618639000.Ia3f6dd4ce35869c92619ce0c56eeda8796bde006@gerrit.openvpn.net>
References: <gerrit.1793618639000.Ia3f6dd4ce35869c92619ce0c56eeda8796bde006@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4NjM5MDAwLklhM2Y2ZGQ0Y2UzNTg2OWM5MjYxOWNlMGM1NmVlZGE4Nzk2YmRlMDA2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5d13d535f8b930aa22bde875a14d12e11de0968b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNqfX-0000000065X-3jLy
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: check_file_access:
 fix --extra-certs access check
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2108232811398512652=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2108232811398512652==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IKUp0LUAfTM="; charset=UTF-8

--IKUp0LUAfTM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2084?usp=3Demail )

Cha=
nge subject: check_file_access: fix --extra-certs access check
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2084?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia3f6dd4ce35869=
c92619ce0c56eeda8796bde006
Gerrit-Change-Number: 2084
Gerrit-PatchSet: 1
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Comment-Date: Mon, 02 Nov 2026 11:57:34 +0000
Gerrit-HasComments: No
Gerrit=
-Has-Labels: Yes

--IKUp0LUAfTM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2084?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2084?=
usp=3Demail">change 2084</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2084?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ia3f6dd4ce35869c92619ce0c56eeda8796bde006 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2084 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 11:57:34 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--IKUp0LUAfTM=--


--===============2108232811398512652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2108232811398512652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2108232811398512652==--

