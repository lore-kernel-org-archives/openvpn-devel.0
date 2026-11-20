Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86494606A330
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ed4DImyC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YypJTJrC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NNejK3pY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Qt/FuESJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DY4d3/MV/gBer3hgFyuk0aUCLyPPDaBVBgzVvCmzzZM=; b=ed4DImyCr7upSGHhhJemoocBIY
	FbW41p5ITR8dhmhvOJVKUa6yUclPW35r3qriuxzrmPyYyK45u9bDrPgk9n0vWhiMQ9yVoiwjBToU4
	rXmYbV8QqJvKBRfFBYMU7NNjUfcipJSGCvtFKuZG+dZvfY6OmqwaNOuC4pcLV6SKEXnM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUMAz-000000008TY-0oxM;
	Fri, 20 Nov 2026 10:49:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUMAy-000000008TQ-2EJd
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:49:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fguPixa+d2w8FcB84z2bgcOWz7UjRjyKQ9D2GMr6YEc=; b=YypJTJrCRxyX2EigPntqtzvsnJ
 huFvk6hhXVrpLPudRAAvL9C7ZMjlmMKiuml+3eW7BV55S1l2S9/h/3oQIa3/mY2IS4+Lys1auxVGH
 3q94igalaZRf7r2XKCYl0EvAhQDGeaENvFXATTQqP21ftLrM1x4AkXE92lZ5X1Eky/o0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fguPixa+d2w8FcB84z2bgcOWz7UjRjyKQ9D2GMr6YEc=; b=NNejK3pY538qqFKV8Z/ODNHWrf
 mkejjXjQsZAhgfynoBfOqMudHybGc/skS07Foh9MHfA8BewUlmV+0rfCDr5K25wSCf40Ie/PtuWzh
 jhAJaR7wel8ALR0HJXyrLHefjjFJWaP6Gt7Hu1/YOc7OEOfGwzMAWwld5Wld9wlb3j2s=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUMAs-000000004FX-3HIb for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:49:04 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso4991595e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 02:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795171732; x=1795776532; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fguPixa+d2w8FcB84z2bgcOWz7UjRjyKQ9D2GMr6YEc=;
 b=Qt/FuESJzZJNNSfuDyMimhMeVQBsLfTXGV3t9lZOK6r69nCd46iJFCFo7OaCdO/yAz
 9Klp1CcFu4sgTzbRhcSjPy4ruVg8HQaW+7wU63fxLIEvu8AS2zSC9k8SHzBumBcCRuOa
 UbiUZJFdWUL7f9YwtynY7KlPJW6nOL7/DKGiTKkUrj7xwKBwQKa7L6oV6iZZt+dQdAES
 9236pk0+jjEP7RfgPFERIceW6RvY19aCNPNvGcXGCoo08l+Xk2QcjwXHLr21eU9a4vF9
 stvZ/0I8zWCzyujcFB+qxSVCgPGJBdQPPxL9kY784UZeXV3S/ncbSZFiZ0nOOaCOpN5o
 rpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171732; x=1795776532;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fguPixa+d2w8FcB84z2bgcOWz7UjRjyKQ9D2GMr6YEc=;
 b=j+IFBXmCZFNJwli/2nrzbChrZovzNDX4v20H5T6mV42zISY2LIuH3DKyD9FiOjQQED
 tFjE3Vy4MniexZAwQfWMsAmTLL0z2u3CQ/i3VkYTpBDcuTRhQ5Ilw+StPZstCGxXkhZ/
 pSuOsBTbZ0gyx/GFf5EBlBE7i0aojqb/kSFk7EpSlT1QeDChB44Ke2Ij19AlQf1ISmNT
 +aGqdd6S9sKBhQfRzmaqkYxmunKQAgt5TFkGWhKNCv4E/iZBW2p4cf/bu7LYd0IeRwJM
 yP0qIDjsJTIjqBIWec9IHvSiwnJyH6Ok110ZDUA94OugNBa9dDPZkn00J+7+uwzVSYAJ
 G6qg==
X-Gm-Message-State: APuU4Z/gMVRAVJU5pXLqPrabQPmfHSexKXoX4xfJrYNUwFG/QZp720gU
 UtYMDat0EZ2wkwMwIk26hqypbii+HI7c1ykFcTZ17gCqCh3gBIUeD7z4saJfyveJ/EHgu2mRH9Q
 csa1P8O392wJ+DdxzTfv+GnCU4JLaEFpizU9r/ljMETUBrdtEB0JjBOAC1TmXNWowkWeg/+Mqnx
 3aIVmeEQ==
X-Gm-Gg: AYBFou05ylSBM8+b/naZHbcxPlGHsT0TtGLFEzDvpHCBEtTaXIScuRlg07/+AJaW7nN
 8JG3quhuSxUB+gWQSErQDW3dEBxEJHazOAR8jTSnQGNtshgTVlnf/9WuHUjK2LkIUYUGN2kYts6
 fkSx4g+a67sqK1D25IU/Xr3i7kYwX0N1i1J3jd1ynjxC5/eTgiD2ByjqYkLhCiht/EqUngML7Jw
 Z2vkD6TKGfm5LYnX0+iB59EeJ1AJkBLCoSvT4rXQz44i7Io3h/6MYGecw1k6g0LhUCRh83t83es
 piTgAWNFgHtc6b2fkVM9I//ju3M5zVOGhQHrOrg3C5rBpim4R5EplemnU6WVVrB98ZjW9Lcx8DA
 97ZAqWl4qyd7ELykRYyPgA37XnG5zZ1qk0elHkNDLyCNSmCfJrNb1VTG0cLhyVVS9nt3kwRhkOR
 95RGM/zc9GiNIXCy+gA7rr41nRfkj9LV7VxRL1Q8WDupzk1rKbop4Sowd37Oxr2GmEOOe9b3vJL
 FGvhXvmxNLhb5EXT0EwsjvD18ZS0o4sivLSKpdcb4j/1OLAIWdVzQI3Hca8sEuOxFC+c5hT8gzh
 kB7xKKCSFiD72//uHK1xyepKdUuwZxQSR82G+YywStKMasCMgL0Hn57hbwkZeZzb5wcYr+NwFak
 O+mvFwg16B7d40SeTcDdbLaf0IzK/JqXAok8Sm+kFUU2yTo/ez2FWwZxg2c1VkjPu6Q4leOLMCx
 C7QoPsn79yI4UyE7A=
X-Received: by 2002:a05:600c:4584:b0:4bb:6c71:b269 with SMTP id
 5b1f17b1804b1-4bb8881fbd2mr51340185e9.28.1795171731656; 
 Fri, 20 Nov 2026 02:48:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe75sm5432218f8f.24.2026.11.20.02.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:48:51 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 10:48:49 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9
X-Gerrit-Change-Number: 2224
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2224?usp=email>
X-Gerrit-Commit: c482c663506d341f0d6669ad253698baff3bfb07
In-Reply-To: <gerrit.1795156301000.Icbfc6b64beea5e70f32449c5a63a08ad862597b9@gerrit.openvpn.net>
References: <gerrit.1795156301000.Icbfc6b64beea5e70f32449c5a63a08ad862597b9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTU2MzAxMDAwLkljYmZjNmI2NGJlZWE1ZTcwZjMyNDQ5YzVhNjNhMDhhZDg2MjU5N2I5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <38c7f05d5dc01c0d4c75e76cb664ccbd1a46b5f7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUMAs-000000004FX-3HIb
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking: use
 NET_ROUTE_TABLE_DEFAULT (-1) for 'no route table'
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3304123102629033091=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3304123102629033091==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XBFncCt2U1Q="; charset=UTF-8

--XBFncCt2U1Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2224?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Antonio Quartulli, Code-Review+2 by Gert Doering


Chang=
e subject: networking: use NET_ROUTE_TABLE_DEFAULT (-1) for 'no route table=
'
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

networking=
: use NET_ROUTE_TABLE_DEFAULT (-1) for 'no route table'

