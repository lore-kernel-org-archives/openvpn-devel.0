Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08C2C5DF81
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=DboWEfr78/PpVAtigmsMnZH2g8udcCXIM7auu7PfYvM=; b=ggUgC1NwtuFE00
	Bqu2H/dKueZWmT6LwEPYD5DFUaQ8/RAUowCo/4aEpogH+0Pq67mpmWgBuAyVNWkz2cNv9FH1N7ik7
	vzgKRPWUSOW5LNVCIYNy9kVx/UMyd9cLpgRk8Njq1UPmSaXtdkzJRfh1Sn7+yv0seH1qEUw+oOE7Q
	mmE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwhSz-0007Gs-Vt;
	Wed, 19 Aug 2026 14:40:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwhSj-0007FV-AB
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 14:40:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OvFewRkfgjWqNqSJjnZRh33AgLZeLdPthqQ6rpmLjBU=; b=TEz9Pqb/LNNxRNpxjN7OyMGNDj
 uXYbT8HlxzV5zyU9j1H48hEkYdID/RZfGhVswDpH1NTjqubvHhLOJZXStYzcGb3sBwtiMal2HYvCk
 Wa4evxw0STJttG8scycQNfwcFgbmSR905TGjqN3OffFRuW5KfQWckfJXPf0XblnApINg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OvFewRkfgjWqNqSJjnZRh33AgLZeLdPthqQ6rpmLjBU=; b=a
 tRs+ljYB96rk7650OhScNSzdQVAh5XuCyrP05Yz+4yxKiFpq9DNgsEdsQyIlT3/i4VFN4OP0eKQhi
 9cXgX7pV4tRjWEUaCWY6eNn/UG9/Y+M+kMSurMZacXXL1RyPvWqc6YnQB0nsIqU2tkEYdilyO3PYg
 Hv/lfjR/GxlgD7vo=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwhSi-0004TC-3q for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 14:40:18 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso9330665e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787150409; x=1787755209; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OvFewRkfgjWqNqSJjnZRh33AgLZeLdPthqQ6rpmLjBU=;
 b=Z9PiIQ3m7nU2U5u7ffNPoZ8gyD3JIbt0iqoYbsueAQ8XMZ9tGv2S9sYq5X7apFiI8S
 qVblN55/4E7EgdWf4Sinb4cerb0I7J3GJfZBWKRjYtyesFqIk4QeFpuezz+Z+r36fBXK
 OHs2NAbJulcg6xeDZ35TU69WaGlPjRYJTilzj5mZGVLSj6jq+r61D6TMNoiGNWrszS6h
 A+P1YqzqRLa/BINfSGmtoDhJjOJ8qMo5aZuUJJYYl9UioK7lllj/KCK1RVDiDGIwq/qD
 jmo9WnybFQOOccjfUwLjSsKptoXBZNjr5BCVw9sxS4JSqxknYT2mZ9Vq6qhSrAZAVjE8
 nr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787150409; x=1787755209;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OvFewRkfgjWqNqSJjnZRh33AgLZeLdPthqQ6rpmLjBU=;
 b=RQ4BkRUcNMTynPgsnXcebmmtaNV/+LAKi8yCLItrR+9sSTJ8YyvQ8sxOlbnm06nte6
 4eE3IVmo12HWcQmxBK9ddz9T0NZ2UZSbP7twZXmieUMffmCxgHfZlMR0/zgR4P8lq/TL
 x6TxIVujs58pkLlSdbNFyxl1X4nEfHEwE/rxhz4olHyApoXn0SYlcydnWKue4ZpCZgf0
 KjJpFq/VaQzYwMgDCCnrKW1Jh4rhwrnMTOceExjBULizDj/qTBnUWGG90JrRv04k7JEd
 0+X2Tit1uKT7mOxzQF3D7AghzHSSy2V4fB/Mz+vVnYxbgjF/Y+eJ+EXTgDFa3Xu3R4uP
 FDSw==
X-Gm-Message-State: AOJu0YzecQvUewOzVUkCt5vYzZaDsvD3UnzIu4BPD19CQtJkZT1vpwhG
 wJ3qc+xS5qZ3SK3FYHH3kOiRHVm7uh7C9hfU7ncMmI1HKiHLYEoPZ0u3Yy9nBR2dibBDwaCH9bQ
 OaGcs4sJyOCfH0Lqg1j1OdO04MCGNylW8oiw2Ju4B2N0Rt7/mBkjozLFFXsIhGiSOuYO7fT4KMU
 LWWaLjZQ==
