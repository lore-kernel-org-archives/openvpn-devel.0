Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C488CC5CFDB
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JjG3IuBYyZXNrKsa/dUmWr39HyZIKU05aDaeIcxoxsc=; b=llsF6IiQoSLeB2E+50Aj1J2mhB
	+92Chn8Nnw3BMrl6tkl9B7NMCcOaCVkq8/6Wonr2QlmHL4OVe7SH1vTznu70GUtt9kntIx8M3Wicr
	UT9AFhnLHiZPkMhB2LflXFF9C0iCTBndFKLtWu24ZXMepo3xRTeYxkwYSWtMy/SqySIY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuqDp-00017Y-G2;
	Fri, 14 Aug 2026 11:37:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuqDo-00017Q-9m
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:37:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XwnXokpK3ZnXdlNZ6s5W8TX9GS/uV/95Dn85D+oPJsY=; b=Yd3h8mXvOg2hGfUzQmyIiR4Wam
 ibgv7MENjbrhSDVtHNuKVSvVp2D4KVkkn/b2YEU+khRhpIFKR9b+/fYdtqbdv5fuAIKXT173I2YRu
 +BsjSPRQl5gq0XcYoIbFUaVSG6ITzWkGKsqpDAVCM9H6Z3b0TBI0mFLBLFuCOgRmdBxg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XwnXokpK3ZnXdlNZ6s5W8TX9GS/uV/95Dn85D+oPJsY=; b=I
 dvscgKhcnxL3WD2Xe1gEfCfKf+ng/QebmfEw5Y80W/JuEqCOpPvHTKC2QxU9VJIDJNW2aWWdkpv3m
 KBQqFPwN0tDVy9EisnBlWO8fjE5N4m+ZsDQ++ADCUGw7b0PeYjIvT2X3NATSzhChEBuT+EgajEe/Z
 N1aHipVUnflSKA5s=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuqDm-00041u-CW for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:37:12 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4998590d392so9645825e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 04:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786707424; x=1787312224; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XwnXokpK3ZnXdlNZ6s5W8TX9GS/uV/95Dn85D+oPJsY=;
 b=PO510OLet6AeDW0MWf2Efi33oq0MqxtOdbJLdyYj8CruZY13ZKC3FDHkouYzzZSldX
 m30PWjR69EeX+NjlMMcKUkkr06qHh1uNKW9ymQOtnxVt4O+MKfAt//iUnrFPwATApV/K
 kAtx7Ucl7k6pfBGDugN6fZdpqck00WK+GYiaXZuzRT4Ie3+nHbHxM85cTeW4nSrCENjK
 8MjbTuQy5a8/psPsSjcf2ct8CKbhuwR2E+ksUWg0it6svd466VOYOIiRpKBEHu1YKlNU
 mAOnxVGJBuyg0oaMl8vATJJiME/QFYLRZqIYndqnwm/yNeaSrMCWo2nWqa2RBPe/Pu0y
 6F+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786707424; x=1787312224;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XwnXokpK3ZnXdlNZ6s5W8TX9GS/uV/95Dn85D+oPJsY=;
 b=dy2+U+ElUhOCizfR+bjiMeb15JY+8uY0ziRitk/p/ZJjBf4qrzcgvAXlEhnHyGSYHe
 byk59e7XuXwJhmClMP4VNn5MRNK/sJqn4gZCY6L73jEah+4ftoI/AhAGwdXR2ZkKM7su
 gG+5opXo6MvvhD8PXLLZ5XNT8AE7QcSpy7i31NY21Dnc3i4i8BySIruDJ5e/ulCUQ9Mg
 Dptt2r1huSXIsSm3+KEPyxszSkVta/Bl9X7GQgus0JOSyh1vrhSCutOQ517sXfF1UDn3
 /ajllkoCwiDF7evzAd3mtO5qy9XppKClVyPZbLXkrBrAa4UqymuXLcKYVhCVzqxlcon+
 TVpw==
