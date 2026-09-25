Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D8AC9830E
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 13:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FUZDcTqKzeTM7djOCGYuK4K3Q4TvaIg/lzK2rqVWBjM=; b=O/vSSIA7Yb4W7lD0q/Is2VI/Hg
	FEUvAqBRZUJKru4jLYNI2RfNazX6iP/eb1NrsBammHhbWLtTvytUP41PrffiyBJzAHAnpG8+d3QHT
	Aod4NMSu5SU6qkymNOzt55oKG8RTMvjim2iOniMvE1/NQZW+NcrsKDoS0PTOyNGt4Uqw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA5cD-00035x-H7;
	Fri, 25 Sep 2026 13:05:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA5cC-00035r-Nb
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 13:05:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8zWrKufADygG9AVrfRA2UK1J2DNL95zEI0hNqX5SDds=; b=hexDK9Fgc5uzTM8dDFQc6ktBRQ
 hq19cqftmrmNpHv0q/fo2OXa97j1Eo/RoR6gYz27WM6DwjSr2Y0oUEHYpgVxBaKNpRKelk5N7LSRo
 KQCRbl28DCuU/4+dUpkAs58N2OB8lq4FBrmm0Yr1ilMeUQl4a4lqNjhFOwKTm6KzPQnI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8zWrKufADygG9AVrfRA2UK1J2DNL95zEI0hNqX5SDds=; b=c
 Vfq8YldXnKhL8K1q/Z+Rw/psDZvPYXwuetWAKUp2c5+OK+Qs/nSzvQUrv5j2MIcDFzrupxvRS69Ei
 qa2GnCwCFY9l4MusjrYsP67uTrVB0uvIgX+xyKSRIfGz+qyaiZfbZSF1irGXcrze8ehvu1nlVlnd3
 1Vxn5i7fSvU2Qpu0=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA5c8-0007Fr-93 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 13:05:22 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso11388545e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 06:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790341514; x=1790946314; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8zWrKufADygG9AVrfRA2UK1J2DNL95zEI0hNqX5SDds=;
 b=SRc2hkI7d6YkRFMgyJW+KesNI9Y0OGzH54PFCPZ1AaqbctcGsM/7DyUqNd1l2SP8yN
 kHCmRsWRnkvtRJDncVn41IFotx6O+0fIZ6sHmnZEbexRRyffOa4TFkun/t0KPK4TjmLd
 0sxIPVALr5+Ba071U+rfoLtdxc1V8dFS3yZoee8u+KEAvUQFEvRj6BPTh/J1Vg3up7hf
 PUx3K2BHnV8vNaA5B1pwyn+u0D0D2hnlyhDfgDjt73NRY3pK2C/LpbraU9R0KTYeec3e
 fDfltO9NM/hr0hgE6RyQ/zvzRJiK/c8d9D7fuTcXNwaWR1NSPcJVlKIBGRU3raLffoHv
 pEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790341514; x=1790946314;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8zWrKufADygG9AVrfRA2UK1J2DNL95zEI0hNqX5SDds=;
 b=p21Wr7KPGyGGyxbQ16hYdGLYbNmInUd/4hXGyCUR0dCzahCIQbIuq0iUTuBMHE9vwx
 r7xMl35MZ9ISdzS5fLr8UTxcL4ws2RDpd/z+7r7pSROg9hyIBtsbormSdJnZ9fMNmRVs
 6wHcE+Sh4cEK+K4n9I4fIJdd6ZY/p20dAs6I61qNQhkAh63Re8wONxdsS0wb68aMJ8mp
 CgWR8DR71igiLJS6akoAc5W8OFBQe7Z4DKyE7VnKr629Jf5G/2NahHt1BiU2dqe+TgX0
 etsuPffFxz8xs+WgDiLALxTXPTct6QBIlWB29ShfkHnK9MstCn1LUdea3N4/DbVTzYS5
 /f9Q==
