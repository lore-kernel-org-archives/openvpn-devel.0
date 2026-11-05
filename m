Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E990A606A326
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EFteC+g4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BHOhexJQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=a/KmnBpT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Had90qyh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mxRg+ovrpAka8Q3FfpntvE4KNdA2w6w6E0+HJ4/CWsk=; b=EFteC+g4axp+38P4aPqzwOj7OU
	2sVjGggaBaFmAphhGPUsO+djR6eEXJRzXcGemkHoNN7qLgN5pSxewO5LUyMjmcsNY160fyEx0HFsk
	l4VYT5nfEGDywgE2FGIrswLJvEptGAnmsljiDYawTHHLpOIWBs1/cRWFLbP1PZKIFb+w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOwFa-000000003yZ-35MS;
	Thu, 05 Nov 2026 12:07:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOwFZ-000000003yO-1eHp
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 12:07:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qSyQb4nv4ilaOS5agOOvYlhjn7VGcPKgUWY/qtAjG+w=; b=BHOhexJQQO+OmbP9+rWG7hSoUA
 FgKWS2irAWjwnIfbj8OuG8Gt17RVlObh7dUw17maxM5UcfDAJxCwH/7YvefKfiwv04uzPzsrUqRQZ
 42J7L8EwqWaICS5DzPsX4wCoKffbHEp3lk5vmd6QBHYnJ0QuhuMPEkPFhjqzlIKiUOVI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qSyQb4nv4ilaOS5agOOvYlhjn7VGcPKgUWY/qtAjG+w=; b=a/KmnBpT0qUsQNdsnZe2Y+vrXS
 w5gfw6Ipky6gmesMNMd5zmDiBuwD0ZSUkWPCGrLAPAfstmVUTEGy9AHqc7oiOscNvt5Px73Lj6W7G
 s/mbXxyh3IV78uWzWpmamT2lhc0GehXKVKQGy6y7/hYGFh1saZn62W78xiFQiEDfnEdY=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOwFX-00000000821-3OqT for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 12:07:25 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4b4571ff080so19133815e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 04:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793880437; x=1794485237; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qSyQb4nv4ilaOS5agOOvYlhjn7VGcPKgUWY/qtAjG+w=;
 b=Had90qyhViwGvYgRO6KWL/0HH0LAZo19vp8Z/bBYfl1yNDiS/V/zb/ijmvDrh+Fd07
 2hCLZuMeU4EIIz7ftXx2X9fDCKPTVulL6QKTHWZYPzWITNc6wLDR54qd9EoKmMxKQ8mX
 tRjjPrpBxdG4VAs9i7r/7WXK2YV5U4+oupDt5b4cDJXWv2+mQWdKKVA7lnP+ys9IhNG4
 tiA/08urf5QK9soaCLNS9/YYsVLwVOfOEsYyVmub8eMLCEu1MHUjpzQr5bDsjSeJqQlu
 8sJYXRIYx/s5ALZ9mhrBlmrn5ZPQy1aA+17kqWfyzj2tWzLi761zj1D4/iRdq9YA39jj
 xdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793880437; x=1794485237;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qSyQb4nv4ilaOS5agOOvYlhjn7VGcPKgUWY/qtAjG+w=;
 b=AQJGqRTmWQ/a9phDqX+QctBHMGRqIrtoMnp8w/mkNwlCq1Ia53xrPAgSQpPwpfVlct
 racrzpG+HjcNQciQlxwIAqrA9BbwuzR30dWQ63JGuxeqUJ7vD/4nzoP2PLejTladYk8G
 FEo/dXdZgfCnt2GqwoqTjq+PoW0IsPfZuXyftMnsPfJln2zpqFe2+UgXNGK5Ncv/PpQT
 2wkOiZOshWRGn0+03cc8E1tmXn4voNLUagilqZr1616u0xVmia5PHRqRwAWsq4FNV6UU
 gCdo3uRgtYFxOTS6d0SxZvNvLvjk5zI8bL8/NlNXlCr48sQeXdHYiCjyy/lpLLM6tmKS
 maMA==
X-Forwarded-Encrypted: i=1;
 AKwUvByLm7NCyTHvERoLJW5YsQjbf7AwGkQpH/DK7fhUw5Ps/x3Knm8eFDG8MblwwRZ3GwqPGX3Hm+/voGbuUUmR@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9/nJHzfSmvQYbsXUlF2rC6GxxeKFBOguhadHrFT9ll9WK+blhg
 tNv8hjM+w8j7Og5ISNinFU9EPuOV1CNxJ/mZOQ/CGkvk6SN5S/Dt5857M9UCxkBdylCWaxZSSJw
 /6Gzc0iJ3mYCIdUjszaVfnSQrGwDODEiToaDu20Q6/ZR1CK7TPFD2+Uefzo3s1pw8rGpj
