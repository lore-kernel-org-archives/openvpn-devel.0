Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A89C9830D
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 14:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uX7QVN7A1hqn7yd08IyuT/niBUUlpati2FJAT5xWeKA=; b=CZg2m+Oz95IsuaG7S0/0cp/Bjs
	KOGaXZaQY9mQSHkPqW1VLFKmmuQFWMN9/5SGrGPwcXEjWQvcm58ly22UL0entcb9D7YvT40IRr52j
	QRcWyu7I3QqUaCuk8JRwVoGY4h0SLFjUU90I53Phnm1sRM8Hu3ycImpN/T+fui0CroFw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA6YT-0007Xx-Ur;
	Fri, 25 Sep 2026 14:05:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA6YR-0007Xn-Hf
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 14:05:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=q/fnDgGWVxNhX0RD6jxw8xF4Fi2aKVFdLzdg2/LwtOM=; b=AIWSwpKCOmTy3xQ8qGP5U3l7DY
 5yChYsXt5xudDl+4st68wetSyha3iJc9dEJF4ux/YOPzsQN915DfNaNwpfK0f6u4xrYb7+bcJ/1xA
 v2LYKGjPIgs0nZBMbmvjsAW9Z3HpxmukjZBn4hn7TDs+RN6YnOBTOTWPTF+G2K/8fqv8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=q/fnDgGWVxNhX0RD6jxw8xF4Fi2aKVFdLzdg2/LwtOM=; b=T
 v8WdAB6M7peWw84hTQY4Gyv58XlpxIK0P4a+WVfCPXBoTSdP/iF1l1GOkofj1PKbvEXgXpBIscXbB
 CpY8zzaDh5mr6H04+ed3lVqWa9SKSTOmu0fYzc4R8vBRBVmIukpBsdBP7a9CkEUGx6K+CgCrGGQJ7
 TyExgXEiy12SezTE=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA6YN-0008OU-G4 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 14:05:33 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so5450115e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 07:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790345125; x=1790949925; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q/fnDgGWVxNhX0RD6jxw8xF4Fi2aKVFdLzdg2/LwtOM=;
 b=Sl6FGF30ExDEf9snjk7XRNrw6LZCKlY4FR/mbM+Xw1EP3PeYih2bZR/EU7TDtyjOuO
 28KEYNTi7ItKWbxPpRKvk57OZAQKgdeDDMWYzqVGPhUjbhuaTpSDT8x7qwohtupeceZW
 +5jFQXpceh7kkpWpH1r4AxTjdlSXOodjw+uV85FGVffVLQQtx4Fobz+pRmhnsKRu8/WY
 uuVNq0uqVT7LRVRdxdVGGUOqXDQl27Uj1nK18rcdoYML/NfGnGUJg8RhXAZECHXG7sDQ
 gdyOy7iT6ds7qXyRpj6nTIzgQyAnTeunfUoWnhNekM4iHNtnLXiGHBvRwL+aV2fkBu/h
 K68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790345125; x=1790949925;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=q/fnDgGWVxNhX0RD6jxw8xF4Fi2aKVFdLzdg2/LwtOM=;
 b=DRwwlxFBx+ernDOCdufnhs2CTSwFgdXvNc+/25ijTOZZXk4pvwotqAdpNEe2iBdK/h
 LgrlZMaf5fNRV/bR3QB6vj6Zkeedl3OABEmgOWgKLQjtOEhbvqL4ZJaSr9sRh5wEvvOm
 GtXucH4KSIfqXKqNyVbEIJVxvynlac019M4aW6nzTJnNi3OM1QEc7Vj9aOXgj9zgyscA
 UbH8wgLlKm5ipI9CR4uUWMPrflKbgjKICt/93I9V1vw23OoibBwPbtKO1+uSpe966cws
 xT1RRvwmTFXy2riBR9hs2AE2o+7ZaHF8+itj3TKHpuAcID4fUjZTXTNpn+CwMK6KQDGK
 I8EA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwl/mSWquoJfp+jjFcaCGk0dQ5PgaCVu+m4PrqSR+nJeZc4sg8aiK62oqy5vkRsdGPfpqTrrs6xasdUkmpf@lists.sourceforge.net
X-Gm-Message-State: AFuF++nWlMBUKa7iNt5bWd57cCJDbkxTRc2U2zpLEAHY1Z1OkgftX2G1
 TyWK0aUxUDA7iGUFdQhlpJOfbkz/hvRsKEN2z8BK4BVtE5JbUAQlrEc+AUedGhgQbaGUOu9/Gsk
 Wml4MNvIbLjmcv0/PJTH8/O/pXmxIjeg1uOe79gHXKH1exNSSWAT8/sn3bhHlIBtnS1/Y