X-Gm-Message-State: AFuF++lRBzHdKIN/jiE5T/rm8HRnW2i1tyIi2rAR3gFGs1bAvmQhgq8p
 Tm8Jj2rEmNmdGIfyz7v341KDMn8h4WBij3tpvlA1jGToMPUrJw3+Y0ZBgbydiDSCRZvzS6RrxjQ
 RLtcrhuNAq+3dvRJCBFoYoJC7GI7FLfi+Dnun/7P0M6p24SK4hDDBjvHbPfGQI/Luvu8p
X-Gm-Gg: AYBFou3DrpQ/F9Fstdo7MpxqeeJ28Xd0wp47lRMfvme8EzJo4UQHI5GNnK57FXU6Gla
 Lk2l2JwlKexRvKKlD8budJygitc8e3W6nkhKMJQCTU+i1zIa4KTyVqAMrR/Se9M26+g2I0pFBe3
 Azsoiwj6aWZBSYjUk/74stLya87cXvPPyuUXRoaAG5FGQoMvWXIyRZOS9mnVIytTwsOfIZrxZ19
 yvtFBUfVHUdth+QACZ5EYe/Pn8n8jLV248Dj74VdQ+pvMvi1Xa2ohFAtIioTxQbLr55M4DabfMT
 o1k8TnSox7s8W+43IAfJRenOCpWWqKwO8iVQduL8/ddRBXOpJ7z41LS8plJpdinvqKyAEQRfwR1
 bmmBkKrqUEr5SEialjQ87Pzw5DGROopyJxALBmPmDatUTChsr8YagmdIdNKAx3o1p5VNjXRl2+d
 KmULM7q6EJEvxoTV5Dt42kdt2APF29SwPm2ubG48HB9pc8/XT1P0ImyizmJfgv6UmDuNtA+tWgC
 lgj4sLmnDrsS4sW6TzgE27/boFLHhawu+C7hLYAFZIJ8P2HZS9R4SqPy8bufmyly/yjfqxbNnkv
 DqwQk73oqjp1DG5xTiUNagYoAO+VPiXnyOqxo7ZLAsa9yohoCHSC2hn+8KFVtz84tPnA2hw=
X-Received: by 2002:a05:600c:1d1c:b0:49f:bd3c:bc28 with SMTP id
 5b1f17b1804b1-49fe6712809mr107309985e9.35.1790341513441; 
 Fri, 25 Sep 2026 06:05:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff42b7074sm32306485e9.6.2026.09.25.06.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:05:12 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 13:05:10 +0000
To: razvanc <razvanc@mailbox.org>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5
X-Gerrit-Change-Number: 1737
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1737?usp=email>
X-Gerrit-Commit: 23cbacde0afc425938af3171111cdefde5651c62
In-Reply-To: <gerrit.1782693360000.Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5@gerrit.openvpn.net>
References: <gerrit.1782693360000.Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNjkzMzYwMDAwLklhNzg5NGZjMzYwYjEyYzVhMGY2M2ZhZDJhYmI5YmJiMWFkOWMyYmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c1deafa8f0594d2f14aec9bc4bde0802d5226a80-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA5c8-0007Fr-93
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7134181450916112853=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7134181450916112853==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YNzpk4piKe0="; charset=UTF-8

--YNzpk4piKe0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

Hello plaisthos,=
 razvanc, 

I'd like you to reexamine a change=2E Please visit

    http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737?usp=3Demail