Table 0 meant "def=
ault table" in the net_route_*() API=2E That is fine on
Linux, where table =
0 is RT_TABLE_UNSPEC, but on FreeBSD FIB 0 is a real
FIB, which could then =
not be selected from a process running in another
FIB=2E

Make the table ar=
gument an int, with NET_ROUTE_TABLE_DEFAULT (-1) for
the default table, and=
 default --route-table to it=2E An invalid
--route-table value is now an er=
ror, instead of table 0=2E sitnl maps -1
and 0 to the main table, as before=
=2E On FreeBSD, -fib is now passed only
for a set table; DCO iroutes no lon=
ger force FIB 0 but use the FIB of
the process=2E

Routes that route=2Ec cr=
eates internally get it too; block-local routes
passed an uninitialized tab=
le before=2E

Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9
Signed-o=
ff-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert=
@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2224
Message-Id: <20261120083531=2E7390-1-gert@greenie=2Emuc=2Ede>
URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4=
1713=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src=
/openvpn/dco=2Ec
M src/openvpn/networking=2Eh
M src/openvpn/networking_free=
bsd=2Ec
M src/openvpn/networking_iproute2=2Ec
M src/openvpn/networking_sitn=
l=2Ec
M src/openvpn/options=2Ec
M src/openvpn/route=2Ec
M tests/unit_tests/=
openvpn/test_networking=2Ec
8 files changed, 74 insertions(+), 63 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/24=
/2224/4

diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index 236be=
93=2E=2Efdee465 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
=
@@ -721,7 +721,7 @@
         }
 
         net_route_v6_add(&m->top=2Enet_ct=
x, &addr->v6=2Eaddr, addr->netbits,
-                         gateway, c->c=
1=2Etuntap->actual_name, 0,
+                         gateway, c->c1=2Etunt=
ap->actual_name, NET_ROUTE_TABLE_DEFAULT,
                          DCO_IRO=
UTE_METRIC);
 #endif
     }
@@ -739,7 +739,7 @@
         }
 
         net_r=
oute_v4_add(&m->top=2Enet_ctx, &dest, addr->netbits, gateway,
-            =
             c->c1=2Etuntap->actual_name, 0, DCO_IROUTE_METRIC);
+         =
                c->c1=2Etuntap->actual_name, NET_ROUTE_TABLE_DEFAULT, DCO_I=
ROUTE_METRIC);
 #endif
     }
 #endif /* if defined(TARGET_LINUX) || define=
d(TARGET_FREEBSD) || defined(_WIN32) */
@@ -765,7 +765,7 @@
             dc=
o_win_del_iroute_ipv4(&c->c1=2Etuntap->dco, htonl(ir->network), ir->netbits=
);
 #else
             net_route_v4_del(net_ctx, &ir->network, ir->netbits,=

-                             &c->c2=2Epush_ifconfig_local, c->c1=2Etuntap=
->actual_name, 0,
+                             &c->c2=2Epush_ifconfig_loca=
l, c->c1=2Etuntap->actual_name, NET_ROUTE_TABLE_DEFAULT,
                  =
            DCO_IROUTE_METRIC);
 #endif
         }
@@ -779,7 +779,7 @@
    =
     {
             /* On windows we do not install these routes, so we als=
o do not need to delete them */
             net_route_v4_del(net_ctx, &ifc=
onfig_local, 32, NULL,
-                             c->c1=2Etuntap->actual=
_name, 0, DCO_IROUTE_METRIC);
+                             c->c1=2Etuntap-=
>actual_name, NET_ROUTE_TABLE_DEFAULT, DCO_IROUTE_METRIC);
         }
 #end=
if
     }
@@ -792,7 +792,7 @@
             dco_win_del_iroute_ipv6(&c->c1=
=2Etuntap->dco, ir6->network, ir6->netbits);
 #else
             net_route_=
v6_del(net_ctx, &ir6->network, ir6->netbits,
-                             =
&c->c2=2Epush_ifconfig_ipv6_local, c->c1=2Etuntap->actual_name, 0,
+       =
                      &c->c2=2Epush_ifconfig_ipv6_local, c->c1=2Etuntap->ac=
tual_name, NET_ROUTE_TABLE_DEFAULT,
                              DCO_IROUT=
E_METRIC);
 #endif
         }
@@ -805,7 +805,7 @@
         {
             /=
* On windows we do not install these routes, so we also do not need to dele=
te them */
             net_route_v6_del(net_ctx, dest, 128, NULL,
-       =
                      c->c1=2Etuntap->actual_name, 0, DCO_IROUTE_METRIC);
+=
                             c->c1=2Etuntap->actual_name, NET_ROUTE_TABLE_D=
EFAULT, DCO_IROUTE_METRIC);
         }
 #endif
     }
diff --git a/src/open=
vpn/networking=2Eh b/src/openvpn/networking=2Eh
index 7ad6e2e=2E=2Ef42ef4b =
100644
--- a/src/openvpn/networking=2Eh
+++ b/src/openvpn/networking=2Eh
@@=
 -24,6 +24,9 @@
 
 #define IFACE_TYPE_LEN_MAX 64
 
+/** net_route_*() table=
: Linux main table, FreeBSD FIB of the process */
+#define NET_ROUTE_TABLE_=
DEFAULT -1
+
 struct context;
 
 #ifdef ENABLE_SITNL
@@ -245,14 +248,13 @@
=
  * @param prefixlen the length of the prefix of the destination
  * @param=
 gw        the gateway for this route
  * @param iface     the interface fo=
r this route (can be NULL)
- * @param table     the table to add this route=
 to (if 0, will be added to the
- *                  main table)
+ * @param=
 table     the table to add this route to, or NET_ROUTE_TABLE_DEFAULT
  * @=
param metric    the metric associated with the route
  *
  * @return       =
   0 on success, a negative error code otherwise
  */
 int net_route_v4_add=
(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
-      =
               const in_addr_t *gw, const openvpn_net_iface_t *iface, uint3=
2_t table,
+                     const in_addr_t *gw, const openvpn_net_ifa=
ce_t *iface, int table,
                      int metric);
 
 /**
@@ -263,1=
4 +265,13 @@
  * @param prefixlen the length of the prefix of the destinati=
on
  * @param gw        the gateway for this route
  * @param iface     the=
 interface for this route (can be NULL)
- * @param table     the table to a=
dd this route to (if 0, will be added to the
- *                  main tabl=
e)
+ * @param table     the table to add this route to, or NET_ROUTE_TABLE_=
DEFAULT
  * @param metric    the metric associated with the route
  *
  * @=
return          0 on success, a negative error code otherwise
  */
 int net=
_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int=
 prefixlen,
-                     const struct in6_addr *gw, const openvpn_=
net_iface_t *iface, uint32_t table,
+                     const struct in6_=
addr *gw, const openvpn_net_iface_t *iface, int table,
                    =
  int metric);
 
 /**
@@ -281,14 +282,13 @@
  * @param prefixlen the length=
 of the prefix of the destination
  * @param gw        the gateway for this=
 route
  * @param iface     the interface for this route (can be NULL)
- * =
@param table     the table to add this route to (if 0, will be added to the=

- *                  main table)
+ * @param table     the table to add thi=
s route to, or NET_ROUTE_TABLE_DEFAULT
  * @param metric    the metric asso=
ciated with the route
  *
  * @return          0 on success, a negative err=
or code otherwise
  */
 int net_route_v4_del(const openvpn_net_ctx_t *ctx, =
const in_addr_t *dst, int prefixlen,
-                     const in_addr_t =
*gw, const openvpn_net_iface_t *iface, uint32_t table,
+                   =
  const in_addr_t *gw, const openvpn_net_iface_t *iface, int table,
       =
               int metric);
 
 /**
@@ -299,14 +299,13 @@
  * @param prefixl=
en the length of the prefix of the destination
  * @param gw        the gat=
eway for this route
  * @param iface     the interface for this route (can =
be NULL)
- * @param table     the table to add this route to (if 0, will be=
 added to the
- *                  main table)
+ * @param table     the tab=
le to add this route to, or NET_ROUTE_TABLE_DEFAULT
  * @param metric    th=
e metric associated with the route
  *
  * @return          0 on success, a=
 negative error code otherwise
  */
 int net_route_v6_del(const openvpn_net=
_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
-                  =
   const struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t ta=
ble,
+                     const struct in6_addr *gw, const openvpn_net_ifa=
ce_t *iface, int table,
                      int metric);
 
 #endif /* ENA=
