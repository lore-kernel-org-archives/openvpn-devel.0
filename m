Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1660FCDB46D
	for <openvpn-devel@archiver.kernel.org>; Sat, 20 Jun 2026 10:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YTI++/AU+y6VCJK1cK7g1Yt0EAi5DFm/+tRhu0Yvy1E=; b=Vy8GueiaBIa+p7xwVFb7XDe/P+
	PynTosRkBUNz4sz6ti24oZ7hmSe48BoUSVUk7ZHOzYoqO8nr2cun3iqqAHjHizMRlZ48cgKyvFDUi
	A85Hw31nqh0a/oCIO8gz3788wC5VclAL4RLHDIZT3Fzt1Y/LBEVqtSoNNIdHBsZC5A54=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1waswq-0005hm-LQ;
	Sat, 20 Jun 2026 10:29:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1waswp-0005hf-8m
 for openvpn-devel@lists.sourceforge.net;
 Sat, 20 Jun 2026 10:29:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zlX5aoDj3WkjIzx8BqheX0iNplJX4nGvymvvyuFT+Dw=; b=ERRP2e72VOmycGBWtv+CjKtxEf
 5GSUAAoe4FQHNHR108ERZ/5DH440+MDg3hOgo8GbmBse4NR6OGvCpO3bkfj6Ww4KjZ5ickbH91V0R
 /LYc8U+CtbBq0QR7pqdP2N40D2YZuYijdZqSOsXwR5qNlcIM3hNz+9u5v2mIUw7h2t3M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zlX5aoDj3WkjIzx8BqheX0iNplJX4nGvymvvyuFT+Dw=; b=X
 Za572gyijtElgL7yrz+qro+l3wJA3nGfj5+C7ErdDfgiiedka1aTQ2ajnxPx0xvU7z4cbjNNRTQzw
 LrCar0r+ZMrkNQt52HzPytBLAR4IDWPwMUo3gcuUI14mnbPPscYp58AdI/78pO3Lkq3iwq5CFK1L4
 6IfP+nDWG0g/du+k=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1waswn-0001JL-W0 for openvpn-devel@lists.sourceforge.net;
 Sat, 20 Jun 2026 10:29:11 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4631679f204so1888847f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 20 Jun 2026 03:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781951339; x=1782556139; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zlX5aoDj3WkjIzx8BqheX0iNplJX4nGvymvvyuFT+Dw=;
 b=eL9UsRWCNhL4rLFUoDWjjTxXZgDyl1amNAhrdYfcSMkOifJ6YM1+k6pXCpR60ybRLt
 sWygoxseqkdoZNECQvhLip6e/BdG/IMbKdzJg8PMvxIoCR08hZk3cCdh1d6lQCn43xlr
 GhBwDcQv86oCS1uUelqJBymQjQehCuvnS5wt2pzlJEJiqeOjvX/j1vuTn/6V3izW+dPx
 x2h8KzW3zEaUGuE64cH3gA93e2/zwYeDdC9CD3ykXOQaeYk6TcjRmJMYeBOUdxgDjJpo
 NehNY3p4UkFGIQpZ433jtMb8NrK+/8YkPyq6Vy+ciyOy9RuYDDWbvNgRvDDdxy/p3Ie9
 xxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781951339; x=1782556139;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zlX5aoDj3WkjIzx8BqheX0iNplJX4nGvymvvyuFT+Dw=;
 b=QD+2VK7MV35GRTJGpEVyxO2uxPz/odU9JFt1a2uPda+dbm6ADxWKxwCxh7BlV8XMlA
 tbd2vO39Dw28qr7gs8XekSVOH0C8/mPpsYHddrQ2upi2TI4GGio2yaZAh3g97HT8DsBW
 NI4K+rVNeUBZySsLzVn8zNQrcRfej7m+gjpT4emsuj+A2vFTk+CvY1fNkRYZFoQzHYGU
 4lD0b9R5/NIGoKie1/KwLrCq9RRq7hZcIFd9j1osgQTYr5/U5PwOrqqXDqF67f4MXXOg
 LhhOYjeEBs5KSWhx8QNsFuJTYayVXoPciLUJ1GnZrwPnxl6pJEnFgVJQWOAu5LGsGXLu
 IRpw==