to look at the new pat=
ch set (#2)=2E

The change is no longer submittable: checks~ChecksSubmitRul=
e is unsatisfied now=2E


Change subject: dco_linux: read multicast notific=
ations on a dedicated netlink socket
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

dco_linux: read multicast notifications on a dedi=
cated netlink socket

ovpn-dco shared a single netlink socket for both sync=
hronous
request/reply transactions (peer create/delete/get, key operations,=

stats) and the asynchronous multicast notification group (peer
del/float, =
key swap)=2E Because every ovpn_nl_msg_send() drains its reply
with nl_recv=
msgs() on that same socket, a notification queued by the
kernel could be di=
spatched re-entrantly in the middle of an unrelated
request/reply: the NL_C=
B_VALID handler runs ovpn_handle_msg() ->
multi_process_incoming_dco() -> m=
ulti_close_instance() while the caller
is still walking an instance collect=
ion=2E For example multi_print_status()
refreshes stats with dco_get_peer_s=
tats_multi() and then iterates
m->hash, and multi_delete_dup() iterates m->=
instances[] while closing
duplicates; an instance freed underneath either i=
terator becomes a
use-after-free and the server crashes (observed under mas=
s simultaneous
client reconnects)=2E

Subscribe the multicast group on a de=
dicated socket (nl_sock_notify) and
read it only from dco_read_and_process(=
), the top-level event-loop point
where closing an instance is safe=2E The =
request/reply socket is no longer
a member of the group, so parsing a comma=
nd or stats reply can never
dispatch a notification=2E The event loop now m=
onitors the notification
socket; the request/reply socket keeps being drain=
ed synchronously by
ovpn_nl_msg_send()=2E

Change-Id: Ia7894fc360b12c5a0f63=
fad2abb9bbb1ad9c2bd5
GitHub: closes OpenVPN/openvpn#1067
Signed-off-by: Ant=
onio Quartulli <antonio=2Equartulli@openvpn=2Ecom>
---
M src/openvpn/dco_li=
nux=2Ec
M src/openvpn/dco_linux=2Eh
2 files changed, 74 insertions(+), 11 d=
eletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/37/1737/2

diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_l=
inux=2Ec
index 56f6259=2E=2E27f4f99 100644
--- a/src/openvpn/dco_linux=2Ec
=
+++ b/src/openvpn/dco_linux=2Ec
@@ -134,12 +134,8 @@
 }
 
 static int
