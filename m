Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF32606C599
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BlAK8APY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=C7CRSO+H;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EX90uLTs;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ftNmhsVY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=h1Mg9cFJPxHJ96D9Yimful+cMXfdwHe1r9IP6uI6w44=; b=BlAK8APYt0LcBNbuUq2WX3DbXr
	dezFkdOZrXrI+mfYYsAd2GotEfHuJKpBmGh1on/v3iMnnfy3rjVb56AxTqyTGNs0lnPrY9OJ1oXh/
	a6/30RZfJ10ssHXbOMpp2ltbKfc/ULJE2aef6GRP+cdJl1/Fu+R8GuX4dte57yOtIlxI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOiaR-0000000068u-44g8;
	Wed, 04 Nov 2026 21:32:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOiaQ-0000000068o-3dYR
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 21:32:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qoeu2fAQRdLUrf2bESmA+nPCOPy+y8zsmrnVMPuqY/o=; b=C7CRSO+HW93/B8B2mlfPF+HTTB
 hzbeWIRTeNhjG2/38loe0B6t1eONaDdnJ6R/2qRaNjjW14Gd6/h92RZ9hd7DTk8ZpQiaQHdJx8wmK
 TfjCt8eC35eaVdUur6R7zBEr6TjgFEijfZFSsc3sKSh2LD/PeWcAhpE7SN+NfqjZ7m5Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qoeu2fAQRdLUrf2bESmA+nPCOPy+y8zsmrnVMPuqY/o=; b=EX90uLTssH9rOfDYr1oXRtmRNF
 bL7iLlyHQWfW7p7UIV4PkAlpvmksTBR1/RdTyChs3w8gObbkZRk8p7s2wN8SG22N1k7pwhaThoTzl
 gcpf+NsJIgctx6i9F/aGxfV277pCQL+5mjqn1G+xVAUsQKEK73dgVOLGv6rXaM4BtDwc=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOiaO-000000001Lj-20VW for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 21:32:02 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48e47347279so716891f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 13:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793827914; x=1794432714; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qoeu2fAQRdLUrf2bESmA+nPCOPy+y8zsmrnVMPuqY/o=;
 b=ftNmhsVYx6wPNczpXrLPRpgnWZLYYmecV375bwueZzxD6RgxVAqaj0MdLaBWhwlPUD
 kkxI/qd0kOB/Ob3NqKVBrSVSWOGMSK/Wng+5wcZ1xtoWquQwWiOrDOOeqm6+TmbWskZ5
 qlVYwAawMJ3espdoXnIs9BOWyeGrNWxRCrT6vtOk8pU99G6Wu6AGYSn3h4MFHW+SMJDV
 d5SZEzA1P8p39KW0g32lDO6UDQAotPv5sP0hjzf6A7JZDd+anhT9gGCOvYriUB7q8o/c
 BfiZ7pSTxygGSZIkI5vjEVhqTjPnQoXy3SwEhV7HxLC0CnJ9tL8Km70phm7jyG0/4sP+
 ouuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793827914; x=1794432714;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qoeu2fAQRdLUrf2bESmA+nPCOPy+y8zsmrnVMPuqY/o=;
 b=ttbu/3nXL0nHpEfG2rCQRuwPBgMyVJqQ6x+vN52Wg0LWHenXIehIMb9QHGdz7tmAV/
 Jzs51KlQ3zcGJN0aEFatqhs82fRe/GV0ad0kekgffvbyjWWndloau67L5otRz0qzKTQI
 AH5L8sVssGpK9Th5Ey2yUQTYvC/JuWpM0xg0+hLV6YR6FfgeE8laph1PAlKog8BE8mSB
 9btfc07gjDJ5aB3pvS5NPVvh8XHBk1fs3XB9keFPWVtWPANReoaB/D+nutyftCUKk1q1
 Fi8Zjn9eUJasgYm6WbV3DgQw7WLzlWUznCEqB9ay+ixxPhQMgdBFOhEKdRt6/DzKeKPn
 ARRQ==
X-Gm-Message-State: APuU4Z87iS+7MMgf5T6I7pJDwv/EsghQ4w7Go2BHz6Wm916KdFvs8taG
 0MWeh/sR2j7Wc8wrOQpQNbGVa1IeQuMLCyT2q+cTdFdh92lNk/vfOOQm/ILkg/pjK2tzYVKwib5
 FF8/XCjOztLtLMyDRnf8+bR2h9L+ADi8O2vqbkeUTV2F1xtqfIfe7Lu7RmgueMYTLa2THmyrmfB
 08dOjzEw==
