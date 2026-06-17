Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C998CD98E2
	for <openvpn-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kCWRwBTIOx58UEAZFuEHZVsbnLNn08CIJy03UsPsV+U=; b=fpEZfSygGCis9GWdO8n8mR1LZd
	Net0fV6hUn5vGx7EoJadkVTfR4+IR4W7Ii6ob7zcQmBFvkRexMQkIBB5OLTrsggnlQE7XeB+jepFF
	8SaHPUf6+jKhSv41TmtLLhQhIxec2dvuNkW1h0SYU3Q4+0iRlztwLsUbYxhCXUmQllwo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wZuN1-0001Pq-BR;
	Wed, 17 Jun 2026 17:48:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wZuN0-0001Pk-95
 for openvpn-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 17:48:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pbHlGRGiwvgNxO6kudIYk2YnzXcRGcZIMZrCrDhx4CQ=; b=efeJYlun63HhDNCa/DPHOPAjta
 soFyGvsYPuWtuoFhdM4Gd9E4TlZv/ZXK+K0O6QyfQA94NZnvzllQ6/bvfWjS6c+XiF3k1NR3IlrLS
 qnPKMNvWZR4+XMKeEUxPvSAD/idfPfTM4tznDkiA9tF0FSFhBAwbYXRiRAix2PAVs0ao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pbHlGRGiwvgNxO6kudIYk2YnzXcRGcZIMZrCrDhx4CQ=; b=k
 kYGFS2it7Jrdtp/PspgcdkJxR1hnZ7uuJG8WuNrFGfoosLA7iGU+UnB0q5TpVRp74awuHs+0w76At
 +kiwBjDqhjzTORnDETtrT8wAAIkYrQBqdIeT3MgWEImirpvxJ7fH5BidaP+Y9FuY4d1pKOcGC3iah
 8Vg8bodci+H2TY6Y=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wZuMy-0004ms-PB for openvpn-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 17:48:10 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490bb83a3f6so47313635e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 17 Jun 2026 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781718483; x=1782323283; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pbHlGRGiwvgNxO6kudIYk2YnzXcRGcZIMZrCrDhx4CQ=;
 b=fhRuLQs3ldRskOgotzEmnWpwaq4AMUffIL6pLBOe8t/M0XobXfkDndmL206QthtWaZ
 PT923wDxUXrQF8k3k1OYCEOLmPhO3Le0pox6WFS4HY9KWH6IDnIdFCRdkdtvMxNC+8vN
 QJ6/sV4n0C4sD5TyjlrI97t9nQ/2WqLQK4WunW1tDb9+OHt5n49E/vr+Jm+v62K9Pg1/
 1G4++Ua+6owspLgANr2AZ5Dc3B3DmOlaWbhoMADJQ+rWj67OZC5jaYT8l2v5Ff/aCoPD
 3Oh6ADY3WawlzPwSYZuu41rJw4D0PM20uANxdF8cmma719Do+9O+7gBuCF6HRnOZoZFk
 165A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781718483; x=1782323283;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pbHlGRGiwvgNxO6kudIYk2YnzXcRGcZIMZrCrDhx4CQ=;
 b=URad5R/6awmexd4O1hK9GcRx6HwZerOdeKw8REzf2EI5AQTdWkr72sYgb75l2PLeJT
 58jhAf02JMGHagWi5RiXYVUaoiCVtPdopDoOHUEtAxi16QoZItGtaxa24AoSLFK+g8Us
 yvX5N8USsjPf5q4r7hxMLG/xPPBnom0AKP9SYx0cX8fzSMTiNEXVSUtjKumvJcb4qryd
 w9ugGi+lExUgbuKtTB6THGb5BQBmpGADbm3aLmClruEc1yWmvo8FEY387jEHAu6S7Mf0
 ZXl6a4vAaXYx2xLRopK8be+EVVEcxJpNi13xo3SKwx5bpTLXN+9hYpOZUvKrJ87f80qb
 gmMA==
X-Gm-Message-State: AOJu0YyzuesKFOF1A9/UIAyidQmkm4UquG7kGludE8u7wGGO3zCwOg4B
 AUb3ljADKVIVT9f0DFdNVi2ny0ZLxNE00oXTwmvwlQwDI4dYbehh2Kwt/rLuPk+Kg4wBos9OOBi
 65uvJuaRjn+OT8SkuX671Io+c5t1m9j6whCSa6iLexy12zrYa+JsvXV14RXxipXHUcnRB
X-Gm-Gg: Acq92OHOyOq6M6JTlF/ux+XjNXjp9j6CLXNjwCd3D7cc9JLm/fEIm0U1UfFhf0s2rrS
 WdQsUTB+GcFKJMMCZ6LaPHOD95nW48o0jO/q7jwTZodI+Kbsm9wVyu3bTJy41l0vypCsS4aPXnz
 dVodYQYvccup/VUDaHAx0mEwb5cJD8fu/S3bDUThM1P0FK8+F+0+TwsmyoyS/HCyR6wtl5cffTo
 HoM8R1cIyCCFm/YOxlvqWPL+JIcDucjyX5qoIB/EB/4il0WpP872oFch8FlpG+zXLhNpd20Ym/t
 Z/stAfOd7BpZzi5fbnpKC3K33ZJIK32ooyXLY4RX6dKijqPZgnIIW4jpvwystGNZeEluLfnOWug
 F7BwplqY4EDkoqBA3cz5l99OLuDWjTbwq2JJeppQ9P8XOM3yPUe7kOv+E2BT3T/YLftJEkrpR6Z
 lp3Sm5pyJlikwf3sO1er1xNQK21tvoRBheOFjDM+pObRO0/EgxoZATyCgOaDGUzUDNXdDv6pE1x
 8s1MjPzts6KqZxH7Eug2GGLSZ+zL73XPYIpQpcLh0o0zM/I0+woytNaBio863tn2AxJaezLjG+p
 oBE=