BLE_SITNL || ENABLE_IPROUTE || TARGET_FREEBSD */
diff --git a/src/openvpn/n=
etworking_freebsd=2Ec b/src/openvpn/networking_freebsd=2Ec
index 88fd5c0=2E=
=2E8ba6326 100644
--- a/src/openvpn/networking_freebsd=2Ec
+++ b/src/openvp=
n/networking_freebsd=2Ec
@@ -10,7 +10,7 @@
 
 static int
 net_route_v4(cons=
t char *op, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
-    =
         const char *iface, uint32_t table, int metric)
+             const=
 char *iface, int table, int metric)
 {
     char buf1[INET_ADDRSTRLEN], bu=
f2[INET_ADDRSTRLEN];
     in_addr_t _dst, _gw;
@@ -27,15 +27,20 @@
     if =
(gw)
     {
         _gw =3D ntohl(*gw);
-        argv_printf(&argv, "%s %s=
 -net %s/%d %s -fib %d", ROUTE_PATH, op,
+        argv_printf(&argv, "%s %s=
 -net %s/%d %s", ROUTE_PATH, op,
                     inet_ntop(AF_INET, &_=
dst, buf1, sizeof(buf1)), prefixlen,
-                    inet_ntop(AF_INET=
, &_gw, buf2, sizeof(buf2)), table);
+                    inet_ntop(AF_INET=
, &_gw, buf2, sizeof(buf2)));
     }
     else
     {
-        argv_printf(=
&argv, "%s %s -net %s/%d -iface %s -fib %d", ROUTE_PATH, op,
+        argv_=
printf(&argv, "%s %s -net %s/%d -iface %s", ROUTE_PATH, op,
               =
      inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixlen,
-          =
          iface, table);
+                    iface);
+    }
+    /* withou=
t -fib, route(8) uses the FIB of the process */
+    if (table >=3D 0)
+   =
 {
+        argv_printf_cat(&argv, "-fib %d", table);
     }
 
     argv_ms=
g(M_INFO, &argv);
@@ -48,7 +53,7 @@
 
 static int
 net_route_v6(const char =
*op, const struct in6_addr *dst, int prefixlen, const struct in6_addr *gw,
=
-             const char *iface, uint32_t table, int metric)
+             =
const char *iface, int table, int metric)
 {
     char buf1[INET6_ADDRSTRLE=
N], buf2[INET6_ADDRSTRLEN];
     struct argv argv =3D argv_new();
@@ -61,15=
 +66,19 @@
      */
     if (gw)
     {
-        argv_printf(&argv, "%s -6 =
%s -net %s/%d %s -fib %d", ROUTE_PATH, op,
+        argv_printf(&argv, "%s =
-6 %s -net %s/%d %s", ROUTE_PATH, op,
                     inet_ntop(AF_INE=
T6, dst, buf1, sizeof(buf1)), prefixlen,
-                    inet_ntop(AF_=
INET6, gw, buf2, sizeof(buf2)), table);
+                    inet_ntop(AF_I=
NET6, gw, buf2, sizeof(buf2)));
     }
     else
     {
-        argv_print=
f(&argv, "%s -6 %s -net %s/%d -iface %s -fib %d", ROUTE_PATH, op,
+        =
argv_printf(&argv, "%s -6 %s -net %s/%d -iface %s", ROUTE_PATH, op,
       =
              inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,
-   =
                 iface, table);
+                    iface);
+    }
+    if=
 (table >=3D 0)
+    {
+        argv_printf_cat(&argv, "-fib %d", table);
 =
    }
 
 
@@ -83,28 +92,28 @@
 
 int
 net_route_v4_add(const openvpn_net_ct=
x_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
-      =
           const char *iface, uint32_t table, int metric)
+                =
 const char *iface, int table, int metric)
 {
     return net_route_v4("add=
", dst, prefixlen, gw, iface, table, metric);
 }
 
 int
 net_route_v6_add(c=
onst openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
-  =
               const struct in6_addr *gw, const char *iface, uint32_t table=
, int metric)
+                 const struct in6_addr *gw, const char *ifac=
e, int table, int metric)
 {
     return net_route_v6("add", dst, prefixlen=
, gw, iface, table, metric);
 }
 
 int
 net_route_v4_del(const openvpn_net_=
ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
-    =
             const char *iface, uint32_t table, int metric)
+              =
   const char *iface, int table, int metric)
 {
     return net_route_v4("d=
el", dst, prefixlen, gw, iface, table, metric);
 }
 
 int
 net_route_v6_del=
(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
-=
                 const struct in6_addr *gw, const char *iface, uint32_t tab=
le, int metric)
+                 const struct in6_addr *gw, const char *if=
ace, int table, int metric)
 {
     return net_route_v6("del", dst, prefixl=
en, gw, iface, table, metric);
 }
diff --git a/src/openvpn/networking_iprou=
te2=2Ec b/src/openvpn/networking_iproute2=2Ec
index d987478=2E=2E6c4c8f4 10=
0644
--- a/src/openvpn/networking_iproute2=2Ec
+++ b/src/openvpn/networking=
_iproute2=2Ec
@@ -243,7 +243,7 @@
 
 int
 net_route_v4_add(const openvpn_ne=
t_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
-  =
               const char *iface, uint32_t table, int metric)
+            =
     const char *iface, int table, int metric)
 {
     struct argv argv =3D=
 argv_new();
     const char *dst_str =3D print_in_addr_t(*dst, 0, &argv=2E=
gc);
@@ -281,7 +281,7 @@
 
 int
 net_route_v6_add(const openvpn_net_ctx_t *=
ctx, const struct in6_addr *dst, int prefixlen,
-                 const str=
uct in6_addr *gw, const char *iface, uint32_t table, int metric)
+         =
        const struct in6_addr *gw, const char *iface, int table, int metric=
)
 {
     struct argv argv =3D argv_new();
     char *dst_str =3D (char *)p=
rint_in6_addr(*dst, 0, &argv=2Egc);
@@ -314,7 +314,7 @@
 
 int
 net_route_v=
4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, co=
nst in_addr_t *gw,
-                 const char *iface, uint32_t table, int=
 metric)
+                 const char *iface, int table, int metric)
 {
   =
  struct argv argv =3D argv_new();
     const char *dst_str =3D print_in_ad=
dr_t(*dst, 0, &argv=2Egc);
@@ -340,7 +340,7 @@
 
 int
 net_route_v6_del(con=
st openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
-    =
             const struct in6_addr *gw, const char *iface, uint32_t table, =
int metric)
+                 const struct in6_addr *gw, const char *iface,=
 int table, int metric)
 {
     struct argv argv =3D argv_new();
     char =
*dst_str =3D (char *)print_in6_addr(*dst, 0, &argv=2Egc);
diff --git a/src/=
openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index b7c0f=
58=2E=2Eaf4ed27 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/ope=
nvpn/networking_sitnl=2Ec
@@ -1115,14 +1115,11 @@
 
 static int
 sitnl_rout=
e_add(const char *iface, sa_family_t af_family, const void *dst, int prefix=
len,
-                const void *gw, uint32_t table, int metric)
+        =
        const void *gw, int table, int metric)
 {
     enum rt_scope_t scop=
e =3D RT_SCOPE_UNIVERSE;
-
-    if (table =3D=3D 0)
-    {
-        table =
=3D RT_TABLE_MAIN;
-    }
+    /* table 0 is RT_TABLE_UNSPEC */
+    const =
uint32_t rt_table =3D table > 0 ? (uint32_t)table : RT_TABLE_MAIN;
 
     i=
f (!gw && iface)
     {
@@ -1130,12 +1127,12 @@
     }
 
     return sitnl_=
route_set(RTM_NEWROUTE, NLM_F_CREATE, iface, af_family, dst, prefixlen, gw,=

-                           table, metric, scope, RTPROT_BOOT, RTN_UNICAST=
);
+                           rt_table, metric, scope, RTPROT_BOOT, RTN_UN=
ICAST);
 }
 
 int
 net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_=
