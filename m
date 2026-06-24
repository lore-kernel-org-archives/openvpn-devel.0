Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED045CDB479
	for <openvpn-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=izls6oS8qGtPa9vXHVgORFcIRQ4g9aP4swIeQtJxZ4E=; b=EgwenPcPRXH6seOSjRk+zFn4Oy
	hoKK12stAm6zc4mbZZ2StRfwkS5+hQEzPEJ7tNgNE42dT07W3BWLk/a2xCY5+HC6iqcDp4SBNtclg
	Dy5BUEAgLIGayoidccCyB6122DUuqUBI+m5XSiFJ7u8e4VCVw5BxvqY4ijAhYj0OZb44=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcNhv-0002Y4-Ar;
	Wed, 24 Jun 2026 13:32:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wcNht-0002Xx-Jd
 for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 13:31:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dPaVfQK+JNH8PcxHq1Roo+rPVuOKOoshgYTQSUNgqmw=; b=U9NZJbnSAxYEPgywH45ZJEqPxu
 igk5ioTSX9fekW3Zz7EY+fGqc5fDhF6Si+r+y3qWVA4ReQp6fjx+bIrhbI+DU5vJO3FGs8caVkyGT
 82+jNSmA1LQd+rRxhL5sbXU4rse5wDQDixahT33i2il1XC1vUIJVwEU0RrwlnTtnfLww=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dPaVfQK+JNH8PcxHq1Roo+rPVuOKOoshgYTQSUNgqmw=; b=J
 xs1TImQqvAwCALHR1rFzauWLy/Wpny4csp+GyGKBtxhScO3Ffs5RgnLNR8h27RU8zbe7pa9+O5XzM
 uGp35FBWSPw2X2lfD17camSchg0ZUo/dlv3hYasllBTmWlfS4halkH0zWFZC81DROscveVV3pnEe6
 XFUbKSv3+abwKDFc=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcNhp-0005T8-1j for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 13:31:58 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so10933155e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 24 Jun 2026 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782307907; x=1782912707; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dPaVfQK+JNH8PcxHq1Roo+rPVuOKOoshgYTQSUNgqmw=;
 b=f3PqBwRLH0MCC7vxK7ikpKlrTsv6SkvvNWGgGSXKouXhcLNXNTdf8oa7H4bfWFZeN2
 9iNjEinKcilGfNlEaS3m+bQA9z3KfWXRL3WJBlUAh5Pgq/OCro3fBLZNld7K+U9yvQMo
 s/8l/tDfRFzwsxzaTmdsBM/mVtvoZoMGy8g2uX38XtaYFohG4ppFfT1O7wLmTU6UUlA0
 kOA9fmhW+MipuMl0HYBCRpvOjy3lIv/Fbir3Dp+0r84zUKkaFVqtpEqoeDfetIXMuIup
 fHJZeqSeIxe6151f2p73deeMJSZWu0yrXzwhsfZ1hcF7gsN7/h4jBxGhDkEgKeQClT+Y
 Y6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782307907; x=1782912707;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dPaVfQK+JNH8PcxHq1Roo+rPVuOKOoshgYTQSUNgqmw=;
 b=MeulHYm0S7EauhEMjJGSH11E8fyG0sIFO0f8775o40gMPtzcw7iN3FCpv1IhiZT72J
 sz/YR9nP7HEp0d1tM3klrBMuEvly9oYs2No9TWbSOzyVjd07qZtq7asd5jbuJyOCkFDc
 XyaAcGeo7kTuvlKQtVL4WhAit3WVtanJMyEhg6KimOg/OqNKedSB6n/4tJy++nOrXQIZ
 oZWd3/vFic/NW7GJEZyv+7aZw0bVPF5JiPO6IFb7mTRUikw3Ib+QY+/DzV3CYg7tWrm0
 RmLjhFmoi1a7mnynb+dI5Vngq0QnGDHPztXt8Ag7F6h5p/krFRgltmdwbWcVspzgsMEo
 ozkw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DKx4l6U2NUUlRrSDe7qhqlRyQLPHQkArnLPUNA1aPBirXR4RMJKAFZ7pZA9PJZ2UUYcLXtlBUF2+4oAyb@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yzf38gr4axLdYim+wy98FfFsjkBJaugsGn2aQsuHR8FOjKdxPKd
 +NHZSnYzopgXv/aDyRjaWQsSQ56xKVhSBVWG4sPafUhO/XBhUq/z+szG/KaohSJD8bwK8/d1DAV
 fZsqkyd37JCPJNnsEGK8JDaZHF6pYw/NT35O+EZCSl3tTKJQKGRbTYI5NNRq8X7Su/sqRsbh7BH
 T7AgQypg==