X-Gm-Gg: AYBFou0bCeLP7fgKrcu/1rSN7PlYAoTzrtEptcNUgYWdGgNreTzDaVXLT7dUTgeA2tH
 FULh7TI1NYDNryWi8XzCRzF0IRQvYN3ajkZ6jrvn44VkC3s9WJlLcVFXaCzRB+OsFNd1ZnvkdBi
 T2hPQLju9OIWLLdrlUmB8FYUDgmbczV24KZ8PZKRdehICNRKvRs35MBVWXdWAaFkkALizlxj5Ii
 liojyyErWY3CPHVx370jR83+nQ3E+d+zOYxxv6aoe9hJDF9LbOt2w90iNQXlNchJ+U6yeMPnTew
 yv/R019GbHPGmLzQmpCojnmRZQpUqw1f4J6AjjiUDmKsDDRLlSsf067ODwJcDLdto5CV7MdofpM
 0RmbDzyMgLR/9LgWogHTZYU+P9M5GEW8C5Pl3j4PfHZbGJgaVRX/VdC+xesnkgN8Yxcd6TSaor2
 DTDTdHzy4CVwvuNq/QSuE4mtKRilZ6O+BtR8tC8byKQdJE7C1UhfWLvgf3I+d2FQmLKkDkJ3Her
 YdnRFUxL4s+6wUbgtdP8PqLrIBqzvSDw9IX8V2axIGrWWVMoIkkqKqxmIQ9GXfzZSwlSz9gcwMo
 aNImrwn3g/fw90YkKcjlBEBPXZUXsa7xUEOwR6dZJ9Ub/EDkiFM8SASXHIA+S6LO0CVSgCDJXQe
 v9WSGPtW5XQF5Zj0Gz9jjB0DL14rEozyFNdDVDqkw/VFw2HHaQ6hxeypKdfRBmT65FUq/K+BNl0
 CG+oran9EqRD8+ng==
X-Received: by 2002:a05:600c:354a:b0:4a3:5aee:2c25 with SMTP id
 5b1f17b1804b1-4ac181e759dmr440264515e9.31.1793880437028; 
 Thu, 05 Nov 2026 04:07:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec8d8e29sm10345317f8f.19.2026.11.05.04.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 04:07:16 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 12:07:14 +0000
To: Heiko Hund <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib65ceb898d23777663c32241156d597918a24ffb
X-Gerrit-Change-Number: 2114
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2114?usp=email>
X-Gerrit-Commit: 2dea0d7f7ae25baf03867e3d5e92e34703000ca5
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 12:07:14 +0000
In-Reply-To: <gerrit.1793747232000.Ib65ceb898d23777663c32241156d597918a24ffb@gerrit.openvpn.net>
References: <gerrit.1793747232000.Ib65ceb898d23777663c32241156d597918a24ffb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzQ3MjMyMDAwLkliNjVjZWI4OThkMjM3Nzc2NjNjMzIyNDExNTZkNTk3OTE4YTI0ZmZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c00af0564887ee342e5cf6df35468719fa7e8030-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOwFX-00000000821-3OqT
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: don't
 stop if the next pipe instance cannot be created
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8254042100112499919=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8254042100112499919==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZHflEfKjLJE="; charset=UTF-8

--ZHflEfKjLJE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

Frank Li=
chtenheld has posted comments on this change by Heiko Hund=2E ( https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2114?usp=3Demail )

Change subject: openvpn=
serv: don't stop if the next pipe instance cannot be created
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment=
)

File src/openvpnserv/interactive=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2114/comment/35ed7592_10aadfae?usp=3Demail :
PS1, Line 4093:     =
             * Drop the client and keep listening on this instance=2E Handi=
ng
Why no error logging here?



-- 
To view, visit https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2114?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: Ib65ceb898d23777663c32241156d597918a24ffb
Gerrit-Change-Number=
: 2114
Gerrit-PatchSet: 1
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>
Ge=
rrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: Heiko Hund <heiko@openvpn=2E=
net>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Com=
ment-Date: Thu, 05 Nov 2026 12:07:14 +0000
Gerrit-HasComments: Yes
Gerrit-H=
as-Labels: No

--ZHflEfKjLJE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>Frank Lichtenheld=
 has posted comments on this change by Heiko Hund=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2114?usp=3Demail">View Change</a></p>=
<p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpnserv/interactive=2Ec:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2114/comment/35ed7592_10aadfae?usp=3Demail">Patch Set #1=
, Line 4093:</a> <code style=3D"font-family:monospace,monospace">          =
       * Drop the client and keep listening on this instance=2E Handing</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Why no error logging here?</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2114?usp=3Demail">ch=
ange 2114</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2114=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ib65ceb898d23777663c32241156d597918a24ffb </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2114 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hu=
nd &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 05=
 Nov 2026 12:07:14 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=

</body></html>
--ZHflEfKjLJE=--


--===============8254042100112499919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8254042100112499919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8254042100112499919==--