X-Gm-Gg: AR+sD11mS6evoLwc7Udep/2CRnPTNwA80HFJp5sme+QSN8yAQecW48Z+NBwQUMQtEiZ
 lN63L4u65Qp3ScpR+DDlESJSAW/xJh+EwjCLRX4nPtPqL7J+BhhS+zvlJpdav7otApYgRW4Oq+V
 YCRhUEFv53NCrHFi61DuBdSanL7gK7VUXg0zNvHic/oJL+BIgB15eoxzorWHN+GrB0/BAEsz67p
 p0IMYmSiy2zTz/svG8RAA4dZl9mokQSW5ECJrd1HSA4iGyc4yxxtNq4Ki6HyYWlO7jLGZPyEuOf
 k6zEM135xBH3V+cTwqDUclVRTKoyorv9cY6z+9TrN6/hxfCPXwxlQFC4i5Ib7/7XwnWIhJa1CiB
 pqMETnbDKpd0yGlxBJSQctsX/XEVrku0pf1CxwtlGrqbQP4BstwEGvw2nnQ8nibLYCUCUQFTC9D
 +W3uU+1L9KkUhLg1jg29gQ+TyVsd9ugkXRqRv8FWeJmEGJIn8zmD3XcwB2ekC6SvCBayHmPEEEZ
 TIKm0tV/aCetokW330ph7q/mTa8dk0H6Vh0soffYlnShBlR+jOJL59jIFVkT8QOoB4iw0acE1EP
 u494ocwfpaMCrjwSWfUsNnjWCBt7toTiOsYele0qp740PBOfpa4uBhNy5iQ0u7A=
X-Received: by 2002:a05:600c:4ec9:b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-499aa167256mr91273215e9.7.1787150409257; 
 Wed, 19 Aug 2026 07:40:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa09b199sm58153545e9.0.2026.08.19.07.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 07:40:08 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 14:40:08 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I57b4122b292f643ddedd91e81bf95fe2f5b2e03a
X-Gerrit-Change-Number: 1850
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1850?usp=email>
X-Gerrit-Commit: a9543c4fe3e3411894b6e65fa4291211337b4d98
References: <gerrit.1787150406000.I57b4122b292f643ddedd91e81bf95fe2f5b2e03a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTUwNDA2MDAwLkk1N2I0MTIyYjI5MmY2NDNkZGVkZDkxZTgxYmY5NWZlMmY1YjJlMDNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <97d9a2ce88f702c3356968c3d03598498d38d61f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwhSi-0004TC-3q
Subject: [Openvpn-devel] [S] Change in openvpn[master]: doc: Update doxygen
 references to removed tunnel_server_{udp, tcp}()
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3676578867771651808=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3676578867771651808==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dgvJYrhNpv8="; charset=UTF-8

--dgvJYrhNpv8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1850?usp=3Demail

to review the following change=2E


Chang=
e subject: doc: Update doxygen references to removed tunnel_server_{udp,tcp=
}()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

doc: Up=
date doxygen references to removed tunnel_server_{udp,tcp}()

The point-to-=
multipoint server event loop is no longer split into
protocol-specific tunn=
el_server_udp() and tunnel_server_tcp()
functions; tunnel_server() now hand=
les both UDP and TCP=2E

Update the Doxygen module documentation accordingl=
y: list
tunnel_server() as the server-mode event loop implementation, and
r=
ewrite the server-mode startup, initialization and cleanup sections
so that=
 they describe tunnel_server() instead of the removed
functions=2E

Documen=
tation only, no functional change=2E

Change-Id: I57b4122b292f643ddedd91e81=
bf95fe2f5b2e03a
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
=
M doc/doxygen/doc_eventloop=2Eh
M doc/doxygen/doc_tunnel_state=2Eh
2 files =
changed, 11 insertions(+), 14 deletions(-)



  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/50/1850/1

diff --git a/doc/doxygen/d=
oc_eventloop=2Eh b/doc/doxygen/doc_eventloop=2Eh
index 55ecd73=2E=2E4c1b012=
 100644
