Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0454C98321
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 12:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wD+g/hSjxpvQXXbRDVhxCiwmT5BI+F8pOio1Q1HHUG4=; b=dOM7++5UBbCBHUFU7v3CstDQ3e
	wtSKq4KRtlQ0BIrO9bp15t5Ot5X/a/ThF7pZHdGcy0Rs5uE6/hu/Ib3T/eP6a867U5mVYEAMLGfIl
	FkYMoWrYLnm7pjuS4pW+IXkBd6C8+C3vvJhljbVf4fZ4lxYTN4ib7mfxbVgtA4iJceiA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA5Bb-00055M-5T;
	Fri, 25 Sep 2026 12:37:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA5Ba-00055C-5w
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 12:37:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tMTX57TT+HyTqyhB2VDsM1/aOKS5eX+W2g+SoRiOI/g=; b=es2YfNPWCVsPmhVrKPK4JRiALq
 xVJduTAFSNsULAudSJGnlgR7iVvWrid75oaRIaJDPcRJl/JZNsKNZXaUYPQ9SnmmE2M+Gd4iICbUL
 m4S+S+Id513+Tv7oIcQkRtSVYCacoviurdEsE+QRup74dhn64RF4kwcgZ2pYJnmkAqNw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tMTX57TT+HyTqyhB2VDsM1/aOKS5eX+W2g+SoRiOI/g=; b=l
 JpGdFgEKFqkUCs+ElBLCcq3VjDNTOT9dkNu//i7SWsg7LIMMtiAoKpFYOsjd3cBRpOMV+LG7aqNuU
 47SMTyDvihsnp2aruwGFjrDMqS8ex7wFaeLQRQIkABq8Fjj4pQ14S14npI8+8AKZ3pdvZplEKTDYN
 1ze/n8dUfhJx6YOg=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA5BZ-0006cv-95 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 12:37:54 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so5278755e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 05:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790339867; x=1790944667; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tMTX57TT+HyTqyhB2VDsM1/aOKS5eX+W2g+SoRiOI/g=;
 b=QtdkJ8e+ymoIlY0bTEVFUNHO20CGBj9DAv7YkxVg+39Lsskd/kfuJ3JCxdNUXxBA7M
 +8NWmLjklu2V4QZJesrQ/Zn68tlRZhHcY2HFgHht6znDGXBqiiKXuq77zIUaqA8x2cZE
 qjZuQc0o88G9zEVq4ZCF0o63/fUhj2XFVLUdebsuQcrj3lV8C+Bpavg0cqqJe5As37ES
 RJRsGeSm0xHG8nNjqlEs6crnhPHZLIGsY1A6eImtcDGEFFDFZb2DV9lYIT1Npc/JbJx0
 Ijws/i6ItsR8XlvM/+v+aKimfpEkrSuZHObJD0KuaetwcaBVWEVbPyKkg5AmA9+KyXFE
 6nWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790339867; x=1790944667;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tMTX57TT+HyTqyhB2VDsM1/aOKS5eX+W2g+SoRiOI/g=;
 b=xBReQTg2f50Ku925JISASFe6pywdJpiUqnm8NrYDyRiYH2Z7CGjqxDRrPFKJVKg4Iu
 TeOZlyHbdCTYIcsnzcOWDYoGnzlrxueoTCo5jsMCgcSqOCz6PQ0/OlgyDoZLhOB+EQvS
 HKCzs3iSDZq9538VZFaYoDskChl17/Ry2Z3cpGN9iycqTPY92zn2GYF+fq7ms+siH5tz
 9wpeRolH/sRS3cvC8wfA/5Xs4ElZHBJWTPSxJQhUzIUUuNEauFMYeq5NWnKx6+2iJkgB
 9Sj1MiNGmaBBubfsj56FrMTPt/S6ZWyIPgMJUaK1scDl6n6i/vgiRcnPT3Ji/qwsEXSr
 m0nA==
X-Gm-Message-State: AFuF++mCiSDJSaHsrpzV9Wn83C+p/6SoXq6yJcQd8+8S6cyZqBnDZyB0
 DlWFSg0OIE7vR13sXLXnJZtu6YEiddA2T3SVAz2MOrhmjao7HPcI9bS0w/QppoGTD0fN/Nsu1v+
 asfbJlsq3uXEwyajUNoJq6HXtdggcJiiJL1MpfqV2FYBwejEJccbYaa6WXvsTXwaWwBfx
X-Gm-Gg: AYBFou3puta8otOa+Yq4XDtxKHfVcT/0kV0aUo/hlDMQWpiIy308kTgN1s9HqhfiOEy
 hJsduTFYwTP/ic9+CzSfUUxeDbVsLDGoLGDXv70BK3w3ykoNR70PUqPFZNOFPli/sRedcsLK9ZC
 7TPwldj8btwp5eQzIt66SD2NLvQZwjvlPhQFHoob7D18nRhCSgbrMUCuf4YYkq97y2wWT/YVDv8
 uaZTOscUOzlC++jCQZdv2vd8NjR2JlgW55uL5l3AxrHH8Yeg1k0IhRIB/VESGQ6pzRhAcUsdAM9
 3O2URcLod350Dny8fCJsfn3bvYTcuF79CQmB/wCl/J/2dkBxmwBnx6MorijdRgqv/3WXK10sT5H
 8xY3PhZFVuY4TTxD9WQOn8Um2dm10/bCW8WSSHp8RTNi1i6AovBCDkGrLbHkD9z34r0qbbTOvxo
 zMMjV8yeVH1NEyYGFVhjVZEXUIil9AgY1tiQ9qyJXVTIBkoO29H34SEduUs6+9KnroUeiK+prua
 7DolwaojcqMDZ2jVVaLuHowEFAYXE7pzg7G8iU0PGDediX+ENbbx2nCBa3CmuNT+zTb2x6JWLMw
 CULy0Ke0IDKEbw5W5klfqMGWYhSmVsNhtCtRDLuCbPRyStw7rzbeGyPsylq0
