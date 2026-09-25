Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D4DC98318
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 03:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yN4qmDTTeyDdPclgkIK80qoggQeH17Y0SfQj7WT4pjw=; b=CYQETcevj01b0yVpzSZ9Ys6qZx
	t9q4nlcOJcWSTWXOIHQXojWizcIDIyBFpN26vlg9k4SNAmxh5Q4shD5F+1ioLIN+xhpP/3vw1o7B3
	3S/N3zccZKbrPK6lM0XLoE+9PBUI3zMLxgf2Z3W+5EwbHRCuMiIL+tlQUZFdyh31UXok=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9wZU-0002mo-1d;
	Fri, 25 Sep 2026 03:26:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9wZC-0002mL-Ij
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 03:25:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rY4aYzD3s6EjtSeyV3NnjmINxWx1OCIW1w9bzQUsMKI=; b=ANosDUYIJSPPvFxqgRPmURZLeN
 /aXeXsHykTieYNDDDtBdB4mK5jxsfwODcsPHJi0BdwH1SBeEdhIE98wYUKgCXJwsRkXkCjTn0hbfl
 PtBUg9wwB8/yJw+Jujcpe1/bXROtHckRKQhm0sByLNPVtAPrYD3JDRduVMZMfVnQ3ANo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rY4aYzD3s6EjtSeyV3NnjmINxWx1OCIW1w9bzQUsMKI=; b=R
 jShmD39F27SJYi9q8AAmRNfgiN2alUGt6hdkjzESuht9VX1MqO4lJxG521yRMehWE2BChokIEe6PI
 YxAbmwfi5d36122L8wpFQoK91pIfHt+Z8jYZLkPa2Kl5mBJqPpGYEjhiuP3jJdEcp8vBLmqop0YrT
 h6mlIdmZcxmolrgk=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9wZC-0001o7-Fy for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 03:25:43 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ff23af865so752235e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 20:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790306736; x=1790911536; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rY4aYzD3s6EjtSeyV3NnjmINxWx1OCIW1w9bzQUsMKI=;
 b=eFfVQq+AHDplufrP97obUUXKtKYi3jlJYAVGXMvG+HfpC2mLA/b60PEX52N5aDpCcU
 21m2hi8Aabwa7usbSZBhegP+RPqgVFmVS73wFGjJHN9iDDxgdllTL0wy6sWoBpZMJFI4
 XnbhnN32XumuDocoKikHnE91TH8L/RFhHbPkmeI78sm3zb6urxVT7CPvulmoK4zkp3fs
 T1zJ7k35IHK5ZEWKvDeDZ9rdORUIw16Y1oean2Fpxpb0u1oei+LWvzTy8YjMfOvWMFEj
 7DMJ7LKoZe/qXSiWqOus+yUt5Lx/0MK9+UmU3IK0We3HPHGDBD0asy48FuZ/gTrX/v/o
 R8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790306736; x=1790911536;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rY4aYzD3s6EjtSeyV3NnjmINxWx1OCIW1w9bzQUsMKI=;
 b=evvkQq71AnqYEyDnaOGwQjYms8t9gwu2kNI/PbnrWzgcvsHM6yVDCU7niLuFisFscj
 T4CbLz3RaumVmVWtaedvpbTK/b7vZICo3getJaJVRcwR4u1a93oBftRfHJGrHYenXoJc
 f+fIvcY1KTdyYvdxKSUX5H8xAX3ENQb0gpGd34ZK4/+sLCTEvEzPAAeOaxkUsnGzSt5c
 xdJjHyCp41SFrsLRyXynQ2mxd4r3ev0Ap+TEAradQxBAj+xacsYT7SD54ya4lwl3v16u
 aCJ0doxZB/+4xVpG2sWDSuMiLQEMeLO3m2ercr39Z3w129EnAG5AzZTCw5YRFYdmAyvq
 hTLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtqbJjc6E38rW1bSb+2mBRhgBQ8MFwK3SPfO7gmacU725W3HyzYl8VSQ/7LDKxlV12F1UJG7nt3BPFeEZz@lists.sourceforge.net
X-Gm-Message-State: AFuF++nxquYSYw9O6vHEpYB4z+6Ei+9afaMxahHHKbJOQn2NbdRsC+n5
 3VIKf1crYhHUV9w+cF8vNW3byo2K5lx5jJjw96M+0ofh1cGvRupQ10qYf0+ZtWWwmBRXCRxQr5V
 bHxsOYhpFkVEBHAr2qcSx4S6EMmXb0COvKdOpBGucD3kQjNFa8q2kTjYpx/W9eeeR3rcH
