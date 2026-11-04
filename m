Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080C606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=h5IxCwqIOln+dJuj/nPexbIZsu+IHVnZVhEh8IxCuJU=; b=BWxh35DMqEanpjZfIj6bJhVjjw
	NnceXxz/460bjdejcSIAvh2LJl3cSkL5r9ppZTGbxQN4iCjMLDMTofm5aTvapGsGGqbzB54kFIppG
	g/1MibY3IQ0JMhCJSJ4OcUWhQyxsjqckD5TrpJ7p85hUqWFaws1D7OZkpFjCOHRYgQyc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xObv6-000000003m9-1KNl;
	Wed, 04 Nov 2026 14:24:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xObut-000000003lr-0D8M
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 14:24:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S2jFoAGV4iXCgDSU1uhamiBGsOrFoIsnvSBTGyAbHco=; b=jC1CPkruC0pxxc8JPq4IpbHbJ1
 5oSTKbhcpgqvHRMn9pxV+zYHFrW42RJs7JabYuWdkYwAvaSshbCqQi+3t+QilHWiKCVCS2qL3irUo
 w5zpdtt3cX/WLA6BmfeGY6eH36amSPxGSLiqB+ZzlONPH0TzE1PeEgEE3yBMIm2G3yC4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S2jFoAGV4iXCgDSU1uhamiBGsOrFoIsnvSBTGyAbHco=; b=U6T7JgU/iIMgsEKsZ1I5FNS0X4
 h5eoBC9rOhuk1egJYn6s11f6pmnK8L5Gmeab2LZFOx6udHCpHtRLc0oAFtSALaXQsNIm2n+93TG1D
 PmOEnE4bX4LzXmclmvuK4Oc2QBn8EuabsEyKkMEFMQaEwm8JQiMPC/7ZI3WSo47L5qKM=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xObus-000000005cO-1HRr for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 14:24:42 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so694259f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 06:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793802276; x=1794407076; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S2jFoAGV4iXCgDSU1uhamiBGsOrFoIsnvSBTGyAbHco=;
 b=aiX6szdM3BjtFIiTttUnzlR7hwD1RRLd+INopSKhMglqw8aAkR5c6l+ou5ANwKE6DI
 JXGsYVqLwdWQdYcOR84WdWqcXxJxZm4gCLuRZvf3jYhg1K1jF3eAq0shmkKX9wQJrxgz
 XY95Jf+kJnMfLOmTolegeImU/7WR//vlpAcnRW/WZCYvUVOxheSUpuzMTkaYMuxyARyY
 yWjhzNAECzBK42i5AmscEFnyzFK5y2K3O1HgzjGM8o2ETwjP0Oy2ZjVcUyShZhgGZxux
 DPphVc6U+5AupmjcfWr6whYMUb6wHaGQjpxebbHecspiyQbq7MlNS9qQVl4D8F37F2+s
 seqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793802276; x=1794407076;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S2jFoAGV4iXCgDSU1uhamiBGsOrFoIsnvSBTGyAbHco=;
 b=YD9C0QXmZ9d3SPxLFPMeISI0O8K1+ipm+65O/6RKLzrwrT2CsmSe//3D/uvwVwrqJ4
 nZ1LoB8evn64cqDjjEpP8XjRh76ghAlIGZlrfHTeALACatQyBfzK3mA50k28NF/PFkyr
 ZJj0GOdBJeALeR++PXjPsqn4cPdtOcq+0XHXU9A7DZd2oP3LL/H1Nn3mh5hoJeykpvCg
 GLAkVUiWg6Q/49Fys9Tn2+1mgJkINptKIg5IhEz8F+k6yPGGvKqCpW89TAsFCMypbI/i
 wi+jS1TbXLAuWTGo8Q5k76PLqOQ3pXU8YbPdayv1cDH1eojdTFqyymUl6501E/4scwjg
 o8Vg==
X-Gm-Message-State: APuU4Z+3wrsxSwD9SCnPahW8LUxSGGY5pcfgMeBYoXGkTkXWjqRKLiRr
 gRSG68x/dMp3cbnFCDU+ofWW8XTCDpfgi6EF7SIiIjAj4Z+Ee1CNAnJJyCeJz9lUTIqQZKgDUyD
 GVkQ37bWQYe9pia5KalI7xAvYFmmHyccpUq4WRyq7RGN+Z6GJ5m2LQRUWNYXKozL6PjMsI1WbkY
 CKqEu2NQ==
