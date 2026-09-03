Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8177AC624D6
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=gdbIiArlDSCFA1YuHtAa/eDOYcDBjSM+IMH8fDL7Kz0=; b=fasy9I81exvxxZ
	tizRJXV/ZzC07/pVoBl4+QD2KlXkU9ot5rX/gItBXm87T6fmcoYG1J0F5HavA5KLZF04gaXKVyTKV
	eAIaB84f+CteBeytZArwYSt8fk5FO9QBWz7E8TGdCCfzFFvXMhO8yFIrrG2XiI1CaY8Y+KSGalQdE
	OE4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2GaB-0002yc-0L;
	Thu, 03 Sep 2026 23:10:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2GaA-0002yW-03
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:10:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tSeUBS6rTy32SJ0ced6/RI213QeZheti9eTYwEtGGc0=; b=iTJXx182hrfGGU+dG94LEcpgwi
 TLTBu9amuSvaAGhK221knm61hec1qrPtIa5cLnIA+CjIqbUdBh6DDsDUvlWo1pLU53CJpX46Vxvtw
 MvcXCeBczGA4pUe+IZN7wqZhZPd/8ltZDL+ULYbPLHlhFxvXWrPNnDPrLr2aDic3R97A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tSeUBS6rTy32SJ0ced6/RI213QeZheti9eTYwEtGGc0=; b=W
 4rk1lpDsuOHNx3+P/KA5wlJN1LXZUdMrRAlKVZXZ+oeFw1sSITITzZphDm1p4dpnJvkf7vrKiYPdg
 0Ijc0dmTTSlo6fcw5BNah7nbddEi+20WSGvhxcxoubfHv1vbutsMSmvFrQsaxMQB9K/RA8GQQO8aa
 Gw8Gu2XLDyamjVQI=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2Ga8-0007Ie-OC for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:10:58 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49b96837ca3so2790325e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 16:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788477050; x=1789081850; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tSeUBS6rTy32SJ0ced6/RI213QeZheti9eTYwEtGGc0=;
 b=LebO204Iesa88azEPhnqWIZ9lH1OV8oHSywLHuoLQwTUmpxtirJJHFfYIYcPYACvPm
 +xuWd2NXXz9eNuaUBwZ1b5GbnVgXNqnTwhCfBO2AcKxa5W5tts5HOnmGJ4E/ouSnoxGA
 rcGaq9yIeV9s0GqBxjH/3shyJBTbyeCcCXFl1AxeDIcWiCvzf7dKSdIgWNqmQa5foQu1
 meXWUUe8dh7+GSj2e6XeaKCsCA+H87nmxz9GNSHTo+3KHQukHE+udGfxCVdpmgbGvGLU
 SW091V4vG9RK1hdPqtTSmSsFPo6foYlvYS+6ebqdbHlyGwJDQMtUMAbG7wr8OxRUub6K
 Cz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788477050; x=1789081850;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tSeUBS6rTy32SJ0ced6/RI213QeZheti9eTYwEtGGc0=;
 b=CU59cYstFN+FTbhMuK9jcWYufH2hVtenUYpgePKu2oQu+P730fGAIb4lOlj56HOwi6
 yNnqKCwhv22h+D2wzyHktqiwmsJSAlLCMymIvzwui5jr46vocqQaQFgsklFJ3ewT7GDJ
 fSN3us0cFoqqTXGodHyBUI3sOV3jqTHv+ff23UveUkfZb9mcDBLSQ61BLKWPLRSUI2O3
 g6A5lxXnr9/X8tZIivDgzWkRGxHtaJ3G0EWHnUERfBb36EY4i2Q7XYUHxVGnlSPOyXpC
 8FxW08T7vO5ex8ggDQzAid0RzD+q8EswWDon8D1PWE/JVSwZrI5V6mV/tEZio/3jCuwW
 mWGg==
X-Gm-Message-State: AFuF++nuiDCKjFvSPhK4EiKefE2zsHch9kYk9yxHzvjlBwfYjjNVpaJM
 XlZaofBRHEEiGHX1vdBjs3vx0rOk5/sBUwTpb5/eym+hjI3wDx6G5/l0RrU9C77y85Jz11rM3Zv
 gA7u5lM/Lb7yxxXKal7EeQYO+L9wXzv7BBcezj3X84rKnZ7YbpRJaNbF8J7KX3RWZ+tEv
