Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ACBC98321
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 13:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Av6WwFs1MRbNZhL8PM2Gu/tTZvI9Y8gRF+5OselwNo0=; b=Gef8RxnrEhFLOo8DZk3SxQSdIm
	OJL/JgYg6pvv3FeRG+c4UBLfPH1WcMAbHy8EG0uNICkvgHMzp9R1LTiW6jSaQq3hYm4RCaS+xmQz3
	vUliB2+1ePhfQ8gSfDETOKMtKNhlIdy8Nbvom/KcWZZpnutOrvAMJBiqWfSlgrlUZ528=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA5cB-0006wT-G3;
	Fri, 25 Sep 2026 13:05:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA5cA-0006wM-J0
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 13:05:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5M0Jc3yTTHMzJPTIJ96GG5l8cWkSj7kD9MU+5D//7rI=; b=leRVKCYoRe83BzhGsgWhjzQDX7
 Ua5mfWvtCz9z+8PQhnOoJ1ciP52oGjTIM8FFLaXJ1wx+kYDMifNgNmPAmuE1JGAy1VmAvjhJGW2id
 JDofhgj9y46PvIqAmwC8oUGaD7ehl5yWSyhT8Dx5+1AxBFKMceIE+A3OqqYh7euxDJtw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5M0Jc3yTTHMzJPTIJ96GG5l8cWkSj7kD9MU+5D//7rI=; b=N
 8uB3dTrxVfgIEMJJZW5d36LcLmyoX19J3pQ3S/+W+HfPVOKRTwfNPKbFNuyIqVdyndpRJObRBBcbe
 UOVyoGPWVvaZH7FHVN3Fc/VuUjRPmwF7SIJdGjtbjFD9x61J0bqQVSDxaEJ6NryTuwO4OCfcNrds/
 sDpoPkCSHt2Uwwfc=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA5c9-0007Ft-LK for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 13:05:23 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso6019125e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 06:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790341515; x=1790946315; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5M0Jc3yTTHMzJPTIJ96GG5l8cWkSj7kD9MU+5D//7rI=;
 b=LtYr5qfF5HUx9I1Us0tz16bCEpPO2IjuAFpTeyph+EEIhLyRD6+yXOBUuTRIzZNxsT
 RU0vEMtE9pLSJOTpt7m9Ni/JDYP6Asy7fn+GEOCtkEVSpwDIq9BJjRtqdf6HTEldHKmQ
 C/MrQsppSG6Czy8z/zrR5HiuqqtkfdVilGW3SSvEuVxwtzQvlVZZ7tgUKxA5nH5Ch+CA
 tPUNkiStjOo3ErzEAuyO1Rarr4g1kubAxYeK/vH/ZJ0ZYqcaJuckCW7qDqZHPi2Xv5IU
 zgOHTkBpONF3gzOFADHbRe8OBTWD7OfZxNTLCTAH/1s47g8iD/89xwqZnu52GR3KdjVg
 Io7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790341515; x=1790946315;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5M0Jc3yTTHMzJPTIJ96GG5l8cWkSj7kD9MU+5D//7rI=;
 b=joWyv/TnGL/SKOFVrcehIsKLCoF7n/dBg8nHkLZCuQg2SAIerEYCkQdk0VrnLc+OGR
 Iy6E7u1sCdMcdQFoJWFksDiZlL9zf61Xk43Zhif46w+ZYb+/8KfGhzwvfBBlR7BamTED
 WpsJOKPy7wN5AIkP+L2pzqcV9yXwwhC09doJGm+BK24nXRmZoAl+5hHn51gTmFVRKhaI
 tzDfv0IXsP7eOeolbw+vCXBaurFd68/JB0zSF74BzkQijojXKjffzv0pZDrPVE92YT20
 8RXQ3VUz2yfQ8uJ7usZsQerdC1P/qGnK2teWlitPx9MpWhvfnTtIYS8YvFHhtQVmKTYY
 s0fQ==
X-Gm-Message-State: AFuF++lerelQDEJxgRSoF1hi9nHAh1eKiyBtXPiAdWbs/q2+J5QZubwy
 HLSN91xF27txiBib6vGHgOWOD06FzCAZRwp6im+aKu28uLQhL8SFM0hYuSNTcn3WJxtgL64ouSV
 t0ado/e8HOXtVdEe446XVLNFAaj2r05KjpvTH6VQwghv9LiZgXa/HfCzukhGya9fXgtVYchdYtj
 ukh9FSjg==
