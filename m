Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9EB606A323
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QUL7Khxp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=G2HCZM/2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GsryJD81;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=A78F31po
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=T9ABp0xSGqSeEkdPHx0ScXqxo9nvXKg6Xd7BD6D8Ito=; b=QUL7KhxpbX30EqQoYuKpT/aZiJ
	Kkvst08NbzOR8AqYZSG5mcCMsUTAgr2AOLMrnruEMbAwxRdjr7M1PAc/SOKHHjtB6PbfqMY+uqzGh
	7CR2bwlk1WmXhZNkTpMXrnz7tPpHedEMrmzpyBxtKB0YhJGnKfofbvz0dLrivAMQ4C8Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSFPX-0000000023X-1BNm;
	Sat, 14 Nov 2026 15:11:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSFPS-0000000023B-2J01
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:11:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gd8I1zu84UWSpbDzAqiHBtBPUsZkXBao1prZhEM2nlY=; b=G2HCZM/2KjKUijDDTbAdoh+Zw2
 Hvif7dISpMIIyJJZytbto1uGpbRAW0tZt0JeBlCbogCHkcPg873LWY0TiwQniY6pW97nNlQZxWgQ2
 ksoLdU1nfIh0p9l+UICoE2XeqNsb8sh8EHZfh02Q+S6F2UIaZVTHuCTtc0SYktFlydvQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gd8I1zu84UWSpbDzAqiHBtBPUsZkXBao1prZhEM2nlY=; b=GsryJD81LpoJDRdvvqrPHo/KkA
 /GTVJGxTujHjWkB+pIyiUEccIAsvXcoU1nUR0K1FRKdAuqczZgftoyE6pBnwriuaFSSeOsU0iChhX
 +ArELdTosH4LsngR2Tbk9pkqNUuKd9cPYkoC8DOX6NGMncO2edGuACWp9YfYGH5Cx9n0=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSFPQ-000000000Xe-1uz2 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:11:18 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4919a880834so961620f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 07:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794669070; x=1795273870; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gd8I1zu84UWSpbDzAqiHBtBPUsZkXBao1prZhEM2nlY=;
 b=A78F31pocBpfPS2hM8Ve1YBAHD1a7LzsGwvyiWlaQzS0UDhgEXTCDDdbU6V8qAtR+G
 dkssXrbDUOSg0OfhaIjC5+1+Xv/vf89iuo5S+UTHQrVIxzYK+kEsgsnfkBSBwqrA+HaD
 TstuhPFJtPWfVNNXxnzSPtq1E+2auz+4pcwixarYKtKxihjm8aJTkHtzBE8HuTATUsoZ
 NzsIY/OVlch7wrxkIX/BbEeVC7bwt+OSYrLHjHDoJZcM2m9vyvGZ45vSKQ6oXm4WROuS
 gkRwWY7OB9e4dXNzNMuSTKNzWUUMkNbWNBz8r/I+6wSVaATUmUKFv/IUd+nuW2nYMpsV
 Zjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794669070; x=1795273870;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gd8I1zu84UWSpbDzAqiHBtBPUsZkXBao1prZhEM2nlY=;
 b=nM48mBSiPA782vJazIq6RbaJnK3FjkDX5ZaqPY9ypT4AbT8o0VNyUDDCgi42u1/noQ
 r9ZYiNYMp4tlM0vIWz8NqrgTIp5I+fP1Cy8BUxeA88/yxtUaa3iTQH+eSs6EfMmgBz9u
 RHLtDx2PSx9EOcOUmx4nSm8Dvxsio2TV25VNPvKtWqnqbUbv52i8/IojubXMp5bK+JvG
 RRffgMWPahoDyds/nZ6PWOx3RZCyn/MHXvNEJ5CNMo9mGeDJigApFesUyGeU3USsxGui
 T55y0uUpLUHO1lYdmad6QGU5l53k0x1elCJIcEIYPrjDg+9ODFKayqoOBFx2DtvrFjqJ
 JhIg==
X-Gm-Message-State: APuU4Z9WMiAfrBD/1RBCc92OvFoqvoi+5tkp0IzfQ9AEVm5T9jdWKFFc
 /uTad3pKrKPkqBeuIYLQzFq7yJt1oPQkduCo3QwHqJMkYT0pqgeQ9ddXdfbwp8WQysjKqNopfgx
 ZqGK0Rji76b9NpdUCj8jLMLF0ATsa4MSojkzZIIuiLRr8ldHlOmWRGTAzHKQM5bgy+BqQmD4iT3
 9+y+ka1Q==
