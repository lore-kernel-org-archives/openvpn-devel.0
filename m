Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1F606A31E
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BQfoDBCR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CY7quxzX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GLCltcMa;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UmIDHl6g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yPjCn21iKo9BQDJ7w5YpdibzJcxOgYwOrXkcss1mj08=; b=BQfoDBCRfYMHqHXEuaYR+Vb00u
	ti60O/ggwEN79yff03Ooii4CLNsly14u8DHklLB7S4yV6yswZTA9T5HYlhrDzMnpoCyUUC6GUXHSa
	jHwOOG5s8DZw+VVHnjYnxYtC+UVIJkfjxBxxLJH2hhqolnz63ToFbJ+Z+Id/2zODjWmo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xScDu-0000000019b-1ko3;
	Sun, 15 Nov 2026 15:32:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xScDt-0000000019T-02Ya
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 15:32:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=obw8yhaFEj1XAfxcAkvR81OjUB+lyyneBERtwaswg2g=; b=CY7quxzXeunKz+IqvTITBIz9Ds
 Sem8Vwf2Z+3lWyburTmKuXNoB+XgdTLg8Yjgmf5wpJe7D0gmcWQnJdIvIU1EzykE5SJiE0eVhcYHA
 dmyI6b9FT1iFjDI6RK2U6rNhyLAJnwMviVbfYpEuldoxVDlSERL4VhkJTRQ+hjxKsI1Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=obw8yhaFEj1XAfxcAkvR81OjUB+lyyneBERtwaswg2g=; b=GLCltcMau2MMvEw61J5SrjUrij
 bPTMt3dN8YbLJVoH72uD5ZLxfzGLYyIkEeVaOlFPFmCJXFd1YFbh8tsHj3kCYXzYD2HjfszwL1kb8
 R33KK4j9dvgPImM9iWGWv9sL6XmqQYAu20X5CnBhfXqQfGFMfxVlA1ZZpuU2Q3IQjqnY=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xScDr-000000003Ap-3lBN for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 15:32:52 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so285145e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 07:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794756764; x=1795361564; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=obw8yhaFEj1XAfxcAkvR81OjUB+lyyneBERtwaswg2g=;
 b=UmIDHl6gqm9yyla91UsWZncOSte3irW7LLsvoGyhz8Xcrbu71K8kNcOQ6+2N9qkUGn
 v1WiWf1z1DFvEHDn089ld0JV3lTw8V0Ng1Ai77V4gg9JU74GLGAPrp6j4nJSF1MRp4dp
 n688f4O5z0rVnFT4eyGMw7zJNpyYTEStavCniIQ88+NBX3IYFg751pRLA6Vx1gNWSIxP
 dFuQMs2sH5+3UQPdlcfLvbru7cdgy46o9xD1ByrmlMZjf4aWrRuGP86yB2YkTq9oH9dc
 E1AH/Y86MN2jE4dVTGyad1gClNE1WsUND8LECudZjXQA8fVilfhwA+/ApLnbOUc0msMQ
 tX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794756764; x=1795361564;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=obw8yhaFEj1XAfxcAkvR81OjUB+lyyneBERtwaswg2g=;
 b=rPMAfcCn1XyuuIdqqddCrV9k5XkJ8qxw8z0wHpGCbouK/07d5njvgwkdUJkVRMbqw1
 aLO0cF+iPvMSWDhJ6Gwce4suRqzPW7F1dgQbBomaTEc3KmL1ZOjZmuPxd6Zr09RivsWs
 fGv2h/YUAklTjSag6IA82rZ0mGGfcRQPND5QJBJ0kubbM2RT1A0VbI1P0YZ7mVb+OrqH
 OXeHJHeuqHAagPc/mX1BltTs1hhZCLThiBV8UPWDBJx8qtaGDV4mUI6onNyT1oz6v1sF
 0JxYz7l4Hfx2arQ7Ndsfd/YHGFp0HxuiAWKwODhKnDS5FkctEM7tm0BBSlpqfEV0oLUq
 ONPg==
X-Gm-Message-State: APuU4Z/3/RjvpJ2Z56+b+ccqQ6qVoXwYLZ/IZKoDuQzy5U1KDz3XkIK4
 omJiOnrbzYgwm426lyy3gfoxMjpCG1//1EOEUvvkevKiToa/71RDadpnn6wHGTiLiMEyCuhK4EQ
 AY17rnV+34xjFi7bjYjGBWq2zOcNL7uJrCtdvsSWChZXjjVEckS/DW6eantqrhQjmH5Zk
