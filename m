Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7C3C98321
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 12:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2KViNNJIUefiITO124ZJ0ouqzOvM4qffRz/JVw2/Ras=; b=KqVccbwigaNamxZZzoNloWg+t1
	bOayfHsg/MvnsHr2f1e4TjxLELsITjgGtXs7aN/vtUkYVwgEi2E7eEW+OBMll0B1N/J7/NoTVEytU
	QjQ+Jc/R//6IWj3nLTpEtinAawAUuHFuvHxNbC98AZLa34ZqAJulB6W6l/C4AaO/hc9U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA5Ez-0005JL-NQ;
	Fri, 25 Sep 2026 12:41:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA5Ey-0005JE-EA
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 12:41:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1+04xn4aB9jia4D1iPYNBtBFZnXJgRGl2ePXy9ozpVw=; b=RzZAv1Q1JVdgB/f3g0QxELb8Li
 OAUlR9w7zU4lk3Ijq1pvpetEbpki5p4CQV7FK9auK0xxjdfXR3k6/H76xXHHIu2BpcB7IA0gp+XXE
 PQf1+yPatfw7p2W/DGwRBgYvy/eBsO3Ag5Qc8Vq9Agc7PpVlDmIJT5gdsJz+8NI55YYI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1+04xn4aB9jia4D1iPYNBtBFZnXJgRGl2ePXy9ozpVw=; b=g
 nq9BBksPPUF/tOgnTOjNYTIFJHBUm8i7ADBQ8qhBlwn/ybvUQO27SEVvMYNZs1Ny7DDLIh5L4I0xs
 X0WzjWLo2jlaET9U7Fi9zAuubqfPpg0g09QnFtBrtgirCsqBjtwmWNlrRIlRFmDGEIfwY75aVyJ1F
 PEDV7ow2PdKLCFJc=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA5Ex-0005LN-Qd for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 12:41:25 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843f22dcb8so661280f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 05:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790340077; x=1790944877; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1+04xn4aB9jia4D1iPYNBtBFZnXJgRGl2ePXy9ozpVw=;
 b=YKrLVNGD6TJi9KrI3ULDhjEGTAIRceNg9LIIrdzYhWLMJv6TPYoF4Rvtb2nssd3qFI
 yi3ZF/v6iBaT/l14SJN6/ku9a0v1vKFQu0VumRxn3xSX3LgY6KkyP/fbAu26Di3kA2V9
 WhJma7bmXreey7dOa9lBmgh60Gtss05fTRdkreGuBLwFoi1FP8QqvFgE3WKTusb7jMrG
 S8k8PAopPgrkLMM6YYOC5TQGYMZ50WQYrLKE8kE3PWQ3gQ+qcFEIHrrFdcwH86GWQ49g
 wjQ1G2Iw04AR3hVUetPcxBTRsh77CLFd58QxbUTx6ol8ywEteYYZzarYshTrca7uqNB9
 cdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790340077; x=1790944877;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1+04xn4aB9jia4D1iPYNBtBFZnXJgRGl2ePXy9ozpVw=;
 b=WG5fq/i3odsb4IVO2nmlIJow1v3ADFrd4hDhx/HLnlCEX9IYl36sUWWto6s7qyVegX
 hf8qaD6r2oZzgHVulgmqfYq498Pb9gBIlUDA7hDjdR+mlRFysGgHNzXSb0oEiQVwUGWo
 /AEzUzqHJeW7Rk5so1mT7uvq7bdAzf1nWuuCdo+GC+oViXL55M4BOwVzKR+HIhP9znPA
 TjLsSRGvW2jutAYqg2yFMuHYd2mGtXqn/SYTc6SGNeW4eD3QHbdWuJUz2+TvtGH3ZAen
 MCsVMyNcWxFxxbBuSSnlitoK5m+Cah9iD1zesANgKyy7ML+LvQg5NoCnQW4txA90jRBJ
 M/6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3xvR05H/KGP/BlsYg+XYyLG2ooYgP0iW/pyrFKt0rBNm5oi/XW7a0NFNZrIFnxw44O75hOOB4/SX3O974@lists.sourceforge.net
