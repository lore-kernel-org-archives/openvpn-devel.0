Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B82CCA6019
	for <openvpn-devel@archiver.kernel.org>; Fri,  9 Oct 2026 09:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=08Ka5AInH29rQQQEdb+JgQDwCoMdzh3FdsHG3HeYk68=; b=jHFUN5hQo2UF6j33elTAvme98N
	OQ63S2Ao9VKVXNPyI+UDiCABLEZl1PGeBGJLhY1Lr+LCEPmlb95qPGL/Ycb6eJqrZ2B0j2QiwjKQR
	6iU5ucYPJTCSs0xELkiqlmse83TujcW6WdAp9q6OMMXt4X0nXglb/ihwmWbMvomvznXI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xF7KU-0007UF-4q;
	Fri, 09 Oct 2026 09:55:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xF7KD-0007T1-L4
 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 09:55:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=prVqi2+ZbBr9uAraL0hFZgj9M4L6UmF0SGCpdKUHT7Q=; b=CRz+Pd01tMEqEvy/188Q6UlNn0
 h5livDzFgMTjyiVqu1NLgogTQesCcMXjYIYbGc4FjhtTsxADPLcaVvTB1PqYMZY3zG3sch8V4dCuq
 Bciwhmwsqs6faWvFfu+ooqYsgHh7QCY+3iRyzh7sgZehhF7pT4bVU/PE3frw1n7PWf9w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=prVqi2+ZbBr9uAraL0hFZgj9M4L6UmF0SGCpdKUHT7Q=; b=I
 /0FJIrQHZZeCH+JeSwAwWlqr5LKujgsd/EqgpSO5ukd3vR+MH8Gk4uQpco11Ht82rDIS2CfujEJx+
 mV1NxihdcS8ElLunUeSHqANhNr4pO9aHyDyeFlxGtdx/niQCJ219rKxXrynSW6JVim0OswUzSGVrG
 RnEwx0msUMFbbgSQ=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xF7K5-0005UQ-26 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 09:55:30 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso66373325e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 02:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791539722; x=1792144522; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=prVqi2+ZbBr9uAraL0hFZgj9M4L6UmF0SGCpdKUHT7Q=;
 b=SNMyWq/aGd35Vp+lHdMDXEAJuT3Lj3CYzsycAJ7D0KEnRubZFFpKXVcZiG7gacy7X8
 UhAcJmqvvpJlrxWU6GEZC7RgJIsbXU5nGs3zkHefgK2tg6OUn1LuhPE/0EoBpQLHVBu8
 L1e9+/RodIZ+QAI4N91YN5XPc3eaaxmUGJcdmCzeyalp/Ni94XBgWi8wXkHf92sc1zvj
 BUpjg0UEyCpXdL19ziTibJpYusF7erowZncx4k4BC1Ogj9mS83ZiR3I6+IFoPdsGiWe3
 fz5MWc+RjHvNksqd6UjXbDfvCa8LJcTDmNMIkWrMCTdNQvLw45V5bmM1x71bMmyolcdA
 bAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791539722; x=1792144522;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=prVqi2+ZbBr9uAraL0hFZgj9M4L6UmF0SGCpdKUHT7Q=;
 b=CP88etEMZtlRUnYp+YY+SYXCwE8OoyKE/17waYsYwXgncsvKTl/6jqX/NGIKGIdg+N
 +97oDfbc+8Kf+p+/a8/VSQzOvtHyfCWoAz7DeG7IboWQkQr1JpAxXJR5jafUvevrHsbM
 Y0ESugnl4xC7o4MgCgfqgPXiT4AOiwxAUnuoC+gGIIVMpEuzNkYX2R5c4YQycmiOk+Lr
 HLMBJENVtSge6+TxptOYAIcVrwwrTjuyzjkbayjp3j4Dq5IVyKyg11mn+rJe+EakLOoU
 h/7v123FtcbjK5edZk22pSkkPMr+zVb+Zn+Z67BjsfWR2O0KZ9CKrcUVBXF1cKCwQxb/
 o1uA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxo3HQ9otT2tp8W0IvFtXHy1vd9XRqHo6RSbyF6cN20dKNu72vv+M6QPYcsPggssf8WzgN03PA/Ow2yieJH@lists.sourceforge.net
