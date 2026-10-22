Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC83606A31D
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W2Km/oBt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OZ09aEX+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hC/pLDKL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FSRQJTZO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DX3EP9zyChAEiyDzGuRySOTuNk5WQL7yIMSHZSiqlRE=; b=W2Km/oBt/1rPn3iR1X7qbhuDrY
	hkhkzcQn33VMM9TKSsKIQjwWI6OJXxPOemu2BMKlnwUSnYmXIsyIru3wjlEfr15MygPGhTcIV+Xld
	K8hM4Cqpz4YhxYBFVnpI8u5uULVQOU2aDdjGvkecwyquqiK1E+r7oHgMAAoRuqORuTGk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJzZd-000000007xo-22Um;
	Thu, 22 Oct 2026 20:39:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xJzZb-000000007xg-1qGY
 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 20:39:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y391bvHieDmahDKaLFC812ECCpmPXKx5dVvZD1P17fo=; b=OZ09aEX+unF9iqavID+5JMxIiq
 bTaJhqvtD7XhEBQG0sK1OUWYpmtc5dBE1/+d8HEodlWDVd3hEIaN4eVtTSlr2FiZt8bt5Fbh/Tdme
 D2Ofzrew5W8VIlZiwwEyv3pVFvhHp2xz5ceL64Sp+Ap6kYEs8Qotm4VzcSjAVl6Py4zY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y391bvHieDmahDKaLFC812ECCpmPXKx5dVvZD1P17fo=; b=hC/pLDKLdqpOokPpjCJv24U8UD
 uTBPQgt3a+JrcQ1TjrvaioUL4RjciE8+l4FBhDHLN5duvGgBr5agKaD5sKShIFhfGZ0yqD5vW6cV2
 j7XARGGLOoSvQCAv/chANcMTh8720DOJBJ2c/Xjf5Ei+/RR1LAT07MRPKebUAn2gNOyI=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJzZZ-000000003bn-3U1u for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 20:39:39 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso114701f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792701571; x=1793306371; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y391bvHieDmahDKaLFC812ECCpmPXKx5dVvZD1P17fo=;
 b=FSRQJTZOtyNoKFKqOmxOsrmmGA6PiuXDjeC03KCqdCrj5gYDdLZlJo5NPbuvoRSTVo
 v7tue7VdNQwYrem/y2ZuPFwCl2uYlavvBmzwKh8w+ybLf4j8SITHLeaBxgAqu5FbeI4o
 yq46KUceDghyMLkwNzQ6BTKW2UkJIdPq8NPY03LbpwDwQ4Z/TmWUyVwJpbyUzloIcO9a
 1im86h52EO75ju+Jq2KRZKbsfwVUaLMqXdFEYsf40vuRvZTPV81HOPj5fsTZNgkPW9aL
 xSMIOtMVeN4tEoHLEqIKu4ma2NT1gG7O5sK3Y3mZKzRWKrNFimtTNEbEgK/4lnq6xe53
 UNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792701571; x=1793306371;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y391bvHieDmahDKaLFC812ECCpmPXKx5dVvZD1P17fo=;
 b=ankb95sx9SSTSHVBVGCX8emidruTRt9aATHvk98BvoF1nZiRZBL7zZQnpkj7HF94kU
 tPlcE4g4FCq1HxJY5mt50GlhoZ/Eu1YFN/YRUeHXdMGAuljbv/0VxCovHMxAVRpOtz3h
 iAPn6UG1H/Ayik1G6+Rsangyi+yx4cGYogJ8rt/J/dKiNearbnCvNLhEkdoA9oMAKpcV
 8pPxcC+bHLxMOSwZELLU2ufifZLjwhJfMI3gwcTbViBrkhNmW6wAuGbyN0UzEf06JH3Y
 qLtNrIm3Uc6SHzx1ta/dCAYB9OFVR6shcJbTACqLV8LwDz5yYWr47xW2kIoB/wRm516o
 PsZg==
X-Gm-Message-State: AFq9FYKCRPWw1WK19WUYDRyxbgC+9EAPP3r7s3Hlurs+E8jQ9GUJYFpt
 knmqLRAV2bku+Ku4RVaObm9e3nH+AwGEYLwV34PcMLWfp5FZI2DadMTdgdjqROr/EnsbaY7yp4A
 fa1eJ/7Ntf4HtVDLqB0Q5Yn672fmKY+6Bz+qI1F04zB1vvay0BieWKhSecTJRCaVVj0X7
