Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DDB606A329
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZhgIuLUj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=U7sBp/OT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G03Nu4Y9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WQZ6K4WC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=0YnbvPks5o6vcniNIjgTgQi2zscFT8pPK167aABrm6A=; b=ZhgIuLUjSEVNB6GiOAOOJomiyd
	i2eYVpZuNWT4mVr5AcKLGplyCyvfSZcbpKp9+VYPvAYOBUOutR99ujeNGQL+0q2Z4vPFJvdNmRbYL
	TGB808HC9IQS0xmr+5b0EGVdx4pwP/JyyBfmtQB0N93jPiHeyd/S+nezgJETXD/A3eyY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT3Oo-000000004kH-2keI;
	Mon, 16 Nov 2026 20:33:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT3OY-000000004jx-0xa1
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 20:33:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ktIABkGQPX8hBWn76VNxykXeuu0cn1U5+dJnK5pdCCo=; b=U7sBp/OTRjasBI/lSiSp9abu4n
 Zz7VLPLtdBdoS5VLp1mNOr6tV7YNKHK1ZKaTpnwSJQnxu3gUa/t1Ja7iHL6O2uG4dfLzttIrvtClM
 HhkIOJd88XYWw9i3zvGAc0umJWzGY1qS3c0Q+f3Cze5nk9Ir7b0j3Jr3OmiPOBYLn744=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ktIABkGQPX8hBWn76VNxykXeuu0cn1U5+dJnK5pdCCo=; b=G03Nu4Y92N5Mlz7ZMtqcIuqRzY
 FmFj/O0thfudxZdj+l0kG/GrNWCEC0Y8HrrawVHByp2O+FKw5htAQmV6iX7gLKdgqmKoPRxQ+hIok
 6vySH3eABGjdgpU+6EM9KMpjFwx3ljsjRvjrP/mWQyatYfYhOpxkbn6nc20GnwfqTJac=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT3OW-000000000SG-2qUM for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 20:33:42 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bb6886d30aso15824665e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 12:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794861214; x=1795466014; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ktIABkGQPX8hBWn76VNxykXeuu0cn1U5+dJnK5pdCCo=;
 b=WQZ6K4WC4ulT3ltPKX8GEUYp6vShq9ymCiTh1r2AFnLriBqNr/wiX/IMiqwzWtYbMl
 2AV9fCTLUZEBQ1SMpLHoPBSItrwl5Y28flNzpxXyzaFDLzgjOJfmRtfDDpqaUpqby+Hj
 jiImWGdCnURrWKBkucY3xZVHw12d+wMXt8XKNON4I3Ggzs8u90TC2HgQjSggjJHHLYXP
 J+uQXe5OVyRkucazQYBXXD/xfR/lT86PZjcoPtg+McqahwEgi2UlJ+uwbbYbR7SyJ74d
 zxuseLyOBSMjk7/wn1NE35UAUY3jZXCSIkA5EERSBbH9X2Vd7AkG/SwnVbHd5VQegD8c
 Y1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794861214; x=1795466014;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ktIABkGQPX8hBWn76VNxykXeuu0cn1U5+dJnK5pdCCo=;
 b=gub3YgE0o9e4DRoagAzvh6q2zz7pkdlrT+hnhCV+0P6xxAn2Qq2qU1OX16m6Rdy5vI
 qWq95vcbrCj0gecgEYwRYBVSQ9vTna2BGFcQp6+GM/s0qTn7soZ3BpDTZ1UuGuvQXkGR
 aF7PcSV00eaVxqDRwQ6YblkjNoJyMIEPW0MkiVsYmW5i2tSta+/i9K2LEuwIF942XVnR
 WQetuSblVZjUsJoKNwF3JEawdYknDw55bE56WN+9xgIXN06UkDO/+nEV4hxyp4LNdyiT
 5KZWaV71NGNWoRWAnRJsoPlyY7ppS6j6f1xng6uGL0mt3eX/Qls1pWfe9F6ETBcdW7O4
 qRRw==
