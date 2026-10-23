Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE37606A31F
	for <openvpn-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Sf2gLHE8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kd3ZVmUY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZZX9V8vH;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JBaehH61
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=u6g8i1RBH3pArVqc7mHbOzzf9lvb4twqiHG2EOb+ywE=; b=Sf2gLHE84Ty8tKlqf4Qtp4yXPw
	zvE9bprbUdRNkfrKZdixTcml1+Auvhn71XZ32c299o0uxuh1ohGevIHAgdRpopSDND+md39LLCs3W
	SAn4ZsROV8HskLkNGE2lp1/WBYaptnCjLQ1PhO9MDQOdU5gnNhzmuu51BmOvE3Bddp1o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xKKv1-000000003EX-41MR;
	Fri, 23 Oct 2026 19:27:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xKKv0-000000003ER-2hra
 for openvpn-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 19:27:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7DCBHAP9Lq2e8XF7jyg4/gpy0br8DgK3KmRtT/fUo8o=; b=kd3ZVmUYT3Bnl4XRZLrSn4Xx5E
 LNdWD16AkWWN3GTvvRTV+J7fdDTFrcrJ8X+IRw4aKxQhqLBHFmnB0lisahk/3i0YoZP30QloSRIRY
 a9yZo7+2bNb5k9Bj/azpUbZIwenDL2oKo+Zg+pITXM6RcpJtWdodKsDW/FuVhx7iWpig=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7DCBHAP9Lq2e8XF7jyg4/gpy0br8DgK3KmRtT/fUo8o=; b=ZZX9V8vHKuq4vloPoUrE1m7G1h
 Ri3Ijagz0jwL0zElwPvQdEefjmuhJTqwSs0HG4joeGpImxqV6twX0ffuZveiGZKl68jG5q5VI8RYo
 dG4cQhTxsblrZfVNHhorjsqZGPN3bdWi39AhnD6DWG1AMMSFIHYUfHauZzAIOH69o2HE=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xKKuz-000000002Ei-3yVs for openvpn-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 19:27:10 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so812559f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 23 Oct 2026 12:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792783623; x=1793388423; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7DCBHAP9Lq2e8XF7jyg4/gpy0br8DgK3KmRtT/fUo8o=;
 b=JBaehH61nBJ8PwH4YS7OMhS9ioQemQPwmGMIk24B4WlnwSFfVBVAItbTHr/sIsXfdd
 4D3+IjHzKv/Go0n/5247yoGuuJDFy+HnyEp/M2lKrTkMjo1HFtr4V4ogYo5DkJvkvRNY
 TtOQTyo+ugWcvVNYS0kDgN+jpg0u5Yk/p+8vTmTdBKznF6JXQiCSRp9aRLBZlIHaJsBL
 +t00KdnLMrK/akx+LYzASkhIDzG1aldWNsTIjpkKuQxBQCZjw1ckHAtE25aVr8sKBDf+
 Wz/zXhnwaPWD/8Wz6I9UPkuBcw9d44RRBK1M6qEoMlREYOSBOU2XzuYPDEyQ9Rom0tbd
 r3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792783623; x=1793388423;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7DCBHAP9Lq2e8XF7jyg4/gpy0br8DgK3KmRtT/fUo8o=;
 b=jsFHTJwBY9PsRj8gg1gSKjtOdrq+Hs6mJicuUUKJIHJ0BEsZXDexIFd89AY4cWunVb
 7MBVFCwMSrvcjBgBS6h8c0OEBYxpEztoiC2Ahau2Oo67WyhuG8nLRW76yocHnhHi+9r4
 UjkQMd1YRcxlE9XaIHOZg7q2yTSIGMZTpmWN749f22SToKrpwyVSl3H3quTHRqXHzo59
 BrWqmlyfPHa/0O/SMtXRmonU3s2TdUrvF3mlUJRDiD/+mYdnThRzNzhLKMHl6iBcDF3q
 7J1Z3LOKfQZQq1WgOBMamLmdi6YWvOxPNDDMy+QoP52YzLy3w/sLe3eqWiAoTTE0Fvwb
 TKDw==
X-Forwarded-Encrypted: i=1;
 AKwUvByvs04FunqEq1kn6oHoLX3QUWZzIj/V4MX++WzK1ZVHk2XFa7yGOnndMKmXiYRRv4wgRRJMyHv0O1D+FSX5@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLgoqQYGlSaJ1MaxM3uY+60Ir63NYzLYKW/fmJrKrM8x9UY7Yi4
 q8L5Ijs4v1SNO+AzE598+dSVf628lCxizKN/fjYX1c7SMB5a9gQ3SwyYXY0qZhPBQSeLcVTQNly
 MqLr/zlAf5FkfVxn4qhhQxRbnQxMiLaA0/QjbQRqDHURavSyk+OtQOmW+F8JMk+vlKtLO
