Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0B4C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 00:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=377d3FPOvj7n2HZ8qdbuh8ZBipAUVfDPpOTrLL6tUTE=; b=Pp45qA7yb7Dl4Q
	3GsxTHox6CrkpQ52zks6gPzEFbUPtW20cjOaaaOwWbtYXFzAlkMq1hwtcRN+dRmjm/MI08LabdYBT
	alup+zr+TEPVEkEQ/zUbpzm8DWeJsHpenUn7qpx7qnoZQIYLafiNcQSlhGNLsAocnQ7MXAFcqsPDC
	3cw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdzz1-0001I0-DR;
	Mon, 29 Jun 2026 00:36:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wdzyz-0001Ht-Tu
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 00:36:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=89EDoCdLMc76LRKk4jynjftiBiRzLgY3BJRnrBmm7Q0=; b=UqfXEULkjEt3116DDiOieNXeJT
 R4TvER818RPfuVtSEbjf+fcPQ9gTmjzPnAjDnacy0NK4uLCwvr8hnGW+RsDIwLPeWvVT9Bs46nPsW
 cLoplXmHkZDouflhmSRhS6oXd7ScoKBGEMm0+0mI6lGg2FNu8+xGEP37MFxPSoQ/bG6U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=89EDoCdLMc76LRKk4jynjftiBiRzLgY3BJRnrBmm7Q0=; b=C
 jtVuoEJWZcX0l0Pu2oRAK7TbfsSQdHpLBur7LTR2Of4/prZOxtijpACoyHWUM5+JYYHo+mocNZrMQ
 i7N8aRnpUK0YBW6sglwRX+sPPHQ92LedGEi9B7DnszszXC6TafFkQea04VZc1h7MMKcYZb6g3VC1C
 dSeDPHv79a6M4d90=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wdzyy-0003Bn-3u for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 00:36:17 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-493a54b80a5so13496165e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 28 Jun 2026 17:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782693365; x=1783298165; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=89EDoCdLMc76LRKk4jynjftiBiRzLgY3BJRnrBmm7Q0=;
 b=PEn/K759B/GtBveKocylvDu8qaDdgbQSB0x6922rbBU55TdKvzlf6NgKLyKvolrTos
 77HJGKAuaEOLHaB7RU7HccLZwZxY1jsj+1ADMFEUzUT5XQAJNrh0fiPB/9TkSkX78RWE
 ql6jRmtDebOnwwXlew3gfBAUWkaa2jfW6yC6BZ+x5ZeCFfdTuseMQRoqH6TJzaJ5f9/Y
 ToLAUHsCK6JrxNEJqPGf4lE0L6bR4rVF+5q0AhTUFxOoQUMgsXbuOLP4Wz/s+T/Fr4Cl
 +4uIEFuNdgT16QbTcqNsrAkBzh4TJCmUPk1pGJjO2s2siysArDq5eh6eUBnxU8NwlL7f
 pIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782693365; x=1783298165;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=89EDoCdLMc76LRKk4jynjftiBiRzLgY3BJRnrBmm7Q0=;
 b=FIHLKI/SZgH0qKENzzMNTehQ0htI9M3V7Kd2KUB6bQOeKl/KSSap0HTzkebFKpnL3i
 nX5sx+UeKL7lim3h32jG/vy7K5aQvPo/KLbYChbJYYQrYoBWWDetYP6YuRd0ZL1VB8iW
 s4tc7bHFyd3xFRNzj1bB2qy/wKzef0NHaKhxKZYqd5lps97O7NBfYDoM0W68LIBWIBjn
 36m6XGg9ZvyUmIoSfKtreYdv+w2SrZmu1AdBriqHNO8dYj2PBmHW+ejD0WTobCHZAcxr
 G5Cn0iKBxRzOPNk0t+mOKKT7m+pjgW98aNvQxXK2ed6PV7eyy6cthDCaVG5nqqr7LTOW
 7+iQ==
