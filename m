Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86031C9830E
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SQWHUvfxpGAXDK5cbjwlxl/xQL4K1B1KScIP+/2+mv0=; b=cG1Hai8cOto0av4aJBUgZoABZn
	SUJA9WFGv5a5MtL6KEsanxqIAiH6kPtGEieY5WZNL6z22BR1P/ieBvKwrYaYOXGl6J93P+xYfC6of
	2EaXzawguhaZ5aia2CoTisPROwOPWY8MmzHVLhJoOvoWHpALyEp0wfdMEZyxwI/pZpLo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA8ZW-0007gr-Sf;
	Fri, 25 Sep 2026 16:14:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA8ZV-0007gi-3R
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 16:14:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jBLKpSCKQhsa9fksbBItViI5ODWZ90+9lkA8+Fmo7JQ=; b=aQL1y8au00M9PC9T7UktUeMzgB
 e5OtC/32lfbgZyNXvqs8yVa8R5MFyxjPMuAkB+Cxa+RvXXg4CEbCZs9hvXHcJ5W+SDmK8tCG3VMZF
 x8FzRO9WFMPusXprVSqdMY/J3VFpbsyLWujvXaQ6KSFbWuUQKjrTujcuglLQycdk9P/I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jBLKpSCKQhsa9fksbBItViI5ODWZ90+9lkA8+Fmo7JQ=; b=M
 fKP8/BKx9qmXYAxc2IHI54Fi5WxNVxv5c3SN8L3OSHqYboL5OWZsE6HcKtbJNGqhQWo1cRZ1ZwLLc
 dV19j95vKD9KV2mzzIDx++0NzlI0AVJXkw2mFi1zc5JpkS4DvbGTXpN2ZqaCofjs6xYdgASHuuzke
 EE6O0ixKCXu3NI9Y=;
Received: from mail-wr2-f37.google.com ([74.125.225.101])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA8ZQ-0002ni-NA for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 16:14:46 +0000
Received: by mail-wr2-f37.google.com with SMTP id
 ffacd0b85a97d-4887840c529so375534f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790352878; x=1790957678; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jBLKpSCKQhsa9fksbBItViI5ODWZ90+9lkA8+Fmo7JQ=;
 b=bS1RLEla3+EpDSN8pRlQCgRhSAJPg2V/wLZK5BYEveP03+nieTLhCJZ3Gulbz78IY/
 LSgkYAGmp/EaaFJqdzTeajCW/kD3y/kL8Nwv1sudOIm9NcwkAiOZLFYjW/PlLBv8aIQr
 uUVNChkJdHv8y9HNvnbSt98jxsHLOjdG76C9bCziW8b0Zjxk4xBiLlEcyqfBo+wyBwLf
 NuutWnJdqQrd9xYOqY+D+f9HXWLwb+dxlbh744m6tsI1r/vX8+dpAjA99OzBUvcQ8lL+
 bA/nX1B6frFy4aVBiqaTdChp8OccM2SCDGNK11BnxfuQZuQ6sUCRXNj57m/+fBX9mpXl
 2Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790352878; x=1790957678;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jBLKpSCKQhsa9fksbBItViI5ODWZ90+9lkA8+Fmo7JQ=;
 b=m/oSTf+k1JmG+uEvDzEWzoCdQiS2NLglGeH5KdY2ow/mdhhBIrYmV1PD2EQqLEfozx
 yKMn78pLvGDSAkhRK/3aP75iRaMICUl9pUQu1c/zcwtyBezPe8dKgnDxFfP+7jazTxb0
 qnYcxp93yHRLQ6pK7IP7hUnCFIrdA8uUdwz1SW2Bi5qQ705CAQ7AzpGWDe7RelnB4xvt
 9ikTMhwi/vkGgg+nsfrTGAiabfkmKDXV5tql3VIfiY/qghQ3m7eurrufeiTkTgGNEfWE
 zOmGyrm0BYZZH9hdZCvpbmKk6HUG3i9F3P+YXe8Ta5MlkapoolJbphBQzJeuvy9Y1CVq
 Ce7A==