addr_t *dst, int prefixlen, const in_addr_t *gw,
-                 const ch=
ar *iface, uint32_t table, int metric)
+                 const char *iface,=
 int table, int metric)
 {
     const in_addr_t *dst_ptr =3D NULL, *gw_ptr =
=3D NULL;
     in_addr_t dst_be =3D 0, gw_be =3D 0;
@@ -1154,7 +1151,7 @@
 =
        gw_ptr =3D &gw_be;
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev=
 %s table %u metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev =
%s table %d metric %d", __func__,
         inet_ntop(AF_INET, &dst_be, dst_=
str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET, &gw_be, gw_st=
r, sizeof(gw_str)), np(iface), table, metric);
 
@@ -1163,7 +1160,7 @@
 
 i=
nt
 net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *d=
st, int prefixlen,
-                 const struct in6_addr *gw, const char =
*iface, uint32_t table, int metric)
+                 const struct in6_addr=
 *gw, const char *iface, int table, int metric)
 {
     inet_address_t dst_=
v6;
     inet_address_t gw_v6;
@@ -1183,7 +1180,7 @@
         gw_v6=2Eipv6 =
=3D *gw;
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metri=
c %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric=
 %d", __func__,
         inet_ntop(AF_INET6, &dst_v6=2Eipv6, dst_str, sizeo=
f(dst_str)), prefixlen,
         inet_ntop(AF_INET6, &gw_v6=2Eipv6, gw_str,=
 sizeof(gw_str)), np(iface), table, metric);
 
@@ -1192,20 +1189,18 @@
 
 s=
tatic int
 sitnl_route_del(const char *iface, sa_family_t af_family, const =
inet_address_t *dst, int prefixlen,
-                const inet_address_t *=
gw, uint32_t table, int metric)
+                const inet_address_t *gw, =
int table, int metric)
 {
-    if (table =3D=3D 0)
-    {
-        table =
=3D RT_TABLE_MAIN;
-    }
+    /* table 0 is RT_TABLE_UNSPEC */
+    const =
uint32_t rt_table =3D table > 0 ? (uint32_t)table : RT_TABLE_MAIN;
 
-    r=
eturn sitnl_route_set(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, gw=
, table, metric,
+    return sitnl_route_set(RTM_DELROUTE, 0, iface, af_fam=
ily, dst, prefixlen, gw, rt_table, metric,
                            RT_S=
COPE_NOWHERE, 0, 0);
 }
 
 int
 net_route_v4_del(const openvpn_net_ctx_t *c=
tx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
-            =
     const char *iface, uint32_t table, int metric)
+                 const=
 char *iface, int table, int metric)
 {
     inet_address_t dst_v4;
     in=
et_address_t gw_v4;
@@ -1225,7 +1220,7 @@
         gw_v4=2Eipv4 =3D htonl(*=
gw);
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d=
", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d"=
, __func__,
         inet_ntop(AF_INET, &dst_v4=2Eipv4, dst_str, sizeof(dst=
_str)), prefixlen,
         inet_ntop(AF_INET, &gw_v4=2Eipv4, gw_str, sizeo=
f(gw_str)), np(iface), table, metric);
 
@@ -1234,7 +1229,7 @@
 
 int
 net_=
route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int =
prefixlen,
-                 const struct in6_addr *gw, const char *iface, =
uint32_t table, int metric)
+                 const struct in6_addr *gw, co=
nst char *iface, int table, int metric)
 {
     inet_address_t dst_v6;
    =
 inet_address_t gw_v6;
@@ -1254,7 +1249,7 @@
         gw_v6=2Eipv6 =3D *gw;=

     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", _=
_func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __=
func__,
         inet_ntop(AF_INET6, &dst_v6=2Eipv6, dst_str, sizeof(dst_st=
r)), prefixlen,
         inet_ntop(AF_INET6, &gw_v6=2Eipv6, gw_str, sizeof(=
gw_str)), np(iface), table, metric);
 
diff --git a/src/openvpn/options=2Ec=
 b/src/openvpn/options=2Ec
index 947439d=2E=2Ee51ece7 100644
--- a/src/open=
vpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -831,7 +831,7 @@
     o->c=
e=2Emssfix =3D 0;
     o->ce=2Emssfix_default =3D true;
     o->ce=2Emssfix=
_encap =3D true;
-    o->route_default_table_id =3D 0;
+    o->route_defaul=
t_table_id =3D NET_ROUTE_TABLE_DEFAULT;
     o->route_delay_window =3D 30;
=
     o->resolve_retry_seconds =3D RESOLV_RETRY_INFINITE;
     o->resolve_in=
_advance =3D false;
@@ -5297,7 +5297,11 @@
         msg(M_WARN, "NOTE: --ro=
ute-table is supported only on Linux when SITNL is built-in");
 #endif
    =
     VERIFY_PERMISSION(OPT_P_ROUTE_TABLE);
-        options->route_default_=
table_id =3D positive_atoi(p[1], msglevel);
+        if (!atoi_constrained(=
p[1], &options->route_default_table_id, p[0], 0, INT_MAX,
+                =
              msglevel))
+        {
+            goto err;
+        }
     =
}
     else if (streq(p[0], "route") && p[1] && !p[5])
     {
diff --git a/=
src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 9086529=2E=2E82cb7f0 10=
0644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -545,6 +545=
,7 @@
         /* split a route into two smaller blocking routes, and direc=
t them to target */
         l2 =3D ((~gateway->netmask) + 1) >> 1;
       =
  r1->flags =3D RT_DEFINED;
+        r1->table_id =3D NET_ROUTE_TABLE_DEFAU=
LT;
         r1->gateway =3D target;
         r1->network =3D gateway->addr=
 & gateway->netmask;
         r1->netmask =3D ~(l2 - 1);
@@ -854,6 +855,7 @=
@
                 r6->gateway =3D rl6->rgi6=2Egateway=2Eaddr_ipv6;
       =
      }
             r6->metric =3D 1;
+            r6->table_id =3D NET_RO=
UTE_TABLE_DEFAULT;
 #ifdef _WIN32
             r6->adapter_index =3D rl6->r=
gi6=2Eadapter_index;
 #else
@@ -883,6 +885,7 @@
     struct route_ipv4 r;
 =
    CLEAR(r);
     r=2Eflags =3D RT_DEFINED;
+    r=2Etable_id =3D NET_ROUT=
E_TABLE_DEFAULT;
     r=2Enetwork =3D network;
     r=2Enetmask =3D netmask=
;
     r=2Egateway =3D gateway;
@@ -897,6 +900,7 @@
     struct route_ipv4 =
r;
     CLEAR(r);
     r=2Eflags =3D RT_DEFINED | RT_ADDED;
+    r=2Etable_=
id =3D NET_ROUTE_TABLE_DEFAULT;
     r=2Enetwork =3D network;
     r=2Enetm=
ask =3D netmask;
     r=2Egateway =3D gateway;
diff --git a/tests/unit_test=
s/openvpn/test_networking=2Ec b/tests/unit_tests/openvpn/test_networking=2E=
c
index b580d32=2E=2E636adda 100644
--- a/tests/unit_tests/openvpn/test_net=
working=2Ec
+++ b/tests/unit_tests/openvpn/test_networking=2Ec
@@ -112,7 +1=
12,7 @@
     }
     printf("\n");
 
-    return net_route_v4_add(NULL, &dst=
, prefixlen, NULL, iface, 0, metric);
+    return net_route_v4_add(NULL, &d=
st, prefixlen, NULL, iface, NET_ROUTE_TABLE_DEFAULT, metric);
 }
 
 static =
int
@@ -148,7 +148,7 @@
     }
     printf("\n");
 
-    return net_route_v=
4_add(NULL, &dst, prefixlen, &gw, iface, 0, metric);
+    return net_route_=
v4_add(NULL, &dst, prefixlen, &gw, iface, NET_ROUTE_TABLE_DEFAULT, metric);=

 }
 
 static int
