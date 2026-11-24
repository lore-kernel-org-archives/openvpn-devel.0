Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E71606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SFadAGNb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AXL2aXyc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=duzvdKnP;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=H6yGx9iT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2slXO6sWdDQmqakhbkE/IbcL53dfXrHVd72oV9e3Tc8=; b=SFadAGNba9CwgXYKRS37Cpn21r
	+Yyg3dcJ/d7m26Yp8TVLljtwsIc62DL8kqPvNN+iP1LXJRp+DFiP+eTi9LCUUym4hm/JMEiLchaJU
	/VVLJLpjvWZ8+opFzK3Dzax0rhfXSRPdLarhIKwhcLmkr22nVC7MBr1yF+POiPwE68rg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVttb-000000000FR-1Q6Z;
	Tue, 24 Nov 2026 17:01:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVttU-000000000De-3X4N
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 17:01:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uuc2Gz5F6EWuPwhgNLbxwhfJnMqkYoZUr2rHu+u01xM=; b=AXL2aXyc3teQKPMu1Pr46lKP68
 6FO+mOgfhQY1hynrlieBykFIWq6xWLgf7KlFl73XXCm0NKwEyLAxiU+fOUkVDQt9c8G/eZ8YCNdOj
 yIwyh7zhVC8jgfP5wEVwFn8kJk631i4uND1oAtPnmSPQH+tD4HRmxtOASeOAMcf0k0Fc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uuc2Gz5F6EWuPwhgNLbxwhfJnMqkYoZUr2rHu+u01xM=; b=duzvdKnPxH5AN4OZodVo1CCyl5
 NRzGg9fRnHsNZm6lO68xiqsaWsseUnTkxQXgLCv/aKmeT1KFgwHnPgRVtX17MIKwNRVrsO7RQ4syu
 o0ASjccYgSTA8oQIwANQp0aq1MwshNuXQL3RFDmKDcpKkmMRlSk4lHVtuOLXK9EI1Q1Q=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVttT-000000007ii-24cR for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 17:01:24 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso3059882f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 09:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795539677; x=1796144477; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uuc2Gz5F6EWuPwhgNLbxwhfJnMqkYoZUr2rHu+u01xM=;
 b=H6yGx9iTZ2YMPq3rtyI2gbYWqZqXQ9f7edIFGAyeFhqqrCZwwNCrpZ4kos+BjH+4si
 gZUFjpURVpXsRbGIF9rTkxhsQWzXjibB6g5uLAjv4E26z6GDPqLzuW+2dfP5CnHrjUqr
 OMSe0i0/yn2t+GadDQJ2G97EuGJioPD1e3rk3oKkHoUGQEFtUpM5TZQo/45DhmLob0yR
 AHR5/RtEZPnpQtZynPOErxU+/c2jKSRaY8jC2J30yVF8fgkShvxYFrawDzQZ6kovAz99
 puac10YGNP/r2iHHeThY/tAGFZIYZ7ZQ+Za9w1BzoBkm1WfeK4z2Df5HfIGWCp84DseR
 uNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795539677; x=1796144477;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uuc2Gz5F6EWuPwhgNLbxwhfJnMqkYoZUr2rHu+u01xM=;
 b=KGFK4Z6Ddj4lVvRuWV+JYG+A02Z5qhdwsipWs+k5duEEDq7j4MwifP75oABKCYbn8i
 M7lW83j7c4vYyYur70HO19NHXjQ8axEXRQBvrJqv5+ZHYB61sve4NmDu7IMWDMszjuUg
 FboN7Z/KP5rR6WTh6iPKJg1RLnzIXQwTcGphqFjw/JBeCq63LilA0DJsIEvQGxlzeKUz
 QD0JPdsn5JiPXJ35JTVEDgganOl+mHWQP7uRD2jLQi8bBDEb4PR7m5g+PZO4x1aa6Z4X
 6gJOHFJ81TnTU2P6AWnpdIYPdTg+gBn1Hy134DmRM4TYm+ebmZPgJ0Dlg04y1pWuxvAE
 QWOQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGU/Z9XiWKU5CI+leevfwUXOnjThhabF7PbZtO3i5T6uXWbel9DVxwSVwnVPQu1Obh5UF8wCNm+SJMKC423@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+Pn00k8TtmoGD4G26/Q4D1OxITJPXLrgekuan+DLFXy+BFFHiv
 516sMyD8PrCNhL4rkatn7iyYaX9+cFFvqIyLqlyl2jAncNLUc68I7IZ1wcqIcW+xINFJWJ5tTRA
 NNg7qd5Jmql/VZ4HQVu5kXeu428UEtEN1ZeENJ8Jxyn/XRmGWD5KPNKl0t+8Iw3XMpaVr
