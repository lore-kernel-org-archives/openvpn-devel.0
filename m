Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512E7C9833F
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=3b4JGYgbOsbgTx1e6xW+ay3GRm94qnVG+pzbAANSqM0=; b=fh0XQ5PNPw812h
	QU9SJIg67f4/SezYJtGkhgR/Bzt4ND2IK1yMTJpFiy8FDn781XmPu7C25xxYBRiwduGoFeiYw7Jag
	Hb+a/mOliRzuwUOoUojmwfkky4ZEbQ9A1d1R32+MBi7ybQGKwoP3IA3ZIIvhYme1ZOiNSwLTybv6T
	gDY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBBJy-0002O1-2T;
	Mon, 28 Sep 2026 13:23:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBBJw-0002Nt-JG
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 13:23:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CxA0D/xCr/GmLevPNUTLJ/XLvpdnUFGZIEjvAANTNwo=; b=aMEqVcGviKxnCjcRNRA6cV9AJv
 VtU34MAaA7/aU2r7qHV01wIpJHCigbS0WYyFID9wGvCrdbWty8ghfO/rCJI6bnY461NYO4HeErgst
 ze92DP98Eyx9DBqwa9XH4c97dum4oAWMC9VrMH8F/lwRXfgrGsiwq9zRxTpqXtGvlD5Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CxA0D/xCr/GmLevPNUTLJ/XLvpdnUFGZIEjvAANTNwo=; b=G
 33LgFvSmTd4DZ7rDj37irbeGG7eEXoYxDogj8C8a0nViWba43HlWoPargI/Xi2ikYmi2wFr4wxih1
 Yo5dOEfOSbL8yNGonGwGZiBiPGYH95dITHto6UF/dwWYawVVsk7X2EzAYLUV755GrOOdm44b1bhUY
 z37rxW4a/2j20Qxk=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBBJv-0005TO-HD for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 13:23:05 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ffe817151so9730265e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 06:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790601777; x=1791206577; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CxA0D/xCr/GmLevPNUTLJ/XLvpdnUFGZIEjvAANTNwo=;
 b=NZbHX4IV7wB3rMOIdg+qa5x0JcbI98mZf3sQaMhm+u1SflCJk+4sRzfGeDqo4FsAEF
 cBek1lK19bLm4RleoSKtPUZZyMqcVpiuI4YfMsJsTt6cAfdu88u/yCymibdEuQzWkzn7
 HiXuXPmxJw//3vWmxtpYL5W2cWP+UmRg80BUkttBf1C0XEWYN0iyBV6NWLlVdQ5ir35y
 WEa5KEwklpxbmswy4bk8nJsNXuHC7wzMzj3AkgpYdPGtj3Uzcak/67LBSonxpxJL8N5B
 X86K9X+4D/jH8QYjEyKswm6J4hiFspet6q/OooDh9xR5sjaiv48ejjmD4GnXTvrtu4DN
 WsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790601777; x=1791206577;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CxA0D/xCr/GmLevPNUTLJ/XLvpdnUFGZIEjvAANTNwo=;
 b=Wj+TwvvJGyugt424+ByMARmVhb/0Kd1KNN3dZ+fB77X8Qx/rLEEX36VAYQsr172gWP
 ZQJi6dieKi9UeFcopCKZqPDYu492E8GerO2/kHBuedqKLMkAwU/teP/aBf3IG/NMx74i
 IpV+k2KnvsnDe6pdv32WzlWa6coab5BwMH1DnMG7jWv31AaeY9iYdkLaFInB1dNnqPhT
 tcxj/xmgZpQSM9hC67s7AIZB3/ubI+UR2SHqAdWhJXDxxsgg/TmGOvALSL8ERuAq0Jaf
 JbO7br1VGJ9B7RffML6lkOmJVFw3TwnGrrSbJpEDrW55y8QUm0KyH/PSuyuuJTDIjUcV
 fQfg==
