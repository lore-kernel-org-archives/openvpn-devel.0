Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC54C43327
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 00:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=K+13wmrzZLKm1cMjgIqAZxnOrx9Bdd6jskcZ1njupJQ=; b=hTbVi/7Ktgz3XO
	fsOAVlYow8SNEcI6ASsK68epIcIDy1LdumriMaPp+B/8JmN9Hh+SezTVtFQ20DkSuMojtqd50SRDA
	oY5wGAPPtCDzQWe4ei05Lwfud8n1oTSMSUHj2v3KjujwSpfEsITzqq30rqkqMpNY6YELVuDMzPw0v
	xLQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdzz3-0001YD-7L;
	Mon, 29 Jun 2026 00:36:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wdzz2-0001Y7-N6
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 00:36:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eWY61wkb3pvrCsepNPnKr76zCqucfyf+K43MMCfdcec=; b=fEtXIrB+JhO6xC4EtBztex/77X
 /aXnMbT86pqOpEuAnGkrd2fmkyQTIst5TD/KHLiWmWvVCBXdbxB8QwWYQ3sisTXjBDEAghuNWeDCj
 q7WxLeEc945zUV2TFifeJZNQ8qp3eBrOKyY57shr7h9bwn7PAnwzgxmgaAIzMBmjhsbc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eWY61wkb3pvrCsepNPnKr76zCqucfyf+K43MMCfdcec=; b=d
 Xw11FJOuD2L7adz9+j/mf7O0geFBbdeH5HwZSTrVuzcL3KBF0Kj4W2Nw/sJcTarqGatXSnX5BLGEH
 171uE+ZT7nkIhqkMQrzhkbS2OI5DT+QZVsjR3wkd2dFjMW/zVdO2qAyvbqunWdMs2kqScVub8+eX+
 dC68KE5UmwYdRBgE=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wdzyx-0003Bm-At for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 00:36:18 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so19942145e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 28 Jun 2026 17:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782693364; x=1783298164; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eWY61wkb3pvrCsepNPnKr76zCqucfyf+K43MMCfdcec=;
 b=FM/foJUvtAG6Rea8FYc4nB8VUF4HZmCNMT2Ap9naytDQ+kdRpRmyCQvaCK2L9lgOj6
 nloTZNl7aazcAnN6SUz8pNL5ehG64Vj5cQXinG85u+W0c8Y2GT3EKLCzcVwxNSQ/fh0q
 x+ElbuIlG4kIVellIbP//FfK8BBDSArXs6+MSQ85E5mdPo7F/KOMPz+CeyVF2HArMNpw
 C6nGUyoVuR5SZv0K4XoHdp3ZldkB0RRrXTT0RVMM0rXSMhHYthCClniqCm0fHC45oT6O
 PG1ppgaQzAEiea2uuzEQJP97i1bFaak5tBPx1mYVgwhqz0mWfeGrcwn6lJPA6/UD5J+I
 jJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782693364; x=1783298164;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eWY61wkb3pvrCsepNPnKr76zCqucfyf+K43MMCfdcec=;
 b=m7ortXppJirj7EfGgFXj/j4lwGiRpqwZKY1qwY+5kO3KZJCPHjnf2Y7MydWAedC5Ph
 KjzZwQQO8GInDnqSVc6KXUrVMt/mOO8UQaRejacCmJ6Lrf1TeRypF4GjsIJZqGm4KPOR
 v0SPyVOkleFtnJsfvvJC/vqh1wak9Jn1tkZUTAVguMm1Jf4O5RPegIFMrBQ8ZGVfkd1Q
 GWavGc3M4CYq1ALUmSQnUrYEzc2X9aMnR5x9Eha3cKM6Qzf+GzmylT5Nz2c8aZwffdMe
 7cetQh2555y0RcO1TIxkOPUEUJ/QotqkcpSSJKMCvaOW1nWy7Lwci37Ozu+gFN2XZpF3
 rCwg==
X-Gm-Message-State: AOJu0YwprjRGqdv6SLeBzRVw4CLjdksUNHEBvv8zigt2lukzssd9XzAO
 LAEI2aRTDTIKsFxI56YNvbPiHleO3j+DOBrimkA1+2Cyi2ztnJMoiDnA4py3wmFr6AxZnbwxhhE
 3jdszGqczH+on51LSqWLfEgn1eelhrKXppTxZd8t5iq3h9FaIyAPx8rtKITUC9pjjWQXP