X-Gm-Message-State: AOJu0YyrCYr5D4G3onTnn2OppmDsn+QDtpJ5v8Xtsz11uNogXuM5EPx9
 zarxBDE57Wi9/1HZ23VGL9nnpqNxPIsDK+BCFM6awHP0v40PEZMZksFatcHObjtAHkQJPPp6BRH
 A6RdvcoZtWytr+rTOEo/GTfOMkTRfhqg3jRqElGIdJ9VtcUfMuOc0rQOV1n+VR7jp8aB/OpbMzQ
 7ncMNykg==
X-Gm-Gg: AfdE7cmc0HuNm4KW5zEqs0bVPDpDj+uzfxwJET102cjDYe2HqsTZG0jNP52Uurj5qns
 j0oMNFplGfLvdaBnIzk3dyj8QWlOrw8gfDMljT7gfTHVgfqIIcEATLCsXEvj24QU6QLhziSPxPi
 ysUJHzYeUyj71hvFadt+WVdtvRvbEzOPXkPTNmVLXqK/dHQFehfT2Iz3WeO02n42FhePChiX2nH
 RUepFCqPYREMmxZIwcb585ZoXVDdpg4P9qZZFhvPo4bxoxBwtGiwz9XlEfYcmzajyjSHDq9W6Z0
 9mA//fef57ofCQ0cCfhdkS0QQYDEopct2+C2xghqMBetKTgg9ctbkxDAKp8GFhpvXpsQWDMeNHA
 qQfzX4RmrGZFSuCxUxoG16yGgKonBThViFPkhVXp/l6frlbi2F3e1sAT6IhruMCIlinlaD8kvBW
 51Qeq6G4M+Ckaek9923lny4ZM/OQaiYQ5Vko0UK135FzJ0uBmpmWYEj4SRQPMj0FPjWFHrxhXSV
 +PB/F9vc+gSop3l69lCZle1JJmzZ6cb+HtLWUQChs9r8w9ZKs261AAfZNTsY9/sizd2MX7cMshv
 bsc=
X-Received: by 2002:a05:600d:644a:10b0:493:ad1b:b38d with SMTP id
 5b1f17b1804b1-493ad1bc0b9mr22242635e9.37.1782693365015; 
 Sun, 28 Jun 2026 17:36:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492690168d5sm377117605e9.14.2026.06.28.17.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 17:36:04 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 00:36:04 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5
X-Gerrit-Change-Number: 1737
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1737?usp=email>
X-Gerrit-Commit: faaea4c811c3bc93b2121a96b2a4aef893259467
References: <gerrit.1782693360000.Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNjkzMzYwMDAwLklhNzg5NGZjMzYwYjEyYzVhMGY2M2ZhZDJhYmI5YmJiMWFkOWMyYmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f15cb5ff42560307093dee4c39e1ec02b438a520-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wdzyy-0003Bn-3u
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: read
 multicast notifications on a dedicated netlink socket
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6438386942181419050=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6438386942181419050==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rgcKtBRhiNM="; charset=UTF-8

--rgcKtBRhiNM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1737?usp=3Demail

to review the following change=2E


Chang=
e subject: dco_linux: read multicast notifications on a dedicated netlink s=
ocket
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_lin=
ux: read multicast notifications on a dedicated netlink socket

ovpn-dco sh=
ared a single netlink socket for both synchronous
request/reply transaction=
s (peer create/delete/get, key operations,
stats) and the asynchronous mult=
icast notification group (peer
del/float, key swap)=2E Because every ovpn_n=
l_msg_send() drains its reply
with nl_recvmsgs() on that same socket, a not=
ification queued by the
kernel could be dispatched re-entrantly in the midd=
le of an unrelated
request/reply: the NL_CB_VALID handler runs ovpn_handle_=
msg() ->
multi_process_incoming_dco() -> multi_close_instance() while the c=
aller
is still walking an instance collection=2E For example multi_print_st=
atus()
refreshes stats with dco_get_peer_stats_multi() and then iterates
m-=
>hash, and multi_delete_dup() iterates m->instances[] while closing
duplica=
tes; an instance freed underneath either iterator becomes a
use-after-free =
and the server crashes (observed under mass simultaneous
client reconnects)=
=2E