X-Gm-Gg: AZFdTZfiw0htibutEMb0gVlSysosI+7gA1fIKIVBGsiqmrdHDDyIkzYeS96ZoBEz8J1
 kBEglKZIpSE+RuclGLa/jxd0OndbFm6laN3AJZVmI1+LcPspVNj94uOD7r48vvrDiOy7i2fLrXm
 jFUSta7pPOwmUhpMM2MbqoS/l8MLhsjh+4zSu56umlbAUzK6fIN2BhPf7j6L6i9322Zjj08yxUG
 rQn+L676tnEBdsmMHS24mawz1glGpEL0MuCNTi3wLxM+DM3YYcEJ4cOPIl+B1FXqioiNx/mIoum
 LFXpwzrD6ZybxWGCPaQ0BQm5h9/Wkg740sVde2h9w+6fpwM5KQDl2xCPoYAD5O6qFTPfvY6eOxo
 5CAHG61puelM92AEMIZmVT1U3l7+8JEcmuo4++G3fnqkKKbUhuRiQfLEwWIgUn63fZRgYGzYk4Z
 21cUtHYGq/9uqrk4L+jpCOB7atzeBSGNQoYa0LgDORz8YXJ9fnkTZWKLBcU34Jo0+hiDwj4twFm
 QOCXOD25IJxuXoI8IWNHtaNDVQ2GsNXEQ8u4L6C1aDAPBRICwMbtPYFTAsPfH3RrzKx460CHoUM
 aDf6BebZlzFPHHP2o3g1VrIHrRqn7NnFZTNYyUakcoOUvLYI/WYpg9j2o7sfpJfLPizLk5QWqF5
 Yie1EpaoGtTlhUURD3GQkFuCRDmb0f5m10MvncYh4FlWlidAzM4LpuB332uPzowLp+f7KMKzSh0
 f1ckyyWRurT1D08N8=
X-Received: by 2002:a05:6000:2893:b0:494:6f49:246d with SMTP id
 ffacd0b85a97d-4abb47b24e7mr29415160f8f.24.1795539676198; 
 Tue, 24 Nov 2026 09:01:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf61e8sm30556830f8f.11.2026.11.24.09.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 09:01:15 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 17:01:14 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5
X-Gerrit-Change-Number: 2339
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2339?usp=email>
X-Gerrit-Commit: 6c639e79beaafa6159e677e587bc82ca01fa34db
X-Gerrit-Comment-Date: Tue, 24 Nov 2026 17:01:14 +0000
In-Reply-To: <gerrit.1795538311000.I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5@gerrit.openvpn.net>
References: <gerrit.1795538311000.I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTM4MzExMDAwLkk4N2RkNDFiNjZmN2Q3N2NhYjdhYWY4MGZhOWQ5MDk1ZTQ2YzAzM2Q1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b32c927f09c18a32fb0553aaa6a130f18d06b17b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVttT-000000007ii-24cR
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: Fix
 conversion warnings in man_write
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
Content-Type: multipart/mixed; boundary="===============8776810599238849313=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8776810599238849313==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="62FkYM/lKek="; charset=UTF-8

--62FkYM/lKek=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=3Demail )

Change=
 subject: manage: Fix conversion warnings in man_write
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87dd41b66f7d77cab7=
aaf80fa9d9095e46c033d5
Gerrit-Change-Number: 2339
Gerrit-PatchSet: 2
Gerrit=
-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Commen=
t-Date: Tue, 24 Nov 2026 17:01:14 +0000
Gerrit-HasComments: No
Gerrit-Has-L=
abels: Yes

--62FkYM/lKek=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=
=3Demail">change 2339</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2339?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2339 </div>
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
lay:none"> Gerrit-Comment-Date: Tue, 24 Nov 2026 17:01:14 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--62FkYM/lKek=--


--===============8776810599238849313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8776810599238849313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8776810599238849313==--

