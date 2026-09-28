Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B504CA5FA2
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xaWyectDsy9jLXkvl3PKUApjx0udVSLwORrbU82BYVw=; b=iYLJKdUxV2IxCdpTUfIRErdI0u
	PmEt09bNy8NZ+1uVBUqROAu9rLPhFDEoyA56Dc0OPFmKrEw5K7NCmWOvDtreWZNxYDl7PurrnCNKa
	lYWTZ+ecAwdovNSPp+eFzqYuvIivIod7iA1umLvEp7zQVD1QH4Dx0n7DflzmEAugDy/E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBAFe-00079Z-5e;
	Mon, 28 Sep 2026 12:14:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBAFc-00079R-CG
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 12:14:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2KJU1v+TH9SN5gZ4s/IUJf6n/T1FliJJt1fDCjK7q/k=; b=Kc1K5oVvTVnHlV/TwM3mJ1yJpo
 UJaKbxz4w0EPKW1ytl8AK+eRAG2JlhMGZohCXrux0kkmiDFAv87doHgXYcAloFTR801BBYTqatv5O
 /5wCqHzYmtkq7dP6KAPmmDKF5O7SxhjtmLO4HTAyTRXvAEr9ILuSRPMjj+fUEFqdyFZU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2KJU1v+TH9SN5gZ4s/IUJf6n/T1FliJJt1fDCjK7q/k=; b=Y
 B64AKSus1gegPIthtb9QssV4PpNS3J8/RFR+6slAjt3cpkK4hkspV3vYgFuHWytmV9kHDR/lemC1x
 M4PbD1vSxGIDByhTq8LW4hu1dTrAL93lPdag0u+GLTyblxApZdckxHQ8p7x/ABnuJm6lf28eIMvJZ
 zwf7i1f6RFyhp8Cg=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBAFY-000194-Bn for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 12:14:29 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7d2bb404so10176135e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 05:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790597662; x=1791202462; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2KJU1v+TH9SN5gZ4s/IUJf6n/T1FliJJt1fDCjK7q/k=;
 b=PSpqnhs3bFPQ5t39JpQoCbtX2osDz6UybaLkBhJ7yscZfNxcJmdJ3M27Ic6OdvVYte
 Xksa/91Hhu2efr997V2gdUdK8V3ukC5c38HwUNqBb4RqvZv/t4VtkZwhN/yQWBZ/9C4P
 BmBVXvtecaDAJSulTtzkKoJj3S3Oeg5/xWU+LwOCS95cfQzOjh3OSnp0bPRUTLLY5uWk
 Mrc5HXDsz1f2ICJCoV+2mQ1T3+y90nqRY+GxuE6iazVkeYzoUGulDtnklZogyuHOpzQY
 DVawzvOPapMud+dJVcfgnqyHShPqpPoM++QRID4s0Ht4cByAJzziIpKO8uOsGrmfxPbN
 6fMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790597662; x=1791202462;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2KJU1v+TH9SN5gZ4s/IUJf6n/T1FliJJt1fDCjK7q/k=;
 b=TRkmzpPwkfVmx5WRfk5YXJFQYunutdod75NaGqRKyc6xBNXrvQyEETV31bz1zTwST+
 t0/+7C/084Y1XJl5IZyV8Gp2/CEHyd5vW0lsqN1C49wSfVfhBzOcBuT4Z+jEPRm5eZ+y
 6EclyvQORex1AfDjZ3s5tTtl0KVBxllkjYQwGaEo2MwjVocGjExHTKXJXsCE6AHo9HSL
 30fnOR7L41iW3UuxK1seW4ElTEz27X40AFnaWyi0aZTPzl5ygrjUE1VPkaMCWqQBgoCb
 r6UJ+mtxS89pRfJKH7L+DwoCzCvRZluO0U5j7PBGi8Fufvx4TMc0g++ahlpuj8ErPUmu
 +/JQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+lfwauaEKhALrVLY+CDmmhBOpw72JOUROA127MrIJsnCOjXgWMSn+6M06xH6TH3QBmqueVaEKdLD7sZ8I@lists.sourceforge.net
X-Gm-Message-State: AFuF++l2w/MUWCB4e9y7iOiv91jyxzgGg+OCBEC7w2yhtxgnnh9P792q
 +/IXjvgeJ6UOaR8IOLcJB4rBHNN6cDSVCpdZAGyP/eKuI8Pd2rTtcVatVp3gfjAs4MQnJ5NMUid
 xkPo5bVjY+OCOfYqYyehNaS1DRX0gCcQMZkmNCxOEHUHUlWzMHcC05w/wPMynzphdXxv6H7uJEK
 QjHLjx6A==