X-Gm-Gg: AfdE7cn9ImnZkiARgba5I1dG3Ld7MXpFh6bcAfKzh+qPo8J3Aa8l/A+0z5US7K5WGLy
 XJqhhXqKvl3fzyzDCPJa9oMFih8YQ33DsrwxxHUjiIDWcc3UbLiWoRQmIM7MI0G4uf+cliRb7Vb
 OKCF5guyCe4K4erAA3g+rNe9/hQWbknCFLO+vntQGt3cSlW0cOdmbmnnicWkpV1IotfJJeBzJP9
 7kDZ0uzqj/gWcVeFmPCP31mAwQL7tKPnnbqjaNG6ciz38CXSH3ggQ9otnrzq204jorGz4aAhhwc
 UoEE2l5n1cCxb8xCee/ErnkL28K7rWRj4ObAall/8UYQEKvQkQZfj29BocUtmTXaD7POIXTcRe/
 GqAlJXGFnf8Y5+tJB4lQP75B1LZOUdsPmwucHU9250RP2zDBT/ZmS7OCK7q5Cysz3GQ3uT5eova
 Ky/raGoLxh4RgjyTKkxm/RZUdMq6gib3N6gO9o2981OMb0dYxu80wQ34L6/MWhDRYwfRWcAy6UY
 aQxhXIfzzho11ksc7bL7ZYwcpqoOa2WGBdIZjJ24yTltWCCE+DnfE/Ll6IilXmKqeN9wc4i7ZUi
 NHo=
X-Received: by 2002:a05:600c:c0c3:10b0:492:53e2:7712 with SMTP id
 5b1f17b1804b1-492608726a0mr36781685e9.21.1782307905829; 
 Wed, 24 Jun 2026 06:31:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926064e948sm60373755e9.0.2026.06.24.06.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 06:31:45 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 24 Jun 2026 13:31:42 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 02829edd0828bd5af8934ffba182588901a03440
X-Gerrit-Comment-Date: Wed, 24 Jun 2026 13:31:42 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <30122c3ff696fc0d7be576a9120c168006362ecd-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wcNhp-0005T8-1j
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 gert@greenie.muc.de
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2499672167038560600=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2499672167038560600==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pUdiQXRbbUQ="; charset=UTF-8

--pUdiQXRbbUQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan=2E

flichtenheld has posted=
 comments on this change by its_Giaan=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1089?usp=3Demail )

Change subject: multipeer: introduce asymmetr=
ic peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 16: Code-Review-1

(4 comments)

File src/openvpn/multi=2Ec:

htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/4cc88294_1a96a5b5?usp=
=3Demail :
PS16, Line 1729: 
spurious change


File src/openvpn/options=2Ec=
:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/a92aab4d_80a8d40f=
?usp=3Demail :
PS16, Line 3890: 
spurious change


File src/openvpn/ssl=2Ec=
:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/92521dd9_9d09e7d5=
?usp=3Demail :
PS16, Line 2347:         free(multi->peer_info);
useless fre=
e, we know it is NULL


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comm=
ent/0dbe9a30_4550caf1?usp=3Demail :
PS16, Line 2348:         multi->peer_in=
fo =3D read_string_alloc(buf);
This needs a comment=2E Why if we do not fin=
d a peer_info, we just try again? Where does the empty string come from? An=
d why does the MODE_SERVER code only use the first one while the MODE_POINT=
_TO_POINT code is happy to use either?



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Chang=
e-Number: 1089
Gerrit-PatchSet: 16
Gerrit-Owner: its_Giaan <gianmarco@mande=
lbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewe=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerr=
it-Comment-Date: Wed, 24 Jun 2026 13:31:42 +0000
Gerrit-HasComments: Yes
Ge=
rrit-Has-Labels: Yes

--pUdiQXRbbUQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan=2E </p>
<p>Patch set 16:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Change</a></p><p>4 comment=
s:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/108=
9/comment/4cc88294_1a96a5b5?usp=3Demail">Patch Set #16, Line 1729:</a> <cod=
e style=3D"font-family:monospace,monospace"></code></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">spurious change</p>=
</li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/opt=
ions=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/a92aab4d_80a8d40f?usp=
=3Demail">Patch Set #16, Line 3890:</a> <code style=3D"font-family:monospac=
e,monospace"></code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">spurious change</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1089/comment/92521dd9_9d09e7d5?usp=3Demail">Patch Set #16, Line 2347:</=
a> <code style=3D"font-family:monospace,monospace">        free(multi-&gt;p=
eer_info);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">useless free, we know it is NULL</p></li><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/0dbe9a30_4550caf=
1?usp=3Demail">Patch Set #16, Line 2348:</a> <code style=3D"font-family:mon=
ospace,monospace">        multi-&gt;peer_info =3D read_string_alloc(buf);</=
code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">This needs a comment=2E Why if we do not find a peer_info, we jus=
t try again? Where does the empty string come from? And why does the MODE_S=
ERVER code only use the first one while the MODE_POINT_TO_POINT code is hap=
py to use either?</p></li></ul></li></ul><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">change 1089</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706=
acf20eabcee3bab3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 16 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 =
&lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Wed, 24 Jun 2026 13:31:42 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div styl=
e=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--pUdiQXRbbUQ=--


--===============2499672167038560600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2499672167038560600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2499672167038560600==--