X-Gm-Gg: AYBFou3InSXMpS3OqiMtqvCpkVvoRUV81aAJ0L16uKPx7hcgLY+lv9yyg7WSG0TAl51
 5kBPrgUczRjmet7AV22oGvM+dauy8E7axF6XpWVySy5z7n1suoI2if5K3UHEYc7/JgQFo6tvqZa
 IlZFQE9BRpjtSUkoGlRBQqkOENXD51JW8y4A8+hwlQMy8PEkC/PAKD97Ed1xZIXFd/bVWO61J/m
 MS6kOAV6SSVF7vsMZc/KQof9phKthKq7PCyr5dPZrSQaFdpvsTH/i7XyzhWf6fazNht6rJJuTJ5
 tE3r9NkTr+XJfmAyIe97ZeVROht9V6gkqdlw/8gG549LK9AkAwT+T2drTP3r56SFfm+t+YzeyfT
 mxOajzhCDNWPLImxPBhj4xn4chUiyHMoCv0gQtk3oA045beU3Gkt8kdqCxfkEo4WmTU/nJvdFzF
 zpadQ79SPkFewYcgrMT7+RA9e+IqOh2TL/MZjGS5nXAqLnAhnL2kyttbMLGI0IWu3tu+Yj6OIkP
 hepliPk9ma5NjrkOsyMnRga/LR+A+8KtzfDJS4GGPWr/hfDyo2wG1DNQ2rsy05ApcE7FuHEEoh3
 DmyivbQ3ko0I03pqk45zunerYHy74nIua7+j28wMBtCcDQkj3CpoLhoU20sKMlgBH7Ti3nGAhWt
 HA2C9br1x5dVYabaNWQJ7lg/rUNbDWWPA/5hCxZjCc/Wl/OKLndw7oqcRYEYJVorGWx+gh66WhF
 14mEdnUMw60dHU0Q==
X-Received: by 2002:a05:6000:1785:b0:48d:f14a:9182 with SMTP id
 ffacd0b85a97d-48e6e2e7536mr38535950f8f.20.1793802274521; 
 Wed, 04 Nov 2026 06:24:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed553116sm4103599f8f.42.2026.11.04.06.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 06:24:34 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 14:24:33 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iba1db32cd130d092e34a31159f14d3aa37db96f2
X-Gerrit-Change-Number: 2133
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2133?usp=email>
X-Gerrit-Commit: fca817003bce8112ad4bbae42db93157919054ce
References: <gerrit.1793802273000.Iba1db32cd130d092e34a31159f14d3aa37db96f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzODAyMjczMDAwLkliYTFkYjMyY2QxMzBkMDkyZTM0YTMxMTU5ZjE0ZDNhYTM3ZGI5NmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bdbb7870f15818006844860160b92e9780db82b4-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xObus-000000005cO-1HRr
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: use
 multi_io_delete_event() and drop multi_tcp_delete_event()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7934736972086805101=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7934736972086805101==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uNq5mexvp4E="; charset=UTF-8

--uNq5mexvp4E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2133?usp=3Demail

to review the following change=2E
=


Change subject: multi: use multi_io_delete_event() and drop multi_tcp_del=
ete_event()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

m=
ulti: use multi_io_delete_event() and drop multi_tcp_delete_event()

cbb044=
0e ("multiproto: move generic event handling code in dedicated
files") adde=
d multi_io_delete_event() as a copy of
multi_tcp_delete_event() but kept th=
e old function and its only
caller=2E Switch management_delete_event() to t=
he new one and remove the
old copy=2E

Change-Id: Iba1db32cd130d092e34a3115=
9f14d3aa37db96f2
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---=

M src/openvpn/mtcp=2Ec
M src/openvpn/mtcp=2Eh
M src/openvpn/multi=2Ec
3 fi=
les changed, 1 insertion(+), 12 deletions(-)



  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/33/2133/1

diff --git a/src/openvpn=
/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index 2d0af06=2E=2E62d059e 100644
--- a/sr=
c/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -95,15 +95,6 @@
 }
 
 void=

