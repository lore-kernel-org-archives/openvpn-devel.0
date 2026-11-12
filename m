Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6544606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QsORzO6a;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=A8wFT01O;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cwULp/Dd;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MKcM/oGI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eVzZHOv4qLBM0QdrZdWJd7c3cxHK/OzJdhZrA76YwoU=; b=QsORzO6aScoVHGCyiBetCC4tys
	a8f1tQ49UROvg7G8Z+APfE25JaGT8bgo03Gw98Vr0Dbz6hqIEeeAVahmEcUq33s4YImrwjooAeIVp
	SvpMILie3W6w9nUBlGOnWe0DlL5j5Fd/uXB8Cwsxsa4F55N4ZvQylmXbtAI+Uz00J1LQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRMT5-000000002oi-0Z99;
	Thu, 12 Nov 2026 04:31:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRMT3-000000002ob-3itJ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 04:31:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/OAOA7RQ3/ugjHxwFAtWGhs9Qg4XjQiyc5u9AeinIA8=; b=A8wFT01OUJ4hKC7IdbmoxDbF3T
 IrP9dUTpDih4Fo6OPRXvGArQ6AMAmrEieoBIMv7fEs9Z4Ml17AGF+5hm6/UZcklCp4+9344k103rd
 O3+88BqdKhEPnLWPQNIIWvT+DVEX2yLvVU1lY9fg/5BtJQuhWfG6zj2GedTrXzMHG+68=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/OAOA7RQ3/ugjHxwFAtWGhs9Qg4XjQiyc5u9AeinIA8=; b=cwULp/Dd95aB77tBcJPkaJJeuz
 ebYwnfTUelU1Hkv4VI6dCfkVFjAOPEiTSg2UDiqRfRZMnJE7Y5xOUW5DfA7IN6rJsFkyLKSnPEeES
 R0WjIkHJhMnmVXFSncUeI/zWXxw5bq3o0MOSTtfa52JmsoJIksvK20rrlGjQJBEYlgSw=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRMT3-000000003Jk-1HYt for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 04:31:21 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so2281203f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 20:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794457875; x=1795062675; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/OAOA7RQ3/ugjHxwFAtWGhs9Qg4XjQiyc5u9AeinIA8=;
 b=MKcM/oGIKb/mC3sttoLrpEp/UlxTVtoy9WqBc0winKC4HL6Isqa/4Bo0N8UWKPc1AO
 41JjaxhAis6hS3ry88fj8XFX+xPAdmL129P8wDxaTASMHlynzI/WG4tWrcqvwHdeI99x
 IwMIPaygQWCfu3jlP/worQLCTDhYPKTSACs8d2hBmrcXRFqPle5qcm6oSJGe74T9++Ox
 iDjrVlCeLwI13tutDj5IAOx9Cdj0zpqBQyz0pb11xgVCwsJ26w+XJNWLobYeTM9lYaUL
 r9H6FYJq9WLq6YdQKghtrb4PZWHnmccCF8WYihwuStggFKnE+8AJZBgtxDafNpk4yBK/
 Lzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794457875; x=1795062675;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/OAOA7RQ3/ugjHxwFAtWGhs9Qg4XjQiyc5u9AeinIA8=;
 b=l5pDoU6W58Uznd4i9iDi27Zvd8c8S3GyEh3A5fyVeeP4iaXOlwkFs8SGtroaAh1HBC
 BE3MBpHncWi6CQ9mqs1pYBgyVWi2Zy6LUwbUfyi+bWH2utbyR5U/TxCDOG3hqWfQOAfw
 3RK5GS2qJFGlyntGPWHlWwM47CVSnTkOtvRcT0P9KN2mGOsAahmapTDhs4yDhoyAJU4D
 iHE5CcfLVleqbaLZpStNYlb9XTP4nWLlgpJC6cl6ntO/J1JQYbj4hUkpEBE6XMEFtzUF
 vB/tczAUVdEyo/ifE9MG43OKVyHFTb8piyRpjaXy/Ckzhg21a2XdKuRVIbYTBmvRlPg+
 OfxA==
