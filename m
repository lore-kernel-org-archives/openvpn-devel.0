Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761F8CA5FFC
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 07:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=24N4OEinc3PGf2pbmJ03pt0mmFpV6f14cZArOW4omAU=; b=e2mJ/E8YXNLWYcItjl3iG3bHOv
	DakbH31nKBq2oUI+EKhdqRIleY85oelXdiNfJ85s9m/PyQf7/OoRKbk4KI6vGhWov/saeW1Efj5qj
	FkfYTHrpiCHINTgx970fq6TXFENgKy0XQfb4YyCTZyIy9KfkRRIQW9DCAFCmp8zZ9+h4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDd9u-00006P-F1;
	Mon, 05 Oct 2026 07:30:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDd9t-00006I-Hn
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 07:30:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cn/M6ApmS6MjOW7Rxhhfftjjfe0tmwGfD/unKHkVQBs=; b=Be2wDNHWFfHdLvLl4cJveu4sAC
 yqwQY923RwfYopKRz2333RlZjVbXsLkmZirumlpDT/OjArN0hxRst1Y6iIjMCZh+EMAOxme/yIFoc
 p8tKQARughz4MBgtk8zXo0CnLpVMgMATwbW8iLCBuQQfQVqyPBHh2vqZjkuq+1i9cA4w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cn/M6ApmS6MjOW7Rxhhfftjjfe0tmwGfD/unKHkVQBs=; b=B
 Nw7tjPV9qchQmV/XdIQddvaBIDykjixxGIsa0kFBn+qdghya9yKsC9an8ljKoXMW809fBssdjcuEm
 DClcREHVpHZE6DuZ2onfCGKQcXVx+lu83qsJ9z036ugnHufiJOnyrElxBLvmRWC9Ht0gTHrXyEtho
 SrI0aUlNkytWziJ0=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDd9n-0007KO-Tp for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 07:30:47 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-4a174a3dc9dso1611975e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 00:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791185437; x=1791790237; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cn/M6ApmS6MjOW7Rxhhfftjjfe0tmwGfD/unKHkVQBs=;
 b=HWSwg7d7Pq7F61VQI/ssHALlKGNCQSZ+XZ1GMCaj4BD0i4xIZDp5M+6Hx6z+VCPGMB
 Y/VgYtPy88ZTi4PwPPf3mBtjU17a3Jdt1dNuPCmNFKxESJr7RPzfTE65/6MNT/9LdML4
 QsS3pzeu4nXVFwffdgSIVPz6RKKtxqVLAMbnk8ZgYSFeaPpLRF/20UMcdyMEdPxZBDuH
 5UwSSJVtlnl5624tZcQZJw6WUNkWVjAW9tLy25D2tdKkWLqMrwIS/4DJvQgy418vHoGq
 XVzFDEMF1S1k4AOaKAfieqBynMLkBEGqwqLgS5XCQMaLKM5ZOzFU0suKFCwJJqwfDKKR
 qvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791185437; x=1791790237;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cn/M6ApmS6MjOW7Rxhhfftjjfe0tmwGfD/unKHkVQBs=;
 b=VlZvKaFrpJLVk3q+16y2sz4ZYmd82Hv3asbBuV3foUfsblSY8Ig8s0PGkT2kUuNRr4
 C86TKkUnQNyWemx2BQpNMfbCzrJzYWBmMdEt7wNt6EctWVNS83wLmis6y8K+0l6clQ0J
 HlbhLBIBf3xQIEOGpgJKwT0XMPL4CEr6D9KeB4sLere7Mc/ePH1YHXtPftc75QcDlPsr
 QzqsLGnedLlGx2Zq5JvVX+9khZBavefJxamKPvzIzsHQhPNO3j1yGfyajo4P29m1n0PO
 32eplTHovUyaBZqR/JMtYSPmXYbuu+n4jqAA+bhAI5e8YUeGa31QLKhwBm9SZUScAbq2
 93pg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6/Xt7dQggAZPNmeEjyl0qtl00BHVQDopUw5ZbQSQ0c6SjS9l+A7y5v62055ma0IEYRDIq6w6VM3I46/cq@lists.sourceforge.net
X-Gm-Message-State: AFuF++lSNzx2qN3E7a5vadEOb6X/D6n9t4/B2ywa5JD+5Nwb+tJrEgPO
 jxA3Zxd7YCPlFszSOp/HWXAMn/+4iVE4ikFh/OklDcUbdmBGdobeU6pgzjHT5yfj0F45uYXRf3e
 nGbF4yneLsu9yXAn1qr9u99rMO6buB1mnWOCNEwHZX88M394YTvR0qUe7AZC0N81diRXD
