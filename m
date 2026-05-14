Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C4CCD4F25
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 14:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=faJ6u18QTPM0Ax0fxwi/cEQhqptjOUVbJIp+Kdw3Gjg=; b=j9J4bTIUbUOnmZXXqAZu9zldq7
	TQz3JsyFQgfQrTqaEEE2AuBeGQLJJ1RPiksfrxzaomEHss4xrdvZRlED6SfSgkb5/BZimGuAUAMMU
	aNECwZTx//2FXO06MTvTU2d4bfg+C6FjVDbl3B1KyNZxnT2R9pgfeFn6JJeOmUnUmcsU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNXNT-0000qy-9g;
	Thu, 14 May 2026 14:49:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wNXNS-0000qs-DA
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 14:49:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=7HwiPrW5moCndIXEW0shIKusBhqFoNW+Xhd5h5Nbqdk=; b=Otl+6bsmm3UmnMTOz6ZhN+wnTS
 ic5fpgjwJTGDfux/ycPfaV9LJX3j2d5Q2GkeM+3h3m7w35D0x2AkM1AUC0sZ1buzBvms77iSn8+vu
 IYX4dB9EBH9zC0fzgSAxBbIliHtV2+Klm7au6VMlVq8mztNCYnKR7P2t2oFSOVBQqACE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7HwiPrW5moCndIXEW0shIKusBhqFoNW+Xhd5h5Nbqdk=; b=S
 uFNU2L8RVJclkN6RDh0GI6DdUpHfEdqFDFrOnJe/rnzQZFuD67dSoi5f+5Girkn/SmknjweEqi2/z
 Ah6+w9xIrjjax/tfX/lWLOVJ8HMYmyjRD0qPdPIdmLQ6YodR8UbPie6lLPG7GV9KGiq/WZpFlDo48
 wvFVDsaNkyHDOtNQ=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNXNP-0004rq-3K for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 14:49:30 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-44a044cb827so6448714f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778770156; x=1779374956; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7HwiPrW5moCndIXEW0shIKusBhqFoNW+Xhd5h5Nbqdk=;
 b=DOAGIaEmxx7PxZRRTz/YiQg4AC/3UsgR7Q/bfc28ZaJn0j1NCW8Q9Ydd3ECh0EYHeE
 ePO9e+QMkgzooqj9lIi/OWh41qzikWwxUaQJOMdqCulSwwVcYu1cNcVhNQi3/WuCTcxx
 AMydhmpNqE4Xtstp6wYp2RVGB1x4QsUxlalfGdbGkawsjhqbq4i6Ut1agZVBED1S2480
 6qW4Xv4+aYQPXJ/xyl89aGipv29hyJFW80GcBKREBeMXEFYWqcgw77yZ/yzWS6dmkZm+
 jm/kTb0orERG7puUH5cupQqFXHdMcNSv04gKZP10IzwempwIhg18dLfPo1s/j5K6QQqW
 8pRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778770156; x=1779374956;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7HwiPrW5moCndIXEW0shIKusBhqFoNW+Xhd5h5Nbqdk=;
 b=Xl7o84lIAUxGPbcXoFB6TCUo8EDFvSLEspwFWfV17qMkzeDidy/77csLXyElB7IWFh
 hifm8AhRrR74qejTB8g4c27a0u9XvSdeiwl2ama/ks1LGMvYHWkx/QmpUsJRxZ2q6F6O
 RNtpYveb2KxkvQ1ODvkltMhhOxF2AGqMyru4W6gqdb8xphOizf3gKNrcfng09rhtAt1K
 hVecChrnfOE7hIGCjAEEvtGsYKpHj2Sj4blc8C096U6Ww86IZxOQoeFFs4wDl3zMyo8p
 nfhb3PlzUijFyIImrHvq53FT0TLfH4d2Xllqr028iejvx+UR0sx8sQDyTZ2vpGMkge7e
 LMLQ==
X-Gm-Message-State: AOJu0YyvgPxo3S39B5YB0NxxpahlUx4lEmEF//nY/VLzC4VtDHVCZ6J/
 TLdjd4jas6yMF2M3M5aAhclqtbVnZEo4hjZt3x2KU7DUc4ePZluc/3K5fPTqEjD7K2XRBogJKwr
 cf+oqP1UirRSRFoMDqXdvR1FXIbltiYWoI8YrJou3Gyz777tNDheTWNDkZquUh3BsNdVw
X-Gm-Gg: Acq92OG0oVGYTQFYF3yYGwj7DEGUI9UoxWWCfIha2DZP9PsqS7Fb6gkvbeW0G1qJ8xD
 hAv6K5ZnuJ8vPPY01uaXDyK8ALHQD66QV4Lnw6kPF/v6lKNt71CafoJhL3zn4hZgavyxyoGG/uZ
 4+O1/q++aX/b7v4m2CzGDf3KTx2plPwp5NuDL7TnBsF1dS7Vx6VeeSQktD9yFRX8i3HpsluszSF
 Zaw3xHNlCA0jJRvqDkoUQJhI2wmHqJvv3QT9gxhhyiTfG7RdZuzhamNMLdSJoTCamMVQz08dtN4
 DiODQxpNLdJDBzT8v3HyXZkqx5obB+H6+25PhOQZHikz5koABezSGb90qPP1MbygrUm3qxoCgaz
 2IRxYOaJdmDS+XheUziC/cfCs4YAmRPnHNflsgH6QdJoSU5iAcNyBSb9y4mhprX0PhEf+dGlUdK
 FO9rfD5wnd11TZlN1PgD+WjeS0OX8IRwzYEbotLRTqusO7+pYNbQVVwZ52QD4lovQIF24z9AKlz
 sZwxK+OSjgiCtraYtt12fH+2cVMMIHMlFYSonTTR/UrZCk90PDwKfYVnx9NzCo4lmiotj++5lKz
 dUNpbmtIvz+1/w==
