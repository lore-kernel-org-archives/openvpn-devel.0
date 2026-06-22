Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251E8CDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nMOER5UYnehFYOnNt1UicTJYCPZz5wslqDgX+UlRj3c=; b=K2wVg9B9Dy1cg9fXNIGglMc4ft
	GiyUwlGp0Zr2Cp8P1y5v2OZzdHjstGDCRInGiqjorrqtpPmgz1VHIVvoJ3CodZb3l5h3HDBWVD+WR
	gBU8pSDZ0aocD3DEmUVlNxOgMYIgTXJix3BKeguB1gcsVY4dm3sFyv5cwqiINJRqQ2cc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbayd-0007Ft-M0;
	Mon, 22 Jun 2026 09:29:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbayd-0007Fl-4C
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 09:29:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HsA0/okam3mPyAPy5yYYIgA2LPfoHGSNfG7PDHXxDVk=; b=ZTjH27IVE/vdcsm9ivbHuPLLsI
 z5eDi6CO90cy6Harp/pHzTQYYcOCLPyH6Og4k8sWzkIa5nQJjFppUl29AZL9PRbPzFmQUfADWBgwg
 OrkPZ04M0xvIVGXYz84b4qzYHAGocRcFfAUGdQFb7QkX1x0hE7JPwkej2Z7FVPaOqiko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HsA0/okam3mPyAPy5yYYIgA2LPfoHGSNfG7PDHXxDVk=; b=j
 x3qKl5lHYomIqs1sUW/f4wtV3xe0iBMZbpC3InnsKvGmjyvXg/OfkLWeMLNpXhD5wvrNGPZkv5ti7
 XInPd0VMfd3W5FyH7qYsg7dap6sKfT3BNaa83U3vFqZ01Y3HNWxft2XFzlk/CRBIEQKI+iFV83Uij
 Lcswo+A7ml+dMcvI=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbayb-0002tV-94 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 09:29:59 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso28199535e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 02:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782120586; x=1782725386; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HsA0/okam3mPyAPy5yYYIgA2LPfoHGSNfG7PDHXxDVk=;
 b=XvqdxTtosEpXWJHqKVtOs1bes05e5BYPH0OMNhOlpQ2PpYAC1GGUjuJLtlWrucrGNo
 pP2i9+y8Zbwc30kqdRmS1ngrJ9ngDyOayR2FsY2QGVj19XUoCZl6V2QfdTSA6tEV5wHO
 hCkzPu557JS8Xl7CHU/xsNuOmuxrqrEZOKSaHzxsxUewJ4GyTF/veWPVsUYig4DFCpnQ
 4SjFPEdxV0X0YQrMfvqHfv1kUrhjdKDAvK05E3qAUXFMeLVt3K4nYvL49600nTsrPAJu
 D19ZvefQN1elgj2z9qXGMA2/89mTuszKjY58depiywfPw+WxukQWHa/HPIVLUDOBl8kJ
 09Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782120586; x=1782725386;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HsA0/okam3mPyAPy5yYYIgA2LPfoHGSNfG7PDHXxDVk=;
 b=TS+C76EjMbrwqzodifAGMivXXcz46E4tILAOLYBx58UotLL2NV+rrbLhnCNAPyxUMc
 ORguUrrcTiDMKq1pMTddDSx4OKLBm6E6s8hnQ61qnhkMrvHDZqhA94MnyONqEBSCOaDs
 IWOKtbDhO+3jCV1dlG3MCfl5PL1dE51OLY6hu7ASRuJfG5y937sLF6If6DRtx1SnWK3e
 to5iO0Yq/gOo4rGrjDnfOYfSyHW8n/Ax9dL3KF0vFyXv1HISrK3BdX0JEnVXrVaK89Mz
 V70jsmbv66+o8/ejC012bpYkeUfUJ8LdV405TWZKZjn2tDBWU2fLVQSpYejeSPAUnCmI
 cimg==