X-Gm-Gg: AYBFou1knZX2TTAyDCjBY4NIUrZZiR6QS2MTw7Sa72bXyiwfX8vvOkOlGh0k4EGPR+E
 gFTNBiiTO31ipUxvtIfDlU5j/JWn8ke3t/56aW9De0Z6iLbStm5bguOaO61oV42N7crPtPkd/6E
 rL67bpr0Cc5sOOZr2Beyulb7PmZALItt0WoQz4hPBs3pGk41pD8e2w6egHUan6pCJbmSM9PtsCz
 Lnm7EYkavUfEjQnaLww4SDZoIlrlsRMeeRvW6Pf0KDsxmtiXBlr5Gkt2AJs8OXBlwwZuTKvkGmm
 BIuScEUH+5m67OMstSfFGZ845pBC4abhar0qvcdOvQjimsrmyfqKD28tDO5RKTa0Ky6FF8nZmaS
 7BULSgesqMGOsipQ3iOa/38NYMbb9SUDlQBWnn8yMVOIXUqCMWbl3n/h66AmIBjedmB9nACc7fx
 DpcG1gzd18qAACPHznSrpSzp2NlHsHppPlONFaPrKUaiovDQ0QhCiDyNi4LewJ1gOMmlkG3vFvX
 F6jjO9WGeSRzF4VTQjidiEPESa7QlqzfaJOy1ik9bqx7NnuIxWCdRyz9ZeKx3vrhGB1RW+npOTS
 6PGHNpR1EQthGzxTDqZDuBl/LCLp8LMU6rv078l3Vkb3airMqFwKc5AnNujA
X-Received: by 2002:a05:600c:348a:b0:49a:a101:4157 with SMTP id
 5b1f17b1804b1-49ff06b2c58mr40913715e9.7.1790345124395; 
 Fri, 25 Sep 2026 07:05:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a355826sm7621955f8f.18.2026.09.25.07.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 07:05:23 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 14:05:22 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de
X-Gerrit-Change-Number: 1952
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1952?usp=email>
X-Gerrit-Commit: 5655c770a96630ceb381007087759de61afc87ae
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 14:05:22 +0000
In-Reply-To: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
References: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzQ0MzM2MDAwLkljNTM1YmIxZjBkYTE3MzlmODdlOWQ2YmVmNmZkMTA2MTI0N2IwNWRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b39bc99b43854508bc196b94037b14301ee561e1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA6YN-0008OU-G4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: stop fetching
 peer stats during client disconnect
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
Content-Type: multipart/mixed; boundary="===============3544328469986900280=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3544328469986900280==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4cPpo5oxGgA="; charset=UTF-8

--4cPpo5oxGgA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

ordex has po=
sted comments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1952?usp=3Demail )

Change subject: dco: stop fetching peer s=
tats during client disconnect
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-2

(1 comment)

File src/openvpn=
/multi=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952/comment/5e6f506=
9_77e37c9b?usp=3Demail :
PS1, Line 506: multi_client_disconnect_setenv(stru=
ct multi_context *m, struct multi_instance *mi)
you should remove *m from t=
he param list too=2E Also check the caller to see if this param con go ther=
e too=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
52?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic535bb1f0=
da1739f87e9d6bef6fd1061247b05de
Gerrit-Change-Number: 1952
Gerrit-PatchSet:=
 1
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: ordex <a=
ntonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 25 Sep 2026 14:05:2=
2 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--4cPpo5oxGgA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>ordex has posted comm=
ents on this change by ralf_lici=2E</p><p>Patch set 1:<span style=3D"border=
-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background=
-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1952?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952/c=
omment/5e6f5069_77e37c9b?usp=3Demail">Patch Set #1, Line 506:</a> <code sty=
le=3D"font-family:monospace,monospace">multi_client_disconnect_setenv(struc=
t multi_context *m, struct multi_instance *mi)</code></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">you should remove=
 *m from the param list too=2E Also check the caller to see if this param c=
on go there too=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail">change 1952</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic535bb1f0da1=
739f87e9d6bef6fd1061247b05de </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1952 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a=
ntonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Fri, 25 Sep 2026 14:05:22 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--4cPpo5oxGgA=--


--===============3544328469986900280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3544328469986900280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3544328469986900280==--