X-Gm-Gg: AYBFou1vBsqrQspaXnQWo9Ncd+29VgCN+iHEq3ym+kWh4h7RVp5OBQn2E6loewNXs94
 0SQci0OW9HqG5V/+o1pjUy6vcGEZxDF9HIDwDglysDI7E7T6Z09XWMlNE7KzJz1LlriqrALB7W5
 07CxbpLqb2yxsvj9I3/H/HXai4bHIKZpD4IS2/AyU4u+899CfgXEjBauRsOKy7eoILaF3vCYQl0
 WVCARlVJkjbtEm1r9fRE3VTwOk9NicP4XxJ5jxXGUNZKzPNJ52nbjNi+j/oVQ3QTxLpRQUI+inA
 X8xqUgE/aK8VHFL4r4irZ35C4KJBDrl9ZJl5vwrtxuoZ52gS8PI8/3aFcbCQ1pURM1PSiKqYsA0
 5Ognq9IeB/2QRPwtRmxAjEjLU/0J8Yrgg879g34AdOlOiZCwpw/B1ePrB/eECpseStTmhqr0coq
 4ndmBZHXVY2G0KPZnicdOvMEIM9Y1V3/Yzv6M1RjA+pvGmZOyjQiDtjwGL5I/39fYGcgAeK65L9
 JBLKYv824vYUlk6QyCjdSJWk463TyxuXYqcA/tMGbu0Ylnfdw+qqyldfgF9CKNnmcVII9XE6w6a
 t98ZwMYAPXO2QLiW8awOWW0GxB/NO/wRpE6UI1FNzoMgey9l59QdH6luC2SInibdF1/OmMDDjw+
 R2jxghy54qM91mB7wwhttgpXS0ZpBw/jaPg9GqgOwcw==
X-Received: by 2002:a05:600c:3111:b0:4a2:1a:a128 with SMTP id
 5b1f17b1804b1-4a211ed7ec2mr54410415e9.19.1792783623151; 
 Fri, 23 Oct 2026 12:27:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d416241sm1628613f8f.43.2026.10.23.12.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 12:27:02 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 23 Oct 2026 19:27:01 +0000
To: Ralf Lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
X-Gerrit-Change-Number: 1991
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1991?usp=email>
X-Gerrit-Commit: b4004c28690cdc057f33573ca50e018eaebe0baf
X-Gerrit-Comment-Date: Fri, 23 Oct 2026 19:27:01 +0000
In-Reply-To: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
References: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODg1ODk2MDAwLkk5N2M1NWUyMTFmOTExM2QwOTA4MDg3MjRhYjQzY2IzYzk0MDk5ZmIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5eb08f072a4a344f9b83bb223810126a68e3119f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xKKuz-000000002Ei-3yVs
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: enable
 RPS on newly created DCO interfaces
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4781216807140604085=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4781216807140604085==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dTOWHk9M+7Q="; charset=UTF-8

--dTOWHk9M+7Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Ralf Lici=2E

Antonio Q=
uartulli has posted comments on this change by Ralf Lici=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail )

Change subject: dco_linux=
: enable RPS on newly created DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1:=
 
> FTR: my UDP throughput, via 25Gbps hairpin NIC, climbs from 7=2E75Gbps =
to 14=2E [=E2=80=A6]
aggregate over 4 flows



-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
Gerrit=
-Change-Number: 1991
Gerrit-PatchSet: 1
Gerrit-Owner: Ralf Lici <ralf@mande=
lbit=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Ge=
rrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ralf Lic=
i <ralf@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Comment-Date: Fri, 23 Oct 2026 19:27:01 +0000
Gerrit-HasCo=
mments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Antonio Quartulli <a=
ntonio@mandelbit=2Ecom>

--dTOWHk9M+7Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Ralf Lici=2E </p>
<p>Antonio Quartulli =
has posted comments on this change by Ralf Lici=2E</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">View Change</a></p><p=
>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?tab=3D=
comments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">FTR: my UDP thr=
oughput, via 25Gbps hairpin NIC, climbs from 7=2E75Gbps to 14=2E [=E2=80=A6=
]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">aggregate over 4 flows</p></li></ul></li></ul><p>To view=
, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Dem=
ail">change 1991</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1991?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1991 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Ra=
lf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Fri, 23 Oct 2026 19:27:01 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: N=
o </div>
<div style=3D"display:none"> Comment-In-Reply-To: Antonio Quartull=
i &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--dTOWHk9M+7Q=--


--===============4781216807140604085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4781216807140604085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4781216807140604085==--

