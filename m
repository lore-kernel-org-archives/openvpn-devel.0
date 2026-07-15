Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF20C44508
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=scUF++FxLldeWYnWzCVSzBQWeLifSaxOsdEph4PlHeE=; b=fBbWgBhlrnvgZ+SLCDzIlYMMrT
	jbFMoQgaEblrGc3yYiUmE1RTosaZdig9P+9FZVM4iF/DCc27bfEzsrhOYsb0UuIBpwQgOGP/k7hvy
	oHq2QmLg11VaiCIIHBpe9h1jjSz8/mRCTX0H+17rNDsU7bY0Oyi4AcBjtpATtipsz0dY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk1Zq-0004mE-T8;
	Wed, 15 Jul 2026 15:31:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk1Zp-0004m8-T9
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:31:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wGU2hWd/xW7x5tFDCoccDtayRlmYRZRgd4482tNWXaM=; b=SALotyJgfbesl+PJhdWJg96m+W
 QE6DtBDKtYrgJnyL/sCErxzqQ4m/hpUFW2R2DJC8cF62NyUpyre0W1aOXYsxZGEH8TaXvsMc/BKee
 xtMayiKRSbIZszVKgu4tVgrv4E4ZxUDpiwi5N46XBgACyDGY64wmjaAbMuOE29gvJric=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wGU2hWd/xW7x5tFDCoccDtayRlmYRZRgd4482tNWXaM=; b=W
 Msq6cFwrxyXGPOOlLfElWLCJLRLUscVEl4B4jVlh4krmw5RH674gGtwFn6LMnx7VCv9fqg2V8kiE1
 N3pVhSJYrbIzPw5KgUmpubUjnF2cUTez5bdU8eSx61WMX9RBnwDVIE2Xr//1kHBfuKKAAZuDSOLNf
 3QGfm5fy6QDzkhD4=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk1Zl-0000Ex-LJ for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:31:11 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47df6a5202bso3634858f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 08:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784129458; x=1784734258; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wGU2hWd/xW7x5tFDCoccDtayRlmYRZRgd4482tNWXaM=;
 b=N2Cyz0hEGeQEGNBHdBdZbVPZ4r0Tkwl7XoCpuMP9FvQSa7RhbwWWQA49DEzIOOEl9o
 nqBHeerLb8IVbvHxNiwe+kogpIpf1JIyk5w81vsrTE62GloXs0g8JFthbOP2qAKA0e/O
 l5B9QlPvW6RBsp6K10VuUJ9tM455162B48iZL6fuCEcYXLZMOcckN0sS76ubYsfcO2Fy
 2O9FjenSw3JLpvSaN4Ym8B2Bv+gPn2c/NFuGEmLgSRtvPZjqJyDUjgrOJ+paAzA23SbF
 PG3qhwCtWIzcbmhF6Fvedq2Y/m4JafFVcZCtst3RCy97jBQ13BbTyHtgXPj7uYFvcdQZ
 ZLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784129458; x=1784734258;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wGU2hWd/xW7x5tFDCoccDtayRlmYRZRgd4482tNWXaM=;
 b=Fl49ZnnUTCNFSTsvl1KbAQojlsRcOSTIcaIKHG34yj57RF5alXF/k8aM5i5kl7D4tE
 n3hopOo8qDPg1RIf35l9vCiK1s5MMDm5k3Zu2XtKk7BkGNE7S0FPa3Ksb3D6S88zrKVG
 2kXpshfgrlPGJmUhOq0hM81/KdmUDZ2ZdHavufDAMhM8RkvZpHVUSc6KsBBcrju3EAWh
 NcXETMQTv9QExOpiiwtFhlVpcHybFLlq7hMrTr3FqC2Vv+5zvAJABnTN1UTxmvLbdZJU
 uUmsORVWLx26GDTTXXPHtxYZPibf6dNv4sTxY8Jf9/nyt3sAegN6+FinQTNQxZagcoBy
 zCcA==
