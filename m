Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9A9CA6007
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3U37zsFClc//Z9ZUKek1EN7Mp1jA4Q/H1YmKxUgoSNo=; b=l184jGP3Op1FGhKS3/i/b8fUvb
	08A0r7HCDIIFQEMaZElYTctaP4NEcLpB6zCzyY12Arf+ds2KWUfNUZvxCq3rToebtTnj1VSEbQymU
	Izm3ybLaYIHQ7GImqM8P7fFY9ujj0IJf6lrA706+MSSpztJ9vgnwcJ5sn7ctCQO7jibQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEpcE-00058Z-Ly;
	Thu, 08 Oct 2026 15:01:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEpcD-00058B-8f
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 15:01:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=S9SEqAdsDu/l+MxrAHRDljJ0642FWRNDcoW6yZV0zVM=; b=MuY90w8SD7YF3qcsZvHKmoxdYJ
 TJCQFvVAZ2RPGDVuphC7Nd31PY3mGzDrP0BFKcjAat9zYCqEtY1Iod0tAKRjFQeDNjI7+9SKT2riB
 VvgNZKkz2k8AlmT14i9e5hA+FzbNT82ELH1v6b0RCGyDzHRqCmJh68q2Kbh/XIKvVkus=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=S9SEqAdsDu/l+MxrAHRDljJ0642FWRNDcoW6yZV0zVM=; b=G
 uQZRjS/FKM4+CQ8to+0rQgxUQOfjXtXrctlPTdOUW+gvW8K7WjLutV2yn2vPlBEnO9ONR6OIqOxIB
 i8OehOyf2yiDU9wzpXvPFHUlMAR6XqKO1pkxlor9T4YRe7AdRa5S209v3FyHojN0ZYcrEITBY/FKI
 p66XzlzhUnmRILyE=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEpcB-00056n-Rf for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 15:01:01 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso9870425e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791471653; x=1792076453; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=S9SEqAdsDu/l+MxrAHRDljJ0642FWRNDcoW6yZV0zVM=;
 b=czwJrkuGjnOk0NG+54Sj38da/1p7chraVqEjRj16fWd1YvKWBkvrnYyPUeVjE5Jf6X
 VsEUoyannn7VYlEXJitlpDss8EiHnDyEnwInESZjqpHlE2HfdRSAt1U3dOlOvIeoGf2y
 7hbdIA9jZzODC649HtTTfmxFSKgIjfG2q05X6BUtxBF+7+rZHYfGwhAA9f6Y9v4TCQr/
 JDVnzGnDZLQqOP+fcJcZUJ5dm6gKKMb5nJKR0Z8MSLX5Ho1EG5F+PvzX/ulBt3R1qMlF
 qQJTcs5zmjlx0zgds9f5TS6w4hBe+0e7oYrDqGreMsdzuREjyJmuIV+1eBnBejbiq6fK
 aufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791471653; x=1792076453;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=S9SEqAdsDu/l+MxrAHRDljJ0642FWRNDcoW6yZV0zVM=;
 b=sUj+ZxTBZItOMwbEhf68GbVzz9IdG0z0jNfPpfYKQt2/y2wU0QayWXUrSikIjtUJGP
 BAXsdk6y5DPXBT1frB3j1vOxi7Rf1rDhgW5W8lHBiYR2X5+SlM07f9LAJu/j00Lje3td
 uZtj1T8riG+ytUlrjNH0DR4WTZKEZ56uzrGcF3zhSWkmgIV0NJ6nA3FQ+vz34josY0S2
 VpqTDzDNBjeqXNTrrKn3FxsGt4xRJF3h1+V7/yKu0/v8vFscSUJsv0v+4Fg8hajyBDrW
 AiHvevdp5E0c7Aonv0YFjpkAC/xnD2OoTwI3ZWQ/mIu/EAS7j0kWjXSAD5bxuiAQXof3
 J9cA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBPpJvn7WuMH2KZGkTOVWPC9A7TSK2twfPdwTFPJcb+2HhG2vDeEiP1MGzyL6FbkxxeOsx9OEKATYGPIG3@lists.sourceforge.net
