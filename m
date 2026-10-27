Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84561606A31F
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LcOffXEm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NrZlXDMP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=b9kvwy5E;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Xf8rIpc0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=zkJRymuewQ9YOg0BUZGT1g9NC4DFW5upxTEF1ZDwTsU=; b=LcOffXEm0eV4h2I10DlbGE7u+A
	89BAVTesIwUD9kBWgfC+RpSoFl4Dt+q2qx+rO9nVRVbajPgaFgMleaYPnP7Awj9fIGOGtSfOwKldw
	+l2Vo1lYbQ8hDjUrl7eXLzfC8hWcGWzCrKjjIzkAyf0+thl4nkxjWDKUGMgjzq0/ZmPw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLi2Q-0000000061K-1Lt3;
	Tue, 27 Oct 2026 14:20:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLi2P-0000000061E-0AEz
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 14:20:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HljAiYTE9gTCEnSczexU/J+X5UGzE95CYgy6x7o3ZrA=; b=NrZlXDMPu21IrkBfNz6ZKsJ4o0
 shZhUO6egfSkt6kVLBf3Nak7R26wFC6qgAERY8SzzkC7WsNaTuwB4HlbJrbmgeC88GCwwfcry2zoT
 LUzIcg29z/oZKLB5TwobHBJS5V2wjQ/zLsfDXua2fXjCYqwmJLPXg9UsuCYotwj4gMFM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HljAiYTE9gTCEnSczexU/J+X5UGzE95CYgy6x7o3ZrA=; b=b9kvwy5EX3xYzNfN0ra2fCZGcv
 V3hwRG7zxduT2a7XLT+bPLXZ6/sbqiS91klnTQ5lQMQ0LfEabb0UqzKE0X2YpsvOq7s3Zmom8Ma/u
 WlpkKuUtWF0LCiC8ksbUX52hJorQ30k22AUL4NDifAlpPbvEm09MjmfDHPXxx5TwzzLo=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLi2N-000000000ST-0yf3 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 14:20:28 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so2759052f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 07:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793110821; x=1793715621; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HljAiYTE9gTCEnSczexU/J+X5UGzE95CYgy6x7o3ZrA=;
 b=Xf8rIpc0U/pFiX/AZzlflEe/unLbs4EdtRf3ZMWKMKneMzVEiSUhi7b7BsehsJfGYq
 0LIyMY/sH4FZHRBBaaiPmNgUQ3P18rYAr4n299lOzmluwM2y8fIJWs7Jz4EfPRKULK3y
 Exfa6Pa6UCDo/c+EKg3v+BcnBQQ6TbMf/EK8jV8Xjtb4no88xG4X5gv+GC4baLnbxHVk
 GZJEbr04WVqR223dZNAiyUXpvXKl/6d3K3198NmkBedlQM3gLLSA9fHK3K9gj/hz1hrW
 xIy4Exm01g7sGt5BPYMOxpeKsh8uLYXwwmsbN8nipG5AJBlsFFX58EA+SdRW/Nhw9eaB
 W1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793110821; x=1793715621;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HljAiYTE9gTCEnSczexU/J+X5UGzE95CYgy6x7o3ZrA=;
 b=SrgOW8MadCsPkbKKQ1Uw0Nwv9XPRgiv/JX6LN3VmSFiEfJOOad5Ljzpk9slPjwUUOj
 GhE24wwo0RVJk/SDztSFMhlIQzJRfmGGcItHr9XvAjc3qlqxjQw73gP/de21mlqAZqh0
 chpjm1ggCbgt6pIFi/sjDFWsTV7Q0G1rvvt9ca45/o9FTkeTmcXTOOrUo+smTtcgZru/
 oCX23m+cIScNUqLKfMWLN1uzxf7+ETzKhUFAn6n/HQICa3UW523YMe55li/udYydSuZQ
 BHPOU7KAp0cwC3fCnw2Qg+QB/mu+pTdFoR8JyRF0BloT9e7F/X/HxRZ2hg3oWuW0Oqhy
 bdFg==
X-Gm-Message-State: AFq9FYI4IL+NAUOWxzuZ81A5S9mFH7V7jboXyV0GbNrsPp4cI6xpYWV1
 nfxYIl9QR15T4DdTmhg8HUGdg80TQYJZwoNlrS0xNP1zr1l0lxDG4lSnKwo8DAb1h0K+d6zxR00
 UZY0EAu3u+rSznz2V7KfYYWfR7I0eqlasrb3H0bmAQm8haFZjxTKnu6klWNQLX/25LzR6Ler05a
 ydgEvPgA==
