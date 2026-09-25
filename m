Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCFAC98328
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qVRZGt/CVE6hoBe921bCt3C6hEzbbpU1V3lLEnOyuKU=; b=DO1z375xNuL7wSox91KFgZIQnf
	lnphj9t/VfJVk/2VutDuuGWrS+Wa94GgKiz2RNpyRe/gspSliZ0goJlbUCN4XtBcMJ7rIcL3eH+yg
	MaY1vJmtb7nBZBaDtSGrKFnsp2+C6Pwo7AYYiqjLZfxT13xb5HVUdS0wmUbNOrLjv42U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA8ZU-0002w7-Nf;
	Fri, 25 Sep 2026 16:14:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA8ZT-0002vz-Oc
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 16:14:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MrJILbnREPphEzBGwBlj3QfhucQpzICBoY+h065Wl20=; b=LM9/XahGtXsdqNG95cBde37pOt
 WRpfk/5qzK5TjQGY9Gq4Pk9L3Z6L2rGy2o7NLGk5D3LqGGjXYBbuI7ee3nkon7LF35Cg35PFO6itU
 IpJ+eLS28d7tGVxXa/TtolkJJ5lcZhErCK0O5q76hsp4dwU2qvei3m1EjoFJO7+Qmu0o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MrJILbnREPphEzBGwBlj3QfhucQpzICBoY+h065Wl20=; b=U
 0uhY9nROn7FDpWXSA5lOLNRsYXSf5/lN2D0Jj7KBKRIIPk2qFTXfD0qOicz3sT1An6i25ovFpmoiM
 r8sM1/Ftia2IP3226s3eGLgLHkr8medgVqdlumlF+SUkh4skaMND8D5ZEpZe5Qrs1hlKL+nf3bcTp
 MpgiHFqILKi63B2I=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA8ZS-0001IC-R8 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 16:14:48 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e66390995so6659715e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790352880; x=1790957680; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MrJILbnREPphEzBGwBlj3QfhucQpzICBoY+h065Wl20=;
 b=HPzq29gZdEWmwFFpLvdg/lr4HqFuvVprO+qt2jMUijUlxPCRDvbOiPLdAYEmxTNPer
 ZqBytPoSE0j9v+Z4AbHXzoy82q6idmwnSyJSPuPc1ZfXi/w9dEFqN9AW0tlHLzvp4A2q
 Rrx8I9XzeCMDtPE/YIaVM1rR+QJM50GyYQbh+bHiSm5dgPmZGqHK8Xeg9ofRyIx4je3S
 Z4DAD6/LIZt/pCSfPBDKpPHFOI8WLD6L6AEEj2jHM33eJJsoDYOln1VTJwdRxGs3xo3Y
 cAsotNYTOdT2ZBirt/uXeruFESfreblYGwkjG9shT7+i5uQLHeU1/h6+zJDiUBYZkDCS
 ZauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790352880; x=1790957680;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MrJILbnREPphEzBGwBlj3QfhucQpzICBoY+h065Wl20=;
 b=CQ+4pTg6qvY3N2rgF4u2IBS/BHRdVAsTZPyGAaUUkSQDZojNOJNhu5n70Axe07Koo+
 X2thLjz3cu6sUtLFdGCq7BdE4lxgCAzTlpvZLKIAvT6frZZoHYQSpBDuY+9OZ9XxKfN4
 QZws8r8yz0yTVcNdgH6N7A0lFfNneH30+jJefNSCnKWzh0iMrDioz2rbWwxzy6zh/e7g
 lG9FjzQTGsYbaWCm1GUBROLpTd7lOVs3T+e8CleQpnTgyRlICkAD1WZtWmjH/Yri/JT5
 Ap/vNLJ0Itpy6FQVdSuA7OLPtqqKhjfMarzhONS9gKnjP3223k7o+MGvr3uAK54pCvS1
 6xKw==