X-Received: by 2002:a05:600c:6305:b0:48a:5565:ec3d with SMTP id
 5b1f17b1804b1-492333cfed3mr77630625e9.22.1781718482420; 
 Wed, 17 Jun 2026 10:48:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4fd31sm176082025e9.4.2026.06.17.10.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 10:48:02 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 17 Jun 2026 17:47:59 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iac54e6772b2c26a09227fd638d24d6e2aa35cec6
X-Gerrit-Change-Number: 1713
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1713?usp=email>
X-Gerrit-Commit: 57bce06563118f9853c6002ae87653f3ec125f15
In-Reply-To: <gerrit.1781716678000.Iac54e6772b2c26a09227fd638d24d6e2aa35cec6@gerrit.openvpn.net>
References: <gerrit.1781716678000.Iac54e6772b2c26a09227fd638d24d6e2aa35cec6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxNzE2Njc4MDAwLklhYzU0ZTY3NzJiMmMyNmEwOTIyN2ZkNjM4ZDI0ZDZlMmFhMzVjZWM2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <25dc131422b37463f1131f03463fbd8fb52209b2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wZuMy-0004ms-PB
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
Content-Type: multipart/mixed; boundary="===============0150936345988851760=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0150936345988851760==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2qWXfQwFZpA="; charset=UTF-8

--2qWXfQwFZpA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1713?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: Fix 1-byte buffer overrun on NTLMv2 proxy responses=2E
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix 1-byte buffe=
r overrun on NTLMv2 proxy responses=2E

An attacker controlling an HTTP pro=
xy (or performing MITM on the
plaintext pre-TLS proxy connection) can trigg=
er a single 0-byte
overrun to a buffer on the stack by sending a crafted NT=
LM Type
2 challenge response=2E

The effects of this depend on memory layou=
t, but could possibly lead
to a crashing OpenVPN client=2E

Reported-by: Tr=
istan Madani (@TristanInSec)
CVE: 2026-11771
Github: OpenVPN/openvpn-privat=
e-issues#116

Change-Id: Iac54e6772b2c26a09227fd638d24d6e2aa35cec6
Signed-o=
ff-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ntlm=2Ec
1 =
file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/13/1713/2

diff --git a/src/openvpn/n=
tlm=2Ec b/src/openvpn/ntlm=2Ec
index 244ee94=2E=2E9c4edf9 100644
--- a/src/=
openvpn/ntlm=2Ec
+++ b/src/openvpn/ntlm=2Ec
@@ -317,7 +317,7 @@
     if ((f=
lags & 0x00800000) =3D=3D 0x00800000)
     {
         tib_len =3D buf2[0x28=
]; /* Get Target Information block size */
-        if (tib_len + 0x1c + 16=
 > sizeof(ntlmv2_response))
+        if (tib_len + 0x1c + 16 >=3D sizeof(nt=
lmv2_response))
         {
             msg(M_WARN, "NTLM: target informati=
on buffer too long for response (len=3D%d)", tib_len);
             return =
NULL;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: Iac5=
4e6772b2c26a09227fd638d24d6e2aa35cec6
Gerrit-Change-Number: 1713
Gerrit-Pat=
chSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>

--2qWXfQwFZpA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>cron2 <strong>uploaded patch set=
 #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1713?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">Fix 1-byt=
e buffer overrun on NTLMv2 proxy responses=2E<br><br>An attacker controllin=
g an HTTP proxy (or performing MITM on the<br>plaintext pre-TLS proxy conne=
ction) can trigger a single 0-byte<br>overrun to a buffer on the stack by s=
ending a crafted NTLM Type<br>2 challenge response=2E<br><br>The effects of=
 this depend on memory layout, but could possibly lead<br>to a crashing Ope=
nVPN client=2E<br><br>Reported-by: Tristan Madani (@TristanInSec)<br>CVE: 2=
026-11771<br>Github: OpenVPN/openvpn-private-issues#116<br><br>Change-Id: I=
ac54e6772b2c26a09227fd638d24d6e2aa35cec6<br>Signed-off-by: Gert Doering &lt=
;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ntlm=2Ec<br>1 file cha=
nged, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/13/1713/2</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/ntlm=2Ec b/src/openvpn/ntlm=2Ec</span><br><span>index =
244ee94=2E=2E9c4edf9 100644</span><br><span>--- a/src/openvpn/ntlm=2Ec</spa=
n><br><span>+++ b/src/openvpn/ntlm=2Ec</span><br><span>@@ -317,7 +317,7 @@<=
/span><br><span>     if ((flags &amp; 0x00800000) =3D=3D 0x00800000)</span>=
<br><span>     {</span><br><span>         tib_len =3D buf2[0x28]; /* Get Ta=
rget Information block size */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (tib_len + 0x1c + 16 &gt; sizeof(ntlmv2_response))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tib_len + 0x=
1c + 16 &gt;=3D sizeof(ntlmv2_response))</span><br><span>         {</span><=
br><span>             msg(M_WARN, &quot;NTLM: target information buffer too=
 long for response (len=3D%d)&quot;, tib_len);</span><br><span>            =
 return NULL;</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713?usp=3Demail">change 1713</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: release/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iac54e6772b2c26a09227fd638d24d6e2aa35cec6 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1713 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--2qWXfQwFZpA=--


--===============0150936345988851760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0150936345988851760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0150936345988851760==--