X-Gm-Gg: AYBFou2fyyNUll1IJg63UKicRJfLLsunAIvoi+6rplyjCn5pAUFZpWnVdg67VTsyqnW
 vkvkkwv6odV5OoGIm3gbiVV6MGiGAEd4EkmaV/X/n7q37MO6Hk3w3SmjxJ16jGrrXjshNIviRFk
 Rbg5g2hzf2EMj6esgoo2gN6/g8AA+nE+MP3Uyth42X+GoNrkq+qpbhuBwYKNXLgEpGzHUk6r1o9
 3XlONBCb3JQRLEXzLLZu8Fi3KhN54y+lroedsSXE9ru0YYDyqmSQ20mi/vK7ZTTQaLWq8jjK058
 aGWRFRti+M0RSSm5pbRNV3dc/iaIrYhFlLk7rUt6kLCnfaY3z6Ql5vYSuM/KMM9Es3CcNKW8uVR
 Aapv8l83UF7nlyq7Dga1E7z4Fb9hQ+2Bv+092cP8kNzpyyovK+ekjOZmzlG5M1YFXFXLYZD8xFg
 14JOxh9Iwl26yU8eLALKjXT2JHhVRQgaljXGIVFwKO744HWh1Yf29RER2pLiy5CB3aiRKYUKGno
 UENXp5BPlE7koaTKHZPFIRTUxhWfGMrkb4ssljH8yGDThNRHLnbSOCKu8l+1udRULuMIuc5lpGb
 CC9NoYthC/0Au06ZVof45ov6d4Jb2V+iymFHMXAFxaHZHBXd59pC3rPJHDgopKsjFgKhWBj7U/3
 +hQQJtCbu5Sl+Jv2ja9QP0Iyvm0LbXmlGgHwBNBfl31D0gRBg+bDzkh+nEBFZouk=
X-Received: by 2002:a05:6000:481b:b0:48e:476:99fb with SMTP id
 ffacd0b85a97d-48e38593a1cmr20365f8f.22.1792701571036; 
 Thu, 22 Oct 2026 13:39:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38054172sm316385f8f.40.2026.10.22.13.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 13:39:30 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 22 Oct 2026 20:39:28 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I10326c787cd8149e7617279e45166073d66b9101
X-Gerrit-Change-Number: 1897
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1897?usp=email>
X-Gerrit-Commit: 52abc98d46a5797e6c823005f89399f370380d3c
In-Reply-To: <gerrit.1788477047000.I10326c787cd8149e7617279e45166073d66b9101@gerrit.openvpn.net>
References: <gerrit.1788477047000.I10326c787cd8149e7617279e45166073d66b9101@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDc3MDQ3MDAwLkkxMDMyNmM3ODdjZDgxNDllNzYxNzI3OWU0NTE2NjA3M2Q2NmI5MTAxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <83c8a1c1cfba71f68fdbf1937e9d19444458ac5b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJzZZ-000000003bn-3U1u
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_freebsd: close
 DCO fds when closing the tun device
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2922038865749241904=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2922038865749241904==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sG+Xa9IaiZ0="; charset=UTF-8

--sG+Xa9IaiZ0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1897?usp=3Demail

to look at the new patch set (#2)=2E

The f=
ollowing approvals got outdated and were removed:
Code-Review-1 by R=C4=83z=
van Cojocaru


Change subject: dco_freebsd: close DCO fds when closing the =
tun device
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

d=
co_freebsd: close DCO fds when closing the tun device

On FreeBSD close_tun=
_dco() is never called: its only call site lives in
the Linux close_tun(), =
behind a TARGET_FREEBSD guard that can never be
true there=2E As a result t=
he DCO control socket and notification pipe
leak every time the tun device =
is closed (e=2Eg=2E on restart without
--persist-tun)=2E

Call close_tun_dc=
o() from the FreeBSD close_tun() as well=2E Since that
function already des=
troys the interface via "ifconfig destroy" (and
keeps it when persistent_if=
 is set), reduce close_tun_dco() to closing
the fds and drop the now unused=
 remove_interface()=2E

While at it, remove the dead TARGET_FREEBSD guard f=
rom the Linux
close_tun()=2E

Change-Id: I10326c787cd8149e7617279e45166073d=
66b9101
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M sr=
c/openvpn/dco_freebsd=2Ec
M src/openvpn/tun=2Ec
2 files changed, 6 insertio=
ns(+), 23 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/97/1897/2

diff --git a/src/openvpn/dco_freebsd=2Ec b/src/=
openvpn/dco_freebsd=2Ec
index d933aaf=2E=2E78b8daa 100644
--- a/src/openvpn=
/dco_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -306,26 +306,6 @@
   =
  return 0;
 }
 
