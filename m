Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03E3C44507
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0YrTd7y+lP0eoGR5mroHs3ena0Pn//FtKQSGeUpCpac=; b=Qmo7DcWvBjBnyNlAwaufF/aJME
	EMma3x6AApijSFT/Hld3oXDNkudobXprQeVk+FCqqMh4Cf7/kWYH1Kg/dex/X47XS4KNklUvgP4Ez
	7YtNbhTo72VoUakJ4RaPw/ri4ZOm1fSOm8iZPdZtvsYQklnIgs7Y9ZkvHUNF2QFq6vDY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjbqo-0008EI-3l;
	Tue, 14 Jul 2026 12:03:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjbqm-0008E4-Ru
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:03:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NLRFvTJJpZ24jwsXrrvQQBeEb9DrcS9TQJlizxFf2Uo=; b=F9+LLnMXSIxqSkJeVz/qB4Q4Y/
 VL0d/cOkum0xzLOpqqseMIfSH/c6ReFbVE6Fj08H+ckqRmJn7mU6ORoWbpNUnlfnkaDbhY7vrCFA6
 jfQVFGnTWM1eEOsQjpEHeRKwfgbKT/8z8ElQrwaTTaDAcFE4dWcxbiaBrGWZJ3O2hUiM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NLRFvTJJpZ24jwsXrrvQQBeEb9DrcS9TQJlizxFf2Uo=; b=l
 U5zcpAuGnMe067xiYC1uQgLcKjFXjOnyJN/Bjh+leYGEKgza5LnF795G3gTCWQv0te/dZDhIv3S3n
 DElIXJkI245UlDiS5Ov5otOSxHzZ63oUdv62jzS/1ZuEAFezmSHUOy5OhH5O8SXZn8X1BXroTS2I5
 ay/31keXde7BITSM=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjbqd-0007C5-Vg for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:03:00 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493f2e39e81so17149415e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 05:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784030538; x=1784635338; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NLRFvTJJpZ24jwsXrrvQQBeEb9DrcS9TQJlizxFf2Uo=;
 b=TsEzfn1kok7d1KXsKuIiuYjbCeqrHcNKAafs5I3EZyfomQQdB92cMt2rbUg0CM2are
 c07rXylVIitbKXo+UvIElLnHYIBzCJSjq+9HygkxtZrMOgEMYIcwbt4migRTHdHHdiXh
 Qgp9v/JK9+jUk+LJRwcrdZ0FYaVBfoM3Di9oxQncjBpwDvvMh3jCzudyeB17DZgeFutk
 O0i2384wSXHY1ArNd/6CO/1zxnUIBtVDZLnNGcQ+jl2ShWzzGq+ybWoB+amp/ZS0lMiv
 lu22LsKD5dF3BIaFkfHnC71OqOea/1bH6NjYY5+GDKZHCgp5KBzc1EKMU+/Z/GPEgkFc
 1nRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784030538; x=1784635338;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NLRFvTJJpZ24jwsXrrvQQBeEb9DrcS9TQJlizxFf2Uo=;
 b=pdAZZLbP4KwJJ2LithbfZSWX4UMO9rzZi+Tskov3iP6Zc/wlU4sp0ZyaDO7l2vCdcw
 RRx1Se7oSHT/PhouZOIJvEVruNXr8XXDEBPZ4jDRPUPQPG3Iyn0LiS/9lFjYWhT4o9v7
 6CsllDKqiqUaTzhyGimc1/DIcK6eL3G/SlMCncKlmiaiuYRGjcAjP2ky8TJMYYbjd1Ta
 zKFoi7qLSVsqP/qw6CFm2/ko0hDsal21PbisYWuuHjgdaD/lsUTLzQiXJePYQNa/qWcP
 fNoMIMCghxekfThKGpEoA/rXMtrMQPTxJpDABIXe6uNIfTBQRzrh77gIb4MWJzlJ/6Qo
 ty7g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3W0po5zieG1Hs/jsVnrlpg3wbRmlawTdDm66T6TracfcDEDGuHZFWkLORmHmBfoeeI7VRrt8+D2I+I2SA@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzQOI1Y8A0ZbPN87aUaUYi5zChvrVANBqne3/bkSB9zZAOB7Ejl
 GX9C5wL+kxWAlMysLj+RUwm+pWffbNsLNWnYYES3L4GSS0G2PEMJVm/HP3OWUzinTMylj44Ir3V
 VIRDmFFPl9mIBJQmwLTIod218+sHU6Q8kaRNQBahu3Q0M6V/ND3gStdlMexWm6NPHrFPnEiBez+
 LVoJyt0Q==