X-Gm-Gg: AYBFou2xX1fsMk1o7VVTJOsvDWFX5lqszwathD3zcpRWmZJNvSr835Uj2AfkKvwwyGn
 e0reW6x1a3orjmQZQ2L9iDUelio+HbSmFZZG8MocDi6myahb66maEZ18iVytc94gfZGK0hCW9xK
 +PWkP3EjFy5xe6BX+enpXkVA+icFqubRIgqZeBzUI0cx9Jv0mm7aLcx/J+BD5rncQIw83Z/Ng4+
 eBNOra40JzKp1zJ4DwbeFUpbdNkYRXj8uI+lnjAWY+U8rsj/nrLiDgdcTTSp/AtfahBwAp+rO5R
 AfnVe+mFmUoXuXMIs9Nj+caUgPL7X5Axuq6/FeB+zN0+CVUuxHp5maVq4OEtMr8d1e805VM6ewS
 Yym+0uILB9WDOCffaFrFwM60sMpJ87z1dgYGpV7kse2PuVU/+VpNJqR2gPK749XalNnfHCjVBAL
 A4uaFdhSq5xDkDZoEX9n/quZfVr2VBlyjQ9hgspyyOBpM+UB523O+rYvIExlxe3/vqti+1r/lYg
 FM0aeAlJ5mZPGv7ROKbss6UzxMrICOGPusEYEqtF9b6e3Z7DAI9tvfqw9EI8xsRhthQdAF37ACj
 p7F9rAojkDShU4j38agVyRC2dEz2uuuYLyZs4sZVPlwpTfX0aOtiljOWEsPy8F+aH2RQt+g=
X-Received: by 2002:a05:600c:138c:b0:49d:174e:2a1e with SMTP id
 5b1f17b1804b1-49fe66e6538mr73540605e9.19.1790306735940; 
 Thu, 24 Sep 2026 20:25:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5dff204sm171013165e9.14.2026.09.24.20.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 20:25:34 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 03:25:33 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d
X-Gerrit-Change-Number: 1949
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1949?usp=email>
X-Gerrit-Commit: 57e9b919136ba4e1dac9ff6ca0de201f644c057b
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 03:25:33 +0000
In-Reply-To: <gerrit.1790306719000.I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d@gerrit.openvpn.net>
References: <gerrit.1790306719000.I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzA2NzE5MDAwLkkyZThmMTQ0OWZlNTRlN2Y2MjhlMmJkYjA0MmVlMmE1NjdmMjVlMDJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fb8e8e15b8eab6c5033890055146a5a1598c197b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9wZC-0001o7-Fy
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: add an
 end-to-end test for --route gateway keywords
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
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6460913197737361157=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6460913197737361157==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KuPMKaCqVYE="; charset=UTF-8

--KuPMKaCqVYE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

chugly has posted comme=
nts on this change by chugly=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1949?usp=3Demail )

Change subject: tests: add an end-to-end test for --ro=
ute gateway keywords
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1:

This is the harness I mentioned on IRC=2E Pushing it=
 so the discussion has
something concrete to look at rather than a descript=
ion=2E

Two things worth deciding=2E

First, this would be the first use of=
 network namespaces in the tree=2E From
what I was told most of the CI runn=
ers can do this and already do for DCO
work, but containers cannot, so it w=
ill skip there=2E If that is not
acceptable I can drop the namespace and cr=
eate the dummy interface on the
host the way t_net=2Esh does, at the cost o=
f touching the host routing table
while the test runs=2E

Second, it covers=
 net_gateway for IPv4 only=2E The IPv6 side is the same code
path and I wou=
ld add it once I9e45c0e lands, which is what prompted writing
this in the f=
irst place=2E

Unlike t_net=2Esh there is no HAVE_SITNL gate, because this =
needs no
specially built binary and skips at runtime instead=2E Happy to ad=
d one if
consistency is preferred=2E


-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1949?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d
Gerrit-Change-Nu=
mber: 1949
Gerrit-PatchSet: 1
Gerrit-Owner: chugly <charlie=2Evigue@openvpn=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 25 Sep 2026=
 03:25:33 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: No

--KuPMKaCqVYE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>chugly has posted comments on th=
is change by chugly=2E</p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">This is the harness I mentioned on IRC=2E Pushin=
g it so the discussion has<br>something concrete to look at rather than a d=
escription=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Two things worth deciding=2E</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">First, this would be the=
 first use of network namespaces in the tree=2E From<br>what I was told mos=
t of the CI runners can do this and already do for DCO<br>work, but contain=
ers cannot, so it will skip there=2E If that is not<br>acceptable I can dro=
p the namespace and create the dummy interface on the<br>host the way t_net=
=2Esh does, at the cost of touching the host routing table<br>while the tes=
t runs=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Second, it covers net_gateway for IPv4 only=2E The IPv6 side =
is the same code<br>path and I would add it once I9e45c0e lands, which is w=
hat prompted writing<br>this in the first place=2E</p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Unlike t_net=2Esh th=
ere is no HAVE_SITNL gate, because this needs no<br>specially built binary =
and skips at runtime instead=2E Happy to add one if<br>consistency is prefe=
rred=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
949?usp=3Demail">change 1949</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1949?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1949 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit=
-Owner: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Fri, 25 Sep 2026 03:25:33 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--KuPMKaCqVYE=--


--===============6460913197737361157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6460913197737361157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6460913197737361157==--