X-Gm-Message-State: AOJu0YznTfvSwfOrnwYnRL05xqn2DOx3/XWXTW+ElsAoee1W6T/tdAM/
 YEVYZ2GqOoNxuN/8bW3ICP3MYpqKs2pFnSLrsvymw033xHu3BjBUVxKjC6WpNN1yxtXxZju6zZl
 Rm2UJc2W95+Pru9uE063uxPQ9N1WJC6JAYRi0pPkAdMgjXACh5c+fZx8jwe7GffV7jZqQ
X-Gm-Gg: AfdE7ckC+e75UfocZAGL0AIfSpSX/QXrptmfUG1TrKACYp1oKooNsZjnSrfVZJD+Y++
 vI6oORp2D02JoqvrmlVGTZTDSRPEKaOfEkR5vCgJpE5XhpQRq4IaN8F0LXdGwxwElrYjA89thgK
 DOxMXt5nNI6i2q1pv+uD4OTzTDqX4jg49Pjvz9vvfAIjSk/QvVdvmW2s5RZSEg9M7McK8K9/Iub
 LLiOzObOT9zHyxPw82pH+ADq/fi36Nh+RmEWWtaxvPZ9ke2aMi2e0YRYyLsFxoXZ41r2bzm2o1u
 ayNpdj3hf3E8Q8WqYBPZmx7cqBfOPXqu+J8uJoS92RFGApGKXTH57SCDdwfq5AxjQAZbyf3ivaY
 jjodLZ7ff+JKOOkyVjKoMK9iazCjsDNjcNmezdI3qv2gPTZQFov33XRYBCtdEqbMB0bUGs0JKIB
 Kl0FdxTHHt9mkmfAhRpEpgBUe3LBwlhLDaBChDUwawuQgITtzSGa/rq9/SO6U9YNOQz56DC4iHn
 0gcH+t5rmeVUSzgUoGCWOhPIUVbIPrlNkFFCS8uU5kw6unKzhLpOKyW54+wUMfW7NNzfx7F7NGG
 vuz5syGThpUaEg==
X-Received: by 2002:a05:6000:611:b0:463:3184:6310 with SMTP id
 ffacd0b85a97d-4651e7b3b26mr10901174f8f.28.1781951337571; 
 Sat, 20 Jun 2026 03:28:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c57902sm6980531f8f.25.2026.06.20.03.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 03:28:57 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 20 Jun 2026 10:28:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iac54e6772b2c26a09227fd638d24d6e2aa35cec6
X-Gerrit-Change-Number: 1713
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1713?usp=email>
X-Gerrit-Commit: 04309bfe0313c09edd02c29945893b9d7e2ca920
In-Reply-To: <gerrit.1781716678000.Iac54e6772b2c26a09227fd638d24d6e2aa35cec6@gerrit.openvpn.net>
References: <gerrit.1781716678000.Iac54e6772b2c26a09227fd638d24d6e2aa35cec6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxNzE2Njc4MDAwLklhYzU0ZTY3NzJiMmMyNmEwOTIyN2ZkNjM4ZDI0ZDZlMmFhMzVjZWM2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <98ca706f7c18cd7e02ed78525b3a4467e419af86-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1waswn-0001JL-W0
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: Fix 1-byte
 buffer overrun on NTLMv2 proxy responses.
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5905112847358460992=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5905112847358460992==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6npeNMEslos="; charset=UTF-8

--6npeNMEslos=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello plaisthos, 

I'd like you to reexamine a change=2E Please visit

    =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713?usp=3Demail