X-Gm-Gg: AfdE7clOxWlm6Zb/oXZhqH20g15vU72Q+JakzznhwPYS2kENfE0aTTr4p2xKwdrCwfP
 fZyC7XmMcJLeNIYZaWCo1jJTu5YKjjM9vrjcqgKFsZh+QZIH5KyR0Z12Q3+HojK+N2EtkG1+svk
 QAQAYCQnXIGb7zZZiahqTyBLEBgSsFGxIdP8p2jAwTJREGskIJ0EXOBbL6q8yA8znkkOVTvq5OY
 UxIpQ33p0m6mFcqKqZqFzqLfJ6+Fk8Wg0GpCTo0s42dWo3pc2AP6XY7u0kFr7ZI5WLXHqpIqynn
 MzVQbjGs8rnL0gPhJst1cn59N4zmmJ9wUvoKu2lWB9Kzv3EBXdYIqqJaQhCs5wtbr1CvkrQQldo
 oPxdh46htt9vQcNrRNFPUDdickNITY0vnXnmklVlVmtbB366aKZs75hPbbQi0eWXu+UaEb87Vy6
 LR6e6+YVFACQyDaLwucD+OKJRQtozl3r7gD6F+RKzt0pKC3o5wOSzDygJtRpdXr7PzEb/DUUg9J
 daomVvKpkLgdTik00LgdbKgmdwGL+Afywic+J8UVgAA3p2sPVACarOPzlFXl8npMypTDTA6iGOt
 kCg=
X-Received: by 2002:a05:600c:a42:b0:493:c77c:108a with SMTP id
 5b1f17b1804b1-493f883c8ffmr138270265e9.36.1784030536325; 
 Tue, 14 Jul 2026 05:02:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635a63esm8051194f8f.9.2026.07.14.05.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 05:02:15 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 12:02:13 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I9f10d91407347faf32397535c95e2d80a1575bd5
X-Gerrit-Change-Number: 1722
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1722?usp=email>
X-Gerrit-Commit: 3f2f6171c104d6725e08d3889206a373f041a627
X-Gerrit-Comment-Date: Tue, 14 Jul 2026 12:02:13 +0000
In-Reply-To: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
References: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk5ZjEwZDkxNDA3MzQ3ZmFmMzIzOTc1MzVjOTVlMmQ4MGExNTc1YmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <05a6153c881a85051d763d98bc8200e8919c35f6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjbqd-0007C5-Vg
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Move incoming data
 processing in its own method
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3233063834134676569=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3233063834134676569==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k0GdpHaFHg0="; charset=UTF-8

--k0GdpHaFHg0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1722?usp=3Demail )

Change subject: Move incoming data processing=
 in its own method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 3:

(2 comments)

File src/openvpn/multi=2Ec:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1722/comment/7cfe05dc_f79653e7?usp=3Demail=
 :
PS3, Line 3310:  * data packets, so the be be forwarded=2E
> "the be be"=
?
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722/comment/a91d9210_b7=
f3ab30?usp=3Demail :
PS3, Line 3312:  * @param m P
> If there is no documen=
tation for the params, do not include `@param`=2E
Done



-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I9f10d91407347faf32397535c95e2d80a1575b=
d5
Gerrit-Change-Number: 1722
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Dat=
e: Tue, 14 Jul 2026 12:02:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Label=
s: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--k0GdpHaFHg0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1722?usp=3Demail">View Change</a></p><p>2 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722/=
comment/7cfe05dc_f79653e7?usp=3Demail">Patch Set #3, Line 3310:</a> <code s=
tyle=3D"font-family:monospace,monospace"> * data packets, so the be be forw=
arded=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">&quot;the be be&quot;?</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722/comm=
ent/a91d9210_b7f3ab30?usp=3Demail">Patch Set #3, Line 3312:</a> <code style=
=3D"font-family:monospace,monospace"> * @param m P</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">If=
 there is no documentation for the params, do not include `@param`=2E</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail">change 1722</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9f10d91407347f=
af32397535c95e2d80a1575bd5 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1722 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div=
>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Tue, 14 Jul 2026 12:02:13 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--k0GdpHaFHg0=--


--===============3233063834134676569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3233063834134676569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3233063834134676569==--

