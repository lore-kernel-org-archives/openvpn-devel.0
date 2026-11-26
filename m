Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F243606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b+MQ8psv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=crpRinh4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DA6X8Qd8;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VSIdGKe3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/JZO6gv/IGA/hJXXWDm/vd8ou+3yTUCZZzKnbSj4yaQ=; b=b+MQ8psvHKlhR3NL+W5a4qXw1t
	T6GzPSa29uQRwCJmQbVwFxkZPcwyuHI8DKB9VjYRlK31prACH2bQ5eM5bEmOnRkAiI5RTPaxmAfLW
	OKfNj2Q8hnkAZg+gKX5ssO/j1+v4WMmUEKf7W4iffmAdt0Oj4p4nt9gZiJes9H9Th+No=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWXk2-000000002ZD-1NoT;
	Thu, 26 Nov 2026 11:34:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWXjx-000000002Z5-3ddt
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:34:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M7plxqprBvwjCyNaLTqGq8l5164QP8gJX1qU+2Nw1x4=; b=crpRinh49WGLZrxIu42z0LkMiS
 Sho9GclIeXE3jfYVekS9xW5ByKZtinFB3QKDspbwGCdkngwgBVU308l3abPoNeAi/qoq+TcjRmumk
 52fs/JAOOZymJ1M2PJ2+y08evcY/ntsdgL5EVAQ5bIlIwayDwhkEGjLoq2z2o5QZ+DUo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M7plxqprBvwjCyNaLTqGq8l5164QP8gJX1qU+2Nw1x4=; b=DA6X8Qd8xdw/FW2wdNv1K3yo4o
 4bDNyib2o09+hWD8sOj9jlk+FFL+vsM9kxeKOcHOmfJ135MThRqLSo3JfrdYziNMBDdflUqou3tU9
 /cnepcMHJ9y/K+s+lpjgaxC2IUarXLXqa4MipfdcC8MWKAkgjPmB0U/xRTcUxLqhF6eM=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWXjv-000000005QQ-14I2 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:34:13 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so57319815e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 03:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795692845; x=1796297645; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M7plxqprBvwjCyNaLTqGq8l5164QP8gJX1qU+2Nw1x4=;
 b=VSIdGKe3BSB0X66RqmHSzZu94QHGpBKaGeEnwc2FDgokN+4EKM+nnZyIeB/c0byHVl
 UZdaABjzyR9mo07H4wPcu6UrZwByPwSiXX8a5VEM64tdfX5gnN6DxQtdHQNiS6qJYHEA
 gj4+RHXuFKUcLd3XXeF1ptvy00cQv4EFOaqnoaNvSToOIj58Wu76dYnaEz2tg2IL2rdz
 00IHzg+MT89XbjhjTqQFO+ojVP9NMDq9LtgHibpSqnjaSHZTK6v0VaaBBl1cq35FK7fS
 HMIhYe8M068CHw5dx3NORap7K8ZYlkgI8g7/whJHybjZnilSZ6dqRHqjRZG1Sl+mNgQU
 aceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795692845; x=1796297645;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M7plxqprBvwjCyNaLTqGq8l5164QP8gJX1qU+2Nw1x4=;
 b=IY+6MHbS9fKgAEH2mJoqGJbQQwjcbFybNi4XERhRwPNnmFq6mCffmgjhvXQg8xRbcG
 YcPSPm7NFNzCgtTDPtiNPPR3eBoIc+acA0+IPstp6PlpFActy13A+LRK9G28OBGcZBNV
 WBv7Pgzdtqw/vchUDzA3dagD8ZHq+XCecxgCqF3mAek6Ic4zpg5Twhma01Kf8Q0m7HaX
 7MraYRWT4y5UJMx/GiYHCWukmF5TEvdoEYKh/TgYaY/U42gF3WVDS7TRz5O+1GOgN5Zs
 6wtdXdmseYKFUOqqKLxuXk3LzZlFhNJu/yafArpaTiTb7nQDbAeYOcZ0WP12JVjtDBJL
 xcrA==
X-Forwarded-Encrypted: i=1;
 AL+hErG9MabpJ/jcALktgZBkWozEnNu66q6mkexY5DLAZDQ59xy8d14LcLjaGLd+dOiFOzF0OldDvAlyUHvIy2sT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/e4gVoL3O/NsWTdlaryHRusUeLh88skCAkXdKj/Kt5fXMmtn14
 /FKV0Opz+/Bmftt+6/kZbC0ICcWdzlbgLaPXPB5xsDU7r3WH1B25yBqwOVd5NzkfbabmC/JhtDq
 hb0qHOdS7Wf7aKESPxvEqMYu/k3OXjHEFKmWMfDOsLHBnvl9kG5NZpvr149zDyImvL5a/
