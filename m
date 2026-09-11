Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004ECC88E45
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ASGXc20FiLl82qLh8lLUhPbwlRxbqCmYJt3mXEaySF4=; b=MctyNZtGi/WH/NROoA0SLN6F/V
	GJfE+JpyNeRSUrj8cL4ETvCcXlTo59pyaqZ/ZT7DgxkC9Yzr2oRdlGyPQwBdxgqGKEAJ1OODrlx2e
	MpSD0MCT7cVjcnlM6+q6jDyzm4S3Tjr3BgWQE6nOIqyFXyvIh2inQUxppkYaKejr8uHs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x51jr-0001gI-AO;
	Fri, 11 Sep 2026 13:56:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x51jS-0001e1-Sg
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:55:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LFJ9uimeAj9MQ822uy09wDGMcGYfebdyhCbSU97zLjU=; b=JqhciZDyk87+HfIQdDvjNKV+Oj
 EBfiXg8Yq4hSfiqChqpB7Fq0CDdMMzVk1GRNgNGi31kRWHWgMcHcjOIP8gZ8MzX8bXCfk7GwCfGQx
 z3ixA+ygypaxkblEh+6QhX/jyp/N8H2WEdT3HLK4tGHKbI6415Q/ROaZ+Q7WmrDjm0JY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LFJ9uimeAj9MQ822uy09wDGMcGYfebdyhCbSU97zLjU=; b=m
 Ak1HdMf3Nd7lKMEIk+qWBSoaRtD0hj6AvNMQjvl/CuAaxZEbcMJYOW2L+VnwwlxHROzTJUGFb2pE2
 HAQkgZZEr6drwK8v17oux0+zGiIlAwN9lKuIrnVbj9ipS6pTmPY1s+q/u9cazTdtqyTjQCOcJM5A9
 3bbkNr73X+sEq1B4=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x51jF-0006bP-Nq for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:55:47 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49e668491f3so2986025e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789134939; x=1789739739; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LFJ9uimeAj9MQ822uy09wDGMcGYfebdyhCbSU97zLjU=;
 b=Gqdh7F2gjGBIAtkNBqiRM3xXtYGgWr4hl6iUvZ/WO4AB0C0BVYBKO0s6IQUf0lsDTT
 I8VjLYyzmjkWMjNrPmI6g5HmhwZAeJNncJcWJjPeQiNDQUH5STNEpHdfR8ZwTqNfavzD
 VMMUO8mBUAO6m8t0xa0n+R5KdtcbaCG0NooKkM1qnk0UBncAZ+jxhF+xaX1sXKPrVW0b
 0de1WrcmYBVoiKUmJaxZKeu5z4thp/G1386bnmDr0RUprwIu2Hf1eil7lgge37mi0ttZ
 KHA7R7WAZjsFmBjjsP3Q+PD0QO4WiZS+B2riqIDNW1tQvEyn82PK53n4YkuwKt2MBk/0
 RJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789134939; x=1789739739;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LFJ9uimeAj9MQ822uy09wDGMcGYfebdyhCbSU97zLjU=;
 b=HPwD1uZwtmEaK4A/fr7twITpgZmE4TvlTHm71PpIkOdGHj3t4BWq6k4x0pE2LM3yOc
 H2j8iZEaCOgVtQxXczyYcXoHw8urgFNnF3U2HpzdqQUf0lt3DkGxxrg1tUQQH7tUQaqv
 uAI0YaY1aLyfbZTVuQjR6lye2JXC1w0jFtqdCppc/fdr1mO8FvTR5vHGMeihjhtFoPpw
 PPtfg1rQD6LCsZ7oX6ib3qqi9GTGNt8bK1kOUbJV5A4120YfcYZjMJAtPEsqxvYWyuSU
 GAbY0K25JhcVULlc6GRSbY3B2T5AxRgcDXFQ53yQfiTZrQ8hpw0wI6QnKqkltYmMQ6LR
 YT/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwB1TkrMiUO9C7bj82qvLxiZKPN4LYgODP6fA5yGUOPBJyPbADtzmRmaCtKkH4PqO3BmZUwa12cmoCrPf7D@lists.sourceforge.net
