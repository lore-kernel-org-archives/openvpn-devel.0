Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68392606A31C
	for <openvpn-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=f9vK2ycL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HASQJw4Q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=m5g3tpaP;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SvB5ofYe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=3xprm0D8Cj5fGKxFJ6dLgYTMnw8cR63a3qnDhhErfn4=; b=f9vK2ycLcjCtAAZqgch18dYtPK
	Apc4AGnsoon9pi2icglRTbfPcQISL80F/1bEEuk7jwQ+xF3EIZqklll4BxEpnZOb0YCfb4qZPKFXl
	Rt/xzBCBjjcTSnrb1PgcG7PRmgkyPCJnZQB1Ybasl8FIQM+Gi/lvqLXQPHVdhrqPeZOk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQ1hX-000000007pk-2v1k;
	Sun, 08 Nov 2026 12:08:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQ1hW-000000007pc-0b66
 for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 12:08:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tV/mrrIObBf5GYUy58LTChIrZKsUwlCYbA2W7ywUrk8=; b=HASQJw4Q2aB+b1ODJ6tZ+XSoaK
 Kvbludt8GKVwmWtSHbPBjJ8SxsUwQ9xqSopp0/lQ+hl+lBl0dH7fJMrkHXTYuUyHbdv3sBFVLIyf3
 B9WEFS9CMshqMCGA0oMIzyQRR80dyRmy3Ac7RnRv7m7EEE16vE2KFdjm7ySxUcj+64p8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tV/mrrIObBf5GYUy58LTChIrZKsUwlCYbA2W7ywUrk8=; b=m5g3tpaPmA/KTT/XCsjHrMUwtR
 3iqg5m9xB2Ms+LVqZkJXzfF+bTz+Q1IgX4RWixFM6bsozPXFk5R9ZpZMlzpOY2rhpK5EDzLFYO3Ep
 /ka6rZGj3Rjy5XKjKTJD6NmrpW7h6NJUrFfI+pd1UlbdFdVXKtjNYFQU4MePOnRCaS38=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQ1hV-000000005uS-1n3m for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 12:08:46 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so28195f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 08 Nov 2026 04:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794139719; x=1794744519; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tV/mrrIObBf5GYUy58LTChIrZKsUwlCYbA2W7ywUrk8=;
 b=SvB5ofYeGg3xWf6dLl6onSv4HWqM7XAMmyNSwFELP9G1Wq4/kXAWmfOhP0LNFADdJP
 XteDMHeDymV6Kzqn74eqaPlb3UMVVuxLb8vSqiBIxlRpKB+n7m1vPPGpKDFwShOzeMlv
 d4buAG+ly1x691AUwmqdXTIp/xEYTsgkXutkg1kiHPHQQlm8Ka4KHPUDD5QA7kgc/vBO
 no0YOwUFXwkBDBpuAZjNKxO+CKBo2mExzZwkOJRim65SG7Qx6NSWH1EsuTkU2j/Q8l9K
 +LCCEOr1+l01r2wl7z5yOhz4C/S64PkiiT1Uzoosfb59F92g1Jz8MmRT7VZLWelL8fMw
 /jyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794139719; x=1794744519;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tV/mrrIObBf5GYUy58LTChIrZKsUwlCYbA2W7ywUrk8=;
 b=Bv6N/bbPfsN7Fre9VvYraEjLVdTkoqy/JbsoZ9eLhQ1rcPNjyf3E/qEMf04RJBHbiV
 Kj4Xw/WUwbMjQT8DMCd1LLb6qu8feb78tCieWPyYyiYguC5D9ntKY7cgXo20DYl9sSKi
 xYrE3RnuTECB55YkB37WjMmmeVoCzO5HOAvUjlmAI7rc7pUPIFGg1EFNHC6igtkR7h5K
 +lzixm5Q4VjDi7uFkWQylG9jAWb1B0Qv8ypXutGv7pla4qiu1xSVEFlwQA/ZpDKb5ILc
 5ZJKgEaYveHntRZsQxHbYhmPbUMixlf7ZKr4OkjedMDGhyFTCsLMMm3Dc7PUkVrFIxI3
 aouQ==
X-Gm-Message-State: APuU4Z/kghVhKnPCx1LoTHwHWU0CVyV9CKV5Sppx9OhD/zh6FAxJCouh
 0hq4BPTKiy7pR2dI3Z6edTnNC3OoBX1wQITxYsx0QgCraxMabYCwKnneGQnL7tU0zXMhY+mDeLb
 Ep1E3ngBW3AQCvQbfiNRJbs+Yi+dXf9AVsrG5ZE93brx8CotgFm6tMw0q1wPbtC896ya2fA+oss
 wTkQCwZA==
