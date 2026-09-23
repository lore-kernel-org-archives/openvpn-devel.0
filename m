Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B93C9830B
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yfGdjXhPj6WfFZQVF0ZUdPll9M7Jx1JaVgN+e5iOshw=; b=h1UtnzOVs55mPFdfbAv1ldEFHs
	TQtJ70Mru/+xCANme3pTlAAj1NhGlhLrDIKEypZI66AWaAbYP/Umc3WPeFChaNG6Qp3tfu81Ium/u
	Ez2KIeNLY1iZUV0M9kEl77iTrJGPt4CaMYCzjB8Vp4Z/gYQrwlL9vG2xU9k7m3IyQgM8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9MzO-0002Xl-Ui;
	Wed, 23 Sep 2026 13:26:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9MzN-0002Xf-IB
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 13:26:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Am7Yolr8Y4ZrXyqyC65uNXM34xBagQKBLaB9sc4k7YQ=; b=eKmW9ZjCzwGwpssavOxr7lqPQs
 uErKPRTwm8eB+qB0ujKTh5Wt3Ps6ZNX2ZC8d7ZLl4diK+JHhfiX+yiJngmC0hDMI9Oix6zaa/mU7o
 MCMrP7XQ6WxcIO4gN5F3JD74kTsk1CTd6pynczPnBVO/g6cVvd0+0JnjbeuTN7dfQQk4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Am7Yolr8Y4ZrXyqyC65uNXM34xBagQKBLaB9sc4k7YQ=; b=W
 Yf5h9RZBrcRuYAOIgOlRnIgoMUOhLRWAxoAbPLFg0r59G09eptksBcD8LtDhMLGMEX+/5xcOr6xpa
 k2sWfWDDAvigXs9ZOr+I0u4Avf9wOXJeWu1lodirZUWbmtGzNsI3ivBHdQ8NB3vPjmm/DMQV1C9qw
 VuoRixD+i8TrBh88=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9MzJ-0002Bg-Tb for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 13:26:18 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4843e397f74so525279f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 06:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790169971; x=1790774771; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Am7Yolr8Y4ZrXyqyC65uNXM34xBagQKBLaB9sc4k7YQ=;
 b=bM/2+XkN1NZ26b8WTWY3Ac2c1nNHriUIskCBNYq5KL9sjt23E8Sk7CR+ucsaUgdH2E
 qJO75d/HZ1VO5kerBmK1smcI2KPzLKYi1fiD9LvUCPlinkvx0IEcyB+rFs/PXkepMjMd
 q5WrG9fXsqSLlnDQo+yniRXEiNjNu5B7gvQn8+NiDxgcllWP7MMBhlCXKZPE8cbbCqcI
 4IRrEZXAMVPF8GmQwoR+H652oIda/7m/eOYoGsa1BcKcpf9ONeiYvaxIgegBoglivW9N
 Y4GWwOmWXPtCyZHaUR8srqVNMeIFIzM98QKGPTlXEx1SXVxu3MlHM1OuGka5VNH07Lct
 UcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169971; x=1790774771;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Am7Yolr8Y4ZrXyqyC65uNXM34xBagQKBLaB9sc4k7YQ=;
 b=d82G+E0amD81WY4kdcFFiP6c4EAi76hfaB/uCaM4CvypYGhAseE1FZTvS24eMB8jLa
 jI2s0FPLjMSeRBo6p6pdBPp4GHrqrTWGNWOXs+sIRzbdfRyfSFowjBL11heDyvbkgoGn
 fdKvRx0yNApp7X93xwS2rPyajIg3GgTH2TeXKDPAfAt8wZ+U9fOlA2U7Fgt8ft/tos3T
 vhYJGaTksyJrKVw+FRcg/IY3Tkq/b8hoks/2nxGXCHIz0y3GOa+XhlW8K7b/MfgOShWj
 rXjVcYFOPJvHhIXwHL0ulA2XgMKJV68Tk7eSvTaMg4RLKSJN1U3ZRLgW/PpXoS0rIO42
 ltRQ==
X-Gm-Message-State: AFuF++lLrwCHpf2ovUl+35Tve9wpglDV7F0ZnpsqKXmWGnym8czyKzJU
 zj1lJ/nmcFil1v8JzVXWd2JBVR9abkhg33TlgVkoyBcSo4kvn82gpMwC1r1Io/CS194LbC15fzI
 gRJL0lg+sv+zZZyttB/h9VgLr1BbmkioP/NVZz1bVU6B5eTbQQDzGS1/S05SbAW9wNbjOkxiXXA
 3ksQuw6Q==
X-Gm-Gg: AYBFou3Vmes/H+2wicSjdByEq/h9gVhB8CMUFDLNKLO+DiRzk2iZgdFF4w/BQEQEA/B
 /OyJxY9r3JG1XQ0oHZU4DEUp8QJ0AfFexBpl9zqqWl0fx30WMNCtqnzUI1BpxJPWNdFPbBrf9YK
 wWxKDEyNHh7fjf9XjJOte1ZsjHl2NBA7YopnB9ZrVDO1VbkoHJQRsj2BJvhfWzw0MpOeiXayCxn
 0xjLQBAwRBXwZj/qggkTtFGuJensESZ6+FSYs6oLEAbCl7K/J1mQ/xiGwGUHMebBYmJ3lcATnz3
 2ddWerlGR796kNrbo1WBLeYxsHgV4paxgyGXLxcWokdqCXsgonGxyud2R7DTiWSmPieuKZp2Sha
 OkgJ5qwZ7Y/1S8AHIfV/jE+lab/TP2jVZrJlZu9DFd6YQk9QreAaeALweZa63rnI5beQMsfLAmR
 SgyNxJ87s9mnmEj3/9ew1hmCrM0zGhy/OWLq9G3tbQ9NeuRsBuABF9XkRceU/G23Oum7tgdDmVy
 +A0L+3JvKapAtnhnGzVDicI4/8myMqCLiy7rQBPG+LATs9sn7j9oz66jS/gHEwJOpf3auoQ3XwZ
 OzrRJgq/oNxkvn8V7Q9AP86zvN3tgy/zt1fa6JpyAwMC2RD2lcQ4ot+vBGuZrA==
