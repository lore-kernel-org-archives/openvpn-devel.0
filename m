Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DFF606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Nx7VAMyP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E4o8CG2L;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MbzAKf5L;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CDtkpgVc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Zk//ngdOtiKXmvH8s2uRxplJzUF/mi/gW6+uP64uSwo=; b=Nx7VAMyPQaiwRGmQv4sniEya87
	YY6CPuYrURan9o6Ey5z4BLCHF35v+RzZ5vAESSZJEInQjEAhNzs9O0LCJwWd6SR4YvjZqbKh7Gagy
	Dsp/7Hnawy63aRIgzSHLt8KuN8OeciMG4w4ydUv4ztKMzcFlR5vapT+v2cDlyT3Kw3zM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTGBq-000000001Z4-1tsf;
	Tue, 17 Nov 2026 10:13:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTGBp-000000001Yx-1PAj
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:13:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BikZWrB2De+PhQbanfJoFJhhUYnJEqLznHGm9bf2fiY=; b=E4o8CG2LrcIsZ6wuV12ncQUzRa
 4/zrxj8kGDMZt/NYoePay5a5RWMIV07YBwm8BHcZoshHJuEhlvHoo5aFpEW/GHgrqgO1hiaSlGIJR
 6MacUO+KRDdX9cyLndsR5bGQZPJIiaNaG2cz/kz6FSFqCtlo3PQUotlvF3RNA/CtuFn0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BikZWrB2De+PhQbanfJoFJhhUYnJEqLznHGm9bf2fiY=; b=MbzAKf5LkTjP4UYRI2sPagEOJj
 cW/6RakXdgU3i56cGpv6JcSsLWtorY2CfITUSuAq18FzuWO7GOVdPp6Qt+W/UNscu21gBvxTfrgA0
 OMOlABS3cFEwxjDxqs/yRhJCU0JVSZX7UI7sZ39ucp2qYI2HvcbZ1yt6c4KHaojGYFEQ=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTGBm-000000001ju-1HbA for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:13:25 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so40402185e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 02:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794910396; x=1795515196; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BikZWrB2De+PhQbanfJoFJhhUYnJEqLznHGm9bf2fiY=;
 b=CDtkpgVcvHzqHBH8UKvbWYHZFfFr6q5ODwA9vfQbJIpyJGmr6J0whfTw50WYlpVayl
 4qpFLNB2wIfAPDhMB5BXcDmbnq+VktuOSV+a8O1LrOPWDL4DUWTvrWKkPV1lDTpZrMyH
 Sqs/pxaT3GxFQ87sZbLIGjc1op18NBI4oMVbuWSHIr8aoBH+T7Lk+/BReBzWgS6HQJYR
 cT2vzP/z8tVg3yiw0r3XFNHvdyDOKeMSFTfQ6TYkjLYaKj5DuMTCgq58fJ1ODmGk8aWZ
 nRs0AtdiiH/YaUCCvJ3w3VhwMCqMzB3eeJD0nNrrtSRkkaSwJ4ZE/DGnsMpaR2Dh/vIh
 pUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794910396; x=1795515196;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BikZWrB2De+PhQbanfJoFJhhUYnJEqLznHGm9bf2fiY=;
 b=Zh4zguBSiDYsfpyjqCZ/C+UNEpNHP3Yu2lT0GZt55zbipvYTuVMdAm8JRND4wujf0t
 0UVzxqdonhwCiDUFBINgavKa1kFbmXSgFWzVHl7EGClImojEHZ2THkwO/kDCWuNkY3BT
 I9hNfTScnQFlBA9GkVMhiJhhfR6jL+XzQeug+Nct9F/DuxnaRqRuGEKJpfJY+kUbov+U
 XkL0cys0KAq15Pj5phEzPaqS06FxIEOyqOoVIOS1/FCObMD6X796onht8yZ3HxeiQkdr
 rQobzC/7hhkgpA7gkEpXERf3pY87Fbm7rP9CFkQXmtU3Rer4Ib/NRVskOrQ2MbNZqrCQ
 aA1w==
X-Forwarded-Encrypted: i=1;
 AL+hErF+zzbUlSXW/baBjDR3EtsB5s5b7wFfyiLQlMYmUmcquE1yGiUkA/iD/eNtT7rHFUxJ4DqZxWSx+LqgPDsl@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9UXOKu0dJ0GOqxpIYACVvkqKblN98YdTqDm/8+W+Rd4Fz1ir00
 OSS2mN2MQibxHUgNwrPD6BztlLHYBUAlqa2Vr6FINoldwWtIB43TPtY2LNUXHND8Hd8MiR3mrdc
 zle01MbymMcuXrMNBi0jLcSX3SSNjQLUSxDnwFafWav8UdTa9kfwYgmmroNcFZ9dpTvfX
