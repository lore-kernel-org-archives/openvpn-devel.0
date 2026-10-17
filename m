Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DBACCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 16:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=4tjlZbifgd48mnj2tAGz73TjwOi8wcxYLt4lDWmESc8=; b=F1rW27JMJCHBNm
	xLgKDrkYGHI1PuEOd4fYzyzfSGCD9gobhAl0zrsMUcCwWwE5xuPqC/weRVyiuzIZypT5eQ2YqGFKx
	c0nzUZVGg+y4DjrXLmvRovfkZ0bMvge0bDOESaJFg/fejKY4Xgx0k/YfaG8+zL4KQTnoagRLj46r5
	o+Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI79y-0000zW-1Q;
	Sat, 17 Oct 2026 16:21:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xI79w-0000zQ-IZ
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:21:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0W9GRBQPUDuy25yPgIXgFB4ca8aQfaWoniq43EqrBsw=; b=WfYUFPK3ABQRs6Id8Mjo7cL2Zo
 IzBAsHX4ZoEUlB+xGW4qpowcA0nEzu2jXRd/X9V+WqkFmDXgeIgFfI5bCcaL1oZkGUjczCFOiNY+Q
 Asd/KkPhQyFxNksRwwMwkVY07bYvEQgCWh7IfypfaUadp8umyD91Seqbjr378C72QUW4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0W9GRBQPUDuy25yPgIXgFB4ca8aQfaWoniq43EqrBsw=; b=I
 0fbYZamEsYEs+d3A/qFgIBWgZ860bxKoSqPncRm4oixZ4GlS063BPacz7MZbmQOI63psAKYlEMZWZ
 QpLcWqkY0teeuUwB2kDiakfYEFmOvtn3bFtzNela21lxN9gdIsw1IiS7G7ASGSW9kR0OCXmLlqmL+
 okDPFWb/UtfGz/d4=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xI79t-0005aa-P8 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:21:25 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49fbb2acc90so9837635e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792254075; x=1792858875; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0W9GRBQPUDuy25yPgIXgFB4ca8aQfaWoniq43EqrBsw=;
 b=YlW/+2IuIECxkxOnF12KmAnhGj0iVAtdelCrJaHZwl9wqYJRvkwKe71OFpCBtCSf3J
 0Zt3AbneLd8ktheLjBafOZRRrjm9rs+EdYOLVd9dbKsmXSioenO/scmtEMAYefeiyREm
 3d64mAW+dp0LTy78paHG5NpTja4BK/eq6MHsgeUJL8QzLbl82LRyFoK0UKNFBH9Ie+UA
 b+JEqB1fMrrzhnKQVfU2KUW177+bO4TQwK84UIrWGcEmTd9+RcEwofiS+VEXchRlaPJQ
 7xLx90+cTxFda2khJ1q0jyxYUCpOBVpLBJh83Km9Woqt6kQ5TYaRnkRnltouNhc5ppoT
 w6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792254075; x=1792858875;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0W9GRBQPUDuy25yPgIXgFB4ca8aQfaWoniq43EqrBsw=;
 b=Pj4f21Q0xyfDG37dxgzuh/EbKMOvyddyeHTWvlqJn9HHdfg45MURiL7y/Zk7ONo0bt
 Sc/F1gnBYPH94xk1gsvgbgDs1mtoo9nlGtInXwRgZJ+/NLLB3SATsVaoQELBSen88xIu
 WZiIWehLTzLyTsCbclaGaGGTVYC+BarQRbdNmHfWFicYHIiG+FRVWxdUOHXsrHpIHUQS
 W9oa9Dw+i35zFo8bIh3DmrTBRnHH23ZiJHwujemmAyTF2aIJpjRXi+Y5oBaxY4WplKiJ
 VGdmqJMbCws0hOWiZthub3MSKCP6XcvZk9G8+E6opZLpDRolnDdLLD5W4yGOZzUsjUG6
 kWjw==
X-Gm-Message-State: AFq9FYKheIDSgUdm2c1Xhj20p+X2KXDYwnT+gJY0mvlnpGLfdz6cSjEw
 y732oWZmJ/gD65tX/VsjkvbozVlS/3kAB+zjLHDHgAsEQX1yN8rBmvI/0fOo2m8I74d7oXLtHbs
 GxHLkbdhf2O6/NRMDqINTQbAeEMExNIGE9DFONfvho3wxXPkdlTMwO3DUc1+xCClPrLRyCtwfll
 Z+KU58mw==
X-Gm-Gg: AYBFou3IVJ+FjTpP68qwWbtWukejQ0A/nbLe3cH98hQu6h9TeIa77KJMZr5ANIyAEVt
 M05OqtiXb5fZ39ritasyZ+U01ayBFaSxBq8NhvNRa3AxzFMXsGOX7dIZAdZVNjV/fJqy9jlDSmh
 eIX4KLUDCUUp5ZkucJTgzfNFQb59VudhXIdC61thd2cXG8C0NNV999XpsEOAZMjEW3WlVmnD1bd
 ubUWXUVMPrgmXSfgGiq8VMshsgFlQPwH4fb5jTqTCanKte6eMhvRYwVw6x8IRju9XCk9Seo+pzg
 pF/piziJ5iliMl1WHoacYU3cLgJl+ZAjKGHJzXeN+ZzAzoLGTMh/vFtU7/hXlcqrdlfZgoUSVQv
 60068ts8gnmPz0q0xFTUjXwjdhd2rIIoN7RM4t3vH0W3QhcStZb8HeuNXpseW47O1ic+64f4BWG
 eF1+Ea3RrXEVO1gZ0oin43Q4J/9rltGa4pUA4HTJVG6WVQeXtiMMmDjpDldxqhIa63rwM/rDbLu
 9o0BKPIU+tTVOK7p7ezbp2dpFhYofp8fgKN+QkkQ4E10epLQg+0FHBUbqAP9mRdKJcPHPVLr+cM
 v4KXbUFZmhweHZFyZjJY3fk7i78IVl6JXyve+phVJU+Mo6EzZnR8T3xsURsv
X-Received: by 2002:a05:600c:3b22:b0:4a1:7690:d878 with SMTP id
 5b1f17b1804b1-4a1d7615cb9mr61162835e9.17.1792254074681; 
 Sat, 17 Oct 2026 09:21:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d756ce69sm75247765e9.4.2026.10.17.09.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 09:21:14 -0700 (PDT)
X-Google-Original-From: "Alejandro (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 16:21:13 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
X-Gerrit-Change-Number: 2002
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2002?usp=email>
X-Gerrit-Commit: 0ee0687f4274f1408174f4c8bf605b4175fcc448
References: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU0MDY4MDAwLkkzNzljMzZlMTU1NzE3OGQyMmQzZWUyN2NkNmVkNTFiNWMzYTJlNzkzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6ac8981be842e75964d2c167ceb0058cb04afbfc-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xI79t-0005aa-P8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Keep the outgoing
 control packet in a buffer owned by tls_multi
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
From: "Alejandro \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: alepacheco99@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Alejandro \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6522715244713297260=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6522715244713297260==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Wskxe5fEGJA="; charset=UTF-8

--Wskxe5fEGJA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2002?usp=3Demail

to review the following change=2E
=


Change subject: Keep the outgoing control packet in a buffer owned by tls=
_multi
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Keep=
 the outgoing control packet in a buffer owned by tls_multi

tls_multi_proc=
ess() returns the outgoing control packet in to_link=2E
Until now to_link p=
ointed into memory owned by a session or key state:
the reliable send buffe=
r, ks->ack_write_buf, or the tls_wrap or
tls_wrap_reneg work buffer=2E  Whe=
n that session or key state was freed
or reset before the packet was writte=
n to the link, to_link was left
pointing to freed memory=2E  This caused CV=
E-2023-46850, CVE-2026-40215,
CVE-2026-12996, CVE-2026-13117 and CVE-2026-8=
4471=2E

The fixes so far added check_session_buf_not_used() and
check_keys=
tate_buf_not_used(), which compare to_link against a list of
the buffers of=
 a session or key state before it is freed and drop the