-static int
-remove_interface(struct tuntap *tt)
-{
-    i=
nt ret;
-    struct ifreq ifr;
-
-    CLEAR(ifr);
-    snprintf(ifr=2Eifr_n=
ame, IFNAMSIZ, "%s", tt->dco=2Eifname);
-
-    ret =3D ioctl(tt->dco=2Efd, =
SIOCIFDESTROY, &ifr);
-    if (ret)
-    {
-        msg(M_ERR, "Failed to r=
emove interface %s", ifr=2Eifr_name);
-    }
-
-    tt->dco=2Eifname[0] =3D=
 0;
-
-    return ret;
-}
-
 int
 open_tun_dco(struct tuntap *tt, openvpn_n=
et_ctx_t *ctx, const char *dev)
 {
@@ -348,7 +328,7 @@
 void
 close_tun_dco=
(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
-    remove_interface(tt);
+=
    /* the interface itself is destroyed by close_tun() via ifconfig */
   =
  close_fd(&tt->dco);
 }
 
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/t=
un=2Ec
index af48921=2E=2Eb793556 100644
--- a/src/openvpn/tun=2Ec
+++ b/sr=
c/openvpn/tun=2Ec
@@ -2240,12 +2240,10 @@
 {
     ASSERT(tt);
 
-#if define=
d(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (tun_dco_enabled(tt))
  =
   {
         close_tun_dco(tt, ctx);
     }
-#endif
     close_tun_generic=
(tt);
     free(tt);
 }
@@ -2825,6 +2823,11 @@
 {
     ASSERT(tt);
 
+    i=
f (tun_dco_enabled(tt))
+    {
+        close_tun_dco(tt, ctx);
+    }
+
  =
   if (tt->persistent_if) /* keep pre-existing if around */
     {
        =
 close_tun_generic(tt);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1897?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I10326c787cd8149e7617279e45166073d66b9101
Gerrit-Change-Number: 18=
97
Gerrit-PatchSet: 2
Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=2E=
com>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartu=
lli <antonio@mandelbit=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>

--sG+Xa9IaiZ0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, R=C4=83zvan Cojocaru=
=2E </p>
<p>Antonio Quartulli <strong>uploaded patch set #2</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/189=
7?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">dco=
_freebsd: close DCO fds when closing the tun device<br><br>On FreeBSD close=
_tun_dco() is never called: its only call site lives in<br>the Linux close_=
tun(), behind a TARGET_FREEBSD guard that can never be<br>true there=2E As =
a result the DCO control socket and notification pipe<br>leak every time th=
e tun device is closed (e=2Eg=2E on restart without<br>--persist-tun)=2E<br=
><br>Call close_tun_dco() from the FreeBSD close_tun() as well=2E Since tha=
t<br>function already destroys the interface via &quot;ifconfig destroy&quo=
t; (and<br>keeps it when persistent_if is set), reduce close_tun_dco() to c=
losing<br>the fds and drop the now unused remove_interface()=2E<br><br>Whil=
e at it, remove the dead TARGET_FREEBSD guard from the Linux<br>close_tun()=
=2E<br><br>Change-Id: I10326c787cd8149e7617279e45166073d66b9101<br>Signed-o=
ff-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M src/op=
envpn/dco_freebsd=2Ec<br>M src/openvpn/tun=2Ec<br>2 files changed, 6 insert=
ions(+), 23 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/97/1897/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec</span><br><span>i=
ndex d933aaf=2E=2E78b8daa 100644</span><br><span>--- a/src/openvpn/dco_free=
bsd=2Ec</span><br><span>+++ b/src/openvpn/dco_freebsd=2Ec</span><br><span>@=
@ -306,26 +306,6 @@</span><br><span>     return 0;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static in=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-remove_interface(str=
uct tuntap *tt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct ifreq ifr;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    CLEAR(ifr);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    snprintf(ifr=2Eifr_name, IFNAMSIZ, &quot;%s&quot;, tt-&gt;=
dco=2Eifname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ioctl(tt-&gt;dco=
=2Efd, SIOCIFDESTROY, &amp;ifr);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (ret)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_=
ERR, &quot;Failed to remove interface %s&quot;, ifr=2Eifr_name);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    tt-&gt;dco=2Eifname[0] =3D 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><=
br><span> open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const cha=
r *dev)</span><br><span> {</span><br><span>@@ -348,7 +328,7 @@</span><br><s=
pan> void</span><br><span> close_tun_dco(struct tuntap *tt, openvpn_net_ctx=
_t *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    remove_interface(tt);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* the interface itself is destroyed by close_tun() via ifc=
onfig */</span><br><span>     close_fd(&amp;tt-&gt;dco);</span><br><span> }=
</span><br><span> </span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/o=
penvpn/tun=2Ec</span><br><span>index af48921=2E=2Eb793556 100644</span><br>=
<span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</=
span><br><span>@@ -2240,12 +2240,10 @@</span><br><span> {</span><br><span> =
    ASSERT(tt);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br>=
<span>     if (tun_dco_enabled(tt))</span><br><span>     {</span><br><span>=
         close_tun_dco(tt, ctx);</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     close_tun_gen=
eric(tt);</span><br><span>     free(tt);</span><br><span> }</span><br><span=
>@@ -2825,6 +2823,11 @@</span><br><span> {</span><br><span>     ASSERT(tt);=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (tun_dco_enabled(tt))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  close_tun_dco(tt, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>     if (tt-&gt;persistent_if) /* keep pre-existing if around */</=
span><br><span>     {</span><br><span>         close_tun_generic(tt);</span=
><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1897?usp=3Demail">change 1897</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1897?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I10326c787cd8149e7617279e45166073d6=
6b9101 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1897 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Antonio=
 Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--sG+Xa9IaiZ0=--


--===============2922038865749241904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2922038865749241904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2922038865749241904==--

