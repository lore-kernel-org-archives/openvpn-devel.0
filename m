Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C7606A80A
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=a+Nt5q3E;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RwJ+M56S;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KaqCmXdc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SQYvNiJu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tXP/97Tu2fbuTZeooVIsJlAY1GUxHUrnImeemcUWxGg=; b=a+Nt5q3E8P+wsXKMxZY/Na0SH5
	6tNc8n+vNH82dBwWVUonR1sbXT3AeKeIphIGgdtTSZEUuMJi2nhkeiYaBfB2nKIsu3YXVWOyH+5AU
	u2JKAX0LABasDy2iDKO8N8A/8CiKqlqV1QarhZFSPhdStN8bgwWeh/LOHv1+ht9zc1Mg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPHxI-000000005WY-1U5i;
	Fri, 06 Nov 2026 11:18:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPHxG-000000005WR-0omW
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:17:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZTaH8M+NHyK/e/QXb/zUfPhYj6yQMacbKzCjtlppSVs=; b=RwJ+M56S9tsGGC7CUcd+MKw9QN
 +HvayTbc7ApD0fRh4HYFr/6VUKO8812XWvH9u1o5hgYPWLIHYIwVaOMSeHloP3DUGWMfi1EXpLwfu
 vXmSvLt1o1/Vglmn1YxnsDcbMMzEjNIFj0DZP2xU7+NfYDhsyhxwvaJNc8SJeOj672ys=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZTaH8M+NHyK/e/QXb/zUfPhYj6yQMacbKzCjtlppSVs=; b=KaqCmXdcYNvrEV2lqeD2RYktTh
 SMs08dvgzcjY/4CKvCu7fI/dE/yDTQ/vQWBPyLgnpe5a8i5ZWhlQsjHqaXNBtVyweacIX+WzpQgWs
 4LgtyjCMxXi2SMjsabAz0LviJsOPUOWt9sEzUthCmu3D7ff4J8AHvYnu23YpRWqqJmxs=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPHxE-000000003if-2TqE for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:17:58 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48fd2e38825so345197f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 03:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793963870; x=1794568670; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZTaH8M+NHyK/e/QXb/zUfPhYj6yQMacbKzCjtlppSVs=;
 b=SQYvNiJurT74CEC+CznzMbKCoKsUZ6DP0DzZ/4WijdES8r06swfdafbGtPeEgrBLzn
 4Kxi9nyR9KacVVW2Ng0/UBISlj/z1fs+P04nZi7iq3sB/Ps28TYojH4N4gZK3gJUAnGH
 RA9YKVSC2k2e1PPN/RcfFxy3UeQBPBKZwyWonoVhAWKC7XPKbyDC7W5NLPDEnBuV8tq9
 37YrzSAyVGDJ5Uic0qtbj5m6l+lLFFHFVhmebEJxwfj+2GL6sCSbT/m+XU+1H033N/BD
 Cy3rq28rPwdoWxjX5f6wQk/IJoYZUwnv8Ou154eLOvjA3GzeOEc6mqMJuykg6QFKRkJW
 ZsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793963870; x=1794568670;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZTaH8M+NHyK/e/QXb/zUfPhYj6yQMacbKzCjtlppSVs=;
 b=J7KKu+J2GHCLGn9n7cfhQ1larpRzH1GA4cStHybCSrEbj0jH0/sidcS3M4ZTxzdCdW
 ajnUFP9uQNZIX796QnGEOYRPnnTVDjsN9vJKQ0RmSVO3TPuItq3SGcxx6PGksjWr/RbI
 gjPa1TFEExRW+lxMkAfw57YFNmV8gJdOz8/cFOeZ+2lRkgyRhGbsmomTta1t/E6NOAQb
 Gfzb09rXVkfJKW7nG+7cXhRsfOXaoXeLXg5RHyiPFDgRLsqaDL4NsG/KmLziCPh3QEvo
 tXgtpSpTBB4DE9Z1E/gsYZTl7rJqaWjnPHqaCRPOhHlEwxkoCoOo1fO3dHkyKZAZTM3L
 VCfw==
X-Forwarded-Encrypted: i=1;
 AL+hErEPxzbae/3MS4rjmGLT6NZWwF/a6gEfKXhDm6YuWAVU/VI+gfllXx2Rg5DP2hEDcA+0YsfEFAYWCSTkLRXV@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/eZBlOFaUBGMZi2bL6h2r5i1f0TBMsOHlbGnSYfrFQjZGcUD29
 3B3iGkouLHA9I02KReXRkBKRl8dFsZ6WZfIEpHq1j8shoFtXYHGZ+ahmpCCBMDGzePle7UeJoLh
 JBE8Lw/gPNVDZVn+4y85sBXKMPbnafmxPqXfXQbwpdrLPgnRESZJnwN2jHjnR3koV9Zor5dw0Zz
 ZAwu7/Tw==
