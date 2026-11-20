Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD413606A697
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HWJVoUU0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IjikH+97;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Zerma3hZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WMd9BCoC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=z4d+mCx33C24Y1eWe9aLj8z+6SLGJTNMz5PejtaIfqo=; b=HWJVoUU0faiaPfEdhlA8quGF38
	MwKNiI53+Xo+6scjFlSZA3J11upjcdZWJ0MXvL8NAWgR3vCfs2SE02MCuFUh5mmkuo69z0Sg97fzy
	bPVLBgx05qiRhYCFPb37YKQSp7TSHfiximTAciDXlBCA0o6HnJlOLT6DjFEpXCd/Or+I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUW3r-000000003PC-05DH;
	Fri, 20 Nov 2026 21:22:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUW3p-000000003P5-2wLz
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 21:22:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gvF16SxBHYFGJqCKCSSQ3irWo0gsUg9YIJmmdZvo5Ns=; b=IjikH+97qkXC92g7KLtKQ+0BVq
 qsM3x8iBHcFZTdoYtYnGcazgKTaDtth6YLtS0qzAlY6tHJgw9e6l+4fiZWsOej7jVI0xXQ9jXx/1p
 51y5az7ZhjeYGz7Bi8QHA0OLBPTN+IBJ4ESoWVfwQp21GbigKfAbYH4buGuDVyp+ZZcc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gvF16SxBHYFGJqCKCSSQ3irWo0gsUg9YIJmmdZvo5Ns=; b=Zerma3hZzelUIkbS0nW6/NZNF7
 wRk40yvyuEVZ2/68jKPPoRcOK5wWCgSK58JuL176JfE3oI6FqW30eh16U5+Vistfh+EEd+ewcNNhq
 WyHTw+Ma1rFa1jjw8DjX9kjX0wxvkdtpE+B/0Bw6GeKjjGLc9jz2/IHzUNIUQpVBIQ4w=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUW3o-000000002G5-350Q for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 21:22:21 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso8033005e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 13:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795209734; x=1795814534; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gvF16SxBHYFGJqCKCSSQ3irWo0gsUg9YIJmmdZvo5Ns=;
 b=WMd9BCoCpeJlqgB2+eRrGbTe5lth0OZGQuAn2iTiIPYM/p6Saq2MdTdQerg93VflG1
 vWtbNlK8mbCvKqEwtJKhnlgBIrjVxSx5PMn/4svy8maplhHxeiPSOypyg0Jsl6WFFnIA
 X4igEdQ8P+2NO1kP6djzu8GyKDSXHhdgp0riAntjUVcIAQLPltFPiZCEqJaCYBUVSSJj
 TABkXIizZYt9f8Hdu5dKkTgSOntWqGVizSkBCtMU2I7y5awkJdf4WQFfiRUJ2DOXdf9W
 G9ppw8GhjSRBEQ4u90TSKiq0XQOO0YJyI5guvPfFk9kdDiN63mKnHWxjF68lwpaGG7y+
 CLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795209734; x=1795814534;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gvF16SxBHYFGJqCKCSSQ3irWo0gsUg9YIJmmdZvo5Ns=;
 b=v4LeHMrEJCLv22flJnLUYKt1mUzELDdAa2+XdAbcAi4T7PmY30M5SunMssIB+bNpLb
 PGc52G92fe0N3S+y0l5Je7DkIN25iEC3Wiuw8AfMnOcp25ZzwuA0a+0K1IhNvnF4cZwB
 C2AyoB7RvrZvcN5Fu/0Xx2pXij+dHCmy0cVC6HaWZPVZ2Aw3XUfEOOTsePlmV/sWJNVy
 INSYwLyQofEtgLGNverTN6XVlfnQopqTIS0zXoQ1SLMZkRParro8w4VVRBfOSmjHMcLl
 e6zIpF9K8fKdxnH/e+DVEVxB1vA+/4QJ+ZQuco6rVW99gcT6kzoV9ylrmh76SBhnD2H2
 +Zcg==
X-Forwarded-Encrypted: i=1;
 AL+hErGZNxoGBEMbR/8zC54J5pBrzQrw7Ckzp8qg2Q5duuhUgZd/wFPPTY3pP8I1e5bTuXz71j8V4VFLqVUtEplF@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/cTA94EqVmOP5nq1ASEjYOtSs7LVyirTRLEgO0F2/RvU5qWBVJ
 +KTihRBp85d9ArtcAIMD3E8/VxvLeStFokJ/nrP0hG27LvgfHVBRuPnfbVr2aWYNrucpKQXkp+Y
 S3zHI/Ggc1lyX+jJAaJ8KifN0jczBIGIBvJUCUJ0naZ5kdo7BZB+I1v+RiJNVj8uuLE7hc7Oc6w
 vY6W9ITQ==
