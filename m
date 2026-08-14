Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABD9C5B572
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ixlp9iaybvQX2wLAS1u1mSv96K8W5l+l9nimGhCLx+4=; b=Uhnbr0aGZAm4Jh7ZnkEZbyLdVo
	sPAStaNMy03IqzttLVRM5N3EkPp1yY+VwBogjVBfK7y3hPc3CTm58+G/Q+kwATXGizIfVsYJvoPSt
	JqcTjofgpR1vNG65WyLs23CLjEHCcX+htjrkfz1w/WKrGFyKyQ04UY81v47UNpKCeFKw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wupHQ-0001Zj-0b;
	Fri, 14 Aug 2026 10:36:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wupHO-0001ZS-Jw
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:36:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hIBXGyg111MGPCs9/0pmEtTlCp5lWQJZmN5CiFAU8xw=; b=ZMTLqhnDHVJ/OPvvHEB3XQut6p
 OTooY0RUtIcGWnUCsH3v9gBQZx5zL5D30eS8clITOb6sJs5Ye2apkwRRGNfEcm6cKzd/IdeTaglUm
 SVVGvG1Xe8n6xL2V4wKq+C8ZDGGK0lBA72W7A9UPTVeYinr1Uyqnj7OtVkIhiGWVynmY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hIBXGyg111MGPCs9/0pmEtTlCp5lWQJZmN5CiFAU8xw=; b=I
 SpWpKJyWchWkf0Mmz1eRSO6IGwUouKhNACHnUEUbYQARC2d6nIJc+4YFsWI3Ko1/rDAcDY96xRl94
 5TRWEsZwHj5LDBVuH93u/rWpRsCXVVBGDWHz1MJCtr+QghUyktkvMEbjCcC/azDmwvSZa4EpYoJia
 qbkJpKxr5N8deuHw=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wupHR-000360-BP for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:36:51 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-480033bdcf4so482207f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 03:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786703803; x=1787308603; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hIBXGyg111MGPCs9/0pmEtTlCp5lWQJZmN5CiFAU8xw=;
 b=ROvdJsBe9sOrahyELj/+slXKh7SNAd8JnkTweh0F+U/oQmGd7+8BvHPjISsfYlhDzM
 086OSc8oKwF4DmglqK1Y7X63eQYZVLBXUt9/W+Jnb4dhpqhhSqkXr2787eEHZlg/svkk
 SEbCXkcqrS6pnKo8Qdub0OYw/DVOWd+UMTOdKgsKKbuXoiBdbTFAoG0IN2ouD4I4DNWg
 rfKyFAVz/3Xyf1/8VcFoVRCzJC2pKTIcfFIqr54u20gW38kb3LGf3tcTOFDR6mBmxlHH
 1IshaPsTBBL1csokOu75hSSzZRSVX33Liztg+jCGJPQeTidJCHkAh5u7ANmqAPYoh6SI
 ZmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786703803; x=1787308603;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hIBXGyg111MGPCs9/0pmEtTlCp5lWQJZmN5CiFAU8xw=;
 b=RRn1b2V9mlhv39bf5NCg/CmzGA5ysHWJcL4VztNqobFnR4YiYMywHNm9HRhKoaibSE
 kPLWeeYqVyofSijYVGLtgRaJkUgLDiO3leO7DCGrs3K7wGg+2fRITkWWomT0sljNByey
 eDUGvfpF+kiI5y+h+POmQJveNcsWUlK7Da50kFIQtrqRm+nHidC6St8LuqvQhtlTGV/W
 x97a4FzkzS3w6VPE3Y+INyYTXf3OvcaeQnTV5yKI1YHBaaOfR01hKLAFWkGpSR95OOJ+
 Mlp0QgYcUoa48CL1O2SQlr7EfbEypQRXVGUSSxYx9uY3Gv1FORhkGQPPoLyHmWPmVwUh
 pMpA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSpTOgq6imE3qreNz29ZeoFht4DPcNkaN94oJFSOdgFyjDFogcZUEOXsVm21xu4Vq/BlucweufIJ4I8+RH@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyBYp9UmBGEjqD4VigvYw+8j4WkyIsLi0MeEslKIVU41yNUm7Sl
 SEFWc/neSWIEGK4N7LSo91RiGTM7Y4RccYpjz4snRgnWIEQ3HqDtpnbjVh48P+A+XS14MMccSAJ
 O4p3mkWfjiLgJMvd5mh4BdjlYbI10gEbfbldijT8WY5aAsv7hNrMzpNAcpVLWv4M1gtTLOLI5vA
 q4OHfloQ==
