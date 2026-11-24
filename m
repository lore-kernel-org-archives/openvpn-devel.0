Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48622606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MBYBBzHU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GUr8YAV2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=keIWy93v;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ULNjGQM0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=T8oa9WlFz03LELpEWdI0j7awAXSG3l5yLS0EtnQpLWo=; b=MBYBBzHUmx70zlWbKldN/G6KxU
	R+sI/mSrkGAtEVkH7jrnIi0etnf6xWjsk2jIPMeFoi6hBaLi54bVxUrpIGhgTDvdj1LaE5uUYpTmj
	DAfWvsCaZU4u5AbBhLquJ+FOg43axub8kb8+9wKz5QXvkJhJaG1Giq94CfZFOlfi8Hyk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVslZ-000000004OO-2ugo;
	Tue, 24 Nov 2026 15:49:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVslY-000000004OG-1epS
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 15:49:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0O0qb4altSPPFRkHDJbjbtMzq7TVA8XPK+ISVpD+dcA=; b=GUr8YAV2zccj3fRtzG48efZLsP
 2Cq1yKTsXArbmx819kyNKlMnFczfj7nYWW6qBpwOG76b59YCjZCkUM314zqmP/lovFv542KBrL1GD
 SOQqwWvCToeF/rZk9AfkPrrlKXbqDhN6IkuLdM7l1pOAkH94fRRXjGd2H8hZutKxm+0k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0O0qb4altSPPFRkHDJbjbtMzq7TVA8XPK+ISVpD+dcA=; b=keIWy93vlWGcXhiLTFLHw4jB51
 eRaQ4A4s+6/pmx0EdlZ3njRl3eY5kepbnRFfcBA1xpJ5XudA6JlYrVkgOQ1RqyURJoa7gkCa2g2Qo
 FCjjHEmCoIhVPFtI9QnrKDD80JgRkVL5R5NMTsou7aKzG0fuE9OP100H3ubrHeRSo4Yo=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVslW-000000005ru-4Bjy for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 15:49:08 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so50741345e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 07:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795535340; x=1796140140; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0O0qb4altSPPFRkHDJbjbtMzq7TVA8XPK+ISVpD+dcA=;
 b=ULNjGQM0VYW7lFh3b5C/9fpUVh+pqf4YmXYTMsElFn3HTuNdwssbphauXZetpafWl9
 qI+PzqysT2cop+2fL3nUt4p2jmOyg0ya3AhgMOmb0lgg/9KnkycklqKxDzufjg5kb+Yn
 FgcxtrjlLFOqSQt3cF3t2g9ojtvXZJ3jchudwdxINIIYF9fcA4TNYQdJrEGD+AnGQb5i
 MQ/6ttO/dYXheGcxAaNB8zJntLeoF+Y88+MVeKfedfbmyqg4lyICwmRe7cLgb09Il/EB
 hNFtKm7VsBkYsl+aR6phmCVa1CW4Gk+gx8Zj48PPCGAOvpYHFwzmFMbOWZr2OPc1U+lb
 xFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795535340; x=1796140140;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0O0qb4altSPPFRkHDJbjbtMzq7TVA8XPK+ISVpD+dcA=;
 b=UL9J47a+qbDgFlIesr6Ztcm1Gt/np84is4iFdlF3lvzFCeQ4ZJwRpw41wI4ue/q1Bt
 5piMHoAQiBRedJ8ITuKUs5Ior2WzUuBOUfl6hmtOpd+tuoi0HPMztw+aSIqoaXUm2Q3q
 fDIJUyDNvF4ZaYHsPyptFc8DkCKexFwLOPcPX6B7hrrLWVBrI1gVeLmoc5RN238X+1mW
 69SOPpNzskpy9zW9c81rwvl1N+Q0iwIH8Uv9gmZv7vL/0AyxEz1Ns9YNpYSC2ixaTJCi
 ZiCJCgYMk8fzbLdulF61K+G/dvik6g0iywWssBktiFahmacrCYk7t6z8vC6RoyIjJQHb
 32ZA==
X-Forwarded-Encrypted: i=1;
 AL+hErF6wFTUIC9WvAT5Z54oWYWSNi+zEAWKg5E5qmPcvDclBEYZPopd6Hadyg3p5p+AwqNF3vzLPpcSPg5Y2zd6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8Na7ZzmLmeUgjdkXjprPD3Bg2oPByuiToRRUGDfF7qt7bj1ouU
 cJLpx+RL8egMZAdBm8FwsbFwyPD6EWu80EEwEabB2Gy9DpNNLKcTi1ew88ZtKiS1jcB8yCvkOjk
 tHOJ1YqbUfzX59RwEN+f8K59nOJdpuIisDKTHayMcrGwiQ/w1pjWFM/Swr8RdwIf0JK60