X-Gm-Gg: AYBFou0LVctpmpss5anelGNDg8clATk+pxEQcdBQq6j8AV4XTEiq9oyIe8ZNnomWVrS
 JpA6+GcXSGEafo2OKm6Uq9E4bNBzL7phdpDQb4rHpVlcwqVUoXvFykV855rrFoBY84V9eavXLP5
 v2+vVtgEdBdNQ8sV2wWgIj6XdBN5Jctsev9o6qYNQzFNRz6j0y/EAm8SYy+K95KGqMI8B/z3TP9
 QaYWfpEN5TkDIvDEQDFtI/HhYScbH6HtzH7tGw6i90nxXZGFhbOJfsFWSpakZ4taUdIMBzvIeg8
 dx7CWlAc5MTGiQ0/TfT4jEFHYDKGg/CfcE7rnq57l7hrFUJju14YZQm4CJTkJXb3+yCBO8mbVnn
 9vX8WxgyigWe3QYik8Qp0AfceMphVw39j4+hgchchVgDHKs2c+OiUA4B+AxpS4gT8neJFZC23DK
 0KTteZzM8QEqquVI2zLWFsg1tp/YwF6dTzv+PqWg+g5dRzEMfPvdbUPVkfoVNAVXBfeODgkX6nZ
 XwdYAEUj1g0i6nacUMT2lxRRJLMAbSbdchBfrPZwNIU0Kjr5N1Q9O2GI/xMl+5Z9zo4mzetdxs1
 1GfWkIlVpS+8ZK5FsEdafdiQlqg2NlF93NQff7yzvStZxB2j61kd4n3Np/hHawzYm6JqIs6rwD8
 LvrDUmw==
X-Received: by 2002:a05:600c:4f89:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-49fe66c80c8mr224048105e9.2.1790597661686; 
 Mon, 28 Sep 2026 05:14:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00571744csm69383155e9.13.2026.09.28.05.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 05:14:19 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 12:14:19 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de
X-Gerrit-Change-Number: 1952
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1952?usp=email>
X-Gerrit-Commit: 459fcbb252b9c9781d2807f4d44dbfd758a26afa
In-Reply-To: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
References: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzQ0MzM2MDAwLkljNTM1YmIxZjBkYTE3MzlmODdlOWQ2YmVmNmZkMTA2MTI0N2IwNWRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0a32cfe003b0bd310d9eaaf92cd39dadaa66a718-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBAFY-000194-Bn
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: stop fetching
 peer stats during client disconnect
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5604483675185766224=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5604483675185766224==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HW/dDk7eXKI="; charset=UTF-8

--HW/dDk7eXKI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1952?usp=3Demail )

Change subject: dco: stop fetching peer stats durin=
g client disconnect
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

dco: stop fetching peer stats during client disconnect

The disconn=
ect path asks DCO for a fresh peer dump after the multi
instance has alread=
y been removed from the peer-id lookup table=2E For
kernel-initiated discon=
nects, the peer has also already been deleted by
the time its notification =
is processed=2E The reply therefore cannot
update the disconnecting instanc=
e=2E

Moreover, each disconnect dumps all surviving peers, causing avoidabl=
e
netlink traffic and repeated work when many clients disconnect at once=2E=


During shutdown or restart, fetch a single final peer snapshot before
clo=
sing any instances, while all peers can still be mapped to their
userspace =
contexts=2E

For individual disconnects, use the cached counters directly=
=2E Kernels
that provide a final statistics snapshot in the deletion notifi=
cation
can update them before the disconnect environment is prepared=2E

Ch=
ange-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de
Signed-off-by: Ralf Lici=
 <ralf@mandelbit=2Ecom>
Acked-by: Antonio Quartulli <antonio@mandelbit=2Eco=
m>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1952
Message-Id: <20260926200956=2E24545-1=
-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-dev=
el@lists=2Esourceforge=2Enet/msg39533=2Ehtml
Signed-off-by: Gert Doering <g=
ert@greenie=2Emuc=2Ede>
---
M src/openvpn/multi=2Ec
1 file changed, 13 inse=
rtions(+), 15 deletions(-)




diff --git a/src/openvpn/multi=2Ec b/src/ope=
nvpn/multi=2Ec
index 52364f9=2E=2E9b9cdc3 100644
--- a/src/openvpn/multi=2E=
c
+++ b/src/openvpn/multi=2Ec
@@ -496,37 +496,29 @@
 }
 
 static void