X-Gm-Message-State: AOJu0Ywut1mzbWLnHG+R1oTZXNOxEUYFDYxRrwxisPmHLNhFc4wsQq45
 NxUYdKJJBX+w9sW7/wKKcjfDvVKouXsruTpdPegtSw8THcl8VMrvp9eGiC24/UNblAhRq79jaAe
 ZnAnhJUiRlErI2lmYeUZJitO+qeHxdVvhdFbmuLLcOvATZ8Dv8bqotJbxjW9g3gIzYoXxjw2HZw
 ep8iq8ww==
X-Gm-Gg: AfdE7ckpNy7D1OXF2+yVihN0Ar6TbC6MsNSf5xcZfQbCKPvE4KaLn7l0sBvbk9pOUIy
 Lv5h5x6j8V9VpYM76IOxvrrKYgwx0RGHwPjx9kzxFSJqvvVWgkmGevPdig6sPQbEeZitRkPyh4M
 +/h/jPjSXxzDcJl3x9sSSmdyy5G4brBcxr2Jqk019LgoVfiGPLWagDVrs9JNKbFXvS0I1jrZiLY
 Ju1gajGU4GWRmkwng+ZCTmxI+mGbLgX9rHxT/Wsp116Y3NrQmfxpt1THZUcUmlhCJwhMOAJNXVf
 5iFyOZJg0kujHZnueUIumo+JSwuCfGuhzAZD40irmPaHu8qPODzWsee3e1zotAzNVw2umq3ASsg
 uvwemi9ZySnfsnSkVM95R2sQXp8SfKuqjB/X4QN5i7L2ma+KPJ6V6ABhV3y2Lz9oTsJpezh6upw
 XPtTYxfdJ47XOzBQFLJhmPmNHGWLcnJVo0IEWmyqrwHCXaFZiJPhrNua3VeoRKdhysFkPEhhS0G
 1zwmGNNtn8rm5BwzB2A8kJH1J2kfbaqvpjejw9pbBFLhFP85/iobNWYxDeDQyyW+4cuz3AHYrko
 r0A=
X-Received: by 2002:a05:600c:c490:b0:490:bbc4:76a6 with SMTP id
 5b1f17b1804b1-49240e7f645mr237919445e9.21.1782120585810; 
 Mon, 22 Jun 2026 02:29:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49245a69f81sm248162875e9.1.2026.06.22.02.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 02:29:45 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 09:29:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835
X-Gerrit-Change-Number: 1715
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1715?usp=email>
X-Gerrit-Commit: bddd85297e4aa6c7c8560aa819d8ca3be54c5e52
In-Reply-To: <gerrit.1782077103000.I49b37b5a90554fa2d4a83c8fc5608dad2a36b835@gerrit.openvpn.net>
References: <gerrit.1782077103000.I49b37b5a90554fa2d4a83c8fc5608dad2a36b835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMDc3MTAzMDAwLkk0OWIzN2I1YTkwNTU0ZmEyZDRhODNjOGZjNTYwOGRhZDJhMzZiODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eeb01765f5f1ac22f7634da0f51bfdb6e2bd6b84-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbayb-0002tV-94
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: fix
 use-after-free of DNS options on client connect
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5425749853718549401=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5425749853718549401==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C5nTo5keeLM="; charset=UTF-8

--C5nTo5keeLM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos=2E

Hello cro=
n2, plaisthos, 

I'd like you to reexamine a change=2E Please visit

    ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail

to look at the ne=
w patch set (#2)=2E

The following approvals got outdated and were removed:=

Code-Review-1 by cron2


Change subject: options: fix use-after-free of DN=
S options on client connect
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

options: fix use-after-free of DNS options on client conne=
ct

struct dns_options embeds its own gc_arena=2E When inherit_context_chil=
d()
/inherit_context_top() copy struct options by value, the child shares t=
he
parent's DNS arena=2E options_detach() detached o->gc but not
o->dns_opt=
ions=2Egc, so pre_connect_restore()'s gc_free() (and context
teardown) free=
d allocations the parent still referenced=2E

With one or more non-pushed -=
-dhcp-option directives that yield a DNS
entry, a connecting client trigger=
s this and the server crashes
(use-after-free in setenv_dns_options(), repo=
rted as a double free)=2E

Detach o->dns_options=2Egc as well, mirroring th=
e existing o->gc handling=2E