-multi_tcp_delete_event(struct multi_io *multi_io, event_t event)
-{
-    =
if (multi_io && multi_io->es)
-    {
-        event_del(multi_io->es, event=
);
-    }
-}
-
-void
 multi_tcp_dereference_instance(struct multi_io *multi=
_io, struct multi_instance *mi)
 {
     const struct link_socket *sock =3D =
mi->context=2Ec2=2Elink_sockets[0];
diff --git a/src/openvpn/mtcp=2Eh b/src=
/openvpn/mtcp=2Eh
index 47c6308=2E=2Eb4ec1f9 100644
--- a/src/openvpn/mtcp=
=2Eh
+++ b/src/openvpn/mtcp=2Eh
@@ -43,6 +43,4 @@
 
 struct multi_instance =
*multi_create_instance_tcp(struct multi_context *m, struct link_socket *soc=
k);
 
-void multi_tcp_delete_event(struct multi_io *multi_io, event_t event=
);
-
 #endif /* ifndef MTCP_H */
diff --git a/src/openvpn/multi=2Ec b/src/o=
penvpn/multi=2Ec
index 3f514d6=2E=2E741b3d1 100644
--- a/src/openvpn/multi=
=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -4025,7 +4025,7 @@
     struct multi_co=
ntext *m =3D (struct multi_context *)arg;
     if (m->multi_io)
     {
-   =
     multi_tcp_delete_event(m->multi_io, event);
+        multi_io_delete_e=
vent(m->multi_io, event);
     }
 }
 

-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2133?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Iba1db32cd130d092e34a31159f14d3aa37db96f2
Gerrit-Chang=
e-Number: 2133
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--uNq5mexvp4E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2133?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">multi: use multi_io_delete_event() and drop multi_tcp_d=
elete_event()<br><br>cbb0440e (&quot;multiproto: move generic event handlin=
g code in dedicated<br>files&quot;) added multi_io_delete_event() as a copy=
 of<br>multi_tcp_delete_event() but kept the old function and its only<br>c=
aller=2E Switch management_delete_event() to the new one and remove the<br>=
old copy=2E<br><br>Change-Id: Iba1db32cd130d092e34a31159f14d3aa37db96f2<br>=
Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M sr=
c/openvpn/mtcp=2Ec<br>M src/openvpn/mtcp=2Eh<br>M src/openvpn/multi=2Ec<br>=
3 files changed, 1 insertion(+), 12 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/33/2133/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br=
><span>index 2d0af06=2E=2E62d059e 100644</span><br><span>--- a/src/openvpn/=
mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -95,=
15 +95,6 @@</span><br><span> }</span><br><span> </span><br><span> void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_delete_event(str=
uct multi_io *multi_io, event_t event)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (multi_io &amp;&amp; multi_io-&gt;es)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        event_del(multi_io-&gt;es, event);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span> multi_tcp_=
dereference_instance(struct multi_io *multi_io, struct multi_instance *mi)<=
/span><br><span> {</span><br><span>     const struct link_socket *sock =3D =
mi-&gt;context=2Ec2=2Elink_sockets[0];</span><br><span>diff --git a/src/ope=
nvpn/mtcp=2Eh b/src/openvpn/mtcp=2Eh</span><br><span>index 47c6308=2E=2Eb4e=
c1f9 100644</span><br><span>--- a/src/openvpn/mtcp=2Eh</span><br><span>+++ =
b/src/openvpn/mtcp=2Eh</span><br><span>@@ -43,6 +43,4 @@</span><br><span> <=
/span><br><span> struct multi_instance *multi_create_instance_tcp(struct mu=
lti_context *m, struct link_socket *sock);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void multi_tcp_delete_event(struct m=
ulti_io *multi_io, event_t event);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> #endif /* ifndef MTCP_H */</span><br><span>d=
iff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>i=
ndex 3f514d6=2E=2E741b3d1 100644</span><br><span>--- a/src/openvpn/multi=2E=
c</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -4025,7 +4=
025,7 @@</span><br><span>     struct multi_context *m =3D (struct multi_con=
text *)arg;</span><br><span>     if (m-&gt;multi_io)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_tcp_del=
ete_event(m-&gt;multi_io, event);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        multi_io_delete_event(m-&gt;multi_io, event);</span><=
br><span>     }</span><br><span> }</span><br></pre><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2133?usp=3Demail">change 21=
33</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2133?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iba1db32cd130d092e34a31159f14d3aa37db96f2 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2133 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--uNq5mexvp4E=--


--===============7934736972086805101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7934736972086805101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7934736972086805101==--