X-Gm-Gg: AYBFou3vQljbKVzLDhUttTfEOE6K0TUTHc8y4n2qGJUXINXnPaQVi0aVRdwVT40FUvh
 k5hTC2zTRqZeWWBo+fVvGufn9pzX2xeODTQaX7uVY/MlLEU4KbEjdQpfgk5xo3ArxdtPBUSqvoF
 +bdLipQENZ5rpdbDpiEsgFCFCFcB3C9sXo4G0Iq8/k/rbccJQiyiiBiR4QeW+oQrxAcDEjGdK9e
 ndrJ45WcuU5A8D6QxrDEU8/FaI5+UvwebQI64QJM3EXwWVv8E/YJcA5nQ0KNPzXs4AqpkvGqqEh
 j86OGi/JQ5Cni3kLeejO1v6p6IRy4Q2keCZEKI6RSikcHzLpZ90amOt8RvIKVhWEQpgnaB9+ioi
 QhfbAvSyue7tYeceyq/DxEYOJMCnjyyyYfx5ZVggR3gTB5KdOqk6DLwYBXZOCNwRB7kibEmCSlS
 dmYYMXi0/PtySZI1pV0T7/e9W9af4uJLEe5I4yDl4pehK0yPYv6iCabR92tCWtjPdsIMD1WM5XA
 vUbXo6jbA7HuSKGPFyEv6aenCzwYt9Bpb0cTocm9PGFeVjAQvKV55DBxZBTy9V+8e0FmCAkBqV7
 hz+bVyFDTDfwnR7dqJbr8mg9nI6CSwRJiqODH2oBPDiUbesZxveK+z6zUW7E
X-Received: by 2002:a05:600c:6217:b0:4a0:1ea1:477a with SMTP id
 5b1f17b1804b1-4a0276a31b1mr151747615e9.27.1791185436881; 
 Mon, 05 Oct 2026 00:30:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280bfafasm340775075e9.8.2026.10.05.00.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:30:36 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 07:30:34 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 178afa9fc7b5a7b499297aa6361beb423d4e845b
X-Gerrit-Comment-Date: Mon, 5 Oct 2026 07:30:34 +0000
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9094bf06bc950fea44a810375bd393a5fe37d89c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDd9n-0007KO-Tp
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unix-script
 functionality to the --management feature
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4549888533042898708=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4549888533042898708==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1IvawJVxtA4="; charset=UTF-8

--1IvawJVxtA4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, plaisthos=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by plaisthos=2E ( https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail )

Change subject: A=
dd unix-script functionality to the --management feature
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 10: Code-Review-1

(=
1 comment)

File src/openvpn/init=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1852/comment/0da67ffc_33d9f9af?usp=3Demail :
PS10, Line 4381:      =
           platform_get_tmp_dir(), "omi", &c->gc);
So `c->options=2Emanagem=
ent_addr` gets overwritten immediately here, after having been assigned a c=
omputed value above?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1852?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
Gerrit-Change-Number: 1852
Ge=
rrit-PatchSet: 10
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Mon, 05 Oct 2026 07:30:34 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: Yes

--1IvawJVxtA4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, plaisthos=2E </p>
<p>R=C4=83zvan C=
ojocaru has posted comments on this change by plaisthos=2E</p><p>Patch set =
10:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px;=
 padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">View Cha=
nge</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init=2Ec:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1852/comment/0da67ffc_33d9f9af?usp=3Demail">Patch Set #1=
0, Line 4381:</a> <code style=3D"font-family:monospace,monospace">         =
       platform_get_tmp_dir(), &quot;omi&quot;, &amp;c-&gt;gc);</code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
So `c-&gt;options=2Emanagement_addr` gets overwritten immediately here, aft=
er having been assigned a computed value above?</p></li></ul></li></ul><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?us=
p=3Demail">change 1852</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1852?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1852 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-O=
wner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Comment-Date: Mon, 05 Oct 2026 07:30:34 +0000 </div>
<div styl=
e=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:no=
ne"> Gerrit-Has-Labels: Yes </div>

</body></html>
--1IvawJVxtA4=--


--===============4549888533042898708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4549888533042898708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4549888533042898708==--