Change-Id: I49b37b5a90554fa2d4a83c8fc5608dad2=
a36b835
GitHub: closes openvpn/OpenVPN#1060
Signed-off-by: Antonio Quartull=
i <antonio@mandelbit=2Ecom>
---
M src/openvpn/options=2Ec
1 file changed, 1=
1 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/15/1715/2

diff --git a/src/openvpn/options=2Ec b=
/src/openvpn/options=2Ec
index 0c2866c=2E=2E9d4a879 100644
--- a/src/openvp=
n/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1531,7 +1531,18 @@
 void
 o=
ptions_detach(struct options *o)
 {
+    /* The options struct carries two =
gc_arena's (one generic and one specific
+     * to the DNS settings), whic=
h the by-value options
+     * copy in inherit_context_child()/inherit_cont=
ext_top() shares with the
+     * source=2E
+     *
+     * Detach both (i=
=2Ee=2E re-inizialize them), otherwise child's call of
+     * gc_free() (o=
r context teardown) would free allocations the source
+     * context still=
 references, leading to a use-after-free (and subsequent
+     * double-fre=
e)=2E
+     */
     gc_detach(&o->gc);
+    gc_detach(&o->dns_options=2Egc)=
;
     o->routes =3D NULL;
     o->client_nat =3D NULL;
     clone_push_lis=
t(o);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I49b37b5a90=
554fa2d4a83c8fc5608dad2a36b835
Gerrit-Change-Number: 1715
Gerrit-PatchSet: =
2
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <ger=
t@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2=
 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom=
>

--C5nTo5keeLM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, ordex, plaisthos=2E </p>
<p>ordex <strong>uplo=
aded patch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail">View Change</a></p><p>The fo=
llowing approvals got outdated and were removed:
Code-Review-1 by cron2</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">options: fix use-after-free of DNS options on client connect<=
br><br>struct dns_options embeds its own gc_arena=2E When inherit_context_c=
hild()<br>/inherit_context_top() copy struct options by value, the child sh=
ares the<br>parent&#39;s DNS arena=2E options_detach() detached o-&gt;gc bu=
t not<br>o-&gt;dns_options=2Egc, so pre_connect_restore()&#39;s gc_free() (=
and context<br>teardown) freed allocations the parent still referenced=2E<b=
r><br>With one or more non-pushed --dhcp-option directives that yield a DNS=
<br>entry, a connecting client triggers this and the server crashes<br>(use=
-after-free in setenv_dns_options(), reported as a double free)=2E<br><br>D=
etach o-&gt;dns_options=2Egc as well, mirroring the existing o-&gt;gc handl=
ing=2E<br><br>Change-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835<br>GitHu=
b: closes openvpn/OpenVPN#1060<br>Signed-off-by: Antonio Quartulli &lt;anto=
nio@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/options=2Ec<br>1 file chang=
ed, 11 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/15/1715/2</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span=
>index 0c2866c=2E=2E9d4a879 100644</span><br><span>--- a/src/openvpn/option=
s=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -153=
1,7 +1531,18 @@</span><br><span> void</span><br><span> options_detach(struc=
t options *o)</span><br><span> {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* The options struct carries two gc_arena&#39;s (one gene=
ric and one specific</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * to the DNS settings), which the by-value options</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * copy in inherit_context_child()=
/inherit_context_top() shares with the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * source=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * Detach both (i=2Ee=2E re-inizialize them), otherwise child&#39;s =
call of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * gc_fr=
ee() (or context teardown) would free allocations the source</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * context still references, l=
eading to a use-after-free (and subsequent</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * double-free)=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     */</span><br><span>     gc_detach(&amp;o-&gt=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_detach(=
&amp;o-&gt;dns_options=2Egc);</span><br><span>     o-&gt;routes =3D NULL;</=
span><br><span>     o-&gt;client_nat =3D NULL;</span><br><span>     clone_p=
ush_list(o);</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail">change 1715</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I49b3=
7b5a90554fa2d4a83c8fc5608dad2a36b835 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1715 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron=
2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; =
</div>

</body></html>
--C5nTo5keeLM=--


--===============5425749853718549401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5425749853718549401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5425749853718549401==--