--- a/doc/doxygen/doc_eventloop=2Eh
+++ b/doc/doxygen/doc_eventloop=
=2Eh
@@ -60,6 +60,5 @@
  * event loop function is called to drive the event=
 processing=2E  The
  * following implementations are available:
  * - Clie=
nt mode using UDP or TCP: \c tunnel_point_to_point()
- * - Server mode usin=
g UDP: \c tunnel_server_udp()
- * - Server mode using TCP: \c tunnel_server=
_tcp()
+ * - Server mode using UDP or TCP: \c tunnel_server()
  */
diff --g=
it a/doc/doxygen/doc_tunnel_state=2Eh b/doc/doxygen/doc_tunnel_state=2Eh
in=
dex 296e804=2E=2E424f81e 100644
--- a/doc/doxygen/doc_tunnel_state=2Eh
+++ =
b/doc/doxygen/doc_tunnel_state=2Eh
@@ -117,10 +117,10 @@
  * tunnel_point_t=
o_point() or \c tunnel_server()=2E
  *
  * In server-mode, \c main() calls =
the \c tunnel_server() function, which
- * transfers control to \c tunnel_s=
erver_udp() or \c
- * tunnel_server_tcp() depending on the external transpo=
rt protocol=2E
+ * drives the event loop for both the UDP and TCP external =
transport
+ * protocols=2E
  *
- * These functions receive the \c context c=
reated in \c main()=2E  This
+ * This function receives the \c context crea=
ted in \c main()=2E  This
  * object has a special status in server-mode, a=
s it does not represent an
  * active VPN tunnel, but does contain process-=
wide configuration
  * parameters=2E  In the source code, it is often store=
d in "top" variables=2E
@@ -130,11 +130,10 @@
  * CM_CHILD_UDP or \c CM_CHI=
LD_TCP, depending on the external transport
  * protocol=2E
  *
- * Both \c=
 tunnel_server_udp_single_threaded() and \c tunnel_server_tcp()
- * perform=
 similar initialization=2E  In either case, a \c multi_context
- * structur=
e is created, and it is initialized according to the
- * configuration stor=
ed in the top \c context by the \c multi_init() and
- * \c multi_top_init()=
 functions=2E
+ * During initialization, \c tunnel_server() creates a \c mu=
lti_context
+ * structure, which is initialized according to the configurat=
ion stored
+ * in the top \c context by the \c multi_init() and \c multi_to=
p_init()
+ * functions=2E
  *
  * @subsection tunnel_state_server_tunnels C=
reating and destroying VPN tunnels
  *
@@ -146,8 +145,7 @@
  *
  * @subsect=
ion tunnel_state_server_cleanup Final cleanup
  *
- * After the main event =
loop exits, both \c
- * tunnel_server_udp_single_threaded() and \c tunnel_s=
erver_tcp() perform
- * similar cleanup=2E  They call \c multi_uninit() fol=
lowed by \c
- * multi_top_free() to clean up the \c multi_context structure=
=2E
+ * After the main event loop exits, \c tunnel_server() performs the
+ =
* cleanup=2E  It calls \c multi_uninit() followed by \c multi_top_free()
+ =
* to clean up the \c multi_context structure=2E
  */

-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1850?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I57b4122b292f643ddedd91e81bf95fe2f5b2e03a=

Gerrit-Change-Number: 1850
Gerrit-PatchSet: 1
Gerrit-Owner: razvanc <razva=
nc@mailbox=2Eorg>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--dgvJYrhNpv8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>razvanc would like plaisthos to =
<strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1850?usp=3Demail">View Change</a></p><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
doc: Update doxygen references to removed tunnel_server_{udp,tcp}()<br><br>=
The point-to-multipoint server event loop is no longer split into<br>protoc=
ol-specific tunnel_server_udp() and tunnel_server_tcp()<br>functions; tunne=
l_server() now handles both UDP and TCP=2E<br><br>Update the Doxygen module=
 documentation accordingly: list<br>tunnel_server() as the server-mode even=
t loop implementation, and<br>rewrite the server-mode startup, initializati=
on and cleanup sections<br>so that they describe tunnel_server() instead of=
 the removed<br>functions=2E<br><br>Documentation only, no functional chang=
