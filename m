Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48F1C55174
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 14:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ua4JlnjRywB0oNU2ZJRGshg1qyXhl4c7swKQoxHjlI=; b=APHFMx+/ZhDxw6Km96jt1H+jTC
	+ruQRQWQ6C1LDnnpTXc/Gd/GzrD15/RhiFE7pCRDWzVpOKtKCI9Z+2QCrh4SnTA3f9pqFoe+31psx
	yWg6Tz3WsWB5arO7u5RGaGK0NMUGVa9I0TPb43Uw2JsdC/jm5ErKRZh4mztYhalpUIEc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrcEQ-0003SS-9F;
	Wed, 05 Aug 2026 14:04:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrcE9-0003Qy-Ls
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 14:04:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KjznPDkR/Y2IcRoimVd5lGQ+4nXi0DjigynJc4YKF/E=; b=P2mcAlf+vxDEoolBXKebD5XqyQ
 xxWCo2GAL73E9uLsyvtJMe6ZzBkk0REwCSqoAhKoA4hSWDMCira3p7e23Wq4kKrj5PqFNdNImNolz
 S70p5EWYxb6J8jqmS+eaaujh6r5j8nii0R+r88b9M3ZKA998TIGvgshpsl7t75x2SldU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KjznPDkR/Y2IcRoimVd5lGQ+4nXi0DjigynJc4YKF/E=; b=W
 ITsSbq06RqhLjqGV3yCxz8TpdgeyuW66p9xKYYBgBNRIRdTVxTZkb4haF2VwdEXqcUSzOFBI36OhJ
 6t3IPohbnHvI97h3jXDdExAxya07br7J5NsOx0q5PQ1Xmw62BJZMaPvAbwfo662G7Vxiyne0KeKQ/
 7FJgQ/MPzmyWsabI=;