X-Gm-Message-State: AFuF++n8DrLHfcUSoKBcJzDXDNea0e9m0IfGs1JxmNXYtxWF05Ff+4RE
 7Y+yeytZ6YU5KutC3PgcA5nWEIqNuOQMthT20xN7jnv1tXL+/3BTVlCk2zlBGkRd+FR/Blx3tVu
 HLNIatZ2hfrxB0KTjjbii4o3xric+KXdJqlq1TcAmD83PYwkwdWqEq6Cd+Rg6m5a9wHxv
X-Gm-Gg: AYBFou2YpEg1daU0uZJCKvnUQi86SQ9UnDubG4J2dhNHnw2+C2gst4jD2yyOFEnAPVv
 fnBiranYdTRwTX0xQwkASKux4/LfnUuE2tQWpAYWW1wFZIIVIOcosHCj9MzggU3Lmq3t+fwrynt
 5QlUvzj4FCOh5V/3DJGHw4+Ar//o3nlVuhInjQo7lrkgJaczbUB6kRNBKWmX4RNcLOuVf0Y04LP
 ogVwraDGKLKoGOgan/NLI2Tl67rcmWp7zYifY3qDn+Dg25AY+ABygPIVgSxN6YbY/cxsG6P5AnI
 mScPyp/SV48KfJtQYJ82h9umsCb1GtkWSaOQN9/RNIkxfQCZhHj+NkkAAwSgJ+Dluim1tTYA7uC
 SYjOmJtDjwLjE8gBsh4CI/ytBGAyFIB9EcBTmzBoz/ZaJgh6eFnPM8n9aFoChP6krZfaqPG8/KP
 6FhRmtcaZj3+0yT25BKE35LRIMD0Hr+Au0HhlCtrMGcVSdshgFVgXnxCxHqGFeYv62G3L9FrrFQ
 0/MC+oLgKsFnjRzniICRos8dN9W28HdtCmVB+VBsuuAEtoH4rvlFjWZTXgbnCxjYQRKNZmD4ndm
 v7axfY+OBh+rXkW6bLfEbdtcwgLPKkI8BYelnGFnQXqgL40s7/sQYV6lh96aWw==
X-Received: by 2002:a05:600c:4687:b0:49d:2625:1b0f with SMTP id
 5b1f17b1804b1-49e619e7090mr50302045e9.31.1789134938948; 
 Fri, 11 Sep 2026 06:55:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a81943sm47629545e9.1.2026.09.11.06.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 06:55:38 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 13:55:36 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: 1461de6294312e7a91facf151d1360a5f35ad0fb
X-Gerrit-Comment-Date: Fri, 11 Sep 2026 13:55:36 +0000
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fe8f291c183371e396f74cd896ceacc5bc52b5a3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x51jF-0006bP-Nq
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 --server-probe to order client remotes by probe
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9203643959704191212=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9203643959704191212==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="20Zqm/nIbVk="; charset=UTF-8

--20Zqm/nIbVk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1747?usp=3Demail )

Change subject: oob: Add --server-probe to or=
der client remotes by probe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 19: Code-Review-1

(3 comments)

Patchset:

PS1=
9: 
The previous socket properties issues are all gone but I think there's =
still a problem with socket creation which could abort the program instead =
of erroring gracefully=2E


File src/openvpn/oob_client=2Ec:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/9cedd114_6071b61a?usp=3Demail :
P=
S19, Line 213:         pc->sd[i] =3D create_socket_udp_configured((sa_famil=
y_t)families[i], o->sockflags, &sbs,
`oob_probe_sockets_open` creates socke=
ts for every address family needed by the resolved probe targets, but `crea=
te_socket_udp_configured` aborts the program if any socket cannot be create=
d (`M_ERR`)=2E With the later "probe every resolved address" patch, a dual-=
stack hostname requires both sockets=2E

For example, probing both IPv4 and=
 IPv6 can abort on an IPv6-incapable system even though the IPv4 targets ar=
e usable=2E Probably, in this case, probe socket creation should leave that=
 family's descriptor as SOCKET_UNDEFINED, instead of fatal=2E


http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/ea1fb9df_b32e5215?usp=3Demail :=

PS19, Line 464:             && !oob_probe_same_bind(l->array[0], ce, &c->o=
ptions))
This is not really a blocker but I'm wondering why bind settings a=
re compared against `l->array[0]` regardless of whether that entry can be p=
robed=2E A TCP first entry, or a UDP-over-SOCKS entry with different bind s=
ettings, can disable probing even when all direct UDP candidates have ident=
ical settings=2E

