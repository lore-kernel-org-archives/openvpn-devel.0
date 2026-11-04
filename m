Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC13606D801
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OwRUBmYe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jwlPWdel;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G4RdlNBD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=U/klnzA8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=amm3mubVXBkUZlGGYoj/SQ/1693BpsKblNC7oD0fYqM=; b=OwRUBmYeHpJrbBQ3+iUktidqEu
	7iW5b4poX7KgjofQg+At4f2YcWbJbh20X+MAxhcghz6AJ/hZPN+zaIQtEs1pTTBjAvwZBF+RPs/ox
	VvnFauiWwpf6GO5c4RW8+ZREDYyOqXRdqcOGnh9kp57WqVt8eOox8qlvPqmgHxJM6DuU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOeC6-000000003y8-3FPb;
	Wed, 04 Nov 2026 16:50:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOeBh-000000003wk-0ah1
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:50:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2OqD99bPnOzLcYNEp4MEzPIFRGWgV+FO+0FJxnBX9Uw=; b=jwlPWdelORSgJxXhxQZCryDIgU
 uWMGeofPGdg/vTMXYE4OhCmhGSpHnqqzlME1GaAUhyP8InhWNId/j8kyJb0uHsIZLVkh+sPRuj7p4
 ZkVlR5Y0n0Du7hMxGzP4UnjXGCyFxnzqDWORET5lfl0NWKN4WL89sJec0oGbi8ZP4elQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2OqD99bPnOzLcYNEp4MEzPIFRGWgV+FO+0FJxnBX9Uw=; b=G4RdlNBDuxKWoyAtBMIwXniVS9
 1nAvB4tGc6aNyk0oyEnQE/xhAIKwUH33d1LPY5yFZ6fxI9FehKxajhSYeDqMYCmg91SNPy1OY+ZLk
 LUc5PIYX8FykiFRgyabMotXWDWNt7CgNYDDNcV+CsZn+JEPsi2SDH2G0o8dMHssycu4g=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOeBf-000000001Ch-18ZR for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:50:13 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so6835625e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793811005; x=1794415805; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2OqD99bPnOzLcYNEp4MEzPIFRGWgV+FO+0FJxnBX9Uw=;
 b=U/klnzA8iyxoBEPR1DgQUnUKqHRw1I9I4/5fDS6icMVinMaIRrkXJkW9+Yg2Fsih0D
 WrzfVdHme50S2+/IJOCxNuPHKbcjsUNJ/GyRf996r5jDw7Gg2pA3+kNTIYuaZmNNfbNk
 tE2371I9Y+Gvm6QBvHVZ/8UUOQXJ48YmH+XLOhciTkH7jn1xTflRvz7PbRrOfRM6UYpT
 NKT7TAn4HfRG4VBEL6F3YsgTQFEbX7oVZoABEcg5g9EN/K2Ef+ufqNPgonMwfxUR1hsg
 UzChSJ+y8z3cW59z/zjJgwraUq64ax1hvGrwO/E8F8lzsBfq/d/ksi8OQOBiUm/FFJNt
 NFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793811005; x=1794415805;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2OqD99bPnOzLcYNEp4MEzPIFRGWgV+FO+0FJxnBX9Uw=;
 b=1lqgwpeFDs43WYqcGFdaHnc50vFlWm757zu72E3ZHAoD5Zp6JV4RKQQC1A09QH2gWv
 I1Gd2Ij0fV006mzIIO4fT4rsMIszbSDcDCU9fUWbgm5DT1OLIK9+0EQomZfieQAx/JvA
 lJ0Ll8wdM+KqNLuEPdBYbwo25skdKUFMjhD9Dxv7H6/477G5pPjt9kinRx+9YOMGPbPb
 AoHRp0f4onR2stsQiVpvxHMAMAmdDf7ytQhCSu/vejZZWkE/0f8fcf2SOc94xhJsr5Kv
 XAM9TIX2tySeFGUGGTpgj+0EUwdAIdRhb9nxPJB4uq2rS9rmFSC0nRwB2s6Xawl/eaN7
 /YIg==
X-Gm-Message-State: APuU4Z/S5x/Ih2/thynJCHg0kQ4HXm5cSwkPzFWDQIxGHZe1/NI0lnpm
 S51tDO2uXmUsD2b2ml8hc3hLQzwcsyCUCo+BsTe4g54VdwM9c9g0YSj1AO3CaQEvTTTHKKhm+6G
 5v3D8GFp4uAmMFEJQlWa9Mci5Gowxr75xjIkbjcKAarfV+XCSoMI2nJuhBhc5Oumo4FQy
X-Gm-Gg: AYBFou3kTH8ggAwjBbY+BGBtiHOKdgyADLmHCdgPTur0/0V2UY6Un+9sg5aFxXJW+cq
 c+0tI/EHRPbWBFluy0g6GjKGyDOZolg3SB0NJ1pTZiSivKMA9uLbVPbJN6+3+xhvj+rFFj6UFSL
 upB5glygN9s5mY1H1UBorzpgTXhZkmJgYhhjq2mRcWiOvOwIIPtNg6h6By7NlhpXN8LR9uljUHD
 z8RzgGg1Lj75J0HkCH0lclxd03CxBgNby70c7Yv9gREhq1VY3Vo79encRxVi2DaKie+FAr4Egkx
 ZEUE4gxQjr7BE9PEVRhXnUL4nnotjN00ZvCkegVaQ74I8LWkQGIiF36aKg9qH4sdo0h5TrQbqms
 FEZgDHW1wr+kSmQjRlnKtfNsNzE76hOKx5NSZiDbnCZM4p0+uTme1yfM29qLACGi9sFvR7haupT
 big2+RdfCIdAf6CkyiMDSNkUIYEsauTiUNUqBUiYOU7n8KnGB+uZSNc0MyQguT+6JQUAK6NYRgl
 9+9TmJ1ZPvnh5tnlPyVmgeB0whguTUGiptWy2MtC1vNPS0Lnoo/lQckqkR4xCkjR2+qPrDoaJic
 tvZizF/BgJ+Sj6hZ5ynscS0IcY6qh0dJJHxM2zgJTaVHFw38fdt259JomEgekoNkUvhg5qqY2mY
 dER5kMIEac6WQnT4NfVFx7ZlKU0nM3YxZHoPbeO0mmU7xrErqbYBmJNNZW85nUqZEaxqvuy4PMA
 B0iNntJt32I5vZeHNpogm8Q/cT5aPrQXtQ1+M=
