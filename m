Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D47C43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8cmGUFhLpDdTgleo99irZ+AmrnmUTqPEel5z0F2ug+E=; b=E7biOLpvao3gCINr2WfvCXwCM3
	bNMN100CvQkSdHySxrpgc3FvEjKt/c7MOWi5QDMTkF89d42ma8y1qx+OsTp3hheQqv0GiyDwnGeEE
	uAYDE7KcC2qu/X9vtEvRkQ2FoJ2A+R5o4SiBW7G+6S37TGMqzjFOdDYL16dnHQWQ2A/k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whquc-0006iC-Na;
	Thu, 09 Jul 2026 15:43:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whqub-0006hy-CU
 for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:43:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZPD6S8SmcXLfxG//hMUt/IKnnZI4HyqDkaqVdo2Focw=; b=FpEibla0NEDFwFI0389HeYonbf
 MxYYJIfp3GcSUjlIwdF4YUFD+77XzIztCLAt1lRR3zReSG0oLpKHIJDcgKU5aTXN2GmEIRp++bqqI
 WE9fVfCpCoE/KRwq8Rq+s3hbi2s8O3v/Kvm2HcgT1ePDTn2ymnuUhDhGK+fQ3MNrrrCE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZPD6S8SmcXLfxG//hMUt/IKnnZI4HyqDkaqVdo2Focw=; b=V
 /5Oq0tEEJiVwnYnK7OAbnN18WffDRdsYU5P5eGl05BtRZJDyDK33kxJ8SQi+VFnnzxl/RNJXbb6kL
 q1QEYaKp5CTomr4eSv4zbqwdlyKZ0bWSaFCQiAp8CzmRzp26PVfSmJwkKoaU+m3bvjW8U4bl7rtxA
 ARy3/rKUhJgvpdB4=;