X-Forwarded-Encrypted: i=1;
 AKwUvByvZLUy+BygpF3HfPqnkmFUtCp9Jh+i5K5llobaHEzdfPvAGbGSwvFtRAlKrlkuPsNBMCfyVWF/ffSKfEut@lists.sourceforge.net
X-Gm-Message-State: AFuF++lB5R5AwIuI9ZYrprZqCYIdN87nvdONxTzaYrNt7+IycQt7Cu/d
 mgQthaH4xiiYKPzWGZ/O+OXJcz33Y7QH2O6dTGZYYxkUWyjz0HU5v3go049WQp8NCdpExzMP9eg
 KekF9YcbW6ypv6JYzBQ2k5Hh1nfrS3speRueCe8UW4EElWEFhpyqw+rWEljcdcnLuPjcD
X-Gm-Gg: AYBFou2EfCoi8AKNanhpKhOh0bEaZqoMd5PxERweQMjWDDQA2Q7FpP7ZsGaEt7IDlzv
 4Iuz/30679yWCQ1Sj738VJR3rRZpdk4Qe5TNzEqiWdayT/lqJu55/PJqaZ3BNpYi2nVxVhZx2Uy
 u/U01/OnopbuKY1q8/yc4qahbyZjyXSzMiFL7m55r8ZBT4OFJgZuESRMT4lg9n1+7Aqn6zYsTvq
 SFi7MuBgwlf9gRFsQHRbFwMB4ipf4i40d/AAGFbfIzXVjsqOJwlcd5iwvhPTJh69kXx9XuZJKDD
 Gnpio+VeW+KPlBwAqD835z4SLkcNakwnbXgOY6QAHJsof+LGrajvQtpQQtbCYKSLdvyZtK9BHjL
 rImHuaF+K9JITimWm0DNX/oMMQ3x+uglKGyS6qKm4hzGyx/wYh/eGna4AUHWcvtqkV5FaJKKt2b
 VbhwkPb8Re/5+9h128JmqIc9ef8oXBowY9jCvoRxtRVE1OERXeM7xxnHU7izyPx/DbVSrCl6mmL
 +xqpJ7Vvp53MGdNqBn9Ap4TwYfZ+RMPLUdc6A9BhqIwORp75YANfmVeG3o8127wolo6MgbB2FZX
 iIsnGIdc6TVZH6NYEu/Pcva4g4lP6hTnw9KPuSt687Q/JBOkJVVhKve8zILP
X-Received: by 2002:a05:600c:4e8b:b0:49c:fc6c:be06 with SMTP id
 5b1f17b1804b1-49ff06eeb73mr48768355e9.29.1790352880075; 
 Fri, 25 Sep 2026 09:14:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fef60cc72sm49915755e9.3.2026.09.25.09.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 09:14:39 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 16:14:38 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5
X-Gerrit-Change-Number: 1737
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1737?usp=email>
X-Gerrit-Commit: 08407e0d3c45ab889e6ff4252fc40d778acca149
In-Reply-To: <gerrit.1782693360000.Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5@gerrit.openvpn.net>
References: <gerrit.1782693360000.Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNjkzMzYwMDAwLklhNzg5NGZjMzYwYjEyYzVhMGY2M2ZhZDJhYmI5YmJiMWFkOWMyYmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ae90b547430a55e067cc408ecd628c838fa57bac-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA8ZS-0001IC-R8
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2069155246650536287=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2069155246650536287==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U0qPafDiXMk="; charset=UTF-8

--U0qPafDiXMk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1737?usp=3Demail )

Change subject: dco_linux: read multicast notificat=
ions on a dedicated netlink socket
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

dco_linux: read multicast notifications on a dedicat=
ed netlink socket

ovpn-dco shared a single netlink socket for both synchro=
nous
request/reply transactions (peer create/delete/get, key operations,
st=
ats) and the asynchronous multicast notification group (peer
del/float, key=
 swap)=2E Because every ovpn_nl_msg_send() drains its reply