X-Gm-Message-State: AFuF++kiNaxNUI+rJnYC1UZ4ktGcBkX1Va0daLVi3bA0NCtsy7+qkZo9
 SJYK3lTdnJn4ekpm68+mOspVKF67lro85WavkYJxE7Fz3s12AKoftYnDLko3p/lNLbRWWoArcan
 c52kCgF7jCkdA15TJcuQJGhHCeb+O8B60GVTUtjsLy/WxIhuPJcnjQDymNoxGEmonxLYl
X-Gm-Gg: AYBFou0HOEuE6snXT7iaJ4uPJUEJPLsbKnigyxFr6aJceu0L0AuOjR4j58viTpvvbH4
 Pywg7INjn5rz3DZnrvYTHoX9BQ2XRC7wT0Pcc9o/FniZfb2NX4gQ1edUx//u2mm2s3poOWHpa2o
 +DQJGVoUq17o0jnZS23IrXm77Ktu+MghfZT8WEYVg5yqDJqfYTE6vit+Ld1bhvpIN3JmBbRhs2g
 1/A80Z+bcWsNMGdRGB76GYygajrcr9/qlEjBXHU/jYeMT/mcblFqnKD2su3FWnbVS+E3pq/JB26
 N74d48hyohzIIXaoPusN/NgjoEOt0aL0moSrwJIQbYZe+wfMSzx1xVbscTLOteQosKyuV6Gm3Ew
 mG2oKU969HqbMidSouJvlHNhLdlDk3qYjb99OusiWxZexGtIUDgw6+WTiDW/dc2/qn3gkGoHwQE
 AdhYJd+XbFLi73MEBhbb9bd1fPzJnkOzUbPQySwQvlxkOgQT4NIpcuzmMZfVBGcPcEITXdVTlGE
 vYtFGkn4mEzgflx1bidpwvlkcORkSA7fvsg5Dkw9tz7R0EdP7G3LwjZfATs9bkZpFSKdqhrfoVp
 fPeVJYA6RL9IOC0dc4lcUNkrXVm3aifbx49xsLxS21LiAQX9iJ2C+WhRoTzu
X-Received: by 2002:a05:600c:c096:b0:49f:f099:6f92 with SMTP id
 5b1f17b1804b1-49ff0997108mr38594445e9.9.1790352877976; 
 Fri, 25 Sep 2026 09:14:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fee6cc7d3sm61283675e9.0.2026.09.25.09.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 09:14:37 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 16:14:36 +0000
To: razvanc <razvanc@mailbox.org>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5
X-Gerrit-Change-Number: 1737
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1737?usp=email>
X-Gerrit-Commit: 08407e0d3c45ab889e6ff4252fc40d778acca149
In-Reply-To: <gerrit.1782693360000.Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5@gerrit.openvpn.net>
References: <gerrit.1782693360000.Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNjkzMzYwMDAwLklhNzg5NGZjMzYwYjEyYzVhMGY2M2ZhZDJhYmI5YmJiMWFkOWMyYmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ae90b547430a55e067cc408ecd628c838fa57bac-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA8ZQ-0002ni-NA
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2903995508302222980=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2903995508302222980==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0SOn1Bjt8do="; charset=UTF-8

--0SOn1Bjt8do=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by razv=
anc


Change subject: dco_linux: read multicast notifications on a dedicate=
d netlink socket
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

dco_linux: read multicast notifications on a dedicated netlink socket
=

ovpn-dco shared a single netlink socket for both synchronous
request/reply=
 transactions (peer create/delete/get, key operations,
stats) and the async=
hronous multicast notification group (peer
del/float, key swap)=2E Because =
every ovpn_nl_msg_send() drains its reply
with nl_recvmsgs() on that same s=
ocket, a notification queued by the
kernel could be dispatched re-entrantly=
 in the middle of an unrelated
request/reply: the NL_CB_VALID handler runs =
ovpn_handle_msg() ->
multi_process_incoming_dco() -> multi_close_instance()=
 while the caller