X-Gm-Gg: AYBFou1xPt2P0lJUloBAJaxNa0J/ED0/Kc7+u3mjg1Tlv7FuhwCKGEYhyuwpaJlWZEL
 bWt8igwzzx4L4qXp/rhmXfFiHw3IWrYQUlzSi73REpYUJx+1pb3y3pAg7zBaJqfu07ehhKnVhHn
 FMrcpZ0aQ+uXPNE2ly0jW+BGKloQ5zORMRCSW033BSJjhbrb4l4NIChymwG/gPPWWE1HIzM4j3F
 CoSrTAzCO8YhOPV2Vf4rmkG66dcsFWXrCwO560iDEXVhAAbHWt1HDk/sFNgmuTdGCEZKf2r7wRa
 cxqm/smMAjO5d9ONuVFu/vB9RE6hvggZPyrerhF8iPd0warNj7pzgoaeVY8MJNKFCF24SQ0mNeL
 UgwHbjzFc7AOdEetYC37iIt+VCEozUDrwKPlBzEjESqmmqDuq/JvP84r9kyEzeFdXCw3Ke4Kb8V
 QXMgZyboYnonNojzFRBmVHbMHx63Eevn9+iEmTuhAO9A4r8m54xNzFwNtNV+xJ0PDKuGHYjuyEo
 g9mSG+TuBQTkJtOMy+eh9nes118KqKonW/wy5FUmH9uIvxKTygywNWUADUmhsmjSuLeyybaEd94
 oiqsh7o0kI63AYxa+CC7wogrcTCPLUXEn3+ISc9yT/cxgGKLfM0+sLJa0FMgWLWmmhSRVY1jlnC
 na2vZtXASKuY6YC0Q0y04UEkhuj92p2OivjsGUCFsM0o5CimS5meq9RsIeucnm/F2nBVWrlUzr4
 qnCFNtW4A62p/qdA==
X-Received: by 2002:a05:6000:4387:b0:48e:4e00:b72f with SMTP id
 ffacd0b85a97d-4958bce7ef1mr2929357f8f.32.1794139718607; 
 Sun, 08 Nov 2026 04:08:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4959783fc31sm3668434f8f.48.2026.11.08.04.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 04:08:38 -0800 (PST)
X-Google-Original-From: "Alexandre Laroche (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 8 Nov 2026 12:08:37 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Idb22f731a00158ff020a819081a07e1235d8323d
X-Gerrit-Change-Number: 2156
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2156?usp=email>
X-Gerrit-Commit: fdef240d2d2daac61ffb09e68e85847df01cfbcb
References: <gerrit.1794139716000.Idb22f731a00158ff020a819081a07e1235d8323d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MTM5NzE2MDAwLklkYjIyZjczMWEwMDE1OGZmMDIwYTgxOTA4MWEwN2UxMjM1ZDgzMjNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ca60d7746f594d864da13020f6a56615673c256c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQ1hV-000000005uS-1n3m
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_linux: clear
 the context, not the pointer, in ovpn_dco_uninit_net...
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Alexandre Laroche \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Alexandre Laroche \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5966667056193216740=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5966667056193216740==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gMNH2xKGzks="; charset=UTF-8

--gMNH2xKGzks=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2156?usp=3Demail

to review the following change=2E
=


Change subject: dco_linux: clear the context, not the pointer, in ovpn_dc=
o_uninit_netlink()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

dco_linux: clear the context, not the pointer, in ovpn_dco_uninit_n=
etlink()

CLEAR(dco) zeroes the local pointer variable instead of the
dco_c=
ontext_t it points to, so the context keeps the nl_cb and
nl_cb_notify poin=
ters that were just released with nl_cb_put()=2E

No functional change toda=
y, since close_tun() frees the tuntap right
after, but use CLEAR(*dco) as i=
ntended=2E

GitHub: closes OpenVPN/openvpn#1143

Assisted-by: Claude Code:c=
laude-opus-5-5
Change-Id: Idb22f731a00158ff020a819081a07e1235d8323d
Signed-=
off-by: Alexandre Laroche <larochealexandre@hotmail=2Ecom>
---
M src/openvp=
n/dco_linux=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/2156/1

diff --=
git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index 4412ad0=
=2E=2Ea84e310 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_=
linux=2Ec
@@ -537,7 +537,7 @@
     nl_cb_put(dco->nl_cb);
     nl_cb_put(dc=
o->nl_cb_notify);
 
-    CLEAR(dco);
+    CLEAR(*dco);
 }
 
 int

-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2156?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb22f731a00158ff020a819081=
a07e1235d8323d
Gerrit-Change-Number: 2156
Gerrit-PatchSet: 1
Gerrit-Owner: =
Alexandre Laroche
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--gMNH2xKGzks=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Alexandre Laroche would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2156?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">dco_linux: clear the context, not the pointer, in ovpn_dco=
_uninit_netlink()<br><br>CLEAR(dco) zeroes the local pointer variable inste=
ad of the<br>dco_context_t it points to, so the context keeps the nl_cb and=
<br>nl_cb_notify pointers that were just released with nl_cb_put()=2E<br><b=
r>No functional change today, since close_tun() frees the tuntap right<br>a=
fter, but use CLEAR(*dco) as intended=2E<br><br>GitHub: closes OpenVPN/open=
vpn#1143<br><br>Assisted-by: Claude Code:claude-opus-5-5<br>Change-Id: Idb2=
2f731a00158ff020a819081a07e1235d8323d<br>Signed-off-by: Alexandre Laroche &=
lt;larochealexandre@hotmail=2Ecom&gt;<br>---<br>M src/openvpn/dco_linux=2Ec=
<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/215=
6/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=
=2Ec</span><br><span>index 4412ad0=2E=2Ea84e310 100644</span><br><span>--- =
a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec=
</span><br><span>@@ -537,7 +537,7 @@</span><br><span>     nl_cb_put(dco-&gt=
;nl_cb);</span><br><span>     nl_cb_put(dco-&gt;nl_cb_notify);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(dco);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*dco);</sp=
an><br><span> }</span><br><span> </span><br><span> int</span><br></pre><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2156?us=
p=3Demail">change 2156</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2156?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Idb22f731a00158ff020a819081a07e1235d8323d </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2156 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Alexandre Laroche </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--gMNH2xKGzks=--


--===============5966667056193216740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5966667056193216740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5966667056193216740==--