Subscribe the multicast group on a dedicated socket (nl_sock_notify) a=
nd
read it only from dco_read_and_process(), the top-level event-loop point=

where closing an instance is safe=2E The request/reply socket is no longer=

a member of the group, so parsing a command or stats reply can never
dispa=
tch a notification=2E The event loop now monitors the notification
socket; =
the request/reply socket keeps being drained synchronously by
ovpn_nl_msg_s=
end()=2E

Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5
GitHub: clos=
es OpenVPN/openvpn#1067
Signed-off-by: Antonio Quartulli <antonio=2Equartul=
li@openvpn=2Ecom>
---
M src/openvpn/dco_linux=2Ec
M src/openvpn/dco_linux=
=2Eh
2 files changed, 74 insertions(+), 11 deletions(-)



  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/1737/1

diff --git a/=
src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index 40746bd=2E=2E7a=
0f620 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2E=
c
@@ -134,12 +134,8 @@
 }
 
 static int
-ovpn_nl_recvmsgs(dco_context_t *dc=
o, const char *prefix)
+ovpn_nl_recvmsgs_report(int ret, const char *prefix=
)
 {
-    __is_locked =3D true;
-    int ret =3D nl_recvmsgs(dco->nl_sock, =
dco->nl_cb);
-    __is_locked =3D false;
-
     switch (ret)
     {
       =
  case -NLE_INTR:
@@ -174,6 +170,16 @@
     return ret;
 }
 
+static int
+o=
vpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)
+{
+    __is_locked=
 =3D true;
+    int ret =3D nl_recvmsgs(dco->nl_sock, dco->nl_cb);
+    __i=
s_locked =3D false;
+
+    return ovpn_nl_recvmsgs_report(ret, prefix);
+}
=
+
 /**
  * Send a prepared netlink message=2E
  *
@@ -398,9 +404,11 @@
    =
 }
 
     /* Register for ovpn-dco specific multicast messages that the ker=
nel may
-     * send
+     * send=2E These are subscribed on the dedicated =
notification socket only, so
+     * that they are never delivered while a =
request/reply transaction on
+     * dco->nl_sock is being parsed=2E
      =
*/
-    int ret =3D nl_socket_add_membership(dco->nl_sock, dco->ovpn_dco_mc=
ast_id);
+    int ret =3D nl_socket_add_membership(dco->nl_sock_notify, dco=
->ovpn_dco_mcast_id);
     if (ret)
     {
         msg(M_FATAL, "%s: faile=
d to join groups: %d", __func__, ret);
@@ -449,17 +457,49 @@
     nl_cb_set=
(dco->nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish, &dco->status);
   =
  nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);
 =

+    /* Set up the dedicated multicast notification socket=2E It shares th=
e message
+     * handler (ovpn_handle_msg) with the request/reply socket, =
but is read only
+     * from dco_read_and_process() in the event loop, so =
notifications never
+     * fire while a request/reply transaction is being=
 parsed=2E */
+    dco->nl_sock_notify =3D nl_socket_alloc();
+    if (!dco=
->nl_sock_notify)
+    {
+        msg(M_FATAL, "Cannot create netlink notif=
ication socket");
+    }
+
+    ret =3D genl_connect(dco->nl_sock_notify);
=
+    if (ret)
+    {
+        msg(M_FATAL, "Cannot connect to generic netli=
nk (notify): %s", nl_geterror(ret));
+    }
+
+    set_cloexec(nl_socket_ge=
t_fd(dco->nl_sock_notify));
+    set_nonblock(nl_socket_get_fd(dco->nl_sock=
_notify));
+
+    dco->nl_cb_notify =3D nl_cb_alloc(NL_CB_DEFAULT);
+    if=
 (!dco->nl_cb_notify)
+    {
+        msg(M_FATAL, "failed to allocate netl=
ink notification callback");
+    }
+
+    nl_socket_set_cb(dco->nl_sock_no=
tify, dco->nl_cb_notify);
+    nl_cb_err(dco->nl_cb_notify, NL_CB_CUSTOM, o=
vpn_nl_cb_error, &dco->status);
+    nl_cb_set(dco->nl_cb_notify, NL_CB_VAL=
ID, NL_CB_CUSTOM, ovpn_handle_msg, dco);
+
     ovpn_dco_register(dco);
 
 =
    /* The async PACKET messages confuse libnl and it will drop them with
 =
     * wrong sequence numbers (NLE_SEQ_MISMATCH), so disable libnl's sequen=
ce
-     * number check */
+     * number check=2E Multicast notifications =
are unsolicited and likewise carry
+     * no matching sequence number, so =
disable the check on both sockets=2E */
     nl_socket_disable_seq_check(dc=
o->nl_sock);
+    nl_socket_disable_seq_check(dco->nl_sock_notify);
 
     =
/* nl library sets the buffer size to 32k/32k by default which is sometimes=

      * overrun with very fast connecting/disconnecting clients=2E
      *=
 TODO: fix this in a better and more reliable way */
     ASSERT(!nl_socket=
_set_buffer_size(dco->nl_sock, 1024 * 1024, 1024 * 1024));
+    ASSERT(!nl_=
socket_set_buffer_size(dco->nl_sock_notify, 1024 * 1024, 1024 * 1024));
 }
=
 
 bool
@@ -495,8 +535,12 @@
     nl_socket_free(dco->nl_sock);
     dco->n=
l_sock =3D NULL;
 
+    nl_socket_free(dco->nl_sock_notify);
+    dco->nl_s=
ock_notify =3D NULL;
+
     /* Decrease reference count */
     nl_cb_put(d=
co->nl_cb);
+    nl_cb_put(dco->nl_cb_notify);
 
     CLEAR(dco);
 }
@@ -11=
64,7 +1208,13 @@
 {
     msg(D_DCO_DEBUG, __func__);
 
-    return ovpn_nl_=
recvmsgs(dco, __func__);
+    /* Drain the multicast notification socket=2E=
 This is the only place where
+     * asynchronous notifications (peer del/=
float, key swap) are processed, so
+     * the multi_close_instance() they =
may trigger happens at a safe point in
+     * the event loop rather than r=
e-entrantly inside a request/reply=2E */
+    int ret =3D nl_recvmsgs(dco->=
nl_sock_notify, dco->nl_cb_notify);
+
+    return ovpn_nl_recvmsgs_report(r=
et, __func__);
 }
 
 static int
@@ -1326,9 +1376,12 @@
 void
 dco_event_set=
(dco_context_t *dco, struct event_set *es, void *arg)
 {
-    if (dco && dc=
o->nl_sock)
+    if (dco && dco->nl_sock_notify)
     {
-        event_ctl(=
es, nl_socket_get_fd(dco->nl_sock), EVENT_READ, arg);
+        /* Only the =
notification socket is monitored by the event loop=2E The
+         * reque=
st/reply socket (dco->nl_sock) is drained synchronously by
+         * ovpn=
_nl_msg_send()=2E */
+        event_ctl(es, nl_socket_get_fd(dco->nl_sock_n=
otify), EVENT_READ, arg);
     }
 }
 
diff --git a/src/openvpn/dco_linux=2E=
h b/src/openvpn/dco_linux=2Eh
index e3e4824=2E=2Ec487581 100644
--- a/src/o=
penvpn/dco_linux=2Eh
+++ b/src/openvpn/dco_linux=2Eh
@@ -62,8 +62,18 @@
 
 =
typedef struct
 {
+    /* socket used for synchronous request/reply transac=
tions (commands and
+     * stats queries)=2E It is NOT subscribed to the m=
ulticast group, so its
+     * recvmsgs never dispatch an asynchronous noti=
fication=2E */
     struct nl_sock *nl_sock;
     struct nl_cb *nl_cb;
+   =
 /* socket dedicated to multicast notifications (peer del/float, key swap)=
=2E
+     * It is read only at the top-level dco_read_and_process() point, =
where it
+     * is safe to close instances=2E Keeping it separate from nl_=
sock prevents
+     * notifications from being processed re-entrantly while=
 a request/reply is
+     * in flight=2E */
+    struct nl_sock *nl_sock_no=
tify;
+    struct nl_cb *nl_cb_notify;
     int status;
 
     struct conte=
xt *c;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia7894fc360b=
12c5a0f63fad2abb9bbb1ad9c2bd5
Gerrit-Change-Number: 1737
Gerrit-PatchSet: 1=

Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>

--rgcKtBRhiNM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1737?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">dc=
o_linux: read multicast notifications on a dedicated netlink socket<br><br>=
ovpn-dco shared a single netlink socket for both synchronous<br>request/rep=
ly transactions (peer create/delete/get, key operations,<br>stats) and the =
asynchronous multicast notification group (peer<br>del/float, key swap)=2E =
Because every ovpn_nl_msg_send() drains its reply<br>with nl_recvmsgs() on =
that same socket, a notification queued by the<br>kernel could be dispatche=
d re-entrantly in the middle of an unrelated<br>request/reply: the NL_CB_VA=
LID handler runs ovpn_handle_msg() -&gt;<br>multi_process_incoming_dco() -&=
gt; multi_close_instance() while the caller<br>is still walking an instance=
 collection=2E For example multi_print_status()<br>refreshes stats with dco=
_get_peer_stats_multi() and then iterates<br>m-&gt;hash, and multi_delete_d=
up() iterates m-&gt;instances[] while closing<br>duplicates; an instance fr=
eed underneath either iterator becomes a<br>use-after-free and the server c=
rashes (observed under mass simultaneous<br>client reconnects)=2E<br><br>Su=
bscribe the multicast group on a dedicated socket (nl_sock_notify) and<br>r=
ead it only from dco_read_and_process(), the top-level event-loop point<br>=
where closing an instance is safe=2E The request/reply socket is no longer<=
br>a member of the group, so parsing a command or stats reply can never<br>=
dispatch a notification=2E The event loop now monitors the notification<br>=
socket; the request/reply socket keeps being drained synchronously by<br>ov=
pn_nl_msg_send()=2E<br><br>Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c=
2bd5<br>GitHub: closes OpenVPN/openvpn#1067<br>Signed-off-by: Antonio Quart=
ulli &lt;antonio=2Equartulli@openvpn=2Ecom&gt;<br>---<br>M src/openvpn/dco_=
linux=2Ec<br>M src/openvpn/dco_linux=2Eh<br>2 files changed, 74 insertions(=
+), 11 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/37/1737/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><span>index 40746b=
d=2E=2E7a0f620 100644</span><br><span>--- a/src/openvpn/dco_linux=2Ec</span=
><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br><span>@@ -134,12 +134,=
8 @@</span><br><span> }</span><br><span> </span><br><span> static int</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_nl_recvmsgs(dco_contex=
t_t *dco, const char *prefix)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ovpn_nl_recvmsgs_report(int ret, const char *prefix)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    __is_locked=
 =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret=
 =3D nl_recvmsgs(dco-&gt;nl_sock, dco-&gt;nl_cb);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    __is_locked =3D false;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     switch (ret)</span><=
br><span>     {</span><br><span>         case -NLE_INTR:</span><br><span>@@=
 -174,6 +170,16 @@</span><br><span>     return ret;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_nl_recvmsg=
s(dco_context_t *dco, const char *prefix)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    __is_locked =3D true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int ret =3D nl_recvmsgs(dco-&gt;nl_sock, dco-&gt;nl_cb);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    __is_locked =3D fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return ovpn_nl_recvmsgs_report(r=
et, prefix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</sp=
an><br><span>  * Send a prepared netlink message=2E</span><br><span>  *</sp=
an><br><span>@@ -398,9 +404,11 @@</span><br><span>     }</span><br><span> <=
/span><br><span>     /* Register for ovpn-dco specific multicast messages t=
hat the kernel may</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
  * send</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * send=
=2E These are subscribed on the dedicated notification socket only, so</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * that they are nev=
er delivered while a request/reply transaction on</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * dco-&gt;nl_sock is being parsed=2E</sp=
an><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    int ret =3D nl_socket_add_membership(dco-&gt;nl_sock, dco-&gt;ovpn_dco_=
mcast_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int r=
et =3D nl_socket_add_membership(dco-&gt;nl_sock_notify, dco-&gt;ovpn_dco_mc=
ast_id);</span><br><span>     if (ret)</span><br><span>     {</span><br><sp=
an>         msg(M_FATAL, &quot;%s: failed to join groups: %d&quot;, __func_=
_, ret);</span><br><span>@@ -449,17 +457,49 @@</span><br><span>     nl_cb_s=
et(dco-&gt;nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish, &amp;dco-&gt;=
status);</span><br><span>     nl_cb_set(dco-&gt;nl_cb, NL_CB_VALID, NL_CB_C=
USTOM, ovpn_handle_msg, dco);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Set up the dedicated multicast notificat=
ion socket=2E It shares the message</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * handler (ovpn_handle_msg) with the request/reply soc=
ket, but is read only</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * from dco_read_and_process() in the event loop, so notifications ne=
ver</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * fire whil=
e a request/reply transaction is being parsed=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;nl_sock_notify =3D nl_socket_=
alloc();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!dc=
o-&gt;nl_sock_notify)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_FATAL, &quot;Cannot create netlink notification socket&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ret =3D genl_connect(dco-&gt;nl_sock_notify);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (ret)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(M_FATAL, &quot;Cannot connect to generic n=
etlink (notify): %s&quot;, nl_geterror(ret));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set=
_cloexec(nl_socket_get_fd(dco-&gt;nl_sock_notify));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    set_nonblock(nl_socket_get_fd(dco-&gt=
;nl_sock_notify));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;nl_cb_no=
tify =3D nl_cb_alloc(NL_CB_DEFAULT);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!dco-&gt;nl_cb_notify)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(M_FATAL, &quot;failed to allocate netlink notific=
ation callback&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    nl_socket_set_cb(dco-&gt;n=
l_sock_notify, dco-&gt;nl_cb_notify);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    nl_cb_err(dco-&gt;nl_cb_notify, NL_CB_CUSTOM, ovpn_nl=
_cb_error, &amp;dco-&gt;status);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    nl_cb_set(dco-&gt;nl_cb_notify, NL_CB_VALID, NL_CB_CUSTOM,=
 ovpn_handle_msg, dco);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     ovpn_dco_register(dco);</span><br><span> </span><=
br><span>     /* The async PACKET messages confuse libnl and it will drop t=
hem with</span><br><span>      * wrong sequence numbers (NLE_SEQ_MISMATCH),=
 so disable libnl&#39;s sequence</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-     * number check */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * number check=2E Multicast notifications are unsolicite=
d and likewise carry</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * no matching sequence number, so disable the check on both sockets=
=2E */</span><br><span>     nl_socket_disable_seq_check(dco-&gt;nl_sock);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nl_socket_disable=
_seq_check(dco-&gt;nl_sock_notify);</span><br><span> </span><br><span>     =
/* nl library sets the buffer size to 32k/32k by default which is sometimes=
</span><br><span>      * overrun with very fast connecting/disconnecting cl=
ients=2E</span><br><span>      * TODO: fix this in a better and more reliab=
le way */</span><br><span>     ASSERT(!nl_socket_set_buffer_size(dco-&gt;nl=
_sock, 1024 * 1024, 1024 * 1024));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ASSERT(!nl_socket_set_buffer_size(dco-&gt;nl_sock_notify=
, 1024 * 1024, 1024 * 1024));</span><br><span> }</span><br><span> </span><b=
r><span> bool</span><br><span>@@ -495,8 +535,12 @@</span><br><span>     nl_=
socket_free(dco-&gt;nl_sock);</span><br><span>     dco-&gt;nl_sock =3D NULL=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    nl_socket_free(dco-&gt;nl_sock_notify);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    dco-&gt;nl_sock_notify =3D NULL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Decrease =
reference count */</span><br><span>     nl_cb_put(dco-&gt;nl_cb);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    nl_cb_put(dco-&gt;nl_cb_n=
otify);</span><br><span> </span><br><span>     CLEAR(dco);</span><br><span>=
 }</span><br><span>@@ -1164,7 +1208,13 @@</span><br><span> {</span><br><spa=
n>     msg(D_DCO_DEBUG, __func__);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return ovpn_nl_recvmsgs(dco, __func__);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Drain the mu=
lticast notification socket=2E This is the only place where</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * asynchronous notifications (=
peer del/float, key swap) are processed, so</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * the multi_close_instance() they may trigger =
happens at a safe point in</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * the event loop rather than re-entrantly inside a request/repl=
y=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =
=3D nl_recvmsgs(dco-&gt;nl_sock_notify, dco-&gt;nl_cb_notify);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return ovpn_nl_recvmsgs_report(ret, __func__);<=
/span><br><span> }</span><br><span> </span><br><span> static int</span><br>=
<span>@@ -1326,9 +1376,12 @@</span><br><span> void</span><br><span> dco_eve=
nt_set(dco_context_t *dco, struct event_set *es, void *arg)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dco &amp;&=
amp; dco-&gt;nl_sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (dco &amp;&amp; dco-&gt;nl_sock_notify)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        event_ctl(es, nl_=
socket_get_fd(dco-&gt;nl_sock), EVENT_READ, arg);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* Only the notification socket is mo=
nitored by the event loop=2E The</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * request/reply socket (dco-&gt;nl_sock) is drained s=
ynchronously by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     * ovpn_nl_msg_send()=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        event_ctl(es, nl_socket_get_fd(dco-&gt;nl_sock_notify),=
 EVENT_READ, arg);</span><br><span>     }</span><br><span> }</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/dco_linux=2Eh b/src/openvpn/dc=