packet on a match=
=2E  This only works as long as the list names every
buffer a packet can en=
d up in and every caller that frees a session or
key state passes to_link d=
own: key_state_soft_reset() is called without
it from tls_pre_decrypt() and=
 tls_session_soft_reset()=2E

Fix the ownership instead=2E  write_control_a=
uth() now copies the
finished packet into a buffer the caller owns, and tls=
_multi_process()
returns it in multi->to_link_buf, which lives as long as t=
he tls_multi,
like multi->to_link_addr already does for the address=2E  Fre=
eing or
moving sessions and key states no longer affects a pending packet, =
so
the checks and the to_link parameters of key_state_free(),
tls_session_f=
ree(), move_session(), reset_session() and
key_state_soft_reset() are remov=
ed=2E  A packet that is pending when its
session is freed is now sent inste=
ad of dropped; the peer handles it
like any late packet of that session=2E
=

The copy costs one memcpy of a control channel packet=2E  The new unit
tes=
t checks that the packet written by write_control_auth() stays
intact and v=
alid after the buffers it was built from are overwritten,
with no wrapping,=
 tls-auth and tls-crypt=2E

Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a=
2e793
Signed-off-by: Alejandro Pacheco <alepacheco99@gmail=2Ecom>
---
M src=
/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M src/openvpn/ssl_pkt=2Ec
M s=
rc/openvpn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/test_pkt=2Ec
5 files chan=
ged, 178 insertions(+), 147 deletions(-)



  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/02/2002/1

diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec
index 3594871=2E=2Ed52d539 100644
--- a/src/open=
vpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -96,14 +96,6 @@
 
 #endif /* ifdef=
 MEASURE_TLS_HANDSHAKE_STATS */
 
-/* forward decleration since tls_process=
 needs this function prototype */
-static void
-check_session_buf_not_used(=
struct buffer *to_link, struct tls_session *session);
-
-static void
-check=
_keystate_buf_not_used(struct buffer *to_link, const struct key_state *ks);=

-
-
 /**
  * Limit the reneg_bytes value when using a small-block (<128 by=
tes) cipher=2E
  *
@@ -904,15 +896,10 @@
  *                       cleaned =
up=2E
  * @param clear        - Whether the memory allocated for the \a ks =
object
  *                       should be overwritten with 0s=2E
- *
- * @=
param to_link      - if not NULL, check that the buffer does not contain
- =
*                       any pointer to one of the internal structs of ks
  =
*/
 static void
-key_state_free(struct key_state *ks, bool clear, struct bu=
ffer *to_link)
+key_state_free(struct key_state *ks, bool clear)
 {
-    ch=
eck_keystate_buf_not_used(to_link, ks);
-
     ks->state =3D S_UNDEF;
 
   =
  key_state_ssl_free(&ks->ks_ssl);
@@ -1056,14 +1043,10 @@
  *             =
          object should be overwritten with 0s=2E This
  *                 =
      implicitly sets many states to 0/false,
  *                       e=
=2Eg=2E the validity of the keys in the structure
- * @param to_link      -=
 if not NULL, check that the buffer does not contain
- *                   =
    any pointer to one of the internal structs of ks
- *
  */
 static void
=
-tls_session_free(struct tls_session *session, bool clear, struct buffer *t=
o_link)
+tls_session_free(struct tls_session *session, bool clear)
 {
-    =
check_session_buf_not_used(to_link, session);
     tls_wrap_free(&session->=
tls_wrap);
     tls_wrap_free(&session->tls_wrap_reneg);
 
@@ -1072,7 +1055=
,7 @@
         /* we don't need clear=3Dtrue for this call since
          =
* the structs are part of session and get cleared
          * as part of se=
ssion */
-        key_state_free(&session->key[i], false, to_link);
+      =
  key_state_free(&session->key[i], false);
     }
 
     free(session->comm=
on_name);
@@ -1091,16 +1074,14 @@
 
 
 static void
-move_session(struct tls=
_multi *multi, int dest, int src, bool reinit_src,
-             struct buf=
fer *to_link)
+move_session(struct tls_multi *multi, int dest, int src, boo=
l reinit_src)
 {
-    check_session_buf_not_used(to_link, &multi->session[d=
est]);
     msg(D_TLS_DEBUG_LOW, "TLS: move_session: dest=3D%s src=3D%s rei=
nit_src=3D%d",
         session_index_name(dest), session_index_name(src), =
reinit_src);
     ASSERT(src !=3D dest);
     ASSERT(src >=3D 0 && src < TM=
_SIZE);
     ASSERT(dest >=3D 0 && dest < TM_SIZE);
-    tls_session_free(&=
multi->session[dest], false, to_link);
+    tls_session_free(&multi->sessio=
n[dest], false);
     multi->session[dest] =3D multi->session[src];
 
     =
if (reinit_src)
@@ -1116,9 +1097,9 @@
 }
 
 static void
-reset_session(stru=
ct tls_multi *multi, struct tls_session *session, struct buffer *to_link)
+=
reset_session(struct tls_multi *multi, struct tls_session *session)
 {
-   =
 tls_session_free(session, false, to_link);
+    tls_session_free(session, =
false);
     tls_session_init(multi, session);
 }
 
@@ -1192,6 +1173,8 @@
 =
tls_multi_init_finalize(struct tls_multi *multi, int tls_mtu)
 {
     tls_i=
nit_control_channel_frame_parameters(&multi->opt=2Eframe, tls_mtu);
+    mu=
lti->to_link_buf =3D alloc_buf(BUF_SIZE(&multi->opt=2Eframe));
+
     /* in=
itialize the active and untrusted sessions */
 
     tls_session_init(multi=
, &multi->session[TM_ACTIVE]);
@@ -1283,9 +1266,11 @@
 
     for (int i =3D=
 0; i < TM_SIZE; ++i)
     {
-        tls_session_free(&multi->session[i], =
false, NULL);
+        tls_session_free(&multi->session[i], false);
     }
=
 
+    free_buf(&multi->to_link_buf);
+
     if (clear)
     {
         sec=
ure_memzero(multi, sizeof(*multi));
@@ -1816,13 +1801,13 @@
  * active key=
=2E
  */
 static void
-key_state_soft_reset(struct tls_session *session, st=
ruct buffer *to_link)
+key_state_soft_reset(struct tls_session *session)
 {=

     struct key_state *ks =3D &session->key[KS_PRIMARY];        /* primary=
 key */
     struct key_state *ks_lame =3D &session->key[KS_LAME_DUCK]; /* =
retiring key */
 
     ks->must_die =3D now + session->opt->transition_wind=
ow;    /* remaining lifetime of old key */
-    key_state_free(ks_lame, fal=
se, to_link);
+    key_state_free(ks_lame, false);
     *ks_lame =3D *ks;
 =

     key_state_init(session, ks);
@@ -1833,7 +1818,7 @@
 void
 tls_session=
_soft_reset(struct tls_multi *tls_multi)
 {
-    key_state_soft_reset(&tls_=
multi->session[TM_ACTIVE], NULL);
+    key_state_soft_reset(&tls_multi->ses=
sion[TM_ACTIVE]);
 }
 
 /*
@@ -2914,18 +2899,15 @@
 
         const struct =
buffer *buf =3D reliable_send(ks->send_reliable, &opcode);
         ASSERT(=
buf);
-        struct buffer b =3D *buf;
         INCR_SENT;
 
-        wri=
te_control_auth(session, ks, &b, to_link_addr, opcode, CONTROL_SEND_ACK_MAX=
, true);
-        *to_link =3D b;
+        write_control_auth(session, ks, =
buf, &multi->to_link_buf, to_link_addr, opcode,
+                          =
 CONTROL_SEND_ACK_MAX, true);
+        *to_link =3D multi->to_link_buf;
   =
      dmsg(D_TLS_DEBUG, "Reliable -> TCP/UDP");
 
-        /* This changed =
the state of the outgoing buffer=2E In order to avoid
-         * running t=
his function again/further and invalidating the key_state
-         * buffe=
r and accessing the buffer that is now in to_link after it being
-         =
* freed for a potential error, we shortcircuit exiting of the outer
-      =
   * process here=2E */
+        /* This changed the state of the outgoing =
buffer=2E Stop this
+         * processing pass so that the event loop can =
send the packet=2E */
         return false;
     }
 
@@ -3165,13 +3147,13 =
@@
             session->opt->aead_usage_limit,
             ks->crypto_opt=
ions=2Ekey_ctx_bi=2Edecrypt=2Eplaintext_blocks + ks->n_packets,
           =
  session->opt->aead_usage_limit);
-        key_state_soft_reset(session, t=
o_link);
+        key_state_soft_reset(session);
     }
 
     /* Kill lame=
 duck key transition_window seconds after primary key negotiation */
     i=
f (lame_duck_must_die(session, wakeup))
     {
-        key_state_free(ks_l=
ame, true, to_link);
+        key_state_free(ks_lame, true);
         msg(D=
_TLS_DEBUG_LOW, "TLS: tls_process: killed expiring key");
     }
 
@@ -3220=
,8 +3202,9 @@
         {
             struct buffer buf =3D ks->ack_write_b=
uf;
             ASSERT(buf_init(&buf, multi->opt=2Eframe=2Ebuf=2Eheadroom)=
);
-            write_control_auth(session, ks, &buf, to_link_addr, P_ACK_V=
1, RELIABLE_ACK_SIZE, false);
-            *to_link =3D buf;
+            w=
rite_control_auth(session, ks, &buf, &multi->to_link_buf, to_link_addr, P_A=
CK_V1,
+                               RELIABLE_ACK_SIZE, false);
+        =
    *to_link =3D multi->to_link_buf;
             dmsg(D_TLS_DEBUG, "Dedica=
ted ACK -> TCP/UDP");
         }
     }
@@ -3264,98 +3247,6 @@
     return =
false;
 }
 