X-Gm-Gg: AfdE7cm+dIKZfYP8S6T5IrTJ8fhCUAuTrabhA9N1bH8hMQj3IEWGPJ80cbH9R+J4gsK
 Mp41ipB8Pm9WzuY2ynic6awuUZ0oK5/T5C7GDHVfm+KvnTRSL5qqZmfxceKR4Pjnrj/e76tX7Qh
 jOOAXwo+qFCncop1JHRhGnF6+YmdK0pwOnfekJO+9KlrBUm/z5noXUcPAKQk6KCBCFYMTlOlrIL
 SLmjXnNkBU8F1psiFq5a1Kf6dqn3RLxTU9SYKOFyk4ShLxHKn7vSnWKC6zz0/QvAoTsPA9nzqGg
 GhR8f5BsF+M0rXZ+Ctu2MIVf5kuYRlokwWtzp6+iIZ3Fg1yhKZUyG64og4Ypycm6iBEjCYZ+O8j
 TD4wcnygjIKqi987UZHa6sEqy2t1uT14T3mjKo9f1jvWYXRHrcEIVmQJCtEjJfyzPAk2eRmIQNB
 +XUL7SDWn4zm16VmIYw0lQsy5lDcdc7WHZZjZ0h9k7z2t1JzAYO/v9Vi0DTKx67Nj5b/dTtITYU
 q6OhN30vEDxv2kiO4Vcb+kW6fd4JUzy4dHVRloydAulLGO3MZ6D1iWV9zYNHhfh9iJjKZqvAr1U
 F1g=
X-Received: by 2002:a05:600c:6812:b0:493:a515:c7a8 with SMTP id
 5b1f17b1804b1-493a515c881mr74227325e9.5.1782693364146; 
 Sun, 28 Jun 2026 17:36:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fce5a8sm265454365e9.3.2026.06.28.17.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 17:36:03 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 00:36:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I46a9ef71359f42395d69cf899c948014fb72f65a
X-Gerrit-Change-Number: 1738
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1738?usp=email>
X-Gerrit-Commit: 6fc9258c4765a02f21fb47063fed4cace474f606
References: <gerrit.1782693360000.I46a9ef71359f42395d69cf899c948014fb72f65a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNjkzMzYwMDAwLkk0NmE5ZWY3MTM1OWY0MjM5NWQ2OWNmODk5Yzk0ODAxNGZiNzJmNjVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <877f34479c6b4e9823d181eb20b0ffa1ef49b8ea-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wdzyx-0003Bm-At
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_linux: drop the
 now-redundant __is_locked re-entrancy guard
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
Content-Type: multipart/mixed; boundary="===============0104095838651974349=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0104095838651974349==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="h5o7y7UhNLQ="; charset=UTF-8

--h5o7y7UhNLQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1738?usp=3Demail

to review the following change=2E


Chang=
e subject: dco_linux: drop the now-redundant __is_locked re-entrancy guard
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_linux: dr=
op the now-redundant __is_locked re-entrancy guard

__is_locked existed onl=
y to stop setenv_stats() from issuing a GET_PEER
request/reply while the sh=
ared socket was still being drained for a batch
of notifications, which cou=
ld fail with NLE_BUSY/NLE_NOMEM or re-enter
nl_recvmsgs() on the busy socke=
t=2E Now that notifications are read on a
dedicated socket and GET_PEER goe=
s to the request/reply socket, the two
never share an nl_recvmsgs() call: t=
he request/reply socket no longer
dispatches notifications, so multi_proces=
s_incoming_dco() (the only path
that reaches dco_get_peer() during message =
parsing) never runs while that
socket is in flight, and the flag is always =
false at its check=2E Remove
the flag, its set/clear and the early return=
=2E

Change-Id: I46a9ef71359f42395d69cf899c948014fb72f65a
Signed-off-by: An=
tonio Quartulli <antonio=2Equartulli@openvpn=2Ecom>
---
M src/openvpn/dco_l=
inux=2Ec
1 file changed, 4 insertions(+), 18 deletions(-)



  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/38/1738/1

diff --git =
a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index 7a0f620=2E=2E=
199a11b 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=
=2Ec
@@ -49,16 +49,6 @@
 #include <netlink/genl/family=2Eh>
 #include <netl=
ink/genl/ctrl=2Eh>
 
-/* When parsing multiple DEL_PEER notifications, open=
vpn tries to request stats
- * for each DEL_PEER message (see setenv_stats)=
=2E This triggers a GET_PEER
- * request-reply while we are still parsing t=
he rest of the initial
- * notifications, which can lead to NLE_BUSY or eve=
n NLE_NOMEM=2E
- *
- * This basic lock ensures we don't bite our own tail b=
y issuing a dco_get_peer
- * while still busy receiving and parsing other m=
essages=2E
- */
-static bool __is_locked =3D false;
-
 /* libnl < 3=2E5=2E0=
 does not set the NLA_F_NESTED on its own, therefore we
  * have to explici=
tly do it to prevent the kernel from failing upon
  * parsing of the messag=
e
@@ -170,12 +160,14 @@
     return ret;
 }
 
+/* Drain the request/reply s=
ocket=2E Used to read command/stats replies=2E This
+ * socket is never sub=
scribed to the multicast group, so it cannot deliver an
+ * asynchronous no=
tification: a reply being parsed here can therefore never
+ * trigger an in=
stance close or a re-entrant request on the same socket=2E */
 static int
 =
ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)
 {
-    __is_locke=
d =3D true;
     int ret =3D nl_recvmsgs(dco->nl_sock, dco->nl_cb);
-    __=
is_locked =3D false;
 
     return ovpn_nl_recvmsgs_report(ret, prefix);
 }=