X-Gm-Message-State: AFuF++l/9Ib4L6kin5f0/PBx0nYmITF6UdnnbqLuTxrZESk11Qzyy30e
 OBUz6wdo2GREhQANagxK8f976P3W5ZlTfFgpL91vL6ICW7AkEtKEyT/8jwbtOYDdc2SYVuLIGlJ
 Yd8EC2bBHZcHad04tGMiIHI7U+mZ6v7p7Dh9qqXCkc3oOvqdbXrtshxxPLu4eTTchAc+jG3LUUM
 Y+xxIZiw==
X-Gm-Gg: AYBFou3qkuT9QXc9o+fGWEYa2y8aEQK6a/BTFjv9YLICr4SvTfgMByZdg1jcOq5RC23
 lxEfCRbm78dSHSkDPGFXwmDTGPpCSD53h9tiTV+W5I3ovITOrkbbhvijhGIfG4sl7TeRchwQQqp
 rr3DpTBYAisQZVa93pHGdf5R4LYFaioQJiWKJwC51fhQZDuNw2y9M+f3MVqG/iiiQ5XkL534CUo
 YJKoK2e/cbbBoGUddmYn7fQaM03ytUmpinAPJqDTTF3tH/FM2K2JZpb8ZUSdzAAyKpT/phXIWl0
 5CbwRU96K4gl8o1c8YdKjCGrSvMkQEKhA4yJ6tg/uU6gekziTaUNCaNSL4iYNcP7xo19bNin54s
 0B24PRxHv3N02E0AS7p8Xi9bmiePWJJF20yCYUb/a1N3jlNFQh3r6l6EsTYjpQhCIT6d+w1mjm4
 hUJnXgJWV2j+WAvUF51Ki2Ew5Y7w1j19StqA67tsl/t23D0v0Qad0yMM5mqVLAruxhErP8Oa9sH
 GIUaFDvi4NAM+NoO0s3xc/TgJheq1WMdn6eF4xY/2i0oishSWNq/OIgdwYoXiE6z1fKYjN34YhB
 Kq3o0ZypOGsnLKQk0J8aICDXAw44r+IolwKsTig4vM2MIuOrv37uaSPlZ6BX
X-Received: by 2002:a05:600c:a418:b0:49f:e4ca:e1d with SMTP id
 5b1f17b1804b1-49fe66fa070mr188153455e9.27.1790601775782; 
 Mon, 28 Sep 2026 06:22:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm139877565e9.9.2026.09.28.06.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:22:55 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 13:22:55 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iacbba3dabd8049901212adaf7551abc554b00226
X-Gerrit-Change-Number: 1956
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1956?usp=email>
X-Gerrit-Commit: 26a34ab6630a0828b1b505968eeb24c4b408047c
References: <gerrit.1790601772000.Iacbba3dabd8049901212adaf7551abc554b00226@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjAxNzcyMDAwLklhY2JiYTNkYWJkODA0OTkwMTIxMmFkYWY3NTUxYWJjNTU0YjAwMjI2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c764e864b0cbe52c57a0c5ba72b54dd7bb87d24f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBBJv-0005TO-HD
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: refresh peer
 stats before userspace disconnect
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0484532430842937641=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0484532430842937641==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fosRFflqFEE="; charset=UTF-8

--fosRFflqFEE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1956?usp=3Demail

to review the following change=2E


Chang=
e subject: dco: refresh peer stats before userspace disconnect
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: refresh peer stats b=
efore userspace disconnect

When userspace initiates a client disconnect, t=
he DCO peer still exists
when multi_close_instance starts=2E Query its stat=
s before removing the
instance from the peer-id lookup table, so that the r=
eply can update the
disconnect environment=2E

Kernel-initiated deletions r=
eset dco_peer_id before closing the instance
and may provide final stats in=
 their deletion notification=2E Only query