X-Received: by 2002:a05:600c:6986:b0:49c:fa21:e73c with SMTP id
 5b1f17b1804b1-49fe66f147bmr97977025e9.18.1790339866554; 
 Fri, 25 Sep 2026 05:37:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0f1f2e3sm90781775e9.0.2026.09.25.05.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 05:37:45 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 12:37:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I46a9ef71359f42395d69cf899c948014fb72f65a
X-Gerrit-Change-Number: 1738
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1738?usp=email>
X-Gerrit-Commit: 694e3b11c0e339919efd77ed7a8fe93346bfc21c
In-Reply-To: <gerrit.1782693360000.I46a9ef71359f42395d69cf899c948014fb72f65a@gerrit.openvpn.net>
References: <gerrit.1782693360000.I46a9ef71359f42395d69cf899c948014fb72f65a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNjkzMzYwMDAwLkk0NmE5ZWY3MTM1OWY0MjM5NWQ2OWNmODk5Yzk0ODAxNGZiNzJmNjVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d14e9a259af7ed7e055195446a4b7f8ba8b7775a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA5BZ-0006cv-95
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
Content-Type: multipart/mixed; boundary="===============8408662029207296811=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8408662029207296811==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JqKnkAAtRgs="; charset=UTF-8

--JqKnkAAtRgs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1738?usp=3Demail

to look at the new patch set (#2)=2E

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
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/38/1738/2

diff --git a/src=
/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index 56f6259=2E=2Ee4d4e=
c5 100644
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
133,12 +123,16 @@
     return NULL;
 }
 
+/**
+ * Drain the request/reply s=
ocket=2E Used to read command/stats replies=2E This
+ * socket is never sub=
scribed to the multicast group, so it cannot deliver an
+ * asynchronous no=
tification: a reply being parsed here can therefore never
+ * trigger an in=
stance close or a re-entrant request on the same socket=2E
+ */
 static int=

 ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)
 {
-    __is_loc=
ked =3D true;
     int ret =3D nl_recvmsgs(dco->nl_sock, dco->nl_cb);
-    =
__is_locked =3D false;
 
     switch (ret)
     {
@@ -1173,12 +1167,6 @@
 {=

     ASSERT(dco);
 
-    if (__is_locked)
-    {
-        msg(D_DCO_DEBUG,=
 "%s: cannot request peer stats while parsing other messages", __func__);
-=
        return 0;
-    }
-
     /* peer_id =3D=3D -1 means "dump all peers"=
, but this is allowed in MP mode only=2E
      * If it happens in P2P mode =
it means that the DCO peer was deleted and we
      * can simply bail out

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1738?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I46a9ef71359f42395=
d69cf899c948014fb72f65a
Gerrit-Change-Number: 1738
Gerrit-PatchSet: 2
Gerri=
t-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--JqKnkAAtRgs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex <strong>uploaded patch set=
 #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
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
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/38/1738/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><span=
>index 56f6259=2E=2Ee4d4ec5 100644</span><br><span>--- a/src/openvpn/dco_li=
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
n>  * parsing of the message</span><br><span>@@ -133,12 +123,16 @@</span><b=
r><span>     return NULL;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Drain the request/reply socket=2E Used to rea=
d command/stats replies=2E This</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * socket is never subscribed to the multicast group, so it can=
not deliver an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * as=
ynchronous notification: a reply being parsed here can therefore never</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * trigger an instance c=
lose or a re-entrant request on the same socket=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span> static int</span><br><s=
pan> ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    __is_locked =
=3D true;</span><br><span>     int ret =3D nl_recvmsgs(dco-&gt;nl_sock, dco=
-&gt;nl_cb);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    __is_=
locked =3D false;</span><br><span> </span><br><span>     switch (ret)</span=
><br><span>     {</span><br><span>@@ -1173,12 +1167,6 @@</span><br><span> {=
</span><br><span>     ASSERT(dco);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (__is_locked)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(D_DCO_DEBUG, &quot;%s: cannot request peer stat=
s while parsing other messages&quot;, __func__);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span>     /* peer_id =3D=3D -1 means &quot;dump all peer=
s&quot;, but this is allowed in MP mode only=2E</span><br><span>      * If =
it happens in P2P mode it means that the DCO peer was deleted and we</span>=
<br><span>      * can simply bail out</span><br></pre><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1738?usp=3Demail">change =
1738</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1738?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I46a9ef71359f42395d69cf899c948014fb72f65a </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1738 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;=
antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--JqKnkAAtRgs=--


--===============8408662029207296811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8408662029207296811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8408662029207296811==--

