Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2547606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZHRDZVNH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XdjNp9Db;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gH+UGswL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OScw+LbF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M/GZ7g7H26f21i8rTEcFurz1e8CeaqMEb6CZJFXeCUk=; b=ZHRDZVNH9cDS4trOzXJ9XCStPU
	pNsFpitRhBpANDuo9JlSRtJqDGNsuus0IVCDBpONzlV0tzM6ndL/CKagiY6cuD/9m0ZeoOHctweBm
	4FxnaPEC7j8R9f/vyfL02rcMfj241oLnalTnXKRcRnKndkmaMhA9OOX6brV0/uxSMF/o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTMlF-000000002Uk-2HHy;
	Tue, 17 Nov 2026 17:14:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTMlE-000000002Ud-2tKF
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:14:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JCaSinJfuBX48XXjIWaUoBnIYVVhVRkrhLlXSQA8yTE=; b=XdjNp9DbG0qB1EB8YSzWHaeXho
 rOzXo8FaFZ87dgBgYzxSDzwlQ6sZ5lhcVuzuj/eDIwhheyh7PTcsVEBRjV/oUoiYUFokAborwrPAr
 +XKMCSCbbyDDaWM81TjoVFjNU3N7u9bqAxl6coVjZNuPK/eYa21XKQrHo8Pz+LzF4GyQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JCaSinJfuBX48XXjIWaUoBnIYVVhVRkrhLlXSQA8yTE=; b=gH+UGswLtW8a5Wz71Xb/HczgRx
 TVfYnj6a408DG0ZqPY1ZxBDM4de+SimxzOCV/1+q1MXXhiUbmgU8tqbV+d042MOsDNyB7G0UD6VLS
 85XvbSz5JOv9jRA5Du/vaWYelRzd44d5Y5qHY/TrPMuKEt10bFL6EV2vPGAKGu5P1orw=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTMlC-00000000484-1m5J for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:14:24 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so1094035e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 09:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794935656; x=1795540456; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JCaSinJfuBX48XXjIWaUoBnIYVVhVRkrhLlXSQA8yTE=;
 b=OScw+LbFjQ1l+FqkzKjgmT4Mr2BscJTOugOcHV4BhTJHW04ttkBofjH2bsWbCFHshW
 7U8y6RPw7r+BlbtIVhKOUgt9JIfTB5n4TdNED6RMftABmBY6cieLMknncZow0an0Dei3
 I3Fad8lziyg1S8re2IqQvVMrSCPKQp+7RAGmIOIKhgCu/c9TQPq7wjDVgWSuzAiKGgAp
 BTVuY6xGUF1O3YZ8y2MQ1fiTIFjGB8JrzXPmqYlye8L0BYPBMD45U8Qd5sDUdz85V1H3
 vVEndK1p0f3OP27BkrjPwonincS2h4MC8eqBnxDH97o5K0WpxQ9VnD4UCof5JEy42yJK
 Wtjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794935656; x=1795540456;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JCaSinJfuBX48XXjIWaUoBnIYVVhVRkrhLlXSQA8yTE=;
 b=lQxFcpCF/nMCo07fcgmCS5ZX2ZdvMmgYFckN/L8UhW9XatzPeeUMRQfddvmJqJlz9/
 TTsltkkHkCWsxGArLuXUCnMi5jolvK5uLgCttKcVz71fBKIqZ65sg7oi76rG+EuIANBF
 UQBzp4G2ih1BpEN35mkTkBMI7RSnpK0rwSFiiHokspSZ8rogC9A60wIMRQ2oIfSYTc+2
 hz/dqF7zjJ11fwQ9mWe/f+xYik2o1O6cxciNlE/gwQDYPUkbzYKa33iBB0lobs5eMQ6m
 tWeOeLIWr7anA76O/ZOdyUSRbCKVCQuXKN4NCFqjQpkf12mRt3pAlztuJ7hZwXLJPRq+
 yWcw==
X-Forwarded-Encrypted: i=1;
 AL+hErHY35gUXA/5aK2FWPDYX8zaK1cF++ch0LRRtWHef+UU0IAh8SoNWKk1fE2ENh0YGbksN213jY6TCpAT91Mk@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+yR9MEczhxQYNEyhsYNW+G3YczBRDRNBs0oi7SmECgT2VeleUc
 gr594rALfd9VZcTkeUxLTyhWl3YGy+F7NhPjvA6bd1CuHuqzUE7Ohyg3EkhTckrI2Z0+4J0igVu
 goBpjeZEti4qbTLJQ+NFaEj/zq/kUqNuwHWAaJMqHn3Bv07ke0zYkJfPuuADMwOU7VAFl0RseuP
 0BUuN/ow==