X-Gm-Gg: AYBFou3RAATI+HLMtU+Ixrt2AvKXeYaCSiwlfmmfMAKhNSeUhmR3S6G8GpXpJHahP2Z
 3eV989PDxHSbQmvdB+k53CTEpKkTYZADc+zI1Dm8nsW/18vUyAh//fVfYXN0GqlyOCBjVTIk9ZY
 vMHaBZGVHMqYc1rSUnMRAu5ZV44jHGGHuoLI1HNd+t08YpIBlAEA4Q+FZlL+7tbkQmgsYNUou/x
 6xBTBpK0NnL7hYOXQGDQ/gfPpgqvFZs7l922aZJI4UtS8uJ31n9UpZo84lVSALVcVgjGd9W6dDU
 scHc7WZU/kr8T3RLbpCszzOCZs7OuESVtGCtDwHerv0EM0kcmyJwBijkVCNMAtGh+JX0Tm5zfRC
 uVyTDgzQUZRvbyV/yQ0MGb30UK5zXSYXKGRDh4SCnTcKV/+tv+KiopEWGEpc0ZKokIE2VZZ4ebL
 Vyk1a5lQxAi6xHmiNv/HfBqZX0xUVwfvBzX7g8lJ5fYa8TYYn2eU0x+roObbDZVyb3nqtH3Pd7/
 gPX/PNpCcl1UvEDDYnB9HyuYjZt7ULmc3ZdHCZHMoEv54hodDv22jmakZJ7ioeIU3gz0vPHhlAg
 qIMD/lr3444dLVLZkwSb4yLmFX/LnJj4DTNPsdr1xjh3ys/4dfNW2w9iIXsM7/Ep2zkUkYbVzcX
 odd1iXYMIeLO5hHhoIvfjEvrd+oieuq/NxegYp8nfCxV6X9YY7Kgveov7/yhejC4Zf80gqeMq6M
 QC/Y1TQl8ox5tG4A4=
X-Received: by 2002:a05:600c:4f93:b0:49f:fd2d:23c7 with SMTP id
 5b1f17b1804b1-4bb55ab36famr177410175e9.27.1794756763411; 
 Sun, 15 Nov 2026 07:32:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e29daa5sm327865425e9.12.2026.11.15.07.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 07:32:42 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 15:32:41 +0000
To: Hansaem Wi <hansaemw@gmail.com>, Steffan Karger <steffan@karger.me>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8e02b4cf39cc431f1f2c058db95997c8907557c0
X-Gerrit-Change-Number: 2079
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2079?usp=email>
X-Gerrit-Commit: 583f6fdc22c9b4ca9521b401210afb83cf8978aa
In-Reply-To: <gerrit.1793594388000.I8e02b4cf39cc431f1f2c058db95997c8907557c0@gerrit.openvpn.net>
References: <gerrit.1793594388000.I8e02b4cf39cc431f1f2c058db95997c8907557c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNTk0Mzg4MDAwLkk4ZTAyYjRjZjM5Y2M0MzFmMWYyYzA1OGRiOTU5OTdjODkwNzU1N2MwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f5611a1840ee3c91aa33acc15856e758fc28dfd8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xScDr-000000003Ap-3lBN
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tls_crypt: Wipe the
 tls-crypt-v2 client key copies
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, hansaemw@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8661001762164640750=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8661001762164640750==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Py0zgWz6Fyc="; charset=UTF-8

--Py0zgWz6Fyc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Hansaem Wi=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2079?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by Steffan Karger


Change subject: tls_crypt: Wipe the tls-crypt-v2 =
client key copies
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

tls_crypt: Wipe the tls-crypt-v2 client key copies

tls_crypt_v2_init_=
client_key() reads the client key into a struct key2
on the stack, copies i=
t to *original_key and returns without clearing
it, so every client start l=
eaves the tls-crypt-v2 client key on the
stack=2E crypto_read_openvpn_key()=
 does the same copy for tls-auth and
tls-crypt keys and clears its struct k=
ey2 afterwards; do the same here=2E

The --genkey tls-crypt-v2-client sanit=
y check in
tls_crypt_v2_write_client_key_file() has two more copies:
- keyd=
ata, the struct key2 that tls_crypt_v2_init_client_key() fills;
  clear it =
after use=2E
- check_wrapped_client_key, the decoded key file buffer: the c=
lient key
  is still in front of the wrapped key when it is freed=2E Clear =
it with
  buf_clear() before free_buf(), as do_close_free_key_schedule() do=
es
  for the client's tls_crypt_v2_wkc=2E

Assisted-by: Claude Code:claude-=
opus-5-5
Change-Id: I8e02b4cf39cc431f1f2c058db95997c8907557c0
Signed-off-by=
: Hansaem Wi <hansaemw@gmail=2Ecom>
Acked-by: Steffan Karger <steffan@karge=
r=2Eme>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2079
Message=
-Id: <20261102101437=2E1209-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Em=
ail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40954=2Ehtml
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/tls_=
crypt=2Ec
1 file changed, 3 insertions(+), 0 deletions(-)


  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/79/2079/2

diff --git a=
/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 64db29f=2E=2Ed=
7f69f7 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=
=2Ec
@@ -332,6 +332,7 @@
 
     tls_crypt_v2_load_client_key(key, &key2, fa=
lse);
     *original_key =3D key2;
+    secure_memzero(&key2, sizeof(key2))=
;
 
     *wkc_buf =3D client_key;
 }