X-Gm-Message-State: APuU4Z/VN+gC4JPnLBsRGZ/OHPTbuOxf6UzyEAgnqsIYgdHcZDBykfJx
 U0GI+d8Om7xeh4PjnVmBeIPIMrUArNOoPIaa47rUomcHDrfIy5iM39eoxRoZo0ePNR7NnWQTOAR
 CycHEgbQFds81odq/DMpjb+qUofvcXBeIy44tD5d5iq/jidmdS6SrPzqr7yL9bKhNowBpRiyaVW
 QQ5ucC5w==
X-Gm-Gg: AYBFou1juugU3iktHQSwif4X3v2wq4C5NCAit/Hk6km016ncq+R+O9q+x7tFX5NL7Mx
 VhLuMpEZcObkF8ktdiVStlPSz+flAU0SU0C5C9A5CLAgjBOCACPObveHjjBVl4oIIeUZqTAXI3O
 r0CSGsZabTbQtFzqsULbcBVvF1tyaOOp3McZsNHr9jYkAPPZIQE0cV5dUevP1D9IxMuYXQWg9bY
 qZFso/y4xyO0ujHXCSkv/uXAOXeUBC7kg5QM8z0Zk3wTZzwXFWkCAYZsyQi5kobwsB/sdKatWpN
 PEJ9eRne3FYkhIF39FRH47p/WEoF3fo5/kjDk3aWDWv6zVIkz4pxsiyKxFpmcJVZ97I1NjwxGNi
 F/+rXdFTRuXaH8LzMrNgYjZ00JfYDbOra21dHVWfzuhmtQCvhYKOJ4j3iBDe3qa48CCnum0Jgud
 jSnwqHssfNHxt3bql8G1fuTCw1TCltcHjWVQZDlqp3ikRMHIV3uRMnAAhy4apwP1oZ5OTmHbomI
 Lu0vsi2d88Bppgp2zGiGqrG12+fNFSUP0+pME7gdJw22LvaQI6D8dljH+gkb6AVAVst8HhyEgVX
 KyPgfTUTnckzUdPlQKWcd/CQQXwkPRs8Xz66MsMAWT/Ukcgyq2wA+cjniMHNmmVwsC/ARshDWj9
 J3LOuk4eLR8FpCraLKvJl1149DWalelQgNLdznLpwJSgj367sjSkGslptbGnXDoj8Le2gQebVdd
 jEIR5tZZodxTx+S4g=
X-Received: by 2002:a05:600c:800e:b0:4bb:6fd3:5ac0 with SMTP id
 5b1f17b1804b1-4bb6fd35c5cmr102889375e9.28.1794861213915; 
 Mon, 16 Nov 2026 12:33:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571f976esm167354895e9.3.2026.11.16.12.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:33:33 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 20:33:33 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2088345f10a630241fbddde68336ea7c1f7b449d
X-Gerrit-Change-Number: 2204
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2204?usp=email>
X-Gerrit-Commit: fe644a439bcc2f81b94365444a6b5ccca68879b3
References: <gerrit.1794861212000.I2088345f10a630241fbddde68336ea7c1f7b449d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODYxMjEyMDAwLkkyMDg4MzQ1ZjEwYTYzMDI0MWZiZGRkZTY4MzM2ZWE3YzFmN2I0NDlkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e4213e61c98536c140be57c072be4f54c716b26e-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT3OW-000000000SG-2qUM
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: don't access
 tls_multi in dco_get_peer_stats() during a restart
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7183977653775303943=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7183977653775303943==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A7qw3GFNbTo="; charset=UTF-8

--A7qw3GFNbTo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2204?usp=3Demail

to review the following change=2E
=


Change subject: dco: don't access tls_multi in dco_get_peer_stats() durin=
g a restart
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

d=
co: don't access tls_multi in dco_get_peer_stats() during a restart

On a r=
estart init_instance() registers the management callbacks before
the restar=
t pause, while c2=2Etls_multi is still NULL: close_instance()
freed it and =
do_init_crypto_tls() has not created the new one yet=2E
A management "statu=
s" command during the pause therefore calls
dco_get_peer_stats() without a =
tls_multi=2E