X-Gm-Gg: AYBFou2/w30u+ZhY6u469Lwwt4WWtrZ0UUL/hEy/9dOhYwTGP7N8OF0LET1V4ZCoaaS
 4/PtD+0OooEeDdcxxI0dOseoaTqmz3tpgQ7oLDkqgoEnUADavhIvjbZEWhpvy6ycN4YKTDj+cWn
 P61njh3H6ojGWIG1xwh5rMXXBK827uHAzT2cKdOa+H2O+35CRNjfzuBGAy5bHW4WfJJohPKrBIf
 d3Oxki68URn3FoDjnpbMLFSAFMOvQs43exCiA6XekpzxxiVDSsQepQwcQFyp1C7CzZzn9lP39gK
 e9A85nqtzdchhn43/B/jnVYP7ksVzC3l8V6l2pV9lqqTMesJ8Dma/CTYybpddc/v1eJRoQ84GcU
 I6Xfi5n5qOrc+DqNDpxrpdxcG6LIGAhuS+tklydS3IsbZtpT1RvAEKX6actkIoa1uTF493MJf/O
 nvceia54aqsei7qfVspN5HpN7hY/koYOkc12fzfpmonW4ghLT9FXWutDCki2zCbUcdVUZcgZOWI
 Rb8YbKviE+XlteZXcGRuiRVn4V4O7zbMzLdh3kNbMBbnJEBVgYN2pyjjYpXTWTGg7w+Smsd7/z6
 jkGHK7khOFE0fmUwXmUyHTfh7SfzlnrpDGnQp5a4PeSMGnJ5Z6bTUMqJQctNaBm65RdMb91HZfB
 AtH5JK2FkMgOY7wDuQRVxe+fhUURP3Op7zNpnJTall5k6ZaFMRUfdSUMSZJxZxddcsCXcaD6F7m
 apggZ6myHvAE5UkQ==
X-Received: by 2002:a05:6000:4908:b0:48e:7470:9e98 with SMTP id
 ffacd0b85a97d-48e74709f70mr33789219f8f.39.1793827913511; 
 Wed, 04 Nov 2026 13:31:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feeb5196esm5508068f8f.58.2026.11.04.13.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 13:31:52 -0800 (PST)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 21:31:50 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic0b8b0a3249eb41e1de10f381932c1161cd75270
X-Gerrit-Change-Number: 2061
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2061?usp=email>
X-Gerrit-Commit: 08f4044a258ce40d8373160c19d5042e86583b6b
In-Reply-To: <gerrit.1793194671000.Ic0b8b0a3249eb41e1de10f381932c1161cd75270@gerrit.openvpn.net>
References: <gerrit.1793194671000.Ic0b8b0a3249eb41e1de10f381932c1161cd75270@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkljMGI4YjBhMzI0OWViNDFlMWRlMTBmMzgxOTMyYzExNjFjZDc1MjcwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <25ec9e41d61a99dded7fe34e84eb358d7523c785-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOiaO-000000001Lj-20VW
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: track installed
 iroutes separately for IPv4 and IPv6
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Marco Baffo \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0164996179919185909=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0164996179919185909==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lXfzNyBhS44="; charset=UTF-8

--lXfzNyBhS44=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo, R=C4=83zva=
n Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to =
reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2061?usp=3Demail

to look at the new patch set (#3)=2E

The followi=
ng approvals got outdated and were removed:
Code-Review-1 by R=C4=83zvan Co=
jocaru


Change subject: dco: track installed iroutes separately for IPv4 a=
nd IPv6
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco:=
 track installed iroutes separately for IPv4 and IPv6

Track successful rou=
te installation per address family and split route
deletion into IPv4 and I=
Pv6 helpers=2E Update delayed-exit cleanup=2E
Return installation status fr=
om the Windows helpers and keep the
non-DCO declarations compatible=2E

Cha=
nge-Id: Ic0b8b0a3249eb41e1de10f381932c1161cd75270
Signed-off-by: Marco Baff=
o <marco@mandelbit=2Ecom>
---
M src/openvpn/dco=2Ec
M src/openvpn/dco=2Eh
M=
 src/openvpn/dco_win=2Ec
M src/openvpn/dco_win=2Eh
M src/openvpn/forward=2E=
c
M src/openvpn/multi=2Ec
M src/openvpn/openvpn=2Eh
7 files changed, 94 ins=
ertions(+), 35 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/61/2061/3

diff --git a/src/openvpn/dco=2Ec b/src/ope=
nvpn/dco=2Ec
index f3b5d44=2E=2Ef807002 100644
--- a/src/openvpn/dco=2Ec
++=
+ b/src/openvpn/dco=2Ec
@@ -706,8 +706,8 @@
     if (addrtype =3D=3D MR_ADD=
R_IPV6)
     {
 #if defined(_WIN32)
-        dco_win_add_iroute_ipv6(&c->c1=
=2Etuntap->dco, addr->v6=2Eaddr, addr->netbits,
-                          =
      c->c2=2Etls_multi->rx_peer_id);
+        bool installed =3D dco_win_a=
dd_iroute_ipv6(&c->c1=2Etuntap->dco, addr->v6=2Eaddr, addr->netbits,
+     =
                                            c->c2=2Etls_multi->rx_peer_id);=

 #else
         const struct in6_addr *gateway =3D &mi->context=2Ec2=2Epus=
h_ifconfig_ipv6_local;
         if (addr->type & MR_ONLINK_DCO_ADDR)
@@ -71=
5,16 +715,18 @@
             gateway =3D NULL;
         }
 
-        net_ro=
ute_v6_add(&m->top=2Enet_ctx, &addr->v6=2Eaddr, addr->netbits,
-           =
              gateway, c->c1=2Etuntap->actual_name, 0,
-                   =
      DCO_IROUTE_METRIC);
+        bool installed =3D net_route_v6_add(&m->=
top=2Enet_ctx, &addr->v6=2Eaddr, addr->netbits,
+                          =
                gateway, c->c1=2Etuntap->actual_name, 0,
+                 =
                         DCO_IROUTE_METRIC)
+                         =3D=
=3D 0;
 #endif
+        mi->context=2Edid_dco_iroutes_v6 |=3D installed;
  =
   }
     else if (addrtype =3D=3D MR_ADDR_IPV4)
     {
 #if defined(_WIN32=
)
-        dco_win_add_iroute_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Eaddr, a=
ddr->netbits,
-                                c->c2=2Etls_multi->rx_peer_i=
d);
+        bool installed =3D dco_win_add_iroute_ipv4(&c->c1=2Etuntap->dc=
o, addr->v4=2Eaddr, addr->netbits,
+                                       =
          c->c2=2Etls_multi->rx_peer_id);
 #else
         in_addr_t dest =
