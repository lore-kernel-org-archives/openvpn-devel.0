Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D3BC61DBE
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g9jNieVrhKwhiafJePuNbySfkrqF14cw/gICXH4IBLc=; b=GEeke0S3o0SXt7kuTkkZH7LvV+
	9H4r7T1lo3O9jR8sH7aUpp3mmz7Acxe+crDxzEOmWVn0t696Slvsf1DgAqVPztQjnLO+pRjPOr4g+
	zis+X7rTDib6c6TCs+bMQ8HKw0VLi4r1B7E81xOcAAPVbnK/oZeElfdQEbYCSJHkUNgE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wytTM-0006Rk-1G;
	Tue, 25 Aug 2026 15:54:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wytTL-0006Rd-5m
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:53:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=N2kqimeqSHHZwBj/mynuMscNQhhaWMHy/gGrWOK98GI=; b=Oxbsmk6tciS3/i0qH1waaFXU4P
 zWuC5kCqRWPyL/GOCAMJICMemiqtG5k0dcoflg4WmmBkCTmQybessKTP/IbjiUatkKmc988l4I9UF
 kS95FkZOfu8WX8qp/csdBdBNd0fKArvTFc7QuuU7WxysovWXEmLR2/8605waGw+/Tdmg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=N2kqimeqSHHZwBj/mynuMscNQhhaWMHy/gGrWOK98GI=; b=B
 ThYBBgm5HQCv4fdi/+RlKktXUiDzSKzh8CI7YNa5Cr4JePBDdo52w+eohI2tOwbbdw1gP3ZFpkYH2
 ptWsKF8z1WObMovA0OS/aokJVQHGMd2dkATY3jrb3FEjKb5QXrsdspVb5JS+nvhUqjcoFIlsOdYwT
 7ZfIxwRIQA+jFeMk=;
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wytTL-0001To-0V for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:53:59 +0000
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c15ba3a2b4bso699541766b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787673232; x=1788278032; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=N2kqimeqSHHZwBj/mynuMscNQhhaWMHy/gGrWOK98GI=;
 b=TkbEBtSGdTPleGDWCg0wuaXjEKWe7YSvoSdM4kqS/hJyGpIVmgPOwHoLe5kWwBVfGm
 N38I4SXP++kEPew1F0vJXgGLUi8cLGyijcR4uGzV8s57+lDk6lW6k93bQX5KQV3QSrg5
 4qVSKbANy3jFFCo5uRdHPULTPPVCxV0O7JJNq3zSCzxbu32KlDbC/W/v96nkx/XiTB6a
 UG9i8itlpDZHzJEpYIkVyM5vdcSZCtnpvMpcJTKiEXPbTPlFjjrVawEWa02gSQZOfIaP
 IB68O7NwJbkKjduXKFPwRjVs2vVH+C6KGoKEO3dq4aCyOBvtwpS/9Ci9OeDXUzbxcdg5
 lFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787673232; x=1788278032;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=N2kqimeqSHHZwBj/mynuMscNQhhaWMHy/gGrWOK98GI=;
 b=bkZxXNGxYnbTdegUz7txZ81vUmkinBxVGmyt919+QVzcuuOOEL04oVkjeRQvhaUHAl
 fDYYKUaiMTbQqc0AaLLbBWuyywXXGsVO4Q/zN01cJsMoJzpD1RPntr8WHi88jqmpkfD+
 bEDX3lv25b5m0m4GzMSCmacm7Aq02NaEHfneKmNIFS/EqWjDD4fADl3RHFxHbCqsJmFF
 hvK3KeSfNC2BsxvZmdxtZttZfNGZ18uE83Hry/TgShgZ9PTXHWw19EHOOrCdf6NGD0H6
 30bU0+37D+3ClXyUm4rU2dFZdvsqh1c6qo2pz+bm+z9C2rT/nJMP7SH+2R64MMJSWN5N
 i1fQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrH/vFBiz2kO4HAqTo9VwFn4wG9utCFj84+uXf+W3SVqFCVGQLrTtfx9mfTJD5b2txVEgbZDUJPN8flChk3@lists.sourceforge.net