With --persist-tun the DCO interface survives the restart, so=
 the Linux
and Windows implementations get past their interface checks and
=
dereference the NULL tls_multi; FreeBSD hits ASSERT(c->c2=2Etls_multi)
even=
 without --persist-tun=2E Either way openvpn dies=2E

Return an error when =
there is no tls_multi, as when there is no DCO
interface=2E

Reproduced on =
Linux with a DCO client using --persist-tun:

  (echo 'signal SIGUSR1'; sle=
ep 0=2E5; echo status; sleep 3) | nc 127=2E0=2E0=2E1 7505

segfaults in dco=
_get_peer_stats() during the restart pause=2E

Gerrit change 2201 makes pri=
nt_status() answer even when
dco_get_peer_stats() fails; together with this=
 change, "status" gets
a reply during a reconnect instead of hanging or cra=
shing=2E

Related: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2201
Change-I=
d: I2088345f10a630241fbddde68336ea7c1f7b449d
Signed-off-by: Antonio Quartul=
li <antonio@mandelbit=2Ecom>
---
M src/openvpn/dco_freebsd=2Ec
M src/openvp=
n/dco_linux=2Ec
M src/openvpn/dco_win=2Ec
3 files changed, 9 insertions(+),=
 3 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/04/2204/1

diff --git a/src/openvpn/dco_freebsd=2Ec b/src/openvp=
n/dco_freebsd=2Ec
index 11b8dff=2E=2E6701d21 100644
--- a/src/openvpn/dco_f=
reebsd=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -916,7 +916,11 @@
 int
 dco=
_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
-   =
 ASSERT(c->c2=2Etls_multi);
+    /* tls_multi is NULL during a restart */
+=
    if (!c->c2=2Etls_multi)
+    {
+        return -EINVAL;
+    }
     msg=
(D_DCO_DEBUG, "%s: peer-id %d", __func__, c->c2=2Etls_multi->dco_peer_id);
=
 
     if (c->c2=2Etls_multi->dco_peer_id < 0)