with nl_recvmsg=
s() on that same socket, a notification queued by the
kernel could be dispa=
tched re-entrantly in the middle of an unrelated
request/reply: the NL_CB_V=
ALID handler runs ovpn_handle_msg() ->
multi_process_incoming_dco() -> mult=
i_close_instance() while the caller
is still walking an instance collection=
=2E For example multi_print_status()
refreshes stats with dco_get_peer_stat=
s_multi() and then iterates
m->hash, and multi_delete_dup() iterates m->ins=
tances[] while closing
duplicates; an instance freed underneath either iter=
ator becomes a
use-after-free and the server crashes (observed under mass s=
imultaneous
client reconnects)=2E

Subscribe the multicast group on a dedic=
ated socket (nl_sock_notify) and
read it only from dco_read_and_process(), =
the top-level event-loop point
where closing an instance is safe=2E The req=
uest/reply socket is no longer
a member of the group, so parsing a command =
or stats reply can never
dispatch a notification=2E The event loop now moni=
tors the notification
socket; the request/reply socket keeps being drained =
synchronously by
ovpn_nl_msg_send()=2E

Change-Id: Ia7894fc360b12c5a0f63fad=
2abb9bbb1ad9c2bd5
GitHub: closes OpenVPN/openvpn#1067
GitHub: OpenVPN/openv=
pn#1111
Signed-off-by: Antonio Quartulli <antonio=2Equartulli@openvpn=2Ecom=
>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1737
Message-Id: <20260925131417=2E10540-1-=
gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg39497=2Ehtml
Signed-off-by: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
---
M src/openvpn/dco_linux=2Ec
M src/openvpn/dco_li=
nux=2Eh
2 files changed, 74 insertions(+), 11 deletions(-)




diff --git a=
/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index 56f6259=2E=2E2=
7f4f99 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=
=2Ec
@@ -134,12 +134,8 @@
 }
 
 static int
-ovpn_nl_recvmsgs(dco_context_t =
*dco, const char *prefix)
+ovpn_nl_recvmsgs_report(int ret, const char *pre=
fix)
 {
-    __is_locked =3D true;
-    int ret =3D nl_recvmsgs(dco->nl_soc=
k, dco->nl_cb);
-    __is_locked =3D false;
-
     switch (ret)
     {
    =
     case -NLE_INTR:
@@ -174,6 +170,16 @@
     return ret;
 }
 
+static int=

+ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)
+{
+    __is_loc=
ked =3D true;
+    int ret =3D nl_recvmsgs(dco->nl_sock, dco->nl_cb);
+    =
__is_locked =3D false;
+
+    return ovpn_nl_recvmsgs_report(ret, prefix);
=
+}
+
 /**
  * Send a prepared netlink message=2E
  *
@@ -399,9 +405,11 @@
 =
    }
 
     /* Register for ovpn-dco specific multicast messages that the =
kernel may
-     * send
+     * send=2E These are subscribed on the dedicat=
ed notification socket only, so
+     * that they are never delivered while=
 a request/reply transaction on
+     * dco->nl_sock is being parsed=2E
   =
   */
