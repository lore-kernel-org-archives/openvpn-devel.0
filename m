Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DC4CD4F3C
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZKep7AVWI8O6nLNzTZTUNyzsJZb/6U/phnjhusydUX4=; b=Zso4QhWgtm0Cn8swG661ORKvrC
	VqPwmA5Lf+Nrp3xdeAWsZNYf7SR1saixKi/C1oZ4NCKivQZFPm/Q7rIp+50EW8FdMLBOQ9lOUN3qc
	+ebLzG5eus1yCa+V57lQipPaSszw751aolH1jtchjRDPEH5b6oh2mWUbq67VICYakGuc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNXNR-0001GP-Hl;
	Thu, 14 May 2026 14:49:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wNXNQ-0001GD-9a
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 14:49:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Vj0jGK/kVndH23ww35Vo3V+cwujOLb2svpG3NlgOVyE=; b=h28QYb+drGsCch4XscH8HRu7zr
 of5frBLDAfMNqjNmeoZ8k5nlObMI+lyfHBbydiXVEoqltbppT3vGe113LMj+6cDgXjzvsXJsQrTog
 EegT46JS5KEsLvWt1l+t5iXsqNNvW3EYK8esDJTf33NOo1lcRCvZCslgWVv5a1gtgCks=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Vj0jGK/kVndH23ww35Vo3V+cwujOLb2svpG3NlgOVyE=; b=L
 l35p7iEbBQrsmcylKQgb0IAkSZe4OBwGt2p8VXcfB74iGIb7NhPu1t0JYktytw5AZcilx956UBJk1
 5xn5BVyyqmk33z044q+uqR3UbinQdHy5TU/4ZCvPo5PfAwlzkxNFLjZnwpbuxsVxfhEvbTQU5Cqfp
 2GhxtivhLyCa2z9g=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNXNP-0004rr-O2 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 14:49:28 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-43d75312379so6160479f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778770157; x=1779374957; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vj0jGK/kVndH23ww35Vo3V+cwujOLb2svpG3NlgOVyE=;
 b=OzrTCFLBMxxnqFUXtI33/YQAqhFv9zIep6+mdNK5EhPSupzOHvbhzX2zJMW0lhiw+C
 UgAibeHoLELzOZVRtR9YTMuUxfCOlPZB0Kt9+1SMOQAWsm3q8ZzNXVAzpW/D2yZtaiD5
 RQP4wd4jy3zFNKDWsw1Hq28aBYzzFibAZiqp2Fp3YNE/z2w83E/PkGZJHaiVn1gbvi7I
 JU1U5YLybt71bwf6HJsdtkmuJmoFVU35XLIdcrhurx6nHMyvbEYzycavrA8jwgpmVRWo
 ihV3Ugmok3Uh+L+mTW3aJEg0km/Jm8appOgqhBQts2JUMVl3DidEiK/D4Uk71AAvHQ9s
 BpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778770157; x=1779374957;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vj0jGK/kVndH23ww35Vo3V+cwujOLb2svpG3NlgOVyE=;
 b=M4wHbV7MZP5/kxKdFLFFKjYmrFWuWBak0lZTuA1MJc0KdyWMAlifJKamCN5BykB3vk
 KeY/bz5dh/JL9w/CfSFxpgrcHAJgD7okWxHs1qImtXmN2WYKRP4K+HK0ZRaNqDcza8Vl
 xDpLCJIew4fKoUqQRSwNCNJ216FN9fBYeqs4pbEtJmv4E7Z6HBrCEkzAuVtsUqz+KhAb
 gFY7jqq6mpxcuMLHhKgyh5zTd1oDyw4RDkzDuzZXIPOMS1ZH8lp631h22JIEfJXxo+1A
 59a/puwWJBnxUFLCxGXhaT0v4lasLzz8/3JY8vgfMlyWDCqNIIWIvn+NRzcWiMetB/yt
 34nQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+vQyuJI7brf2EILxjcfaPlpgnwpt/D/FYv2GqSN7voIUZDVONiXRZ+mipG5Q0WT83QEIQ1kj02PeYECMhX@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxCkb6uL83M8kENnxo4Q8mpRyoRdw6XPEb4/J6iP9g8iAC7Ojak
 G764y9xQN8IPGoGM68dwDMploDrXkRSGXJS8hEG2tCELuPWrebcO1SdaOUXuFi4L+4p6kdFHwTS
 oTEvrfT7fdSDDAc3MrVLsosx9znW/6kbSakcyOp0vxtgoGLcBJj8r62JqyYxCT+vESBym