@@ -175,7 +175,7 @@
     }
     printf("\n");
 
-    retu=
rn net_route_v6_add(NULL, &dst, prefixlen, NULL, iface, 0, metric);
+    re=
turn net_route_v6_add(NULL, &dst, prefixlen, NULL, iface, NET_ROUTE_TABLE_D=
EFAULT, metric);
 }
 
 static int
@@ -208,7 +208,7 @@
     }
     printf("\=
n");
 
-    return net_route_v6_add(NULL, &dst, prefixlen, &gw, iface, 0, m=
etric);
+    return net_route_v6_add(NULL, &dst, prefixlen, &gw, iface, NET=
_ROUTE_TABLE_DEFAULT, metric);
 }
 
 static void

-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9=

Gerrit-Change-Number: 2224
Gerrit-PatchSet: 4
Gerrit-Owner: R=C4=83zvan Co=
jocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@=
mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--XBFncCt2U1Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2224?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Antonio Quartulli, Code-Review+2 =
by Gert Doering</p><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">networking: use NET_ROUTE_TABLE_DEFAULT (-=
1) for &#39;no route table&#39;<br><br>Table 0 meant &quot;default table&qu=
ot; in the net_route_*() API=2E That is fine on<br>Linux, where table 0 is =
RT_TABLE_UNSPEC, but on FreeBSD FIB 0 is a real<br>FIB, which could then no=
t be selected from a process running in another<br>FIB=2E<br><br>Make the t=
able argument an int, with NET_ROUTE_TABLE_DEFAULT (-1) for<br>the default =
table, and default --route-table to it=2E An invalid<br>--route-table value=
 is now an error, instead of table 0=2E sitnl maps -1<br>and 0 to the main =
table, as before=2E On FreeBSD, -fib is now passed only<br>for a set table;=
 DCO iroutes no longer force FIB 0 but use the FIB of<br>the process=2E<br>=
<br>Routes that route=2Ec creates internally get it too; block-local routes=
<br>passed an uninitialized table before=2E<br><br>Change-Id: Icbfc6b64beea=
5e70f32449c5a63a08ad862597b9<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;=
<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224<br>Message-=
Id: &lt;20261120083531=2E7390-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:/=
/www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41713=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M src/openvpn/dco=2Ec<br>M src/openvpn/networking=2Eh<br>M src/openvp=
n/networking_freebsd=2Ec<br>M src/openvpn/networking_iproute2=2Ec<br>M src/=
openvpn/networking_sitnl=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/=
route=2Ec<br>M tests/unit_tests/openvpn/test_networking=2Ec<br>8 files chan=
ged, 74 insertions(+), 63 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/24/2224/4</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index=
 236be93=2E=2Efdee465 100644</span><br><span>--- a/src/openvpn/dco=2Ec</spa=
n><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -721,7 +721,7 @@</=
span><br><span>         }</span><br><span> </span><br><span>         net_ro=
ute_v6_add(&amp;m-&gt;top=2Enet_ctx, &amp;addr-&gt;v6=2Eaddr, addr-&gt;netb=
its,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
        gateway, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                         gateway, c-&gt;=
c1=2Etuntap-&gt;actual_name, NET_ROUTE_TABLE_DEFAULT,</span><br><span>     =
                     DCO_IROUTE_METRIC);</span><br><span> #endif</span><br>=
<span>     }</span><br><span>@@ -739,7 +739,7 @@</span><br><span>         }=
</span><br><span> </span><br><span>         net_route_v4_add(&amp;m-&gt;top=
=2Enet_ctx, &amp;dest, addr-&gt;netbits, gateway,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                         c-&gt;c1=2Etuntap-&gt;=
actual_name, 0, DCO_IROUTE_METRIC);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                         c-&gt;c1=2Etuntap-&gt;actual_name,=
 NET_ROUTE_TABLE_DEFAULT, DCO_IROUTE_METRIC);</span><br><span> #endif</span=
><br><span>     }</span><br><span> #endif /* if defined(TARGET_LINUX) || de=
fined(TARGET_FREEBSD) || defined(_WIN32) */</span><br><span>@@ -765,7 +765,=
7 @@</span><br><span>             dco_win_del_iroute_ipv4(&amp;c-&gt;c1=2Et=
untap-&gt;dco, htonl(ir-&gt;network), ir-&gt;netbits);</span><br><span> #el=
se</span><br><span>             net_route_v4_del(net_ctx, &amp;ir-&gt;netwo=
rk, ir-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                           &amp;c-&gt;c2=2Epush_ifconfig_local, c-&gt;c1=2E=
tuntap-&gt;actual_name, 0,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                             &amp;c-&gt;c2=2Epush_ifconfig_local, c-=
&gt;c1=2Etuntap-&gt;actual_name, NET_ROUTE_TABLE_DEFAULT,</span><br><span> =
                             DCO_IROUTE_METRIC);</span><br><span> #endif</s=
pan><br><span>         }</span><br><span>@@ -779,7 +779,7 @@</span><br><spa=
n>         {</span><br><span>             /* On windows we do not install t=
hese routes, so we also do not need to delete them */</span><br><span>     =
        net_route_v4_del(net_ctx, &amp;ifconfig_local, 32, NULL,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                             c-&=
gt;c1=2Etuntap-&gt;actual_name, 0, DCO_IROUTE_METRIC);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                             c-&gt;c1=2E=
tuntap-&gt;actual_name, NET_ROUTE_TABLE_DEFAULT, DCO_IROUTE_METRIC);</span>=
<br><span>         }</span><br><span> #endif</span><br><span>     }</span><=
br><span>@@ -792,7 +792,7 @@</span><br><span>             dco_win_del_irout=
e_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, ir6-&gt;network, ir6-&gt;netbits);</=
span><br><span> #else</span><br><span>             net_route_v6_del(net_ctx=
, &amp;ir6-&gt;network, ir6-&gt;netbits,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                             &amp;c-&gt;c2=2Epush_ifconf=
ig_ipv6_local, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                             &amp;c-&gt;c=
2=2Epush_ifconfig_ipv6_local, c-&gt;c1=2Etuntap-&gt;actual_name, NET_ROUTE_=
TABLE_DEFAULT,</span><br><span>                              DCO_IROUTE_MET=
RIC);</span><br><span> #endif</span><br><span>         }</span><br><span>@@=
 -805,7 +805,7 @@</span><br><span>         {</span><br><span>             /=
* On windows we do not install these routes, so we also do not need to dele=
te them */</span><br><span>             net_route_v6_del(net_ctx, dest, 128=
, NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
               c-&gt;c1=2Etuntap-&gt;actual_name, 0, DCO_IROUTE_METRIC);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
       c-&gt;c1=2Etuntap-&gt;actual_name, NET_ROUTE_TABLE_DEFAULT, DCO_IROU=
TE_METRIC);</span><br><span>         }</span><br><span> #endif</span><br><s=
pan>     }</span><br><span>diff --git a/src/openvpn/networking=2Eh b/src/op=
envpn/networking=2Eh</span><br><span>index 7ad6e2e=2E=2Ef42ef4b 100644</spa=
n><br><span>--- a/src/openvpn/networking=2Eh</span><br><span>+++ b/src/open=
vpn/networking=2Eh</span><br><span>@@ -24,6 +24,9 @@</span><br><span> </spa=
n><br><span> #define IFACE_TYPE_LEN_MAX 64</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/** net_route_*() table: Linux mai=
n table, FreeBSD FIB of the process */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define NET_ROUTE_TABLE_DEFAULT -1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct context;</span><=
br><span> </span><br><span> #ifdef ENABLE_SITNL</span><br><span>@@ -245,14 =
+248,13 @@</span><br><span>  * @param prefixlen the length of the prefix of=
 the destination</span><br><span>  * @param gw        the gateway for this =