-    int ret =3D nl_socket_add_membership(dco->nl_sock, dco->ovpn_dco=
_mcast_id);
+    int ret =3D nl_socket_add_membership(dco->nl_sock_notify, =
dco->ovpn_dco_mcast_id);
     if (ret)
     {
         msg(M_FATAL, "%s: fa=
iled to join groups: %d", __func__, ret);
@@ -450,17 +458,49 @@
     nl_cb_=
set(dco->nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish, &dco->status);
=
     nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco)=
;
 
+    /* Set up the dedicated multicast notification socket=2E It shares=
 the message
+     * handler (ovpn_handle_msg) with the request/reply socke=
t, but is read only
+     * from dco_read_and_process() in the event loop, =
so notifications never
+     * fire while a request/reply transaction is be=
ing parsed=2E */
+    dco->nl_sock_notify =3D nl_socket_alloc();
+    if (!=
dco->nl_sock_notify)
+    {
+        msg(M_FATAL, "Cannot create netlink no=
tification socket");
+    }
+
+    ret =3D genl_connect(dco->nl_sock_notify=
);
+    if (ret)
+    {
+        msg(M_FATAL, "Cannot connect to generic ne=
tlink (notify): %s", nl_geterror(ret));
+    }
+
+    set_cloexec(nl_socket=
_get_fd(dco->nl_sock_notify));
+    set_nonblock(nl_socket_get_fd(dco->nl_s=
ock_notify));
+
+    dco->nl_cb_notify =3D nl_cb_alloc(NL_CB_DEFAULT);
+   =
 if (!dco->nl_cb_notify)
+    {
+        msg(M_FATAL, "failed to allocate n=
etlink notification callback");
+    }
+
+    nl_socket_set_cb(dco->nl_sock=
_notify, dco->nl_cb_notify);
+    nl_cb_err(dco->nl_cb_notify, NL_CB_CUSTOM=
, ovpn_nl_cb_error, &dco->status);
+    nl_cb_set(dco->nl_cb_notify, NL_CB_=
VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);
+
     ovpn_dco_register(dco);
=
 
     /* The async PACKET messages confuse libnl and it will drop them wit=
h
      * wrong sequence numbers (NLE_SEQ_MISMATCH), so disable libnl's seq=
uence
-     * number check */
+     * number check=2E Multicast notificatio=
ns are unsolicited and likewise carry
+     * no matching sequence number, =
so disable the check on both sockets=2E */
     nl_socket_disable_seq_check=
(dco->nl_sock);
+    nl_socket_disable_seq_check(dco->nl_sock_notify);
 
  =
   /* nl library sets the buffer size to 32k/32k by default which is someti=
mes
      * overrun with very fast connecting/disconnecting clients=2E
    =
  * TODO: fix this in a better and more reliable way */
     ASSERT(!nl_soc=
ket_set_buffer_size(dco->nl_sock, 1024 * 1024, 1024 * 1024));
+    ASSERT(!=
nl_socket_set_buffer_size(dco->nl_sock_notify, 1024 * 1024, 1024 * 1024));
=
 }
 
 bool
@@ -496,8 +536,12 @@
     nl_socket_free(dco->nl_sock);
     dco=
->nl_sock =3D NULL;
 
+    nl_socket_free(dco->nl_sock_notify);
+    dco->n=
l_sock_notify =3D NULL;
+
     /* Decrease reference count */
     nl_cb_pu=
t(dco->nl_cb);
+    nl_cb_put(dco->nl_cb_notify);
 
     CLEAR(dco);
 }
@@ =
-1165,7 +1209,13 @@
 {
     msg(D_DCO_DEBUG, __func__);
 
-    return ovpn_=
nl_recvmsgs(dco, __func__);
+    /* Drain the multicast notification socket=
=2E This is the only place where
+     * asynchronous notifications (peer d=
el/float, key swap) are processed, so
+     * the multi_close_instance() th=
ey may trigger happens at a safe point in
+     * the event loop rather tha=
n re-entrantly inside a request/reply=2E */
+    int ret =3D nl_recvmsgs(dc=
o->nl_sock_notify, dco->nl_cb_notify);
+
+    return ovpn_nl_recvmsgs_repor=
t(ret, __func__);
 }
 
 static int
@@ -1327,9 +1377,12 @@
 void
 dco_event_=
set(dco_context_t *dco, struct event_set *es, void *arg)
 {
-    if (dco &&=
 dco->nl_sock)
+    if (dco && dco->nl_sock_notify)
     {
-        event_c=
tl(es, nl_socket_get_fd(dco->nl_sock), EVENT_READ, arg);
+        /* Only t=
he notification socket is monitored by the event loop=2E The
+         * re=
quest/reply socket (dco->nl_sock) is drained synchronously by
+         * o=
vpn_nl_msg_send()=2E */
+        event_ctl(es, nl_socket_get_fd(dco->nl_soc=
k_notify), EVENT_READ, arg);
     }
 }
 
diff --git a/src/openvpn/dco_linux=
=2Eh b/src/openvpn/dco_linux=2Eh
index e3e4824=2E=2Ec487581 100644
--- a/sr=
c/openvpn/dco_linux=2Eh
+++ b/src/openvpn/dco_linux=2Eh
@@ -62,8 +62,18 @@
=
 
 typedef struct
 {
+    /* socket used for synchronous request/reply tran=
sactions (commands and
+     * stats queries)=2E It is NOT subscribed to th=
e multicast group, so its
+     * recvmsgs never dispatch an asynchronous n=
otification=2E */
     struct nl_sock *nl_sock;
     struct nl_cb *nl_cb;
+=
    /* socket dedicated to multicast notifications (peer del/float, key swa=
p)=2E
+     * It is read only at the top-level dco_read_and_process() point=
, where it
+     * is safe to close instances=2E Keeping it separate from n=
l_sock prevents
+     * notifications from being processed re-entrantly whi=
le a request/reply is
+     * in flight=2E */
+    struct nl_sock *nl_sock_=
notify;
+    struct nl_cb *nl_cb_notify;
     int status;
 
     struct con=
text *c;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia7894fc360b1=
2c5a0f63fad2abb9bbb1ad9c2bd5
Gerrit-Change-Number: 1737
Gerrit-PatchSet: 3
=
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--U0qPafDiXMk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1737?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">dco_linux: read multicast notifications on=
 a dedicated netlink socket<br><br>ovpn-dco shared a single netlink socket =
for both synchronous<br>request/reply transactions (peer create/delete/get,=
 key operations,<br>stats) and the asynchronous multicast notification grou=
p (peer<br>del/float, key swap)=2E Because every ovpn_nl_msg_send() drains =
its reply<br>with nl_recvmsgs() on that same socket, a notification queued =
by the<br>kernel could be dispatched re-entrantly in the middle of an unrel=
ated<br>request/reply: the NL_CB_VALID handler runs ovpn_handle_msg() -&gt;=
<br>multi_process_incoming_dco() -&gt; multi_close_instance() while the cal=
ler<br>is still walking an instance collection=2E For example multi_print_s=
tatus()<br>refreshes stats with dco_get_peer_stats_multi() and then iterate=
s<br>m-&gt;hash, and multi_delete_dup() iterates m-&gt;instances[] while cl=
osing<br>duplicates; an instance freed underneath either iterator becomes a=
<br>use-after-free and the server crashes (observed under mass simultaneous=
<br>client reconnects)=2E<br><br>Subscribe the multicast group on a dedicat=
ed socket (nl_sock_notify) and<br>read it only from dco_read_and_process(),=
 the top-level event-loop point<br>where closing an instance is safe=2E The=
 request/reply socket is no longer<br>a member of the group, so parsing a c=
ommand or stats reply can never<br>dispatch a notification=2E The event loo=
p now monitors the notification<br>socket; the request/reply socket keeps b=
eing drained synchronously by<br>ovpn_nl_msg_send()=2E<br><br>Change-Id: Ia=
7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5<br>GitHub: closes OpenVPN/openvpn#1=
067<br>GitHub: OpenVPN/openvpn#1111<br>Signed-off-by: Antonio Quartulli &lt=
;antonio=2Equartulli@openvpn=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1737<br>Message-Id: &lt;20260925131417=2E10540-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg39497=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dco_linux=2Ec<br>M src/openvpn/=
dco_linux=2Eh<br>2 files changed, 74 insertions(+), 11 deletions(-)<br><br>=
</pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2E=
c</span><br><span>index 56f6259=2E=2E27f4f99 100644</span><br><span>--- a/s=
rc/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</s=
pan><br><span>@@ -134,12 +134,8 @@</span><br><span> }</span><br><span> </sp=
an><br><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ovpn_nl_recvmsgs_report(int ret, co=
nst char *prefix)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    __is_locked =3D true;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int ret =3D nl_recvmsgs(dco-&gt;nl_sock, dco-&gt;nl_=
cb);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    __is_locked =
=3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span>     switch (ret)</span><br><span>     {</span><br><span>         cas=
e -NLE_INTR:</span><br><span>@@ -174,6 +170,16 @@</span><br><span>     retu=
rn ret;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    __is_locked =3D true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D nl_recvmsgs(dco-&g=
t;nl_sock, dco-&gt;nl_cb);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    __is_locked =3D false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn ovpn_nl_recvmsgs_report(ret, prefix);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> /**</span><br><span>  * Send a prepared netlink mes=
sage=2E</span><br><span>  *</span><br><span>@@ -399,9 +405,11 @@</span><br>=
<span>     }</span><br><span> </span><br><span>     /* Register for ovpn-dc=
o specific multicast messages that the kernel may</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-     * send</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * send=2E These are subscribed on the dedicated no=
tification socket only, so</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * that they are never delivered while a request/reply transacti=
on on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * dco-&gt=
;nl_sock is being parsed=2E</span><br><span>      */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int ret =3D nl_socket_add_membership(dc=
o-&gt;nl_sock, dco-&gt;ovpn_dco_mcast_id);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int ret =3D nl_socket_add_membership(dco-&gt;nl_=
sock_notify, dco-&gt;ovpn_dco_mcast_id);</span><br><span>     if (ret)</spa=
n><br><span>     {</span><br><span>         msg(M_FATAL, &quot;%s: failed t=
o join groups: %d&quot;, __func__, ret);</span><br><span>@@ -450,17 +458,49=
 @@</span><br><span>     nl_cb_set(dco-&gt;nl_cb, NL_CB_ACK, NL_CB_CUSTOM, =
ovpn_nl_cb_finish, &amp;dco-&gt;status);</span><br><span>     nl_cb_set(dco=
-&gt;nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Set up t=
he dedicated multicast notification socket=2E It shares the message</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * handler (ovpn_handle=
_msg) with the request/reply socket, but is read only</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * from dco_read_and_process() in the=
 event loop, so notifications never</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * fire while a request/reply transaction is being pars=
ed=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt=
;nl_sock_notify =3D nl_socket_alloc();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!dco-&gt;nl_sock_notify)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_FATAL, &quot;Cannot create netlink notifi=
cation socket&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D genl_connect(dco-&g=
t;nl_sock_notify);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (ret)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &=
quot;Cannot connect to generic netlink (notify): %s&quot;, nl_geterror(ret)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    set_cloexec(nl_socket_get_fd(dco-&gt;nl_sock_n=
otify));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set_non=
block(nl_socket_get_fd(dco-&gt;nl_sock_notify));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    dco-&gt;nl_cb_notify =3D nl_cb_alloc(NL_CB_DEFAULT);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!dco-&gt;nl_cb_notif=
y)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;fail=
ed to allocate netlink notification callback&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    nl_socket_set_cb(dco-&gt;nl_sock_notify, dco-&gt;nl_cb_notify);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    nl_cb_err(dco-&gt;nl_c=
b_notify, NL_CB_CUSTOM, ovpn_nl_cb_error, &amp;dco-&gt;status);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    nl_cb_set(dco-&gt;nl_cb_not=
ify, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ovpn_dco_register(=
dco);</span><br><span> </span><br><span>     /* The async PACKET messages c=
onfuse libnl and it will drop them with</span><br><span>      * wrong seque=
nce numbers (NLE_SEQ_MISMATCH), so disable libnl&#39;s sequence</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-     * number check */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * number check=2E Multica=
st notifications are unsolicited and likewise carry</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * no matching sequence number, so di=
sable the check on both sockets=2E */</span><br><span>     nl_socket_disabl=
e_seq_check(dco-&gt;nl_sock);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    nl_socket_disable_seq_check(dco-&gt;nl_sock_notify);</span><b=
r><span> </span><br><span>     /* nl library sets the buffer size to 32k/32=
k by default which is sometimes</span><br><span>      * overrun with very f=
ast connecting/disconnecting clients=2E</span><br><span>      * TODO: fix t=
his in a better and more reliable way */</span><br><span>     ASSERT(!nl_so=
cket_set_buffer_size(dco-&gt;nl_sock, 1024 * 1024, 1024 * 1024));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(!nl_socket_set_buf=
fer_size(dco-&gt;nl_sock_notify, 1024 * 1024, 1024 * 1024));</span><br><spa=
n> }</span><br><span> </span><br><span> bool</span><br><span>@@ -496,8 +536=
,12 @@</span><br><span>     nl_socket_free(dco-&gt;nl_sock);</span><br><spa=
n>     dco-&gt;nl_sock =3D NULL;</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    nl_socket_free(dco-&gt;nl_sock_notify);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;nl_sock_=
notify =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     /* Decrease reference count */</span><br><span>     nl_c=
b_put(dco-&gt;nl_cb);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    nl_cb_put(dco-&gt;nl_cb_notify);</span><br><span> </span><br><span>  =
   CLEAR(dco);</span><br><span> }</span><br><span>@@ -1165,7 +1209,13 @@</s=
pan><br><span> {</span><br><span>     msg(D_DCO_DEBUG, __func__);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ov=
pn_nl_recvmsgs(dco, __func__);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* Drain the multicast notification socket=2E This is the on=
ly place where</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* asynchronous notifications (peer del/float, key swap) are processed, so</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the multi_clos=
e_instance() they may trigger happens at a safe point in</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * the event loop rather than re-e=
ntrantly inside a request/reply=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int ret =3D nl_recvmsgs(dco-&gt;nl_sock_notify, dco-&=
gt;nl_cb_notify);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ovpn_nl_re=
cvmsgs_report(ret, __func__);</span><br><span> }</span><br><span> </span><b=
r><span> static int</span><br><span>@@ -1327,9 +1377,12 @@</span><br><span>=
 void</span><br><span> dco_event_set(dco_context_t *dco, struct event_set *=
es, void *arg)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (dco &amp;&amp; dco-&gt;nl_sock)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (dco &amp;&amp; dco-&gt;nl_sock_no=
tify)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        event_ctl(es, nl_socket_get_fd(dco-&gt;nl_sock), EVENT_READ,=
 arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* On=
ly the notification socket is monitored by the event loop=2E The</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         * request/reply socke=
t (dco-&gt;nl_sock) is drained synchronously by</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+         * ovpn_nl_msg_send()=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        event_ctl(es, nl_socket=
_get_fd(dco-&gt;nl_sock_notify), EVENT_READ, arg);</span><br><span>     }</=
span><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvp=
n/dco_linux=2Eh b/src/openvpn/dco_linux=2Eh</span><br><span>index e3e4824=
=2E=2Ec487581 100644</span><br><span>--- a/src/openvpn/dco_linux=2Eh</span>=
<br><span>+++ b/src/openvpn/dco_linux=2Eh</span><br><span>@@ -62,8 +62,18 @=
@</span><br><span> </span><br><span> typedef struct</span><br><span> {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* socket used for s=
ynchronous request/reply transactions (commands and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * stats queries)=2E It is NOT subscr=
ibed to the multicast group, so its</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * recvmsgs never dispatch an asynchronous notification=
=2E */</span><br><span>     struct nl_sock *nl_sock;</span><br><span>     s=
truct nl_cb *nl_cb;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* socket dedicated to multicast notifications (peer del/float, key swa=
p)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * It is r=
ead only at the top-level dco_read_and_process() point, where it</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * is safe to close instan=
ces=2E Keeping it separate from nl_sock prevents</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * notifications from being processed re-e=
ntrantly while a request/reply is</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * in flight=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct nl_sock *nl_sock_notify;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct nl_cb *nl_cb_notify;</span><br=
><span>     int status;</span><br><span> </span><br><span>     struct conte=
xt *c;</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1737?usp=3Demail">change 1737</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1737?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Ia7894fc360b12c5a0f63fad2abb9bb=
b1ad9c2bd5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1737 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"=
display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--U0qPafDiXMk=--


--===============2069155246650536287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2069155246650536287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2069155246650536287==--

