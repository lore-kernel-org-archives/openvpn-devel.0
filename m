Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34FC606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Nge8nUgs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=F8lYXST8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CTJd4lcJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fiZ2/WkW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mE5bM0FuIjikxlkFeqURb4F3lWEY9T10Oxg1Jnh1nVA=; b=Nge8nUgsSykchRJ9z6gXjXaYKG
	4ZxyMBF630N2+GfVSGUybTtd4QM7FX5RCXfzA/HcbqBEABwAAV3bIlSIhXMcBaJS6Mz3GYgWNA2P0
	VveqLSC9tUp+4x7tWlFkmGDkS7QKku7k+zuVwpoJbEY1iu9YH3ZhPxfHiZaak2gZw978=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR4Ck-000000004Th-2M2D;
	Wed, 11 Nov 2026 09:01:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR4Cg-000000004SG-2IK5
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:01:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TkO3CMewz2fuTQCD8aaXoOCgCi9K9NefXxoTNzQo5qQ=; b=F8lYXST8VkAETSI9DkBrxP1WRY
 YS/6EQ7k9LTPeGcnm/ENzj/xIqHgrDP1z1BD8fgbvgxKTOpud7G8jy8hajjsRLuyfmY0uj6Lh5KUO
 /gj2rxSCENGgCKT+RRr/CjSTqKZsfVAPjksNtU/zsSWpzoeVte2GkK5ZtniZLddvcCA8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TkO3CMewz2fuTQCD8aaXoOCgCi9K9NefXxoTNzQo5qQ=; b=CTJd4lcJe/1CQnrfNM5PKJ7PUd
 DwQy0mgZfUfL+61r0UQx3U+uUqQy6ljRdwtshScNQ4x0KnsI1gebpYlzSYXAbY9clCtHIAIdQBSzK
 TsMo0exgXWQpgunKsz5VaL+CLeLrzip9p0RJ6KGkw3nJ7j+cXyJscfpOqMAsxuSfalEc=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR4CQ-000000007Xp-3kex for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:01:01 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so16964405e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 01:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794387652; x=1794992452; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TkO3CMewz2fuTQCD8aaXoOCgCi9K9NefXxoTNzQo5qQ=;
 b=fiZ2/WkW01UBNOklomZ+4ioz/YS3L5Cy82Kg/92YsfdVNzxh1KVuaFnqI3Xt8GX/K3
 ix6vA75obfCOaBgNOPdXidX8ZRWsyZkxQ2WZkFJ+tGlrrO/+HokF2AXAhpTH0APGPaYS
 QaRFGmM2aGzhmS2vG7hvnMXfkkKhVrc4SJDuzm1jTycNSYjyg4hrVzyR/2BBAb9qljyX
 PpCP76HkLQXuvWPi/32TMUqt8TKOjmojsqzrj9bGuu3wvUMiZfyKUck2oCgdM0S3rkpe
 28+9OrM+49kuCPzKwSmmvAK8DROx3/Ply4dLNoTF4GZx4cdf6yFFOzHKCgYFlZndDdRI
 nLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794387652; x=1794992452;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TkO3CMewz2fuTQCD8aaXoOCgCi9K9NefXxoTNzQo5qQ=;
 b=l6i0x2G45K5yrRr0ZbLys75nDZPfzgvSXVFynb8BrWB95Zoe2HQlV54dLqPEqnAtaU
 0fTfqPlXBk7Bhx8WIWi2oWO9khWikXpzPj0HHM9hFC4iBtq7T8AmTE75dDspVj7QS6EP
 TPu1IovQ+dRYMh57dWtwMxIo63bxowpM1igiLmqn5wGCeN7RtXwfGWaonO3e+aMfnO+L
 4sf5TuGKNvvB7aE/k6T+W3kW2MH5b/aBgMw3haDOmBNVQmGHKBSKa4NWxVxxFp8en2Cn
 zFlQDnONVouzJE6TyUvD+iX2bjZdYsbMab5YRC+5gRF32ggkiHDxgnJuR1n1R8vVORiG
 djvA==
X-Forwarded-Encrypted: i=1;
 AL+hErEViJc4x4m2Lxf+sy5e/BYlJIwa2HtovjjMeX5j+LLKhqeUlawHNcfmKcMIW0tM+zDzmhqewZbBhlI0Ky4c@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+k8aoAgPN/Ov7Amwt+N947GJz/znxGAmC2u5/XAk5oxL+MLtUv
 1Bhwg9pl3Eg7vx3TPPpRyViCNX0itNpaAaCjT9BjyUDzdTfOVDEDlMgmbU9m6nHYGYjhwYSjx3F
 N45fOkI7+0cCWTnoSpJA3gOEe0MDtabLhWK4ScHCMDnREFL5H7ch/3+txyvCxk+CvglyeuvW+IX
 PoP2/Eyw==