X-Gm-Gg: AYBFou0SEy0wsaIfwI7mlZ0XUphuzGzYQ8T8D8rcYdY9otLul9Mvq1xJTNOh21UpGcR
 ljrxKsAlyX3mvS+g7NNIaWnmEk5vjQfrnK85XZjx8lVIWYKXC7Q/J96jbQzLKccw5yeh06bA0Xp
 6yCUqhSlGTWxwgf3A743amR8ie9d+kiW+cjYENYJAlUVC/5wh+EfVu1479yfTHuC5RJJHdN3O10
 uP30kpxypKsXKr1iOMlo1p1TVKZrylru34njaFIxYrSKi1P1XHxR5rJFk+iwpM+un6ci1v+tDFw
 HTWG7ANqlsgdYlTeYj9+9kRDEuJbupQUYMUN2h0RxLPqWbjAXyEKnFQahmqh7tdEYGX24rBY2Ty
 PbyKbA/DqYDwUdQ3wQHCpGmtijqs6UzRG+Imsm43e5BdV57L2vZgHHU+RjM+wwC3uOlWoPUkUsb
 567H4PU8jIiqJ0AD7CH2d8P+J6AO57LGmbQLkULfwHyUKfXsYY/WRDE9CuDJehHREfMheTZ9xpe
 F1ipEdgUQoVnepEeo+R19D09thq1uA9B5joAjAS+VXsUFx+YNnHcndqK2ctz9om1O+zMicA9f1R
 6kHWZLRAbKaiT1LZ5LwWGLfZDa4cip1CNS4q6ikl5vFE2pp/Dv/ot9628GEJOdKJpC+8MzWl/6v
 l1U+xpon6fefNihHfvmhBzk9XCCmQ/9HDM+2fMWeoOxpOYXOFNWQZCOovipV2ystwbCLZsYozzA
 7vdzuvKsWxWfJGspBuRzOfDGgdc+KJRonWzlc=
X-Received: by 2002:a05:6000:1861:b0:48a:f36d:fb57 with SMTP id
 ffacd0b85a97d-49275fe4f5dmr5243826f8f.18.1793963869832; 
 Fri, 06 Nov 2026 03:17:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d73286cdsm2902943f8f.28.2026.11.06.03.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 03:17:49 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 11:17:47 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
X-Gerrit-Change-Number: 2037
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2037?usp=email>
X-Gerrit-Commit: 89922173c29fd19bf3310aa6ab34db88206542ae
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 11:17:47 +0000
In-Reply-To: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
References: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQzNzQ3MDAwLkk2OTU5Njc1MjRiYjllODM4ODdiOGMwN2QwZDA5YmFmZjZlNDFhY2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ebc087f9806d442f2af9c04a0fbae89534a3f964-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xPHxE-000000003if-2TqE
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate the ACC protocol
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6571245823867887326=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6571245823867887326==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JUJ03D3NjWE="; charset=UTF-8

--JUJ03D3NjWE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Name of user not set #1000061, Ralf L=
ici=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail )

Change sub=
ject: Add python scripts that demonstrate the ACC protocol
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 7:

(1 comment)

=
Patchset:

PS7: 
> https://sashiko=2E [=E2=80=A6]
Thanks=2E I don't think I=
 need to address the remaining issue that Sashiko found=2E It is again conf=
used about this is not being a patch series and there are obscure failure m=
odes that can occur when executing route utils that I think we do not care =
for in the demo script=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2037?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
Gerrit-Change-Number: 20=
37
Gerrit-PatchSet: 7
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: Name of user not set #1000061
Gerrit-CC: Ralf Lici <ralf@mand=
elbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: Name of user not set #1000061
Gerrit-Attention: Ralf=
 Lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Fri, 06 Nov 2026 11:17:47=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=
alf Lici <ralf@mandelbit=2Ecom>

--JUJ03D3NjWE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061, Ralf Lici=2E </p>
<p>A=
rne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2037?tab=3Dcomments&amp;usp=3Demail">Patch Set #7:</a> </p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
https://sashiko=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Thanks=2E I don&#39;t think=
 I need to address the remaining issue that Sashiko found=2E It is again co=
nfused about this is not being a patch series and there are obscure failure=
 modes that can occur when executing route utils that I think we do not car=
e for in the demo script=2E</p></li></ul></li></ul><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">change 20=
37</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2037 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: Name of user not set #1000061 </div>
<div style=3D"display:none">=
 Gerrit-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Name of us=
er not set #1000061 </div>
<div style=3D"display:none"> Gerrit-Attention: R=
alf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Comment-Date: Fri, 06 Nov 2026 11:17:47 +0000 </div>
<div style=3D"di=
splay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Ge=
rrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To=
: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--JUJ03D3NjWE=--


--===============6571245823867887326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6571245823867887326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6571245823867887326==--