is still walking an instance collection=2E For example mu=
lti_print_status()
refreshes stats with dco_get_peer_stats_multi() and then=
 iterates
m->hash, and multi_delete_dup() iterates m->instances[] while clo=
sing
duplicates; an instance freed underneath either iterator becomes a
use=
-after-free and the server crashes (observed under mass simultaneous
client=
 reconnects)=2E

Subscribe the multicast group on a dedicated socket (nl_so=
ck_notify) and
read it only from dco_read_and_process(), the top-level even=
t-loop point
where closing an instance is safe=2E The request/reply socket =
is no longer
a member of the group, so parsing a command or stats reply can=
 never
dispatch a notification=2E The event loop now monitors the notificat=
ion
socket; the request/reply socket keeps being drained synchronously by
o=
vpn_nl_msg_send()=2E

Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5
=
GitHub: closes OpenVPN/openvpn#1067
GitHub: OpenVPN/openvpn#1111
Signed-off=
-by: Antonio Quartulli <antonio=2Equartulli@openvpn=2Ecom>
Acked-by: Razvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1737
Message-Id: <20260925131417=2E10540-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg39497=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/dco_linux=2Ec
M src/openvpn/dco_linux=2Eh
2 files =
changed, 74 insertions(+), 11 deletions(-)


  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/37/1737/3

diff --git a/src/openvpn/dc=
o_linux=2Ec b/src/openvpn/dco_linux=2Ec
index 56f6259=2E=2E27f4f99 100644
-=
-- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -134,12 +=
134,8 @@
 }
 
 static int