X-Gm-Gg: AYBFou35fSuhZcH0gx9Vtu886s2YrKzvHSJIUB2QUOnnOv4KCpRzzAnRscdTBKmJ5Tf
 TCQ/M0YFS8KclueawJXoSujOjXy3JFQVU77YG95EbybSarDKDWcyjfKXCkWPP5UfsjEGdKxk+m2
 c7MiFCuPL3yYrA1lp95z5ZXyNXeKpkVUiKuYkC2YGc8zipp0F0wTa8RbGbinrFZSELl5AsGN7LP
 iyxKnOUDWzpZmVDLrCDotVCTgBNeZ5aYzzewSHSISQXGOKfG1++8qxpGw60csAUZDBnQRDxKmtH
 IjokFAMx6sSg81C1AjLxa6hr2UdBFVMswLpu5XxGPawOw8ekSkCszq2jUVZ2ZL2J/EKHOSonR0M
 ony1MmVNtASCanbVSSbeiO+QsEME5HAvcN0byOXvVBZHjrL0dQ3h0fKM/pLy8WiwbfiEGuZnI3f
 fL7c4z2eQ9hxUTznM+9+P0XbsurdQ8BqgUHBkk608iFazCiEkYweVbnHwNk3Sm7jXSVvvd+TROk
 8FXmW28kpRUSzbQMDWB8729Agvz/FjujeLTRjIg9BOlRfFAqUGVq4htPf9Z7WxMPb4OFPJMnXKX
 p8HB1IQyhBsHFbj1/aqkk2tWgD6m28od0havdJZs5V1KzO/uuJXfnJxC2HxZ
X-Received: by 2002:a05:600c:3b01:b0:49f:bd3c:bc27 with SMTP id
 5b1f17b1804b1-49fe6712096mr98901345e9.34.1790341514936; 
 Fri, 25 Sep 2026 06:05:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a34a4e9sm6016351f8f.11.2026.09.25.06.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:05:14 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 13:05:10 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I46a9ef71359f42395d69cf899c948014fb72f65a
X-Gerrit-Change-Number: 1738
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1738?usp=email>
X-Gerrit-Commit: 235e8730afd06d8b6cd75d8422c2e64089d5ffbe
In-Reply-To: <gerrit.1782693360000.I46a9ef71359f42395d69cf899c948014fb72f65a@gerrit.openvpn.net>
References: <gerrit.1782693360000.I46a9ef71359f42395d69cf899c948014fb72f65a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNjkzMzYwMDAwLkk0NmE5ZWY3MTM1OWY0MjM5NWQ2OWNmODk5Yzk0ODAxNGZiNzJmNjVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dcb30982c2b11981132834f8614bb9539471ce55-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA5c9-0007Ft-LK
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
Content-Type: multipart/mixed; boundary="===============8460742850852075717=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8460742850852075717==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OiEtNCZBoHE="; charset=UTF-8

--OiEtNCZBoHE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1738?usp=3Demail