=3D htonl(addr->v4=2Eaddr);
         const in_addr_t *gateway =3D &mi->cont=
ext=2Ec2=2Epush_ifconfig_local;
@@ -733,15 +735,17 @@
             gateway =
=3D NULL;
         }
 
-        net_route_v4_add(&m->top=2Enet_ctx, &dest, =
addr->netbits, gateway,
-                         c->c1=2Etuntap->actual_na=
me, 0, DCO_IROUTE_METRIC);
+        bool installed =3D net_route_v4_add(&m-=
>top=2Enet_ctx, &dest, addr->netbits, gateway,
+                           =
               c->c1=2Etuntap->actual_name, 0, DCO_IROUTE_METRIC)
+        =
                 =3D=3D 0;
 #endif
+        mi->context=2Edid_dco_iroutes_v=
4 |=3D installed;
     }
 #endif /* if defined(TARGET_LINUX) || defined(TAR=
GET_FREEBSD) || defined(_WIN32) */
 }
 
 void
-dco_delete_iroutes(openvpn_n=
et_ctx_t *net_ctx, const struct context *c)
+dco_delete_iroutes_v4(openvpn_=
net_ctx_t *net_ctx, const struct context *c)
 {
 #if defined(TARGET_LINUX) =
|| defined(TARGET_FREEBSD) || defined(_WIN32)
     if (!dco_enabled(&c->opt=
ions))
@@ -750,7 +754,7 @@
     }
     ASSERT(TUNNEL_TYPE(c->c1=2Etuntap) =
=3D=3D DEV_TYPE_TUN);
 