-sete=
nv_stats(struct multi_context *m, struct context *c)
+setenv_stats(struct c=
ontext *c)
 {
-    if (dco_enabled(&m->top=2Eoptions))
-    {
-        if (=
dco_get_peer_stats_multi(&m->top=2Ec1=2Etuntap->dco, false) < 0)
-        {=

-            return;
-        }
-    }
-
     setenv_counter(c->c2=2Ees, "=
bytes_received", c->c2=2Elink_read_bytes + c->c2=2Edco_read_bytes);
     se=
tenv_counter(c->c2=2Ees, "bytes_sent", c->c2=2Elink_write_bytes + c->c2=2Ed=
co_write_bytes);
 }
 
 static void
-multi_client_disconnect_setenv(struct m=
ulti_context *m, struct multi_instance *mi)
+multi_client_disconnect_setenv=
(struct multi_instance *mi)
 {
     /* setenv client real IP address */
   =
  setenv_trusted(mi->context=2Ec2=2Ees, get_link_socket_info(&mi->context))=
;
 
     /* setenv stats */
-    setenv_stats(m, &mi->context);
+    setenv=
_stats(&mi->context);
 
     /* setenv connection duration */
     setenv_l=
ong_long(mi->context=2Ec2=2Ees, "time_duration", now - mi->created);
 }
 
 =
static void
-multi_client_disconnect_script(struct multi_context *m, struct=
 multi_instance *mi)
+multi_client_disconnect_script(struct multi_instance =
*mi)
 {
-    multi_client_disconnect_setenv(m, mi);
+    multi_client_disco=
nnect_setenv(mi);
 
     if (plugin_defined(mi->context=2Eplugins, OPENVPN_=
PLUGIN_CLIENT_DISCONNECT))
     {
@@ -634,7 +626,7 @@
 
     if (mi->contex=
t=2Ec2=2Etls_multi->multi_state >=3D CAS_CONNECT_DONE)
     {
-        mult=
i_client_disconnect_script(m, mi);
+        multi_client_disconnect_script(=
mi);
     }
 
     close_context(&mi->context, SIGTERM, CC_GC_FREE);
@@ -65=
9,6 +651,12 @@
 {
     if (m->hash)
     {
+        /* fetch final stats wh=
ile all peers can still be mapped to their instances */
+        if (dco_en=
abled(&m->top=2Eoptions))
+        {
+            dco_get_peer_stats_multi(=
&m->top=2Ec1=2Etuntap->dco, false);
+        }
+
         for (uint32_t i =
=3D 0; i <=3D m->max_peerid; i++)
         {
             struct multi_inst=
ance *mi =3D m->instances[i];
@@ -2750,7 +2748,7 @@
          * did not fai=
l */
         if (mi->context=2Ec2=2Etls_multi->multi_state =3D=3D CAS_PEND=
ING_DEFERRED_PARTIAL)
         {
-            multi_client_disconnect_scrip=
t(m, mi);
+            multi_client_disconnect_script(mi);
         }
 
   =
      mi->context=2Ec2=2Etls_multi->multi_state =3D CAS_FAILED;

-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061=
247b05de
Gerrit-Change-Number: 1952
Gerrit-PatchSet: 3
Gerrit-Owner: ralf_l=
ici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: ordex <antonio@mandelbit=2Ecom>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: r=
azvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>

--HW/dDk7eXKI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1952?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">dco: stop fetching peer stats during clien=
t disconnect<br><br>The disconnect path asks DCO for a fresh peer dump afte=
r the multi<br>instance has already been removed from the peer-id lookup ta=
ble=2E For<br>kernel-initiated disconnects, the peer has also already been =
deleted by<br>the time its notification is processed=2E The reply therefore=
 cannot<br>update the disconnecting instance=2E<br><br>Moreover, each disco=
nnect dumps all surviving peers, causing avoidable<br>netlink traffic and r=
epeated work when many clients disconnect at once=2E<br><br>During shutdown=
 or restart, fetch a single final peer snapshot before<br>closing any insta=
nces, while all peers can still be mapped to their<br>userspace contexts=2E=
<br><br>For individual disconnects, use the cached counters directly=2E Ker=
nels<br>that provide a final statistics snapshot in the deletion notificati=
on<br>can update them before the disconnect environment is prepared=2E<br><=
br>Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de<br>Signed-off-by: R=
alf Lici &lt;ralf@mandelbit=2Ecom&gt;<br>Acked-by: Antonio Quartulli &lt;an=
tonio@mandelbit=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952<b=
r>Message-Id: &lt;20260926200956=2E24545-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg39533=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 file changed, 13 insertions(+)=
, 15 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src=
/openvpn/multi=2Ec</span><br><span>index 52364f9=2E=2E9b9cdc3 100644</span>=
<br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/mul=
ti=2Ec</span><br><span>@@ -496,37 +496,29 @@</span><br><span> }</span><br><=
span> </span><br><span> static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-setenv_stats(struct multi_context *m, struct context *c)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+setenv_stats(struct cont=
ext *c)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (dco_enabled(&amp;m-&gt;top=2Eoptions))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (dco_get_peer_stats_multi(&amp;m-&gt;top=2Ec1=2E=
tuntap-&gt;dco, false) &lt; 0)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     setenv_coun=
ter(c-&gt;c2=2Ees, &quot;bytes_received&quot;, c-&gt;c2=2Elink_read_bytes +=
 c-&gt;c2=2Edco_read_bytes);</span><br><span>     setenv_counter(c-&gt;c2=
=2Ees, &quot;bytes_sent&quot;, c-&gt;c2=2Elink_write_bytes + c-&gt;c2=2Edco=
_write_bytes);</span><br><span> }</span><br><span> </span><br><span> static=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_client_dis=
connect_setenv(struct multi_context *m, struct multi_instance *mi)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+multi_client_disconnect_sete=
nv(struct multi_instance *mi)</span><br><span> {</span><br><span>     /* se=
tenv client real IP address */</span><br><span>     setenv_trusted(mi-&gt;c=
ontext=2Ec2=2Ees, get_link_socket_info(&amp;mi-&gt;context));</span><br><sp=
an> </span><br><span>     /* setenv stats */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    setenv_stats(m, &amp;mi-&gt;context);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    setenv_stats(&amp;mi-&gt;c=
ontext);</span><br><span> </span><br><span>     /* setenv connection durati=
on */</span><br><span>     setenv_long_long(mi-&gt;context=2Ec2=2Ees, &quot=
;time_duration&quot;, now - mi-&gt;created);</span><br><span> }</span><br><=
span> </span><br><span> static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-multi_client_disconnect_script(struct multi_context *m, struc=
t multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+multi_client_disconnect_script(struct multi_instance *mi)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_client_d=
isconnect_setenv(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    multi_client_disconnect_setenv(mi);</span><br><span> </span><br><s=
pan>     if (plugin_defined(mi-&gt;context=2Eplugins, OPENVPN_PLUGIN_CLIENT=
_DISCONNECT))</span><br><span>     {</span><br><span>@@ -634,7 +626,7 @@</s=
pan><br><span> </span><br><span>     if (mi-&gt;context=2Ec2=2Etls_multi-&g=
t;multi_state &gt;=3D CAS_CONNECT_DONE)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        multi_client_disconnect_sc=
ript(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 multi_client_disconnect_script(mi);</span><br><span>     }</span><br><span=
> </span><br><span>     close_context(&amp;mi-&gt;context, SIGTERM, CC_GC_F=
REE);</span><br><span>@@ -659,6 +651,12 @@</span><br><span> {</span><br><sp=
an>     if (m-&gt;hash)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* fetch final stats while all peers can=
 still be mapped to their instances */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (dco_enabled(&amp;m-&gt;top=2Eoptions))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            dco_get_peer_stats_mult=
i(&amp;m-&gt;top=2Ec1=2Etuntap-&gt;dco, false);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>         for (uint32_t i =3D 0; i &lt;=
=3D m-&gt;max_peerid; i++)</span><br><span>         {</span><br><span>     =
        struct multi_instance *mi =3D m-&gt;instances[i];</span><br><span>@=
@ -2750,7 +2748,7 @@</span><br><span>          * did not fail */</span><br>=
<span>         if (mi-&gt;context=2Ec2=2Etls_multi-&gt;multi_state =3D=3D C=
AS_PENDING_DEFERRED_PARTIAL)</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            multi_client_disconnect_scrip=
t(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  multi_client_disconnect_script(mi);</span><br><span>         }</span><br>=
<span> </span><br><span>         mi-&gt;context=2Ec2=2Etls_multi-&gt;multi_=
state =3D CAS_FAILED;</span><br></pre><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail">change 1952</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic535bb1f0da1739f8=
7e9d6bef6fd1061247b05de </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1952 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antoni=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>

</body></html>
--HW/dDk7eXKI=--


--===============5604483675185766224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5604483675185766224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5604483675185766224==--