X-Gm-Message-State: AFuF++lZPHD2GMgc0fWiJtxnxmAbIoTG/mKSsge+mRfo0X+dE3VOLLyx
 0BBJO9bMPi6re+H0eNN6WPbmZ/OpkyKSg/3g0zZmX1Fs36xzeOCCAXzsx33N26Yjr8o/PYefUdA
 7spuRmM3mtIwv8X330Mr2xSHVsZ1yZTbRpaCtjThJ0wtNJaF8d8Lgo+OVSXQYuj2hAmj14XYC2g
 tf3BLzYw==
X-Gm-Gg: AYBFou2Ah+fBvHE4394dfzHRY08BpmsJPA/ejn9ZB1jul7lmRpkzhFtUE4L60bjWCAy
 nCBsThBCZbvPCAj3b84+v3kKw8uU0dMAEsMvGssVIuAZ+4o9pDocNJq/L8PjrrFDr7TdM3njnxU
 2oDOnqi7ZMbnun3wPXhM+505QmSqMkwyECWnPyKJm/QmpPY7GIcM0WlGase66ALDEJDzT1JwsGq
 TpYBY5lRSvSO5KFYE1cWg1WUFT/JINsO16RWOzNijvqPyysf6xoQdl0PGccC1eQ9WGaDuFKCgaw
 2pXtQ7F6xJavjPCFQwbo+NU+T8jfEV8JsEwxqcD7f5yBFXKseq/XbXxXJahCNoqs5g89eBO18eP
 hNdl32UFuYa707KseSXRIfuQlKjrh9a5nW6f6Z25LYQJpfE3jCD3RKYPuE7WuqVCELcV0Djrndn
 exSrVaiOwH1MEjrnVTbi6Y1ZCD6gqXR3oiou8hsUz4JyY3lKBPQNnhyY4l1Q3g4Hu70xKrk5hgb
 9UevAFw/kmjIyqKD2tyjOkazoNL4rdl6rHy7mYApDGq4j9nHebyWcvuNZnbMDQ3hDFhCOjF8brH
 2Qbo/L7iVRRkxBOZEJWaxkX6MhWPyuV9WLUpaAze2MurfGL0elL2SyhOhAL9
X-Received: by 2002:a05:600c:4504:b0:49c:fc6e:a3da with SMTP id
 5b1f17b1804b1-4a18e4a7839mr26008955e9.25.1791539722406; 
 Fri, 09 Oct 2026 02:55:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bea0f1csm79325405e9.9.2026.10.09.02.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 02:55:22 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 9 Oct 2026 09:55:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 37
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: a8b5b440b6de3acda7f7c390114c4e3a724754db
X-Gerrit-Comment-Date: Fri, 9 Oct 2026 09:55:18 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <47b4c10124f7f3e2f47b79f908eefe3cd3cff5fb-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xF7K5-0005UQ-26
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5789417416339158412=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5789417416339158412==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i853JZIcMbE="; charset=UTF-8

--i853JZIcMbE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

A=
ntonio Quartulli has posted comments on this change by Arne Schwabe=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail )

Change subject=
: Add lookup of multi session by session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 37: Code-Review+2

(1 comment)

=
Patchset:

PS37: 
we have a winner!



-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit-Change-=
Number: 1727
Gerrit-PatchSet: 37
Gerrit-Owner: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
=
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 09 Oct 2026 09:55:18 +00=
00
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--i853JZIcMbE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Antonio Qu=
artulli has posted comments on this change by Arne Schwabe=2E</p><p>Patch s=
et 37:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2=
px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1727?tab=3Dcomments&amp;usp=3Demail">Patch Set #37:</a> </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">we have=
 a winner!</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb59ecd119331b19=
8792ad1379bec8600211651b </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1727 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 37 </div>=

<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Anton=
io Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, =
09 Oct 2026 09:55:18 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCo=
mments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </di=
v>

</body></html>
--i853JZIcMbE=--


--===============5789417416339158412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5789417416339158412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5789417416339158412==--