to look at the new patch set (#3)=2E

=

Change subject: dco_linux: drop the now-redundant __is_locked re-entrancy =
guard
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_lin=
ux: drop the now-redundant __is_locked re-entrancy guard

__is_locked exist=
ed only to stop setenv_stats() from issuing a GET_PEER
request/reply while =
the shared socket was still being drained for a batch
of notifications, whi=
ch could fail with NLE_BUSY/NLE_NOMEM or re-enter
nl_recvmsgs() on the busy=
 socket=2E Now that notifications are read on a
dedicated socket and GET_PE=
ER goes to the request/reply socket, the two
never share an nl_recvmsgs() c=
all: the request/reply socket no longer
dispatches notifications, so multi_=
process_incoming_dco() (the only path
that reaches dco_get_peer() during me=
ssage parsing) never runs while that
socket is in flight, and the flag is a=
lways false at its check=2E Remove
the flag, its set/clear and the early re=
turn=2E

Change-Id: I46a9ef71359f42395d69cf899c948014fb72f65a
Signed-off-by=
: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M src/openvpn/dco_linux=
=2Ec
1 file changed, 6 insertions(+), 18 deletions(-)


  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/38/1738/3

diff --git a/src=
/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index 27f4f99=2E=2Ee5836=
96 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@=
@ -49,16 +49,6 @@
 #include <netlink/genl/family=2Eh>
 #include <netlink/ge=
nl/ctrl=2Eh>
 
-/* When parsing multiple DEL_PEER notifications, openvpn tr=
ies to request stats
- * for each DEL_PEER message (see setenv_stats)=2E Th=
is triggers a GET_PEER
- * request-reply while we are still parsing the res=
t of the initial
- * notifications, which can lead to NLE_BUSY or even NLE_=
NOMEM=2E
- *
- * This basic lock ensures we don't bite our own tail by issu=
ing a dco_get_peer
- * while still busy receiving and parsing other message=
s=2E
- */
-static bool __is_locked =3D false;
-
 /* libnl < 3=2E5=2E0 does =
not set the NLA_F_NESTED on its own, therefore we
  * have to explicitly do=
 it to prevent the kernel from failing upon
  * parsing of the message
@@ -=
170,12 +160,16 @@
     return ret;
 }
 
+/**
+ * Drain the request/reply so=
cket=2E Used to read command/stats replies=2E This
+ * socket is never subs=
cribed to the multicast group, so it cannot deliver an
+ * asynchronous not=
ification: a reply being parsed here can therefore never
+ * trigger an ins=
tance close or a re-entrant request on the same socket=2E
+ */
 static int
=
 ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)
 {
-    __is_lock=
ed =3D true;
     int ret =3D nl_recvmsgs(dco->nl_sock, dco->nl_cb);
-    _=
_is_locked =3D false;
 
     return ovpn_nl_recvmsgs_report(ret, prefix);
 =
}
@@ -1223,12 +1217,6 @@
 {
     ASSERT(dco);
 
-    if (__is_locked)
-    =
{
-        msg(D_DCO_DEBUG, "%s: cannot request peer stats while parsing ot=
her messages", __func__);
-        return 0;
-    }
-
     /* peer_id =3D=
=3D -1 means "dump all peers", but this is allowed in MP mode only=2E
     =
 * If it happens in P2P mode it means that the DCO peer was deleted and we
=
      * can simply bail out

-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1738?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I46a9ef71359f42395d69cf899c948014fb72f65a
Gerrit-Change-Number: =
1738
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>

--OiEtNCZBoHE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex <strong>uploaded patch set=
 #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1738?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">dco_linux=
: drop the now-redundant __is_locked re-entrancy guard<br><br>__is_locked e=
xisted only to stop setenv_stats() from issuing a GET_PEER<br>request/reply=
 while the shared socket was still being drained for a batch<br>of notifica=
tions, which could fail with NLE_BUSY/NLE_NOMEM or re-enter<br>nl_recvmsgs(=
) on the busy socket=2E Now that notifications are read on a<br>dedicated s=
ocket and GET_PEER goes to the request/reply socket, the two<br>never share=
 an nl_recvmsgs() call: the request/reply socket no longer<br>dispatches no=
tifications, so multi_process_incoming_dco() (the only path<br>that reaches=
 dco_get_peer() during message parsing) never runs while that<br>socket is =
in flight, and the flag is always false at its check=2E Remove<br>the flag,=
 its set/clear and the early return=2E<br><br>Change-Id: I46a9ef71359f42395=
d69cf899c948014fb72f65a<br>Signed-off-by: Antonio Quartulli &lt;antonio@man=
delbit=2Ecom&gt;<br>---<br>M src/openvpn/dco_linux=2Ec<br>1 file changed, 6=
 insertions(+), 18 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/38/1738/3</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><span=
>index 27f4f99=2E=2Ee583696 100644</span><br><span>--- a/src/openvpn/dco_li=
nux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br><span>@@ =
-49,16 +49,6 @@</span><br><span> #include &lt;netlink/genl/family=2Eh&gt;</=
span><br><span> #include &lt;netlink/genl/ctrl=2Eh&gt;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-/* When parsing multiple=
 DEL_PEER notifications, openvpn tries to request stats</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * for each DEL_PEER message (see setenv_=
stats)=2E This triggers a GET_PEER</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * request-reply while we are still parsing the rest of the in=
itial</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * notifications=
, which can lead to NLE_BUSY or even NLE_NOMEM=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * This basic lock ensures we don&#39;t bite our own tail by issui=
ng a dco_get_peer</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * w=
hile still busy receiving and parsing other messages=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-static bool __is_locked =3D false;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> /* libnl &lt; 3=2E5=2E0 does=
 not set the NLA_F_NESTED on its own, therefore we</span><br><span>  * have=
 to explicitly do it to prevent the kernel from failing upon</span><br><spa=
n>  * parsing of the message</span><br><span>@@ -170,12 +160,16 @@</span><b=
r><span>     return ret;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Drain the request/reply socket=2E Used to read=
 command/stats replies=2E This</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * socket is never subscribed to the multicast group, so it cann=
ot deliver an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * asy=
nchronous notification: a reply being parsed here can therefore never</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * trigger an instance cl=
ose or a re-entrant request on the same socket=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span> static int</span><br><sp=
an> ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    __is_locked =
=3D true;</span><br><span>     int ret =3D nl_recvmsgs(dco-&gt;nl_sock, dco=
-&gt;nl_cb);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    __is_=
locked =3D false;</span><br><span> </span><br><span>     return ovpn_nl_rec=
vmsgs_report(ret, prefix);</span><br><span> }</span><br><span>@@ -1223,12 +=
1217,6 @@</span><br><span> {</span><br><span>     ASSERT(dco);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (__is_loc=
ked)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO_DEBUG, &quot;%s=
: cannot request peer stats while parsing other messages&quot;, __func__);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* peer_id =3D=3D -1=
 means &quot;dump all peers&quot;, but this is allowed in MP mode only=2E</=
span><br><span>      * If it happens in P2P mode it means that the DCO peer=
 was deleted and we</span><br><span>      * can simply bail out</span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1738?usp=3Demail">change 1738</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1738?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I46a9ef71359f42395d69cf899c948014fb72f65a </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1738 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> =
Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></=
html>
--OiEtNCZBoHE=--


--===============8460742850852075717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8460742850852075717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8460742850852075717==--