-static void
-check_keystate_buf_not_used(struct buffer *to_lin=
k, const struct key_state *ks)
-{
-    if (ks->state =3D=3D S_UNDEF || !to_=
link || !to_link->data)
-    {
-        return;
-    }
-
-    const uint8_t=
 *dataptr =3D to_link->data;
-
-    /* we don't expect send_reliable to be =
NULL when state is
-     * not S_UNDEF, but people have reported crashes no=
netheless,
-     * therefore we better catch this event, report and exit=2E=

-     */
-    if (!ks->send_reliable)
-    {
-        msg(M_FATAL,
-      =
      "ERROR: ks=2Esend_reliable (key-id %d), is NULL "
-            "while=
 key state is %s=2E Exiting=2E",
-            ks->key_id, state_name(ks->st=
ate));
-    }
-
-    for (int j =3D 0; j < ks->send_reliable->size; j++)
- =
   {
-        if (ks->send_reliable->array[j]=2Ebuf=2Edata =3D=3D dataptr)
=
-        {
-            msg(M_INFO,
-                "Warning buffer of fre=
ed TLS session is still in"
-                " use (key-id %d, ks=2Esend_re=
liable->array[%d])",
-                ks->key_id, j);
-
-            goto u=
sed;
-        }
-    }
-
-    if (ks->ack_write_buf=2Edata =3D=3D dataptr)
=
-    {
-        msg(M_INFO, "Warning buffer of freed TLS session is still i=
n use "
-                    "(ks=2Eack_write_buf, key-id %d)",
-          =
  ks->key_id);
-
-        goto used;
-    }
-    return;
-
-used:
-    to_l=
ink->len =3D 0;
-    to_link->data =3D 0;
-}
-
-/**
- * This is a safe guar=
d function to double check that a buffer from a session is
- * not used in =
a session to avoid a use after free=2E
- *
- * @param to_link
- * @param se=
ssion
- */
-static void
-check_session_buf_not_used(struct buffer *to_link,=
 struct tls_session *session)
-{
-    if (!to_link || !to_link->data)
-    =
{
-        return;
-    }
-    const uint8_t *dataptr =3D to_link->data;
-
=
-    /* Checks buffers in tls_wrap */
-    if (session->tls_wrap=2Ework=2Ed=
ata =3D=3D dataptr)
-    {
-        msg(M_INFO, "Warning buffer of freed TL=
S session is "
-                    "still in use (tls_wrap=2Ework=2Edata)"=
);
-        goto used;
-    }
-    if (session->tls_wrap_reneg=2Ework=2Edat=
a =3D=3D dataptr)
-    {
-        msg(M_INFO, "Warning buffer of freed TLS =
session is "
-                    "still in use (tls_wrap_reneg=2Ework=2Eda=
ta)");
-        goto used;
-    }
-
-    for (int i =3D 0; i < KS_SIZE; i++=
)
-    {
-        const struct key_state *ks =3D &session->key[i];
-       =
 check_keystate_buf_not_used(to_link, ks);
-    }
-    return;
-
-used:
-  =
  to_link->len =3D 0;
-    to_link->data =3D 0;
-    /* for debugging, you =
can add an ASSERT(0); here to trigger an abort */
-}
 /*
  * Called by the =
top-level event loop=2E
  *
@@ -3444,11 +3335,11 @@
                 if (i =
=3D=3D TM_ACTIVE && ks_lame->state >=3D S_GENERATED_KEYS
                  =
   && !multi->opt=2Esingle_session)
                 {
-                   =
 move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true, to_link);
+            =
        move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true);
               =
  }
                 else
                 {
-                    reset_ses=
sion(multi, session, to_link);
+                    reset_session(multi, se=
ssion);
                 }
             }
         }
@@ -3511,7 +3402,7 @@
=
      */
     if (lame_duck_must_die(&multi->session[TM_LAME_DUCK], wakeup)=
)
     {
-        tls_session_free(&multi->session[TM_LAME_DUCK], true, to_=
link);
+        tls_session_free(&multi->session[TM_LAME_DUCK], true);
    =
     msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: killed expiring key");
 =
    }
 
@@ -3526,7 +3417,7 @@
      */
     if (TLS_AUTHENTICATED(multi, &m=
ulti->session[TM_INITIAL]=2Ekey[KS_PRIMARY]))
     {
-        move_session(=
multi, TM_ACTIVE, TM_INITIAL, true, to_link);
+        move_session(multi, =
TM_ACTIVE, TM_INITIAL, true);
         tas =3D tls_authentication_status(mu=
lti);
         msg(D_TLS_DEBUG_LOW,
             "TLS: tls_multi_process: i=
nitial untrusted "
@@ -3938,7 +3829,7 @@
                 goto error;
     =
        }
 
-            key_state_soft_reset(session, NULL);
+            =
key_state_soft_reset(session);
 
             dmsg(D_TLS_DEBUG, "TLS: recei=
ved P_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s", i,
                  session_=
id_print(&sid, &gc));
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn=
/ssl_common=2Eh
index f6392f9=2E=2Ea0f677e 100644
--- a/src/openvpn/ssl_com=
mon=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -627,6 +627,14 @@
      */
    =
 struct link_socket_actual to_link_addr;
 
+    /**
+     * Holds the outgo=
ing control packet returned by tls_multi_process=2E
+     * It belongs to t=
he tls_multi and not to a session or key state, so
+     * it stays valid w=
hen these are freed or moved before the packet is
+     * written to the li=
nk=2E
+     */
+    struct buffer to_link_buf;
+
     int n_sessions; /**< =
Number of sessions negotiated thus
                      *   far=2E */
    =
 enum multi_status multi_state;
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/=
openvpn/ssl_pkt=2Ec
index f78782f=2E=2Ed8a1cef 100644
--- a/src/openvpn/ssl=
_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -163,10 +163,14 @@
 }
 
 void