X-Gm-Message-State: AFuF++lbvd3NvPaYK2lrH5ksJVA9hxlylsech8d88NVD4y8CWyFJx+lR
 FWMnK4Cj04dWa9HHnDgJGk4C04RYkzYgBl7pxXF+J+kokG15nr23+G/UTEgdAhuaGo2R+F+5SAW
 OQ0ZYXVGGlvJ2TcuoSANRcglo3CwKX6Ow6/jswhW5ov5zV9+Meth7Rjq3NXBAuaJd3Yug
X-Gm-Gg: AR+sD13oG+vS54205c8hlb+79blJ+ASFjW/1fn7lXtiRMXqWj5dA0YgSstQhd3By2El
 DiakOjn12uftTG0oWZFu/J8W4D0ZfkPQ7sXr0F9FWqZGffiM1uVwjj0IC0q+3LEK6kDJlUU3e6/
 RXAoG24v3fITrDNdHO9AwyRzL1DB64XnmNqg0dzme1yFfdrCHop459SySnDbLGE+xt5DE+Xq/aS
 VqzeKTq7GRJpPsys7t6uoc4XY8WEnTwQNLdmG23tw8fm3LvMtCCUw2aujivf+i1sEHILQv3SUcR
 j07mY+tXSwD/dX1K5xaPE4aBRrLmhBAhMR54zaodMjpaDmYRZqjhG0Iv3V0JD6GOeOcqXTVmQwb
 9QSbx3Ll/VFDH28ldVHCJekDF0R55LbQCh3csYUoEZbSZCTtmqh7ff/U9pXDbj1a4s8PeFAiz6U
 uZEPovMGusR982scYXatILIaCtAwh5vEyMbZtkqS+4iHPcXF/j58HLjvQ7qppkt+PVYPMkd6aRF
 sQ4DqIuNMfEaL2W7SuO10Ub6pRbmyMP5YsmXGv9zxOTrRiMLU4yKMhcLijF9wumXIxNrDCsY8X8
 /mhrAliqoTHH7Hg5GacfhODyToHwXgtAqfFDjQXTf5bAnrTE8ws=
X-Received: by 2002:a17:907:1c8d:b0:c15:ee0d:9a32 with SMTP id
 a640c23a62f3a-c246a6aba8fmr4108059166b.21.1787673232260; 
 Tue, 25 Aug 2026 08:53:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b10cesm11449666b.48.2026.08.25.08.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 08:53:51 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 15:53:49 +0000
To: razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I57b4122b292f643ddedd91e81bf95fe2f5b2e03a
X-Gerrit-Change-Number: 1850
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1850?usp=email>
X-Gerrit-Commit: a9543c4fe3e3411894b6e65fa4291211337b4d98
X-Gerrit-Comment-Date: Tue, 25 Aug 2026 15:53:49 +0000
In-Reply-To: <gerrit.1787150406000.I57b4122b292f643ddedd91e81bf95fe2f5b2e03a@gerrit.openvpn.net>
References: <gerrit.1787150406000.I57b4122b292f643ddedd91e81bf95fe2f5b2e03a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTUwNDA2MDAwLkk1N2I0MTIyYjI5MmY2NDNkZGVkZDkxZTgxYmY5NWZlMmY1YjJlMDNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8c2970a24ebe0acb4c6322ca0e53e9bd7090ad2f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wytTL-0001To-0V
Subject: [Openvpn-devel] [S] Change in openvpn[master]: doc: Update doxygen
 references to removed tunnel_server_{udp, tcp}()
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6736849128583885605=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6736849128583885605==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HASV9lQBuEI="; charset=UTF-8

--HASV9lQBuEI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by razvanc=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1850?usp=3Demail )

Change subject: doc: Update doxygen =
references to removed tunnel_server_{udp,tcp}()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1850?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I57b4122b292f643ddedd91e81bf95fe=
2f5b2e03a
Gerrit-Change-Number: 1850
Gerrit-PatchSet: 1
Gerrit-Owner: razva=
nc <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@ma=
ilbox=2Eorg>
Gerrit-Comment-Date: Tue, 25 Aug 2026 15:53:49 +0000
Gerrit-Ha=
sComments: No
Gerrit-Has-Labels: Yes

--HASV9lQBuEI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1850?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1850?usp=3Demail">change 1850</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1850?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I57b4122b=
292f643ddedd91e81bf95fe2f5b2e03a </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1850 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: razvanc &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Tue, 25 Aug 2026 15:53:49 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--HASV9lQBuEI=--


--===============6736849128583885605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6736849128583885605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6736849128583885605==--