X-Gm-Gg: Acq92OHQ5Z39u0YYD/0zBPYynxiOaqshaat5rPYgIf56No/Kak2EOlvjQXMEEwOX5Xi
 RWqfETYgVH5XhoSCMCmPwo46fu6PEvZH1m5jB+qJj0qvoQI+YbvGnKg05wXsqws1WucJm7OuwP0
 qHzf82KMXoyZoLxse2oVkjzav8vLj4VUdpV5MO7GPe6WwCRSBaegaBlm/M3hOR/7zzsopuqETNC
 T+3zQOhg+kvdCmQ+AxXO3AzPveF6uQLAjEmYF9Bs66y4SiYxt8XN6bS/0+czB5nOYtCjPGFwtvA
 7WG//4JDz7ujlH0MPZNPCa/pdHTZgHYZdLJDka00zvtlz/insYv5aSl/1ng2r7mH/wUwNMkLWWy
 4aDpS+Rzo2FQedGRFfX2Kv1zFqUNJIP+XgBzboAieyepB+k7N/A5+oUrjMtPzVEpIv2ETEq1vIf
 cIiHhrsEXsQj7E/pWQb92q84PXezUOPbFSS1WM3kGAy5YiHtPpDzkHMcs+hM86FRDhCKfQkqBlL
 80hAquJDzefzR3lQzfzGigwb+xIdV/NyLCe+nASdkjujco0VEBqP/7T+xs4tOOexYxmWO7qYZeG
 Gij4HFprMYdSj6rVTl8+VxGp
X-Received: by 2002:a05:6000:40cf:b0:449:31ca:5e53 with SMTP id
 ffacd0b85a97d-45d9099a9c6mr6855838f8f.8.1778770156557; 
 Thu, 14 May 2026 07:49:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed30110sm7912536f8f.13.2026.05.14.07.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 07:49:16 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 14 May 2026 14:49:15 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3d391016dcd3c66e58f3f05b356bcd419224acb1
X-Gerrit-Change-Number: 1671
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1671?usp=email>
X-Gerrit-Commit: 2b8afc6c685f4e451fd0fa5aa37f18147520dfc1
In-Reply-To: <gerrit.1778239616000.I3d391016dcd3c66e58f3f05b356bcd419224acb1@gerrit.openvpn.net>
References: <gerrit.1778239616000.I3d391016dcd3c66e58f3f05b356bcd419224acb1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkkzZDM5MTAxNmRjZDNjNjZlNThmM2YwNWIzNTZiY2Q0MTkyMjRhY2IxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <897150bd17c6e3c0f0817de8bec1508d4046fe5a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wNXNP-0004rr-O2
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 d12fk <heiko@openvpn.net>, plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5706264609169856479=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5706264609169856479==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZUnxb8u+7UQ="; charset=UTF-8

--ZUnxb8u+7UQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1671?usp=3Demail )

Change subject: openvpnserv: always use W variant o=
f RpcStringFree()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

openvpnserv: always use W variant of RpcStringFree()

Probably not a r=
eal issue since it should always use the
W version in our case, but still u=
nclean=2E

Fixes a cppcheck complaint=2E

Change-Id: I3d391016dcd3c66e58f3f=
05b356bcd419224acb1
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>
Acked-by: Heiko Hund <heiko@openvpn=2Enet>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1671
Message-Id: <20260514091918=2E18197-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg36915=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 1=
 insertion(+), 1 deletion(-)




diff --git a/src/openvpnserv/interactive=
=2Ec b/src/openvpnserv/interactive=2Ec
index 7726bc9=2E=2E788a578 100644
--=
- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@=
@ -3487,7 +3487,7 @@
     swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name)=
,
              L"\\\\=2E\\pipe\\" _L(PACKAGE) L"%ls\\service_%lu_%ls", ser=
vice_instance,
              GetCurrentThreadId(), pipe_uuid_str);
-    Rpc=
StringFree(&pipe_uuid_str);
+    RpcStringFreeW(&pipe_uuid_str);
 
     /* =
make a security descriptor for the named pipe with access
      * restricte=
d to the user and SYSTEM

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1671?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I3d391016dcd3c66e58f3f05b356bcd419224acb1
Gerrit-Change-Number: 1671
Ger=
rit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--ZUnxb8u+7UQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1671?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">openvpnserv: always use W variant of RpcSt=
ringFree()<br><br>Probably not a real issue since it should always use the<=
br>W version in our case, but still unclean=2E<br><br>Fixes a cppcheck comp=
laint=2E<br><br>Change-Id: I3d391016dcd3c66e58f3f05b356bcd419224acb1<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: =
Heiko Hund &lt;heiko@openvpn=2Enet&gt;<br>Gerrit URL: https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1671<br>Message-Id: &lt;20260514091918=2E18197-1-gert=
@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg36915=2Ehtml<br>Signed-off-by: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/interactive=
=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec<=
/span><br><span>index 7726bc9=2E=2E788a578 100644</span><br><span>--- a/src=
/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interact=
ive=2Ec</span><br><span>@@ -3487,7 +3487,7 @@</span><br><span>     swprintf=
(ovpn_pipe_name, _countof(ovpn_pipe_name),</span><br><span>              L&=
quot;\\\\=2E\\pipe\\&quot; _L(PACKAGE) L&quot;%ls\\service_%lu_%ls&quot;, s=
ervice_instance,</span><br><span>              GetCurrentThreadId(), pipe_u=
uid_str);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    RpcStrin=
gFree(&amp;pipe_uuid_str);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    RpcStringFreeW(&amp;pipe_uuid_str);</span><br><span> </span><br>=
<span>     /* make a security descriptor for the named pipe with access</sp=
an><br><span>      * restricted to the user and SYSTEM</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1671?usp=3Demail">change 1671</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1671?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I3d391016dcd3c66e58f3f05b356bcd419224a=
cb1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1671 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body=
></html>
--ZUnxb8u+7UQ=--


--===============5706264609169856479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5706264609169856479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5706264609169856479==--