X-Received: by 2002:a05:6000:1865:b0:44f:da54:da6c with SMTP id
 ffacd0b85a97d-45c7aea187amr11861552f8f.26.1778770155805; 
 Thu, 14 May 2026 07:49:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm6856523f8f.11.2026.05.14.07.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 07:49:15 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 14 May 2026 14:49:14 +0000
To: flichtenheld <frank@lichtenheld.com>,
 plaisthos <arne-openvpn@rfc2549.org>, d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3d391016dcd3c66e58f3f05b356bcd419224acb1
X-Gerrit-Change-Number: 1671
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1671?usp=email>
X-Gerrit-Commit: 2b8afc6c685f4e451fd0fa5aa37f18147520dfc1
In-Reply-To: <gerrit.1778239616000.I3d391016dcd3c66e58f3f05b356bcd419224acb1@gerrit.openvpn.net>
References: <gerrit.1778239616000.I3d391016dcd3c66e58f3f05b356bcd419224acb1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkkzZDM5MTAxNmRjZDNjNjZlNThmM2YwNWIzNTZiY2Q0MTkyMjRhY2IxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <897150bd17c6e3c0f0817de8bec1508d4046fe5a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wNXNP-0004rq-3K
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: always
 use W variant of RpcStringFree()
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5119828567103009775=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5119828567103009775==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xWhbczasTr0="; charset=UTF-8

--xWhbczasTr0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1671?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by d12fk


Change subject: openvpnserv: always use W variant of RpcStringFr=
ee()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpn=
serv: always use W variant of RpcStringFree()

Probably not a real issue si=
nce it should always use the
W version in our case, but still unclean=2E

F=
ixes a cppcheck complaint=2E

Change-Id: I3d391016dcd3c66e58f3f05b356bcd419=
224acb1
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by=
: Heiko Hund <heiko@openvpn=2Enet>
Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1671
Message-Id: <20260514091918=2E18197-1-gert@greenie=2Emu=
c=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg36915=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 1 insertion(+)=
, 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/71/1671/3

diff --git a/src/openvpnserv/interactive=2Ec b/src/ope=
nvpnserv/interactive=2Ec
index 7726bc9=2E=2E788a578 100644
--- a/src/openvp=
nserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -3487,7 +348=
7,7 @@
     swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
            =
  L"\\\\=2E\\pipe\\" _L(PACKAGE) L"%ls\\service_%lu_%ls", service_instance,=

              GetCurrentThreadId(), pipe_uuid_str);
-    RpcStringFree(&pi=
pe_uuid_str);
+    RpcStringFreeW(&pipe_uuid_str);
 
     /* make a securit=
y descriptor for the named pipe with access
      * restricted to the user =
and SYSTEM

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/16=
71?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatc=
hset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3d391=
016dcd3c66e58f3f05b356bcd419224acb1
Gerrit-Change-Number: 1671
Gerrit-Patch=
Set: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer=
: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--xWhbczasTr0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1671?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by d12fk</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">openvpnserv: always use W =
variant of RpcStringFree()<br><br>Probably not a real issue since it should=
 always use the<br>W version in our case, but still unclean=2E<br><br>Fixes=
 a cppcheck complaint=2E<br><br>Change-Id: I3d391016dcd3c66e58f3f05b356bcd4=
19224acb1<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t;<br>Acked-by: Heiko Hund &lt;heiko@openvpn=2Enet&gt;<br>Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1671<br>Message-Id: &lt;2026051409191=
8=2E18197-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg36915=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpns=
erv/interactive=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/71/1671/3</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b=
/src/openvpnserv/interactive=2Ec</span><br><span>index 7726bc9=2E=2E788a578=
 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><sp=
an>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -3487,7 +3487,7=
 @@</span><br><span>     swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),=
</span><br><span>              L&quot;\\\\=2E\\pipe\\&quot; _L(PACKAGE) L&q=
uot;%ls\\service_%lu_%ls&quot;, service_instance,</span><br><span>         =
     GetCurrentThreadId(), pipe_uuid_str);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    RpcStringFree(&amp;pipe_uuid_str);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    RpcStringFreeW(&amp;pipe_uuid_s=
tr);</span><br><span> </span><br><span>     /* make a security descriptor f=
or the named pipe with access</span><br><span>      * restricted to the use=
r and SYSTEM</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1671?usp=3Demail">change 1671</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1671?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3d39=
1016dcd3c66e58f3f05b356bcd419224acb1 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1671 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>

</body></html>
--xWhbczasTr0=--


--===============5119828567103009775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5119828567103009775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5119828567103009775==--