X-Received: by 2002:a5d:64ca:0:b0:482:dd86:348 with SMTP id
 ffacd0b85a97d-48860f7eb42mr8752689f8f.4.1790169971213; 
 Wed, 23 Sep 2026 06:26:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488684863fbsm6259574f8f.11.2026.09.23.06.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:26:10 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 13:26:09 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: If276bd4c5d07fcd26f6749f514f0257eab73249f
X-Gerrit-Change-Number: 1945
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1945?usp=email>
X-Gerrit-Commit: 0c12762e6b250a967c154a2a127909e2bd9d3394
In-Reply-To: <gerrit.1790167275000.If276bd4c5d07fcd26f6749f514f0257eab73249f@gerrit.openvpn.net>
References: <gerrit.1790167275000.If276bd4c5d07fcd26f6749f514f0257eab73249f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMTY3Mjc1MDAwLklmMjc2YmQ0YzVkMDdmY2QyNmY2NzQ5ZjUxNGYwMjU3ZWFiNzMyNDlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c3e05fdf2a8dad101dd526756d5489bc7122f7dd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9MzJ-0002Bg-Tb
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: proxy:
 Work-around spurious warning on mingw builds
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8894088930532460073=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8894088930532460073==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RrmBdked5oI="; charset=UTF-8

--RrmBdked5oI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1945?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by plaisthos


Change subject: proxy: Work-around spurious warning on mingw=
 builds
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

prox=
y: Work-around spurious warning on mingw builds

mingw in Ubuntu 26=2E04 ha=
s issues with checking snprintf
format strings against original MS implemen=
tation even
though it uses the GCC implementation=2E

Apply work-around tha=
t is good enough for code that is
already gone in master=2E

Change-Id: If2=
76bd4c5d07fcd26f6749f514f0257eab73249f
Signed-off-by: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1945
Message-Id: <20=
260923130801=2E16802-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39441=2Ehtml
Signed-o=
ff-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/proxy=2Ec
1=
 file changed, 3 insertions(+), 1 deletion(-)


  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/45/1945/2

diff --git a/src/openvpn=
/proxy=2Ec b/src/openvpn/proxy=2Ec
index 7101d9f=2E=2E857bf03 100644
--- a/=
src/openvpn/proxy=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -767,7 +767,9 @@
 
   =
              char get[80];
                 CLEAR(buf2);
-                =
snprintf(get, sizeof(get), "%%*s NTLM %%%zus", sizeof(buf2) - 1);
+        =
        /* mingw checks calls to the builtin snprintf() with the
+         =
        * ms_printf archetype, which does not know the 'z' modifier */
+   =
             snprintf(get, sizeof(get), "%%*s NTLM %%%us", (unsigned int)(s=
izeof(buf2) - 1));
                 nparms =3D sscanf(buf, get, buf2);
 
  =
               /* check for "Proxy-Authenticate: NTLM TlRM=2E=2E=2E" */

--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1945?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: If276bd4c5d07=
fcd26f6749f514f0257eab73249f
Gerrit-Change-Number: 1945
Gerrit-PatchSet: 2
=
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>

--RrmBdked5oI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1945?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">proxy: Work-around spu=
rious warning on mingw builds<br><br>mingw in Ubuntu 26=2E04 has issues wit=
h checking snprintf<br>format strings against original MS implementation ev=
en<br>though it uses the GCC implementation=2E<br><br>Apply work-around tha=
t is good enough for code that is<br>already gone in master=2E<br><br>Chang=
e-Id: If276bd4c5d07fcd26f6749f514f0257eab73249f<br>Signed-off-by: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1945<br>Message-Id: &lt;20260923130801=2E16802-1-gert@greenie=2Em=
uc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg39441=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/proxy=2Ec<br>1 file changed, =
3 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/45/1945/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec</span><br><span>index 7=
101d9f=2E=2E857bf03 100644</span><br><span>--- a/src/openvpn/proxy=2Ec</spa=
n><br><span>+++ b/src/openvpn/proxy=2Ec</span><br><span>@@ -767,7 +767,9 @@=
</span><br><span> </span><br><span>                 char get[80];</span><br=
><span>                 CLEAR(buf2);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                snprintf(get, sizeof(get), &quot;%%*s NTLM %=
%%zus&quot;, sizeof(buf2) - 1);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                /* mingw checks calls to the builtin snprintf()=
 with the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
       * ms_printf archetype, which does not know the &#39;z&#39; modifier =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                s=
nprintf(get, sizeof(get), &quot;%%*s NTLM %%%us&quot;, (unsigned int)(sizeo=
f(buf2) - 1));</span><br><span>                 nparms =3D sscanf(buf, get,=
 buf2);</span><br><span> </span><br><span>                 /* check for &qu=
ot;Proxy-Authenticate: NTLM TlRM=2E=2E=2E&quot; */</span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1945?usp=3De=
mail">change 1945</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1945?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: If276bd4c5d07fcd26f6749f514f0257eab73249f </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1945 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit=
-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--RrmBdked5oI=--


--===============8894088930532460073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8894088930532460073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8894088930532460073==--

