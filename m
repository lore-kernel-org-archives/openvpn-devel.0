Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AB7C982EA
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VC+HisQuZKt8IeuXUHwpBpgIqwPEd6PmtRYvsyItBr8=; b=KErAtWkXjm4Y/hQ5hzaiVeMMZt
	mB2i1+tODVbsaZn8rKZAlTVcrqGp1kJnAGLs55wurrfYXjr+ISwfD/96ehKlF4R4RaaQRPp+AQdHK
	6swZAi1Wus+xZb04fVby4FK709izgh6EpbIuLy7BIqPqVgMb7jwZXyzxQnSfXSXoa7Jk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9JKW-0001gI-Ft;
	Wed, 23 Sep 2026 09:31:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9JKU-0001g9-FK
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 09:31:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=huMS421+KLnqjx2qJNtLrDj53mA8OkWux2BTfr0Qlgk=; b=WgqQEKQnPVZK1y6f6JmfiZCPlD
 xL01/NW4Oa8MxY28LJQ/78uLQCMjyrm8HNTnzbkUQvEeoyOH7957GmEk/wdMlj2drc7Ki15xy79my
 vQ1k+CDWSPLgt6KFxaOvQs6IDB5OK06Ro1PVkeMs0robIbEa/Qv/ilkePVC53vjvkLnM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=huMS421+KLnqjx2qJNtLrDj53mA8OkWux2BTfr0Qlgk=; b=g
 oAesGRLit+IkisxdDw42g8PnWcIwoXnNPmvR41xZ4jXKkC0XwefQ5nfEuayFuMUsbZJ4/4e2rjHDc
 XF7lW0Foarm762IM9Lwo1/95ABQJDb4e6pQnHkKsStSMKeAHyKlTxJnO7iCzvmhJTHcC/LKPr4xXI
 UNNMN1FPcIm6YYtg=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9JKT-0002t9-Hd for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 09:31:55 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6350f89so541495f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790155907; x=1790760707; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=huMS421+KLnqjx2qJNtLrDj53mA8OkWux2BTfr0Qlgk=;
 b=IujdJbkGi+r3D2Q/N7W7Yf/HSoWjrv+4JCitrECRe/uiY4vhW+sJo+4ROEpymEfgal
 Tn2lmqQSmueNoxtTjnFkVY3PQPq0MkwdP+cseK7J1xfXDzYueCgB8MCRdRbt/R1IvCFU
 JWApdqIZvm7IDst9+LpHtb0XSzlXgUWubXgd+El6qcB63Nq7/zFZcgT4cG1iwxBhDwLf
 MhsGiBwFiw8hdeHmDFV1FR/n47qyJltQyNI05uxlV5lhYxhUH1YYZKH+C4wsCmbqir0r
 qtEuIjEiyQ3fS2sfYAScsrwtOkK7CxIT8xSGHCPHaojZQpG29Z8KeSLMea667NDfrWQJ
 wkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790155907; x=1790760707;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=huMS421+KLnqjx2qJNtLrDj53mA8OkWux2BTfr0Qlgk=;
 b=PfSEMN+hPK++Qm2gs9/TPsElvL3/dhdEy6Sys51HaMQseNh7lo0hD74Z9kDMGGs5Ut
 ncXOV6TzmAL4rb19uhv605nehT/PCITl3ndbOlVD0Tx+bbGDPz7duDoROxztu6hfYMp8
 v+AQ1g72UK4BJiMtm3SZjvet3qqGZrAWJWmRQ6iPGEhJMfGQa42J2iQxM0Cw7kEKuEIQ
 Ez9k1RLdbqN2RtWkohBfzoywXOOaZzPW/39xjnLk46EixAeI7FQ58kBVjK504FS93CSh
 Mfw0iO4gpIQObt/XuhO8el8XxWJmh7ZYPLeMKgGDUN0FLonT9CVQkijFvyY5n+W6ThQ9
 VBBQ==
X-Gm-Message-State: AFuF++nuo9/f7DtbvqAXaep7jHkxDNr0Uuj+BK2mvk56skk58BZd0Dci
 EmiPwIazm1PA8uYS6mXfy8ALHFSsVgfT15sWwFqcWfV2X4eC8nvU+pdr85bnP5/qT6H/NwygV9S
 EFbUjTFqzxitIU3ZPmr5z7cCJ7p5FQGz7V5yLkk2FpFCxlDt9eJuZ9PMgY7vSyw5H0z5M
