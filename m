Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10637CA5FEC
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 18:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7XjxPl3reeHeqTOuEXPfgaCqsvI853g6Sh/bJfxHAzM=; b=eTtI1EwOAzKWOHEZ9c0ued+NZS
	ozsVGErVuBt7K7FA+3xHp+vj0XbJLGh0laIIYvc+aZLLnXybqYxg0pG8yMVCbvdOkjfwSF9qLL5We
	0zk4RUeLsPbvTxWZUT0KBx5MBqvwi7+9SomkwQxM49deRnLYWObjuZy9gp9bo3p0E/Fk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xD4FP-0004z7-Nu;
	Sat, 03 Oct 2026 18:14:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xD4FO-0004yv-Nu
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 18:14:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rdVCpSshYXr67Ky6dokzzIKGYDj4ifAugrUaOUW3jqU=; b=jLg15lrogTLq5NKw8GF7MmKzol
 whcA9fQ4cY8wG82MclLNFQvZ8cFL3MgHU5UfimhQFpMSHDcYwTNmC1naUlUN/rraONCSwhx+oRKsY
 2BWMhBahuocNPkguAEfIL4mv0t37eH15SknCX7a8F5lkxU77WQ8c2CkbV4IdVHemJHfI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rdVCpSshYXr67Ky6dokzzIKGYDj4ifAugrUaOUW3jqU=; b=d
 /dbM05PQCLrvb0c8ETsN/8gHoNe099MuaggVUGFggZvIBQFyWAKxXeglGKijiY1ZSNGqbYX3P262r
 51kSKKlYs2s4KllFD7fi+AhRSxmwFD0FVBUtlQsdAM9+n05Q5g/KTigz5haYc1IMInh9kakSbNakw
 oq+XrKlywSCGkYwY=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xD4FO-0003qm-Sj for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 18:14:11 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48afd5b1678so263187f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 03 Oct 2026 11:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791051244; x=1791656044; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rdVCpSshYXr67Ky6dokzzIKGYDj4ifAugrUaOUW3jqU=;
 b=FwEq2nO5VPENfTmMceNpTDZ/QXJWofGtdU29VyQ7h8U0o3QcCmeQr5AGzHR3xsW+xM
 NaON7xJOoh2buOV4LYMul4tm3RnohXNKpFwrcejyt5l46c9l0mV11d2UpLGrCVnBSThF
 rDoG/tAjwabCvpXbseDiqLX8+JBCZx6EZLMe5tQPN3YiDqa6fP4JrUA0rBec0O6O2kES
 eVQ/QI3g/KZUyEpvqFkR6KQiR9B9W51BNEVIl8br4AunfE7Psg8bsCf7jeNU5ALrhNIy
 kyvr8wx4Ps2aJpe0f5xHgFo7/fy8eXakWXIwv11P0KdbFwg4igLGKNWZ1BMaWJpI54vx
 +8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791051244; x=1791656044;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rdVCpSshYXr67Ky6dokzzIKGYDj4ifAugrUaOUW3jqU=;
 b=JppzTMXyx8hGVp2J26l0s1gpu5+dBCLTK/t6NlqP0HVt38e39Qh3OUWOgsmWnCSp60
 wNdCSuUFC7wZUmcJ0rAgjUAfnqYXvAg8T6l31eAHu+KGdv8/ZtGYRlDR5NkGuS/qClT3
 9dTscNy7aGllI9cXP5f48+V3BbmUj6i5knRY3mHaa0EQkG+zld/gwu89+B5PORCv+GYB
 T+yQ33LluEbP0EZDJyqVoyjlfa3VtRlS6FIb01UgbvSCh/4j97yRMnjnWbqCdoGDMAGa
 /ymMxcIJ9ABKvT/b3/DjuS9GKJCKgRn0a7VKpSaBPvWIubKlc6P2pRkBZsElGY9/L8A8
 u5YA==
X-Forwarded-Encrypted: i=1;
 AKwUvBytWTH4w22YzkqLn8+uDq73obcmgFuTA09wfakoTrt3n6FtMBFnLoGO1qY/jZhV5CninU4dVcMUsj1dfR72@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI4eFDL75dGbXQ68kYn5G4frpm0kEUIN02tgh/I+o9JqHQjMe+b
 2JwnFpLRIKXhEG3epZOToIlAU4y5oXz/HTjy5QXrcg+zxu9dcIycdwbfMvTYk6bjA9/6EKc8Mwf
 bqpU8o8A6c1xY1p6d8KKjT2s+gEAwPTEu+uOqKSafzZFhlppOs1FSUkxeSzsDjg3nOY9m