X-Forwarded-Encrypted: i=1;
 AHgh+RodUezJVD4rNst1CQ2H74wzUsx6OhUsqXm/WHUQ6jWvBDJ1+JhcxUOb6OTrmROujFowe9WcLTpcVaehSfTw@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyaUIum8BVVJZjxbPq7NfAghTFhOQpJdIQ3Bb68lsKLqdnPt+48
 H16yCORckikwbCcaZ3zhGMFkco6hkz8xbj6k8MKDPZsm1FGo6olGnjSXwx3YbqaW+nna4qn1CGK
 HLVrYMTS2fDufdWJP6AXBErJ4H6oIsYogtF28Xjom2XRaDUcAuR1eSdcgMrXPkJIcGIDsAPajBM
 FOgwE5AA==
X-Gm-Gg: AfdE7ckTtE4HeQaU0680RL2StpedlUYePC03RwPHg8gA4TfRPQ0mis9Y496Zlhc6KeA
 pypWdnRlmXeBqBIawTLJrAGKfey1CP3U33FaJbCHklq4ly0prXfoqmhW6w/up88X9wVV33NbeaD
 FMtupT4F/rI9dsw/r71IoqY3Zd/t/+plKDZcymh1CK4xy1w/778ENwEvomCs1Cxy0EUu/w6zCbu
 0Em5zIS6RlU2BQqXChU+2oyPmxFMXwbfzI1Nj9rFxzZzX6UUeEcg8jY57mzXkI/RA4z9S9Ccf3W
 pRXRXJ/sncqW+4b59WCQEDF38waRQXZscqx6qg8wkm58LspFJCSxKzfyi9/ssPRulAOP7tJr4tN
 TmN19fe7dhYE8BKGIA82H+RRWpzIhLy5xOoJOm2U0tKrgo3TKXtozsWrAETvmu+4cyqfaxJOp5C
 hvTRE0hWQwtuOIYHkvD/d6zXXOllvy2lsdR8gY8MS2a/O3/W8G9fX9xNTwA+ECOcykxoaH7Nu48
 YR2FZBf5tLp79YJkOn3zGrFPf7SmNZrQNF3eFncLTz+9WzsDo473Bzu+cNNIxF2wiYY1hCGaJcu
 eGU=
X-Received: by 2002:a05:6000:430a:b0:475:94e1:29d2 with SMTP id
 ffacd0b85a97d-47f4fca8330mr3932023f8f.2.1784129457653; 
 Wed, 15 Jul 2026 08:30:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e0e4sm18431515f8f.4.2026.07.15.08.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:30:57 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 15:30:55 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe
X-Gerrit-Change-Number: 1789
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1789?usp=email>
X-Gerrit-Commit: 08e75f6ea182acd2c9b6d4ca06b5bb35b7b7addd
In-Reply-To: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
References: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTI2NTIzMDAwLkk4MjE5YzYyOTVhY2YyOGZmMTBkZGIyZmNjMjg1ZjgxM2M0MmZhOGZlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1519bcd0811882ec886648b33bc27e34b0413106-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk1Zl-0000Ex-LJ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: proto: correct
 802.1Q length check in is_ipv_X
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
Content-Type: multipart/mixed; boundary="===============5573365474011148711=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5573365474011148711==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hbkzBXU0Vso="; charset=UTF-8

--hbkzBXU0Vso=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

Hello plaisthos,=
 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1789?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: proto: correct 802=2E1Q length check in is_ipv_X
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

proto: correc=
t 802=2E1Q length check in is_ipv_X

Github: OpenVPN/openvpn#1044

This has=
 also been reported twice as a security relevant bug, but
only later than t=
he original finding - and it isn't=2E

