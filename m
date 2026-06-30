Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73393C43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=PAr9KkDQJN2i2oUKK4o31ZtME4iSsvDgRF7byUZIXxU=; b=ZZS0aX34yNVZea
	DCw5i5sdKFSoQQLvZor3ibY8Bm4pyQKoJtCKGTFWgZjAOGQx3Clqkm9zMsX1ZkpF6XgXuoOk8JlR1
	Dw70vEdYyLLV6lHV66PjdCbXAne4n8WIHVj1aEyx9aQSYxwsOmERFzyKtXkINtBXnJ4G/NqKCt1OC
	Fac=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weWwJ-00012C-86;
	Tue, 30 Jun 2026 11:47:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weWwI-000126-5h
 for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 11:47:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sPT5Z3MP2TyNRMiLDJ+oZJ/z3aK9+Y29CD1P6pF/wr8=; b=U2np4qpN7esboUzkXRJZdA8aLx
 ODheUnwkJo0DMhAsq4sTibqceZmiHw2hFVhbRqFs45vMkm9XJdXeYzJc1ROEDJpSYKGuhJDznj1HJ
 EZEKO8nR50nn6o4K3I8INhYjY7YZA+gJDuTcDpa5bl5wkG/x3pnypfTuLZg7FasDtScc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sPT5Z3MP2TyNRMiLDJ+oZJ/z3aK9+Y29CD1P6pF/wr8=; b=N
 Y+Z3V+kPBQKmTyy1s6b2Q1YJDSV5hj3Sj+UIlnH6w8MIM4DKoBsowsTgNMdORnJrc55EtSxmsWXQG
 +6amP9QrRKtWpId7DN1ciozrs50DDSzlayPNnbIl8T0V0FaPG5cHrm3GoYZOLUNxwSNuuTyCy1xup
 SB3PZnsaKxc+rz3U=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weWwB-0003Wv-MO for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 11:47:40 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493b6f1b14bso5583135e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 30 Jun 2026 04:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782820050; x=1783424850; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPT5Z3MP2TyNRMiLDJ+oZJ/z3aK9+Y29CD1P6pF/wr8=;
 b=XncHSF4H30zM3C4viQhHMcPkUrc1rQ+3bhRjfQQPobsOSS9Fy6VhKWhwZ3dGEgQ6s0
 mqwWZld/8ueBQESdqiF29yqfcyNgfTO7qmf17ZHmPcdFD9vDt0v2sFiixaszkAWvRtUP
 j/OcewA8pFNyN91ipsjUaytu3GoWH9Mrz0MViEWdIPKjphNWbXXCBxT204Ovs4ZzML43
 em099aLTatUjxgakQsKVPTYTrvFsV9Ev18N2sEyMxaLois9NaEXg7vVY/Ep0iTGfB3so
 8qBV3IhvQA5WBx+79XJR0UBwCFx4In1SQn/djgto78cn18shjxgY3U3LIQTSVFHE31SE
 MLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782820050; x=1783424850;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sPT5Z3MP2TyNRMiLDJ+oZJ/z3aK9+Y29CD1P6pF/wr8=;
 b=GYEmTeLsHigR7CQGSGvOdCAaBg/vL7EJFyOMkY40w9j43UPsLrVnfbQPnyEqdCjOgw
 DPzelltbjq0gsfMc7UrW+xJhZ+gDyX3SQPTaPqC5u4LaQO0r/0+beWosXDA84WhbTps4
 2HYkH+NfB1Yk8ueWwOpMm3kfH9kwrLkSJukQlw9WHm4WGH3PZUgv2ohazq1WBYT3C/rb
 lmcE4U1UnEmjIWvodLZiZPI5vSaJEuox+3R57VjVJSiFatBb9mnbX5YNtK0BrB+wOXpD
 gepRfbwyP983Rd9gHgvhICu8Qma/VwPTohz1dNFv74CSW3LnZx5RFVNlkNGYsmTiNim+
 AOdA==
X-Gm-Message-State: AOJu0Yy63H5FGOSZmkgBaN29y1yFn6n/VQ+tcoembOEci6XO5sgxF/i6
 GTTLlLoocwCdspk9Bc/QrJkuX6GxtUMkdgXyU8gSn2YQefR0S1nOUlaztcbhbGEBZ9VYO71g26r
 Gdk1utVRzz3mSKPBDk9eU0DYnKwTzAcw7bNUChgISzuTinNcCAdt9uIN2gX9VCYU5GhaZ