X-Gm-Gg: AYBFou0F2CQlbK0GgaSPy0AXOK7dTZ8PYvKY5UKiaKRooc9kMgsouTm5CCMGL5trJoW
 CYsvDczmooLdO2ZvAY+sjErY/X+WJdz75nvNHQYktt0n22F8Jymf/zyOLnV7vjL7Rhc5WsIYx3V
 qG5dpvsL5BGU6zQo6mhal7FdbKDHBcHcuqyHVjGKsoy04ZH5l6zYbwAx/KAt/0emqoFRk4KnH+o
 +2wPeYkYs3+OPzAq7SYsbz4wSAhjWG7PqFYGIR3513Q9rxkKcXWu2kuv4L8iNH9qWc+sM9ejlKk
 Yhk9SFYkAH2EZX9BXGiuPQ77pBghRd/YcnIoZT8QjFyhEm66lNyWpy768VbYmV6krf3IskNoq4D
 QAR0JixqG6KQhQJdsFmas6B+nnhimUYWW2bNJERx6S8x2G/b2ZYCntUGjuyaZfofKBm8n6oCzac
 DLDCtJJuXtZiZqCNQhHpTf+p4uxV2mVsdEmLtl1BVyVT20fw/DC4M9uZ9KrW1tR2Pv3Cex6LKh2
 tALAEoFHMf43a84xitgzpmygK6G7+2KUXXB4MDRxnEFs2aHw6u47+/9SxoNWvDJX8JGwreilmhf
 pGzPZPb2ITHLTdrWGCar/lhzs+UtCIXMHclth83OjAmJnVNEG+24AqjKHr1RzGANsjYho4tHoMS
 13iS3Xb+gdAmUhYXk/w2woeayv73hr6tSr2ADmPGy9IhnATGmU+d7TUtb8EPqr1hUtjtlz0u5aH
 yn66s+vA0MEowUIa8=
X-Received: by 2002:a05:600c:3112:b0:4a2:150f:1607 with SMTP id
 5b1f17b1804b1-4bb55a4ebfbmr328124365e9.13.1794935655548; 
 Tue, 17 Nov 2026 09:14:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571f976esm206829255e9.3.2026.11.17.09.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:14:15 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 17:14:14 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I33123fe621512376410765031fc9ae68cdd91a6c
X-Gerrit-Change-Number: 2214
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2214?usp=email>
X-Gerrit-Commit: 3990c07cdf21e87fd14872c86d1633ee38f86ed8
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 17:14:14 +0000
In-Reply-To: <gerrit.1794934992000.I33123fe621512376410765031fc9ae68cdd91a6c@gerrit.openvpn.net>
References: <gerrit.1794934992000.I33123fe621512376410765031fc9ae68cdd91a6c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTM0OTkyMDAwLkkzMzEyM2ZlNjIxNTEyMzc2NDEwNzY1MDMxZmM5YWU2OGNkZDkxYTZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <670874cd982616639f7f739c7a8c8b9c49a5e472-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xTMlC-00000000484-1m5J
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_openssl: fix
 -Wsign-conversion in tls_ctx_set_tls_groups()
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
Content-Type: multipart/mixed; boundary="===============0508740860937444152=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0508740860937444152==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="q3rAedDIllc="; charset=UTF-8

--q3rAedDIllc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2214?usp=3Demail )

Cha=
nge subject: ssl_openssl: fix -Wsign-conversion in tls_ctx_set_tls_groups()=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 2:

(1 comment)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2214/comment/57a42533_6ecddb5a?usp=3Demail :
PS1, Line 9: Since 7d46ff17=
 dropped the -Wsign-conversion pragma, LibreSSL and
> Please add a comment =
why the buildbot LibreSSL builds did not fail=2E
Done



-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2214?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I33123fe621512376410765031fc9ae68cdd91=
a6c
Gerrit-Change-Number: 2214
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 17 Nov=
 2026 17:14:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-=
In-Reply-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--q3rAedDIllc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2214?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2214/comment/57a42533_6ecddb5a?usp=3Demail">Patch Set #1=
, Line 9:</a> <code style=3D"font-family:monospace,monospace">Since 7d46ff1=
7 dropped the -Wsign-conversion pragma, LibreSSL and</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
Please add a comment why the buildbot LibreSSL builds did not fail=2E</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2214?usp=3Demail">change 2214</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2214?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I33123fe6215=
12376410765031fc9ae68cdd91a6c </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2214 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </=
div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Tue, 17 Nov 2026 17:14:14 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--q3rAedDIllc=--


--===============0508740860937444152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0508740860937444152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0508740860937444152==--

