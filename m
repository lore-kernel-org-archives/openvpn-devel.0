Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A4FC2A09B
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=95fT2NcZ/qAbM59ZSlcMmbtlR2DVdquFacttJraRxDI=; b=lU45miGZvqH3gKKqXgwZpkQUAm
	bphdG3WxdYJVieyhtK1ac7ZcS7XkNm6KTWfZ4rR3dXpyKGPsw9FlYzCxIsqK+U7cIsfTVzYYmLjEj
	SmBDSHDc+O6s5B/3JVCEWEnG2T8/IsZDAWvqfFGU2Yusac56kBjGXrN2tOpOavvN9ZtY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsMAG-0005uz-Ck;
	Fri, 07 Aug 2026 15:07:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsMA1-0005tp-Ee
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:07:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=06mAbowOAn7XRPYdJ923IM0uPdBJlpYpLXFQSW30Yls=; b=WTDScvYIjdc4eCtOFaqzDPihZK
 k73CL3VM9wvQozs50bv3cFfhdSELmCutuXE5X1JAZ8NayCIolmIoOVXcm4hpVvR3xLWEXcKGSRtjn
 vl7QqDKYerqKWJyhriV1RAY9CZS0C4EWzforF+obuxRTli+czCus1Q5eMDjwKUmiSMFM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=06mAbowOAn7XRPYdJ923IM0uPdBJlpYpLXFQSW30Yls=; b=X
 PoLw6nf+0fLWn/48zpKeGrWJHpdnW5A6k2x8fwmT0TjuDznG30l4/0MJRiwtnbMVsir3eGHS9H3r3
 wQGL93aKcIq0lO85ISCF7e2MvC8OBn8b9k7+4YU0vqtLaSuPvlwzKlDUVMruAoGk90kM3+B81B+O3
 rvWpL6LxmSR+dp94=;