X-Gm-Gg: AYBFou12py/NgCEm1mWeNtQ6noBCz3mTyjvIOXw691YkWbgc4jqwm1obxOalMGcw2aW
 jhkvBUjURfwLzfVlHg5pU0jOb1iwqnjzcVkEj5M2NzYhRqBXhzuuOaS8ifNt0jizeWRq5g88ma7
 5mNCpwbompLuYhbmBWByrOAdDXwUDOMBs4owFe3fMYxsIVg58y6gdf+TaRq6zDbyBuXEqHN8S5E
 Eqb0c6qOMGIIzZGYMXXcKeoKhtODh+mzm/arq+aJxyl3Th1bmtzjEkbBIYyAEEfHEz5tsOLIbiz
 LBxZOMXSde+/Fnx7KnaqaxF7DBvJTGRhnn1Fg8nSm+euQ9wZ15AFYobFTE77CTAmFb84yk24H1p
 dzGA1Z8VIOW4uWaKBZfpfogOAhIOch+8Jj6LFmrI68INhk+OP1KOQ3FtzHhAzsXCkn7ifDMhRBr
 kVL7minAYMee/t0/X8z/dmX0gP4Cr9fe/aRMsrI3HtqRZV5UIlYrj5ILyX+m4kOn4ziBGkxU3zZ
 Aatg+SDjJgrKs1YkkXWPvgaKA1xwMEF/vKyVlJz5Z1g2b5RgP3WxNj7gtipAK0tYgF9yadJtQo+
 gtwurq/I7fAVqdufGOVaoNLa0CiGgDNmBm9B4M3rW1l6rvWZ0Tjh0jB8cGHSgYYjsDcmx4VswF1
 BwQLQxdDBgUVZyXYxJnY4yzueL+hSEoobNkHQBrdtkq/iFioWP4bsajgeBfKni+mBs3DlMl83ae
 qiZoa3jbvjKrSGbHk=
X-Received: by 2002:a05:600c:46d5:b0:4a5:87b3:ddc1 with SMTP id
 5b1f17b1804b1-4bb55a8329amr280561405e9.13.1794910395440; 
 Tue, 17 Nov 2026 02:13:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783853b5sm58214005e9.2.2026.11.17.02.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 02:13:15 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 10:13:13 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
X-Gerrit-Change-Number: 2198
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2198?usp=email>
X-Gerrit-Commit: 6fd15e316f10888e29a439d4da99e1ff4b032f5c
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 10:13:13 +0000
In-Reply-To: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
References: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLkk5YzI0MDNjMjFlZjhmMjFhMGZiZDk5ODM0NmM4YWQ3MTliNGI5OTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <11b647115b2506c9f0bfb10d84e5ff15517cb7db-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xTGBm-000000001ju-1HbA
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Switch
 buf_forward_capacity and buf_set_write to size_t
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6260545024248287896=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6260545024248287896==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jz5Rq59+Vi0="; charset=UTF-8

--jz5Rq59+Vi0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail )

Change=
 subject: buffer: Switch buf_forward_capacity and buf_set_write to size_t
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:=


(2 comments)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2198/comment/5e25f6d1_43c1994a?usp=3Demail :
PS1, Line 7: buffer: Switch b=
uf_forward_capacity and buf_write_set to size_t
> The function name is buf_=
set_write()=2E
Done


File src/openvpn/ssl_ncp=2Ec:

https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2198/comment/c4f74e55_013e7857?usp=3Demail :
PS1, Line=
 566:     ASSERT(ncp_ciphers_len <=3D INT_MAX);
> Do we still need the `ASS=
ERT()` if we are no longer casting to `int`?
Done



-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
=
Gerrit-Change-Number: 2198
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 17 Nov 20=
26 10:13:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-=
Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--jz5Rq59+Vi0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2198/comment/5e25f6d1_43c1994a?usp=3Demail">Patch Set #1, Li=
ne 7:</a> <code style=3D"font-family:monospace,monospace">buffer: Switch bu=
f_forward_capacity and buf_write_set to size_t</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">The fu=
nction name is buf_set_write()=2E</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_ncp=2Ec:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2198/comment/c4f74e55_013e7857?usp=3Demail">Patch S=
et #1, Line 566:</a> <code style=3D"font-family:monospace,monospace">    AS=
SERT(ncp_ciphers_len &lt;=3D INT_MAX);</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Do we still ne=
ed the `ASSERT()` if we are no longer casting to `int`?</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2198?usp=3Demail">change 2198</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I9c2403c21ef8f21a0fbd99834=
6c8ad719b4b9972 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2=
198 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Nov=
 2026 10:13:13 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div=
 style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>

</body></html>
--jz5Rq59+Vi0=--


--===============6260545024248287896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6260545024248287896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6260545024248287896==--

