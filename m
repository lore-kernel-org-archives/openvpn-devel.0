Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D11C61DB6
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VgU3jPqHQSr7sUGtUAmPuE6MxK8kzoXJ5Tv8ivnSQ04=; b=RCILwtRHxbQ9HUeucciwVtFxEw
	cMvwJmmmLwbuuYbtKx5XdVSYMw3jZDP1McVN/PrGeGMCHCznsgh6EtL1Jj5ILLV4q0JUjD2V8o67E
	QBcliUXBoFobe1stNS9F3L66iUpc5ZPgWBkU7BDAjnU6332cWar1VINJi61ylAl3+oi4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyldM-000701-4q;
	Tue, 25 Aug 2026 07:31:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyldL-0006zh-G2
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:31:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WKMzJi7jgpDJvweJXUWG56nmQ9Dj/G7kU8793aAIwAs=; b=a8fqX6ROv5N0Y3o5i1pz5e0HrG
 k3E2B7a4k6taMUzlMirrAnm+d6s74xvh/3yndqTkiWkOz3X5vXDsGyXqG6x/SqB49QX+UoL6m0N9y
 qdw8h7gg02aIAQEzke6MukNnoMAYig92ySu4EYsBT2wgtvqzkgTLEOuCELns06B4M7Rc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WKMzJi7jgpDJvweJXUWG56nmQ9Dj/G7kU8793aAIwAs=; b=Z
 roP7EuHMXqLaY2jokiiAoCkx2eO87/aaFmaNm0Cd7qo9dQ6YA60w5AIQ7tgEZ9gwR3pVpbIb74Tri
 TDMy9ixk1viQl3b3CjZp/YLX+PODXuq/g3ea48uzOMaQfdNEFRTtQbwrHN+IHKIp6FCsKfcIJ9lH2
 WXeBEzlu5cUiIKsY=;
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyld0-0000LF-Fb for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:31:27 +0000
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso7468717a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 00:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787643080; x=1788247880; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WKMzJi7jgpDJvweJXUWG56nmQ9Dj/G7kU8793aAIwAs=;
 b=VirT17XQ/4qiz/im4cseq4xJgKZTGqIJkc/Hsdxsnu4cx/a/sQYGoX2MIsSV5Gca2h
 tF4dT7bYY8/3t+YFhscI71B5LL/1jhJ5v0zMrKcJy5fz4TLgvprHUmuLtSRoElie09cA
 /pVSJH3L7FnW5iniAwmNa7ndttMvhnvuD3PoDLNbop+U2A54L06QflOYy/lpKBFSWhzQ
 ehV7DjqGFX6+WXZi58vKsxtrsK+CqrrIaG14W6+UXm+WOvX0cNmwi0t8pHEcFby6uu5u
 HOuIzug2fUcue2eIR6ElDNVIC8xsjs8/2wo31PctXTTb/C2hdkGCxsUi9biW//v/sTAT
 rQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787643080; x=1788247880;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WKMzJi7jgpDJvweJXUWG56nmQ9Dj/G7kU8793aAIwAs=;
 b=dcCLY1Uc3nXBbM4RwKgMwslopCv/b5QZ7PJjWphcHgX25+Ut16GE5j0vtgjT4xzpVY
 3dgTc+X8SbagDdTFiSPpXQmhMVVi7N14z9RhUVmegIoM+HFLnqHlGIARSNTJkzvoR4gg
 E+oTg3d9t33TbAH57KzFbBOohMhy/vZEl1yOl5UhBFWmscMpXiJYSPzp5xU2uPPXymuP
 ZV3eyoiKQgDLEM7TZEceHPO9BJUcRdKRhqlyWwGUdA3nI6Flw2ly0b/Xv2iAkA7SCuX6
 YusX+XlvO3NE85vtYCA/6ZVyCLBLsTuhhgmLM4xVkhBuhkhomswR66Z9v1GwxWBxC15H
 ySUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RruX38MJbaK3U1fyW+ggVkVyOupDdkbGPyMeVhilSHpkXZemcVzNp6/LY3z6Ns4vQW6zprs3DbaIE0+DwpY@lists.sourceforge.net