X-Gm-Gg: AYBFou17uzylCdmf7AUaCI8kJVaN6lsVok15uADRQfAzrG9MwkPtrcHtj/tfKxagPFU
 Bz6iQQ7q2YVJnfCw2Z62I6V8kzWtQt922EVJWURwlzS7BjRtinZW4wnrs5Cxmprqb79+cct91fR
 hpRmZZuIeD9x1ZmTqAxIyFfUppp5D9xNFJgXuX1QdNv4AZrYA6Jk6tCeWdZOfjW9GNI7Y86WTe5
 rRYRyvg03gUv1bXKuPPsYp5hQ/6QMHSEcnpo3ItdFPPHZdsy81OvjASodAo/Wuc2e4EPdGuYbfg
 K7sRMGdQciyk26Vi6QcSss9IGiy81x5nn5xpP9qYM6rw3oO2Lv0VpZTfLieC7JxJ8KBPl+jgPDM
 sqNsdmsuuH/B1HWalD7WmEoCwYsq6ydPIxogFVQVVeSO9ynbE5yYKkJPOpL/0kLrEJ3AwnGbOv2
 ay8OHNFDFrrxXwgOH9kLSWX5BCOQQRvyVMaFw7EWwSbGCtrf8edJQ8kX/qN9DqzZ/mYGzFeHI/u
 6ow6kM1PvH4goABoQdBRYMsZHgvhj13isdYuKkwmqYfnpup6zktjQFYA2IdpWXyT7EbnSNIo/yT
 El9FGuaYoYe7IOPeoHmBe6sHGu34f0mZEjBw2AATNOJe/I44MGbaXnTx7JhXovsMV6DHSakRVjG
 EEkbU1eg2WOmUh5cRRTQxsXXpRQ5b8plzosmUzUbF/Q==
X-Received: by 2002:a05:6000:2511:b0:48e:2371:3835 with SMTP id
 ffacd0b85a97d-48e3eba89a5mr18946719f8f.51.1793110818949; 
 Tue, 27 Oct 2026 07:20:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4bc5sm23293308f8f.34.2026.10.27.07.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:20:18 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 14:20:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20
X-Gerrit-Change-Number: 2056
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2056?usp=email>
X-Gerrit-Commit: d23f0ecb4215c6667517fc70e3a79ce93c6eaa7c
References: <gerrit.1793110816000.I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTEwODE2MDAwLkkyZjQ5ZjQwZTQ5YWY4NTAzZjVjMDhjNTU3NWZmYzlhOGI0YzlhYTIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <61bd82e30a533f044c695a098320f66e1c85c495-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLi2N-000000000ST-0yf3
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.7]: multi_io: walk
 the link sockets once in multi_io_wait()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4223487434570173162=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4223487434570173162==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T/hA9tf+uao="; charset=UTF-8

--T/hA9tf+uao=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2056?usp=3Demail

to review the following change=2E
=


Change subject: multi_io: walk the link sockets once in multi_io_wait()
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi_io: wal=
k the link sockets once in multi_io_wait()

multi_io_wait() went over the l=
ink sockets twice: first to register
every socket as a listening socket, th=
en, if a UDP socket is configured,
again to arm the UDP ones=2E The UDP soc=
kets were thus registered twice,
and on Windows the first pass created an F=
D_ACCEPT event for them=2E

Walk the sockets once, arming the UDP sockets a=
nd registering only the
TCP ones as listening sockets=2E Drop the mode chec=
k as well, since
multi_io_wait() only runs in server mode=2E

Change-Id: I2=
f49f40e49af8503f5c08c5575ffc9a8b4c9aa20
Signed-off-by: Gianmarco De Gregori=
 <gianmarco@mandelbit=2Ecom>
---
M src/openvpn/multi_io=2Ec
1 file changed,=
 8 insertions(+), 18 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/56/2056/1