Received: from mail-ed1-f54.google.com ([209.85.208.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whqua-0000m4-KW for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:43:42 +0000
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6986287534eso3774365a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 09 Jul 2026 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783611814; x=1784216614; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZPD6S8SmcXLfxG//hMUt/IKnnZI4HyqDkaqVdo2Focw=;
 b=NPPhXlqCO4EcvboFx9xs22GePwGMA1g9yqMY3HoiaUBW74BUQRggHSFClwVp+wn9qm
 kRhdSCF9FYIK24sRISgu9bsHTIzv2TlpjawAxxk/0IkY7fwMkd09jz8zYtth5mLD2IOG
 EzQriNaKry4qUq+JQDvq7IXfRRvMszcpxtwlPcFJTx/RhXXriC7puQ3Ftz5vVGV1DemJ
 yTVic/8zH5lxsPTrrybEH6TD4KjmGQ+f2aKEP3Iq6bhwOSEonPgcL+mxdpdezS3p43sG
 3sOMNWP6QTSbylVWiPK56YqWSz2e2uK9wMYAbktUoqFeJHRz2P4372EAvbK8lHB5li+d
 qADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783611814; x=1784216614;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZPD6S8SmcXLfxG//hMUt/IKnnZI4HyqDkaqVdo2Focw=;
 b=dF7YqjtH9HBAWlVy8VQKLRWpTCk4FlyfvENgP1T/s8vSp/6CBCKSKVJT9CGDFQEOvS
 a9Q9ZL7STs0KaoSJbLFI656yCWX8qJ1m5KA0ti/5WSdwkQYFhECzdEPNcrZyTTx6i6yr
 MYXFgcBZjdNEhFZZmaFRljwDqcDp2S77KKHW0bXno4PlgXf0yXjMHjnBVNuaP3BoOdIT
 GIsjXkNSMHTimlFMpF0MM3BF8soag6/jMxZQBV8WRwTd3vTv8+EydQaJ5V1VPc4GCGVK
 P/EWU6KsjZyT7HVFELK7DmpzJoHC/C2LtyynpFV3F3y6x5oFEjiaxJC2lNkPAU9bw8Yn
 ZBvw==
X-Gm-Message-State: AOJu0YzyAnNIgDXWVf9HaFTI51DrAr6TUHvebrSsOf2y+NLFLjpjOCxd
 7liBcpj2cgxPkFqKPi1z5NXXsXFvLiVIZxEHpEEfeCq8Du7YBWpWAksMtPWx7xfIMKux/zYq3AQ
 oqmCNrwbhY7NX0ifd/BxeM5njw67giCJ3ibVlwjfc6OxucLCVP2gJAJTCVtcyr9F/WFaiFCm6KW
 uB/nwRmQ==
X-Gm-Gg: AfdE7ckP9m54xM8hk+/9/IBxPaehNaBdoULID6TgLGhA7zACVYnPLAMMROUdZlxsAij
 YwdQyLy+Ym0D8SeftjfbTZwT07FruCFIqySRn+jFJhjTlVMPmaqKl1L7CmdFF6y+l/ibZQik07p
 IqCWQ6GLpsEQ1gr0ohG0man7Cv5T+wHQOvQsKIqs15dwD1hPqs/KYuotgVl1jLgCK8G1LrC+58z
 KBWdqfYpcO6tTzGst6JkHposj5xVVp7SsiFOlQvwjfLDAYRep2E+4iK9k8dllbIZIWy+jxZpwxH
 HphVBRChiXanEyRNa66rL6vbB+kLtNXrTn7Y7UYwIu0jnD0H7PNVZufwVZRouVecTF3VRJeX3xd
 0vT77aLntMShmDaPgfsGdoQjpsRXSHDMEehGY9halWi0NX/WV7lWBzJX9zbf+zNTVMnSvD1F22T
 HR6MUB5y/3fpL8G45PWFbeNRmpoFWIZPa7hEgvltVD77es/GeK8UW+JQFowlQq6m1M9Qp+KlLxD
 wMBoyWytWX9Fhe407Hyn+RmTmGKSbjt0WE8IeDqoaGiLoRtprHvskac8ONdUXvah1AGqK76S1JH
 qezFWyTTdB01Dg==
X-Received: by 2002:a05:6000:26d3:b0:474:3b3b:5e5f with SMTP id
 ffacd0b85a97d-47df072b06bmr7711911f8f.16.1783604853474; 
 Thu, 09 Jul 2026 06:47:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d843csm50843000f8f.14.2026.07.09.06.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 06:47:33 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 9 Jul 2026 13:47:21 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
X-Gerrit-Change-Number: 1743
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1743?usp=email>
X-Gerrit-Commit: a42fcc7cb35546e3b6e785928aa11e08365b68bc
In-Reply-To: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNzVjYTJlZTliNTlhNGUxMWYzN2NkOTY1M2RmMjY4YmJhMzM4ODljQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <40444f7611d8d12bbda654ebb21be550135099d1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whqua-0000m4-KW
Subject: [Openvpn-devel] [M] Change in openvpn[master]: mudp: extract
 send_standalone_reply() helper
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7604003261085951833=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7604003261085951833==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8M1lHH6VAsY="; charset=UTF-8

--8M1lHH6VAsY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

He=
llo flichtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please=
 visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail

to =
look at the new patch set (#4)=2E

The following approvals got outdated and=
 were removed:
Code-Review-1 by flichtenheld


Change subject: mudp: extrac=
t send_standalone_reply() helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

mudp: extract send_standalone_reply() helper

Factor th=
e synchronous, stateless "send a standalone control packet back to the
peer=
 that just contacted us" sequence out of send_hmac_reset_packet() into a
re=
usable helper=2E No behavioural change=2E

This lets a following commit reu=
se it for the out-of-band probe reply instead of
duplicating the aux_buf / =
to_link / process_outgoing_link sequence=2E

Change-Id: Ic75ca2ee9b59a4e11f=
37cd9653df268bba33889c
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
=
M src/openvpn/mudp=2Ec
1 file changed, 37 insertions(+), 23 deletions(-)


=
  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/43/1743/=
4

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 9acf297=
=2E=2E2be085f 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
=
@@ -37,6 +37,41 @@
 #include <sys/inotify=2Eh>
 #endif
 
+/**
+ * Send an a=
lready-built standalone control packet back to the peer that just
+ * conta=
cted us (c2=2Efrom), synchronously and without keeping any state=2E
+ *
+ *=
 We do not want to keep state for a reply to an initial/out-of-band packet,=
 so
+ * we send it without queueing=2E If we hit EAGAIN on a busy socket th=
e packet is
+ * lost and the client simply retries -- an acceptable comprom=
ise that avoids
+ * consuming server resources under attack=2E
+ *
+ * @par=
am m       the server's multi_context
+ * @param buf     the packet to send=
 (built by a tls_*_standalone() helper)
+ * @param prefix  msg() prefix to =
set for the duration of the send
+ * @param detail  D_MULTI_DEBUG message d=
escribing the reply
+ * @param sock    the socket to send the reply on
+ */=

+static void
+send_standalone_reply(struct multi_context *m, struct buffer=
 *buf, const char *prefix,
+                      const char *detail, struc=
t link_socket *sock)
+{
+    struct context *c =3D &m->top;
+
+    /* dco-w=
in server requires prepend with sockaddr, so preserve offset */
+    ASSERT=
(buf_init(&c->c2=2Ebuffers->aux_buf, buf->offset));
+    buf_copy(&c->c2=2E=
buffers->aux_buf, buf);
+
+    msg_set_prefix(prefix);
+    c->c2=2Eto_link=
 =3D c->c2=2Ebuffers->aux_buf;
+    c->c2=2Eto_link_addr =3D &c->c2=2Efrom;=

+    msg(D_MULTI_DEBUG, "%s", detail);
+    process_outgoing_link(c, sock)=
;
+    c->c2=2Eto_link=2Elen =3D 0;
+    c->c2=2Eto_link_addr =3D NULL;
+  =
  msg_set_prefix(NULL);
+}
+
 static void
 send_hmac_reset_packet(struct mu=
lti_context *m, struct tls_pre_decrypt_state *state,
                      =
  struct tls_auth_standalone *tas, struct session_id *sid,
@@ -48,29 +83,8 =
@@
     struct buffer buf =3D tls_reset_standalone(&state->tls_wrap_tmp, ta=
s, sid,
                                              &state->peer_session_=
id, header, request_resend_wkc);
 
-    struct context *c =3D &m->top;
-
- =
   /* dco-win server requires prepend with sockaddr, so preserve offset */
=
-    ASSERT(buf_init(&c->c2=2Ebuffers->aux_buf, buf=2Eoffset));
-
-    buf_=
copy(&c->c2=2Ebuffers->aux_buf, &buf);
-
-    /*
-     * We do not want to =
keep any state here, so we send the reply to the
-     * initial packet syn=
chronously without queueing anything=2E
-     *
-     * If we hit EAGAIN on=
 a busy socket, the packet will be lost and the
-     * client will have to=
 retransmit its HARD_RESET=2E This is considered an
-     * acceptable comp=
romise to avoid consuming server resources under attack=2E
-     */
-    ms=
g_set_prefix("Connection Attempt");
-    c->c2=2Eto_link =3D c->c2=2Ebuffer=
s->aux_buf;
-    c->c2=2Eto_link_addr =3D &c->c2=2Efrom;
-    msg(D_MULTI_D=
EBUG, "Reset packet from client, sending HMAC based reset challenge");
-   =
 process_outgoing_link(c, sock);
-    c->c2=2Eto_link=2Elen =3D 0;
-    c->=
c2=2Eto_link_addr =3D NULL;
-    msg_set_prefix(NULL);
+    send_standalone=
_reply(m, &buf, "Connection Attempt",
+                          "Reset pac=
ket from client, sending HMAC based reset challenge", sock);
 }
 
 

-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd9=
653df268bba33889c
Gerrit-Change-Number: 1743
Gerrit-PatchSet: 4
Gerrit-Owne=
r: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--8M1lHH6VAsY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>stipa <stro=
ng>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail">View Change</a></p><p=
>The following approvals got outdated and were removed:
Code-Review-1 by fl=
ichtenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">mudp: extract send_standalone_reply() helper<br=
><br>Factor the synchronous, stateless &quot;send a standalone control pack=
et back to the<br>peer that just contacted us&quot; sequence out of send_hm=
ac_reset_packet() into a<br>reusable helper=2E No behavioural change=2E<br>=
<br>This lets a following commit reuse it for the out-of-band probe reply i=
nstead of<br>duplicating the aux_buf / to_link / process_outgoing_link sequ=
ence=2E<br><br>Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c<br>Sign=
ed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/m=
udp=2Ec<br>1 file changed, 37 insertions(+), 23 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/43/1743/4</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=
=2Ec</span><br><span>index 9acf297=2E=2E2be085f 100644</span><br><span>--- =
a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br=
><span>@@ -37,6 +37,41 @@</span><br><span> #include &lt;sys/inotify=2Eh&gt;=
</span><br><span> #endif</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Send an already-built standalone control packet back to the peer =
that just</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * contact=
ed us (c2=2Efrom), synchronously and without keeping any state=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * We do not want to keep state for a reply to=
 an initial/out-of-band packet, so</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * we send it without queueing=2E If we hit EAGAIN on a busy=
 socket the packet is</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * lost and the client simply retries -- an acceptable compromise that av=
oids</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * consuming se=
rver resources under attack=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram m       the server&#39;s multi_context</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param buf     the packet to send (built by a tls=
_*_standalone() helper)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param prefix  msg() prefix to set for the duration of the send</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param detail  D_MULT=
I_DEBUG message describing the reply</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param sock    the socket to send the reply on</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+send_standalone_reply(struct multi_context *m, struc=
t buffer *buf, const char *prefix,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                      const char *detail, struct link_socket=
 *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D &amp=
;m-&gt;top;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* dco-win server requi=
res prepend with sockaddr, so preserve offset */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ASSERT(buf_init(&amp;c-&gt;c2=2Ebuffers-&g=
t;aux_buf, buf-&gt;offset));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buf_copy(&amp;c-&gt;c2=2Ebuffers-&gt;aux_buf, buf);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    msg_set_prefix(prefix);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eto_link =3D c-&gt;c2=2Ebuf=
fers-&gt;aux_buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  c-&gt;c2=2Eto_link_addr =3D &amp;c-&gt;c2=2Efrom;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_MULTI_DEBUG, &quot;%s&quot;, de=
tail);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    process_o=
utgoing_link(c, sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    c-&gt;c2=2Eto_link=2Elen =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    c-&gt;c2=2Eto_link_addr =3D NULL;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    msg_set_prefix(NULL);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span> sen=
d_hmac_reset_packet(struct multi_context *m, struct tls_pre_decrypt_state *=
state,</span><br><span>                        struct tls_auth_standalone *=
tas, struct session_id *sid,</span><br><span>@@ -48,29 +83,8 @@</span><br><=
span>     struct buffer buf =3D tls_reset_standalone(&amp;state-&gt;tls_wra=
p_tmp, tas, sid,</span><br><span>                                          =
    &amp;state-&gt;peer_session_id, header, request_resend_wkc);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct con=
text *c =3D &amp;m-&gt;top;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* dco-win =
server requires prepend with sockaddr, so preserve offset */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_init(&amp;c-&gt;c2=2E=
buffers-&gt;aux_buf, buf=2Eoffset));</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bu=
f_copy(&amp;c-&gt;c2=2Ebuffers-&gt;aux_buf, &amp;buf);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
  * We do not want to keep any state here, so we send the reply to the</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-     * initial packet sync=
hronously without queueing anything=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-     * If we hit EAGAIN on a busy socket, the packet will be lost and the=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * client will ha=
ve to retransmit its HARD_RESET=2E This is considered an</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     * acceptable compromise to avoid co=
nsuming server resources under attack=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    msg_set_prefix(&quot;Connection Attempt&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Eto_link =3D c-&gt;c2=2Ebu=
ffers-&gt;aux_buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 c-&gt;c2=2Eto_link_addr =3D &amp;c-&gt;c2=2Efrom;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    msg(D_MULTI_DEBUG, &quot;Reset packet from=
 client, sending HMAC based reset challenge&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    process_outgoing_link(c, sock);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Eto_link=2Elen =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2E=
to_link_addr =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    msg_set_prefix(NULL);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    send_standalone_reply(m, &amp;buf, &quot;Connection Attempt&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
         &quot;Reset packet from client, sending HMAC based reset challenge=
&quot;, sock);</span><br><span> }</span><br><span> </span><br><span> </span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1743?usp=3Demail">change 1743</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1743?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic75ca2ee9b59a4e11f37cd=
9653df268bba33889c </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1743 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

<=
/body></html>
--8M1lHH6VAsY=--


--===============7604003261085951833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7604003261085951833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7604003261085951833==--