X-Gm-Gg: AYBFou2GOfr+o44KmFHSd6JltzT8i2upYLfr1gydnWGkw+id83JAHviKFa3GeKaHK0z
 iPxqcSdsgwTKAlBGdg+Qf1lKbIS2XbMqyYZNZovdsXz7ATlYBnpCTKyVj70r5AKNC28Oblh9Xvh
 ZYKGaDdjEXSTLuFYZB9fqxEvbomF5X7vL5XUNy5vnq+cL+pfqefwE46NM6uXHexYL1KUcsT5wwC
 3xxXOReaH3GKTdxYvaAdVAXqdojtZcmPWWTTdKM/4lGneYPSVgFZhZeGskTCD9NOdu/d8UgMapI
 Sg9MZ/92lrob6qD6FNa9XaO2t48PxFsxfk5PW6pS8S2Aq8atXKfHGD0J3Z/2ayhosK/LyeW0xtg
 O0cijBfBoW3ZeIMyIXoCNixGsJ19UxPscRU3t8297IVnLid7YX16SZ3zvwNAplwJtk3HFwx2NUe
 KZBq2MCIvAsm+ecFJH7UpnLwtPWscsGQl2rcRWnJHM00hc4veSsj8Yj6QrAwFhBa5EFkNWG8UkE
 pKYgThnT0zyra0k7fyZgnASvw6tABOkdqFhSqPHX7+BqbUxseu4j8RpHZgbdBHDZOUBdMXTOY/c
 fte7vCf5yOkPQmXwcLm/kHgGEju+B4RkPgpa4teV6VPzGtS+hYgqhVyDBbJjyGlpAmqMRvY=
X-Received: by 2002:a05:600c:4f4d:b0:49a:a101:4157 with SMTP id
 5b1f17b1804b1-49fdee0af52mr31882305e9.7.1790155906910; 
 Wed, 23 Sep 2026 02:31:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde197466sm58302665e9.7.2026.09.23.02.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 02:31:46 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 09:31:45 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I98f33343d35453219e43b8730cc10bcef119ea20
X-Gerrit-Change-Number: 1944
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1944?usp=email>
X-Gerrit-Commit: ab8bbcb4c70a4f775cae0c445e2a654109c9d701
X-Gerrit-Comment-Date: Wed, 23 Sep 2026 09:31:45 +0000
In-Reply-To: <gerrit.1790155491000.I98f33343d35453219e43b8730cc10bcef119ea20@gerrit.openvpn.net>
References: <gerrit.1790155491000.I98f33343d35453219e43b8730cc10bcef119ea20@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMTU1NDkxMDAwLkk5OGYzMzM0M2QzNTQ1MzIxOWU0M2I4NzMwY2MxMGJjZWYxMTllYTIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <671a9276488bdb1c735b1eca2fbdc53c3cdc90e3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9JKT-0002t9-Hd
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Inline ret
 definition in dco_linux.c
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6595921988289310485=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6595921988289310485==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tAWa27EpbvM="; charset=UTF-8

--tAWa27EpbvM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

razvanc has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1944?usp=3Demail )

Change subject: Inline ret definition in dco_linux=
=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1: Code-Review-2

(1 comment)

Patchset:

PS1: 
cppcheck doesn't unders=
tand the `NLA_PUT()` macros, which on failure `goto nla_put_failure`, which=
 is:

```
nla_put_failure:
    nlmsg_free(nl_msg);
    return ret;
```

So =
the -EMSGSIZE initial value _is_ read=2E

So this patch would add undefined=
 behavior to every path it touches=2E



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1944?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I98f33343d35453219e43b8730cc10bcef119ea20
Gerrit-Chang=
e-Number: 1944
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 23 Sep 2026 09=
:31:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--tAWa27EpbvM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>razvanc has posted comments on t=
his change by plaisthos=2E</p><p>Patch set 1:<span style=3D"border-radius: =
3px; display: inline-block; margin: 0 2px; padding: 4px;background-color: #=
ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1944?usp=3Demail">View Change</a></p><p>1 comment:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;">=
<p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1944?tab=3Dcomments&amp;usp=3Dema=
il">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">cppcheck doesn&#39;t understand the `NLA_PUT()` =
macros, which on failure `goto nla_put_failure`, which is:</p><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>```<br>nla_put_failure:<br>    nlmsg_free(nl_msg);<br>    return ret;<br>`=
``</pre><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">So the -EMSGSIZE initial value _is_ read=2E</p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">So this patch woul=
d add undefined behavior to every path it touches=2E</p></li></ul></li></ul=
><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/194=
4?usp=3Demail">change 1944</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1944?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I98f33343d35453219e43b8730cc10bcef119ea20 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1944 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Wed, 23 Sep 2026 09:31:45 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displ=
ay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--tAWa27EpbvM=--


--===============6595921988289310485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6595921988289310485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6595921988289310485==--