@@ -1222,12 +1214,6 @@
 {
     ASSERT(dco);
 
-    if (__is_locked)
-    {=

-        msg(D_DCO_DEBUG, "%s: cannot request peer stats while parsing oth=
er messages", __func__);
-        return 0;
-    }
-
     /* peer_id =3D=3D=
 -1 means "dump all peers", but this is allowed in MP mode only=2E
      * =
If it happens in P2P mode it means that the DCO peer was deleted and we
   =
   * can simply bail out

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1738?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I46a9ef71359f42395d69cf899c948014fb72f65a
Gerrit-Change-Number: 1738
=
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>

--h5o7y7UhNLQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1738?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">dc=
o_linux: drop the now-redundant __is_locked re-entrancy guard<br><br>__is_l=
ocked existed only to stop setenv_stats() from issuing a GET_PEER<br>reques=
t/reply while the shared socket was still being drained for a batch<br>of n=
otifications, which could fail with NLE_BUSY/NLE_NOMEM or re-enter<br>nl_re=
cvmsgs() on the busy socket=2E Now that notifications are read on a<br>dedi=
cated socket and GET_PEER goes to the request/reply socket, the two<br>neve=
r share an nl_recvmsgs() call: the request/reply socket no longer<br>dispat=
ches notifications, so multi_process_incoming_dco() (the only path<br>that =
reaches dco_get_peer() during message parsing) never runs while that<br>soc=
ket is in flight, and the flag is always false at its check=2E Remove<br>th=
e flag, its set/clear and the early return=2E<br><br>Change-Id: I46a9ef7135=
9f42395d69cf899c948014fb72f65a<br>Signed-off-by: Antonio Quartulli &lt;anto=
nio=2Equartulli@openvpn=2Ecom&gt;<br>---<br>M src/openvpn/dco_linux=2Ec<br>=
1 file changed, 4 insertions(+), 18 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/38/1738/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec=
</span><br><span>index 7a0f620=2E=2E199a11b 100644</span><br><span>--- a/sr=
c/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</sp=
an><br><span>@@ -49,16 +49,6 @@</span><br><span> #include &lt;netlink/genl/=
family=2Eh&gt;</span><br><span> #include &lt;netlink/genl/ctrl=2Eh&gt;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* When =
parsing multiple DEL_PEER notifications, openvpn tries to request stats</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * for each DEL_PEER mess=
age (see setenv_stats)=2E This triggers a GET_PEER</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * request-reply while we are still parsing th=
e rest of the initial</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * notifications, which can lead to NLE_BUSY or even NLE_NOMEM=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * This basic lock ensures we don&#39;t bite our o=
wn tail by issuing a dco_get_peer</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * while still busy receiving and parsing other messages=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static bool __is_locked =3D false;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* libnl &lt=
; 3=2E5=2E0 does not set the NLA_F_NESTED on its own, therefore we</span><b=
r><span>  * have to explicitly do it to prevent the kernel from failing upo=
n</span><br><span>  * parsing of the message</span><br><span>@@ -170,12 +16=
0,14 @@</span><br><span>     return ret;</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Drain the requ=
est/reply socket=2E Used to read command/stats replies=2E This</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * socket is never subscribed to=
 the multicast group, so it cannot deliver an</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * asynchronous notification: a reply being parse=
d here can therefore never</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * trigger an instance close or a re-entrant request on the same soc=
ket=2E */</span><br><span> static int</span><br><span> ovpn_nl_recvmsgs(dco=
_context_t *dco, const char *prefix)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    __is_locked =3D true;</span><br><span=
>     int ret =3D nl_recvmsgs(dco-&gt;nl_sock, dco-&gt;nl_cb);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    __is_locked =3D false;</span><=
br><span> </span><br><span>     return ovpn_nl_recvmsgs_report(ret, prefix)=
;</span><br><span> }</span><br><span>@@ -1222,12 +1214,6 @@</span><br><span=
> {</span><br><span>     ASSERT(dco);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (__is_locked)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        msg(D_DCO_DEBUG, &quot;%s: cannot request peer sta=
ts while parsing other messages&quot;, __func__);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span>     /* peer_id =3D=3D -1 means &quot;dump all pee=
rs&quot;, but this is allowed in MP mode only=2E</span><br><span>      * If=
 it happens in P2P mode it means that the DCO peer was deleted and we</span=
><br><span>      * can simply bail out</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1738?us=
p=3Demail">change 1738</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1738?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I46a9ef71359f42395d69cf899c948014fb72f65a </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1738 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--h5o7y7UhNLQ=--


--===============0104095838651974349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0104095838651974349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0104095838651974349==--