X-Gm-Gg: AfdE7clNPXLgs2num94RGmPg6rBdfCrXFsF82QMGwdL5baAHxvx4J1fkg7QEDcUQDWg
 10iWi3/Tf86+1tbEt7IDZvZiP1BIvDT4HpZgKIyGMinXPNxqj4wwd4Jyb1S0OVvyPRhKedgx7hE
 EkXEUMhoUc5WEmYSc7pD57c95mQbrngDCNUY1uJMm2HQIzKklhhe8QkBWabvE6C1jcrUqIGKp6E
 DBgwgbWgt2ByVRk71HLEA3qPrc7ik8NfZmKG6EhxpAfx11otHPGTESqBpg8G6kvhftM9SivhfY/
 YKfn9SxbaKY47g4udI26n+EkLfPl6TtNN3rtL8TxhYYMbGdz1gHVx24SUR9YDAIr0ns2WL6DXGL
 o7hfPMlsTsm0umYHelZX7GBY3M8cYBg2FIGkdkP6za469oIaj/CiDp9nBDYRl2KG3tFVh2HdNxo
 9q0NudhXXp7tM/cersYc8jEwCHAC0WGvKDuHF91vMg+P1d5/+DVQSpf63zOJ6cFpcEXe3AiBRAL
 Jy9S3jrXN0978+XuxKH+3qcsxindecmb5l/+xAJZHvGJXRUw98y9CTjjKIXoZq36N2gv7OWnxVt
 QdfjNbZMLIuBAA==
X-Received: by 2002:a05:600c:8583:b0:493:b910:202c with SMTP id
 5b1f17b1804b1-493b91022a1mr38515335e9.34.1782820049419; 
 Tue, 30 Jun 2026 04:47:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8d0496csm57634815e9.10.2026.06.30.04.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 04:47:28 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 30 Jun 2026 11:47:28 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0
X-Gerrit-Change-Number: 1759
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1759?usp=email>
X-Gerrit-Commit: 00813ff3ea10557edcc15cd33289982ac990bd48
References: <gerrit.1782820043000.I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLkk1Y2MxMDBkZDdkYzgxMGQ3ZDFlNmYyOWJiNTc1ODQ5MDVmYmNmNGEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <262bf71941d55eeacf7ea7b2c88181b5476d9f90-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weWwB-0003Wv-MO
Subject: [Openvpn-devel] [S] Change in openvpn[master]: oob: Send
 tls-crypt-v2 SERVER_PROBE from the client
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2865146634975927029=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2865146634975927029==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jVeACXerx8U="; charset=UTF-8

--jVeACXerx8U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1759?usp=3Demail

to review the following change=2E


Chang=
e subject: oob: Send tls-crypt-v2 SERVER_PROBE from the client
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Send tls-crypt-v2 SE=
RVER_PROBE from the client

When tls-crypt-v2 is configured, send the probe=
 as P_CONTROL_OOB_WKC_V1
with the wrapped client key (WKc) appended, so the=
 server can recover the
per-client key and unwrap it=2E Without tls-crypt-v=
2 the probe stays a plain
P_CONTROL_OOB_V1, unchanged=2E

  - drop the "ski=
p probing under tls-crypt-v2" bail-out
  - make the WKc available on the pr=
obe's wrap context (mirroring
    init_instance()), so tls_wrap_control() a=
ppends it
  - choose the opcode (P_CONTROL_OOB_WKC_V1 vs P_CONTROL_OOB_V1) =
and report
    "tls-crypt-v2" in the wrapping log line

Change-Id: I5cc100d=
d7dc810d7d1e6f29bb57584905fbcf4a0
---
M src/openvpn/oob_client=2Ec
1 file c=
hanged, 24 insertions(+), 17 deletions(-)



  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/59/1759/1

diff --git a/src/openvpn/oo=
b_client=2Ec b/src/openvpn/oob_client=2Ec
index 2b1b732=2E=2E7e26392 100644=

--- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -84,1=
9 +84,9 @@
      * supported; the first entry's wrapping is used for all=2E=
) */
     const struct connection_entry *ce =3D c->options=2Econnection_lis=
t->array[0];
 
