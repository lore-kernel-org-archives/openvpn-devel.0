Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4082A606A335
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YfJwi5AW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jdZWk40v;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Y4rA4C6/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Tme2681x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hh94f4ys0acXL9cMrbc5P3GRpn3k9Ue43hZRkkQ1YmY=; b=YfJwi5AWYWHmtYGcAtB6nlw/ro
	jiNqOgbhqM6zIZC+XeSSULaY346EX6l7MoxePkP5zQpyyDdg84ujOmVEI8YVMYbRQP3XIwSTSb6Ez
	BU2tMB9REZJkV3rk4YXdTrLSvsL0Lsi09ZzAZH6PQDxkkfLK225204X7AZEEw59Uk5dU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNqhy-00000000203-3WkH;
	Mon, 02 Nov 2026 12:00:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNqhx-000000001zw-3hs2
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:00:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YFu8hu//U05HGjY16yh9NZiXg6zVo3lgySrDfOcDoD8=; b=jdZWk40vf3LKF5+/l4B9yCyssh
 WQhgOPjD8aZrK9Ie64q46CFSJCHEWa6F/A8RjLG8HjIckyd6dsEjn9+jcsYHJCBB2FxQvXfv6EYwk
 Vi52pqPMaupDSh4pslmG0Pr2fUiHxFJRArCaxn6KtoztxZOkXGgt8wm0sjUOwDv89i7Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YFu8hu//U05HGjY16yh9NZiXg6zVo3lgySrDfOcDoD8=; b=Y4rA4C6/soTLS08jN1ovhM6/jJ
 Hhf/j+2gHYinhOqXld3KFSF2SiTnme6ZT6xUj4oKNbHg+wKkEgHOs1idxpj874cnLkXbA0aQn1dZd
 c/j+8utBt7u+uXEFWEO+zoVhsUbaQMSx/nGRQukoif2ZSRlcXsTPK7zOCT+0mAlG/meQ=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNqhw-0000000061i-15EZ for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:00:13 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so2334284f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 04:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793620806; x=1794225606; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YFu8hu//U05HGjY16yh9NZiXg6zVo3lgySrDfOcDoD8=;
 b=Tme2681xLzh+sFoMU5tRQzeAfmRsBpLEdyTXZELBOSf8fhZdyC5iI9b14d5I3F0R8t
 yisn8+H+a/jZgsbPRtZBd5r6n//qWlgo71/0A5QGwzq6qm4RkwDIt/b2E28equNVT1Fu
 lKQSbZ2wr29X6cj5rJpCPsotKCuLwKDptC9fx92du09xotIe3GOtis8uXC4LAm0RGzeb
 41D8R0d/2YP5tXS0aKDgapd77zRKB+MNvJVYQeKQo1aSwoW55ZMZU3Ae75aEGl+iL+ja
 7B1/AUpDcDJA4J1tIwHfgp3r+lb/4RN1JpwXljmM9JSQI19i+HowOwpOtQ+rtpFl86O/
 0KXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793620806; x=1794225606;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YFu8hu//U05HGjY16yh9NZiXg6zVo3lgySrDfOcDoD8=;
 b=AzhAcr04b1nlYuTcmcQtcdf0ThG3ymZhPpwFGy6GX1sIYOT+KTMePGlNpCe88OMitx
 6GomMyhrZGwABVU/4NyADKopmVfXTqvJ8Qeebejk/Va1IVnE6tb3qxXZamUSutqw+TWK
 IxnV4AlS9JXcHNnlqNEBHoIjcXMfCfXWaNZZ2SrgiEJDmnQhWKBCOTkHQMEMK25eF8SE
 lowwAPVv9L3BbCCOs8HcUtA7aL9cfoXqZCjx9rMUI16VJdeTp6ybXMMeZuOEqZfXd2nV
 CozXLp3kyF802ao1kxUR9pwZJT7kRSVJoO7siNAGNtdvyJWQfcaZ0vBdY5N0Gks0Ceos
 m1PA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzh7Qdl6l/Q1JIWD+ZBPhpXlZBDk+BubfRg3HM+vqfNCxs5VPS8ftSTcBIYlqHnIngi4HLmvarYk+t61UaM@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJIQnOhp6pCRHo9UxjHNgTqhq3OkwY9MeWEjmlyar5heltxSd82
 nD4QYU1llc5GQtDrYtPlObEoQKEpXrI2XRFkWwusJYLaMQLW/e4iEz2C6N1OingFsEN/C0eghW9
 /asGBiB5TN0OSoLYOXN+a7rxWHDAN/OAPPjnc1fN0YuEHJyQFWRnTmDWo3/Qgf101PqQVcqh55A
 gT/CSzyQ==
