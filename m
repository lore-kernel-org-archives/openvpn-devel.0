Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D07EC61DD3
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GRkOydp911kEtl1/k16tFratf2D0pj8xeXrrahR5pPQ=; b=SJiD5zRix4xG5gkTVtZLuIAY+o
	CMyGAkDvm0fdGb06fL6DSmDNUxpRwIoDGBvBvM9R9eHPdNC4SpsztHx6rQkkgoVRbfjOOWbPye/U6
	HJDvF3KL/XKP0B9o0anzgVMyf5c9BamH+GNd6/bTvk424jZuqQIJ6U6b5VbqZfmPEVlM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1PSm-00066x-WE;
	Tue, 01 Sep 2026 14:27:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1PSl-00066j-OB
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 14:27:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Dz0NS0uU2mUcr3AGq+RRooPyygPK82G0EUsVijDZUp4=; b=Gl1eKK3InQLgB/ARN0lv36yyUY
 AYOnk9Ke+IlozfLliKKJ0jEJPT61Nop8ZUjtl+x9Uki7mDquYJ6171Xl+w6fJXGwiVJNLkR12s902
 h7kr64KRCMFmFO/a5/CU+2YmZWAnAOL/mxglqyiHya7R/UEAJAFe50RTtAAvG8oq+xa0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Dz0NS0uU2mUcr3AGq+RRooPyygPK82G0EUsVijDZUp4=; b=S
 PWy4b2ivEdqZeQUrxSlcp2YkRg9WCroxM5sBVjR2zZxAGzA2BU7abVRL3hcgqWSkfrtj2XSvSd3XO
 ippTg5MJ64K1MgTagStlX+Ai0mVYt9Fnkj0e5DUmeXYa7lc0X26gN3Cnddn0zzWDYFvemEk7rF/gw
 soCG4Dw7WFyr6Q2E=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1PSl-0003im-RL for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 14:27:48 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49b8687630fso35424915e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 07:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788272861; x=1788877661; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dz0NS0uU2mUcr3AGq+RRooPyygPK82G0EUsVijDZUp4=;
 b=gR4ZF47Q6ST82Zal6YLyBcdjFsvZHkvIwVX4UNDEH9Sk59FpFs1eUJ9An5fHPqVzHC
 GGElhKWp6GUjs7j+Tbuv6j0Q4nY6q0z0hWCcXbAytOOxAqp7IipDYGnYEoTOWOZp5RVN
 2JRCVuH39BMSXIgevSfYi60D3U2eOe874iniFW8qYdsl0oAe5QxcDzqTN3S4Nt7G2ffw
 BQxPO9quGnsxXV6AXk20l9qdxSZV9aLoU9UFBP3x3YSUe2xjuDQ9SaW2COfQU0C2wqH8
 Kq+LgEj5+/O+4JcFSl6bNZzD9DQZVOei+axDNxEi2Jn15GWJzmBuoZRuXxc++IR5Vavs
 N58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788272861; x=1788877661;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Dz0NS0uU2mUcr3AGq+RRooPyygPK82G0EUsVijDZUp4=;
 b=rZwj/oKCymuYxlrXDc0kzRS8bo5/4LrZ+zmSbGXbNVm1ZP8KAf8l9isLP1ZcZH0yz3
 cyirYK57Hv05oKb7V4Sr+iYTaXxiit3Zt+W8qX0nrM1uGsTle1rrRnpSDWNtUpsQlZvh
 mNkPPnVpxJjC9QHexd6unPq45Uwd1Ct8b13MaVzYScD8pkTw6T1HrdAZB8o8GT69lu/8
 LDaJPwubxGjyN8CMGhUYVlky3Vehx1gHFG7RsIXt39Asi1p82XgAl+uON/UWKSF77eol
 roexu2nUfXNuktM9Eedz522+Ba5QK/BqntZc2cWnt+kd35uoreCZijwuft/4xEEjrZPy
 NpBA==