@@ -794,6 +795,7 @@
     tls_crypt_v2_=
init_client_key(&check_client_key, &keydata, &check_wrapped_client_key, cli=
ent_file,
                                  client_inline);
     free_key_c=
tx_bi(&check_client_key);
+    secure_memzero(&keydata, sizeof(keydata));
 =

     /* Sanity check: unwrap and load client key (as "server") */
     str=
uct buffer check_metadata =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &=
gc);
@@ -804,6 +806,7 @@
     ASSERT(tls_crypt_v2_unwrap_client_key(&check_=
client_key2, &check_metadata,
                                           ch=
eck_wrapped_client_key, &server_key));
     secure_memzero(&check_client_ke=
y2, sizeof(check_client_key2));
+    buf_clear(&check_wrapped_client_key);
=
     free_buf(&check_wrapped_client_key);
 
 cleanup:

-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2079?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I8e02b4cf39cc431f1f2c058db95997c8907=
557c0
Gerrit-Change-Number: 2079
Gerrit-PatchSet: 2
Gerrit-Owner: Hansaem W=
i <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--Py0zgWz6Fyc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Hans=
aem Wi=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2079?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by Steffan Karger</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">tls_crypt: =
Wipe the tls-crypt-v2 client key copies<br><br>tls_crypt_v2_init_client_key=
() reads the client key into a struct key2<br>on the stack, copies it to *o=
riginal_key and returns without clearing<br>it, so every client start leave=
s the tls-crypt-v2 client key on the<br>stack=2E crypto_read_openvpn_key() =
does the same copy for tls-auth and<br>tls-crypt keys and clears its struct=
 key2 afterwards; do the same here=2E<br><br>The --genkey tls-crypt-v2-clie=
nt sanity check in<br>tls_crypt_v2_write_client_key_file() has two more cop=
ies:<br>- keydata, the struct key2 that tls_crypt_v2_init_client_key() fill=
s;<br>  clear it after use=2E<br>- check_wrapped_client_key, the decoded ke=
y file buffer: the client key<br>  is still in front of the wrapped key whe=
n it is freed=2E Clear it with<br>  buf_clear() before free_buf(), as do_cl=
ose_free_key_schedule() does<br>  for the client&#39;s tls_crypt_v2_wkc=2E<=
br><br>Assisted-by: Claude Code:claude-opus-5-5<br>Change-Id: I8e02b4cf39cc=
431f1f2c058db95997c8907557c0<br>Signed-off-by: Hansaem Wi &lt;hansaemw@gmai=
l=2Ecom&gt;<br>Acked-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>Gerr=
it URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2079<br>Message-Id: &lt;=
20261102101437=2E1209-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Em=
ail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40954=2Ehtml<b=
r>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M s=
rc/openvpn/tls_crypt=2Ec<br>1 file changed, 3 insertions(+), 0 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/79/2079/2</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/tls_crypt=2Ec =
b/src/openvpn/tls_crypt=2Ec</span><br><span>index 64db29f=2E=2Ed7f69f7 1006=
44</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</span><br><span>+++ b/sr=
c/openvpn/tls_crypt=2Ec</span><br><span>@@ -332,6 +332,7 @@</span><br><span=
> </span><br><span>     tls_crypt_v2_load_client_key(key, &amp;key2, false)=
;</span><br><span>     *original_key =3D key2;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    secure_memzero(&amp;key2, sizeof(key2));</sp=
an><br><span> </span><br><span>     *wkc_buf =3D client_key;</span><br><spa=
n> }</span><br><span>@@ -794,6 +795,7 @@</span><br><span>     tls_crypt_v2_=
init_client_key(&amp;check_client_key, &amp;keydata, &amp;check_wrapped_cli=
ent_key, client_file,</span><br><span>                                  cli=
ent_inline);</span><br><span>     free_key_ctx_bi(&amp;check_client_key);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(&a=
mp;keydata, sizeof(keydata));</span><br><span> </span><br><span>     /* San=
ity check: unwrap and load client key (as &quot;server&quot;) */</span><br>=
<span>     struct buffer check_metadata =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_M=
ETADATA_LEN, &amp;gc);</span><br><span>@@ -804,6 +806,7 @@</span><br><span>=
     ASSERT(tls_crypt_v2_unwrap_client_key(&amp;check_client_key2, &amp;che=
ck_metadata,</span><br><span>                                           che=
ck_wrapped_client_key, &amp;server_key));</span><br><span>     secure_memze=
ro(&amp;check_client_key2, sizeof(check_client_key2));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    buf_clear(&amp;check_wrapped_client_=
key);</span><br><span>     free_buf(&amp;check_wrapped_client_key);</span><=
br><span> </span><br><span> cleanup:</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2079?usp=3Demail">change =
2079</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2079?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I8e02b4cf39cc431f1f2c058db95997c8907557c0 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2079 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Hansaem =
Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--Py0zgWz6Fyc=--


--===============8661001762164640750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8661001762164640750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8661001762164640750==--