-ovpn=
_nl_recvmsgs(dco_context_t *dco, const char *prefix)
+ovpn_nl_recvmsgs_repo=
rt(int ret, const char *prefix)
 {
-    __is_locked =3D true;
-    int ret =
=3D nl_recvmsgs(dco->nl_sock, dco->nl_cb);
-    __is_locked =3D false;
-
  =
   switch (ret)
     {
         case -NLE_INTR:
@@ -174,6 +170,16 @@
     r=
eturn ret;
 }
 
+static int
+ovpn_nl_recvmsgs(dco_context_t *dco, const cha=
r *prefix)
+{
+    __is_locked =3D true;
+    int ret =3D nl_recvmsgs(dco->=
nl_sock, dco->nl_cb);
+    __is_locked =3D false;
+
+    return ovpn_nl_rec=
vmsgs_report(ret, prefix);
+}
+
 /**
  * Send a prepared netlink message=2E=

  *
@@ -399,9 +405,11 @@
     }
 
     /* Register for ovpn-dco specific m=
ulticast messages that the kernel may
-     * send
+     * send=2E These ar=
e subscribed on the dedicated notification socket only, so
+     * that the=
y are never delivered while a request/reply transaction on
+     * dco->nl_=
sock is being parsed=2E
      */
-    int ret =3D nl_socket_add_membership(=
dco->nl_sock, dco->ovpn_dco_mcast_id);
+    int ret =3D nl_socket_add_membe=
rship(dco->nl_sock_notify, dco->ovpn_dco_mcast_id);
     if (ret)
     {
  =
       msg(M_FATAL, "%s: failed to join groups: %d", __func__, ret);
@@ -45=
0,17 +458,49 @@
     nl_cb_set(dco->nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl=
_cb_finish, &dco->status);
     nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CU=
STOM, ovpn_handle_msg, dco);
 
+    /* Set up the dedicated multicast notif=
ication socket=2E It shares the message
+     * handler (ovpn_handle_msg) w=
ith the request/reply socket, but is read only
+     * from dco_read_and_pr=
ocess() in the event loop, so notifications never
+     * fire while a requ=
est/reply transaction is being parsed=2E */
+    dco->nl_sock_notify =3D nl=
_socket_alloc();
+    if (!dco->nl_sock_notify)
+    {
+        msg(M_FATAL=
, "Cannot create netlink notification socket");
+    }
+
+    ret =3D genl_=
connect(dco->nl_sock_notify);
+    if (ret)
+    {
+        msg(M_FATAL, "C=
annot connect to generic netlink (notify): %s", nl_geterror(ret));
+    }
+=

+    set_cloexec(nl_socket_get_fd(dco->nl_sock_notify));
+    set_nonblock=
(nl_socket_get_fd(dco->nl_sock_notify));
+
+    dco->nl_cb_notify =3D nl_cb=
_alloc(NL_CB_DEFAULT);
+    if (!dco->nl_cb_notify)
+    {
+        msg(M_F=
ATAL, "failed to allocate netlink notification callback");
+    }
+
+    nl=
_socket_set_cb(dco->nl_sock_notify, dco->nl_cb_notify);
+    nl_cb_err(dco-=
>nl_cb_notify, NL_CB_CUSTOM, ovpn_nl_cb_error, &dco->status);
+    nl_cb_se=
t(dco->nl_cb_notify, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);
+
  =
   ovpn_dco_register(dco);
 
     /* The async PACKET messages confuse libn=
l and it will drop them with
      * wrong sequence numbers (NLE_SEQ_MISMAT=
CH), so disable libnl's sequence
-     * number check */
+     * number che=
ck=2E Multicast notifications are unsolicited and likewise carry
+     * no=
 matching sequence number, so disable the check on both sockets=2E */
     =
nl_socket_disable_seq_check(dco->nl_sock);
+    nl_socket_disable_seq_check=
(dco->nl_sock_notify);
 
     /* nl library sets the buffer size to 32k/32k=
 by default which is sometimes
      * overrun with very fast connecting/di=
sconnecting clients=2E
      * TODO: fix this in a better and more reliable=
 way */
     ASSERT(!nl_socket_set_buffer_size(dco->nl_sock, 1024 * 1024, 1=
024 * 1024));
+    ASSERT(!nl_socket_set_buffer_size(dco->nl_sock_notify, 1=
024 * 1024, 1024 * 1024));
 }
 
 bool
@@ -496,8 +536,12 @@
     nl_socket_f=
ree(dco->nl_sock);
     dco->nl_sock =3D NULL;
 
+    nl_socket_free(dco->n=
l_sock_notify);
+    dco->nl_sock_notify =3D NULL;
+
     /* Decrease refer=
ence count */
     nl_cb_put(dco->nl_cb);
+    nl_cb_put(dco->nl_cb_notify)=
;
 
     CLEAR(dco);
 }
@@ -1165,7 +1209,13 @@
 {
     msg(D_DCO_DEBUG, __f=
unc__);
 
-    return ovpn_nl_recvmsgs(dco, __func__);
+    /* Drain the mu=
lticast notification socket=2E This is the only place where
+     * asynchr=
onous notifications (peer del/float, key swap) are processed, so
+     * th=
e multi_close_instance() they may trigger happens at a safe point in
+     =
* the event loop rather than re-entrantly inside a request/reply=2E */
+   =
 int ret =3D nl_recvmsgs(dco->nl_sock_notify, dco->nl_cb_notify);
+
+    re=
turn ovpn_nl_recvmsgs_report(ret, __func__);
 }
 
 static int
@@ -1327,9 +1=
377,12 @@
 void
 dco_event_set(dco_context_t *dco, struct event_set *es, vo=
id *arg)
 {
-    if (dco && dco->nl_sock)
+    if (dco && dco->nl_sock_noti=
fy)
     {
-        event_ctl(es, nl_socket_get_fd(dco->nl_sock), EVENT_REA=
D, arg);
+        /* Only the notification socket is monitored by the event=
 loop=2E The
+         * request/reply socket (dco->nl_sock) is drained syn=
chronously by
+         * ovpn_nl_msg_send()=2E */
+        event_ctl(es, n=
l_socket_get_fd(dco->nl_sock_notify), EVENT_READ, arg);
     }
 }
 