to look at the =
new patch set (#3)=2E

The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos


Change subject: Fix 1-byte buffer overrun o=
n NTLMv2 proxy responses=2E
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Fix 1-byte buffer overrun on NTLMv2 proxy responses=2E

An=
 attacker controlling an HTTP proxy (or performing MITM on the
plaintext pr=
e-TLS proxy connection) can trigger a single 0-byte
overrun to a buffer on =
the stack by sending a crafted NTLM Type
2 challenge response=2E

The effec=
ts of this depend on memory layout, but could possibly lead
to a crashing O=
penVPN client=2E

Reported-by: Tristan Madani (@TristanInSec)
CVE: 2026-117=
71
Github: OpenVPN/openvpn-private-issues#116

Change-Id: Iac54e6772b2c26a0=
9227fd638d24d6e2aa35cec6
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2E=
de>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713
Message-Id: <20260618123729=2E1833=
7-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg37218=2Ehtml
Signed-off-by: Gert Doering=
 <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ntlm=2Ec
1 file changed, 1 ins=
ertion(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/13/1713/3

diff --git a/src/openvpn/ntlm=2Ec b/src/openv=
pn/ntlm=2Ec
index 244ee94=2E=2E9c4edf9 100644
--- a/src/openvpn/ntlm=2Ec
++=
+ b/src/openvpn/ntlm=2Ec
@@ -317,7 +317,7 @@
     if ((flags & 0x00800000) =
=3D=3D 0x00800000)
     {
         tib_len =3D buf2[0x28]; /* Get Target In=
formation block size */
-        if (tib_len + 0x1c + 16 > sizeof(ntlmv2_re=
sponse))
+        if (tib_len + 0x1c + 16 >=3D sizeof(ntlmv2_response))
   =
      {
             msg(M_WARN, "NTLM: target information buffer too long =
for response (len=3D%d)", tib_len);
             return NULL;

-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: ope=
nvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: Iac54e6772b2c26a09227fd=
638d24d6e2aa35cec6
Gerrit-Change-Number: 1713
Gerrit-PatchSet: 3
Gerrit-Own=
er: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>

--6npeNMEslos=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1713?usp=3Demail">View Change</a></p><p>The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by plaistho=
s</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">Fix 1-byte buffer overrun on NTLMv2 proxy responses=2E<b=
r><br>An attacker controlling an HTTP proxy (or performing MITM on the<br>p=
laintext pre-TLS proxy connection) can trigger a single 0-byte<br>overrun t=
o a buffer on the stack by sending a crafted NTLM Type<br>2 challenge respo=
nse=2E<br><br>The effects of this depend on memory layout, but could possib=
ly lead<br>to a crashing OpenVPN client=2E<br><br>Reported-by: Tristan Mada=
ni (@TristanInSec)<br>CVE: 2026-11771<br>Github: OpenVPN/openvpn-private-is=
sues#116<br><br>Change-Id: Iac54e6772b2c26a09227fd638d24d6e2aa35cec6<br>Sig=
ned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Acked-by: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1713<br>Message-Id: &lt;20260618123729=2E18337-1-=
gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg37218=2Ehtml<br>Signed-off-by: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ntlm=2Ec<br>1=
 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/13/1713/3</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/ntlm=2Ec b/src/openvpn/ntlm=2Ec</span><br><sp=
an>index 244ee94=2E=2E9c4edf9 100644</span><br><span>--- a/src/openvpn/ntlm=
=2Ec</span><br><span>+++ b/src/openvpn/ntlm=2Ec</span><br><span>@@ -317,7 +=
317,7 @@</span><br><span>     if ((flags &amp; 0x00800000) =3D=3D 0x0080000=
0)</span><br><span>     {</span><br><span>         tib_len =3D buf2[0x28]; =
/* Get Target Information block size */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (tib_len + 0x1c + 16 &gt; sizeof(ntlmv2_respon=
se))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tib=
_len + 0x1c + 16 &gt;=3D sizeof(ntlmv2_response))</span><br><span>         =
{</span><br><span>             msg(M_WARN, &quot;NTLM: target information b=
uffer too long for response (len=3D%d)&quot;, tib_len);</span><br><span>   =
          return NULL;</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713?usp=3Demail">chang=
e 1713</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Iac54e6772b2c26a09227fd638d24d6e2aa35cec6 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1713 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--6npeNMEslos=--


--===============5905112847358460992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5905112847358460992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5905112847358460992==--