X-Gm-Message-State: AFuF++nvbaW093M+8z1d/4o4OT0JzVHRZzeWfVSaHmvCWccXIjLmDziZ
 QAgQa+Sn9XFYcX2zjQKENA74aKurQUCJqnsHBhbJ26qr59HjH6PpOGg2F2hg35/g9TYp8grweha
 Tm550IhDIiUk2IScOetxuuSOIlQ3XBKRmazWTw4texUCPLPZy46RbK80n/OJ8Dv6F2GkX
X-Gm-Gg: AR+sD12s2agDmuJWU7funt5QtAtqYJbu7YG0g8KZwJzFK12DhghGiXV4b4sWafbSaff
 vHYjlo22tvDvCJZDtpsB+Y8bsHUL2ugLcxlPo2otmTo4+wz0MAPXPkCgmLH8mQCmBQwQcPMwEHQ
 KWFMMdXRE3fzrCjmX3aVkAoxopXA+gOxn9LVP3sy9Brlp/jBtHoIXhNT1YjqISvfmTnFZPlZFrs
 MZ9DvE1LlPm6O41KmX53M3zcqh/1cSjYqD0m3mN76thR/WVtN3dWZdCp3dM1s6G3xZoge92VPRJ
 pLHhbd8mSbZowbtm3TEa/CfpJ+Tg+mmhamX6mxDv46vcuVXXqFJNXXtI406l49/HuDQ0kjN+uTH
 3UrVVN8qvPu4cAsnRg+6Zmt04YYQt1C3uoOibqVx2mB0q/ZC8MTSl3bRxfbvlb61gcMEIVbrnmd
 6JZYviGaC+aqPGpcssUT33NFGjt9Z2NMcpsEgOXqH7uWK1fI+7KA+BIwNZ4jzc/spQ+Q9EzZdQK
 M7A/+oTPsy22xL/yOdYciCtsT3XhgOpIWHKsg6SqDAdJwcTuQlMTVNSdqOPn+78ERdTSzFQOAAG
 DSmeld8Ut8RfxXY3bGJKUjIs0ha4vIS5QqTTiiwFvJ/pv7UoVyXPbBTtmD0zmA==
X-Received: by 2002:a05:600c:870e:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-49cdc43f461mr187384355e9.12.1788272861065; 
 Tue, 01 Sep 2026 07:27:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce365048asm10594465e9.5.2026.09.01.07.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:27:40 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 14:27:38 +0000
To: d12fk <heiko@openvpn.net>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1a181d65ad0d5e3765f57373a6ee223ede909dea
X-Gerrit-Change-Number: 1888
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1888?usp=email>
X-Gerrit-Commit: c5308c026f837215f6f7eccad82b5c3601a7b418
In-Reply-To: <gerrit.1788192180000.I1a181d65ad0d5e3765f57373a6ee223ede909dea@gerrit.openvpn.net>
References: <gerrit.1788192180000.I1a181d65ad0d5e3765f57373a6ee223ede909dea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTkyMTgwMDAwLkkxYTE4MWQ2NWFkMGQ1ZTM3NjVmNTczNzNhNmVlMjIzZWRlOTA5ZGVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a728b1c5d19a7a737c59db38e39a2a5f96ea74aa-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1PSl-0003im-RL
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: fix
 off-by-one input validation
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5447590627714175146=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5447590627714175146==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tSrtGo8SHNI="; charset=UTF-8

--tSrtGo8SHNI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello d12fk, plaisthos, razvanc, 

I'd like you to reexamine a change=2E Pl=
ease visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1888?usp=3Demail
=