X-Gm-Gg: AYBFou1udsEljHSaD4h5Uyk/RqoqM8F+ku2kX2A5D52fiAUHQtx9TsXg5WHMBsWKR+0
 gSHATod02kgXmFYBwG7IwrlddkGv4mLgMqojS3iGYXcLZujw0gMD+L5wjbu2DZe11k1cZNFOlDU
 xIbLRX30gfJwVkgqG8jjXAJilvlvY9pIplXnfu6bEwzAsxqHmyjYESdSncorOOE7kgd6zyurnSH
 e7XvSDN4GcuL2zuVV4CuCbYZjdJLwf68H7XWX9R9xiaz+0N96W6oWH45gDCREEKcZ8WgdECf9GJ
 vCDQSX/o4XdGdLQPY6X6TwSvCBU8lmHbtP+vygYe6LxvMYuNlHzji9IiMi+fUDA/MSirjg9ofe6
 205stkPlZBYMow0rgRvWDYKW92jgp4l2MtNn9PhhdyHTaL7nrcxeVm36RctwAY4q/g2omvxjvms
 +DYYgDGxFjPVX46dOWl3JLwlyFta9a3+dzCxoQvsFvFfXRtx5QxmNKz8155mt/L3Y9GcPY+9Egq
 XeWvH1ucPeyzIXZIH9AXQM1XV89Kx4HJKtaKTPBaNNdI2cEnFXqYA7lWWmBkR7NLK/NSa4pOuPr
 SKIsc/sFeVYMTNu58/UD0rA9eAnoP5LqnUqp0OoEpoB+Ldga38Qa7vICS8LSjbfz2Mj46ZhR7Rr
 CqEcjh3NJ0AzbJq/WjwjgbDTB6LixLcfyHYej2X+gq2oxivaGHFBFU8mcvT8w81OaGsKnZmD0fj
 56WGYmx+SV8pSPc/I=
X-Received: by 2002:a05:600c:8b70:b0:4b7:6c16:7b43 with SMTP id
 5b1f17b1804b1-4ba0939d508mr28559785e9.10.1794387651983; 
 Wed, 11 Nov 2026 01:00:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0951f237sm27850395e9.4.2026.11.11.01.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:00:51 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 09:00:49 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
X-Gerrit-Change-Number: 2162
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2162?usp=email>
X-Gerrit-Commit: f7ecc5e1df7f4b5260059e70c49b7b6e63f3818d
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 09:00:49 +0000
In-Reply-To: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
References: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA0Mjg4MDAwLkljNjAyYjEyNWQ4NTdmMWJlZWQ0YWY4NjYxZjUyMmQzMzliYzllOTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2175f60d429b6648a812c9246f1cd67efebad934-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR4CQ-000000007Xp-3kex
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: keep
 IPv6 name servers in NRPT exclude rules
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8386185439236418654=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8386185439236418654==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JYGxNe6ThN4="; charset=UTF-8

--JYGxNe6ThN4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Antonio Quartulli has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail )

Cha=
nge subject: openvpnserv: keep IPv6 name servers in NRPT exclude rules
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review-1

(1 comment)

Patchset:

PS1: 
As far as I understand, this pat=
ch fixes also a separate bug: both readers now set addrs[0] =3D '\0' first=
=2E
RegGetValueA() leaves the buffer untouched when the value doesn't exist=
=2E And since a slot is reused after an interface is skipped, a later inter=
face with no name servers could inherit the previous interface's addresses=
=2E

Maybe you didn't realize :-D but could you double check my finding and=
 mention it in the commit too?

For the rest, the patch looks good to me=2E=
 Only detail is that I couldn't test/build on windows=2E=2E



-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d3=
39bc9e972
Gerrit-Change-Number: 2162
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli=
 <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-At=
tention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed=
, 11 Nov 2026 09:00:49 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes=


--JYGxNe6ThN4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Dem=
ail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2162?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
As far as I understand, this patch fixes also a separate bug: both readers =
now set addrs[0] =3D &#39;\0&#39; first=2E<br>RegGetValueA() leaves the buf=
fer untouched when the value doesn&#39;t exist=2E And since a slot is reuse=
d after an interface is skipped, a later interface with no name servers cou=
ld inherit the previous interface&#39;s addresses=2E</p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Maybe you didn&#39=
;t realize :-D but could you double check my finding and mention it in the =
commit too?</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">For the rest, the patch looks good to me=2E Only detail is =
that I couldn&#39;t test/build on windows=2E=2E</p></li></ul></li></ul><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?us=
p=3Demail">change 2162</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2162?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2162 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 09:00:49 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--JYGxNe6ThN4=--


--===============8386185439236418654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8386185439236418654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8386185439236418654==--

