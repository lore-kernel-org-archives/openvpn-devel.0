Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A6F6070F21
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gGVLoKwK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nNzKzgmJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=g2YhgYYd;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=b2GowHo1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wTELwwXZYpp3ww5u3G5fWa9AYMo/Ex8zpMi+8HNMnXU=; b=gGVLoKwKe0w90jrNat1/1KKyMx
	Ns2WYVvusrjhQXEDJhTJlqyahFrMB1mU/8cSJ2RtrWNUbz/fATs3rxSkhbEyfnix3xDpWjiqmdZBK
	FnsTWWQnjWQ6uyBoPIMdBXTWWgacwp1t8RJGuZuOvHhm3KGbQ8niEdaGgx1bRJV3DCO8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOgqT-000000001SF-1lXt;
	Wed, 04 Nov 2026 19:40:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOgq9-000000001Rx-0jDu
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 19:40:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7vu+h+aLNpZaix0ONQDbN9Yea/mD5A8+S4+T9IRpRp4=; b=nNzKzgmJUpqUNR+EAppHVxxZ5Y
 WcyImjgpp+yY6KXG54JQBKtlEXBxC6BRcFj73Vpq0Id451PbUERPPTrn5HyRiZ1dRJuv/YTq+K3RX
 Wd9lV5dK2Z1loWUIl5YjIveUDo2pIGvH7BjKjzfDDIFxKHCXL8RoigW8QqtwrMwe9ogw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7vu+h+aLNpZaix0ONQDbN9Yea/mD5A8+S4+T9IRpRp4=; b=g2YhgYYdQUM9EguimtNMfzCkMr
 7VC24CwxeRh//JPpfUPBi3iyEfDDP17FzSLJAdxw8svuhIkpEM7jRtU/E9yh+pK/WSGqYnmg7kt4d
 qs5ImdYTqmQTTDWhTZSoMu54KHh5e0lYHQzf1SC+vlOLXUlq5nCxpRvijVHMRei3nW4k=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOgq8-0000000049l-0NW5 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 19:40:09 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso7504755e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 11:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793821196; x=1794425996; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7vu+h+aLNpZaix0ONQDbN9Yea/mD5A8+S4+T9IRpRp4=;
 b=b2GowHo1tri1kYiS50ZFEbz6lK9WS3j8vSPhq1CRRbreRoc6SLxPjIrw5d1qZLwOua
 sE3TQ0ZM5g1A3hn4M711c8T4/3Fi6VA0bfAuvmQgnOxQtZYdo+FkCZ3Ei+qDuQF1hSt1
 Q8cBOe+rX7EMFcKQz42ghdANamVvT0wZuyyeOcLsPRBWw6u+gLRzDJQ9ypVbk1DmoOE8
 jRWvRtJNytXz66r0inSXQ+ezTNVr57oh8qeFBiVkYju2fffKrT2r6TGnCMtyzNP0yYfz
 HiTfCvQQbfZiWgnswzDgQZt+v2N68xe0IyKai8mIrukYoy+pFiOLa3estZKsk21chwNR
 OzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821196; x=1794425996;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7vu+h+aLNpZaix0ONQDbN9Yea/mD5A8+S4+T9IRpRp4=;
 b=Yyd/zCM1PbzBfDwrR8WXsxSn7TjNgNvZ50qB9dffaXvNN+MFXaYpbWOf5C+Hrkkkam
 +gE/dLeuztbfdnk5J2wH4qmCt5/oHY3jkHxRPwMXu4f9Rkm26ngtpEXnr3WlrQDCp4Ds
 x6FeF5Wj7btCg4JGsCl7g05HTtTzNKaTcC//28VprjwJpUuc7UIBLp9VufRn1ADh/7i2
 2Es86anZlmbPKe7jJoQx5mCBkdyTadrk1wbqhAxyyUFe5vFCRMo4HF6FawyJr8dx8pno
 WrDOcVG+iDkKyIjKc45E6P27VXnGYT93gboFdV0Q5sWywqn+H0NjePhPp8JXugrEadPH
 kBEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6xbxO8vj+PvXSZjIyJNe9GgD1eTz8ZMceGh7L68q/RHlywXH8K7/TEk/MwrEcRiptWKUQElHGYhchk8Sd@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9fupEi3i7UDC12BNaRR/hceFF4jTemMc9ZktejqauJ6hrEgZgW
 4GUzUryLTjGcqryO88P8XRtC3TEXWzJ1VGNNjrwCqird/wtyRh/KRPmqLv8Q4iGB8RKra0ViPzV
 UW/w2iGYW+qOkriA335HBma1AYNVZX4TVe5vNRDMZcyAx+MarWap2s0BjIw0mBhSnVsj5sV0C3R
 z3XL3ucw==