established peers with a valid d=
co_peer_id to avoid asking the kernel
about a peer that is already gone=2E
=

Change-Id: Iacbba3dabd8049901212adaf7551abc554b00226
Signed-off-by: Ralf L=
ici <ralf@mandelbit=2Ecom>
---
M src/openvpn/multi=2Ec
1 file changed, 12 i=
nsertions(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/56/1956/1

diff --git a/src/openvpn/multi=2Ec b/src=
/openvpn/multi=2Ec
index 9b9cdc3=2E=2Ed23abbb 100644
--- a/src/openvpn/mult=
i=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -590,6 +590,18 @@
         }
 #endif
 =

+        /* This path handles both kernel-reported and userspace-initiated=
 peer
+         * deletion=2E In the former case, the peer is already gone =
and
+         * dco_peer_id has been reset to -1=2E Only query stats while =
it is still
+         * valid=2E
+         */
+        if (mi->context=2Ec2=
=2Etls_multi->multi_state >=3D CAS_CONNECT_DONE
+            && dco_enabled=
(&mi->context=2Eoptions)
+            && mi->context=2Ec2=2Etls_multi->dco_=
peer_id !=3D -1)
+        {
+            dco_get_peer_stats(&mi->context, f=
alse);
+        }
+
         if (mi->context=2Ec2=2Etls_multi->rx_peer_id !=
=3D MAX_PEER_ID)
         {
             m->instances[mi->context=2Ec2=2Etl=
s_multi->rx_peer_id] =3D NULL;

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1956?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: Iacbba3dabd8049901212adaf7551abc554b00226
Gerrit-Change-Number=
: 1956
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>

--fosRFflqFEE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ralf_lici would like plaisthos t=
o <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1956?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">dco: refresh peer stats before userspace disconnect<br><br>When userspa=
ce initiates a client disconnect, the DCO peer still exists<br>when multi_c=
lose_instance starts=2E Query its stats before removing the<br>instance fro=
m the peer-id lookup table, so that the reply can update the<br>disconnect =
environment=2E<br><br>Kernel-initiated deletions reset dco_peer_id before c=
losing the instance<br>and may provide final stats in their deletion notifi=
cation=2E Only query<br>established peers with a valid dco_peer_id to avoid=
 asking the kernel<br>about a peer that is already gone=2E<br><br>Change-Id=
: Iacbba3dabd8049901212adaf7551abc554b00226<br>Signed-off-by: Ralf Lici &lt=
;ralf@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 file chang=
ed, 12 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/1956/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>ind=
ex 9b9cdc3=2E=2Ed23abbb 100644</span><br><span>--- a/src/openvpn/multi=2Ec<=
/span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -590,6 +590,=
18 @@</span><br><span>         }</span><br><span> #endif</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* This path=
 handles both kernel-reported and userspace-initiated peer</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+         * deletion=2E In the former=
 case, the peer is already gone and</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+         * dco_peer_id has been reset to -1=2E Only query s=
tats while it is still</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+         * valid=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+         */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (mi-&gt;context=2Ec2=2Etls_multi-&gt;multi_state &gt;=3D CAS_CONNECT_=
DONE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &am=
p;&amp; dco_enabled(&amp;mi-&gt;context=2Eoptions)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            &amp;&amp; mi-&gt;context=2Ec2=
=2Etls_multi-&gt;dco_peer_id !=3D -1)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            dco_get_peer_stats(&amp;mi-&gt;context, false);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if (mi-&gt;=
context=2Ec2=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)</span><br><span> =
        {</span><br><span>             m-&gt;instances[mi-&gt;context=2Ec2=
=2Etls_multi-&gt;rx_peer_id] =3D NULL;</span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1956?usp=3Demail">change=
 1956</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1956?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Iacbba3dabd8049901212adaf7551abc554b00226 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 1956 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt=
;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--fosRFflqFEE=--


--===============0484532430842937641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0484532430842937641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0484532430842937641==--