-    msg(D_DCO, "DCO: attempt removing iroutes from=
 system table");
+    msg(D_DCO, "DCO: attempt removing IPv4 iroutes from s=
ystem table");
 
     if (c->c2=2Epush_ifconfig_defined)
     {
@@ -778,6 +=
782,20 @@
         }
 #endif
     }
+#endif /* if defined(TARGET_LINUX) || =
defined(TARGET_FREEBSD) || defined(_WIN32) */
+}
+
+void
+dco_delete_iroute=
s_v6(openvpn_net_ctx_t *net_ctx, const struct context *c)
+{
+#if defined(T=
ARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
+    if (!dco_en=
abled(&c->options))
+    {
+        return;
+    }
+    ASSERT(TUNNEL_TYPE(=
c->c1=2Etuntap) =3D=3D DEV_TYPE_TUN);
+
+    msg(D_DCO, "DCO: attempt remov=
ing IPv6 iroutes from system table");
 
     if (c->c2=2Epush_ifconfig_ipv6=
_defined)
     {
diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
ind=
ex c435f8c=2E=2Ece44331 100644
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/=
dco=2Eh
@@ -218,12 +218,20 @@
                         const struct mroute_=
addr *addr);
 
 /**
- * Remove all routes added through the specified clien=
t
+ * Remove all IPv4 routes added through the specified client
  *
  * @pa=
ram net_ctx   the iface networking context
  * @param c         the client =
context for which routes have to be removed
  */
-void dco_delete_iroutes(o=
penvpn_net_ctx_t *net_ctx, const struct context *c);
+void dco_delete_irout=
es_v4(openvpn_net_ctx_t *net_ctx, const struct context *c);
+
+/**
+ * Remo=
ve all IPv6 routes added through the specified client
+ *
+ * @param net_ct=
x   the iface networking context
+ * @param c         the client context fo=
r which routes have to be removed
+ */
+void dco_delete_iroutes_v6(openvpn_=
net_ctx_t *net_ctx, const struct context *c);
 
 /**
  * Update traffic sta=
tistics for all peers
@@ -356,12 +364,17 @@
 }
 
 static inline void
-dco_i=
nstall_iroute(struct multi_context *m, struct multi_instance *mi, struct mr=
oute_addr *addr)
+dco_install_iroute(struct multi_context *m, struct multi_=
instance *mi, const struct mroute_addr *addr)
 {
 }
 
 static inline void
-=
dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struct context *c)
+dc=
o_delete_iroutes_v4(openvpn_net_ctx_t *net_ctx, const struct context *c)
+{=

+}
+
+static inline void
+dco_delete_iroutes_v6(openvpn_net_ctx_t *net_ctx=
, const struct context *c)
 {
 }
 
diff --git a/src/openvpn/dco_win=2Ec b/s=
rc/openvpn/dco_win=2Ec
index 12b0666=2E=2E68ae7c5 100644
--- a/src/openvpn/=
dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -1007,7 +1007,7 @@
     return=
 dco_get_version(&ver) && ver=2EMajor >=3D 2;
 }
 
-void
+bool
 dco_win_add=
_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits,
     =
                    unsigned int peer_id)
 {
@@ -1021,16 +1021,18 @@
      =
   netbits, peer_id);
 
     DWORD bytes_returned =3D 0;
-    if (!DeviceIo=
Control(dco->tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NUL=
L, 0,
-                         &bytes_returned, NULL))
+    bool installed=
 =3D DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeo=
f(route), NULL, 0,
+                                     &bytes_returned, N=
ULL);
+    if (!installed)
     {
         msg(M_WARN | M_ERRNO, "DeviceIoC=
ontrol(OVPN_IOCTL_MP_ADD_IROUTE) failed");
     }
 
     gc_free(&gc);
+   =
 return installed;
 }
 
-void
+bool
 dco_win_add_iroute_ipv6(dco_context_t =
*dco, struct in6_addr dst, unsigned int netbits,
                         u=
nsigned int peer_id)
 {
@@ -1042,13 +1044,15 @@
         netbits, peer_id);=

 
     DWORD bytes_returned =3D 0;
-    if (!DeviceIoControl(dco->tt->hand=
, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NULL, 0,
-              =
           &bytes_returned, NULL))
+    bool installed =3D DeviceIoControl(=
dco->tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NULL, 0,
+ =
                                    &bytes_returned, NULL);
+    if (!insta=
lled)
     {
         msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_=
ADD_IROUTE) failed");
     }
 
     gc_free(&gc);
+    return installed;
 }=

 
 void
diff --git a/src/openvpn/dco_win=2Eh b/src/openvpn/dco_win=2Eh
ind=
ex a92e5ad=2E=2E28795b7 100644
--- a/src/openvpn/dco_win=2Eh
+++ b/src/open=
vpn/dco_win=2Eh
@@ -67,10 +67,10 @@
 
 bool dco_win_supports_multipeer(void=
);
 
-void dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsig=
ned int netbits,
+bool dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_=
t dst, unsigned int netbits,
                              unsigned int pee=
r_id);
 
-void dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_addr =
dst, unsigned int netbits,
+bool dco_win_add_iroute_ipv6(dco_context_t *dco=
, struct in6_addr dst, unsigned int netbits,
                              =
unsigned int peer_id);
 
 void dco_win_del_iroute_ipv4(dco_context_t *dco, =
in_addr_t dst, unsigned int netbits);
diff --git a/src/openvpn/forward=2Ec =
b/src/openvpn/forward=2Ec
index eb41d03=2E=2E6ef480e 100644
--- a/src/openv=
pn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -555,10 +555,17 @@
      * =
last connecting client claiming the iroutes takes ownership=2E Therefore
  =
    * they are not removed during delayed cleanup=2E
      */
-    if (c->d=
id_dco_iroutes)
+
+    if (c->did_dco_iroutes_v4)
     {
-        c->did_dc=
o_iroutes =3D false;
-        dco_delete_iroutes(&c->net_ctx, c);
+        =
c->did_dco_iroutes_v4 =3D false;
+        dco_delete_iroutes_v4(&c->net_ctx=
, c);
+    }
+
+    if (c->did_dco_iroutes_v6)
+    {
+        c->did_dco_i=
routes_v6 =3D false;
+        dco_delete_iroutes_v6(&c->net_ctx, c);
     }=

 
     tls_set_single_session(c->c2=2Etls_multi);
diff --git a/src/openvpn=
/multi=2Ec b/src/openvpn/multi=2Ec
index 0027550=2E=2Ea850e72 100644
--- a/=
src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -479,6 +479,28 @@
    =
 set_prefix(mi);
 }
 
+static void
+multi_del_dco_iroutes_v4(struct multi_c=
ontext *m, struct multi_instance *mi)
+{
+    /* Only remove DCO IPv4 irout=
es this instance installed=2E */
+    if (mi->context=2Edid_dco_iroutes_v4)=

+    {
+        mi->context=2Edid_dco_iroutes_v4 =3D false;
+        dco_d=
elete_iroutes_v4(&m->top=2Enet_ctx, &mi->context);
+    }
+}
+
+static void=

+multi_del_dco_iroutes_v6(struct multi_context *m, struct multi_instance *=
mi)
+{
+    /* Only remove DCO IPv6 iroutes this instance installed=2E */
+=
    if (mi->context=2Edid_dco_iroutes_v6)
+    {
+        mi->context=2Edid=
_dco_iroutes_v6 =3D false;
+        dco_delete_iroutes_v6(&m->top=2Enet_ctx=
, &mi->context);
+    }
+}
+
 /*
  * Tell the route helper about deleted ir=
outes so
  * that it can update its mask of currently used
@@ -490,12 +512,=
8 @@
     const struct iroute *ir;
     const struct iroute_ipv6 *ir6;
 
- =
   /* check if DCO iroutes were already removed when scheduling a delayed e=
xit */
-    if (mi->context=2Edid_dco_iroutes)
-    {
-        mi->context=
=2Edid_dco_iroutes =3D false;
-        dco_delete_iroutes(&m->top=2Enet_ctx=
, &mi->context);
-    }
+    multi_del_dco_iroutes_v4(m, mi);
+    multi_de=
l_dco_iroutes_v6(m, mi);
 
     if (TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =
=3D=3D DEV_TYPE_TUN)
     {
@@ -1309,8 +1327,6 @@
     if (TUNNEL_TYPE(mi->=
context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
     {
         mi->did_iroutes=
 =3D true;
-        /* multi_learn_in{6}_addr_t takes care of installing th=
e DCO iroute */
-        mi->context=2Edid_dco_iroutes =3D true;
         f=
or (ir =3D mi->context=2Eoptions=2Eiroutes; ir !=3D NULL; ir =3D ir->next)
=
         {
             if (ir->netbits >=3D 0)
diff --git a/src/openvpn/op=
envpn=2Eh b/src/openvpn/openvpn=2Eh
index cdd02b6=2E=2E72436fe 100644
--- a=
/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -507,7 +507,8 @@
=
     bool did_we_daemonize;       /**< Whether demonization has already
   =
                                *   taken place=2E */
 
-    bool did_dco_i=
routes;        /**< Whether DCO iroutes have been installed */
+    bool di=
d_dco_iroutes_v4;     /**< Whether DCO IPv4 iroutes have been installed */
=
+    bool did_dco_iroutes_v6;     /**< Whether DCO IPv6 iroutes have been i=
nstalled */
 
     struct context_persist persist;
     /**< Persistent %co=
ntext=2E */

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2061?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic0=
b8b0a3249eb41e1de10f381932c1161cd75270
Gerrit-Change-Number: 2061
Gerrit-Pa=
tchSet: 3
Gerrit-Owner: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Co=
jocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: Marco Baffo <marco@mandelbit=2Ecom=
>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--lXfzNyBhS44=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo, R=C4=83zvan Cojocaru=2E </=
p>
<p>Marco Baffo <strong>uploaded patch set #3</strong> to this change=2E<=
/p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demai=
l">View Change</a></p><p>The following approvals got outdated and were remo=
ved:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">dco: track in=
stalled iroutes separately for IPv4 and IPv6<br><br>Track successful route =
installation per address family and split route<br>deletion into IPv4 and I=
Pv6 helpers=2E Update delayed-exit cleanup=2E<br>Return installation status=
 from the Windows helpers and keep the<br>non-DCO declarations compatible=
=2E<br><br>Change-Id: Ic0b8b0a3249eb41e1de10f381932c1161cd75270<br>Signed-o=
ff-by: Marco Baffo &lt;marco@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/dc=
o=2Ec<br>M src/openvpn/dco=2Eh<br>M src/openvpn/dco_win=2Ec<br>M src/openvp=
n/dco_win=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn/multi=2Ec<br>M =
src/openvpn/openvpn=2Eh<br>7 files changed, 94 insertions(+), 35 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/61/2061/3</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/sr=
c/openvpn/dco=2Ec</span><br><span>index f3b5d44=2E=2Ef807002 100644</span><=
br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2E=
c</span><br><span>@@ -706,8 +706,8 @@</span><br><span>     if (addrtype =3D=
=3D MR_ADDR_IPV6)</span><br><span>     {</span><br><span> #if defined(_WIN3=
2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_win_add=
_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v6=2Eaddr, addr-&gt;n=
etbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
                  c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        bool installed =3D dco_win_add_=
iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v6=2Eaddr, addr-&gt;ne=
tbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                                    c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</=
span><br><span> #else</span><br><span>         const struct in6_addr *gatew=
ay =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span=
>         if (addr-&gt;type &amp; MR_ONLINK_DCO_ADDR)</span><br><span>@@ -7=
15,16 +715,18 @@</span><br><span>             gateway =3D NULL;</span><br><=
span>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        net_route_v6_add(&amp;m-&gt;top=2Enet_ctx, &amp;addr-&g=
t;v6=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                         gateway, c-&gt;c1=2Etuntap-&gt;actual_nam=
e, 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
         DCO_IROUTE_METRIC);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        bool installed =3D net_route_v6_add(&amp;m-&gt;top=2Enet_c=
tx, &amp;addr-&gt;v6=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                          gatewa=
y, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                          DCO_IROUTE_M=
ETRIC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
            =3D=3D 0;</span><br><span> #endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        mi-&gt;context=2Edid_dco_iroutes_v6 |=3D =
installed;</span><br><span>     }</span><br><span>     else if (addrtype =
=3D=3D MR_ADDR_IPV4)</span><br><span>     {</span><br><span> #if defined(_W=
IN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_win_=
add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v4=2Eaddr, addr-&g=
t;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                     c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        bool installed =3D dco_win_a=
dd_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v4=2Eaddr, addr-&gt=
;netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                       c-&gt;c2=2Etls_multi-&gt;rx_peer_id)=
;</span><br><span> #else</span><br><span>         in_addr_t dest =3D htonl(=
addr-&gt;v4=2Eaddr);</span><br><span>         const in_addr_t *gateway =3D =
&amp;mi-&gt;context=2Ec2=2Epush_ifconfig_local;</span><br><span>@@ -733,15 =
+735,17 @@</span><br><span>             gateway =3D NULL;</span><br><span> =
        }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        net_route_v4_add(&amp;m-&gt;top=2Enet_ctx, &amp;dest, addr-&g=
t;netbits, gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                       c-&gt;c1=2Etuntap-&gt;actual_name, 0, DCO_IROUTE_MET=
RIC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bool i=
nstalled =3D net_route_v4_add(&amp;m-&gt;top=2Enet_ctx, &amp;dest, addr-&gt=
;netbits, gateway,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                         c-&gt;c1=2Etuntap-&gt;actual_name,=
 0, DCO_IROUTE_METRIC)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                         =3D=3D 0;</span><br><span> #endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context=2Edid_dco_=
iroutes_v4 |=3D installed;</span><br><span>     }</span><br><span> #endif /=
* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */=
</span><br><span> }</span><br><span> </span><br><span> void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-dco_delete_iroutes(openvpn_net_ctx_t =
*net_ctx, const struct context *c)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+dco_delete_iroutes_v4(openvpn_net_ctx_t *net_ctx, const stru=
ct context *c)</span><br><span> {</span><br><span> #if defined(TARGET_LINUX=
) || defined(TARGET_FREEBSD) || defined(_WIN32)</span><br><span>     if (!d=
co_enabled(&amp;c-&gt;options))</span><br><span>@@ -750,7 +754,7 @@</span><=
br><span>     }</span><br><span>     ASSERT(TUNNEL_TYPE(c-&gt;c1=2Etuntap) =
=3D=3D DEV_TYPE_TUN);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    msg(D_DCO, &quot;DCO: attempt removing iroutes from s=
ystem table&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    msg(D_DCO, &quot;DCO: attempt removing IPv4 iroutes from system table&q=
uot;);</span><br><span> </span><br><span>     if (c-&gt;c2=2Epush_ifconfig_=
defined)</span><br><span>     {</span><br><span>@@ -778,6 +782,20 @@</span>=
<br><span>         }</span><br><span> #endif</span><br><span>     }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(TARGET=
_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_delete_irou=
tes_v6(openvpn_net_ctx_t *net_ctx, const struct context *c)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) =
|| defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!dco_enabled(&amp;c-&gt;options))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(=
TUNNEL_TYPE(c-&gt;c1=2Etuntap) =3D=3D DEV_TYPE_TUN);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msg(D_DCO, &quot;DCO: attempt removing IPv6 iroutes from=
 system table&quot;);</span><br><span> </span><br><span>     if (c-&gt;c2=
=2Epush_ifconfig_ipv6_defined)</span><br><span>     {</span><br><span>diff =
--git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh</span><br><span>index c43=
5f8c=2E=2Ece44331 100644</span><br><span>--- a/src/openvpn/dco=2Eh</span><b=
r><span>+++ b/src/openvpn/dco=2Eh</span><br><span>@@ -218,12 +218,20 @@</sp=
an><br><span>                         const struct mroute_addr *addr);</spa=
n><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * Remove all routes added through the specified client</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Remove all IPv4 routes =
added through the specified client</span><br><span>  *</span><br><span>  * =
@param net_ctx   the iface networking context</span><br><span>  * @param c =
        the client context for which routes have to be removed</span><br><s=
pan>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void dco_dele=
te_iroutes(openvpn_net_ctx_t *net_ctx, const struct context *c);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void dco_delete_iroutes_v4(ope=
nvpn_net_ctx_t *net_ctx, const struct context *c);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * R=
emove all IPv6 routes added through the specified client</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param net_ctx   the iface networking context</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c         the cl=
ient context for which routes have to be removed</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+void dco_delete_iroutes_v6(openvpn_net_ctx_t *net_ctx, const s=
truct context *c);</span><br><span> </span><br><span> /**</span><br><span> =
 * Update traffic statistics for all peers</span><br><span>@@ -356,12 +364,=
17 @@</span><br><span> }</span><br><span> </span><br><span> static inline v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_install_iroute=
(struct multi_context *m, struct multi_instance *mi, struct mroute_addr *ad=
dr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_install_irou=
te(struct multi_context *m, struct multi_instance *mi, const struct mroute_=
addr *addr)</span><br><span> {</span><br><span> }</span><br><span> </span><=
br><span> static inline void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struct context =
*c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_delete_irout=
es_v4(openvpn_net_ctx_t *net_ctx, const struct context *c)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_delete_iroute=
s_v6(openvpn_net_ctx_t *net_ctx, const struct context *c)</span><br><span> =
{</span><br><span> }</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>index 12b0666=2E=
=2E68ae7c5 100644</span><br><span>--- a/src/openvpn/dco_win=2Ec</span><br><=
span>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -1007,7 +1007,7 @@</s=
pan><br><span>     return dco_get_version(&amp;ver) &amp;&amp; ver=2EMajor =
&gt;=3D 2;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool</span><br><span> dco_win_add_iroute_ipv4(dco_context_t *dco=
, in_addr_t dst, unsigned int netbits,</span><br><span>                    =
     unsigned int peer_id)</span><br><span> {</span><br><span>@@ -1021,16 +=
1021,18 @@</span><br><span>         netbits, peer_id);</span><br><span> </s=
pan><br><span>     DWORD bytes_returned =3D 0;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN=
_IOCTL_MP_ADD_IROUTE, &amp;route, sizeof(route), NULL, 0,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                         &amp;bytes_ret=
urned, NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bo=
ol installed =3D DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_ADD_IRO=
UTE, &amp;route, sizeof(route), NULL, 0,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                     &amp;bytes_return=
ed, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
installed)</span><br><span>     {</span><br><span>         msg(M_WARN | M_E=
RRNO, &quot;DeviceIoControl(OVPN_IOCTL_MP_ADD_IROUTE) failed&quot;);</span>=
<br><span>     }</span><br><span> </span><br><span>     gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return installed;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+bool</span><br><span> dco_win_add_iroute_ipv6(dco_context_t *dco, struct i=
n6_addr dst, unsigned int netbits,</span><br><span>                        =
 unsigned int peer_id)</span><br><span> {</span><br><span>@@ -1042,13 +1044=
,15 @@</span><br><span>         netbits, peer_id);</span><br><span> </span>=
<br><span>     DWORD bytes_returned =3D 0;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOC=
TL_MP_ADD_IROUTE, &amp;route, sizeof(route), NULL, 0,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                         &amp;bytes_returne=
d, NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool i=
nstalled =3D DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_ADD_IROUTE,=
 &amp;route, sizeof(route), NULL, 0,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                     &amp;bytes_returned, =
NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!inst=
alled)</span><br><span>     {</span><br><span>         msg(M_WARN | M_ERRNO=
, &quot;DeviceIoControl(OVPN_IOCTL_MP_ADD_IROUTE) failed&quot;);</span><br>=
<span>     }</span><br><span> </span><br><span>     gc_free(&amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return installed;</sp=
an><br><span> }</span><br><span> </span><br><span> void</span><br><span>dif=
f --git a/src/openvpn/dco_win=2Eh b/src/openvpn/dco_win=2Eh</span><br><span=
>index a92e5ad=2E=2E28795b7 100644</span><br><span>--- a/src/openvpn/dco_wi=
n=2Eh</span><br><span>+++ b/src/openvpn/dco_win=2Eh</span><br><span>@@ -67,=
10 +67,10 @@</span><br><span> </span><br><span> bool dco_win_supports_multi=
peer(void);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-void dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, uns=
igned int netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ool dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int=
 netbits,</span><br><span>                              unsigned int peer_i=
d);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
void dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsig=
ned int netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned=
 int netbits,</span><br><span>                              unsigned int pe=
er_id);</span><br><span> </span><br><span> void dco_win_del_iroute_ipv4(dco=
_context_t *dco, in_addr_t dst, unsigned int netbits);</span><br><span>diff=
 --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>=
index eb41d03=2E=2E6ef480e 100644</span><br><span>--- a/src/openvpn/forward=
=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -555,=
10 +555,17 @@</span><br><span>      * last connecting client claiming the i=
routes takes ownership=2E Therefore</span><br><span>      * they are not re=
moved during delayed cleanup=2E</span><br><span>      */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;did_dco_iroutes)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (c-&gt;did_dco_iroutes_v4)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt=
;did_dco_iroutes =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        dco_delete_iroutes(&amp;c-&gt;net_ctx, c);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        c-&gt;did_dco_iroutes_v4 =3D f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco_de=
lete_iroutes_v4(&amp;c-&gt;net_ctx, c);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt=
;did_dco_iroutes_v6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt=
;did_dco_iroutes_v6 =3D false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        dco_delete_iroutes_v6(&amp;c-&gt;net_ctx, c);</span><br>=
<span>     }</span><br><span> </span><br><span>     tls_set_single_session(=
c-&gt;c2=2Etls_multi);</span><br><span>diff --git a/src/openvpn/multi=2Ec b=
/src/openvpn/multi=2Ec</span><br><span>index 0027550=2E=2Ea850e72 100644</s=
pan><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn=
/multi=2Ec</span><br><span>@@ -479,6 +479,28 @@</span><br><span>     set_pr=
efix(mi);</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+multi_del_dco_iroutes_v4(struct multi_context *m, struct=
 multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Only remov=
e DCO IPv4 iroutes this instance installed=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Edid_dco_iroutes_v4)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context=2Edid_dco_ir=
outes_v4 =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        dco_delete_iroutes_v4(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&gt;context=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
ulti_del_dco_iroutes_v6(struct multi_context *m, struct multi_instance *mi)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Only remove DCO IPv6 iroutes t=
his instance installed=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (mi-&gt;context=2Edid_dco_iroutes_v6)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        mi-&gt;context=2Edid_dco_iroutes_v6 =3D false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco_delete_i=
routes_v6(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&gt;context);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> /*</span><br><span>  * Tell the route helper about =
deleted iroutes so</span><br><span>  * that it can update its mask of curre=
ntly used</span><br><span>@@ -490,12 +512,8 @@</span><br><span>     const s=
truct iroute *ir;</span><br><span>     const struct iroute_ipv6 *ir6;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* ch=
eck if DCO iroutes were already removed when scheduling a delayed exit */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mi-&gt;context=
=2Edid_dco_iroutes)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;con=
text=2Edid_dco_iroutes =3D false;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        dco_delete_iroutes(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&g=
t;context);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_del_dco_iroute=
s_v4(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mul=
ti_del_dco_iroutes_v6(m, mi);</span><br><span> </span><br><span>     if (TU=
NNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><spa=
n>     {</span><br><span>@@ -1309,8 +1327,6 @@</span><br><span>     if (TUN=
NEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><span=
>     {</span><br><span>         mi-&gt;did_iroutes =3D true;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /* multi_learn_in{6}_addr_t=
 takes care of installing the DCO iroute */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        mi-&gt;context=2Edid_dco_iroutes =3D true;</s=
pan><br><span>         for (ir =3D mi-&gt;context=2Eoptions=2Eiroutes; ir !=
=3D NULL; ir =3D ir-&gt;next)</span><br><span>         {</span><br><span>  =
           if (ir-&gt;netbits &gt;=3D 0)</span><br><span>diff --git a/src/o=
penvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</span><br><span>index cdd02b6=
=2E=2E72436fe 100644</span><br><span>--- a/src/openvpn/openvpn=2Eh</span><b=
r><span>+++ b/src/openvpn/openvpn=2Eh</span><br><span>@@ -507,7 +507,8 @@</=
span><br><span>     bool did_we_daemonize;       /**&lt; Whether demonizati=
on has already</span><br><span>                                   *   taken=
 place=2E */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    bool did_dco_iroutes;        /**&lt; Whether DCO iroutes have =
been installed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  bool did_dco_iroutes_v4;     /**&lt; Whether DCO IPv4 iroutes have been i=
nstalled */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 did_dco_iroutes_v6;     /**&lt; Whether DCO IPv6 iroutes have been install=
ed */</span><br><span> </span><br><span>     struct context_persist persist=
;</span><br><span>     /**&lt; Persistent %context=2E */</span><br></pre><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?=
usp=3Demail">change 2061</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2061?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchs=
et </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: Ic0b8b0a3249eb41e1de10f381932c1161cd75270 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 2061 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerr=
it-Owner: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Marco Baffo &lt;marco@mandelbi=
t=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--lXfzNyBhS44=--


--===============0164996179919185909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0164996179919185909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0164996179919185909==--

