Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04092C44507
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hRFbkKsw1EuadO9fCstT41Rw54ys5hZAne50dAaYS+Y=; b=Agh5nND8DPdVzSJUpNpC1RGcTV
	jt8kGWyyd+1qTpBPNgFhmvhJkNh9NVedKrdCP01d7v4Xb0W4inyvbbGCWA9Q5pJiPlgrfKvGEyyyd
	i5c5fmAIcjNSw4rhj5MoYWEv+h9XobZKs5x7QRGjDZ07OSppnguNTqzZgxZt8ZhEP2+g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkeqL-0003UQ-Sy;
	Fri, 17 Jul 2026 09:26:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkeqK-0003U9-3L
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 09:26:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iQc4UwXGv8XOYO38BtAp6us5rCtGBsk5PBrKqf8r60s=; b=W/JAeBPma3viQFv88QGEwiGl6Q
 W6iirYud76rYTDBZaE/L7Kdlo47bWZxKIqGx0vAXexhSeyop1ORgPCXF98ikN6RNcCsBJIKpWjjZQ
 SKVTVuzPHWLAruyR+k+Nz9cKKkI/yE2XVQAy10BjFhtUSS5Xj6X7aYgmoC3W61tySb6k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iQc4UwXGv8XOYO38BtAp6us5rCtGBsk5PBrKqf8r60s=; b=M
 WSo7+KAQ8ORgoYg1Om796Ix3yXMUj7sGIM17Ea9hoffeXKboyhzGYhdXtWY3oukTg1A6UbEnH9lTa
 GCwkbBDqgXQPMO9z96h8dBFE3ZElCdA75PwuUuIGBhgYG7F3/vNj1wx3IYmX8++a1Zs1B7AWTUss8
 +Qm/uz3Oz7JRjdgM=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkeqJ-0008MT-Th for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 09:26:52 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4758bd3731bso1196263f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 02:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784280400; x=1784885200; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iQc4UwXGv8XOYO38BtAp6us5rCtGBsk5PBrKqf8r60s=;
 b=Kk8/qhUWzmNwRVe68SpRzzhuPrbsRdU8EMQqabLJfNIFAPFw+PWrbxaf1VmVxjyOjA
 N9V1XR4CTMlDLK1gCJwmU9B0cWbWE9VZIl2mFj0NvC38IjBSrF5BAfoOkIDRPb8ah4pF
 2pCuPoI4wYz9LwzwdQfSS+dTVtsB2Grdb0p0WWrcfFgBxj9lXen/KKZeFB5Y4zn/E/M8
 nJdNQdSQQu3yMEsF+6ayIyZlr8r5CI5aEdJrEgzZVtzt2cIFIBeK5NvPsojrOeCfwzZ9
 0smlxUvfB+K+pUNxexxSbzLk2etsz0Ro0rCs+3m8UZvGrSXE2ViFplVcvmncKr3/XrJF
 9r7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784280400; x=1784885200;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iQc4UwXGv8XOYO38BtAp6us5rCtGBsk5PBrKqf8r60s=;
 b=N0Qo5/5pn9oNrFme0cm2omLIPmV3yABMU3jGGP20JKKCpmNm0+NVKCd8U+PM2C+ieU
 JPR27lPEoQHnqWqgdcyrA4MJXRBWvhwvCQtvWHENK4j//NLS5xgJprESxUyYjJ3c+q96
 w3w5OFOkFek8srJfI+LG/X+4F8SB1v6eoOpj3v/mWGpnsw8j5DI9WqKeuXvXjt49BJ5n
 vsMKuT65VZPzN/ODKJZBsuZDpgmM/Cnqb0/jt/NKq0jCQWGNMxGYTwWUJVVZFWiLk5eo
 rJQTNJ6NUG4vB8eUPZ5/YXOgw+mbrHvTBRArLkwBDWby9p3ZhTNrOzfGOSFwHwrHVKnR
 ovBw==
X-Gm-Message-State: AOJu0YzUntzdEwcVxKVpTUiSvmXn4MzNqWCjh1eN9VFiq6ye+BsDILRU
 FTHmb7LdHW9DDTsPt+FkIW5EVHW8PWUkdiU8Ig2kVG4jgGq3bZG6FW9ysOjA3UKNXN4wlWwhTmK
 U6BEbHfREiGKyV6VK9M77Yq5H1hWgXmLxst7b4IAlN7f4cOyIF/nd88pgo+KUihSupUNsf4VHSB
 ER6BMxag==
X-Gm-Gg: AfdE7ck0DlaW0/louskFQ2peih0vXQl+pzbyyUqPPGCJ91qsVTpA6jMjbz7mpUTRixQ
 wU90us2D2VvBsA+ezXOEIsnoB0sw9AVFNgD76Nri31Y2YqDCoF0EaH/aIm319AOMGzLAz1bGQ5v
 8SOn51JqL+8QXW8DSlzlsiWrRlUp4qfuY5Q2QdiiAgvQUl65t0vyKBiE8qJLzgjXpBC0yVMniCT
 VdpskoF2iWONwfn/fju4H7OWxFg3qLeKhOuwBCMPDtdnXB8QuY6PUPOfVojVMxa9tvlTE4alTbb
 z3TT2eF8P1j0g7yeAmYQ70s1LlUV165Hq2rULsssmtOpYxs4CPAjszxnNbsvu1h8ofpQKbRLPfe
 mOSzO12K1qErCrIAf4lGFLACmr3szjDsr6HQOjk2Ma8sMgCaTH2pGuWEvDVKVQCKlAX+ESf/Wb+
 SnyG6Y/U/6hPHOwGdla7IhJjuXub1ABFPunGsHDnQijHEoaZUh9R3VLs5jPMXE+QXa9/ORZ//V3
 L3LXuJzCmDWF4J0kMiaPUk9tDiCamr8B5+yeGjGszVx9nEN1sdyTKF+T3Jw+Rw9fcfrRCxVKUJO
 7Qo=
X-Received: by 2002:a05:6000:22c9:b0:47d:f508:3364 with SMTP id
 ffacd0b85a97d-47f5a5486cemr8276883f8f.15.1784280400080; 
 Fri, 17 Jul 2026 02:26:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec66ebsm2268055f8f.21.2026.07.17.02.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 02:26:39 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 09:26:37 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I9f10d91407347faf32397535c95e2d80a1575bd5
X-Gerrit-Change-Number: 1722
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1722?usp=email>
X-Gerrit-Commit: d14f3df670f07842af4166c078326e8345d2b1ff
X-Gerrit-Comment-Date: Fri, 17 Jul 2026 09:26:37 +0000
In-Reply-To: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
References: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk5ZjEwZDkxNDA3MzQ3ZmFmMzIzOTc1MzVjOTVlMmQ4MGExNTc1YmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6cb7f6c07458d9fd8527e493a866a8f9adc21130-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkeqJ-0008MT-Th
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0108123065446320962=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0108123065446320962==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nXGoJdPwseM="; charset=UTF-8

--nXGoJdPwseM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1722?usp=3Demail )

Change subject: Move incoming data processing=
 in its own method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 4: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1722?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I9f10d91407347faf32397535c95e2d80a1575bd5
Gerrit-Change-Num=
ber: 1722
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 17 Jul 2026=
 09:26:37 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--nXGoJdPwseM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 4:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1722?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail">change 1722</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9f10d91407347faf3=
2397535c95e2d80a1575bd5 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1722 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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
Fri, 17 Jul 2026 09:26:37 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--nXGoJdPwseM=--


--===============0108123065446320962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0108123065446320962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0108123065446320962==--

