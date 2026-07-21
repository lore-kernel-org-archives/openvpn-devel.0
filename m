Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D434C44529
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5bGyhdCE0+yNREgKNlYYR4uIj6lcvt0t2FJhSytDXsE=; b=QNMrAm20/Zya/391MP/nV+3J+R
	5PmjzGABec22kANLPj/MOyAxwycbdWpu7iMJnOW+hB3paziBns4e37JkgDfedXYxBbJjxyK2kJevL
	mNJMKPkWLe2J2FFnsvI8n14BLv7m092pNYqqybmA7ABAVowk/EtiAFeKnR7ncM17+CuI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmB5b-0001Ms-N4;
	Tue, 21 Jul 2026 14:04:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmB5a-0001Mm-HW
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 14:04:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Arrh1mtlRFBGFkqcdmBFXIYGMPkUfWn+JJs5KAIZ+x4=; b=bLwLZQSCuL9KcbENioNl7Hyz9r
 Lwks51bfdK+a07JZaTfVjh6zMZ7GZmG3jEGA8fBk8Q4YVpElO2cO2Z87h7Q6Q8r4etaF1OL7Dxm/H
 tx6sLQkTtKJqLhAJFv6rtes5yic8+Gb90NF4ecUpjdSD4hkiBYNhDYmTZbWNXlts5UEQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Arrh1mtlRFBGFkqcdmBFXIYGMPkUfWn+JJs5KAIZ+x4=; b=B
 vG/l0485H4QfDdHQupxcpvylfmoOST34vNXOTgBDrR2GkaOb1JJAw2OZa0ZZrCJMjN+4WGjWyTr3B
 VuThHQoft/HCqQl5C3wjubYlNR95Br/nys/sfrrWY1QNqhvmsh64g+MlpLdYeOX+iHgNwQ9I2vpVZ
 XLLeRlCvITzDcaEk=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmB5S-00062y-5m for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 14:04:47 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-495590ba856so22121845e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 07:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784642674; x=1785247474; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Arrh1mtlRFBGFkqcdmBFXIYGMPkUfWn+JJs5KAIZ+x4=;
 b=as1/KclDc7qdPDwBOtJ+EBs8L07XLgLwKvhyxSsEBW3arO9ZvwxUBXBADEC5h9lZzL
 Phz6srjVQrSDdIvNdMnj1FggKL3b0vAivxhUJ7KUgYWa1ZI8yH+q2kbUh1d1zcaGOhoA
 boe2UnqmNzHx+2BXkrKvse6OWE/eXVYaPScgWFsihhhK0t3xora+MMhS2xmrlDD5y8u+
 9RE+oM3H9ULRFbWP1xkUXCgXcIXNAYOrKdbqhgpsaS7BGzlJDK7DnkxwCFduL97K3Gft
 ozk0yl1dvh4GmD3MRp6yaABVDeyHTuQYuVdO89M6m3RawtSKvOidHnFu/MF1QcwTwr28
 jalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784642674; x=1785247474;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Arrh1mtlRFBGFkqcdmBFXIYGMPkUfWn+JJs5KAIZ+x4=;
 b=eH252FuGQDUOVuDef74nY0csIFO9y2hG163uHkGwt2a36sm9IQTIxwhQ9oKHu2TPDf
 bBSH/BsuGZxP4YOE80BmJae8HKxwdQcMRvp3Cy7C+Nva6UOFXBT+LHg+N6SoHuMQLl3z
 SpX8zgGrgDAjESUXgoZWwaKjy8X0RqV3sU1I5ZcxlWJ9twtw0hW1s8PJRixqrvUzGVQR
 yAVwyQhGT0qmPjtmS8hIthXTaEFRMYwHOMi3Zql+QmOvAD+/hl6X7B+S3gAqcsdXHk7/
 L8SVfeZKxZhoQyFLNDivOvgAsoSbWm/a5hsQi7Tios8KjRWJoGp6DzaOzYsGqVBaZ0FC
 9QXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJ9ApDLRDmLdAFxxNq9kessaYyeaHmez3uoUj4QnmMxVPaSRc/f23+CSiDoc5/Hr5Q/IkfcnjWG31lzRFH@lists.sourceforge.net