-    /* tls-crypt-v2 wraps with a per-client key the server =
only learns from the
-     * wrapped client key (WKc) carried in the TLS ha=
ndshake=2E An out-of-band
-     * probe carries no WKc, so the server canno=
t unwrap it; skip probing rather
-     * than send something unverifiable=
=2E */
-    if (ce->tls_crypt_v2_file)
-    {
-        msg(D_LOW, "server-p=
robe: not supported with tls-crypt-v2; using configured order");
-        r=
eturn NULL;
-    }
-
-    /* Load the tls-auth/tls-crypt key material into =
c->c1=2Eks (a no-op if neither
-     * is configured)=2E This is run again =
per-connection later; calling it early
-     * here is harmless=2E */
+    =
/* Load the tls-auth/tls-crypt(-v2) key material into c->c1=2Eks (a no-op i=
f
+     * none is configured)=2E This is run again per-connection later; ca=
lling it
+     * early here is harmless=2E */
     do_init_tls_wrap_key(c, =
ce);
 
     struct tls_options to;
@@ -105,6 +95,15 @@
     to=2Ereplay_win=
dow =3D c->options=2Ereplay_window;
     to=2Ereplay_time =3D c->options=2E=
replay_time;
 
+    /* tls-crypt-v2 wraps with a per-client key the server =
learns from the
+     * wrapped client key (WKc)=2E init_tls_wrap_ctx() loa=
ded the per-client key
+     * into the wrap context; make the WKc availabl=
e too so the probe can append
+     * it (as a P_CONTROL_OOB_WKC_V1 message=
), mirroring init_instance()=2E */
+    if (ce->tls_crypt_v2_file)
+    {
+=
        to=2Etls_wrap=2Etls_crypt_v2_wkc =3D &c->c1=2Eks=2Etls_crypt_v2_wkc=
;
+    }
+
     struct tls_auth_standalone *tas =3D tls_auth_standalone_ini=
t(&to, gc);
 
     /* Control-channel frame and work buffers, mirroring do_=
init_frame_tls()=2E */
@@ -467,8 +466,15 @@
         return;
     }
 
+    =
/* With tls-crypt-v2 the probe must carry the wrapped client key so the
+  =
   * server can recover the per-client key; that is a P_CONTROL_OOB_WKC_V1
=
+     * message=2E Otherwise (tls-crypt v1, tls-auth, or plaintext) it is a=
 plain
+     * P_CONTROL_OOB_V1=2E */
+    const bool is_v2 =3D (tas->tls_w=
rap=2Etls_crypt_v2_wkc !=3D NULL);
+    const int probe_opcode =3D is_v2 ? =
P_CONTROL_OOB_WKC_V1 : P_CONTROL_OOB_V1;
+
     struct buffer probe =3D
