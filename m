Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EA3606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BdEs86Ob;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gE+OvPab;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cXrFzTLw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XqYA6Oya
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GHZyY+1U3n3qyGhntvZWL2+XbgzZj4f5Bb9Uvvt9yhE=; b=BdEs86OboM4BVahoQjmXRhq0rm
	uq2voulGH97PTRsEDOJ79mKeKvQu0vLGVeuFh7Be83hy0lKx95Wg1E3KMKzu0rmoUEqlaJtsQEwBo
	lijqX0r58uZ6ce3NfcAeet86x9fE+3hrjQbPRkFIt4Q25srevD1feqBNstlET8CH2MX8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrwK-0000000062T-0wmL;
	Mon, 02 Nov 2026 13:19:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNrwI-0000000062L-2LwY
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:19:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O0G3mi0gJCK79Enx7CQTKayHbX/ICRjzp6SX9+S4V5k=; b=gE+OvPabAk4HESCpuZ1T01sA8U
 iVi9WM5FlvwulJuBNLrGkvcYKiCLuqw764blLivvmpqxziFZj7GmoKAXNHevYthIJbWhgXxC8epZx
 7Mr3PCphY2fEKpZ9wjdsFJi7Cahb9EWtcE7t3X3EHYlT+mkM9hP5CiG5zSvQJ4pOssjc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O0G3mi0gJCK79Enx7CQTKayHbX/ICRjzp6SX9+S4V5k=; b=cXrFzTLwxsCP9G22+vEfZM4s8v
 5tjLBTdCTwx2i/69ZwRmzrz0ZUPblxkBc47pWNZfOdwNJ0CVcmksytf565MfKN8i3MsnBAy7razF7
 Su05shDrg39U+1QN+HWc42T0GMj+WyrOKWN2q5Y+14rbkmgnhovFzor2+nEQ3XsX+hhI=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNrwH-0000000087m-0O9P for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:19:06 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so24066705e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 05:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793625538; x=1794230338; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O0G3mi0gJCK79Enx7CQTKayHbX/ICRjzp6SX9+S4V5k=;
 b=XqYA6Oyak/hkA3ohCE9LxeJLdy87st1SMdHVyCOSVHx+Vx00mSHnoUS/JxtK+mW1/U
 VXI4HfoVrHulRK1wW4c+AwHyQGhAAW+yZsZDlUaKweEZN4b39igiIdVS+Oii9iian/5Q
 Ou3rOCXR0AMon7bsZW0IWEw8E8fW0XGkQ6IfYgxMWEV/mfzpVd7QdbUUzmVideukzf7r
 ELhwRBKFxdv4s+dzn/7fUPo2IuvIomW7DJ46j16oFB75PJHTUoAzT0xGuO7aVxNl25bZ
 uE/W8xj00EBpsTrmIwRyyifBPrSapou2ShAQdBcCEOvSuKqJDuorCGaNjl/lvQ4NaNGD
 yaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793625538; x=1794230338;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=O0G3mi0gJCK79Enx7CQTKayHbX/ICRjzp6SX9+S4V5k=;
 b=Sze3SqWS2xYAoIUcLpUliKSTzmjScc7u6OJbGNkd2gWt8Fo3DBb8OJX7XQ44Qee1EZ
 udKlcP9MhyblNdvYq8MZCNbeJXirZKEuRj5PMY48Gq68K8JhTzsHwwy0HKtJEDu+d1Df
 /oL9SEiZeCAhgUGGoUSeVyHcuY5/xOCGb87DHqwZvtowkxpP6pHJlBIMruv84WPQOXuN
 l1rBwWGI1rGR4otlv+aDfB7mpvseCeBZ4fqFyVJWqH6RA/dMqi8RbvZGl3NvFvomHowZ
 XFfIA5TReX+Ws9HGz9oIuto5XsHwHoTF+wxRY1dBF7F2rKod645yhjRlxcgeRgdCXLc9
 Ujug==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4QhW6McYn+TSYvHtZ6bcJSSVdpCJihuCmUTGDJxcYdfcJkhzlutbIRzmHnCd0LAnENASYxXLIjvU1RzJN@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIVvV6AAsEKWIG0J0rdGnm6JlXN0WwLdySguF7zz3/pWPxr9Jwv
 2DK9wFUaF5R0euPuS6bkM+w86XfBgz9XyFpuS8vWY62l6u56ljbX6EE+J3al40jsHUv8CWh6H4n
 Al3KR9O8+ImJEMo4j2NzXSA7ZwGiqBW8VYEAgYwP2ctrGmgyvXK0wwA2Y0JH+E+7N3MbKUZKPlz
 VTjET5AQ==