e=2E<br><br>Change-Id: I57b4122b292f643ddedd91e81bf95fe2f5b2e03a<br>Signed-=
off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M doc/doxyg=
en/doc_eventloop=2Eh<br>M doc/doxygen/doc_tunnel_state=2Eh<br>2 files chang=
ed, 11 insertions(+), 14 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/50/1850/1</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/doc/doxygen/doc_eventloop=2Eh b/doc/doxygen/doc_eventloop=2Eh</s=
pan><br><span>index 55ecd73=2E=2E4c1b012 100644</span><br><span>--- a/doc/d=
oxygen/doc_eventloop=2Eh</span><br><span>+++ b/doc/doxygen/doc_eventloop=2E=
h</span><br><span>@@ -60,6 +60,5 @@</span><br><span>  * event loop function=
 is called to drive the event processing=2E  The</span><br><span>  * follow=
ing implementations are available:</span><br><span>  * - Client mode using =
UDP or TCP: \c tunnel_point_to_point()</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * - Server mode using UDP: \c tunnel_server_udp()</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * - Server mode using TCP: \=
c tunnel_server_tcp()</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * - Server mode using UDP or TCP: \c tunnel_server()</span><br><span>  *=
/</span><br><span>diff --git a/doc/doxygen/doc_tunnel_state=2Eh b/doc/doxyg=
en/doc_tunnel_state=2Eh</span><br><span>index 296e804=2E=2E424f81e 100644</=
span><br><span>--- a/doc/doxygen/doc_tunnel_state=2Eh</span><br><span>+++ b=
/doc/doxygen/doc_tunnel_state=2Eh</span><br><span>@@ -117,10 +117,10 @@</sp=
an><br><span>  * tunnel_point_to_point() or \c tunnel_server()=2E</span><br=
><span>  *</span><br><span>  * In server-mode, \c main() calls the \c tunne=
l_server() function, which</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * transfers control to \c tunnel_server_udp() or \c</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * tunnel_server_tcp() depending on the=
 external transport protocol=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * drives the event loop for both the UDP and TCP external tran=
sport</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * protocols=
=2E</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * These functions receive the \c context created in \c main()=2E  This</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This function rece=
ives the \c context created in \c main()=2E  This</span><br><span>  * objec=
t has a special status in server-mode, as it does not represent an</span><b=
r><span>  * active VPN tunnel, but does contain process-wide configuration<=
/span><br><span>  * parameters=2E  In the source code, it is often stored i=
n &quot;top&quot; variables=2E</span><br><span>@@ -130,11 +130,10 @@</span>=
<br><span>  * CM_CHILD_UDP or \c CM_CHILD_TCP, depending on the external tr=
ansport</span><br><span>  * protocol=2E</span><br><span>  *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * Both \c tunnel_server_udp_single_t=
hreaded() and \c tunnel_server_tcp()</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * perform similar initialization=2E  In either case, a \c m=
ulti_context</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * struct=
ure is created, and it is initialized according to the</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * configuration stored in the top \c cont=
ext by the \c multi_init() and</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * \c multi_top_init() functions=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * During initialization, \c tunnel_server() creat=
es a \c multi_context</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * structure, which is initialized according to the configuration stored<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * in the top \c con=
text by the \c multi_init() and \c multi_top_init()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * functions=2E</span><br><span>  *</span=
><br><span>  * @subsection tunnel_state_server_tunnels Creating and destroy=
ing VPN tunnels</span><br><span>  *</span><br><span>@@ -146,8 +145,7 @@</sp=
an><br><span>  *</span><br><span>  * @subsection tunnel_state_server_cleanu=
p Final cleanup</span><br><span>  *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * After the main event loop exits, both \c</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * tunnel_server_udp_single_threaded() =
and \c tunnel_server_tcp() perform</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * similar cleanup=2E  They call \c multi_uninit() followed by=
 \c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * multi_top_free(=
) to clean up the \c multi_context structure=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * After the main event loop exits, \c tunnel_s=
erver() performs the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * cleanup=2E  It calls \c multi_uninit() followed by \c multi_top_free()<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to clean up the \=
c multi_context structure=2E</span><br><span>  */</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1850?usp=3Demail">change 1850</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1850?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I57b4122b292f643ddedd91e81bf95fe2f5b2e03a <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 1850 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body=
></html>
--dgvJYrhNpv8=--


--===============3676578867771651808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3676578867771651808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3676578867771651808==--