-wr=
ite_control_auth(struct tls_session *session, struct key_state *ks, struct =
buffer *buf,
-                   struct link_socket_actual **to_link_addr, =
int opcode, int max_ack,
-                   bool prepend_ack)
+write_contr=
ol_auth(struct tls_session *session, struct key_state *ks, const struct buf=
fer *payload,
+                   struct buffer *out, struct link_socket_ac=
tual **to_link_addr, int opcode,
+                   int max_ack, bool prep=
end_ack)
 {
+    /* Work on a copy so that tls_wrap_control can point it at=
 another
+     * buffer without modifying the caller's buffer */
+    struc=
t buffer buf =3D *payload;
+
     ASSERT(ks->key_id >=3D 0 && ks->key_id <=
=3D P_KEY_ID_MASK);
     ASSERT(opcode >=3D 0 && opcode <=3D P_LAST_OPCODE)=
;
     uint8_t header =3D (uint8_t)(ks->key_id | (opcode << P_OPCODE_SHIFT)=
);
@@ -181,14 +185,20 @@
     }
 
     ASSERT(link_socket_actual_defined(&k=
s->remote_addr));
-    ASSERT(reliable_ack_write(ks->rec_ack, ks->lru_acks,=
 buf, &ks->session_id_remote, max_ack,
+    ASSERT(reliable_ack_write(ks->r=
ec_ack, ks->lru_acks, &buf, &ks->session_id_remote, max_ack,
              =
                 prepend_ack));
 
     msg(D_TLS_DEBUG, "%s(): %s", __func_=
_, packet_opcode_name(opcode));
 
-    tls_wrap_control(tls_session_get_tls=
_wrap(session, ks->key_id), header, buf,
+    tls_wrap_control(tls_session_=
get_tls_wrap(session, ks->key_id), header, &buf,
                      &ses=
sion->session_id);
 
+    /* buf now points into memory owned by ks or sess=
ion (the payload's
+     * buffer or the tls_wrap work buffer)=2E  Either c=
an be freed before
+     * the packet is written to the link, so copy the p=
acket to out=2E */
+    ASSERT(buf_init(out, buf=2Eoffset));
+    ASSERT(bu=
f_copy(out, &buf));
+
     *to_link_addr =3D &ks->remote_addr;
 }
 
diff --=
git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 8203e4a=2E=2E=
d02b4b0 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
=
@@ -185,10 +185,29 @@
 bool check_session_hmac_and_pkt_id(struct tls_pre_de=
crypt_state *state, const struct openvpn_sockaddr *from,
                  =
                  const uint8_t *key, int handwindow, bool pkt_is_ack);
 
-=
/*
- * Write a control channel authentication record=2E
+/**
+ * Write a co=
ntrol channel packet: add the ACKs, the opcode and session id
+ * header an=
d the tls-auth/tls-crypt wrapping to \c payload=2E
+ *
+ * @param session  =
         the TLS session the packet belongs to
+ * @param ks               =
 the key state the packet belongs to
+ * @param payload           the packe=
t payload=2E Its data is left
+ *                          unchanged, but t=
he space around it in its
+ *                          buffer is used to bu=
ild the packet=2E
+ * @param out               buffer the finished packet i=
s written to, at
+ *                          the offset it was built at=2E=
 It must be owned
+ *                          by the caller, not share mem=
ory with \c payload
+ *                          or the tls_wrap work buffe=
rs, and have room for
+ *                          the packet at that offse=
t (a buffer of
+ *                          BUF_SIZE() of the session's fra=
me does)=2E
+ * @param to_link_addr      set to the address the packet is s=
ent to
+ * @param opcode            opcode of the packet
+ * @param max_ack=
           maximum number of ACKs to add
+ * @param prepend_ack       add t=
he ACKs in front of the payload instead
+ *                          of wri=
ting them into it
  */
-void write_control_auth(struct tls_session *session=
, struct key_state *ks, struct buffer *buf,
+void write_control_auth(struct=
 tls_session *session, struct key_state *ks,
+                        const=
 struct buffer *payload, struct buffer *out,
                         struc=
t link_socket_actual **to_link_addr, int opcode, int max_ack,
             =
            bool prepend_ack);
 
diff --git a/tests/unit_tests/openvpn/test=
_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index 51c73d8=2E=2E120f98f=
 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/=
openvpn/test_pkt=2Ec
@@ -741,6 +741,108 @@
     free_tas(&tas);
 }
 
+/* wr=
ite_control_auth() writes the finished packet to the out buffer of the
+ * =
caller, so the packet stays valid when the buffers of the session and key
+=
 * state are reused or freed before it is sent=2E */
+static void
+check_wr=
ite_control_auth_out_buf(struct tls_wrap_ctx *wrap, struct tls_wrap_ctx *pe=
er_wrap)
+{
+    struct tls_options opt =3D { 0 };
+    opt=2Eserver =3D tr=
ue;
+
+    struct tls_session session =3D { 0 };
+    session=2Eopt =3D &op=
t;
+    session=2Etls_wrap =3D *wrap;
+    session=2Esession_id =3D (struct=
 session_id){ { 1, 2, 3, 4, 5, 6, 7, 8 } };
+
+    struct reliable_ack rec_=
ack =3D { =2Elen =3D 1, =2Epacket_id =3D { 7 } };
+    struct reliable_ack =
lru_acks =3D { 0 };
+    struct key_state ks =3D { 0 };
+    ks=2Erec_ack =
=3D &rec_ack;
+    ks=2Elru_acks =3D &lru_acks;
+    ks=2Esession_id_remote=
 =3D (struct session_id){ { 8, 7, 6, 5, 4, 3, 2, 1 } };
+    ks=2Eremote_ad=
dr=2Edest=2Eaddr=2Esa=2Esa_family =3D AF_INET;
+    ks=2Eremote_addr=2Edest=
=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D htonl(0x01020304);
+
+    const uint8=
_t data[] =3D "control channel payload";
+    struct buffer payload =3D all=
oc_buf(1600);
+    struct buffer out =3D alloc_buf(1600);
+
+    /* a contr=
ol packet with the ACK in front of its payload, as sent from
+     * the re=
liability layer, and a dedicated ACK packet */
+    for (int i =3D 0; i < 2=
; i++)
+    {
+        const bool dedicated_ack =3D (i =3D=3D 1);
+        =
const size_t len =3D dedicated_ack ? 0 : sizeof(data);
+
+        assert_tr=
ue(buf_init(&payload, 200));
+        assert_true(buf_write(&payload, data,=
 len));
+
+        struct link_socket_actual *to_link_addr =3D NULL;
+     =
   write_control_auth(&session, &ks, &payload, &out, &to_link_addr,
+      =
                     dedicated_ack ? P_ACK_V1 : P_CONTROL_V1, RELIABLE_ACK_=
SIZE,
+                           !dedicated_ack);
+
+        assert_ptr_eq=
ual(to_link_addr, &ks=2Eremote_addr);
+        assert_int_equal(BLEN(&paylo=
ad), len);
+        assert_memory_equal(BPTR(&payload), data, len);
+      =
  assert_true(BLENZ(&out) > len);
+
+        /* the packet is still intact =
after the session buffers are overwritten */
+        memset(payload=2Edata=
, 0x55, payload=2Ecapacity);
+        if (session=2Etls_wrap=2Ework=2Edata)=

+        {
+            memset(session=2Etls_wrap=2Ework=2Edata, 0x55, ses=
sion=2Etls_wrap=2Ework=2Ecapacity);
+        }
+
+        struct link_socke=
t_actual from =3D { 0 };
+        assert_true(read_control_auth(&out, peer_=
wrap, &from, &opt));
+
+        struct reliable_ack ack;
+        struct se=
ssion_id sid;
+        assert_true(reliable_ack_parse(&out, &ack, &sid));
+=
        assert_int_equal(ack=2Elen, 1);
+        assert_int_equal(ack=2Epac=
ket_id[0], 7);
+        assert_memory_equal(&sid, &ks=2Esession_id_remote, =
SID_SIZE);
+        assert_int_equal(BLEN(&out), len);
+        assert_memo=
ry_equal(BPTR(&out), data, len);
+    }
+
+    free_buf(&out);
+    free_bu=
f(&payload);
+}
+
+static void
+test_write_control_auth_out_buf(void **ut_s=
tate)
+{
+    now =3D 0x22446688;
+
+    struct tls_wrap_ctx none =3D { =2E=
mode =3D TLS_WRAP_NONE };
+    check_write_control_auth_out_buf(&none, &non=
e);
+
+    struct tls_auth_standalone tas_client =3D init_tas_auth(KEY_DIRE=
CTION_INVERSE);
+    struct tls_auth_standalone tas_server =3D init_tas_aut=
h(KEY_DIRECTION_NORMAL);
+    packet_id_init(&tas_client=2Etls_wrap=2Eopt=
=2Epacket_id, 5, 5, "UNITTEST", 0);
+    packet_id_init(&tas_server=2Etls_w=
rap=2Eopt=2Epacket_id, 5, 5, "UNITTEST", 0);
+    reset_packet_id_send(&tas=
_client=2Etls_wrap=2Eopt=2Epacket_id=2Esend);
+    check_write_control_auth=
_out_buf(&tas_client=2Etls_wrap, &tas_server=2Etls_wrap);
+    packet_id_fr=
ee(&tas_client=2Etls_wrap=2Eopt=2Epacket_id);
+    packet_id_free(&tas_serv=
er=2Etls_wrap=2Eopt=2Epacket_id);
+    free_tas(&tas_client);
+    free_tas=
(&tas_server);
+
+    tas_client =3D init_tas_crypt(false);
+    tas_server=
 =3D init_tas_crypt(true);
+    packet_id_init(&tas_client=2Etls_wrap=2Eopt=
=2Epacket_id, 5, 5, "UNITTEST", 0);
+    packet_id_init(&tas_server=2Etls_w=
rap=2Eopt=2Epacket_id, 5, 5, "UNITTEST", 0);
+    reset_packet_id_send(&tas=
_client=2Etls_wrap=2Eopt=2Epacket_id=2Esend);
+    check_write_control_auth=
_out_buf(&tas_client=2Etls_wrap, &tas_server=2Etls_wrap);
+    packet_id_fr=
ee(&tas_client=2Etls_wrap=2Eopt=2Epacket_id);
+    packet_id_free(&tas_serv=
er=2Etls_wrap=2Eopt=2Epacket_id);
+    free_tas(&tas_client);
+    free_tas=
(&tas_server);
+}
+
 static void
 test_extract_control_message(void **ut_st=
ate)
 {
@@ -792,6 +894,7 @@
         cmocka_unit_test(test_generate_reset_p=
acket_plain),
         cmocka_unit_test(test_generate_reset_packet_tls_auth=
),
         cmocka_unit_test(test_wkc_not_appended_without_key),
+        c=
mocka_unit_test(test_write_control_auth_out_buf),
         cmocka_unit_test=
(test_extract_control_message)
     };
 

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
Gerrit-Ch=
ange-Number: 2002
Gerrit-PatchSet: 1
Gerrit-Owner: Alejandro <alepacheco99@=
gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--Wskxe5fEGJA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Alejandro would like Arne Sch=
wabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Keep the outgoing control packet in a buffer owned by tls_multi<br=
><br>tls_multi_process() returns the outgoing control packet in to_link=2E<=
br>Until now to_link pointed into memory owned by a session or key state:<b=
r>the reliable send buffer, ks-&gt;ack_write_buf, or the tls_wrap or<br>tls=
_wrap_reneg work buffer=2E  When that session or key state was freed<br>or =
reset before the packet was written to the link, to_link was left<br>pointi=
ng to freed memory=2E  This caused CVE-2023-46850, CVE-2026-40215,<br>CVE-2=
026-12996, CVE-2026-13117 and CVE-2026-84471=2E<br><br>The fixes so far add=
ed check_session_buf_not_used() and<br>check_keystate_buf_not_used(), which=
 compare to_link against a list of<br>the buffers of a session or key state=
 before it is freed and drop the<br>packet on a match=2E  This only works a=
s long as the list names every<br>buffer a packet can end up in and every c=
aller that frees a session or<br>key state passes to_link down: key_state_s=
oft_reset() is called without<br>it from tls_pre_decrypt() and tls_session_=
soft_reset()=2E<br><br>Fix the ownership instead=2E  write_control_auth() n=
ow copies the<br>finished packet into a buffer the caller owns, and tls_mul=
ti_process()<br>returns it in multi-&gt;to_link_buf, which lives as long as=
 the tls_multi,<br>like multi-&gt;to_link_addr already does for the address=
=2E  Freeing or<br>moving sessions and key states no longer affects a pendi=
ng packet, so<br>the checks and the to_link parameters of key_state_free(),=
<br>tls_session_free(), move_session(), reset_session() and<br>key_state_so=
ft_reset() are removed=2E  A packet that is pending when its<br>session is =
freed is now sent instead of dropped; the peer handles it<br>like any late =
packet of that session=2E<br><br>The copy costs one memcpy of a control cha=
nnel packet=2E  The new unit<br>test checks that the packet written by writ=
e_control_auth() stays<br>intact and valid after the buffers it was built f=
rom are overwritten,<br>with no wrapping, tls-auth and tls-crypt=2E<br><br>=
Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793<br>Signed-off-by: Alej=
andro Pacheco &lt;alepacheco99@gmail=2Ecom&gt;<br>---<br>M src/openvpn/ssl=
=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M src/openvpn/ssl_pkt=2Ec<br>M src/=
openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>5 files c=
hanged, 178 insertions(+), 147 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/02/2002/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>=
index 3594871=2E=2Ed52d539 100644</span><br><span>--- a/src/openvpn/ssl=2Ec=
</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -96,14 +96,6 =
@@</span><br><span> </span><br><span> #endif /* ifdef MEASURE_TLS_HANDSHAKE=
_STATS */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-/* forward decleration since tls_process needs this function prototyp=
e */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-check_session_buf_not_used(=
struct buffer *to_link, struct tls_session *session);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-check_keystate_buf_not_used(struct buffer *to_link, const struct key_state=
 *ks);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><spa=
n>  * Limit the reneg_bytes value when using a small-block (&lt;128 bytes) =
cipher=2E</span><br><span>  *</span><br><span>@@ -904,15 +896,10 @@</span><=
br><span>  *                       cleaned up=2E</span><br><span>  * @param=
 clear        - Whether the memory allocated for the \a ks object</span><br=
><span>  *                       should be overwritten with 0s=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * @param to_link      - if not NULL, check that t=
he buffer does not contain</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *                       any pointer to one of the internal structs of=
 ks</span><br><span>  */</span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-key_state_free(struct key_state *ks, bool c=
lear, struct buffer *to_link)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+key_state_free(struct key_state *ks, bool clear)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    check_keystate_=
buf_not_used(to_link, ks);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span>     ks-&gt;state =3D S_UNDEF;</span><br><span> </spa=
n><br><span>     key_state_ssl_free(&amp;ks-&gt;ks_ssl);</span><br><span>@@=
 -1056,14 +1043,10 @@</span><br><span>  *                       object shou=
ld be overwritten with 0s=2E This</span><br><span>  *                      =
 implicitly sets many states to 0/false,</span><br><span>  *               =
        e=2Eg=2E the validity of the keys in the structure</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * @param to_link      - if not NULL, =
check that the buffer does not contain</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *                       any pointer to one of the interna=
l structs of ks</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</sp=
an><br><span>  */</span><br><span> static void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-tls_session_free(struct tls_session *session, bool=
 clear, struct buffer *to_link)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+tls_session_free(struct tls_session *session, bool clear)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    chec=
k_session_buf_not_used(to_link, session);</span><br><span>     tls_wrap_fre=
e(&amp;session-&gt;tls_wrap);</span><br><span>     tls_wrap_free(&amp;sessi=
on-&gt;tls_wrap_reneg);</span><br><span> </span><br><span>@@ -1072,7 +1055,=
7 @@</span><br><span>         /* we don&#39;t need clear=3Dtrue for this ca=
ll since</span><br><span>          * the structs are part of session and ge=
t cleared</span><br><span>          * as part of session */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        key_state_free(&amp;session-&=
gt;key[i], false, to_link);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        key_state_free(&amp;session-&gt;key[i], false);</span><br><=
span>     }</span><br><span> </span><br><span>     free(session-&gt;common_=
name);</span><br><span>@@ -1091,16 +1074,14 @@</span><br><span> </span><br>=
<span> </span><br><span> static void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-move_session(struct tls_multi *multi, int dest, int src, boo=
l reinit_src,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
     struct buffer *to_link)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+move_session(struct tls_multi *multi, int dest, int src, bool rein=
it_src)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    check_session_buf_not_used(to_link, &amp;multi-&gt;session[dest]);=
</span><br><span>     msg(D_TLS_DEBUG_LOW, &quot;TLS: move_session: dest=3D=
%s src=3D%s reinit_src=3D%d&quot;,</span><br><span>         session_index_n=
ame(dest), session_index_name(src), reinit_src);</span><br><span>     ASSER=
T(src !=3D dest);</span><br><span>     ASSERT(src &gt;=3D 0 &amp;&amp; src =
&lt; TM_SIZE);</span><br><span>     ASSERT(dest &gt;=3D 0 &amp;&amp; dest &=
lt; TM_SIZE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_=
session_free(&amp;multi-&gt;session[dest], false, to_link);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    tls_session_free(&amp;multi-&gt=
;session[dest], false);</span><br><span>     multi-&gt;session[dest] =3D mu=
lti-&gt;session[src];</span><br><span> </span><br><span>     if (reinit_src=
)</span><br><span>@@ -1116,9 +1097,9 @@</span><br><span> }</span><br><span>=
 </span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-reset_session(struct tls_multi *multi, struct tls_session *session=
, struct buffer *to_link)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+reset_session(struct tls_multi *multi, struct tls_session *session)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
tls_session_free(session, false, to_link);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    tls_session_free(session, false);</span><br><spa=
n>     tls_session_init(multi, session);</span><br><span> }</span><br><span=
> </span><br><span>@@ -1192,6 +1173,8 @@</span><br><span> tls_multi_init_fi=
nalize(struct tls_multi *multi, int tls_mtu)</span><br><span> {</span><br><=
span>     tls_init_control_channel_frame_parameters(&amp;multi-&gt;opt=2Efr=
ame, tls_mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
ulti-&gt;to_link_buf =3D alloc_buf(BUF_SIZE(&amp;multi-&gt;opt=2Eframe));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>    =
 /* initialize the active and untrusted sessions */</span><br><span> </span=
><br><span>     tls_session_init(multi, &amp;multi-&gt;session[TM_ACTIVE]);=
</span><br><span>@@ -1283,9 +1266,11 @@</span><br><span> </span><br><span> =
    for (int i =3D 0; i &lt; TM_SIZE; ++i)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        tls_session_free(&amp;m=
ulti-&gt;session[i], false, NULL);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        tls_session_free(&amp;multi-&gt;session[i], false);<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    free_buf(&amp;multi-&gt;to_link_buf);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (clear)=
</span><br><span>     {</span><br><span>         secure_memzero(multi, size=
of(*multi));</span><br><span>@@ -1816,13 +1801,13 @@</span><br><span>  * ac=
tive key=2E</span><br><span>  */</span><br><span> static void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-key_state_soft_reset(struct tls_ses=
sion *session, struct buffer *to_link)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+key_state_soft_reset(struct tls_session *session)</span>=
<br><span> {</span><br><span>     struct key_state *ks =3D &amp;session-&gt=
;key[KS_PRIMARY];        /* primary key */</span><br><span>     struct key_=
state *ks_lame =3D &amp;session-&gt;key[KS_LAME_DUCK]; /* retiring key */</=
span><br><span> </span><br><span>     ks-&gt;must_die =3D now + session-&gt=
;opt-&gt;transition_window;    /* remaining lifetime of old key */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    key_state_free(ks_lame, fa=
lse, to_link);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    k=
ey_state_free(ks_lame, false);</span><br><span>     *ks_lame =3D *ks;</span=
><br><span> </span><br><span>     key_state_init(session, ks);</span><br><s=
pan>@@ -1833,7 +1818,7 @@</span><br><span> void</span><br><span> tls_sessio=
n_soft_reset(struct tls_multi *tls_multi)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    key_state_soft_reset(&amp;tls_mu=
lti-&gt;session[TM_ACTIVE], NULL);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    key_state_soft_reset(&amp;tls_multi-&gt;session[TM_ACTIV=
E]);</span><br><span> }</span><br><span> </span><br><span> /*</span><br><sp=
an>@@ -2914,18 +2899,15 @@</span><br><span> </span><br><span>         const=
 struct buffer *buf =3D reliable_send(ks-&gt;send_reliable, &amp;opcode);</=
span><br><span>         ASSERT(buf);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        struct buffer b =3D *buf;</span><br><span>         I=
NCR_SENT;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        write_control_auth(session, ks, &amp;b, to_link_addr, opcode,=
 CONTROL_SEND_ACK_MAX, true);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        *to_link =3D b;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        write_control_auth(session, ks, buf, &amp;multi-&gt;to_=
link_buf, to_link_addr, opcode,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                           CONTROL_SEND_ACK_MAX, true);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        *to_link =3D multi-=
&gt;to_link_buf;</span><br><span>         dmsg(D_TLS_DEBUG, &quot;Reliable =
-&gt; TCP/UDP&quot;);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        /* This changed the state of the outgoing buffer=
=2E In order to avoid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
         * running this function again/further and invalidating the key_sta=
te</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * buffer a=
nd accessing the buffer that is now in to_link after it being</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-         * freed for a potential er=
ror, we shortcircuit exiting of the outer</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-         * process here=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* This changed the state of the outg=
oing buffer=2E Stop this</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+         * processing pass so that the event loop can send the packet=
=2E */</span><br><span>         return false;</span><br><span>     }</span>=
<br><span> </span><br><span>@@ -3165,13 +3147,13 @@</span><br><span>       =
      session-&gt;opt-&gt;aead_usage_limit,</span><br><span>             ks=
-&gt;crypto_options=2Ekey_ctx_bi=2Edecrypt=2Eplaintext_blocks + ks-&gt;n_pa=
ckets,</span><br><span>             session-&gt;opt-&gt;aead_usage_limit);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        key_state_soft=
_reset(session, to_link);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        key_state_soft_reset(session);</span><br><span>     }</span><=
br><span> </span><br><span>     /* Kill lame duck key transition_window sec=
onds after primary key negotiation */</span><br><span>     if (lame_duck_mu=
st_die(session, wakeup))</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        key_state_free(ks_lame, true, to_link);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        key_state_fre=
e(ks_lame, true);</span><br><span>         msg(D_TLS_DEBUG_LOW, &quot;TLS: =
tls_process: killed expiring key&quot;);</span><br><span>     }</span><br><=
span> </span><br><span>@@ -3220,8 +3202,9 @@</span><br><span>         {</sp=
an><br><span>             struct buffer buf =3D ks-&gt;ack_write_buf;</span=
><br><span>             ASSERT(buf_init(&amp;buf, multi-&gt;opt=2Eframe=2Eb=
uf=2Eheadroom));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       write_control_auth(session, ks, &amp;buf, to_link_addr, P_ACK_V1, RE=
LIABLE_ACK_SIZE, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            *to_link =3D buf;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            write_control_auth(session, ks, &amp;buf, &amp;mul=
ti-&gt;to_link_buf, to_link_addr, P_ACK_V1,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                               RELIABLE_ACK_SIZE, f=
alse);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *=
to_link =3D multi-&gt;to_link_buf;</span><br><span>             dmsg(D_TLS_=
DEBUG, &quot;Dedicated ACK -&gt; TCP/UDP&quot;);</span><br><span>         }=
</span><br><span>     }</span><br><span>@@ -3264,98 +3247,6 @@</span><br><s=
pan>     return false;</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-check_keystate_buf_not_used(struct buffer *to_l=
ink, const struct key_state *ks)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (k=
s-&gt;state =3D=3D S_UNDEF || !to_link || !to_link-&gt;data)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        return;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const uint8_t *d=
ataptr =3D to_link-&gt;data;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* we don&=
#39;t expect send_reliable to be NULL when state is</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * not S_UNDEF, but people have reporte=
d crashes nonetheless,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-     * therefore we better catch this event, report and exit=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!ks-&gt;send_reliable)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        msg(M_FATAL,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            &quot;ERROR: ks=2Esend_reliable (key-id %d=
), is NULL &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        &quot;while key state is %s=2E Exiting=2E&quot;,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            ks-&gt;key_id, state_name(ks=
-&gt;state));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    for (int j =3D 0; j &lt; ks-&gt;send_re=
liable-&gt;size; j++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ks-&=
gt;send_reliable-&gt;array[j]=2Ebuf=2Edata =3D=3D dataptr)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            msg(M_INFO,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                &quot;Warning buffer of freed TL=
S session is still in&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                &quot; use (key-id %d, ks=2Esend_reliable-&gt;array[%=
d])&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     ks-&gt;key_id, j);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto us=
ed;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (ks-&gt;ack_write_buf=2Edata =3D=3D dataptr)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;Warning buffer of freed TLS=
 session is still in use &quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    &quot;(ks=2Eack_write_buf, key-id %d)&quot;,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ks-&gt;key=