diff --git a/src/openvpn/multi_io=
=2Ec b/src/openvpn/multi_io=2Ec
index 8fe4487=2E=2E622a2c5 100644
--- a/src=
/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -195,30 +195,20 @@
=
 int
 multi_io_wait(struct multi_context *m)
 {
-    int status, i;
+    in=
t status;
     unsigned int *persistent =3D &m->multi_io->tun_rwflags;
 
- =
   if (!tuntap_is_dco_win(m->top=2Ec1=2Etuntap))
+    for (int i =3D 0; i <=
 m->top=2Ec1=2Elink_sockets_num; i++)
     {
-        for (i =3D 0; i < m->=
top=2Ec1=2Elink_sockets_num; i++)
+        struct link_socket *sock =3D m->=
top=2Ec2=2Elink_sockets[i];
+
+        if (proto_is_dgram(sock->info=2Eprot=
o))
         {
-            socket_set_listen_persistent(m->top=2Ec2=2Elink=
_sockets[i], m->multi_io->es,
-                                         &m-=
>top=2Ec2=2Elink_sockets[i]->ev_arg);
+            multi_io_process_flags(&=
m->top, m->multi_io->es, sock, p2mp_iow_flags(m, sock));
         }
-    }
=
-
-    if (has_udp_in_local_list(&m->top=2Eoptions))
-    {
-        for (i=
nt i =3D 0; i < m->top=2Ec1=2Elink_sockets_num; i++)
+        else if (!tun=
tap_is_dco_win(m->top=2Ec1=2Etuntap))
         {
-            struct link_s=
ocket *sock =3D m->top=2Ec2=2Elink_sockets[i];
-
-            if ((m->top=
=2Eoptions=2Emode =3D=3D MODE_SERVER) && proto_is_dgram(sock->info=2Eproto)=
)
-            {
-                unsigned int flags =3D p2mp_iow_flags(m, =
sock);
-
-                multi_io_process_flags(&m->top, m->multi_io->es, =
sock, flags);
-            }
+            socket_set_listen_persistent(sock=
, m->multi_io->es, &sock->ev_arg);
         }
     }
 

-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2056?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Ge=
rrit-Branch: release/2=2E7
Gerrit-Change-Id: I2f49f40e49af8503f5c08c5575ffc=
9a8b4c9aa20
Gerrit-Change-Number: 2056
Gerrit-PatchSet: 1
Gerrit-Owner: Gia=
nmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--T/hA9tf+uao=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2056?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">multi_io: walk the link sockets once in multi_io_wait()=
<br><br>multi_io_wait() went over the link sockets twice: first to register=
<br>every socket as a listening socket, then, if a UDP socket is configured=
,<br>again to arm the UDP ones=2E The UDP sockets were thus registered twic=
e,<br>and on Windows the first pass created an FD_ACCEPT event for them=2E<=
br><br>Walk the sockets once, arming the UDP sockets and registering only t=
he<br>TCP ones as listening sockets=2E Drop the mode check as well, since<b=
r>multi_io_wait() only runs in server mode=2E<br><br>Change-Id: I2f49f40e49=
af8503f5c08c5575ffc9a8b4c9aa20<br>Signed-off-by: Gianmarco De Gregori &lt;g=
ianmarco@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/multi_io=2Ec<br>1 file=
 changed, 8 insertions(+), 18 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/2056/1</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><=
br><span>index 8fe4487=2E=2E622a2c5 100644</span><br><span>--- a/src/openvp=
n/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><sp=
an>@@ -195,30 +195,20 @@</span><br><span> int</span><br><span> multi_io_wai=
t(struct multi_context *m)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    int status, i;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int status;</span><br><span>     unsigned int *p=
ersistent =3D &amp;m-&gt;multi_io-&gt;tun_rwflags;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tuntap_is_dco_win(m=
-&gt;top=2Ec1=2Etuntap))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    for (int i =3D 0; i &lt; m-&gt;top=2Ec1=2Elink_sockets_num; i++)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        for (i =3D 0; i &lt; m-&gt;top=2Ec1=2Elink_sockets_num; i++)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct link_socket=
 *sock =3D m-&gt;top=2Ec2=2Elink_sockets[i];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (proto_is_dgram(sock-&gt;info=2Eproto))</span><br><span>  =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            s=
ocket_set_listen_persistent(m-&gt;top=2Ec2=2Elink_sockets[i], m-&gt;multi_i=
o-&gt;es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                             &amp;m-&gt;top=2Ec2=2Elink_sockets[i]-&gt;ev_a=
rg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mul=
ti_io_process_flags(&amp;m-&gt;top, m-&gt;multi_io-&gt;es, sock, p2mp_iow_f=
lags(m, sock));</span><br><span>         }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (has_udp_=
in_local_list(&amp;m-&gt;top=2Eoptions))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        for (int i =3D 0; i &lt; m-&gt;top=2Ec1=2Elink_sockets_num; i++)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (!t=
untap_is_dco_win(m-&gt;top=2Ec1=2Etuntap))</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct link_soc=
ket *sock =3D m-&gt;top=2Ec2=2Elink_sockets[i];</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            if ((m-&gt;top=2Eoptions=2Emode =3D=3D MODE_SERVER) &amp;&=
amp; proto_is_dgram(sock-&gt;info=2Eproto))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                unsigned int flags =3D p2mp_iow_flags(m, sock=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                multi_io_process_flags(&=
amp;m-&gt;top, m-&gt;multi_io-&gt;es, sock, flags);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            socket_set_listen_persistent(sock, m-=
&gt;multi_io-&gt;es, &amp;sock-&gt;ev_arg);</span><br><span>         }</spa=
n><br><span>     }</span><br></pre><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2056?usp=3Demail">change 2056</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2056?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: r=
elease/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2f49f40=
e49af8503f5c08c5575ffc9a8b4c9aa20 </div>
<div style=3D"display:none"> Gerri=
t-Change-Number: 2056 </div>
<div style=3D"display:none"> Gerrit-PatchSet: =
1 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &l=
t;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--T/hA9tf+uao=--


--===============4223487434570173162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4223487434570173162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4223487434570173162==--