X-Gm-Message-State: AOJu0YyynYcKWmN19kTS0XTD4qzvYEuUrlnG8CwR6t7MNkN0ZJMXwqvL
 OM9RG/KjEzaOpCuKRe9R3MWvxh/4y0sQh+B1RL5reXdVVsHx7Aj1YrqGwQuFBkIfkcfl9zG18zh
 Hpx3/9KE1+y6rcmZWuPofd7JmNIFlVSEV77Ijrkl5ghMwyRggou4YI3UBYdGS9zVGLq6v
X-Gm-Gg: AR+sD102x6kH/MrkjO5FMjzusccrQAJ/NFPnVQI33SBnIsyoconu1VIYXfRNuMvxIkL
 Jj+y3GJ3UiTy8lh3/i5X51qYL2o1Fo5v3rCkcAbV0RAA05JpWhE9egx68gbufSJHjnjmcg20sI4
 cxJWMWXY4ZUQECoPXE11IKb1jxMIhTnWmvisoNi62cAHHTtDqkg+HL+QVKl+kv7AtCOZSeVJC5Q
 rT8MIkAhC6YGbX3knaeZ/j2cCJLfIMczaclnCAfjecV+W8QlCq1nRRFJv3q8DixGzt8T4s9GMjp
 4l4cMpQcupYGA9FGN1HkT+kf5pT18HlornNZ95KKpkfVbY8Tx2CZnp5SxJvm17odX+Iqmn46UZ5
 PuRB7lXK6Y1+i6QCUVLIM9VZIs9MqfRmugonP05Gbl2jqT7bmOOaRqH9c4Y8q82/Swk17PXT+0B
 RJKqMxCoM4Qdlb55NPUA+GAZr5V+wHBPIQ7fx4aq2ULQT0D/gDkx2DExUNaHUiescZFIyQ1Fb72
 JIjGy1BvPoFmc1DsoGWLYlkcJMVjtrG0RvQAw8MtWHvHweRBBgKqksIzCMyxaOuVU3ugIXv9KO+
 X1HdXnWO+rCkEgfMi6VaJJp+Ih7Bop/jgFzUiqfXvSPZYToK7OQ=
X-Received: by 2002:a05:600c:5754:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-49987951a06mr45604025e9.7.1786707423722; 
 Fri, 14 Aug 2026 04:37:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1d9bsm7523001f8f.24.2026.08.14.04.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:37:03 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 11:37:01 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I08281cb511dacb2a69ff4a9607c5daf09157337b
X-Gerrit-Change-Number: 1757
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1757?usp=email>
X-Gerrit-Commit: f966e962a3ca3fa07dcde8f4b0a04d83de5f6698
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 11:37:01 +0000
In-Reply-To: <gerrit.1782744874000.I08281cb511dacb2a69ff4a9607c5daf09157337b@gerrit.openvpn.net>
References: <gerrit.1782744874000.I08281cb511dacb2a69ff4a9607c5daf09157337b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQ0ODc0MDAwLkkwODI4MWNiNTExZGFjYjJhNjlmZjRhOTYwN2M1ZGFmMDkxNTczMzdiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6118ee20ea7d67aabf6140aa052aa1cfdd2a7d2b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuqDm-00041u-CW
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix compiling with
 mbed TLS 3 and cmake
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
Content-Type: multipart/mixed; boundary="===============3425836721765410350=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3425836721765410350==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sAVzat14gCs="; charset=UTF-8

--sAVzat14gCs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1757?usp=3Demail )

Change subject: Fix compiling with mbed TLS 3=
 and cmake
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1757?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I08281cb511dacb2a69ff4a9607c5daf09157337b
Gerrit-Change-Number: 1757=

Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 14 Aug 2026 11:37:01 =
+0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--sAVzat14gCs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1757?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1757?usp=3Demail">change 1757</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1757?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I08281cb511dacb2a6=
9ff4a9607c5daf09157337b </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1757 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Fri, 14 Aug 2026 11:37:01 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--sAVzat14gCs=--


--===============3425836721765410350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3425836721765410350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3425836721765410350==--