X-Gm-Message-State: AFuF++lS1WIuSjJphLkDnmOK3uxNy5IfJdoiIExxNMVwfkNrGQJ62ZFK
 Ug/XPp4uGKwQY2AP8YwjGMLvL69Js7nPtefVF8xEx/lwyFSri0E6NxryacuPHCrot+hcyie2iXl
 NBM5mNuJOhQ8fQgI834453llSgvevaRr6WxwUVZ4/Lnq7kifRxoP9rT0epc/IHnRj9QKS
X-Gm-Gg: AR+sD13oXhhjBmPDmkG30zfhwjox+jxrd8ZDBZ4b+ZWTXJSYRCCIZRRJpb8EFPkQHzF
 5iqP4GpetCqQI8mBegAtXQNOTZSQL2WHsGFZeq7XGyMJIBslhpIlkoTo7Ok6rIDJ2XuixchWg8/
 lCYzrg4BBMGQFwIwjuAe4VSmBHCW2J9V3DkJaIf11eJas3on7o6WG0UfgfCkwZ61fWZY/5aJkrn
 LCSZuP0cKjE3iwou/fwLWX/SmmSAvAnV/2p02p/JE6dNpLMFHyhLe9PZ73s/mRAWIVBuogxlSFV
 Ll859/tZaXmBzIkhEMaVBUqjcl9XzxK7MLLuEIJzseZrdwdnsVL05SLjdusKCgM80xS454JuFQl
 eCAs4dBfSiZ/lRqqMpMjdSwbM9n2P3R+0jkFxQTvtHs/ZvYzy/GmlnM15+rNPQaMmSB6lG7ZAw3
 D1Y2D9H6EvPQFJlpaPxGioyxNsehhEhf4HdBvdAFA2vUVi8bqDSyQITn5ph+7eMZTjEgCvtkOD3
 qvXVIUzvIPsD08qG8m3eVzHYEf3VU9Fp5nEDcak2iwyd3qmjI1iG8/7QX3yFCmUNu3ABzNxLLmu
 FVjGIKypQtZPbvuHt3RLDn0UTveSktXB1Rm9Nk9L7nwC4KsLqkGDEMUN/Ebfi8k=
X-Received: by 2002:a17:906:7316:b0:c20:fe93:a86 with SMTP id
 a640c23a62f3a-c24e5b965bdmr437519366b.18.1787643079361; 
 Tue, 25 Aug 2026 00:31:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24968ba7b6sm1559066766b.62.2026.08.25.00.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 00:31:18 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 07:31:18 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I395cc722d53201d775c20ae3cf9d50149bfc90ed
X-Gerrit-Change-Number: 1863
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1863?usp=email>
X-Gerrit-Commit: 32d04ebb0adae7e236e3bea708b84cf576cbd0e2
In-Reply-To: <gerrit.1787570563000.I395cc722d53201d775c20ae3cf9d50149bfc90ed@gerrit.openvpn.net>
References: <gerrit.1787570563000.I395cc722d53201d775c20ae3cf9d50149bfc90ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLkkzOTVjYzcyMmQ1MzIwMWQ3NzVjMjBhZTNjZjlkNTAxNDliZmM5MGVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <860fee538ddb14a81e962c8570342ab3dd9b99b1-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyld0-0000LF-Fb
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_win: Remove
 unused dco_start_tun declaration
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3936110455145185140=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3936110455145185140==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gGqv4tu4/zc="; charset=UTF-8

--gGqv4tu4/zc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1863?usp=3Demail )

Change subject: dco_win: Remove unused dco_start_tu=
n declaration
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


dco_win: Remove unused dco_start_tun declaration

This function was remov=
ed in commit
1625d927fc79e2926015ded06a01fd8e460a4bc7, but the
declaration =
and the non-Windows definition were
left behind=2E