diff --git a/src/openvpn/dco=
_linux=2Ec b/src/openvpn/dco_linux=2Ec
index 3a55b6e=2E=2Ebefad61 100644
--=
- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -1280,7 +1=
280,8 @@
 int
 dco_get_peer_stats(struct context *c, const bool raise_sigus=
r1_on_err)
 {
-    if (!c->c1=2Etuntap || c->c1=2Etuntap->dco=2Eifindex =3D=
=3D 0)
+    /* tls_multi is NULL during a restart, while a persisted tun is=
 still around */
+    if (!c->c1=2Etuntap || c->c1=2Etuntap->dco=2Eifindex =
=3D=3D 0 || !c->c2=2Etls_multi)
     {
         return -1;
     }
diff --gi=
t a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index a854045=2E=2Eef=
f4d33 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@=
 -898,7 +898,8 @@
 {
     const struct tuntap *tt =3D c->c1=2Etuntap;
 
-  =
  if (!tuntap_defined(tt))
+    /* tls_multi is NULL during a restart, whil=
e a persisted tun is still around */
+    if (!tuntap_defined(tt) || !c->c2=
=2Etls_multi)
     {
         return -1;
     }

-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2204?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I2088345f10a630241fbddde68336ea7c1f7b449d
Ge=
rrit-Change-Number: 2204
Gerrit-PatchSet: 1
Gerrit-Owner: Antonio Quartulli=
 <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--A7qw3GFNbTo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2204?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">dco: don&#39;t access tls_multi in dco_get_peer_stats() du=
ring a restart<br><br>On a restart init_instance() registers the management=
 callbacks before<br>the restart pause, while c2=2Etls_multi is still NULL:=
 close_instance()<br>freed it and do_init_crypto_tls() has not created the =
new one yet=2E<br>A management &quot;status&quot; command during the pause =
therefore calls<br>dco_get_peer_stats() without a tls_multi=2E<br><br>With =
--persist-tun the DCO interface survives the restart, so the Linux<br>and W=
indows implementations get past their interface checks and<br>dereference t=
he NULL tls_multi; FreeBSD hits ASSERT(c-&gt;c2=2Etls_multi)<br>even withou=
t --persist-tun=2E Either way openvpn dies=2E<br><br>Return an error when t=
here is no tls_multi, as when there is no DCO<br>interface=2E<br><br>Reprod=
uced on Linux with a DCO client using --persist-tun:<br><br>  (echo &#39;si=
gnal SIGUSR1&#39;; sleep 0=2E5; echo status; sleep 3) | nc 127=2E0=2E0=2E1 =
7505<br><br>segfaults in dco_get_peer_stats() during the restart pause=2E<b=
r><br>Gerrit change 2201 makes print_status() answer even when<br>dco_get_p=
eer_stats() fails; together with this change, &quot;status&quot; gets<br>a =
reply during a reconnect instead of hanging or crashing=2E<br><br>Related: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2201<br>Change-Id: I2088345f10a6=
30241fbddde68336ea7c1f7b449d<br>Signed-off-by: Antonio Quartulli &lt;antoni=
o@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/dco_freebsd=2Ec<br>M src/open=
vpn/dco_linux=2Ec<br>M src/openvpn/dco_win=2Ec<br>3 files changed, 9 insert=
ions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/04/2204/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec</span><br><span>inde=
x 11b8dff=2E=2E6701d21 100644</span><br><span>--- a/src/openvpn/dco_freebsd=
=2Ec</span><br><span>+++ b/src/openvpn/dco_freebsd=2Ec</span><br><span>@@ -=
916,7 +916,11 @@</span><br><span> int</span><br><span> dco_get_peer_stats(s=
truct context *c, const bool raise_sigusr1_on_err)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(c-&gt;c2=2Etls_m=
ulti);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* tls_mu=
lti is NULL during a restart */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!c-&gt;c2=2Etls_multi)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return -EINVAL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: peer-id =
%d&quot;, __func__, c-&gt;c2=2Etls_multi-&gt;dco_peer_id);</span><br><span>=
 </span><br><span>     if (c-&gt;c2=2Etls_multi-&gt;dco_peer_id &lt; 0)</sp=
an><br><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=
=2Ec</span><br><span>index 3a55b6e=2E=2Ebefad61 100644</span><br><span>--- =
a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec=
</span><br><span>@@ -1280,7 +1280,8 @@</span><br><span> int</span><br><span=
> dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (!c-&gt;c1=2Etuntap || c-&gt;c1=2Etuntap-&gt;dco=2Eifindex =3D=3D 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* tls_multi is NULL=
 during a restart, while a persisted tun is still around */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!c-&gt;c1=2Etuntap || c-&gt=
;c1=2Etuntap-&gt;dco=2Eifindex =3D=3D 0 || !c-&gt;c2=2Etls_multi)</span><br=
><span>     {</span><br><span>         return -1;</span><br><span>     }</s=
pan><br><span>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2E=
c</span><br><span>index a854045=2E=2Eeff4d33 100644</span><br><span>--- a/s=
rc/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</span>=
<br><span>@@ -898,7 +898,8 @@</span><br><span> {</span><br><span>     const=
 struct tuntap *tt =3D c-&gt;c1=2Etuntap;</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (!tuntap_defined(tt))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* tls_multi is NULL dur=
ing a restart, while a persisted tun is still around */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!tuntap_defined(tt) || !c-&gt;c=
2=2Etls_multi)</span><br><span>     {</span><br><span>         return -1;</=
span><br><span>     }</span><br></pre><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2204?usp=3Demail">change 2204</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2204?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2088345f10a=
630241fbddde68336ea7c1f7b449d </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2204 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Antonio Quartulli &lt;anton=
io@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--A7qw3GFNbTo=--


--===============7183977653775303943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7183977653775303943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7183977653775303943==--