route</span><br><span>  * @param iface     the interface for this route (ca=
n be NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param t=
able     the table to add this route to (if 0, will be added to the</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *                  main tabl=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param table  =
   the table to add this route to, or NET_ROUTE_TABLE_DEFAULT</span><br><sp=
an>  * @param metric    the metric associated with the route</span><br><spa=
n>  *</span><br><span>  * @return          0 on success, a negative error c=
ode otherwise</span><br><span>  */</span><br><span> int net_route_v4_add(co=
nst openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                     const in_ad=
dr_t *gw, const openvpn_net_iface_t *iface, uint32_t table,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     const in_addr_=
t *gw, const openvpn_net_iface_t *iface, int table,</span><br><span>       =
               int metric);</span><br><span> </span><br><span> /**</span><b=
r><span>@@ -263,14 +265,13 @@</span><br><span>  * @param prefixlen the leng=
th of the prefix of the destination</span><br><span>  * @param gw        th=
e gateway for this route</span><br><span>  * @param iface     the interface=
 for this route (can be NULL)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * @param table     the table to add this route to (if 0, will be a=
dded to the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *        =
          main table)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param table     the table to add this route to, or NET_ROUTE_TABLE_DE=
FAULT</span><br><span>  * @param metric    the metric associated with the r=
oute</span><br><span>  *</span><br><span>  * @return          0 on success,=
 a negative error code otherwise</span><br><span>  */</span><br><span> int =
net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, =
int prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
              const struct in6_addr *gw, const openvpn_net_iface_t *iface, =
uint32_t table,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                 const struct in6_addr *gw, const openvpn_net_iface_t *ifac=
e, int table,</span><br><span>                      int metric);</span><br>=
<span> </span><br><span> /**</span><br><span>@@ -281,14 +282,13 @@</span><b=
r><span>  * @param prefixlen the length of the prefix of the destination</s=
pan><br><span>  * @param gw        the gateway for this route</span><br><sp=
an>  * @param iface     the interface for this route (can be NULL)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * @param table     the table =
to add this route to (if 0, will be added to the</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *                  main table)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param table     the table to add=
 this route to, or NET_ROUTE_TABLE_DEFAULT</span><br><span>  * @param metri=
c    the metric associated with the route</span><br><span>  *</span><br><sp=
an>  * @return          0 on success, a negative error code otherwise</span=
><br><span>  */</span><br><span> int net_route_v4_del(const openvpn_net_ctx=
_t *ctx, const in_addr_t *dst, int prefixlen,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                     const in_addr_t *gw, const ope=
nvpn_net_iface_t *iface, uint32_t table,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                     const in_addr_t *gw, const openvp=
n_net_iface_t *iface, int table,</span><br><span>                      int =
metric);</span><br><span> </span><br><span> /**</span><br><span>@@ -299,14 =
+299,13 @@</span><br><span>  * @param prefixlen the length of the prefix of=
 the destination</span><br><span>  * @param gw        the gateway for this =
route</span><br><span>  * @param iface     the interface for this route (ca=
n be NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param t=
able     the table to add this route to (if 0, will be added to the</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *                  main tabl=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param table  =
   the table to add this route to, or NET_ROUTE_TABLE_DEFAULT</span><br><sp=
an>  * @param metric    the metric associated with the route</span><br><spa=
n>  *</span><br><span>  * @return          0 on success, a negative error c=
ode otherwise</span><br><span>  */</span><br><span> int net_route_v6_del(co=
nst openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                     const=
 struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                     co=
nst struct in6_addr *gw, const openvpn_net_iface_t *iface, int table,</span=
><br><span>                      int metric);</span><br><span> </span><br><=
span> #endif /* ENABLE_SITNL || ENABLE_IPROUTE || TARGET_FREEBSD */</span><=
br><span>diff --git a/src/openvpn/networking_freebsd=2Ec b/src/openvpn/netw=
orking_freebsd=2Ec</span><br><span>index 88fd5c0=2E=2E8ba6326 100644</span>=
<br><span>--- a/src/openvpn/networking_freebsd=2Ec</span><br><span>+++ b/sr=
c/openvpn/networking_freebsd=2Ec</span><br><span>@@ -10,7 +10,7 @@</span><b=
r><span> </span><br><span> static int</span><br><span> net_route_v4(const c=
har *op, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-             const char *iface=
, uint32_t table, int metric)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+             const char *iface, int table, int metric)</span><br>=
<span> {</span><br><span>     char buf1[INET_ADDRSTRLEN], buf2[INET_ADDRSTR=
LEN];</span><br><span>     in_addr_t _dst, _gw;</span><br><span>@@ -27,15 +=
27,20 @@</span><br><span>     if (gw)</span><br><span>     {</span><br><spa=
n>         _gw =3D ntohl(*gw);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        argv_printf(&amp;argv, &quot;%s %s -net %s/%d %s -fib %d&q=
uot;, ROUTE_PATH, op,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        argv_printf(&amp;argv, &quot;%s %s -net %s/%d %s&quot;, ROUTE_PAT=
H, op,</span><br><span>                     inet_ntop(AF_INET, &amp;_dst, b=
uf1, sizeof(buf1)), prefixlen,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    inet_ntop(AF_INET, &amp;_gw, buf2, sizeof(buf2=
)), table);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            inet_ntop(AF_INET, &amp;_gw, buf2, sizeof(buf2)));</span><br><s=
pan>     }</span><br><span>     else</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        argv_printf(&amp;argv, &quot;=
%s %s -net %s/%d -iface %s -fib %d&quot;, ROUTE_PATH, op,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;=
%s %s -net %s/%d -iface %s&quot;, ROUTE_PATH, op,</span><br><span>         =
            inet_ntop(AF_INET, &amp;_dst, buf1, sizeof(buf1)), prefixlen,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    ifa=
ce, table);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* without=
 -fib, route(8) uses the FIB of the process */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (table &gt;=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-fib %d&quot;,=
 table);</span><br><span>     }</span><br><span> </span><br><span>     argv=
_msg(M_INFO, &amp;argv);</span><br><span>@@ -48,7 +53,7 @@</span><br><span>=
 </span><br><span> static int</span><br><span> net_route_v6(const char *op,=
 const struct in6_addr *dst, int prefixlen, const struct in6_addr *gw,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-             const char *i=
face, uint32_t table, int metric)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+             const char *iface, int table, int metric)</span>=
<br><span> {</span><br><span>     char buf1[INET6_ADDRSTRLEN], buf2[INET6_A=
DDRSTRLEN];</span><br><span>     struct argv argv =3D argv_new();</span><br=
><span>@@ -61,15 +66,19 @@</span><br><span>      */</span><br><span>     if=
 (gw)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        argv_printf(&amp;argv, &quot;%s -6 %s -net %s/%d %s -fib %d&=
quot;, ROUTE_PATH, op,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        argv_printf(&amp;argv, &quot;%s -6 %s -net %s/%d %s&quot;, ROUTE=
_PATH, op,</span><br><span>                     inet_ntop(AF_INET6, dst, bu=
f1, sizeof(buf1)), prefixlen,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)), ta=
ble);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)));</span><br><span>     }<=
/span><br><span>     else</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        argv_printf(&amp;argv, &quot;%s -6 %s -n=
et %s/%d -iface %s -fib %d&quot;, ROUTE_PATH, op,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s -6 %s=
 -net %s/%d -iface %s&quot;, ROUTE_PATH, op,</span><br><span>              =
       inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    iface, table)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (table &gt;=3D 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv=
, &quot;-fib %d&quot;, table);</span><br><span>     }</span><br><span> </sp=
an><br><span> </span><br><span>@@ -83,28 +92,28 @@</span><br><span> </span>=
<br><span> int</span><br><span> net_route_v4_add(const openvpn_net_ctx_t *c=
tx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                 const char *iface,=
 uint32_t table, int metric)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                 const char *iface, int table, int metric)</span><=
br><span> {</span><br><span>     return net_route_v4(&quot;add&quot;, dst, =
prefixlen, gw, iface, table, metric);</span><br><span> }</span><br><span> <=
/span><br><span> int</span><br><span> net_route_v6_add(const openvpn_net_ct=
x_t *ctx, const struct in6_addr *dst, int prefixlen,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                 const struct in6_addr *gw,=
 const char *iface, uint32_t table, int metric)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                 const struct in6_addr *gw, con=