X-Gm-Gg: AZFdTZcGRFfVK0aNLMq0a8k7c7THvLM89w9EMGEdFYmKIG15F0rRBIibmqWIUt+mJL2
 O1NuAoT/gVLTH7G2gJRm2Buw0WIVRSQIpa7a9f2bELWP97XOfLESp0DAEdvT4mPsb+tAX/ouvO9
 iUZvoC9xIkrIPh96PxC4OtKkkLjhHCFWq5LGiQgTX/v5JTSKv3+dZ67DH3BUk1Ol05AwILDts5E
 LgDLoVg7zXGpYjgoVU/u1OwJPQk+b46RZhj0TLhEEhvOzlE0IGvshOGaBXWyRwRqxxejFEMO0Vn
 7GJUVzvZ5+YlDJlboCAt5mzJzgKBchmZMGHWYDpcGDO3+Nw9jr6gJekGT3ES6T3qwivQjTEYbfk
 LAXZfpScHyxU24ILSJQJ3O85vFazh6xg7NR3v0Q+Mwcz3VY7nuOD8wBUitV8eEYMWA7n8nta+aV
 f3hp+Uu0oAxlAsrHV4XA3HWBg9C4LaNqKyOCI6/kGJqYq/fyjnePgzD6y/deMADrwVvRdHUQUtU
 MRtMcD4xIHJiqrey2rXgOQvKfqY+RcS4x/mBSBpotZuYKAit3uR4RRRQytU91rONqYL/iXgI0KD
 IF+htOnlwxKgjkmsFL3P1B38O9oLt9q4/ZrTjSXHPbhk4ufveAFH2+xfz51gnzbs1dMq1TOcnNS
 MSEnYigjTYlfWB0dZJSDMaAohqaikq9KxDKblTPDc1es54+S011WASVuOnAmljBxgOYLtl5QWxa
 1OvRulht7yxN+KHJc=
X-Received: by 2002:a05:600c:4584:b0:4a7:c366:d791 with SMTP id
 5b1f17b1804b1-4bb887e266amr293573365e9.1.1795535340233; 
 Tue, 24 Nov 2026 07:49:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90655f5asm261867745e9.1.2026.11.24.07.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 07:48:59 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 15:48:58 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
X-Gerrit-Change-Number: 1915
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1915?usp=email>
X-Gerrit-Commit: ccd026cbe43b2526a79ee823cd93672b5a74a1d0
X-Gerrit-Comment-Date: Tue, 24 Nov 2026 15:48:58 +0000
In-Reply-To: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
References: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5Mzk1NTEyMDAwLkkyNGU1OTI1YTcyYWFlZGU1M2VmOWU4NjNmZTk2ZmNkNzM2M2RmNDAyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <57d1cae605249c72421937231ed36d8c1b5e90d9-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVslW-000000005ru-4Bjy
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: Let an
 optional UDP socket give up on a failed bind
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5673705724362807985=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5673705724362807985==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NdGMjeiG/rU="; charset=UTF-8

--NdGMjeiG/rU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Lev Stipakov, Ralf Lici=
=2E

R=C4=83zvan Cojocaru has posted comments on this change by Lev Stipako=
v=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail )

Chang=
e subject: socket: Let an optional UDP socket give up on a failed bind
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 13: C=
ode-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1915?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I24e5=
925a72aaede53ef9e863fe96fcd7363df402
Gerrit-Change-Number: 1915
Gerrit-Patc=
hSet: 13
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ralf Lici <ral=
f@mandelbit=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Lev St=
ipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 24 Nov 2026 15:48:58 +0000
Gerrit=
-HasComments: No
Gerrit-Has-Labels: Yes

--NdGMjeiG/rU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Lev Stipakov, Ralf Lici=2E </p>
<p>R=C4=
=83zvan Cojocaru has posted comments on this change by Lev Stipakov=2E</p><=
p>Patch set 13:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Dema=
il">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?u=
sp=3Demail">change 1915</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1915?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1915 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;r=
alf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 24 Nov 2026 15:=
48:58 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--NdGMjeiG/rU=--


--===============5673705724362807985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5673705724362807985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5673705724362807985==--