X-Gm-Message-State: AFuF++n3Modxu1U6jkVstswKEh1cCWgPYbTA2ulX5GSRS92mOE8bQRuX
 lSeLHO4OZ6ZmhfTglnnfnqU7yDrH6liQxMtUjqRcJoV+FoPIz4d6syFS3FqQaeogUZfU4cii4+5
 Ho9k4qVlGYq7GoqQaNO7SwbMelvzM+ZZqJwTftGaa5JM0h0jNLB/VMOXnJmQNgxPtLMtz/Byfj7
 nzW/njkQ==
X-Gm-Gg: AYBFou3UrBFBxJ1kYY/uZQVNO1Ctk5bY5ZY4cJOIfPaJWXU609DunLMLFHM1vSRPWMJ
 GNNw1yYGH5OelVVZfIkituxnCDBE8P9QBxRUb/IREuOt4KeJmiEIFZUfx/hejHE6/nrNttOWE8P
 xgSN3/df+Q5p8WgvXxWb0YbohiSJVMp7f4BCsq+6u2s69DSk6WqBa+v3q+O73YBV7PieQ36VkdP
 lRqE8DiX0kpwaoMN8sXeTUUrGsaWldoAZm97KyCOZdDKRE/L4d0JNTTQp9fN0pcN4uWF9+g9FPS
 ZZCcyLvtIr887kZodCZSBtJBpCG8+ou92lCqnn5YylajxyE4O5U99asqQQun4FEvmNrF+levUg8
 ubYoqAUVUFvs36jLFg0PXOkQJwRVWr5Ws0lylU5It/NOdv4cTZ0kH74liA7ThyLx5PP1/LST3ik
 uKFDZPUIIzhEFbvlFKNRh12g92SAh7CenKnZlC7gf1yLDnghMBis4SibQtmRvnBPqbiUTPnncBR
 7VMrGMJuenqUITsHzDcdf4UKiuwy7zudJ5LbDzuRYoEREQ2iOdlFbbAjvhKOK7QktVljpHI8QA6
 ZVKMr1cowjK2koDqPhb1wt4JUdsg310/BUuf4nGhffd9sU/Lobh292B2AYGD
X-Received: by 2002:a05:600c:4e53:b0:49f:d58f:1f8b with SMTP id
 5b1f17b1804b1-49fe66d807bmr94684665e9.18.1790340077073; 
 Fri, 25 Sep 2026 05:41:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd4c8dsm167334485e9.3.2026.09.25.05.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 05:41:16 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 12:41:14 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id999691f74d291f4b902b8ca224a12d9bc7e6046
X-Gerrit-Change-Number: 1951
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1951?usp=email>
X-Gerrit-Commit: e93012164d7ab0476efc41aa8bfe034b40bbdb7c
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 12:41:14 +0000
In-Reply-To: <gerrit.1790339862000.Id999691f74d291f4b902b8ca224a12d9bc7e6046@gerrit.openvpn.net>
References: <gerrit.1790339862000.Id999691f74d291f4b902b8ca224a12d9bc7e6046@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzM5ODYyMDAwLklkOTk5NjkxZjc0ZDI5MWY0YjkwMmI4Y2EyMjRhMTJkOWJjN2U2MDQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3b30a0e58c3570e1190280d62c84df7c2b833ca8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA5Ex-0005LN-Qd
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: multi: make
 multi_add_mbuf static
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2107260749610552884=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2107260749610552884==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vuIyGndXJYY="; charset=UTF-8

--vuIyGndXJYY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

razvanc has post=
ed comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1951?usp=3Demail )

Change subject: multi: make multi_add_mbuf stat=
ic
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1951?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id=
999691f74d291f4b902b8ca224a12d9bc7e6046
Gerrit-Change-Number: 1951
Gerrit-P=
atchSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mai=
lbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 25 Sep 2026 1=
2:41:14 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--vuIyGndXJYY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>razvanc has posted commen=
ts on this change by ordex=2E</p><p>Patch set 1:<span style=3D"border-radiu=
s: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-color=
: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1951?usp=3Demail">View Change</a></p><ul style=3D"list-s=
tyle: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1951?usp=3Demail">change 1951</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1951?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Id999691f74d291f4b902b=
8ca224a12d9bc7e6046 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1951 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Fri, 25 Sep 2026 12:41:14 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> G=
errit-Has-Labels: Yes </div>

</body></html>
--vuIyGndXJYY=--


--===============2107260749610552884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2107260749610552884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2107260749610552884==--

