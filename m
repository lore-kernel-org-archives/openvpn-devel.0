Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3D6C9832F
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 07:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uC8UDxN94kGnoWvCaI3WaRyd3z8BsVi90TwJTJB6bV4=; b=XlAA2g0fdyg0tiVav+05owFMiu
	sUnlEb1iDkBn3lIoGvqlqtf51M9fytVZfuiWgoRdzrLKcZtYmsF/aaU63KROOkBNJiTyVS3MYVu88
	i6sEu9py7DvHtwb8X5GlFSbaJbPfW3k6zZHFUgmhUc7mCKEVOvPCSJu76/Rz//0YeN0Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xB5z7-0003Ch-NV;
	Mon, 28 Sep 2026 07:41:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xB5z6-0003Ca-1U
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 07:41:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=l3ETtChK9C5rucvzj8woY+NrxEGG75Rei2lzUSyMVWg=; b=jWVt3drQJ1ahqzFFegcYC6MMnI
 6sIkvteiVzp58lzDEBBYv2dLtx6RuWITenArztZsG8Y5Rc0tPdbtRB3gNbtyoozgbikdeyirnyXJg
 czP1+JhNkcDntOTcTu0Iuxh1F6AcHtFasZS0RZQtOMbFiqd0NTwkPfIMdl2lFZeTScMU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=l3ETtChK9C5rucvzj8woY+NrxEGG75Rei2lzUSyMVWg=; b=M
 71CWP2uO9OQACXiGUBvg72IM0suxwq0xLm5ovLAvufpmz7ElvfD4RH0zlr47U5ZddeC7dZMBfShsq
 xQRQBlu0QCw+EkcIgW5s6HwoP5YZlKq9o6Ww6m9oM0EKxkdIC8uqwgaNI7YlrKh+qFFl6sV6LYHZm
 nFr6EjIjBXUtrXSc=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xB5z6-0005IP-2k for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 07:41:12 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f63546c3so2131273f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 00:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790581265; x=1791186065; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l3ETtChK9C5rucvzj8woY+NrxEGG75Rei2lzUSyMVWg=;
 b=WHx3aLCvGPNUb8UbDGjpr5sIvrF7yITqcLvHWnC0NqgjWTXPnqxa2wrXAxHv1sPhko
 f6dMQhTtNloWy4PclvNFiN0mTIxCBr1ocK8E7hqUbZoCZcje/MDY/gGcLAWalW7R0ncy
 j8E7EbnCyrPwlzjhAipfiLxXNdWT0Cjvyzxer52AP+iH/hS5SWaEw3mSXmPzRDUd+cog
 0Dd4t43oyh/YbnOQgbjwzpJ9nq54uUT0sPDUAL6sQ/fAwufK4qiTxA49AADkzen/8OE8
 r2VkQH5fq/+/08PxtN46ZQ1mxVCeOdwGvaNJQclGbs3t+6CzGCzIOLTDQXgaMyc7CZ8k
 0rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790581265; x=1791186065;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=l3ETtChK9C5rucvzj8woY+NrxEGG75Rei2lzUSyMVWg=;
 b=ee8jTy1939UMz3x0X8DAXEVNb8v8DEUpZclyWjMwoWh0q12GbgX+mKGdirnoaLtrUj
 VchdDIp66zQBLjWAmnKqMiRJD4cdiQ4c5w7XcQzfn46M9GtTaQQurMQntFD/axprmuOl
 s0pEgVCeDBjnGWy90hn+f316lJeewBAr8NUuu9FMe5Ta0vBnOq0JQAEPfZPXY2fRvgHP
 WhBg1q8Mt0vjXUXCzeHgbu5UyiKv6qCL/E4CHKJHF1+vLA8uQ0HmMu6sPFNidnKkbJNu
 IQZ+J6CooXUNjCUyVbBu94dCoGruQIO1BQT5UZyKFtcJnUofgLZGhrfptJ6dHuBhqPAo
 zsFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMH79UB09m2vA3fqtC7dMwi9NzJMDD0CMU/Ytel1xmaWvxiKO7yiusNtMvsdeDq7ZWdbSUfTf+suCTXsxb@lists.sourceforge.net
X-Gm-Message-State: AFuF++n8Ru5lvV+WTZbPPjnL6LePisz1raT7qoJp1hzbp7AXGzYJTFxH
 BFvPN2apQ2b6DP+NhaA8odM8IlkXSpi965aZKkJ0nAhv2SEcnyMaxumOD1DIbuedPPZf8OR2CPV
 +gvV1bJZi222O7Y6a8yVzHS0lmD2P2qD0isYx2nf1inc3MRQ6873iVl81Z5tq8HULDQsp