st char *iface, int table, int metric)</span><br><span> {</span><br><span> =
    return net_route_v6(&quot;add&quot;, dst, prefixlen, gw, iface, table, =
metric);</span><br><span> }</span><br><span> </span><br><span> int</span><b=
r><span> net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *ds=
t, int prefixlen, const in_addr_t *gw,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                 const char *iface, uint32_t table, int me=
tric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
   const char *iface, int table, int metric)</span><br><span> {</span><br><=
span>     return net_route_v4(&quot;del&quot;, dst, prefixlen, gw, iface, t=
able, metric);</span><br><span> }</span><br><span> </span><br><span> int</s=
pan><br><span> net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct =
in6_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                 const struct in6_addr *gw, const char *iface, uint=
32_t table, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                 const struct in6_addr *gw, const char *iface, int tabl=
e, int metric)</span><br><span> {</span><br><span>     return net_route_v6(=
&quot;del&quot;, dst, prefixlen, gw, iface, table, metric);</span><br><span=
> }</span><br><span>diff --git a/src/openvpn/networking_iproute2=2Ec b/src/=
openvpn/networking_iproute2=2Ec</span><br><span>index d987478=2E=2E6c4c8f4 =
100644</span><br><span>--- a/src/openvpn/networking_iproute2=2Ec</span><br>=
<span>+++ b/src/openvpn/networking_iproute2=2Ec</span><br><span>@@ -243,7 +=
243,7 @@</span><br><span> </span><br><span> int</span><br><span> net_route_=
v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, c=
onst in_addr_t *gw,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
               const char *iface, uint32_t table, int metric)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                 const char *ifac=
e, int table, int metric)</span><br><span> {</span><br><span>     struct ar=
gv argv =3D argv_new();</span><br><span>     const char *dst_str =3D print_=
in_addr_t(*dst, 0, &amp;argv=2Egc);</span><br><span>@@ -281,7 +281,7 @@</sp=
an><br><span> </span><br><span> int</span><br><span> net_route_v6_add(const=
 openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                 const struct=
 in6_addr *gw, const char *iface, uint32_t table, int metric)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                 const struct in6=
_addr *gw, const char *iface, int table, int metric)</span><br><span> {</sp=
an><br><span>     struct argv argv =3D argv_new();</span><br><span>     cha=
r *dst_str =3D (char *)print_in6_addr(*dst, 0, &amp;argv=2Egc);</span><br><=
span>@@ -314,7 +314,7 @@</span><br><span> </span><br><span> int</span><br><=
span> net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, =
int prefixlen, const in_addr_t *gw,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                 const char *iface, uint32_t table, int metri=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
const char *iface, int table, int metric)</span><br><span> {</span><br><spa=
n>     struct argv argv =3D argv_new();</span><br><span>     const char *ds=
t_str =3D print_in_addr_t(*dst, 0, &amp;argv=2Egc);</span><br><span>@@ -340=
,7 +340,7 @@</span><br><span> </span><br><span> int</span><br><span> net_ro=
ute_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int pr=
efixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
    const struct in6_addr *gw, const char *iface, uint32_t table, int metri=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
const struct in6_addr *gw, const char *iface, int table, int metric)</span>=
<br><span> {</span><br><span>     struct argv argv =3D argv_new();</span><b=
r><span>     char *dst_str =3D (char *)print_in6_addr(*dst, 0, &amp;argv=2E=
gc);</span><br><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/op=
envpn/networking_sitnl=2Ec</span><br><span>index b7c0f58=2E=2Eaf4ed27 10064=
4</span><br><span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>++=
+ b/src/openvpn/networking_sitnl=2Ec</span><br><span>@@ -1115,14 +1115,11 @=
@</span><br><span> </span><br><span> static int</span><br><span> sitnl_rout=
e_add(const char *iface, sa_family_t af_family, const void *dst, int prefix=
len,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                c=
onst void *gw, uint32_t table, int metric)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                const void *gw, int table, int metri=
c)</span><br><span> {</span><br><span>     enum rt_scope_t scope =3D RT_SCO=
PE_UNIVERSE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (table =3D=3D 0)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        table =3D RT_TABLE_MAIN;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* table 0 is RT_TABLE_UNSPEC */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const uint32_t rt_table =
=3D table &gt; 0 ? (uint32_t)table : RT_TABLE_MAIN;</span><br><span> </span=
><br><span>     if (!gw &amp;&amp; iface)</span><br><span>     {</span><br>=
<span>@@ -1130,12 +1127,12 @@</span><br><span>     }</span><br><span> </spa=
n><br><span>     return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, iface, =
af_family, dst, prefixlen, gw,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                           table, metric, scope, RTPROT_BOOT, RTN_=
UNICAST);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                 rt_table, metric, scope, RTPROT_BOOT, RTN_UNICAST);</span>=
<br><span> }</span><br><span> </span><br><span> int</span><br><span> net_ro=
ute_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixle=
n, const in_addr_t *gw,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                 const char *iface, uint32_t table, int metric)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                 const char *=
iface, int table, int metric)</span><br><span> {</span><br><span>     const=
 in_addr_t *dst_ptr =3D NULL, *gw_ptr =3D NULL;</span><br><span>     in_add=
r_t dst_be =3D 0, gw_be =3D 0;</span><br><span>@@ -1154,7 +1151,7 @@</span>=
<br><span>         gw_ptr =3D &amp;gw_be;</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUT=
E, &quot;%s: %s/%d via %s dev %s table %u metric %d&quot;, __func__,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s:=
 %s/%d via %s dev %s table %d metric %d&quot;, __func__,</span><br><span>  =
       inet_ntop(AF_INET, &amp;dst_be, dst_str, sizeof(dst_str)), prefixlen=
,</span><br><span>         inet_ntop(AF_INET, &amp;gw_be, gw_str, sizeof(gw=
_str)), np(iface), table, metric);</span><br><span> </span><br><span>@@ -11=
63,7 +1160,7 @@</span><br><span> </span><br><span> int</span><br><span> net=
_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int=
 prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
       const struct in6_addr *gw, const char *iface, uint32_t table, int me=
tric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
   const struct in6_addr *gw, const char *iface, int table, int metric)</sp=