X-Gm-Gg: AZFdTZeqq6okLXOn8vAnAsIMXPWczShbaQFGYNHpj03zYtvR/WOGKDXICGxzuueObvq
 zIpqcqjwsUoH1oWwCjH1YGWmT+567xHdbCiMbzJeKPrvKB93soqT0A+TU17k1ggLQ7ZWS5p4GmZ
 K2UMOMeYAlKvcC2XvlZZUA5FKKDzObKrvDTzvgjE4mZ2PBkZwY7eXJZMltRYs8jZKTfEFGw2Jhw
 GPvIFfK04Y04zciIcx7LwLdR3iRZn2utxNMXuy5qS/ryhzzkjP1wV3eqzRsKHB/legq7ll+a8/X
 8J0h+X3JpEX/FG7DUEZiptFE6+P+r/3AyClT9OKvzsK+FcFzL0yxa6RqG1Pi1ovXeVATI61Rdyy
 VloIi92FTh0fjGY6LEmAqWJMM3WHPAr4u+0OpUifJZBnZ0n5VWalqsfjjUBo9i8IrXvCaJfTvDi
 SkwAh4CFRPaNsic6gD7APmTdvoshqguBc28KxYCb9ZR5OkHEQFTu6vxWDNXvsDoYHwr3pmKTe6l
 +TdmVuz77LM0gauqwtfsBD10KFvh2NBtUKq41tvpTHvPXtYwhhJEEvPHYmbOnplVun+WBXXafE4
 I7x427ts1HQ1PkpkY9gF7Pk1FNBaDDFhJ21Tu+9cbPt/v2BtthmRtgw6oHRRqk8KM1luzOT5F3W
 DJsgjzfxxdtScV3bsaL7cQ+qKAjA9IbXXa7afW/hCP3igjYHlONYf2to3+ekLdVY/oIVvrovwim
 p9JlTlX2/rInZ9L1o=
X-Received: by 2002:a05:600d:600b:b0:4a2:18c4:61a5 with SMTP id
 5b1f17b1804b1-4bb887fb6e7mr427893805e9.6.1795692844477; 
 Thu, 26 Nov 2026 03:34:04 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm836792145e9.13.2026.11.26.03.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 03:34:04 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 11:34:02 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2
X-Gerrit-Change-Number: 2342
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2342?usp=email>
X-Gerrit-Commit: f7498a7b2c968dd37b1b8068c93e6982ddbe02bf
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 11:34:02 +0000
In-Reply-To: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
References: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYzMTc4MDAwLkkyMjVjMjFkYmQ4NDM2MDFiNjk3ZmU3MTJiNWI2NmMyYTRmNWMyYWMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2d02b9646e92326f3ca6b2561ecaea9e463d0eda-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWXjv-000000005QQ-14I2
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Windows: Switch all
 uses of address family to ADDRESS_FAMILY type
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
Content-Type: multipart/mixed; boundary="===============6239033556585871897=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6239033556585871897==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6U41z45NkYY="; charset=UTF-8

--6U41z45NkYY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Frank Lichtenheld ha=
s posted comments on this change by Frank Lichtenheld=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail )

Change subject: Windows: S=
witch all uses of address family to ADDRESS_FAMILY type
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Build-Request+1

=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I225c21dbd843601b69=
7fe712b5b66c2a4f5c2ac2
Gerrit-Change-Number: 2342
Gerrit-PatchSet: 2
Gerrit=
-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment=
-Date: Thu, 26 Nov 2026 11:34:02 +0000
Gerrit-HasComments: No
Gerrit-Has-La=
bels: Yes

--6U41z45NkYY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld has posted =
comments on this change by Frank Lichtenheld=2E</p><p>Patch set 2:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #d4ffd4;">Build-Request +1</span></p><p><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail">change 234=
2</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2=
25c21dbd843601b697fe712b5b66c2a4f5c2ac2 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2342 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Thu, 26 Nov 2026 11:34:02 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: Yes </div>

</body></html>
--6U41z45NkYY=--


--===============6239033556585871897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6239033556585871897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6239033556585871897==--