to look at the new patch set (#2)=2E

The following approvals got outdated=
 and were removed:
Code-Review+2 by razvanc


Change subject: openvpnserv: =
fix off-by-one input validation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

openvpnserv: fix off-by-one input validation

Code chec=
ked for a hypothetical third trailing NUL character,
instead of the second=
=2E Could read one extra octet beyond the buffer if
it is used up by the da=
ta completely=2E

Discovered and reported by BreachX Zero Day Labs, using T=
yphon AI Mil v2=2E
Contributing Researcher: Vivek Parikh=2E

Reported-by: V=
ivek Parikh <vivek=2Eparikh@breachx=2Eai>
Tested-by: Vivek Parikh <vivek=2E=
parikh@breachx=2Eai>
CVE: 2026-78221
Change-Id: I1a181d65ad0d5e3765f57373a6=
ee223ede909dea
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Ack=
ed-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Arne Schwabe <arne=
@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1888=

Message-Id: <20260831184732=2E3417-1-gert@greenie=2Emuc=2Ede>
URL: https:/=
/www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38856=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/ope=
nvpnserv/interactive=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)


  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/88/1888/2
=

diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=
=2Ec
index 0c6e23f=2E=2Ed2288b9 100644
--- a/src/openvpnserv/interactive=2E=
c
+++ b/src/openvpnserv/interactive=2Ec
@@ -2959,7 +2959,7 @@
         cons=
t char *rdom =3D msg->resolve_domains;
         size_t rdom_size =3D sizeof=
(msg->resolve_domains);
         size_t rdom_len =3D strlen(rdom);
-       =
 if (rdom_len && (rdom_len + 1 >=3D rdom_size || rdom[rdom_len + 2] !=3D 0)=
)
+        if (rdom_len && (rdom_len + 1 >=3D rdom_size || rdom[rdom_len + =
1] !=3D 0))
         {
             return ERROR_MESSAGE_DATA;
         }

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1888?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1a181d65ad0d5e376=
5f57373a6ee223ede909dea
Gerrit-Change-Number: 1888
Gerrit-PatchSet: 2
Gerri=
t-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerr=
it-CC: d12fk <heiko@openvpn=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>

--tSrtGo8SHNI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1888?usp=3Demail">View Change</a></p><p>The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by razvanc<=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">openvpnserv: fix off-by-one input validation<br><br>Code c=
hecked for a hypothetical third trailing NUL character,<br>instead of the s=
econd=2E Could read one extra octet beyond the buffer if<br>it is used up b=
y the data completely=2E<br><br>Discovered and reported by BreachX Zero Day=
 Labs, using Typhon AI Mil v2=2E<br>Contributing Researcher: Vivek Parikh=
=2E<br><br>Reported-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br=
>Tested-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>CVE: 2026-7=
8221<br>Change-Id: I1a181d65ad0d5e3765f57373a6ee223ede909dea<br>Signed-off-=
by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by: Razvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne@rfc2=
549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/188=
8<br>Message-Id: &lt;20260831184732=2E3417-1-gert@greenie=2Emuc=2Ede&gt;<br=
>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg38856=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 1 =
insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/88/1888/2</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><b=
r><span>index 0c6e23f=2E=2Ed2288b9 100644</span><br><span>--- a/src/openvpn=
serv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec<=
/span><br><span>@@ -2959,7 +2959,7 @@</span><br><span>         const char *=
rdom =3D msg-&gt;resolve_domains;</span><br><span>         size_t rdom_size=
 =3D sizeof(msg-&gt;resolve_domains);</span><br><span>         size_t rdom_=
len =3D strlen(rdom);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (rdom_len &amp;&amp; (rdom_len + 1 &gt;=3D rdom_size || rdom[rdo=
m_len + 2] !=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (rdom_len &amp;&amp; (rdom_len + 1 &gt;=3D rdom_size || rdom[rdo=
m_len + 1] !=3D 0))</span><br><span>         {</span><br><span>            =
 return ERROR_MESSAGE_DATA;</span><br><span>         }</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1888?usp=3Demail">change 1888</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1888?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I1a181d65ad0d5e3765f57373a6ee223ede=
909dea </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1888 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d=
12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

=
</body></html>
--tSrtGo8SHNI=--


--===============5447590627714175146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5447590627714175146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5447590627714175146==--