Received: from mail-ej1-f50.google.com ([209.85.218.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrcEA-000099-7r for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 14:04:11 +0000
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c160420289bso155809566b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785938644; x=1786543444; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KjznPDkR/Y2IcRoimVd5lGQ+4nXi0DjigynJc4YKF/E=;
 b=J7KSeD/CVicFCqoAwT9l4cQTjxA5JIfcw7wLhSJvUa6DszM4o/s0e5Vh6bgn65fybL
 Iu44z2Mmd5NGenvA4nyWXoWlM6WlzUdcKT/cOZt/DSHsZIvpl48xrabpg9hk+3fnGzlX
 OJ+kszhl+ekj1DexYRxl6mUTRflNMoMsbZRa2gGeseC+yDLK8sCbPcWoMqOgu4H9jYoN
 S3AwbLCjnZXbPxVCZwShwIa9bgDSYdVv92YL4EZmKtR3ycRXVG0RdOT/t/QL4OiFO2K3
 TXgpz798NvWpoDcFpYN/FOyELWX5y2hBIAAnvjBhdsRxD9WYzrXRFM4L6Lc2utv3kTaP
 Xjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785938644; x=1786543444;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KjznPDkR/Y2IcRoimVd5lGQ+4nXi0DjigynJc4YKF/E=;
 b=XovpAS+93+Ya/oOAof4DobMo6U7mDTaFCOZJ6QlYlBxiY49JvpsYnAALQSm9y4elx7
 DlLRqsT80nEW/h8nVhXbfRYcFOOm7lozfzLr/J6dmG8TQfA3cMFths+LcZB+evi+GqdN
 52OmTtYWFbTzJuDXVNqyM6ln1z3MJPH6jX7H95bpWKTlSyJ7EBXQ7Ipxm3hC6wGoQrVx
 KmDjlRsUV0FpOgSpN7B1ZQG/g6EdXXvz72WSl/JMtpVMvGHjphYy6qw//znzS85tnq9E
 N+HZ5x/aDKELwc5gaf0F6YNqDHnVFvYpVSTAjtaWpjDtIZCm1P+0Yxzz6kR4H1mGh2Dl
 DK6A==
X-Gm-Message-State: AOJu0YyVoyqqAi9i06vMyHXrSSHgGPkOYbYUfp9QkNRaxu79070UGG02
 7hA7O2qO/wtzxSAJtIm4TeuYK9ngAmgyWyDKl87p6DyqqVB5fQOTGUBJ5fqQRDVrCeUo2JHP2PA
 am/etCk5K41V67qB0W8Gek2LOT0fXIsrJcoh2wQ+DtyvLQJDcCNtbtf8b1a8dHUvPcH3zTtPxxz
 K8dt3pOQ==
X-Gm-Gg: AR+sD12eTkRs3F4Pdz+UzfaRC/nT5/qlpK3YAhf7YlUH28xq1LtA05Oomsn5fB0T54+
 7YgkcjbfaH4KdPOV6PoPvX9efhq6Rn6B5I7ZJp5w40h8Rqkdo9ECD/be2T/zTfbYGD3OmYtfJ9n
 81G0gCGCBbxLKoAHDKn2fDxoSF5ieCaKo+b6YZafmVOzyaH3BVL/DcTnUBLsHOjSHrbFMMjdAVC
 iQfmQuz4p+JeC657X8IeqoDrUlghtE3ptTo0tEk2W3n9hVINm2YEY2FHhH2A3JCfS9IfH1cEDkT
 0wF6cXaLdDkWlB/oTOeDQtnSfxKBaH/2P3JlhaLhB/5QZnEa4wYM3Bx4uPQo9NITrO/BTdDuZol
 0BH+UZ9UW1FflZKzc8PcVzSpUjB4aLxRJEnjNCNAQ7t/bAw/T1miTMwtNKtWUCCp8FAJ646lT+S
 pP/2IJFR3coga/+FXYvCzYE6Bri+VY7LmM/JHABC0gafIVcQtCS5dPf0hcs4+ziL0x7TOZm8Ygn
 KqJfwfbJqUsuH2fhba0Olki367a+dX5iZFhZhOcHNW2E2PUpFYrfSw0TESI4bZbrQTXrvbq+dPn
 7HwneOTl64sElu19Py7KpJX02zAz66rqYKaw/Et2nT2ChPYnrI0=
X-Received: by 2002:a17:907:6d1b:b0:c16:242a:4722 with SMTP id
 a640c23a62f3a-c2039d1cae8mr301728966b.22.1785938643900; 
 Wed, 05 Aug 2026 07:04:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec23e250sm10197799f8f.26.2026.08.05.07.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 07:04:03 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 14:04:01 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: e4c4e2fff1272a6a949b347d4bfe38d3d4278f6d
X-Gerrit-Comment-Date: Wed, 5 Aug 2026 14:04:01 +0000
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ab074131852d1d76082ad78ec6cd9534620dcc00-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrcEA-000099-7r
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make required action
 returned from pre_decrypt_verdict more explicit
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
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4033761515564949196=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4033761515564949196==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="puzye3Dth08="; charset=UTF-8

--puzye3Dth08=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1826?usp=3Demail )

Change subject: Make required action returned=
 from pre_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-Review-1

(2 comments)

Pat=
chset:

PS4: 
Needs more explanation, best added as in-code documentation=
=2E


File src/openvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1826/comment/2bb3363f_a8fbd3eb?usp=3Demail :
PS4, Line 83: /* Returns true=
 if this packet should create a new session */
Obsolete comment=2E Please a=
dd some explanation here about the different states=2E



-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f=
89
Gerrit-Change-Number: 1826
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Dat=
e: Wed, 05 Aug 2026 14:04:01 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Label=
s: Yes

--puzye3Dth08=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 4:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1826?usp=3Demail">View Change</a></p><p>2 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?tab=3Dcomments&am=
p;usp=3Demail">Patch Set #4:</a> </p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Needs more explanation, best added as=
 in-code documentation=2E</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826/comme=
nt/2bb3363f_a8fbd3eb?usp=3Demail">Patch Set #4, Line 83:</a> <code style=3D=
"font-family:monospace,monospace">/* Returns true if this packet should cre=
ate a new session */</code></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Obsolete comment=2E Please add some explana=
tion here about the different states=2E</p></li></ul></li></ul><p>To view, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail=
">change 1826</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/182=
6?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1826 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Wed, 05 Aug 2026 14:04:01 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>

</body></html>
--puzye3Dth08=--


--===============4033761515564949196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4033761515564949196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4033761515564949196==--