X-Gm-Gg: AYBFou0vC7Ha3qfGv9XXP181e9FNwGZlK3Dt4uUq5h5Fe2YL+aQKCA6mEt/2B70Wl7J
 XMdEiIcot8zJXrmvHLcLuDSRsI+djayNOCnYIC816AbSLx3ljzFkbOk26QLnjsjj0Z9Dam6Ycvq
 nXo9cYwkwYW8+EvlS+EE+/xdmat57F5kC/i3SpOzkPH4g34Id90d1YyeaeiebM81XwJ3jI2LN4e
 wBJo3fcfp1WwMH79/icDzhqqL19hRLnWzKu8nB+UiKO5Qy2SE3wBdnFg7urFJwgTU1BFJQik1Tj
 9iEhT/DVppydIC9cKzzvPadYWSavhT9L6aejzJW52p75XjWBHdZbuh2AI9hXBLq9l7I0z4jUNF5
 AwICaHSR5MfYRgLtMY2FvIXGszIDPbudilILXaP4iuzfr9JaxOIgZdPvP1ipt9DEzybPKwAFRnO
 2A+fOle3CRYfXhS9wQYw80b9Puk6uFTJumA5kofFJu5EAjpM+224bWrzFCmAuKcAxGVj7mCXgj0
 EPTIV2hvql1Mb8Gb/stiIucNkaiJKukA+0xQ1G6lUb/k4aSyIUAK41eTwm1Glg7z8OWWix60cz0
 Bz0NWXRblVIbKgziwEANBy81rhasoIDIQsdfqORuPDBh+3abgW2rVxBZrF/8S0UOg9dYfTY=
X-Received: by 2002:a05:6000:2486:b0:48c:4664:4c70 with SMTP id
 ffacd0b85a97d-48c46644d44mr6394174f8f.45.1791051244162; 
 Sat, 03 Oct 2026 11:14:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380f04f8sm13777074f8f.9.2026.10.03.11.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 11:14:03 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 3 Oct 2026 18:14:01 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I7f910599f0f4005f06a88a93b40417ffa37022a8
X-Gerrit-Change-Number: 1960
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1960?usp=email>
X-Gerrit-Commit: ac3160d4d9adbce01eb3e3ac1004d5f3901187c8
X-Gerrit-Comment-Date: Sat, 3 Oct 2026 18:14:01 +0000
In-Reply-To: <gerrit.1790610390000.I7f910599f0f4005f06a88a93b40417ffa37022a8@gerrit.openvpn.net>
References: <gerrit.1790610390000.I7f910599f0f4005f06a88a93b40417ffa37022a8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjEwMzkwMDAwLkk3ZjkxMDU5OWYwZjQwMDVmMDZhODhhOTNiNDA0MTdmZmEzNzAyMmE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cef9ebd6503c36003abb880be4dd6c5189287f57-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xD4FO-0003qm-Sj
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Fix all occurrences
 of cppcheck invalidPrintfArgType_uint
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
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3303835413454188700=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3303835413454188700==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9LG/iQICs0s="; charset=UTF-8

--9LG/iQICs0s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, plaisthos=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=2E=
 ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1960?usp=3Demail )

Change su=
bject: Fix all occurrences of cppcheck invalidPrintfArgType_uint
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1960?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7f910599f0f=
4005f06a88a93b40417ffa37022a8
Gerrit-Change-Number: 1960
Gerrit-PatchSet: 3=

Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comme=
nt-Date: Sat, 03 Oct 2026 18:14:01 +0000
Gerrit-HasComments: No
Gerrit-Has-=
Labels: Yes

--9LG/iQICs0s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, plaisthos=2E </p>
<p>R=C4=83zvan C=
ojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p>Pa=
tch set 3:<span style=3D"border-radius: 3px; display: inline-block; margin:=
 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1960?usp=3Demail">V=
iew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1960?usp=3D=
email">change 1960</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1960?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I7f910599f0f4005f06a88a93b40417ffa37022a8 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1960 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Sat, 03 Oct 2026 18:14:01 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> G=
errit-Has-Labels: Yes </div>

</body></html>
--9LG/iQICs0s=--


--===============3303835413454188700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3303835413454188700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3303835413454188700==--