diff --=
git a/src/openvpn/dco_linux=2Eh b/src/openvpn/dco_linux=2Eh
index e3e4824=
=2E=2Ec487581 100644
--- a/src/openvpn/dco_linux=2Eh
+++ b/src/openvpn/dco_=
linux=2Eh
@@ -62,8 +62,18 @@
 
 typedef struct
 {
+    /* socket used for s=
ynchronous request/reply transactions (commands and
+     * stats queries)=
=2E It is NOT subscribed to the multicast group, so its
+     * recvmsgs ne=
ver dispatch an asynchronous notification=2E */
     struct nl_sock *nl_soc=
k;
     struct nl_cb *nl_cb;
+    /* socket dedicated to multicast notifica=
tions (peer del/float, key swap)=2E
+     * It is read only at the top-leve=
l dco_read_and_process() point, where it
+     * is safe to close instances=
=2E Keeping it separate from nl_sock prevents
+     * notifications from be=
ing processed re-entrantly while a request/reply is
+     * in flight=2E */=

+    struct nl_sock *nl_sock_notify;
+    struct nl_cb *nl_cb_notify;
    =
 int status;
 
     struct context *c;

-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1737?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5
Gerrit-Chan=
ge-Number: 1737
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: ordex <antonio@mandelbit=2E=
com>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--YNzpk4piKe0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>ordex <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1737?usp=3Demail">View Change</a></p><p>The change is=
 no longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">dco_linux: read multicast notifications on a dedicated netlink =
socket<br><br>ovpn-dco shared a single netlink socket for both synchronous<=
br>request/reply transactions (peer create/delete/get, key operations,<br>s=
tats) and the asynchronous multicast notification group (peer<br>del/float,=
 key swap)=2E Because every ovpn_nl_msg_send() drains its reply<br>with nl_=
recvmsgs() on that same socket, a notification queued by the<br>kernel coul=
d be dispatched re-entrantly in the middle of an unrelated<br>request/reply=
: the NL_CB_VALID handler runs ovpn_handle_msg() -&gt;<br>multi_process_inc=
oming_dco() -&gt; multi_close_instance() while the caller<br>is still walki=
ng an instance collection=2E For example multi_print_status()<br>refreshes =
stats with dco_get_peer_stats_multi() and then iterates<br>m-&gt;hash, and =
multi_delete_dup() iterates m-&gt;instances[] while closing<br>duplicates; =
an instance freed underneath either iterator becomes a<br>use-after-free an=
d the server crashes (observed under mass simultaneous<br>client reconnects=
)=2E<br><br>Subscribe the multicast group on a dedicated socket (nl_sock_no=
tify) and<br>read it only from dco_read_and_process(), the top-level event-=
loop point<br>where closing an instance is safe=2E The request/reply socket=
 is no longer<br>a member of the group, so parsing a command or stats reply=
 can never<br>dispatch a notification=2E The event loop now monitors the no=
tification<br>socket; the request/reply socket keeps being drained synchron=
ously by<br>ovpn_nl_msg_send()=2E<br><br>Change-Id: Ia7894fc360b12c5a0f63fa=
d2abb9bbb1ad9c2bd5<br>GitHub: closes OpenVPN/openvpn#1067<br>Signed-off-by:=
 Antonio Quartulli &lt;antonio=2Equartulli@openvpn=2Ecom&gt;<br>---<br>M sr=
c/openvpn/dco_linux=2Ec<br>M src/openvpn/dco_linux=2Eh<br>2 files changed, =
74 insertions(+), 11 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/1737/2</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><sp=
an>index 56f6259=2E=2E27f4f99 100644</span><br><span>--- a/src/openvpn/dco_=
linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br><span>@=
@ -134,12 +134,8 @@</span><br><span> }</span><br><span> </span><br><span> s=
tatic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_nl_recv=
msgs(dco_context_t *dco, const char *prefix)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ovpn_nl_recvmsgs_report(int ret, const char *prefi=
x)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    __is_locked =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int ret =3D nl_recvmsgs(dco-&gt;nl_sock, dco-&gt;nl_cb);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    __is_locked =3D false;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     switc=
h (ret)</span><br><span>     {</span><br><span>         case -NLE_INTR:</sp=
an><br><span>@@ -174,6 +170,16 @@</span><br><span>     return ret;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    __is_locked =3D true;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int ret =3D nl_recvmsgs(dco-&gt;nl_sock, dco-&=
gt;nl_cb);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    __is_=
locked =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ovpn_nl_re=
cvmsgs_report(ret, prefix);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> /**</span><br><span>  * Send a prepared netlink message=2E</span><b=
r><span>  *</span><br><span>@@ -399,9 +405,11 @@</span><br><span>     }</sp=
an><br><span> </span><br><span>     /* Register for ovpn-dco specific multi=
cast messages that the kernel may</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-     * send</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * send=2E These are subscribed on the dedicated notification socke=
t only, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * th=
at they are never delivered while a request/reply transaction on</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * dco-&gt;nl_sock is bein=
g parsed=2E</span><br><span>      */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    int ret =3D nl_socket_add_membership(dco-&gt;nl_sock, dc=
o-&gt;ovpn_dco_mcast_id);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int ret =3D nl_socket_add_membership(dco-&gt;nl_sock_notify, dco-=
&gt;ovpn_dco_mcast_id);</span><br><span>     if (ret)</span><br><span>     =
{</span><br><span>         msg(M_FATAL, &quot;%s: failed to join groups: %d=
&quot;, __func__, ret);</span><br><span>@@ -450,17 +458,49 @@</span><br><sp=
an>     nl_cb_set(dco-&gt;nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish=
, &amp;dco-&gt;status);</span><br><span>     nl_cb_set(dco-&gt;nl_cb, NL_CB=
_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* Set up the dedicated mult=
icast notification socket=2E It shares the message</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * handler (ovpn_handle_msg) with the re=
quest/reply socket, but is read only</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * from dco_read_and_process() in the event loop, so n=
otifications never</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * fire while a request/reply transaction is being parsed=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;nl_sock_notify =
=3D nl_socket_alloc();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!dco-&gt;nl_sock_notify)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(M_FATAL, &quot;Cannot create netlink notification socket&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ret =3D genl_connect(dco-&gt;nl_sock_notify);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;Cannot connec=
t to generic netlink (notify): %s&quot;, nl_geterror(ret));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    set_cloexec(nl_socket_get_fd(dco-&gt;nl_sock_notify));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    set_nonblock(nl_socket_ge=
t_fd(dco-&gt;nl_sock_notify));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-=
&gt;nl_cb_notify =3D nl_cb_alloc(NL_CB_DEFAULT);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!dco-&gt;nl_cb_notify)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;failed to allocate net=
link notification callback&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nl_socket_set_=
cb(dco-&gt;nl_sock_notify, dco-&gt;nl_cb_notify);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    nl_cb_err(dco-&gt;nl_cb_notify, NL_CB_CUS=
TOM, ovpn_nl_cb_error, &amp;dco-&gt;status);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    nl_cb_set(dco-&gt;nl_cb_notify, NL_CB_VALID, N=
L_CB_CUSTOM, ovpn_handle_msg, dco);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>     ovpn_dco_register(dco);</span><br><sp=
an> </span><br><span>     /* The async PACKET messages confuse libnl and it=
 will drop them with</span><br><span>      * wrong sequence numbers (NLE_SE=
Q_MISMATCH), so disable libnl&#39;s sequence</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-     * number check */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * number check=2E Multicast notifications ar=
e unsolicited and likewise carry</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * no matching sequence number, so disable the check on bo=
th sockets=2E */</span><br><span>     nl_socket_disable_seq_check(dco-&gt;n=
l_sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nl_sock=
et_disable_seq_check(dco-&gt;nl_sock_notify);</span><br><span> </span><br><=
span>     /* nl library sets the buffer size to 32k/32k by default which is=
 sometimes</span><br><span>      * overrun with very fast connecting/discon=
necting clients=2E</span><br><span>      * TODO: fix this in a better and m=
ore reliable way */</span><br><span>     ASSERT(!nl_socket_set_buffer_size(=
dco-&gt;nl_sock, 1024 * 1024, 1024 * 1024));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ASSERT(!nl_socket_set_buffer_size(dco-&gt;nl_s=
ock_notify, 1024 * 1024, 1024 * 1024));</span><br><span> }</span><br><span>=
 </span><br><span> bool</span><br><span>@@ -496,8 +536,12 @@</span><br><spa=
n>     nl_socket_free(dco-&gt;nl_sock);</span><br><span>     dco-&gt;nl_soc=
k =3D NULL;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    nl_socket_free(dco-&gt;nl_sock_notify);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;nl_sock_notify =3D NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /*=
 Decrease reference count */</span><br><span>     nl_cb_put(dco-&gt;nl_cb);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nl_cb_put(dco-&=
gt;nl_cb_notify);</span><br><span> </span><br><span>     CLEAR(dco);</span>=
<br><span> }</span><br><span>@@ -1165,7 +1209,13 @@</span><br><span> {</spa=
n><br><span>     msg(D_DCO_DEBUG, __func__);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    return ovpn_nl_recvmsgs(dco, _=
_func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Dra=
in the multicast notification socket=2E This is the only place where</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * asynchronous notifi=
cations (peer del/float, key swap) are processed, so</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * the multi_close_instance() they ma=
y trigger happens at a safe point in</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * the event loop rather than re-entrantly inside a re=
quest/reply=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int ret =3D nl_recvmsgs(dco-&gt;nl_sock_notify, dco-&gt;nl_cb_notify);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ovpn_nl_recvmsgs_report(ret, _=
_func__);</span><br><span> }</span><br><span> </span><br><span> static int<=
/span><br><span>@@ -1327,9 +1377,12 @@</span><br><span> void</span><br><spa=
n> dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
dco &amp;&amp; dco-&gt;nl_sock)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (dco &amp;&amp; dco-&gt;nl_sock_notify)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        event_c=
tl(es, nl_socket_get_fd(dco-&gt;nl_sock), EVENT_READ, arg);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* Only the notification so=
cket is monitored by the event loop=2E The</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * request/reply socket (dco-&gt;nl_sock) is=
 drained synchronously by</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+         * ovpn_nl_msg_send()=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        event_ctl(es, nl_socket_get_fd(dco-&gt;nl_soc=
k_notify), EVENT_READ, arg);</span><br><span>     }</span><br><span> }</spa=
n><br><span> </span><br><span>diff --git a/src/openvpn/dco_linux=2Eh b/src/=
openvpn/dco_linux=2Eh</span><br><span>index e3e4824=2E=2Ec487581 100644</sp=
an><br><span>--- a/src/openvpn/dco_linux=2Eh</span><br><span>+++ b/src/open=
vpn/dco_linux=2Eh</span><br><span>@@ -62,8 +62,18 @@</span><br><span> </spa=
n><br><span> typedef struct</span><br><span> {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* socket used for synchronous request/reply=
 transactions (commands and</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * stats queries)=2E It is NOT subscribed to the multicast grou=
p, so its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * rec=
vmsgs never dispatch an asynchronous notification=2E */</span><br><span>   =
  struct nl_sock *nl_sock;</span><br><span>     struct nl_cb *nl_cb;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* socket dedicated to=
 multicast notifications (peer del/float, key swap)=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * It is read only at the top-level =
dco_read_and_process() point, where it</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * is safe to close instances=2E Keeping it separate=
 from nl_sock prevents</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * notifications from being processed re-entrantly while a request/r=
eply is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * in fl=
ight=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t nl_sock *nl_sock_notify;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct nl_cb *nl_cb_notify;</span><br><span>     int status;</sp=
an><br><span> </span><br><span>     struct context *c;</span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737?usp=
=3Demail">change 1737</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1737?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1737 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>

</body></html>
--YNzpk4piKe0=--


--===============7134181450916112853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7134181450916112853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7134181450916112853==--