X-Forwarded-Encrypted: i=1;
 AL+hErHAW52m/+K+1HWJ4+0WAz2MZzl2f01QL1n0d3N6ZzMi0gOw4s2iq+7N58Sdu5E7Dv/J5jWx11tYK2B2RGLP@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8PV+MZA1tLx16qSWnqZz5aCdtGpou+AfrDEBGaIvf48u4RL918
 DxmY2EmWOEHBsFMI9b1JnSeDxxClWAmdPk7JytLxGSQa2AJ5b8RUfd9+hTcyp/HNowQes+Gioot
 DCNo1oiitXduy3Vu2pvVrS9QqfvLTpsEekNtGGRnOoPjb7cCUyjcnADZ/QqGM2/6lsHXs
X-Gm-Gg: AYBFou2pZOXa37rK7LtG8Nk2Bi/gyZLlyVKAWc+mxAvNtLQylLEu82Agbts7vZCMOjF
 vbupVHjkEHuOx2BA+WmXDwiVbXVQgmxUWSwpZEktNsb1ZqBFpo9zMjkj+fBK7PoxcswcrkeyqC/
 VSZIxrzEaDDMtGqyG8LNHycHcMBcw3c87bE1q1q8q5KdnIAFi5eYR7Dcfjzlt4i53JJoE0AM515
 DpCTH3FrMSdCG21ZxdRyzlcyxsTyuKMhRUuVkummIzLfUrMoSQ07I335WVeGbDMoSX0z0nqIAmQ
 2a/+OmVGNU8Rb30GzDoxjKtvzbrKeWnqMznO+mSNJQWhRF7xcqf7siA57eYWamiESpAOC2x4L8w
 jeq3ayZe9z+eM37r+E4iWkqZKFxRxWo3+5qLpOycHckXjNBmzddL1w8hlDvQYrDV/neW6FiSyaY
 MdPFDlodLZ4pyJ1Jtjk/kMPv1QQcc/IbwGmcbNsb9BVUXx8FAnFjE+erPGjGfcowK+G23q1M3nE
 T5+RAovWxKKBMJkCzEK2ZwzhSe/YWbwZoeIxYbX7F6eZSZyMursHtHo45QSJ8MMjjnf3TFY/jHI
 NGSFllxpepoyq3KUh7Ide5X9s2ads/xsd5CU1ECpQDcqGxDybsfmrdq3/qBSJ65dM/A0/CwwKr1
 RAy9ul7zXT/zUJmbzSnKEojNG7ElC07YnQqrC0DuK77joaBr79pNEetmDBzJbfTTooVB54Bk4Qh
 E8P9daVExzWN9rkN0=
X-Received: by 2002:a05:6000:4013:b0:48e:d27:bef2 with SMTP id
 ffacd0b85a97d-499c77414eemr6644701f8f.21.1794457874626; 
 Wed, 11 Nov 2026 20:31:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c2793sm14051296f8f.45.2026.11.11.20.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 20:31:14 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 04:31:12 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4
X-Gerrit-Change-Number: 2161
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2161?usp=email>
X-Gerrit-Commit: 193f1deedeb81851852f64a578c1e8518fd05343
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 04:31:12 +0000
In-Reply-To: <gerrit.1794301782000.I7ffae4da3b29521844a31d234fe6a9dd08954cf4@gerrit.openvpn.net>
References: <gerrit.1794301782000.I7ffae4da3b29521844a31d234fe6a9dd08954cf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAxNzgyMDAwLkk3ZmZhZTRkYTNiMjk1MjE4NDRhMzFkMjM0ZmU2YTlkZDA4OTU0Y2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9619b1dacdf437f478350dac19c2c0e96f3e5831-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRMT3-000000003Jk-1HYt
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: only
 remove search domains that were added
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8827283827125829265=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8827283827125829265==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uHnYcyv8d9Q="; charset=UTF-8

--uHnYcyv8d9Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Heiko Hund has posted comments on this change by R=C4=83zvan Cojocaru=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3Demail )

Change sub=
ject: openvpnserv: only remove search domains that were added
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7ffae4da3b2952=
1844a31d234fe6a9dd08954cf4
Gerrit-Change-Number: 2161
Gerrit-PatchSet: 2
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
ntonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko Hund <heiko@ist=2Eeigentl=
ich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-At=
tention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu=
, 12 Nov 2026 04:31:12 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--uHnYcyv8d9Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Heiko H=
und has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Pat=
ch set 2:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3Demail">Vi=
ew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3De=
mail">change 2161</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2161?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2161 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 12 Nov 2026 04=
:31:12 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></ht=
ml>
--uHnYcyv8d9Q=--


--===============8827283827125829265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8827283827125829265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8827283827125829265==--