X-Gm-Message-State: AFuF++kTKTDevxbL/UDvXj5ei4eHFE3BBLUme/YcFU3gGPP97KHLXeCd
 gjRJyYi10d8aXQEkUHVBY/AHmS97OiKklvsysglD9yRlSulCuXP/5XtRmWHEcfYIJOn6TTLchkM
 jcJyDDBUJZcCH4j2zBLtKRizIxMdr/9fKpj5cJwQVUrRIH5Mv9/nxx2OS9aMvF4Pllyc+
X-Gm-Gg: AYBFou0fHturh2WES8oPCtbhiTLvVqpMg2x/5JygQ4y/9Un//8HFW+Hwh/MAXA9U9Y/
 CAlxOTswuxJ74RqAjDCfhoUO1Q3cIu7Uqy5fG4+oX8mIDaGJHGBmJoCnAMKL44YJw4WPT66ic90
 VbK7XyzXz8KkKj7zrRbIycxNMk1bPs7xEGdLrxD0hcCN48oT8ztEbjZ1zAjB3811ua8PiMhf/+0
 x37+JjFLHHSVYA/+9BtTfW8jRX1pPgpBXO9OhDIIyIBgQQbRNOwi20Vk3XGyTJ1ObBgRCGFu1vt
 3I23FU3zkxTSJ8OEE7CWfWyjEL4CP4Ps9KGxiDGValGbrDqNQAvx78MeAqMyotD26hHA/cc1AUT
 fhvoba3nN3I8va45gzCMkLX2ve8/h7/HSVrc6eP0WHRRu8rawMAQLCWO0R9oyRLk3uOLwPeu60I
 R9yL8opUUcqXKNn6hveOjQj2nwSi9sgHNb1JnbCBJuKXMEpK2VIZy7pelj6WR0iXwunHVcSBvF3
 nHSywrOYaF/n0Tr89466weRy8vH5ze+M29Svjm8RJ1g2LbnazisuHfiJAKq7I4lrtg5liAu/SV4
 WvRUNQh/OZusg8GsBuMdxgL5gocwlPHUjiksCVpe2GnkusLVFXy7ciVz
X-Received: by 2002:a05:600c:a307:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4a188df8b83mr15279645e9.13.1791471652885; 
 Thu, 08 Oct 2026 08:00:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f48ab77sm155438245e9.1.2026.10.08.08.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 08:00:52 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 8 Oct 2026 15:00:50 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd
X-Gerrit-Change-Number: 1987
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1987?usp=email>
X-Gerrit-Commit: f4ece820dcfb9a84c3ba309abf687f1990e98f59
X-Gerrit-Comment-Date: Thu, 8 Oct 2026 15:00:50 +0000
In-Reply-To: <gerrit.1791470166000.I47e0741c75832a8f3fe161769feb27ddbfba3cdd@gerrit.openvpn.net>
References: <gerrit.1791470166000.I47e0741c75832a8f3fe161769feb27ddbfba3cdd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNDcwMTY2MDAwLkk0N2UwNzQxYzc1ODMyYThmM2ZlMTYxNzY5ZmViMjdkZGJmYmEzY2RkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c904740437ec0ab944cd7a6ea1ded25fefedc7af-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEpcB-00056n-Rf
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Clean up
 rm_trailing_chars
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3333243396263762229=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3333243396263762229==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wjOUGAGvuMw="; charset=UTF-8

--wjOUGAGvuMw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail )

Change=
 subject: buffer: Clean up rm_trailing_chars
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1:=
 
Actually on a second look, `chomp()` appears to be the only caller of `rm=
_trailing_chars()`=2E

Is in this case `rm_trailing_chars()` worth keeping =
at all?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
87?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I47e0741c=
75832a8f3fe161769feb27ddbfba3cdd
Gerrit-Change-Number: 1987
Gerrit-PatchSet=
: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Review=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Comment-Date: Thu, 08 Oct 2026 15:00:50 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: No

--wjOUGAGvuMw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1987?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Actuall=
y on a second look, `chomp()` appears to be the only caller of `rm_trailing=
_chars()`=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Is in this case `rm_trailing_chars()` worth keeping at all=
?</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1987?usp=3Demail">change 1987</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I47e0741c75832a8f3fe161769f=
eb27ddbfba3cdd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 19=
87 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 08 Oct 202=
6 15:00:50 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Ye=
s </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body>=
</html>
--wjOUGAGvuMw=--


--===============3333243396263762229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3333243396263762229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3333243396263762229==--