X-Gm-Message-State: AOJu0YysnLaqrORkEiDjMuk8ThIiy92k5f6G6XSwaMwBlqBzg1l4NzKl
 JPDseev4PDpT4/JxhkWjgDBxhHtLB9x34l7XEbN9cJV2A6vmXKaI4bm15iwcIJJhIxAktb/J9mn
 gfTjGy6PSMn0ZxySCcgLvKhV/1dPauXT4EtQb+POOueXAiuVBK9BpZFnqK59w4zu02ky2
X-Gm-Gg: AfdE7cns//gycWABCdzSj+Xv8bUBazLkobHlcj49Gfr0r54EXdxG8Zlhppggxl43LzP
 r59ZUff0I3TO4SeeOzt263wCb2RrxQAt0glqr+c6uHtP3sbk6HN2evFM0vxbfT320M81oZa3S3Z
 MdVRcjcRdlHYkdraDPdhCde7SBg1EQj8CvcsD86K5h6TQFcCeffAG/bBtYfDUv+XOPbx6mhY0Uy
 NenkrRrI024LWs/JKdDRqBcJhjffqNm7RQ10JKivlis/53w/lTkKc2In98TWvApVTMTbrE0I3BM
 sq25HxmvEkFM+rAyhRbM+zmG5txsNZwOkuHjx1b5GeLw6f1QAD3hCiyXiphBcwBAwN9lLMk6AlP
 tENZ4LEHE+oNx3qGGNkC0RenOky93b9z6B4mDhpnAgGsKTrzFglhQiSlqbhhGfnlGt1RHOpBZqA
 HpuvL0jeEYmqrU6Kq68haKtBum2GZT4yp5x9iPswgLrqPjIv2CnlKQXdu0RZClAOANgfjZ4AX+Z
 ZcpGS8vhHYDkw8HpeRDVnlgiiaGRt+wV2wxT/f7tIhIhFG0w0eWMZjjtKfu3FTshkL6
X-Received: by 2002:a05:600c:e558:20b0:495:5cda:52ec with SMTP id
 5b1f17b1804b1-4955cda5441mr82343975e9.16.1784642674432; 
 Tue, 21 Jul 2026 07:04:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956547a9basm68737545e9.7.2026.07.21.07.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 07:04:34 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 14:04:31 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3
X-Gerrit-Change-Number: 1795
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1795?usp=email>
X-Gerrit-Commit: 817919dafbc393f5b8b419bbb3248d595fc65729
X-Gerrit-Comment-Date: Tue, 21 Jul 2026 14:04:31 +0000
In-Reply-To: <gerrit.1784390158000.I4d0887839b4a13a92e92250d1b315dec949698f3@gerrit.openvpn.net>
References: <gerrit.1784390158000.I4d0887839b4a13a92e92250d1b315dec949698f3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzkwMTU4MDAwLkk0ZDA4ODc4MzliNGExM2E5MmU5MjI1MGQxYjMxNWRlYzk0OTY5OGYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ea249ed003c9b5489ab5f8f371ad48b129355222-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmB5S-00062y-5m
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco.c: make key
 state desync recoverable
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5559637561336196001=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5559637561336196001==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8RZVzrIoT40="; charset=UTF-8

--8RZVzrIoT40=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

ordex has po=
sted comments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1795?usp=3Demail )

Change subject: dco=2Ec: make key state d=
esync recoverable
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2:

(1 comment)

Patchset:

PS2: 
other than the nitpick I =
highlighted, the rest looks good=2E



-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1795?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3
Gerrit-Change-Nu=
mber: 1795
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: ordex <antonio=
@mandelbit=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue=
, 21 Jul 2026 14:04:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--8RZVzrIoT40=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795?tab=3Dcomme=
nts&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">other than the nitpick I highli=
ghted, the rest looks good=2E</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Demail">change 1=
795</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
4d0887839b4a13a92e92250d1b315dec949698f3 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1795 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ra=
lf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Tue, 21 Jul 2026 14:04:31 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--8RZVzrIoT40=--


--===============5559637561336196001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5559637561336196001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5559637561336196001==--