X-Gm-Gg: AYBFou2BelWd9i0myFpVxdtAy9GrWF1ciu7iPxZ/XLYNx/AQxFJbO+clPB6Evhp8gyX
 yP6JnKdTFfqfEN0tOC/L+szH/eTG+vI7n21jz8noh0k7+/KJ+IQtdJvcXrIClVR0aKk+9Psg2ED
 7T/coOtCnvZuzKJ7ca1OpPvvm/Sk2hdM6I/CtCnCpn/CVdo0sYS4Bkh76c6bGt5msw3hNJLNxgL
 3hefLN5f9wl6Bk8O0z2K4/v3T7N3vhso9TkZqVbQ1kcWF8zK2vjzD4K7QrTS7VDv+Gk+wT3v8js
 ceho0fupD394dlEPTqyi4addlZf4s5IuS2a0FOg80XNuWy1fJn7XkGbhOG8lYdEDiwGHKjBi4yT
 Kjjp3QVVkSwteLJUasW1no4JEKvExxVxeFZaGo0Wt7LfuziI7KfK6y1h89S+M40g+d8//sky7GW
 LMGzfySfwrYH/sK2lyIRZU1SH7PVV1eSXfzZ69VqfOwdGxmOadRVNGxFy70xfzYFlz7YMm4+3H9
 cQ6/rsU2lzmcKcxujz2L+QpIf5xgxjDPd2YedJv/OjWK3N+ADPzVTLq0Hd5nDxpn/x+P5aPYcDw
 SOZt+jmW8rZGi4vZIFqwYlv62MOnZbVfsVhkKZA37Xytkm4DyYBzy6yH3O2IVhgd14qBHvIRyFc
 4KzDvMMoI4wDH55POAMr0UaR5SpHyG9LI2GjJcBXjyehKaD5Y02JcdgJ1q4YV2VezmG8UA7OiLe
 5W4KDnjkxVTaiwPj7w/5vHCCBnHxWnoXu364wr
X-Received: by 2002:a05:600c:1d09:b0:4bb:6b59:aac3 with SMTP id
 5b1f17b1804b1-4bb88816050mr102741095e9.29.1795209733909; 
 Fri, 20 Nov 2026 13:22:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853ca452sm145693635e9.15.2026.11.20.13.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:22:13 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 21:22:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1249834b1899461bc8f01e848bea95e30decf60c
X-Gerrit-Change-Number: 2236
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2236?usp=email>
X-Gerrit-Commit: fe68bc4c2db29c9b98dbebafe6e1b1c7bc9c28bc
X-Gerrit-Comment-Date: Fri, 20 Nov 2026 21:22:12 +0000
In-Reply-To: <gerrit.1795207834000.I1249834b1899461bc8f01e848bea95e30decf60c@gerrit.openvpn.net>
References: <gerrit.1795207834000.I1249834b1899461bc8f01e848bea95e30decf60c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjA3ODM0MDAwLkkxMjQ5ODM0YjE4OTk0NjFiYzhmMDFlODQ4YmVhOTVlMzBkZWNmNjBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <90b571b8eaa6e375d8d45d6c78804fb024d7b69b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xUW3o-000000002G5-350Q
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: zero
 name server bufs with ZeroMemory
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2049449207583731477=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2049449207583731477==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AQaYHDKJb8o="; charset=UTF-8

--AQaYHDKJb8o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Heiko Hund=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2236?usp=3Demail )

Change subject: open=
vpnserv: zero name server bufs with ZeroMemory
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2236?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I1249834b1899461bc8f01e848bea=
95e30decf60c
Gerrit-Change-Number: 2236
Gerrit-PatchSet: 1
Gerrit-Owner: He=
iko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Atten=
tion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 2=
0 Nov 2026 21:22:12 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--AQaYHDKJb8o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Heiko Hund=2E</p><p>Patch set 1:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2236?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2236?usp=3Demail">ch=
ange 2236</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2236=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I1249834b1899461bc8f01e848bea95e30decf60c </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2236 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hu=
nd &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Fri, 20 Nov 2026 21:22:12 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: Yes </div>

</body></html>
--AQaYHDKJb8o=--


--===============2049449207583731477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2049449207583731477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2049449207583731477==--