X-Gm-Gg: AR+sD135hBQbJ0WipOtapjowv/wNeIZUgCv7G8jSLMld1BtrMJMJs8RuuLmMbC+n+St
 lLdwaX5swyGvapWE5dK1VJLCywKXdcnd3gky+mdLsDvSo+Z1l2dDcp4WHL74Nuu8sA/NzRm2Bmb
 COaRuxkl9EBI28qqaAQWwUorgN75h6fAFeBV6tRDjBRfVoau97iJgDvEjER5Vf1lodPicSt7Iec
 tdme0bHSCLb2gkO817YtESi96tlvbcR5LiaLgYR4zRS8hfSBP4YUpIUmmrqk4R1HUnj7PHEcJyS
 teNltdCWZe8UXNZnWJ848reygxhuZB3wIelJQm1+r33E9THbjpe8kwKHonOAB5WTUVhdR1hcJcL
 X9BCPt45O7NYZxK7LC29dMVRvZrNy4PbgXZLzsx4WMLXpqPwvTRyTgYTFIMJTbZpgfunySN+c6Y
 2UYmZn2tF+qiMgmdCI++ZDjk/RMUXzn0vgY60Hzl9ZxksoJ8SdXJJs0AuzFnKazN3CDSj3pAx6P
 IXvkHHbET88xonzuVQqGFNyBpCACISiYckEYBcOCACIDZWRiKyRNwszNvENRrCDGTGxJc3Sq4E+
 4P1W+oAlZ49KJnrpzsn9As5a7aSsenPzQ0bXittu2jlSlZRwPMiRz+3JkPhXOw==
X-Received: by 2002:a05:6000:601:b0:481:511c:8d3a with SMTP id
 ffacd0b85a97d-4816070fc6fmr7535292f8f.2.1786703803084; 
 Fri, 14 Aug 2026 03:36:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2cd7ecsm7090112f8f.36.2026.08.14.03.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 03:36:42 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 10:36:39 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
X-Gerrit-Change-Number: 1610
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1610?usp=email>
X-Gerrit-Commit: f5ea903b6ec7feb54b9854e2b709a545da23d570
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 10:36:39 +0000
In-Reply-To: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
References: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MmE0ZTgyZmY4NzZmYWI3MTVlMDUyZGUxOTAzYzY1YjgzNTM2MGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ee286aae1f730d03a5be352161c8830cd569268e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wupHR-000360-BP
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove various
 unused functions
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7648129443760821185=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7648129443760821185==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7QaOXJdlo7k="; charset=UTF-8

--7QaOXJdlo7k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1610?usp=3Demail )

Change subject: Remove various unus=
ed functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 13:

(1 comment)

File src/openvpn/buffer=2Eh:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1610/comment/080a3082_5a7ba107?usp=3Demail :
P=
S12, Line 818: {
> OOB patch series (not merged yet) is the consumer of buf=
_read_u32=2E [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1610?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
Gerrit-Change-Number: =
1610
Gerrit-PatchSet: 13
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: F=
ri, 14 Aug 2026 10:36:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: N=
o
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Re=
ply-To: flichtenheld <frank@lichtenheld=2Ecom>
Comment-In-Reply-To: stipa <=
lstipakov@gmail=2Ecom>

--7QaOXJdlo7k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/buffer=2Eh:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1610/comment/080a3082_5a7ba107?usp=3Demail">Patch Set #12, Line 818:</a> <c=
ode style=3D"font-family:monospace,monospace">{</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">OOB p=
atch series (not merged yet) is the consumer of buf_read_u32=2E [=E2=80=A6]=
</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail">change 1610</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I82a4e82f=
f876fab715e052de1903c65b835360b5 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1610 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Fri, 14 Aug 2026 10:36:39 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To=
: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--7QaOXJdlo7k=--


--===============7648129443760821185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7648129443760821185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7648129443760821185==--