-  =
      tls_wrap_oob_standalone(&tas->tls_wrap, tas, &client_sid, &payload, P=
_CONTROL_OOB_V1);
+        tls_wrap_oob_standalone(&tas->tls_wrap, tas, &cl=
ient_sid, &payload, probe_opcode);
     if (!BLEN(&probe))
     {
         =
msg(D_LOW, "server-probe: could not wrap probe packet; using configured ord=
er");
@@ -478,9 +484,10 @@
         return;
     }
 
-    const char *wrap_=
name =3D (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? "tls-crypt"
-     =
                       : (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? "tls=
-auth"
-                                                                   =
 : "none (plaintext)";
+    const char *wrap_name =3D is_v2                =
                    ? "tls-crypt-v2"
+                            : (tas->t=
ls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT) ? "tls-crypt"
+                      =
      : (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH)  ? "tls-auth"
+        =
                                                             : "none (plain=
text)";
     msg(D_LOW, "server-probe: probing %d remote(s) with a %d ms wi=
ndow, control-channel wrapping: %s",
         l->len, OOB_PROBE_WINDOW_MS, =
wrap_name);
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1759?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newc=
hange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5cc1=
00dd7dc810d7d1e6f29bb57584905fbcf4a0
Gerrit-Change-Number: 1759
Gerrit-Patc=
hSet: 1
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>

--jVeACXerx8U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1759?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oo=
b: Send tls-crypt-v2 SERVER_PROBE from the client<br><br>When tls-crypt-v2 =
is configured, send the probe as P_CONTROL_OOB_WKC_V1<br>with the wrapped c=
lient key (WKc) appended, so the server can recover the<br>per-client key a=
nd unwrap it=2E Without tls-crypt-v2 the probe stays a plain<br>P_CONTROL_O=
OB_V1, unchanged=2E<br><br>  - drop the &quot;skip probing under tls-crypt-=
v2&quot; bail-out<br>  - make the WKc available on the probe&#39;s wrap con=
text (mirroring<br>    init_instance()), so tls_wrap_control() appends it<b=
r>  - choose the opcode (P_CONTROL_OOB_WKC_V1 vs P_CONTROL_OOB_V1) and repo=
rt<br>    &quot;tls-crypt-v2&quot; in the wrapping log line<br><br>Change-I=
d: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0<br>---<br>M src/openvpn/oob_cl=
ient=2Ec<br>1 file changed, 24 insertions(+), 17 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/59/1759/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn=
/oob_client=2Ec</span><br><span>index 2b1b732=2E=2E7e26392 100644</span><br=
><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+++ b/src/openvpn/o=
ob_client=2Ec</span><br><span>@@ -84,19 +84,9 @@</span><br><span>      * su=
pported; the first entry&#39;s wrapping is used for all=2E) */</span><br><s=
pan>     const struct connection_entry *ce =3D c-&gt;options=2Econnection_l=
ist-&gt;array[0];</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* tls-crypt-v2 wraps with a per-client key the server on=
ly learns from the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
  * wrapped client key (WKc) carried in the TLS handshake=2E An out-of-band=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * probe carries =
no WKc, so the server cannot unwrap it; skip probing rather</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-     * than send something unverifiab=
le=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ce-&g=
t;tls_crypt_v2_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_LOW=
, &quot;server-probe: not supported with tls-crypt-v2; using configured ord=
er&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret=
urn NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    /* Load the tls-auth/tls-crypt key material i=
nto c-&gt;c1=2Eks (a no-op if neither</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-     * is configured)=2E This is run again per-connection l=
ater; calling it early</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-     * here is harmless=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* Load the tls-auth/tls-crypt(-v2) key material into c-&gt;=
c1=2Eks (a no-op if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * none is configured)=2E This is run again per-connection later; calli=
ng it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * early h=
ere is harmless=2E */</span><br><span>     do_init_tls_wrap_key(c, ce);</sp=
an><br><span> </span><br><span>     struct tls_options to;</span><br><span>=
@@ -105,6 +95,15 @@</span><br><span>     to=2Ereplay_window =3D c-&gt;optio=
ns=2Ereplay_window;</span><br><span>     to=2Ereplay_time =3D c-&gt;options=
=2Ereplay_time;</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* tls-crypt-v2 wraps with a per-client key the server le=
arns from the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 wrapped client key (WKc)=2E init_tls_wrap_ctx() loaded the per-client key<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * into the wrap=
 context; make the WKc available too so the probe can append</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * it (as a P_CONTROL_OOB_WKC_=
V1 message), mirroring init_instance()=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (ce-&gt;tls_crypt_v2_file)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        to=2Etls_wrap=2Etls_crypt_v2_wkc =3D &amp;=
c-&gt;c1=2Eks=2Etls_crypt_v2_wkc;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span>     struct tls_auth_standalone *tas =3D tls_auth_standalo=
ne_init(&amp;to, gc);</span><br><span> </span><br><span>     /* Control-cha=
nnel frame and work buffers, mirroring do_init_frame_tls()=2E */</span><br>=
<span>@@ -467,8 +466,15 @@</span><br><span>         return;</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* With tls-crypt-v2 the probe must carry the wrapped client key =
so the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * server=
 can recover the per-client key; that is a P_CONTROL_OOB_WKC_V1</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * message=2E Otherwise (tl=
s-crypt v1, tls-auth, or plaintext) it is a plain</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * P_CONTROL_OOB_V1=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const bool is_v2 =3D (tas-&gt;t=
ls_wrap=2Etls_crypt_v2_wkc !=3D NULL);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const int probe_opcode =3D is_v2 ? P_CONTROL_OOB_WKC=
_V1 : P_CONTROL_OOB_V1;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     struct buffer probe =3D</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        tls_wrap_oob_standalone(&amp;tas-&gt;tl=
s_wrap, tas, &amp;client_sid, &amp;payload, P_CONTROL_OOB_V1);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap_oob_standalone(=
&amp;tas-&gt;tls_wrap, tas, &amp;client_sid, &amp;payload, probe_opcode);</=
span><br><span>     if (!BLEN(&amp;probe))</span><br><span>     {</span><br=
><span>         msg(D_LOW, &quot;server-probe: could not wrap probe packet;=
 using configured order&quot;);</span><br><span>@@ -478,9 +484,10 @@</span>=
<br><span>         return;</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *wrap_name =3D=
 (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? &quot;tls-crypt&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
     : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? &quot;tls-auth&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
                                                : &quot;none (plaintext)&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char =
*wrap_name =3D is_v2                                    ? &quot;tls-crypt-v=
2&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT) ? &quot;t=
ls-crypt&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                       : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH)  ? =
&quot;tls-auth&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                                                     : &qu=
ot;none (plaintext)&quot;;</span><br><span>     msg(D_LOW, &quot;server-pro=
be: probing %d remote(s) with a %d ms window, control-channel wrapping: %s&=
quot;,</span><br><span>         l-&gt;len, OOB_PROBE_WINDOW_MS, wrap_name);=
</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1759?usp=3Demail">change 17=
59</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1759?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"=
display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> =
Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id:=
 I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0 </div>
<div style=3D"display:non=
e"> Gerrit-Change-Number: 1759 </div>
<div style=3D"display:none"> Gerrit-P=
atchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lsti=
pakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--jVeACXerx8U=--


--===============2865146634975927029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2865146634975927029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2865146634975927029==--

