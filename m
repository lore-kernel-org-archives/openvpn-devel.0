Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB01606A31D
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b4gIsQYZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZE9qhUaa;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LsqLgulL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=W62k9hXz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=Z4qM647fhyr0dZ99duTpIH+3d/5EaaWt0cby6KrwpPc=; b=b4gIsQYZHT668hQu5r1fwAGUXt
	J0VPHWNdn09lVgoDvr+WVAWEcnr88c5yy/n3K1+VXE0rqrLp/qUeMVsuCbp1ESZQTiZoWFBLsiY0D
	ETBu8ymCYNs8qSpAT+Pztj+XDkqbihaDwSM0WkOwVAHsZ23iD4RIdjmpTk3xFDegs1z0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM6wE-000000002av-3jZk;
	Wed, 28 Oct 2026 16:55:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM6vu-000000002aX-1tcW
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 16:55:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VqdhWAQIVuVC8s0qjiwbDbF0JTTwr+qlYrIsS8OhH24=; b=ZE9qhUaaiH3jmCRCaBAlhkeQr1
 viZ93vaP/HCz0+XhPMByFLyCCEAljttuzM8OAp80u0jThAVuShf6OGKDOki9Qvbqjn1Z/uy6Se8NQ
 3bYUHfXOPNbM+5G1g6FlipCGxup9PPgq9yTENpJSrR0IqQGUithQwbhJ6D0A1DfI/0b8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VqdhWAQIVuVC8s0qjiwbDbF0JTTwr+qlYrIsS8OhH24=; b=LsqLgulL64Ch7ffRCgK40mhDi4
 5w1Hyze0OSR8qVUpIO+jkvmgfLhxu7FsU/JqiBEOaNKHQiGOuMNRyCSKc80Bbaq+AJxT6PHMHNHUO
 OJLZYrtwT7uPnD0Q/SrM70H8sKRKXvvsDZW/AxxFvfTnixTQ/eg7sQNb6otgr7vIVe9M=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM6vg-000000004cv-2Od6 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 16:55:14 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso639060f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793206506; x=1793811306; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VqdhWAQIVuVC8s0qjiwbDbF0JTTwr+qlYrIsS8OhH24=;
 b=W62k9hXzOwYfzd4JmpzwB3Ffl+9NFhRgfVhPi6DFdI+m0UlGcS9QKMZGUXbRBCFRT6
 Psh4VbIy/4Q07N5dBap8r/F2cZ7zkW6NxpqE2Xvs7wZpl/UBMk93vTETgH1Ft+LXUrpy
 ATYS8KxWjgULER1GhQRwIbNgOmGE8b3WwdYSYx00E4zJ1MbCy9751yN9iFhFsdu1ObYB
 g3PZ0N75q9f9uC8Z5d6KTQZCGNTXt5hXLFdkQMi+YbQi5W7VHAAcQ2gvtTdiMiFYQENj
 QbCUlXAB07eAKyCwfkm7YPDICDv+fXVIngS9AJV20AyYhNINTcQahnfh0+pfCNCUr9oS
 Ar3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793206506; x=1793811306;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VqdhWAQIVuVC8s0qjiwbDbF0JTTwr+qlYrIsS8OhH24=;
 b=j/GtP5CT4fqicBMDAnhlxxI4di7qAhpxBlnCDIdtVaJ98USUpqVKXoivjkDF0Udl0I
 kvhltO9QsfjVaQbmUAG7POYw141BEdZCk1W4+AZPMcq7CcMu0SCMjJmaEu1mMz2X22Sd
 Qc3Vf3wOhH22twEr3qQNFK74hSK1VM/jnv9GoB4bNhQymmAyoOKZnZXnbZScrJvSAncS
 NWZzaexGtOKgZ4XSZjW/1zgD0bbTjRxvgO+2tOVkMhDVGlLfkW2w5+gHqvssZCYbdkkM
 Wkmv7nXBVWpGfbpz0ar521njAxVrwfQ3COXDm8zjTuafTsArDJDzskRsYgzhg1WOUxJv
 b+hQ==
X-Gm-Message-State: AFq9FYKXTOJts71ec5QGbbQZlDPPqZtLFG+Op/MTPKauxfdWSq7nc4/U
 0vYYqW0U4i8yQLHAXymc5hdN+6QA44TnT7TjMTWA4OkjMxW7ekrXER29U5kPS/YM2jJXtnYo3FI
 oWdRQSWtlneLQroVbWrH9yjX7uuzijfXwNZdys0RBWHHAIfL+6cg9nOTLBqs7u03MyKbHK79Oud
 sjx4+sZw==
X-Gm-Gg: AYBFou0FAE/YKCA6i50hLZ1DGbp/crBTf5NTAg5IyzSdi1K3ibaOxtUlXx069XoNFfz
 1lW/ohUvVuekRDoNOKtd9gMo37Bpx6D40QosX4At680rCTQqXVo8Z4/ZzXFgwndGRwKTzUPjUW3
 sD/aTqu4trA9ZKNTttKdvZ7YPGQcDGD06tUB7KIFTvZNg8wt/SNrO53DjkJFLROmqIlkVZoyWkw
 Xqtk7WMXpD+f9TPFwc4FkpqFVb2vqyOuyPqWdG2jrltZuOA8lhgA5sdlrtgBv/i5PRorAPhcOJs
 I2DdZNGlpIjykkg9XCQqlG1qzuzp84djtHU9ql4kUui28E5Hjn2LwpYkvxTsLw71vg8UCwe/AlT
 hHXQsm1inqBJrAiEx8kwn2qYZHE1QftzR1cfiDZoHqAm7+x5tj9i2m/G5sItE3hZnO35eSGNv/q
 Ivoc50wroFaS91H5ZI7uIHel9bTkKlO4IzVkx1Zead0KD2Lculq6jUBCA6K5UoXJ6MEzbVnyjqD
 HiFlvO4GEComNd6cvKZ3o0Jy0s2r0eH7MpkxrFjJZTrANQRvXE2ttZ9L/pabMwel3mGArDrIIve
 sro7cHZQiPd9O2y+bfOE0IJS92R3shkUKXOtTOveXVQ3UpKgl/esynotU9tSU77eHa8qmXQsdHX
 W122T0IWAXCGXNaJa1+9H6YgBBvRnV2OKEVcjWOCop51mu/Asr7lodQkXVFurkuxypqu9OpJRBX
 dwYSbjwSeS0/S7gQQ=