X-Gm-Gg: AYBFou2PB0yOXKdNFy65ISHMY6pbbasZqp3YhRQJWS/Jv6iy6RdpoYxwbsXCG7ITQz+
 XFxYvbPASMYfibHvAclN6I6aVismrHAPBOPTCtcEYCsS8iRz/uDJ6JQdP8D5xlbJDwLIkT3/U/3
 J14X/WIIplbhqbG6IrZ+oFheCaEkVLGimEULXG/taKr5AarptiLzAw6Im4V1VGkBNRA/nV1DJa8
 /BRWLjBTCPWQhg41gGDBiuVTi6AYBHZrF0ikgCRmKVL3HgYutxwf5dP/Wcvhu1ZvTn6MiAIqhBy
 DGiaZAIYHux0G1pkycRfsIRd8IPlBIlbMqtMRvmANpnmKSWhuPkYgX88f/F4Ka0BX9zytUlAYdz
 /GnLIm/7OQdwR1Zt9+Oyh5YbQu/96SBVoKM3GCGv/lpw6iOLzw2Mz50pbSz49X6OPJGXbW1NoUB
 ur08DdYwNU2a7fzLXD/hCow04KPJn8vHMs5GYq39dmNHSN/SMAj1Z4YyEArVuLgcqOeKPeN8B/B
 ObmK2Q22FpFftAn1OsU3f73nlY/x/Ipw80CBkP8H4h5flAijPhGyP2XqSkBan/EozuF/HtB/q3u
 y2gUsaizYlkfdt+2sWFuJ4pt8embj40+kCHh7NU57vpQQG67Muw4k0hhYNuqajdGU1Sd3ph3CK6
 wKvjHS158fP/niyrgfLmEdqlXzyAL9yJOi11Mcspni3te/ZC+04PF50YwfpYro5e/PtrxbI8EtC
 wKqUaGMpTUcG5BSPQ=
X-Received: by 2002:a5d:5846:0:b0:48e:cd3:64f8 with SMTP id
 ffacd0b85a97d-49dfd36c520mr5525988f8f.4.1794669069111; 
 Sat, 14 Nov 2026 07:11:09 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c608cf46dsm11898014f8f.43.2026.11.14.07.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 07:11:08 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 15:11:07 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ie2d784272184261a62c848e6ad3b7a4570ae6dc7
X-Gerrit-Change-Number: 2165
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2165?usp=email>
X-Gerrit-Commit: 400d7e59c82b7835c64e00ae45db2d55d4895c93
In-Reply-To: <gerrit.1794313546000.Ie2d784272184261a62c848e6ad3b7a4570ae6dc7@gerrit.openvpn.net>
References: <gerrit.1794313546000.Ie2d784272184261a62c848e6ad3b7a4570ae6dc7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzEzNTQ2MDAwLkllMmQ3ODQyNzIxODQyNjFhNjJjODQ4ZTZhZDNiN2E0NTcwYWU2ZGM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b4291b15513924c9710c9026e832052aa20d83fa-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSFPQ-000000000Xe-1uz2
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Change
 return type of buf_forward_capacity_total to size_t
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4584796165127787582=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4584796165127787582==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AbqJdShFqZs="; charset=UTF-8

--AbqJdShFqZs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#5) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
165?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: buffer: Change retur=
n type of buf_forward_capacity_total to size_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: Change return type of buf_forwar=
d_capacity_total to size_t

All callers already want a size_t, so make the
=
conversion implicit=2E