Since only direct UDP entries can respond and adopt a pro=
be socket, could the first probeable direct UDP entry be used as the socket=
 template, with compatibility checked only among the other probeable entrie=
s? Otherwise mixed connection profiles can unnecessarily disable `--server-=
probe`=2E

More generally, I don't think it is necessary to require every p=
robeable UDP entry to have the same bind configuration=2E For example, give=
n one `--nobind` UDP entry followed by ten UDP entries using `--lport 420`,=
 probing is disabled completely=2E Ideally the entries could be grouped by =
compatible socket configuration, with one probe socket per address family a=
nd bind group (the socket belonging to the winning group could then be adop=
ted)=2E But I understand that this requires reply matching and endpoint ded=
uplication to be scoped to the socket group so maybe we can simply document=
 this limitation clearly for now=2E



-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1747?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Gerrit-Change-Nu=
mber: 1747
Gerrit-PatchSet: 19
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ra=
lf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: F=
ri, 11 Sep 2026 13:55:36 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Y=
es

--20Zqm/nIbVk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 19:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><p>3=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?tab=3Dco=
mments&amp;usp=3Demail">Patch Set #19:</a> </p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">The previous socket propert=
ies issues are all gone but I think there&#39;s still a problem with socket=
 creation which could abort the program instead of erroring gracefully=2E</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/o=
ob_client=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/9cedd114_6071b61=
a?usp=3Demail">Patch Set #19, Line 213:</a> <code style=3D"font-family:mono=
space,monospace">        pc-&gt;sd[i] =3D create_socket_udp_configured((sa_=
family_t)families[i], o-&gt;sockflags, &amp;sbs,</code></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">`oob_probe_sock=
ets_open` creates sockets for every address family needed by the resolved p=
robe targets, but `create_socket_udp_configured` aborts the program if any =
socket cannot be created (`M_ERR`)=2E With the later &quot;probe every reso=
lved address&quot; patch, a dual-stack hostname requires both sockets=2E</p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">For example, probing both IPv4 and IPv6 can abort on an IPv6-incapable sy=
stem even though the IPv4 targets are usable=2E Probably, in this case, pro=
be socket creation should leave that family&#39;s descriptor as SOCKET_UNDE=
FINED, instead of fatal=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1747/comment/ea1fb9df_b32e5215?usp=3Demail">Patch Set #1=
9, Line 464:</a> <code style=3D"font-family:monospace,monospace">          =
  &amp;&amp; !oob_probe_same_bind(l-&gt;array[0], ce, &amp;c-&gt;options))<=
/code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">This is not really a blocker but I&#39;m wondering why bind sett=
ings are compared against `l-&gt;array[0]` regardless of whether that entry=
 can be probed=2E A TCP first entry, or a UDP-over-SOCKS entry with differe=
nt bind settings, can disable probing even when all direct UDP candidates h=
ave identical settings=2E</p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Since only direct UDP entries can respond and=
 adopt a probe socket, could the first probeable direct UDP entry be used a=
s the socket template, with compatibility checked only among the other prob=
eable entries? Otherwise mixed connection profiles can unnecessarily disabl=
e `--server-probe`=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">More generally, I don&#39;t think it is necessary=
 to require every probeable UDP entry to have the same bind configuration=
=2E For example, given one `--nobind` UDP entry followed by ten UDP entries=
 using `--lport 420`, probing is disabled completely=2E Ideally the entries=
 could be grouped by compatible socket configuration, with one probe socket=
 per address family and bind group (the socket belonging to the winning gro=
up could then be adopted)=2E But I understand that this requires reply matc=
hing and endpoint deduplication to be scoped to the socket group so maybe w=
e can simply document this limitation clearly for now=2E</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1747?usp=3Demail">change 1747</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1747?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comme=
nt </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 1747 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 19 </div>
<div style=3D"display:none"> Ger=
rit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbi=
t=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 11=
 Sep 2026 13:55:36 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>=


</body></html>
--20Zqm/nIbVk=--


--===============9203643959704191212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9203643959704191212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9203643959704191212==--