_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        goto used;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-used:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    to_link-&gt;len =3D 0;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    to_link-&gt;data =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * This is a safe guard function to double check that a buffer from a sess=
ion is</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * not used in =
a session to avoid a use after free=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 @param to_link</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @pa=
ram session</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-check_session_buf_not_used(struct buff=
er *to_link, struct tls_session *session)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (!to_link || !to_link-&gt;data)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const uint8_t *da=
taptr =3D to_link-&gt;data;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Checks b=
uffers in tls_wrap */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (session-&gt;tls_wrap=2Ework=2Edata =3D=3D dataptr)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;Warning buffer of freed TLS =
session is &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                &quot;still in use (tls_wrap=2Ework=2Edata)&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        goto used;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (session-&gt;tls_wrap_reneg=2Ework=2Edata=
 =3D=3D dataptr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &=
quot;Warning buffer of freed TLS session is &quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    &quot;still in use (tls_wr=
ap_reneg=2Ework=2Edata)&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        goto used;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; K=
S_SIZE; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        const struct key_=
state *ks =3D &amp;session-&gt;key[i];</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        check_keystate_buf_not_used(to_link, ks);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-us=
ed:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    to_link-&gt;le=
n =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    to_link-&=
gt;data =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* =
for debugging, you can add an ASSERT(0); here to trigger an abort */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span> /*</span>=
<br><span>  * Called by the top-level event loop=2E</span><br><span>  *</sp=
an><br><span>@@ -3444,11 +3335,11 @@</span><br><span>                 if (i=
 =3D=3D TM_ACTIVE &amp;&amp; ks_lame-&gt;state &gt;=3D S_GENERATED_KEYS</sp=
an><br><span>                     &amp;&amp; !multi-&gt;opt=2Esingle_sessio=
n)</span><br><span>                 {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    move_session(multi, TM_LAME_DUCK, TM_AC=
TIVE, true, to_link);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true);</=
span><br><span>                 }</span><br><span>                 else</sp=
an><br><span>                 {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    reset_session(multi, session, to_link);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    reset=
_session(multi, session);</span><br><span>                 }</span><br><spa=
n>             }</span><br><span>         }</span><br><span>@@ -3511,7 +340=
2,7 @@</span><br><span>      */</span><br><span>     if (lame_duck_must_die=
(&amp;multi-&gt;session[TM_LAME_DUCK], wakeup))</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        tls_session_free(&=
amp;multi-&gt;session[TM_LAME_DUCK], true, to_link);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tls_session_free(&amp;multi-&gt;s=
ession[TM_LAME_DUCK], true);</span><br><span>         msg(D_TLS_DEBUG_LOW, =
&quot;TLS: tls_multi_process: killed expiring key&quot;);</span><br><span> =
    }</span><br><span> </span><br><span>@@ -3526,7 +3417,7 @@</span><br><sp=
