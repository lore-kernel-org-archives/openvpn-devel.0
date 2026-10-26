Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E395606A31E
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=El5u7aW2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QJYR7jBB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=izjli9Js;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FmqL1jle
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=sDrnWG91swDyd77Nou/4s8ZaXErlQWIc8kElrsog9cU=; b=El5u7aW21/tYhsZz6/NkAfA4qO
	VkwuEtnbcqGe9EYvBJRiAj65kB8KSGx0Zoz+mkb0vlnA09VSMmUWz9dOUJQH9/CnKG0E2l0kOHy2y
	fSt/H1P5SQJ1lLgPUyA/daOuoImGv+/ke7OgrwgiaZVISGpdYTG4SVTwhzUA1snXY57o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLIPY-000000000Og-2bao;
	Mon, 26 Oct 2026 10:58:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLIPX-000000000OZ-1BhS
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 10:58:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lvXri86CkS+4zl3tD6hogdzxi5HjQt7NGQZE8YUXy2o=; b=QJYR7jBBSmwWr1UY20mmHKYIgu
 uCrqwTHZNhoyHlH1bRsRvbRiyGmhbdKUkviWsg1YV/lY9fk97510k0CBgukcPUU3W0paDcREzDN8z
 mFhe4sBtG6JixlKoik1WayPSTl5sMPJ6+GJk9VObE6/u12fyxiUnk+WRxJgDZBHdt2yc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lvXri86CkS+4zl3tD6hogdzxi5HjQt7NGQZE8YUXy2o=; b=izjli9Js/oI9e4Jrbe1R7/JVdA
 FxnXBbV9YQmLkcc0i6gpN5iAnpPGAgSgi4UL0HA1SqQv/yLhccZFvusvuwZoGX0z1TrwTwNQgHqT5
 ex0za0TuZhWzXqoPEZDNlcWJnDEJ7N2Uad+CYIoGN8m5yUt4wzD5Ue81peiy+0ndiirU=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLIPV-000000004oJ-1gJ5 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 10:58:39 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a4dc547987so4826175e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 03:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793012311; x=1793617111; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lvXri86CkS+4zl3tD6hogdzxi5HjQt7NGQZE8YUXy2o=;
 b=FmqL1jleGhH+v1WK2z3l1FcG1WU1cVMCshLK0NnQCVVu2wXwkjjTt0z5oQgF9Eq/yS
 uIZt19NnUgDdegfJ6Wc7Z7GZ1gkm/9SuYaWaO0W6d9YGwIAe9v396HnuQXBuGjBF+xcS
 K8kOFrN4hKnLyXmTOsppIPzoZPu/c8VNRuK2h/Za17FIuvOKj2suNa0jCwqImZ8/j+Pu
 vjYAQL7dqPPCI4y7rBR+BQAlvtpotmdZsiexQw4vu3FYXRi3aEiXC5dt/1ewM9qsgfYo
 txHwAoVWN/mlcT6w97OiN+LZYjeERYf3LtPJn3hn4q4ygrTmLL2KfOwFmqrFBQfQyQ/I
 Auiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793012311; x=1793617111;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lvXri86CkS+4zl3tD6hogdzxi5HjQt7NGQZE8YUXy2o=;
 b=RG8fVxJmAHXzfFLJAOREWKeEFQ6uhS+iPbynZYpVpIusTdXwBFMthq2tdAAxROZGkb
 EErIk3pHRdovKChMm7SzaWAJGx33v0Bg9EZ8Kwk6FRUZYn7+yR1QsDYID9fFtIHIZ6vF
 oIZ80YxRGai7klZQozXFbm+5zVGeyaSvkIOfCaPRHxfsHUwmJMf6pi/Ev+AVjqXO0tRA
 bAyc9bP1gzXk7B+jad73u30zvXhICtagcW/3G8ZGMPVz3URZldxE6zY45zDI4yVzDNjf
 BAoYxyfHbKIwLuwagQ84/zC+BIrj0HQZ9jzAP1zWBgTVwz1drZN3KZg1Matni1iW2kpt
 PIpg==
X-Gm-Message-State: AFq9FYJv+j48WHAVaQujlcxbeatwvrjnzo8rx9z6U6xqZ9wEX58xsLeZ
 twYU1i8zbonwXzctx4AgA7pJ1sRDtFh95/s+H0DBLGDv/iy9JzGgasMwufmg7toHnzwrWXoFOC3
 wP4nt4z/6L2Yhkv8gHqE+RqO3TXsMvI44v/8b9gaTKic8iwQbnG6nWgjfYIZmJsKsgN98CwD+SX
 XhlkabcA==