an><br><span> {</span><br><span>     inet_address_t dst_v6;</span><br><span=
>     inet_address_t gw_v6;</span><br><span>@@ -1183,7 +1180,7 @@</span><br=
><span>         gw_v6=2Eipv6 =3D *gw;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &=
quot;%s: %s/%d via %s dev %s table %u metric %d&quot;, __func__,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/=
%d via %s dev %s table %d metric %d&quot;, __func__,</span><br><span>      =
   inet_ntop(AF_INET6, &amp;dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefi=
xlen,</span><br><span>         inet_ntop(AF_INET6, &amp;gw_v6=2Eipv6, gw_st=
r, sizeof(gw_str)), np(iface), table, metric);</span><br><span> </span><br>=
<span>@@ -1192,20 +1189,18 @@</span><br><span> </span><br><span> static int=
</span><br><span> sitnl_route_del(const char *iface, sa_family_t af_family,=
 const inet_address_t *dst, int prefixlen,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                const inet_address_t *gw, uint32_t tab=
le, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            const inet_address_t *gw, int table, int metric)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (table =3D=
=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        table =3D RT_TABLE_MAIN=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* table 0 is RT_TABLE_UNSPEC =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint32_=
t rt_table =3D table &gt; 0 ? (uint32_t)table : RT_TABLE_MAIN;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl=
_route_set(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, gw, table, me=
tric,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sit=
nl_route_set(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, gw, rt_tabl=
e, metric,</span><br><span>                            RT_SCOPE_NOWHERE, 0,=
 0);</span><br><span> }</span><br><span> </span><br><span> int</span><br><s=
pan> net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, i=
nt prefixlen, const in_addr_t *gw,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                 const char *iface, uint32_t table, int metric=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 c=
onst char *iface, int table, int metric)</span><br><span> {</span><br><span=
>     inet_address_t dst_v4;</span><br><span>     inet_address_t gw_v4;</sp=
an><br><span>@@ -1225,7 +1220,7 @@</span><br><span>         gw_v4=2Eipv4 =
=3D htonl(*gw);</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;%s: %s/%d via %s =
dev %s table %u metric %d&quot;, __func__,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table=
 %d metric %d&quot;, __func__,</span><br><span>         inet_ntop(AF_INET, =
&amp;dst_v4=2Eipv4, dst_str, sizeof(dst_str)), prefixlen,</span><br><span> =
        inet_ntop(AF_INET, &amp;gw_v4=2Eipv4, gw_str, sizeof(gw_str)), np(i=
face), table, metric);</span><br><span> </span><br><span>@@ -1234,7 +1229,7=
 @@</span><br><span> </span><br><span> int</span><br><span> net_route_v6_de=
l(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 const=
 struct in6_addr *gw, const char *iface, uint32_t table, int metric)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                 const str=
uct in6_addr *gw, const char *iface, int table, int metric)</span><br><span=
> {</span><br><span>     inet_address_t dst_v6;</span><br><span>     inet_a=
ddress_t gw_v6;</span><br><span>@@ -1254,7 +1249,7 @@</span><br><span>     =
    gw_v6=2Eipv6 =3D *gw;</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;%s: %s/=
%d via %s dev %s table %u metric %d&quot;, __func__,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%d via %s d=
ev %s table %d metric %d&quot;, __func__,</span><br><span>         inet_nto=
p(AF_INET6, &amp;dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,</span=
><br><span>         inet_ntop(AF_INET6, &amp;gw_v6=2Eipv6, gw_str, sizeof(g=
w_str)), np(iface), table, metric);</span><br><span> </span><br><span>diff =
--git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>i=
ndex 947439d=2E=2Ee51ece7 100644</span><br><span>--- a/src/openvpn/options=
=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -831,=
7 +831,7 @@</span><br><span>     o-&gt;ce=2Emssfix =3D 0;</span><br><span> =
    o-&gt;ce=2Emssfix_default =3D true;</span><br><span>     o-&gt;ce=2Emss=
fix_encap =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  o-&gt;route_default_table_id =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    o-&gt;route_default_table_id =3D NET_ROUTE_TABLE_DEFA=
ULT;</span><br><span>     o-&gt;route_delay_window =3D 30;</span><br><span>=
     o-&gt;resolve_retry_seconds =3D RESOLV_RETRY_INFINITE;</span><br><span=
>     o-&gt;resolve_in_advance =3D false;</span><br><span>@@ -5297,7 +5297,=
11 @@</span><br><span>         msg(M_WARN, &quot;NOTE: --route-table is sup=
ported only on Linux when SITNL is built-in&quot;);</span><br><span> #endif=
</span><br><span>         VERIFY_PERMISSION(OPT_P_ROUTE_TABLE);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;route_default=
_table_id =3D positive_atoi(p[1], msglevel);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (!atoi_constrained(p[1], &amp;options-&=
gt;route_default_table_id, p[0], 0, INT_MAX,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                              msglevel))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</spa=
n><br><span>     else if (streq(p[0], &quot;route&quot;) &amp;&amp; p[1] &a=
mp;&amp; !p[5])</span><br><span>     {</span><br><span>diff --git a/src/ope=
nvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 9086529=2E=2E8=
2cb7f0 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+=
++ b/src/openvpn/route=2Ec</span><br><span>@@ -545,6 +545,7 @@</span><br><s=
pan>         /* split a route into two smaller blocking routes, and direct =
them to target */</span><br><span>         l2 =3D ((~gateway-&gt;netmask) +=
 1) &gt;&gt; 1;</span><br><span>         r1-&gt;flags =3D RT_DEFINED;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        r1-&gt;table_id =
=3D NET_ROUTE_TABLE_DEFAULT;</span><br><span>         r1-&gt;gateway =3D ta=
rget;</span><br><span>         r1-&gt;network =3D gateway-&gt;addr &amp; ga=
teway-&gt;netmask;</span><br><span>         r1-&gt;netmask =3D ~(l2 - 1);</=
span><br><span>@@ -854,6 +855,7 @@</span><br><span>                 r6-&gt;=
gateway =3D rl6-&gt;rgi6=2Egateway=2Eaddr_ipv6;</span><br><span>           =
  }</span><br><span>             r6-&gt;metric =3D 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            r6-&gt;table_id =3D NET_ROUTE=
_TABLE_DEFAULT;</span><br><span> #ifdef _WIN32</span><br><span>            =
 r6-&gt;adapter_index =3D rl6-&gt;rgi6=2Eadapter_index;</span><br><span> #e=
lse</span><br><span>@@ -883,6 +885,7 @@</span><br><span>     struct route_i=
pv4 r;</span><br><span>     CLEAR(r);</span><br><span>     r=2Eflags =3D RT=
_DEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=2Eta=
ble_id =3D NET_ROUTE_TABLE_DEFAULT;</span><br><span>     r=2Enetwork =3D ne=
twork;</span><br><span>     r=2Enetmask =3D netmask;</span><br><span>     r=
=2Egateway =3D gateway;</span><br><span>@@ -897,6 +900,7 @@</span><br><span=
>     struct route_ipv4 r;</span><br><span>     CLEAR(r);</span><br><span> =
    r=2Eflags =3D RT_DEFINED | RT_ADDED;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    r=2Etable_id =3D NET_ROUTE_TABLE_DEFAULT;</span><b=
r><span>     r=2Enetwork =3D network;</span><br><span>     r=2Enetmask =3D =
netmask;</span><br><span>     r=2Egateway =3D gateway;</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/test_networking=2Ec b/tests/unit_tests/op=
envpn/test_networking=2Ec</span><br><span>index b580d32=2E=2E636adda 100644=
</span><br><span>--- a/tests/unit_tests/openvpn/test_networking=2Ec</span><=
br><span>+++ b/tests/unit_tests/openvpn/test_networking=2Ec</span><br><span=
>@@ -112,7 +112,7 @@</span><br><span>     }</span><br><span>     printf(&qu=
ot;\n&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    return net_route_v4_add(NULL, &amp;dst, prefixlen, NULL, ifac=
e, 0, metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn net_route_v4_add(NULL, &amp;dst, prefixlen, NULL, iface, NET_ROUTE_TA=
BLE_DEFAULT, metric);</span><br><span> }</span><br><span> </span><br><span>=
 static int</span><br><span>@@ -148,7 +148,7 @@</span><br><span>     }</spa=
n><br><span>     printf(&quot;\n&quot;);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return net_route_v4_add(NULL, &amp=
;dst, prefixlen, &amp;gw, iface, 0, metric);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return net_route_v4_add(NULL, &amp;dst, prefix=
len, &amp;gw, iface, NET_ROUTE_TABLE_DEFAULT, metric);</span><br><span> }</=
span><br><span> </span><br><span> static int</span><br><span>@@ -175,7 +175=
,7 @@</span><br><span>     }</span><br><span>     printf(&quot;\n&quot;);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn net_route_v6_add(NULL, &amp;dst, prefixlen, NULL, iface, 0, metric);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return net_route=
_v6_add(NULL, &amp;dst, prefixlen, NULL, iface, NET_ROUTE_TABLE_DEFAULT, me=
tric);</span><br><span> }</span><br><span> </span><br><span> static int</sp=
an><br><span>@@ -208,7 +208,7 @@</span><br><span>     }</span><br><span>   =
  printf(&quot;\n&quot;);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    return net_route_v6_add(NULL, &amp;dst, prefixlen=
, &amp;gw, iface, 0, metric);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return net_route_v6_add(NULL, &amp;dst, prefixlen, &amp;gw, i=
face, NET_ROUTE_TABLE_DEFAULT, metric);</span><br><span> }</span><br><span>=
 </span><br><span> static void</span><br></pre><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demail">change 2224</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
Icbfc6b64beea5e70f32449c5a63a08ad862597b9 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2224 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--XBFncCt2U1Q=--


--===============3304123102629033091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3304123102629033091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3304123102629033091==--