-ovpn_nl_recvmsgs(dco_context_t *dco, const char =
*prefix)
+ovpn_nl_recvmsgs_report(int ret, const char *prefix)
 {
-    __is=
_locked =3D true;
-    int ret =3D nl_recvmsgs(dco->nl_sock, dco->nl_cb);
-=
    __is_locked =3D false;
-
     switch (ret)
     {
         case -NLE_IN=
TR:
@@ -174,6 +170,16 @@
     return ret;
 }
 
+static int
+ovpn_nl_recvmsg=
s(dco_context_t *dco, const char *prefix)
+{
+    __is_locked =3D true;
+  =
  int ret =3D nl_recvmsgs(dco->nl_sock, dco->nl_cb);
+    __is_locked =3D f=
alse;
+
+    return ovpn_nl_recvmsgs_report(ret, prefix);
+}
+
 /**
  * Sen=
d a prepared netlink message=2E
  *
@@ -399,9 +405,11 @@
     }
 
     /* R=
egister for ovpn-dco specific multicast messages that the kernel may
-     =
* send
+     * send=2E These are subscribed on the dedicated notification s=
ocket only, so
+     * that they are never delivered while a request/reply =
transaction on
+     * dco->nl_sock is being parsed=2E
      */
-    int re=
t =3D nl_socket_add_membership(dco->nl_sock, dco->ovpn_dco_mcast_id);
+    =
int ret =3D nl_socket_add_membership(dco->nl_sock_notify, dco->ovpn_dco_mca=
st_id);
     if (ret)
     {
         msg(M_FATAL, "%s: failed to join grou=
ps: %d", __func__, ret);
@@ -450,17 +458,49 @@
     nl_cb_set(dco->nl_cb, N=
L_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish, &dco->status);
     nl_cb_set(dc=
o->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);
 
+    /* Set u=
p the dedicated multicast notification socket=2E It shares the message
+   =
  * handler (ovpn_handle_msg) with the request/reply socket, but is read on=
ly
+     * from dco_read_and_process() in the event loop, so notifications =
never
+     * fire while a request/reply transaction is being parsed=2E */
=
+    dco->nl_sock_notify =3D nl_socket_alloc();
+    if (!dco->nl_sock_noti=
fy)
+    {
+        msg(M_FATAL, "Cannot create netlink notification socket=
");
+    }
+
+    ret =3D genl_connect(dco->nl_sock_notify);
+    if (ret)
=
+    {
+        msg(M_FATAL, "Cannot connect to generic netlink (notify): %=
s", nl_geterror(ret));
+    }
+
+    set_cloexec(nl_socket_get_fd(dco->nl_s=
ock_notify));
+    set_nonblock(nl_socket_get_fd(dco->nl_sock_notify));
+
+=
    dco->nl_cb_notify =3D nl_cb_alloc(NL_CB_DEFAULT);
+    if (!dco->nl_cb_=
notify)
+    {
+        msg(M_FATAL, "failed to allocate netlink notificati=
on callback");
+    }
+
+    nl_socket_set_cb(dco->nl_sock_notify, dco->nl_=
cb_notify);
+    nl_cb_err(dco->nl_cb_notify, NL_CB_CUSTOM, ovpn_nl_cb_erro=
r, &dco->status);
+    nl_cb_set(dco->nl_cb_notify, NL_CB_VALID, NL_CB_CUST=
OM, ovpn_handle_msg, dco);
+
     ovpn_dco_register(dco);
 
     /* The asy=
nc PACKET messages confuse libnl and it will drop them with
      * wrong s=
equence numbers (NLE_SEQ_MISMATCH), so disable libnl's sequence
-     * num=
ber check */
+     * number check=2E Multicast notifications are unsolicite=
d and likewise carry
+     * no matching sequence number, so disable the ch=
eck on both sockets=2E */
     nl_socket_disable_seq_check(dco->nl_sock);
+=
    nl_socket_disable_seq_check(dco->nl_sock_notify);
 
     /* nl library =
sets the buffer size to 32k/32k by default which is sometimes
      * overr=
un with very fast connecting/disconnecting clients=2E
      * TODO: fix thi=
s in a better and more reliable way */
     ASSERT(!nl_socket_set_buffer_si=
ze(dco->nl_sock, 1024 * 1024, 1024 * 1024));
+    ASSERT(!nl_socket_set_buf=
fer_size(dco->nl_sock_notify, 1024 * 1024, 1024 * 1024));
 }
 
 bool
@@ -49=
6,8 +536,12 @@
     nl_socket_free(dco->nl_sock);
     dco->nl_sock =3D NUL=
L;
 
+    nl_socket_free(dco->nl_sock_notify);
+    dco->nl_sock_notify =3D=
 NULL;
+
     /* Decrease reference count */
     nl_cb_put(dco->nl_cb);
+ =
   nl_cb_put(dco->nl_cb_notify);
 
     CLEAR(dco);
 }
@@ -1165,7 +1209,13 =
@@
 {
     msg(D_DCO_DEBUG, __func__);
 
-    return ovpn_nl_recvmsgs(dco, =
__func__);
+    /* Drain the multicast notification socket=2E This is the o=
nly place where
+     * asynchronous notifications (peer del/float, key swa=
p) are processed, so
+     * the multi_close_instance() they may trigger ha=
ppens at a safe point in
+     * the event loop rather than re-entrantly in=
side a request/reply=2E */
+    int ret =3D nl_recvmsgs(dco->nl_sock_notify=
, dco->nl_cb_notify);
+
+    return ovpn_nl_recvmsgs_report(ret, __func__);=

 }
 
 static int
@@ -1327,9 +1377,12 @@
 void
 dco_event_set(dco_context_t=
 *dco, struct event_set *es, void *arg)
 {
-    if (dco && dco->nl_sock)
+ =
   if (dco && dco->nl_sock_notify)
     {
-        event_ctl(es, nl_socket_=
get_fd(dco->nl_sock), EVENT_READ, arg);
+        /* Only the notification s=
ocket is monitored by the event loop=2E The
+         * request/reply socke=
t (dco->nl_sock) is drained synchronously by
+         * ovpn_nl_msg_send()=
=2E */
+        event_ctl(es, nl_socket_get_fd(dco->nl_sock_notify), EVENT_=
READ, arg);
     }
 }
 
diff --git a/src/openvpn/dco_linux=2Eh b/src/openvp=
n/dco_linux=2Eh
index e3e4824=2E=2Ec487581 100644
--- a/src/openvpn/dco_lin=
ux=2Eh
+++ b/src/openvpn/dco_linux=2Eh
@@ -62,8 +62,18 @@
 
 typedef struct=

 {
+    /* socket used for synchronous request/reply transactions (command=
s and
+     * stats queries)=2E It is NOT subscribed to the multicast group=
, so its
+     * recvmsgs never dispatch an asynchronous notification=2E */=

     struct nl_sock *nl_sock;
     struct nl_cb *nl_cb;
+    /* socket ded=
icated to multicast notifications (peer del/float, key swap)=2E
+     * It =
is read only at the top-level dco_read_and_process() point, where it
+     =
* is safe to close instances=2E Keeping it separate from nl_sock prevents
+=
     * notifications from being processed re-entrantly while a request/repl=
y is
+     * in flight=2E */
+    struct nl_sock *nl_sock_notify;
+    stru=
ct nl_cb *nl_cb_notify;
     int status;
 
     struct context *c;

-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia7894fc360b12c5a0f63fad2=
abb9bbb1ad9c2bd5
Gerrit-Change-Number: 1737
Gerrit-PatchSet: 3
Gerrit-Owner=
: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--0SOn1Bjt8do=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by ordex=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">dco_linux: read multicast notif=
ications on a dedicated netlink socket<br><br>ovpn-dco shared a single netl=
ink socket for both synchronous<br>request/reply transactions (peer create/=
delete/get, key operations,<br>stats) and the asynchronous multicast notifi=
cation group (peer<br>del/float, key swap)=2E Because every ovpn_nl_msg_sen=
d() drains its reply<br>with nl_recvmsgs() on that same socket, a notificat=
ion queued by the<br>kernel could be dispatched re-entrantly in the middle =
of an unrelated<br>request/reply: the NL_CB_VALID handler runs ovpn_handle_=
msg() -&gt;<br>multi_process_incoming_dco() -&gt; multi_close_instance() wh=
ile the caller<br>is still walking an instance collection=2E For example mu=
lti_print_status()<br>refreshes stats with dco_get_peer_stats_multi() and t=
hen iterates<br>m-&gt;hash, and multi_delete_dup() iterates m-&gt;instances=
[] while closing<br>duplicates; an instance freed underneath either iterato=
r becomes a<br>use-after-free and the server crashes (observed under mass s=
imultaneous<br>client reconnects)=2E<br><br>Subscribe the multicast group o=
n a dedicated socket (nl_sock_notify) and<br>read it only from dco_read_and=
_process(), the top-level event-loop point<br>where closing an instance is =
safe=2E The request/reply socket is no longer<br>a member of the group, so =
parsing a command or stats reply can never<br>dispatch a notification=2E Th=
e event loop now monitors the notification<br>socket; the request/reply soc=
ket keeps being drained synchronously by<br>ovpn_nl_msg_send()=2E<br><br>Ch=
ange-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5<br>GitHub: closes OpenVP=
N/openvpn#1067<br>GitHub: OpenVPN/openvpn#1111<br>Signed-off-by: Antonio Qu=
artulli &lt;antonio=2Equartulli@openvpn=2Ecom&gt;<br>Acked-by: Razvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1737<br>Message-Id: &lt;20260925131417=2E10540-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg39497=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dco_linux=2Ec<br>M s=
rc/openvpn/dco_linux=2Eh<br>2 files changed, 74 insertions(+), 11 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/37/1737/3</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_linux=
=2Ec b/src/openvpn/dco_linux=2Ec</span><br><span>index 56f6259=2E=2E27f4f99=
 100644</span><br><span>--- a/src/openvpn/dco_linux=2Ec</span><br><span>+++=
 b/src/openvpn/dco_linux=2Ec</span><br><span>@@ -134,12 +134,8 @@</span><br=
><span> }</span><br><span> </span><br><span> static int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-ovpn_nl_recvmsgs(dco_context_t *dco, cons=
t char *prefix)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn=
_nl_recvmsgs_report(int ret, const char *prefix)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    __is_locked =3D true;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D nl_recvms=
gs(dco-&gt;nl_sock, dco-&gt;nl_cb);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    __is_locked =3D false;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span>     switch (ret)</span><br><span>     =
{</span><br><span>         case -NLE_INTR:</span><br><span>@@ -174,6 +170,1=
6 @@</span><br><span>     return ret;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_nl_recvmsgs(dco_context_=
t *dco, const char *prefix)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    __is_l=
ocked =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int ret =3D nl_recvmsgs(dco-&gt;nl_sock, dco-&gt;nl_cb);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    __is_locked =3D false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return ovpn_nl_recvmsgs_report(ret, prefix);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span> =
 * Send a prepared netlink message=2E</span><br><span>  *</span><br><span>@=
@ -399,9 +405,11 @@</span><br><span>     }</span><br><span> </span><br><spa=
n>     /* Register for ovpn-dco specific multicast messages that the kernel=
 may</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * send</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * send=2E These are =
subscribed on the dedicated notification socket only, so</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * that they are never delivered w=
hile a request/reply transaction on</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * dco-&gt;nl_sock is being parsed=2E</span><br><span> =
     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =
=3D nl_socket_add_membership(dco-&gt;nl_sock, dco-&gt;ovpn_dco_mcast_id);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D nl_so=
cket_add_membership(dco-&gt;nl_sock_notify, dco-&gt;ovpn_dco_mcast_id);</sp=
an><br><span>     if (ret)</span><br><span>     {</span><br><span>         =
msg(M_FATAL, &quot;%s: failed to join groups: %d&quot;, __func__, ret);</sp=
an><br><span>@@ -450,17 +458,49 @@</span><br><span>     nl_cb_set(dco-&gt;n=
l_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish, &amp;dco-&gt;status);</sp=
an><br><span>     nl_cb_set(dco-&gt;nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_=
handle_msg, dco);</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* Set up the dedicated multicast notification socket=
=2E It shares the message</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * handler (ovpn_handle_msg) with the request/reply socket, but i=
s read only</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * f=
rom dco_read_and_process() in the event loop, so notifications never</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * fire while a reques=
t/reply transaction is being parsed=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    dco-&gt;nl_sock_notify =3D nl_socket_alloc();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!dco-&gt;nl_soc=
k_notify)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &qu=
ot;Cannot create netlink notification socket&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ret =3D genl_connect(dco-&gt;nl_sock_notify);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (ret)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(M_FATAL, &quot;Cannot connect to generic netlink (not=
ify): %s&quot;, nl_geterror(ret));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set_cloexec(nl=
_socket_get_fd(dco-&gt;nl_sock_notify));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    set_nonblock(nl_socket_get_fd(dco-&gt;nl_sock_noti=
fy));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;nl_cb_notify =3D nl_c=
b_alloc(NL_CB_DEFAULT);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!dco-&gt;nl_cb_notify)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        msg(M_FATAL, &quot;failed to allocate netlink notification callbac=
k&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    nl_socket_set_cb(dco-&gt;nl_sock_noti=
fy, dco-&gt;nl_cb_notify);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    nl_cb_err(dco-&gt;nl_cb_notify, NL_CB_CUSTOM, ovpn_nl_cb_error, =
&amp;dco-&gt;status);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    nl_cb_set(dco-&gt;nl_cb_notify, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handl=
e_msg, dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     ovpn_dco_register(dco);</span><br><span> </span><br><span>  =
   /* The async PACKET messages confuse libnl and it will drop them with</s=
pan><br><span>      * wrong sequence numbers (NLE_SEQ_MISMATCH), so disable=
 libnl&#39;s sequence</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     * number check */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * number check=2E Multicast notifications are unsolicited and likew=
ise carry</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * no =
matching sequence number, so disable the check on both sockets=2E */</span>=
<br><span>     nl_socket_disable_seq_check(dco-&gt;nl_sock);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    nl_socket_disable_seq_check(dc=
o-&gt;nl_sock_notify);</span><br><span> </span><br><span>     /* nl library=
 sets the buffer size to 32k/32k by default which is sometimes</span><br><s=
pan>      * overrun with very fast connecting/disconnecting clients=2E</spa=
n><br><span>      * TODO: fix this in a better and more reliable way */</sp=
an><br><span>     ASSERT(!nl_socket_set_buffer_size(dco-&gt;nl_sock, 1024 *=
 1024, 1024 * 1024));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ASSERT(!nl_socket_set_buffer_size(dco-&gt;nl_sock_notify, 1024 * 1024=
, 1024 * 1024));</span><br><span> }</span><br><span> </span><br><span> bool=
</span><br><span>@@ -496,8 +536,12 @@</span><br><span>     nl_socket_free(d=
co-&gt;nl_sock);</span><br><span>     dco-&gt;nl_sock =3D NULL;</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nl_socket=
_free(dco-&gt;nl_sock_notify);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    dco-&gt;nl_sock_notify =3D NULL;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>     /* Decrease reference cou=
nt */</span><br><span>     nl_cb_put(dco-&gt;nl_cb);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    nl_cb_put(dco-&gt;nl_cb_notify);</spa=
n><br><span> </span><br><span>     CLEAR(dco);</span><br><span> }</span><br=
><span>@@ -1165,7 +1209,13 @@</span><br><span> {</span><br><span>     msg(D=
_DCO_DEBUG, __func__);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return ovpn_nl_recvmsgs(dco, __func__);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* Drain the multicast notif=
ication socket=2E This is the only place where</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * asynchronous notifications (peer del/floa=
t, key swap) are processed, so</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * the multi_close_instance() they may trigger happens at a =
safe point in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 the event loop rather than re-entrantly inside a request/reply=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D nl_recvms=
gs(dco-&gt;nl_sock_notify, dco-&gt;nl_cb_notify);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return ovpn_nl_recvmsgs_report(ret, __func__);</span><br><sp=
an> }</span><br><span> </span><br><span> static int</span><br><span>@@ -132=
7,9 +1377,12 @@</span><br><span> void</span><br><span> dco_event_set(dco_co=
ntext_t *dco, struct event_set *es, void *arg)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (dco &amp;&amp; dco-&gt;=
nl_sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco=
 &amp;&amp; dco-&gt;nl_sock_notify)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        event_ctl(es, nl_socket_get_fd=
(dco-&gt;nl_sock), EVENT_READ, arg);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* Only the notification socket is monitored by th=
e event loop=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
         * request/reply socket (dco-&gt;nl_sock) is drained synchronously =
by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * ovpn_n=
l_msg_send()=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       event_ctl(es, nl_socket_get_fd(dco-&gt;nl_sock_notify), EVENT_READ, =
arg);</span><br><span>     }</span><br><span> }</span><br><span> </span><br=
><span>diff --git a/src/openvpn/dco_linux=2Eh b/src/openvpn/dco_linux=2Eh</=
span><br><span>index e3e4824=2E=2Ec487581 100644</span><br><span>--- a/src/=
openvpn/dco_linux=2Eh</span><br><span>+++ b/src/openvpn/dco_linux=2Eh</span=
><br><span>@@ -62,8 +62,18 @@</span><br><span> </span><br><span> typedef st=
ruct</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* socket used for synchronous request/reply transactions (commands=
 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * stats qu=
eries)=2E It is NOT subscribed to the multicast group, so its</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * recvmsgs never dispatch an=
 asynchronous notification=2E */</span><br><span>     struct nl_sock *nl_so=
ck;</span><br><span>     struct nl_cb *nl_cb;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* socket dedicated to multicast notification=
s (peer del/float, key swap)=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * It is read only at the top-level dco_read_and_process() =
point, where it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * is safe to close instances=2E Keeping it separate from nl_sock prevents<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * notifications=
 from being processed re-entrantly while a request/reply is</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * in flight=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct nl_sock *nl_sock_noti=
fy;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nl_cb=
 *nl_cb_notify;</span><br><span>     int status;</span><br><span> </span><b=
r><span>     struct context *c;</span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737?usp=3Demail">change 1737=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
a7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1737 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antoni=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>

</body></html>
--0SOn1Bjt8do=--


--===============2903995508302222980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2903995508302222980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2903995508302222980==--