X-Received: by 2002:a05:6000:4203:b0:48e:35d4:55b5 with SMTP id
 ffacd0b85a97d-48e5d312084mr6776360f8f.52.1793206505596; 
 Wed, 28 Oct 2026 09:55:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd49afsm29707038f8f.35.2026.10.28.09.55.05
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:55:05 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 16:55:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If8ae9cbc971f60800a998abf2f97da0384c023f3
X-Gerrit-Change-Number: 2067
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2067?usp=email>
X-Gerrit-Commit: 8841b1dbf2dc7ca506222cbd8f8bb9266cc26a97
References: <gerrit.1793206499000.If8ae9cbc971f60800a998abf2f97da0384c023f3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjA2NDk5MDAwLklmOGFlOWNiYzk3MWY2MDgwMGE5OThhYmYyZjk3ZGEwMzg0YzAyM2YzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2de8917f8be0155ec4c12a73e8fbe8d7580e6084-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xM6vg-000000004cv-2Od6
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Do not hash real
 addresses of TCP connection
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2155728736347365538=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2155728736347365538==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nY5GxYA+D7Y="; charset=UTF-8

--nY5GxYA+D7Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2067?usp=3Demail )


Change subject: Do not hash real=
 addresses of TCP connection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Do not hash real addresses of TCP connection

With neither=
 status report nor max-client depending on TCP
connections in m->hash anymo=
re, remove hashing of TCP
connection=2E

This now allows an obscure corner =
case of two TCP clients coming
from the same IP and port to different IP or=
 port on the server
but as our operating system can handle this case, we do=
 not have
a problem with that either=2E

This has a small added benefit to =
keep the number of entries in
m->hash a bit smaller=2E

Change-Id: If8ae9cb=
c971f60800a998abf2f97da0384c023f3
Signed-off-by: Arne Schwabe <arne@rfc2549=
=2Eorg>
---
M src/openvpn/multi=2Ec
1 file changed, 9 insertions(+), 0 dele=
tions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/67/2067/1

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
i=
ndex 055305d=2E=2E98172db 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/open=
vpn/multi=2Ec
@@ -2487,6 +2487,15 @@
 multi_client_connect_real_addr(struct=
 multi_context *m, struct multi_instance *mi,
                             =
   bool deferred, uint64_t *option_types_found)
 {
+    if (proto_is_tcp(mi=
->real=2Eproto))
+    {
+        /* For TCP connection we neither need to b=
e able to map incoming
+         * DATA_V1 packets to the multi_instance no=
r do we need to ensure
+         * that two TCP connections are not using t=
he same address as the
+         * OS takes care of that=2E */
+        ret=
urn CC_RET_SUCCEEDED;
+    }
+
     /* If the address is already taken up b=
y another client we fail the new
      * connection */
     if (!multi_chec=
k_dest_addr_allowed(m, mi, &mi->real))

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2067?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: If8ae9cbc971f60800a998abf2f97da0384c023f3
Gerrit-Ch=
ange-Number: 2067
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>

--nY5GxYA+D7Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Do not hash real addresses of TCP connection<br><br>With neith=
er status report nor max-client depending on TCP<br>connections in m-&gt;ha=
sh anymore, remove hashing of TCP<br>connection=2E<br><br>This now allows a=
n obscure corner case of two TCP clients coming<br>from the same IP and por=
t to different IP or port on the server<br>but as our operating system can =
handle this case, we do not have<br>a problem with that either=2E<br><br>Th=
is has a small added benefit to keep the number of entries in<br>m-&gt;hash=
 a bit smaller=2E<br><br>Change-Id: If8ae9cbc971f60800a998abf2f97da0384c023=
f3<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M sr=
c/openvpn/multi=2Ec<br>1 file changed, 9 insertions(+), 0 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/67/2067/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/ope=
nvpn/multi=2Ec</span><br><span>index 055305d=2E=2E98172db 100644</span><br>=
<span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=
=2Ec</span><br><span>@@ -2487,6 +2487,15 @@</span><br><span> multi_client_c=
onnect_real_addr(struct multi_context *m, struct multi_instance *mi,</span>=
<br><span>                                bool deferred, uint64_t *option_t=
ypes_found)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (proto_is_tcp(mi-&gt;real=2Eproto))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* For TCP connection we neither need to be abl=
e to map incoming</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       * DATA_V1 packets to the multi_instance nor do we need to ensure</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         * that two TCP=
 connections are not using the same address as the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * OS takes care of that=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return CC_RET_SUC=
CEEDED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* I=
f the address is already taken up by another client we fail the new</span><=
br><span>      * connection */</span><br><span>     if (!multi_check_dest_a=
ddr_allowed(m, mi, &amp;mi-&gt;real))</span><br></pre><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?usp=3Demail">change=
 2067</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: If8ae9cbc971f60800a998abf2f97da0384c023f3 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2067 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--nY5GxYA+D7Y=--


--===============2155728736347365538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2155728736347365538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2155728736347365538==--