Identified by cppcheck=
=2E

Change-Id: I395cc722d53201d775c20ae3cf9d50149bfc90ed
Signed-off-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1863=

Message-Id: <20260824161512=2E1720-1-gert@greenie=2Emuc=2Ede>
URL: https:/=
/www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38640=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/ope=
nvpn/dco_win=2Eh
1 file changed, 0 insertions(+), 10 deletions(-)




diff =
--git a/src/openvpn/dco_win=2Eh b/src/openvpn/dco_win=2Eh
index ac3ce33=2E=
=2Ea92e5ad 100644
--- a/src/openvpn/dco_win=2Eh
+++ b/src/openvpn/dco_win=
=2Eh
@@ -65,8 +65,6 @@
 void dco_p2p_new_peer(HANDLE handle, OVERLAPPED *ov=
, struct link_socket *sock,
                       struct signal_info *sig_=
info);
 
-void dco_start_tun(struct tuntap *tt);
-
 bool dco_win_supports_m=
ultipeer(void);
 
 void dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr=
_t dst, unsigned int netbits,
@@ -79,13 +77,5 @@
 
 void dco_win_del_iroute=
_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int netbits);
 
-#e=
lse  /* if defined(ENABLE_DCO) && defined(_WIN32) */
-
-static inline void
=
-dco_start_tun(struct tuntap *tt)
-{
-    ASSERT(false);
-}
-
 #endif /* de=
fined(_WIN32) */
 #endif /* ifndef DCO_H */

-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1863?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I395cc722d53201d775c20ae3cf9d50149bfc90ed
Gerrit-Chan=
ge-Number: 1863
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Review=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>

--gGqv4tu4/zc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1863?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">dco_win: Remove unused dco_start_tun decla=
ration<br><br>This function was removed in commit<br>1625d927fc79e2926015de=
d06a01fd8e460a4bc7, but the<br>declaration and the non-Windows definition w=
ere<br>left behind=2E<br><br>Identified by cppcheck=2E<br><br>Change-Id: I3=
95cc722d53201d775c20ae3cf9d50149bfc90ed<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
863<br>Message-Id: &lt;20260824161512=2E1720-1-gert@greenie=2Emuc=2Ede&gt;<=
br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38640=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/dco_win=2Eh<br>1 file changed, 0 inserti=
ons(+), 10 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_win=
=2Eh b/src/openvpn/dco_win=2Eh</span><br><span>index ac3ce33=2E=2Ea92e5ad 1=
00644</span><br><span>--- a/src/openvpn/dco_win=2Eh</span><br><span>+++ b/s=
rc/openvpn/dco_win=2Eh</span><br><span>@@ -65,8 +65,6 @@</span><br><span> v=
oid dco_p2p_new_peer(HANDLE handle, OVERLAPPED *ov, struct link_socket *soc=
k,</span><br><span>                       struct signal_info *sig_info);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void d=
co_start_tun(struct tuntap *tt);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> bool dco_win_supports_multipeer(void);</span><=
br><span> </span><br><span> void dco_win_add_iroute_ipv4(dco_context_t *dco=
, in_addr_t dst, unsigned int netbits,</span><br><span>@@ -79,13 +77,5 @@</=
span><br><span> </span><br><span> void dco_win_del_iroute_ipv6(dco_context_=
t *dco, struct in6_addr dst, unsigned int netbits);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if defined(ENABLE=
_DCO) &amp;&amp; defined(_WIN32) */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_start_=
tun(struct tuntap *tt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(false);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* defined(_WIN32=
) */</span><br><span> #endif /* ifndef DCO_H */</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1863?usp=3Demail">change 1863</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1863?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I395cc722d53201d775c20ae3cf9d50149bfc90ed </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1863 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></h=
tml>
--gGqv4tu4/zc=--


--===============3936110455145185140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3936110455145185140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3936110455145185140==--