While --client-nat would modify a 32=
bit integer "after the packet"
(the place where an IPv4 address would be, i=
n a well-formed packet),
the underlying buffer is always max-frame sized, a=
nd we never look
at the "modified integer" afterwards, so there are no cons=
equences
warranting allocation of a CVE ID=2E

Signed-off-by: rootvector2 <=
dxbnaveed=2Ek@gmail=2Ecom>
Reported-By: =E7=AB=A0=E9=B1=BC=E5=93=A5 (www=2E=
aipyaipy=2Ecom)
Reported-By: Yu Zhang Wong <wongyuzhang45@gmail=2Ecom>
Chan=
ge-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe
---
M src/openvpn/proto=2E=
c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/89/1789/2

diff --git a/src/ope=
nvpn/proto=2Ec b/src/openvpn/proto=2Ec
index 13fe0a5=2E=2E785c021 100644
--=
- a/src/openvpn/proto=2Ec
+++ b/src/openvpn/proto=2Ec
@@ -70,7 +70,7 @@
   =
      if (proto =3D=3D htons(OPENVPN_ETH_P_8021Q))
         {
             =
const struct openvpn_8021qhdr *evh;
-            if (BLENZ(buf) < sizeof(st=
ruct openvpn_ethhdr) + sizeof(struct openvpn_iphdr))
+            if (BLENZ=
(buf) < sizeof(struct openvpn_8021qhdr) + sizeof(struct openvpn_iphdr))
   =
          {
                 return false;
             }

-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I8219c6295acf28ff10ddb2fcc285f813c=
42fa8fe
Gerrit-Change-Number: 1789
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <=
gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=
=2Ede>

--hbkzBXU0Vso=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p>cron2 <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1789?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">pr=
oto: correct 802=2E1Q length check in is_ipv_X<br><br>Github: OpenVPN/openv=
pn#1044<br><br>This has also been reported twice as a security relevant bug=
, but<br>only later than the original finding - and it isn&#39;t=2E<br><br>=
While --client-nat would modify a 32bit integer &quot;after the packet&quot=
;<br>(the place where an IPv4 address would be, in a well-formed packet),<b=
r>the underlying buffer is always max-frame sized, and we never look<br>at =
the &quot;modified integer&quot; afterwards, so there are no consequences<b=
r>warranting allocation of a CVE ID=2E<br><br>Signed-off-by: rootvector2 &l=
t;dxbnaveed=2Ek@gmail=2Ecom&gt;<br>Reported-By: =E7=AB=A0=E9=B1=BC=E5=93=A5=
 (www=2Eaipyaipy=2Ecom)<br>Reported-By: Yu Zhang Wong &lt;wongyuzhang45@gma=
il=2Ecom&gt;<br>Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe<br>---=
<br>M src/openvpn/proto=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/89/1789/2</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/proto=2Ec b/s=
rc/openvpn/proto=2Ec</span><br><span>index 13fe0a5=2E=2E785c021 100644</spa=
n><br><span>--- a/src/openvpn/proto=2Ec</span><br><span>+++ b/src/openvpn/p=
roto=2Ec</span><br><span>@@ -70,7 +70,7 @@</span><br><span>         if (pro=
to =3D=3D htons(OPENVPN_ETH_P_8021Q))</span><br><span>         {</span><br>=
<span>             const struct openvpn_8021qhdr *evh;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            if (BLENZ(buf) &lt; sizeof(str=
uct openvpn_ethhdr) + sizeof(struct openvpn_iphdr))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (BLENZ(buf) &lt; sizeof(st=
ruct openvpn_8021qhdr) + sizeof(struct openvpn_iphdr))</span><br><span>    =
         {</span><br><span>                 return false;</span><br><span> =
            }</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail">change 1789</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8=
219c6295acf28ff10ddb2fcc285f813c42fa8fe </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1789 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@gr=
eenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body=
></html>
--hbkzBXU0Vso=--


--===============5573365474011148711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5573365474011148711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5573365474011148711==--