o_linux=2Eh</span><br><span>index e3e4824=2E=2Ec487581 100644</span><br><sp=
an>--- a/src/openvpn/dco_linux=2Eh</span><br><span>+++ b/src/openvpn/dco_li=
nux=2Eh</span><br><span>@@ -62,8 +62,18 @@</span><br><span> </span><br><spa=
n> typedef struct</span><br><span> {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* socket used for synchronous request/reply transacti=
ons (commands and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * stats queries)=2E It is NOT subscribed to the multicast group, so its<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * recvmsgs neve=
r dispatch an asynchronous notification=2E */</span><br><span>     struct n=
l_sock *nl_sock;</span><br><span>     struct nl_cb *nl_cb;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* socket dedicated to multicast=
 notifications (peer del/float, key swap)=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * It is read only at the top-level dco_read_a=
nd_process() point, where it</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * is safe to close instances=2E Keeping it separate from nl_s=
ock prevents</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
notifications from being processed re-entrantly while a request/reply is</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * in flight=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nl_sock =
*nl_sock_notify;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct nl_cb *nl_cb_notify;</span><br><span>     int status;</span><br><sp=
an> </span><br><span>     struct context *c;</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
737?usp=3Demail">change 1737</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1737?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchan=
ge </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 1737 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerr=
it-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html=
>
--rgcKtBRhiNM=--


--===============6438386942181419050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6438386942181419050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6438386942181419050==--