X-Received: by 2002:a05:600c:4585:b0:4a7:8fe8:130c with SMTP id
 5b1f17b1804b1-4ac1889d5a1mr366740335e9.28.1793811004365; 
 Wed, 04 Nov 2026 08:50:04 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43c17ecdasm96115705e9.5.2026.11.04.08.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:50:03 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:50:03 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5542520825112dfd64aab332bd76333b74d7fec0
X-Gerrit-Change-Number: 2128
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2128?usp=email>
X-Gerrit-Commit: 21efe909a89fd6eb13b04849505301312a22c35a
In-Reply-To: <gerrit.1793782065000.I5542520825112dfd64aab332bd76333b74d7fec0@gerrit.openvpn.net>
References: <gerrit.1793782065000.I5542520825112dfd64aab332bd76333b74d7fec0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzgyMDY1MDAwLkk1NTQyNTIwODI1MTEyZGZkNjRhYWIzMzJiZDc2MzMzYjc0ZDdmZWMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fbe67afd2ea7340ce6e50ba3059e2479483be874-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOeBf-000000001Ch-18ZR
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: don't
 return freed token groups from GetTokenGroups()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6520558347692816570=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6520558347692816570==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="znm2dRd28tI="; charset=UTF-8

--znm2dRd28tI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2128?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: openvpnserv: don't return=
 freed token groups from GetTokenGroups()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: don't return freed token groups f=
rom GetTokenGroups()

When the second GetTokenInformation() call failed, th=
e freed buffer was
returned=2E IsUserInGroup() then read it and IsAuthorize=
dUser() freed it
again=2E Return NULL, which IsUserInGroup() already handle=
s by skipping
the token group check=2E

Broken since e82733a1 ("Fix user's =
group membership check in
interactive service to work with domains")=2E

Ch=
ange-Id: I5542520825112dfd64aab332bd76333b74d7fec0
Signed-off-by: Razvan Co=
jocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2128
Message-=
Id: <20261104105737=2E7333-1-gert@greenie=2Emuc=2Ede>
URL: https://lore=2Ek=
ernel=2Eorg/openvpn-devel/20261104105737=2E7333-1-gert@greenie=2Emuc=2Ede
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/=
validate=2Ec
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/2128/2

diff --git=
 a/src/openvpnserv/validate=2Ec b/src/openvpnserv/validate=2Ec
index 6a13a0=
6=2E=2E2858f62 100644
--- a/src/openvpnserv/validate=2Ec
+++ b/src/openvpns=
erv/validate=2Ec
@@ -227,6 +227,7 @@
     {
         MsgToEventLog(M_SYSERR=
, L"GetTokenInformation");
         free(groups);
+        groups =3D NULL;=

     }
     return groups;
 }

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2128?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I5542520825112dfd64aab332bd76333b74d7fec0
Gerrit-Change-Num=
ber: 2128
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--znm2dRd28tI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2128?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ope=
nvpnserv: don&#39;t return freed token groups from GetTokenGroups()<br><br>=
When the second GetTokenInformation() call failed, the freed buffer was<br>=
returned=2E IsUserInGroup() then read it and IsAuthorizedUser() freed it<br=
>again=2E Return NULL, which IsUserInGroup() already handles by skipping<br=
>the token group check=2E<br><br>Broken since e82733a1 (&quot;Fix user&#39;=
s group membership check in<br>interactive service to work with domains&quo=
t;)=2E<br><br>Change-Id: I5542520825112dfd64aab332bd76333b74d7fec0<br>Signe=
d-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert D=
oering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2128<br>Message-Id: &lt;20261104105737=2E7333-1-gert@=
greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20=
261104105737=2E7333-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/validate=2Ec<=
br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/212=
8/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpnserv/validate=2Ec b/src/openvpnserv/val=
idate=2Ec</span><br><span>index 6a13a06=2E=2E2858f62 100644</span><br><span=
>--- a/src/openvpnserv/validate=2Ec</span><br><span>+++ b/src/openvpnserv/v=
alidate=2Ec</span><br><span>@@ -227,6 +227,7 @@</span><br><span>     {</spa=
n><br><span>         MsgToEventLog(M_SYSERR, L&quot;GetTokenInformation&quo=
t;);</span><br><span>         free(groups);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        groups =3D NULL;</span><br><span>     }</sp=
an><br><span>     return groups;</span><br><span> }</span><br></pre><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2128?usp=
=3Demail">change 2128</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2128?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I5542520825112dfd64aab332bd76333b74d7fec0 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2128 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=

</body></html>
--znm2dRd28tI=--


--===============6520558347692816570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6520558347692816570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6520558347692816570==--