X-Gm-Gg: AYBFou08bmIWjJBHX+g9IK7y7OFXv7BYGArocE2oFBF9u9l3KxZXgNZ6qb0k/+uATP+
 NeNnJLqLwzDEQnAOUWUwSa4x8F6M3U7zy6TjF0D33ncKD6pz7kgtOndVdxvcvSuGPDF5VJVyTeC
 WXC50ORu9UVH9DpsW70NyXFBR5JVKzN6pBj3sbC09xmiqaxpVMviDLA/OWU3taC2ItImNwmBwsH
 UJcg2MOFLGSlfw56tsc2AhdO4Z2o+N2RE4rrZlym76VAw3FSWzUZ2oCrLFRwCxNZbIyC/9grWGe
 2lAJjWmpjA2eEJs0Sq7zIzkzIif+zVLq444VL8MMOdUR6JbSWKrX4lIGgpli/pj6B+OGUTkHdmR
 e9diPvQp20KPmqYTz8EAROJ0atvpi/Vr6vcDN2XMXukcqeE3hcL4NexXeQVpUtvhd3G8GFw2m+v
 wVu9exXPVod58/jfxsCVowVS4jG2d750B4TV7w/h/DcSrtoUueFskPwgLh5xDtykiTstIsAFsDL
 4GBjpZ1xIQGl9fIlNb0ux59ItBIQ55cHhDz+wuhFIwGFscdmobpuevDpiN7lq6bCeFMVhGYeXCS
 qdoBG7t3ElGNSGNX/MigmM9La+0jHlJ3heQKCyijlZqU5DWqYe+ynzZk/Ze5kqGjxqk5oktI5U3
 NdJJOTybMxfmnej0vu5Gf8Za1QXeubRBuVcjcuIkksqKtsKAsfSZTN38I8aX2W9HUsQQD0q/Bt0
 E9ZsFyc5GLpzJdMA==
X-Received: by 2002:a05:600c:1f96:b0:4a2:1a:a129 with SMTP id
 5b1f17b1804b1-4ac185bd363mr220459255e9.35.1793620805324; 
 Mon, 02 Nov 2026 04:00:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81a896ecsm357392055e9.9.2026.11.02.04.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 04:00:04 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 12:00:02 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
X-Gerrit-Change-Number: 2085
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2085?usp=email>
X-Gerrit-Commit: 18da77590cdcd408545fd532f320a5b9a452fe58
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 12:00:02 +0000
In-Reply-To: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
References: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE5MDcwMDAwLkliOTE2NGUxYzhmNWUwMmEyMjUzYmJiM2IyMzYzYTRmOWYzMWM4YmRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <69bec670de7ed5f81293d68f00c89166b9a27240-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNqhw-0000000061i-15EZ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: init: check
 parameters for NULL before strlen() in send_cc_message
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
Content-Type: multipart/mixed; boundary="===============2739809642036510703=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2739809642036510703==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2lS6+OrWwmo="; charset=UTF-8

--2lS6+OrWwmo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail )

Cha=
nge subject: init: check parameters for NULL before strlen() in send_cc_mes=
sage
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1: Code-Review-1

(1 comment)

Patchset:

PS1: 
I had added a cppcheck =
suppression for this=2E Please remove that=2E



-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
Gerr=
it-Change-Number: 2085
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 02 Nov 2026 1=
2:00:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--2lS6+OrWwmo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Dem=
ail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2085?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
I had added a cppcheck suppression for this=2E Please remove that=2E</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2085?usp=3Demail">change 2085</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f3=
1c8bdb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2085 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 12:00=
:02 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--2lS6+OrWwmo=--


--===============2739809642036510703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2739809642036510703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2739809642036510703==--