an>      */</span><br><span>     if (TLS_AUTHENTICATED(multi, &amp;multi-&g=
t;session[TM_INITIAL]=2Ekey[KS_PRIMARY]))</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        move_session(multi, TM_A=
CTIVE, TM_INITIAL, true, to_link);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        move_session(multi, TM_ACTIVE, TM_INITIAL, true);</s=
pan><br><span>         tas =3D tls_authentication_status(multi);</span><br>=
<span>         msg(D_TLS_DEBUG_LOW,</span><br><span>             &quot;TLS:=
 tls_multi_process: initial untrusted &quot;</span><br><span>@@ -3938,7 +38=
29,7 @@</span><br><span>                 goto error;</span><br><span>      =
       }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            key_state_soft_reset(session, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            key_state_soft_reset(session)=
;</span><br><span> </span><br><span>             dmsg(D_TLS_DEBUG, &quot;TL=
S: received P_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s&quot;, i,</span><br><sp=
an>                  session_id_print(&amp;sid, &amp;gc));</span><br><span>=
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span>=
<br><span>index f6392f9=2E=2Ea0f677e 100644</span><br><span>--- a/src/openv=
pn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><b=
r><span>@@ -627,6 +627,14 @@</span><br><span>      */</span><br><span>     =
struct link_socket_actual to_link_addr;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * Holds the outgoing control packet returned=
 by tls_multi_process=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * It belongs to the tls_multi and not to a session or key state, =
so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * it stays v=
alid when these are freed or moved before the packet is</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * written to the link=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer to_link_buf;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     int n_se=
ssions; /**&lt; Number of sessions negotiated thus</span><br><span>        =
              *   far=2E */</span><br><span>     enum multi_status multi_st=
ate;</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl=
_pkt=2Ec</span><br><span>index f78782f=2E=2Ed8a1cef 100644</span><br><span>=
--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec=
</span><br><span>@@ -163,10 +163,14 @@</span><br><span> }</span><br><span> =
</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-write_control_auth(struct tls_session *session, struct key_state *ks, stru=
ct buffer *buf,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
             struct link_socket_actual **to_link_addr, int opcode, int max_=
ack,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
  bool prepend_ack)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