X-Gm-Gg: AYBFou3C7Z+8vQqFIEgKXul3KQwA3SFwnFERZo9qb6giad4VIEBbo1yX21wWxYkKmAk
 4cuhkuwHRJJsc/6ATFjVY8dITMs9y3MFLEl7bKvAXqikWRFCl08c5lHyAk6tok7IQVikv7ARFbc
 IRJGM+8EjAE/pPUAGp+aALh19ajKHLLwApjeEQ5ZkpZr+blWrRjGwM9VgvwgEWx4ijI+A1gcZOH
 PsK90i/xAQ1g/Kp9RhRchxtCVZGmIL2KxHASYls+KmVImZsON3kBAxeQcexZJbmdNrA7TPD+W6G
 BkPY4qXmc97rXCK5qBXGGbn8yprfHdgydQs8q7eLzga29j+IsqmNr8Pbv6RJqpPmyaWQMWMmCbo
 /dYO3rrJ6yBdXDEFERZYdvOdNG4kslFohXWEg+jASIfeY8ddoihKUuaBd1H2aPFXqN4poMUa2PQ
 dfIPlQXboMM9xGjOPMsfrmkikc9EoYjLwwpq5SsSTfv5cuaQxqUNkiR42Gz62FaUAGOiGMwxN5J
 QTWP3LUCk1R7EO3qy3//bgqF9kZQ0ClEJvPJoOijzX/BGcGeQwMD0bYNMjqardJIHPeIlz0Jvon
 az2CpByrJR8Cz7ytCeCR6wERZqaF6RJm9JblNQEsmUW8ol+NXgo=
X-Received: by 2002:a05:600c:c8f:b0:49c:f5bf:e8fb with SMTP id
 5b1f17b1804b1-49cf81e6950mr19513265e9.5.1788477049745; 
 Thu, 03 Sep 2026 16:10:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm160061905e9.1.2026.09.03.16.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 16:10:49 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 3 Sep 2026 23:10:49 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I10326c787cd8149e7617279e45166073d66b9101
X-Gerrit-Change-Number: 1897
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1897?usp=email>
X-Gerrit-Commit: bcd5ef323aa524e5fc02aff083a743917b95fba0
References: <gerrit.1788477047000.I10326c787cd8149e7617279e45166073d66b9101@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDc3MDQ3MDAwLkkxMDMyNmM3ODdjZDgxNDllNzYxNzI3OWU0NTE2NjA3M2Q2NmI5MTAxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d3d58e248c6c274ba00dc8a3acb226fb2537e783-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2Ga8-0007Ie-OC
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_freebsd: don't
 destroy pre-existing interfaces on close
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
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0323991543167797602=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0323991543167797602==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pl86ntU2Tcc="; charset=UTF-8

--pl86ntU2Tcc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1897?usp=3Demail

to review the following change=2E


Chang=
e subject: dco_freebsd: don't destroy pre-existing interfaces on close
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_freebsd: don=
't destroy pre-existing interfaces on close

close_tun_dco() calls remove_i=
nterface() unconditionally, ignoring
tt->persistent_if=2E Since create_inte=
rface() stores the requested name in
tt->dco=2Eifname before the SIOCSIFNAM=
E rename, on -EEXIST the destroy
targets the pre-existing interface rather =
than the temporary one=2E

Skip remove_interface() for persistent interface=
s, as done on Linux=2E

Change-Id: I10326c787cd8149e7617279e45166073d66b910=
1
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M src/open=
vpn/dco_freebsd=2Ec
1 file changed, 4 insertions(+), 1 deletion(-)



  git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/97/1897/1

di=
ff --git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec
index =
d933aaf=2E=2E00429be 100644
--- a/src/openvpn/dco_freebsd=2Ec
+++ b/src/ope=
nvpn/dco_freebsd=2Ec
@@ -348,7 +348,10 @@
 void
 close_tun_dco(struct tunta=
p *tt, openvpn_net_ctx_t *ctx)
 {
-    remove_interface(tt);
+    if (!tt->=
persistent_if)
+    {
+        remove_interface(tt);
+    }
     close_fd(&=
tt->dco);
 }
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1897?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
change
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I103=
26c787cd8149e7617279e45166073d66b9101
Gerrit-Change-Number: 1897
Gerrit-Pat=
chSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>

--pl86ntU2Tcc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1897?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">dc=
o_freebsd: don&#39;t destroy pre-existing interfaces on close<br><br>close_=
tun_dco() calls remove_interface() unconditionally, ignoring<br>tt-&gt;pers=
istent_if=2E Since create_interface() stores the requested name in<br>tt-&g=
t;dco=2Eifname before the SIOCSIFNAME rename, on -EEXIST the destroy<br>tar=
gets the pre-existing interface rather than the temporary one=2E<br><br>Ski=
p remove_interface() for persistent interfaces, as done on Linux=2E<br><br>=
Change-Id: I10326c787cd8149e7617279e45166073d66b9101<br>Signed-off-by: Anto=
nio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/dco_f=
reebsd=2Ec<br>1 file changed, 4 insertions(+), 1 deletion(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/97/1897/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn=
/dco_freebsd=2Ec</span><br><span>index d933aaf=2E=2E00429be 100644</span><b=
r><span>--- a/src/openvpn/dco_freebsd=2Ec</span><br><span>+++ b/src/openvpn=
/dco_freebsd=2Ec</span><br><span>@@ -348,7 +348,10 @@</span><br><span> void=
</span><br><span> close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 remove_interface(tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!tt-&gt;persistent_if)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        remove_interface(tt);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span>     close_fd(&amp;tt-&gt;dco);</span><br><=
span> }</span><br><span> </span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1897?usp=3Demail">ch=
ange 1897</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1897?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I10326c787cd8149e7617279e45166073d66b9101 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1897 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &=
lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--pl86ntU2Tcc=--


--===============0323991543167797602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0323991543167797602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0323991543167797602==--