Change-Id: Ie2d784272184261a62c848e6ad3b7a4570ae6dc=
7
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2165
Message-Id: <20261110123659=2E4683-1-gert@greenie=2Emu=
c=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg41077=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M tests/unit_t=
ests/openvpn/test_dhcp=2Ec
3 files changed, 3 insertions(+), 12 deletions(-=
)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/2=
165/5

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 7=
f142c4f=2E=2Ee672b74 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/=
buffer=2Ec
@@ -275,7 +275,7 @@
     if (buf_forward_capacity(buf) <=3D 1)
 =
    {
         size_t len =3D strlen(str) + 1;
-        if (buf_size_valid(=
len) && (int)len < buf_forward_capacity_total(buf))
+        if (buf_size_v=
alid(len) && len < buf_forward_capacity_total(buf))
         {
            =
 memcpy(buf->data + buf->capacity - len, str, len);
         }
diff --git a=
/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index ede3066=2E=2Eae6dcb7=
 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -1068,=
7 +1068,7 @@
  *
  * @return Capacity minus offset, or 0 if \c buf is inval=
id=2E
  */
-static inline int
+static inline size_t
 buf_forward_capacity_t=
otal(const struct buffer *buf)
 {
     if (buf_valid(buf))
@@ -1078,7 +1078=
,7 @@
         {
             ret =3D 0;
         }
-        return ret;
+ =
       return (size_t)ret;
     }
     else
     {
diff --git a/tests/unit_=
tests/openvpn/test_dhcp=2Ec b/tests/unit_tests/openvpn/test_dhcp=2Ec
index =
e331d3d=2E=2E3a84e1e 100644
--- a/tests/unit_tests/openvpn/test_dhcp=2Ec
++=
+ b/tests/unit_tests/openvpn/test_dhcp=2Ec
@@ -50,11 +50,6 @@
     return "=
dummy";
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diag=
nostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 =
static void
 test_write_dhcp_search_str(void **state)
 {
@@ -146,10 +141,6 =
@@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#p=
ragma GCC diagnostic pop
-#endif
-
 int
 main(void)
 {

-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: Ie2d784272184261a62c848e6ad3b7a4570=
ae6dc7
Gerrit-Change-Number: 2165
Gerrit-PatchSet: 5
Gerrit-Owner: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--AbqJdShFqZs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #5</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2165?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">buffer: Change return type of buf_forward_capacity_total to size_t<br><=
br>All callers already want a size_t, so make the<br>conversion implicit=2E=
<br><br>Change-Id: Ie2d784272184261a62c848e6ad3b7a4570ae6dc7<br>Signed-off-=
by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2165<br>Message-Id: &lt;20261110123659=2E4683-1-gert@g=
reenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg41077=2Ehtml<br>Signed-off-by: Gert Doering =
&lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src=
/openvpn/buffer=2Eh<br>M tests/unit_tests/openvpn/test_dhcp=2Ec<br>3 files =
changed, 3 insertions(+), 12 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/2165/5</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><s=
pan>index 7f142c4f=2E=2Ee672b74 100644</span><br><span>--- a/src/openvpn/bu=
ffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -2=
75,7 +275,7 @@</span><br><span>     if (buf_forward_capacity(buf) &lt;=3D 1=
)</span><br><span>     {</span><br><span>         size_t len =3D strlen(str=
) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (buf=
_size_valid(len) &amp;&amp; (int)len &lt; buf_forward_capacity_total(buf))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (buf_size=
_valid(len) &amp;&amp; len &lt; buf_forward_capacity_total(buf))</span><br>=
<span>         {</span><br><span>             memcpy(buf-&gt;data + buf-&gt=
;capacity - len, str, len);</span><br><span>         }</span><br><span>diff=
 --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>in=
dex ede3066=2E=2Eae6dcb7 100644</span><br><span>--- a/src/openvpn/buffer=2E=
h</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -1068,7 +=
1068,7 @@</span><br><span>  *</span><br><span>  * @return Capacity minus of=
fset, or 0 if \c buf is invalid=2E</span><br><span>  */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static inline size_t</span><br><span> buf=
_forward_capacity_total(const struct buffer *buf)</span><br><span> {</span>=
<br><span>     if (buf_valid(buf))</span><br><span>@@ -1078,7 +1078,7 @@</s=
pan><br><span>         {</span><br><span>             ret =3D 0;</span><br>=
<span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return (size_t)ret;</span><br><span>     }</span><br><span>     else</sp=
an><br><span>     {</span><br><span>diff --git a/tests/unit_tests/openvpn/t=
est_dhcp=2Ec b/tests/unit_tests/openvpn/test_dhcp=2Ec</span><br><span>index=
 e331d3d=2E=2E3a84e1e 100644</span><br><span>--- a/tests/unit_tests/openvpn=
/test_dhcp=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_dhcp=2Ec=
</span><br><span>@@ -50,11 +50,6 @@</span><br><span>     return &quot;dummy=
&quot;;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic i=
gnored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> static void</span><br><span> test_write_dhcp_search_str(v=
oid **state)</span><br><span> {</span><br><span>@@ -146,10 +141,6 @@</span>=
<br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> int</span><br><span> main(void)</span><br><span> {</span><br></pre><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=
=3Demail">change 2165</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2165?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: Ie2d784272184261a62c848e6ad3b7a4570ae6dc7 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2165 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>

</body></html>
--AbqJdShFqZs=--


--===============4584796165127787582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4584796165127787582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4584796165127787582==--