X-Gm-Gg: AYBFou2jmB1VTSZjEl5RBFfvpPnqWPmkRt8Lyk2x+mpyrd4GU7NBAlfcU6NHYz4fYOy
 ZUSB0j8hkCW8ov56XNTdBwhpBUqbjwM0HRfqyz2M5s4ec6O9lh3HEMdfG/ezK1SEO82DCo5t1i+
 M0sTdJGQG6aogRNsy6HSoDL4ocnVCGNS3JOND9AFyqpmGPyNwR1Ik5SI1yldiUJMIvNB6r54YGz
 GIK1mO8xMXiRZ0lRdy7QhflppFit2ybMuVwU1YDKEvG+BeTOCQbMNZVSHMm1uSbr9ywgvCytxe7
 Crax/mUaSLV86RhF24ykvs7VFHatphKmMx3JTmXIzdGPmxHqqLCDZ8BNk/M4/xvBh/eIbEofuvI
 O+EIq9idrdT5QZAuNc8jTuVfzbgGAsZ36B0WzYLVADFvJf9SOA7jAfVuCOS9JIHtVBb8bnTAv9M
 /VibSCUPQjE8FW/rvyhUMuhTjYJP1A1mq7G5ezCXk8tgmhCa7+JC27H6DQw1/ae/Sw9qYJahh6E
 AH9lh5qQxa+ONnxL/toRjiBQ/5OVxbUj8ZXYjIeecVOSMXZuuGUErdFi+aZ1hKXXCTsrFDAzKLg
 7AOf6Ujb7von+nAGKWb+R0ZAdqxhmgIDYhyhXXzwnNb0/vvYMgC3JenmTrt/IA==
X-Received: by 2002:a05:600c:1912:b0:49c:fc6e:8cb1 with SMTP id
 5b1f17b1804b1-49fe66d811dmr208339085e9.21.1790581265295; 
 Mon, 28 Sep 2026 00:41:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f1375sm109602505e9.8.2026.09.28.00.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 00:41:04 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 07:41:03 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: 90dac0ff74b5023b593c7903d89f7c9210fbd403
X-Gerrit-Comment-Date: Mon, 28 Sep 2026 07:41:03 +0000
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b42aee7ecbf8d5b2577b32bfe973774d2e3a8995-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xB5z6-0005IP-2k
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: add unit
 tests for route.c
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
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3898274241831122127=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3898274241831122127==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A/Gm9+g3dco="; charset=UTF-8

--A/Gm9+g3dco=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

chugly has pos=
ted comments on this change by chugly=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1946?usp=3Demail )

Change subject: tests: add unit tests for rou=
te=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 3:

(1 comment)

File CMakeLists=2Etxt:

http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1946/comment/15ae40d6_e06c28ec?usp=3Demail :
PS3, Line 912: =
    target_sources(test_socket PRIVATE
Done in PS3, though not quite the wa=
y test_misc does it=2E test_networking is not a cmocka driver: it has a mai=
n() that dispatches on argv and t_net=2Esh drives it by test number, so the=
re is no CMUnitTest list to add to=2E The route tests are a numbered case i=
nstead, case 9, which runs cmocka_run_group_tests=2E

t_net=2Esh runs the c=
ases above LAST_AUTO_TEST after it has torn down its dummy interface, so bu=
mping LAST_TEST to 9 gets them run there without needing an interface or an=
y particular network state=2E They still run on their own, networking_testd=
river 9, since they need no privileges=2E

This also drops the separate gat=
ing Razvan asked for on PS1, because networking_testdriver is already restr=
icted to HAVE_SITNL and to Linux in CMake=2E



-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
Gerrit=
-Change-Number: 1946
Gerrit-PatchSet: 3
Gerrit-Owner: chugly <charlie=2Evig=
ue@openvpn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: razvanc <razvanc@=
mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Comment-Date: Mon, 28 Sep 2026 07:41:03 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: No

--A/Gm9+g3dco=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>chugly has posted comme=
nts on this change by chugly=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1946?usp=3Demail">View Change</a></p><p>1 comment:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"=
><p>File CMakeLists=2Etxt:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946/comment/15ae40=
d6_e06c28ec?usp=3Demail">Patch Set #3, Line 912:</a> <code style=3D"font-fa=
mily:monospace,monospace">    target_sources(test_socket PRIVATE</code></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Done in PS3, though not quite the way test_misc does it=2E test_networking=
 is not a cmocka driver: it has a main() that dispatches on argv and t_net=
=2Esh drives it by test number, so there is no CMUnitTest list to add to=2E=
 The route tests are a numbered case instead, case 9, which runs cmocka_run=
_group_tests=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">t_net=2Esh runs the cases above LAST_AUTO_TEST after it=
 has torn down its dummy interface, so bumping LAST_TEST to 9 gets them run=
 there without needing an interface or any particular network state=2E They=
 still run on their own, networking_testdriver 9, since they need no privil=
eges=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">This also drops the separate gating Razvan asked for on PS1, be=
cause networking_testdriver is already restricted to HAVE_SITNL and to Linu=
x in CMake=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">change 1946</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9085c55a7efefd318=
39b00ec8ec9a6f085574dde </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1946 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: chugly &lt;charlie=2Evigue@openvp=
n=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Mon, 28 Sep 2026 07:41:03 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: No </div>

</body></html>
--A/Gm9+g3dco=--


--===============3898274241831122127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3898274241831122127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3898274241831122127==--