X-Gm-Gg: AYBFou2FvWFSvDeBz3dk5ILcm2HOLO7ocv+Mql0z/ZeRQeqcZkUmYTSEkE5vgjOhSuF
 tscjpqUeweBxzP4f76xnz8RK3rlGXtbnz7NeG/SGnN3T3bbA2hQr/7JoZY06P/bOe6tdSSBhYEj
 CBd5XUbsSoYfLgywrUVNizLPIGZNBjJ/Hhqcqf9CM9LcJAMZyx7umOJSC0hvY/sbvYhj5V9fmAV
 rzOGU41ETFpmTEYkLHBl1ufpY3IEerkogDLTWrOUXO7+ZJShxFSu8+W4td4JtNV/NuTDTPTKgdD
 tBMcUajdylIMRgNKG2y41XQOkmVBSgoA2EQ7KrOPUXJiFhFDbw+72l+fpcTNXOhnXtHKJLjJccG
 IBErHUclfhZrI56r0++pWd3zFDSD0eXZs7YoZjvBnwR37u4d0vHInaxfP0AQbNzaPbqCoWfcauB
 5FwZsNqKAihY+NcAc4QvL9nnTQ+BNNmvqGpcpvLMJFMdoxby6phDTbiw8QJPCPovri639epOARG
 dJIKpEg5Ei0QFwJEq4jcpEmZne9qfJuXTii45EaibgJcS5QAD1ZNPw6d8Sx4jJCGnCmhCoxBN7G
 YNqSS5gFD+/rf2PmBAdSOlEMqjveiiWPzNDAjgjHL5PJDqSKF/ED+lKVT6KOmdqEjQHqhKV6mw6
 VvsssI/UXMNXRP5oB46Iv19x6M4nXuc+FQKg8Fiw0pfjsKPlodjwxaUiBHeSAsAvkzUcdCVoaTG
 NOKsX+f/ukItas5g==
X-Received: by 2002:a05:600c:474f:b0:4a1:f8cb:7d70 with SMTP id
 5b1f17b1804b1-4ac1793ed87mr387084895e9.24.1793821195844; 
 Wed, 04 Nov 2026 11:39:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda20521sm5461944f8f.53.2026.11.04.11.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:39:55 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 19:39:54 +0000
To: Marco Baffo <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic0b8b0a3249eb41e1de10f381932c1161cd75270
X-Gerrit-Change-Number: 2061
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2061?usp=email>
X-Gerrit-Commit: 1c9cff61c5ac47362028c3c131156704ced18a05
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 19:39:54 +0000
In-Reply-To: <gerrit.1793194671000.Ic0b8b0a3249eb41e1de10f381932c1161cd75270@gerrit.openvpn.net>
References: <gerrit.1793194671000.Ic0b8b0a3249eb41e1de10f381932c1161cd75270@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkljMGI4YjBhMzI0OWViNDFlMWRlMTBmMzgxOTMyYzExNjFjZDc1MjcwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <da14bc09029c85cdfabbbffd53b0945605c11faa-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOgq8-0000000049l-0NW5
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: track installed
 iroutes separately for IPv4 and IPv6
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3005438867191788880=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3005438867191788880==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8NWw8Ke+Gi8="; charset=UTF-8

--8NWw8Ke+Gi8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo=2E

R=C4=83=
zvan Cojocaru has posted comments on this change by Marco Baffo=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail )

Change subject: dc=
o: track installed iroutes separately for IPv4 and IPv6
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(1=
 comment)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061=
/comment/ffc35e8e_6a61ff91?usp=3Demail :
PS2, Line 10: deletion into IPv4 a=
nd IPv6 helpers=2E Keep the combined deletion API for
PS2 no longer keeps t=
he combined deletion API, so this comment is no longer accurate=2E



-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic0b8b0a3249eb41e1de10f38=
1932c1161cd75270
Gerrit-Change-Number: 2061
Gerrit-PatchSet: 2
Gerrit-Owner=
: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 20=
26 19:39:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--8NWw8Ke+Gi8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo=2E </p>
<p>R=C4=83zvan Cojo=
caru has posted comments on this change by Marco Baffo=2E</p><p>Patch set 2=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2061/comment/ffc35e8e_6a61ff91?usp=3Demail">Patch Set #2, Line 10:</a=
> <code style=3D"font-family:monospace,monospace">deletion into IPv4 and IP=
v6 helpers=2E Keep the combined deletion API for</code></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">PS2 no longer k=
eeps the combined deletion API, so this comment is no longer accurate=2E</p=
></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2061?usp=3Demail">change 2061</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: Ic0b8b0a3249eb41e1de10f381932=
c1161cd75270 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2061=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Marco B=
affo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 19:39:54 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div st=
yle=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--8NWw8Ke+Gi8=--


--===============3005438867191788880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3005438867191788880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3005438867191788880==--