X-Gm-Gg: AYBFou00FwkwVZvw19oopTuoj7PSs8iw6Qoia8suvyWfjdc9f7ZvCh+1/Q3SpdOOaHs
 2FuWznYf6z/fXsArSJvPA3IIeChsLESSbDGT6Q+Lwap8JF1bpdLwLZrDS0DDxVEz5uMUQOD0flr
 yQYXogzaoFcCD0Dv+5zK1ubvBnBtscC5Yh7K3W0bOifWD0BIOErEHY/YQFV/eubzORxZnhTX5Lr
 vm89661b18mf2qkSbv+K5cMj/xhrc74hf9lXzBjO7YJybUTrSI4u+CJ0lPzYrt/PF4e8f+ViAXc
 Qif834zQdc1OL3sVQQtU6V+qsV2YmqzTMzR8nVeYQoho95CjRgWoR6R74au9cdG3bNvjyplgD1X
 ikbcMbJvDy/58OrtcpTeZb+JtHJM5lZ9cCQYGD2haFWGfDM7ljxFbrZorAEH96sGpAASXRVwHjd
 Fj416xgSFj8LMYPbC+Rkrbfie2g9qS9F1LYJf7K0nC8ZpBjLKNGLXr1zQX5DS6yZcPQ6w3W9K8d
 PpD1qx5wwEm73ROy72/hgtoWGgD5NWQWsIFyIRHZsVVF3vtMJsGA2TxvaBGr29q8OHMPvu8e8zn
 /eXe/u6zVnhUwOgP0nN7Q37QHF2DolsUzDzpqjmOLQbDEDmzE6XPkdyTb7s0ZVkPedTDWPyqUYw
 Mq/RTGNoVr1pn/1wrrKjuzrqN6BK+i/awGeqb+Bab/r8EH4jbaVy5UMyNmv5g5MibzL80/CqkDm
 JqjVQbttsyfKPzfg==
X-Received: by 2002:a05:600c:a4e:b0:4a7:76fa:87e9 with SMTP id
 5b1f17b1804b1-4ac187a766bmr226433835e9.21.1793625538305; 
 Mon, 02 Nov 2026 05:18:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80306sm21541103f8f.33.2026.11.02.05.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:18:57 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 13:18:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
X-Gerrit-Change-Number: 2081
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2081?usp=email>
X-Gerrit-Commit: 68fd83945956945d64655703fdb33041757f812d
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 13:18:56 +0000
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljYWRiZWU1MGEzYWY1NWYwZjIwNjlmNmQ2ZjFjY2M3NDYxODBmMzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7f41ef27bbd9a943d9ffee108e6f1968d642629e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNrwH-0000000087m-0O9P
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove support for
 --secret
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2393603367426872021=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2393603367426872021==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r28J758e5bo="; charset=UTF-8

--r28J758e5bo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld=2E

Arne Schwabe ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2081?usp=3Demail )

Change subject: Remove support fo=
r --secret
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 2:

(2 comments)

Patchset:

PS2: 
> There is one mention of `--s=
ecret` in options_string=2E [=E2=80=A6]
Done


File tests/unit_tests/openvp=
n/test_crypto=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment=
/a9d635ea_0cd599b9?usp=3Demail :
PS2, Line 311:     assert_int_equal(linkmt=
u, 1405);
> This test seems to be redundant now?
Done



-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f=
368
Gerrit-Change-Number: 2081
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Comment-Date: Mon, 02 Nov 2026 13:18:56 +0000
Gerrit-HasComments: Yes
Ge=
rrit-Has-Labels: No
Comment-In-Reply-To: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>

--r28J758e5bo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld=2E </p>
<p>Arne Schwabe has posted =
comments on this change by Arne Schwabe=2E</p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">View Change</a></p><p>2 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?tab=3Dcommen=
ts&amp;usp=3Demail">Patch Set #2:</a> </p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">There is one mention =
of `--secret` in options_string=2E [=E2=80=A6]</blockquote></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/o=
penvpn/test_crypto=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/a9d635ea=
_0cd599b9?usp=3Demail">Patch Set #2, Line 311:</a> <code style=3D"font-fami=
ly:monospace,monospace">    assert_int_equal(linkmtu, 1405);</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">This test seems to be redundant now?</blockquote></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li>=
</ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2081?usp=3Demail">change 2081</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc7461=
80f368 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2081 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon,=
 02 Nov 2026 13:18:56 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </di=
v>
<div style=3D"display:none"> Comment-In-Reply-To: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--r28J758e5bo=--


--===============2393603367426872021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2393603367426872021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2393603367426872021==--