X-Gm-Gg: AYBFou1Ih+T+M7yBmjBl6a7MbmSqHjk0OwWPJf3T4fJ54qsl7CQ1hdNqGMRdp+hkubL
 sOf6tAn/9g2ozGIkCTDgXwheDdlmhzuEgsAaa5ma2SMEg06kI5NOwcVlv+RW8upp7WUooz5a88w
 k3qvS1LdVnlbjPVUIYRXiOTmhLAUNC6UWyBQa23WdgP88ur4wueCWRpDKwPAjq0uhCNKy96sqwq
 cKXeorXNr+0Bvi5W+faSJXE3W6wz8qW8CMrBdxnhrh4PPrvLsogQYIpJ+p0ER1tFmB8Z2GQUl2A
 a/zhsAcgvuXrxBxAl8iUXeMSX4N7rSZHb2Eu53DC/8R9zYqvjwo/aVGubRCQHp91xGEvVfnWCe1
 qm/nau/q9XmdQ5L5YnNxwwXLCDGgWbJeljc4XDHNcHl5Wk4Lr6OEtOnA1vvJF+Uux23tQwp1tCz
 EVK38KrcCWMvxK993Vebm4TnPFJt82uXiMSP3puNHgJl0IaHwotnBh8CpON84k605T6f4TAQ5qk
 Jhj4PutWCXpv7Zw3hUTkNnmRnOPA0aVCBN1+h+c9gHpAfdUoqR0JRqMDYDV+jTVBvnPPq/U+2kU
 fya03Wx0sGluDtUO93DkbDz0IEHN+OUmHtjgc9KIH7Q1mu26e4NQZP9gxphrhXMiOcVaXJDwfO9
 ky30QpT1SL5IKEQ18YuzoQMtJ8tRIx9+RZA9svWPZtg==
X-Received: by 2002:a05:600c:c0c9:b0:4a5:5fb9:5d35 with SMTP id
 5b1f17b1804b1-4a55fb95fc9mr52990015e9.21.1793012310497; 
 Mon, 26 Oct 2026 03:58:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a5822a7sm193015935e9.11.2026.10.26.03.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 03:58:30 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 10:58:29 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id206b12bd67c0b8a014a2c62277b43b18debfd43
X-Gerrit-Change-Number: 2033
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2033?usp=email>
X-Gerrit-Commit: 5801424a8dd19aee720526a3fb963cbcf9443206
References: <gerrit.1793012308000.Id206b12bd67c0b8a014a2c62277b43b18debfd43@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDEyMzA4MDAwLklkMjA2YjEyYmQ2N2MwYjhhMDE0YTJjNjIyNzdiNDNiMThkZWJmZDQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a1d7bcc629e1210492e0d6a3f6a37b2515c39762-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLIPV-000000004oJ-1gJ5
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: run-cppcheck.sh:
 Make CPPCHECK_CHECK_LEVEL=normal the default
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8813196150284173546=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8813196150284173546==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+QDQSkNXZy0="; charset=UTF-8

--+QDQSkNXZy0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2033?usp=3Demail

to review the following change=2E
=


Change subject: run-cppcheck=2Esh: Make CPPCHECK_CHECK_LEVEL=3Dnormal the=
 default
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

run-=
cppcheck=2Esh: Make CPPCHECK_CHECK_LEVEL=3Dnormal the default

exhaustive i=
s generally not usable since it runs for hours=2E
So avoid confusion by cho=
osing a sane default=2E

Change-Id: Id206b12bd67c0b8a014a2c62277b43b18debfd=
43
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M dev-too=
ls/run-cppcheck=2Esh
1 file changed, 1 insertion(+), 1 deletion(-)



  git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/33/2033/1

di=
ff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index =
58609b2=2E=2E05ec869 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-too=
ls/run-cppcheck=2Esh
@@ -3,7 +3,7 @@
 set -eu
 
 : ${CPPCHECK_VERBOSE:=3Dfa=
lse}
-: ${CPPCHECK_CHECK_LEVEL:=3Dexhaustive}
+: ${CPPCHECK_CHECK_LEVEL:=3D=
normal}
 
 if "${CPPCHECK_VERBOSE}"; then
     verbosity_arg=3D"-v"

-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2033?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id206b12bd67c0b8a014a2c6=
2277b43b18debfd43
Gerrit-Change-Number: 2033
Gerrit-PatchSet: 1
Gerrit-Owne=
r: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--+QDQSkNXZy0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2033?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">run-cppcheck=2Esh: Make CPPCHECK_CHECK_LEVEL=3Dnormal the =
default<br><br>exhaustive is generally not usable since it runs for hours=
=2E<br>So avoid confusion by choosing a sane default=2E<br><br>Change-Id: I=
d206b12bd67c0b8a014a2c62277b43b18debfd43<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-tools/run-cppcheck=2Esh<b=
r>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/33/2033/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=
=2Esh</span><br><span>index 58609b2=2E=2E05ec869 100755</span><br><span>---=
 a/dev-tools/run-cppcheck=2Esh</span><br><span>+++ b/dev-tools/run-cppcheck=
=2Esh</span><br><span>@@ -3,7 +3,7 @@</span><br><span> set -eu</span><br><s=
pan> </span><br><span> : ${CPPCHECK_VERBOSE:=3Dfalse}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-: ${CPPCHECK_CHECK_LEVEL:=3Dexhaustive}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+: ${CPPCHECK_CHECK_LEVE=
L:=3Dnormal}</span><br><span> </span><br><span> if &quot;${CPPCHECK_VERBOSE=
}&quot;; then</span><br><span>     verbosity_arg=3D&quot;-v&quot;</span><br=
></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2033?usp=3Demail">change 2033</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2033?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: Id206b12bd67c0b8a014a2c62277b43b18debfd43 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 2033 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>

</body></html>
--+QDQSkNXZy0=--


--===============8813196150284173546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8813196150284173546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8813196150284173546==--