write_control_auth(struct tls_session *session, struct key_state *ks, const=
 struct buffer *payload,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                   struct buffer *out, struct link_socket_actual **to_=
link_addr, int opcode,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                   int max_ack, bool prepend_ack)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Work on a copy s=
o that tls_wrap_control can point it at another</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * buffer without modifying the caller&#39;=
s buffer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct buffer buf =3D *payload;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>     ASSERT(ks-&gt;key_id &gt;=3D 0 &amp;&amp; ks-=
&gt;key_id &lt;=3D P_KEY_ID_MASK);</span><br><span>     ASSERT(opcode &gt;=
=3D 0 &amp;&amp; opcode &lt;=3D P_LAST_OPCODE);</span><br><span>     uint8_=
t header =3D (uint8_t)(ks-&gt;key_id | (opcode &lt;&lt; P_OPCODE_SHIFT));</=
span><br><span>@@ -181,14 +185,20 @@</span><br><span>     }</span><br><span=
> </span><br><span>     ASSERT(link_socket_actual_defined(&amp;ks-&gt;remot=
e_addr));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(r=
eliable_ack_write(ks-&gt;rec_ack, ks-&gt;lru_acks, buf, &amp;ks-&gt;session=
_id_remote, max_ack,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ASSERT(reliable_ack_write(ks-&gt;rec_ack, ks-&gt;lru_acks, &amp;buf, &=
amp;ks-&gt;session_id_remote, max_ack,</span><br><span>                    =
           prepend_ack));</span><br><span> </span><br><span>     msg(D_TLS_=
DEBUG, &quot;%s(): %s&quot;, __func__, packet_opcode_name(opcode));</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_wra=
p_control(tls_session_get_tls_wrap(session, ks-&gt;key_id), header, buf,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_wrap_control(t=
ls_session_get_tls_wrap(session, ks-&gt;key_id), header, &amp;buf,</span><b=
r><span>                      &amp;session-&gt;session_id);</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* buf now po=
ints into memory owned by ks or session (the payload&#39;s</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * buffer or the tls_wrap work b=
uffer)=2E  Either can be freed before</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * the packet is written to the link, so copy the pac=
ket to out=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ASSERT(buf_init(out, buf=2Eoffset));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ASSERT(buf_copy(out, &amp;buf));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     *to_link_addr =3D =
&amp;ks-&gt;remote_addr;</span><br><span> }</span><br><span> </span><br><sp=
an>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br=
><span>index 8203e4a=2E=2Ed02b4b0 100644</span><br><span>--- a/src/openvpn/=
ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@=
@ -185,10 +185,29 @@</span><br><span> bool check_session_hmac_and_pkt_id(st=
ruct tls_pre_decrypt_state *state, const struct openvpn_sockaddr *from,</sp=
an><br><span>                                    const uint8_t *key, int ha=
ndwindow, bool pkt_is_ack);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * Write a control channel authentication record=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Write a control channel packet: add the ACKs, the o=
pcode and session id</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * header and the tls-auth/tls-crypt wrapping to \c payload=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param session           the TLS session the =
packet belongs to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param ks                the key state the packet belongs to</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param payload           the p=
acket payload=2E Its data is left</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *                          unchanged, but the space around i=
t in its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
                 buffer is used to build the packet=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param out               buffer the f=
inished packet is written to, at</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *                          the offset it was built at=2E It m=
ust be owned</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
                     by the caller, not share memory with \c payload</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *                        =
  or the tls_wrap work buffers, and have room for</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *                          the packet at tha=
t offset (a buffer of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *                          BUF_SIZE() of the session&#39;s frame does)=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param to_lin=
k_addr      set to the address the packet is sent to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param opcode            opcode of the=
 packet</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ma=
x_ack           maximum number of ACKs to add</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param prepend_ack       add the ACKs in front=
 of the payload instead</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *                          of writing them into it</span><br><span>  *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void write_control_a=
uth(struct tls_session *session, struct key_state *ks, struct buffer *buf,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void write_control_a=
uth(struct tls_session *session, struct key_state *ks,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        const struct buf=
fer *payload, struct buffer *out,</span><br><span>                         =
struct link_socket_actual **to_link_addr, int opcode, int max_ack,</span><b=
r><span>                         bool prepend_ack);</span><br><span> </span=
><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_=
tests/openvpn/test_pkt=2Ec</span><br><span>index 51c73d8=2E=2E120f98f 10064=
4</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><sp=
an>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -741,6 +7=
41,108 @@</span><br><span>     free_tas(&amp;tas);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* writ=
e_control_auth() writes the finished packet to the out buffer of the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * caller, so the packet s=
tays valid when the buffers of the session and key</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * state are reused or freed before it is se=
nt=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_write_control=
_auth_out_buf(struct tls_wrap_ctx *wrap, struct tls_wrap_ctx *peer_wrap)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct tls_options opt =3D { 0 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    opt=2Eserver =3D t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct tls_session session =3D=
 { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session=
=2Eopt =3D &amp;opt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    session=2Etls_wrap =3D *wrap;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    session=2Esession_id =3D (struct session_id){ { 1, 2, 3,=
 4, 5, 6, 7, 8 } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct reliable=
_ack rec_ack =3D { =2Elen =3D 1, =2Epacket_id =3D { 7 } };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct reliable_ack lru_acks =3D=
 { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct k=
ey_state ks =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ks=2Erec_ack =3D &amp;rec_ack;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ks=2Elru_acks =3D &amp;lru_acks;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ks=2Esession_id_remote =3D (struct s=
ession_id){ { 8, 7, 6, 5, 4, 3, 2, 1 } };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ks=2Eremote_addr=2Edest=2Eaddr=2Esa=2Esa_family =
=3D AF_INET;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks=
=2Eremote_addr=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D htonl(0x01020304=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t data[] =3D &quot;c=
ontrol channel payload&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct buffer payload =3D alloc_buf(1600);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer out =3D alloc_buf(16=
00);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* a control packet with the A=
CK in front of its payload, as sent from</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * the reliability layer, and a dedicated ACK pack=
et */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i=
 =3D 0; i &lt; 2; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st bool dedicated_ack =3D (i =3D=3D 1);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        const size_t len =3D dedicated_ack ? 0 : sizeof=
(data);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(buf_init(&a=
mp;payload, 200));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       assert_true(buf_write(&amp;payload, data, len));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        struct link_socket_actual *to_link_addr =3D NULL;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        write_contro=
l_auth(&amp;session, &amp;ks, &amp;payload, &amp;out, &amp;to_link_addr,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
     dedicated_ack ? P_ACK_V1 : P_CONTROL_V1, RELIABLE_ACK_SIZE,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                           !de=
dicated_ack);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_ptr_equal(=
to_link_addr, &amp;ks=2Eremote_addr);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        assert_int_equal(BLEN(&amp;payload), len);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_memory_equa=
l(BPTR(&amp;payload), data, len);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        assert_true(BLENZ(&amp;out) &gt; len);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        /* the packet is still intact after the sessi=
on buffers are overwritten */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        memset(payload=2Edata, 0x55, payload=2Ecapacity);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (session=2Etls_w=
rap=2Ework=2Edata)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 memset(session=2Etls_wrap=2Ework=2Edata, 0x55, session=2Etls_wrap=2Ework=
=2Ecapacity);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        struct link_socket_actual f=
rom =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   assert_true(read_control_auth(&amp;out, peer_wrap, &amp;from, &amp;opt))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct reliable_ack ack;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct session_i=
d sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        asser=
t_true(reliable_ack_parse(&amp;out, &amp;ack, &amp;sid));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        assert_int_equal(ack=2Elen, 1=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_in=
t_equal(ack=2Epacket_id[0], 7);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        assert_memory_equal(&amp;sid, &amp;ks=2Esession_id_remo=
te, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   assert_int_equal(BLEN(&amp;out), len);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        assert_memory_equal(BPTR(&amp;out), data, len=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    free_buf(&amp;out);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    free_buf(&amp;payload);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_wri=
te_control_auth_out_buf(void **ut_state)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    now =3D 0x22446688;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct t=
ls_wrap_ctx none =3D { =2Emode =3D TLS_WRAP_NONE };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    check_write_control_auth_out_buf(&amp=
;none, &amp;none);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_=
standalone tas_client =3D init_tas_auth(KEY_DIRECTION_INVERSE);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone =
tas_server =3D init_tas_auth(KEY_DIRECTION_NORMAL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas_client=2Etls_=
wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas_server=2Etl=
s_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    reset_packet_id_send(&amp;tas_cli=
ent=2Etls_wrap=2Eopt=2Epacket_id=2Esend);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    check_write_control_auth_out_buf(&amp;tas_client=
=2Etls_wrap, &amp;tas_server=2Etls_wrap);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    packet_id_free(&amp;tas_client=2Etls_wrap=2Eopt=
=2Epacket_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p=
acket_id_free(&amp;tas_server=2Etls_wrap=2Eopt=2Epacket_id);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    free_tas(&amp;tas_client);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_tas(&amp;tas_s=
erver);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    tas_client =3D init_tas_cry=
pt(false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_s=
erver =3D init_tas_crypt(true);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    packet_id_init(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id=
, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    packet_id_init(&amp;tas_server=2Etls_wrap=2Eopt=2Epacket_=
id, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    reset_packet_id_send(&amp;tas_client=2Etls_wrap=2Eopt=
=2Epacket_id=2Esend);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    check_write_control_auth_out_buf(&amp;tas_client=2Etls_wrap, &amp;tas=
_server=2Etls_wrap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    packet_id_free(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas_=
server=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    free_tas(&amp;tas_client);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    free_tas(&amp;tas_server);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> static void</span><br><span> test_e=
xtract_control_message(void **ut_state)</span><br><span> {</span><br><span>=
@@ -792,6 +894,7 @@</span><br><span>         cmocka_unit_test(test_generate=
_reset_packet_plain),</span><br><span>         cmocka_unit_test(test_genera=
te_reset_packet_tls_auth),</span><br><span>         cmocka_unit_test(test_w=
kc_not_appended_without_key),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test(test_write_control_auth_out_buf),</span>=
<br><span>         cmocka_unit_test(test_extract_control_message)</span><br=
><span>     };</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail">change 2002</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I379c36e1557178d22=
d3ee27cd6ed51b5c3a2e793 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2002 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Alejandro &lt;alepacheco99@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--Wskxe5fEGJA=--


--===============6522715244713297260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6522715244713297260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6522715244713297260==--