Received: from mail-lj1-f173.google.com ([209.85.208.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsMA2-00012R-W7 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:07:02 +0000
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-39c86945164so30444981fa.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 08:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786115209; x=1786720009; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=06mAbowOAn7XRPYdJ923IM0uPdBJlpYpLXFQSW30Yls=;
 b=JDJWetIv+O3PaTMYzl9SVECkooXzjSasjDtJyPnuS298sW4I9c9ut/cu8jN0tG4Sz2
 sucBEe/X7+1YWs1XN88bh1p4wgKMpuT4gDk7lJmKtiXJ/nsD5H1lIMZjukL4EPF0Fq0P
 DbCV+PBGco5SPs7LT2Q7X/WpJs7z9RQQjZTNtaJGYCzU1Q+Cu3wGGXS9iA1i91c6mqo/
 A6vqU+gzslIec/hYQ3nrb77Klu3z7Ru9HR6octdo03Clf8le5IiclYC/Cq0mDlBvsqP0
 VafYg7H7gG6ZY9CyVqAs9LYcLrqdChyFRgCteoqxmkJ+bx4Hw0UjBBxTUSzR3V6cmPD4
 +f3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786115209; x=1786720009;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=06mAbowOAn7XRPYdJ923IM0uPdBJlpYpLXFQSW30Yls=;
 b=PDQCsI4ge7us18BaipJzh3c/xq+VJ3oaiRkT1PWNV1HEXl2qV4OXCvrlmgockeZtyr
 TfrzquFeg/erhl5wrTA2EnPR/Uc9+pFbN/+hj2HEAlpbS+rRFY9F2mSBQUX15vKUKmAR
 bCgTqXf8b171ww9V1HuLppXSj3peC6yRUzk6ztl5h6UUPZxgnByiDUcnlUDGixonjb6a
 eFZ6TrUipOvga6vmAc1cIc1Y7YwZrMTjNHvAlYJCsLiFviK3RrlPMr9p6Ln8f6Ro88ND
 3sqSef/O6jxKCnJX7O+jnu70fzVUCj0kpeRq0cR4uJ55Vucc7SsveuAUnbHw0fa+VmTF
 3zxQ==
X-Gm-Message-State: AOJu0Yz570Rdi3VbP5IOB+qF+vBjdbAfXEamdaaufoqs1XfWQAcQZNkL
 ox3XrA3t/p0kvezB4qWeMbikLKTXzZGfsqKFPa/jlYWwFeTaUZW+jUkU1WxQ3ZL0G3xQ8sD1Ion
 lEgdvfwCpMMtBLFqk4RGLJ8LmEOa2E//wKUbjm6m4GwXjNh59OnpXXU5DSZwgo8lvnjNHWSLff7
 1FCtjM+g==
X-Gm-Gg: AR+sD13IpDAprT9V2gHBy9GJ+gkvqmVm8SmJk45N8OZLirVP8dZ9651C4zO+/1T2zsb
 dihqQYWSvmeNa5HajcNSgPg1d7biSaSvKGgd77cgGEQU7+I7UYg7x2U9Xss2H5qGwBfdvwharB5
 m1t7gPUqy62/dKwidoWMfm5DP9GCDLg4uupeIFV/pOnByXcyTKnM/dxSl3IRBE//Aofy+eVs1b+
 qtMRAAfL54MyJBLAH8dyiYj0l6AHetTUwuGD0Vtfue5Gyi8pDes/Dska/QZv7D1ND4cqIYv4eil
 nVPUVoBSUNhbQQiMMsjAiiA/06glZrg+wPEkGiy03Hnuix+CwO2JD8ZwT41xk/zYbinc8zr7pGY
 ySRsO+8FWvRcr9pzQ3xsNJg0YWSiT/n000c5H8rkZM9o2byvf2FstfRqWXk97MxOWt7rWr+XLHk
 xSQY4WJB3fUJ5kahEr0zz/mJksbp1qG2IiiHRzTSEIGGT5rkAwD+YQK5Gnhz71ONFPhb6m4FWMZ
 nfFjb0ICGIwdvymfo5KZfmGPWB6318NQxeB08MjNgPsPVpkzFmRzhjtG9gAKKvg+3JENK8K9MZC
 ptYlMDLybqTqRYD7LBq7bLpBs251LdcdSJuHRxIUpeSErwqmk7Y=
X-Received: by 2002:a05:600c:4e12:b0:499:61bb:6c78 with SMTP id
 5b1f17b1804b1-49961bb71abmr3270445e9.14.1786114774031; 
 Fri, 07 Aug 2026 07:59:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995e9eb1a0sm50187085e9.5.2026.08.07.07.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 07:59:33 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 7 Aug 2026 14:59:30 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
X-Gerrit-Change-Number: 1728
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1728?usp=email>
X-Gerrit-Commit: 7f4541b3b554f681d3e102c57d9c50f9ebc51199
X-Gerrit-Comment-Date: Fri, 7 Aug 2026 14:59:30 +0000
In-Reply-To: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
References: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTQyMjY4MDAwLklhZjFmMzQ3NWU0ZjI3YTkyMGMwMjhjZDczYjFhMjQ5Nzk1MzU4M2QwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b51de4dc46f75e9be66aba52b3eb381de249fcfa-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsMA2-00012R-W7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Do not differentiate
 TLS server and client context initialisation
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
Content-Type: multipart/mixed; boundary="===============8241363901901181838=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8241363901901181838==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lk89ujTt1Mg="; charset=UTF-8

--lk89ujTt1Mg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1728?usp=3Demail )

Change subject: Do not differentiate TLS serv=
er and client context initialisation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 6: Code-Review+2


-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0=

Gerrit-Change-Number: 1728
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Dat=
e: Fri, 07 Aug 2026 14:59:30 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: Yes

--lk89ujTt1Mg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 6:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1728?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3Demail">change 1728</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaf1f3475e4f27a920=
c028cd73b1a2497953583d0 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1728 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
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
Fri, 07 Aug 2026 14:59:30 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--lk89ujTt1Mg=--


--===============8241363901901181838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8241363901901181838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8241363901901181838==--

