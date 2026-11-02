Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616FB606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=g1o5ShKZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=j2Ai89Pa;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ht6eohnh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=F+55lQHm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kuELKHajYhphgIrap7TqJYdcd37Sl9F8TdSiaOxgCpo=; b=g1o5ShKZQ0Fwq+4Hl81jPdKhlE
	mBdFCQdhVl1D7picmrXn/fFe9ib4MnBDmdJugJx+IWY5yp3MKvIY/N6aVe5NSTq6DoiI3dpD7ksSa
	NLMEUZWqccNxeTgwvjy7SajOizWgo0JrTTxzYqcp44+xggveF2jRS78HB1J1dycUjFpw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNzen-000000007Bl-0QhF;
	Mon, 02 Nov 2026 21:33:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNzel-000000007Be-1XRR
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:33:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wrMJpxg0JgevZOggLxppQITnu+GWSIRBQTcDjwNGFSo=; b=j2Ai89PaTXEs+LCTpIV0EwcyXY
 zXXrL+pNSqzgnA0znPMXaQ5QdpVUaJun6bx/YNGHr5Mydx4Wrbb2jQX2OwjDTduCZvg0v+H74kaAo
 7ctLQYB1hlIlCKcD9BpoEFGA37m3Yj2OyRNtdjlm3iJAKQncwJgw0RxfJiPTeuZWM2k0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wrMJpxg0JgevZOggLxppQITnu+GWSIRBQTcDjwNGFSo=; b=Ht6eohnhA2Qxn/e6ynjWSc0KP7
 VcIvWbrdHMRxQPtBPW2wMpQ0A3n97fT+1C+6i9eEsI7/DRuml06/TboQ6Kyr6zPer8/QZKnGwEv7X
 GXQUWeMlTpvAewLWSwMOcyq/vyuWykNjeE+abWOBLGaNol43VI71vtOzQjJHhZrFPV78=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNzej-000000005h5-3vKs for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:33:31 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so22515775e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 13:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793655203; x=1794260003; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wrMJpxg0JgevZOggLxppQITnu+GWSIRBQTcDjwNGFSo=;
 b=F+55lQHmg5oksEzYt22y7ZOrbLrGxwZah8z/61s0JwfI2brUbFOqxlWXvVddd5bD/M
 dgNDcNUQKFbKkJIRoN3xaoVO+37Blx0wCHSvZBWT6l/8LsEy0CbsHf9H72c9bKHc//UD
 Hw59jaNGP5RoXNs2n6mSHVCRif/OAqAClL4KYg5u2XzTK5rwlCeOFrVVVBcMTL3VZzAN
 kqo5a214jLQ9InOCFzCOMdve3MdZ+5U2+k0ziCh1j0YH+Jve9/CV93s2cdHvlp7y3Aob
 GrGdtyOl4ONBx7TppoPez7UDMIIh7Pt4Amfg84ZGOIjHz8826sOGmUa+PV70xW5JfZ1F
 7geA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793655203; x=1794260003;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wrMJpxg0JgevZOggLxppQITnu+GWSIRBQTcDjwNGFSo=;
 b=ykJc3BjOndkm4euOZJq8SFCGEUQXtMkPFwYSpkpESpTPgfpmZ85dTJ1wYAL0yVBBUd
 zFrpj3CpYE0eHdpSeIvBEw6v8Pd7vtWCu85aOly/PhGvEV8ftcwF1PPRv1nc8MrddDss
 ol9DECdoBj5ckFbbvKFf6is52C4VO1iiVgXH+3VXoyj38VI8iQnincMM+tp84s4CJ34x
 wC0Y6Fi94Q9ufgKy4Po9ppIKmTGF+dGMe6Fv8CvGt3uSe5RziQmZhlZAj8mb5oaUe5cy
 4g9aQNLQiwHPT5cWe+pbJAR1PYEeJeVPqS8zEtgfc0Sb7+CzK4Z9QzP7vC2N4MvZIR4y
 rNdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvffELlucBMBKtiXtXjnLaYmpUEh89ZoqFqX6zCXZjefX9huxTgKdlw/IV9C9xqi44okvAPlh1p+n02n8i@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKVw53b+V5suTYvODrcd7IoW6CvR5dsgJ3ASxHUtZOGoK4y2rou
 Rp0ggskZ9Xc7thJmTnJES/bed+ylL04k6bOCuHDrnZ5LEc4KE0chX0IG1acfdFtPyBR5fi6q3TS
 cIVeND9kFXKV90lwcHjSvzMcNW5ysJpezZl/p3H9VePVuB1ObmZ9DkgNLgFtkKMcff+jQ
X-Gm-Gg: AYBFou3uJj/dojc9R1uet7GiCcAvosZpxzmDvSILxmGnHd7k0EhaNhaW8hVdRELvH8m
 n35MkqdCQbS9e0+ouUBelkUB+NXj5gn/4Z/sVXKE3oqVP/nq6QA/8pq5SRVXiWle0tMNZjxdC+6
 JTl65ashR58x/iH+wrhFwFbF1lseT8YAqcjnogbVK6124+UvYZTCCRdzNw1oVVL141I9RRKyhkc
 6l/hhvuwerTc0Hg+C+eBpI4N45h6yK7TKDyomKZGLa/l0cnDxWCSG0rHJoXdf5lRDExpyttu9IE
 q5oXqvqEkvMZpl1fCLu3kClTd4dUSRMODZ4fh55oIAF7K1riGNs/dyJfNIutM6UDUKgxBPEjYk3
 J94rgdzWEEw62U/TSnTXi2G8vUCpNiOSLLITOjDgSQv8fZi10A+9p2wd/bl0cxPV4QFpzoWvjdK
 KVqn+AEwaEUXuhsoxwdyXVDDBsZ0D0V0q3rH+20AO2RSrIpXkZMRsMudo3MLWKJfgO1eRdhzi/U
 0KugvQNNDDzypW67aCt2pL/l7ImuhG6qSVf/Irjf2gZD0M191AZB+1aonUQcaxRzh0sfEwJFt3T
 E2D6sJta00ldH2kM588nvAAVDBYyNrISVxDyWl+ra21vCFAjbiKJ0950xuY+5XcwexxEaRgJHvu
 +4Xe+LnTQGOCw7NuT0ilorf9YiY2ZEbcLVw3WPinRgMjX1FAYSJHpbzwQQcU4T3p/SGURphMvXu
 poR7rfljnr6tQkBA==
X-Received: by 2002:a05:600c:3b29:b0:4a2:167a:c939 with SMTP id
 5b1f17b1804b1-4ac17d19aeamr235134405e9.21.1793655203273; 
 Mon, 02 Nov 2026 13:33:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a96fc933sm13402225e9.11.2026.11.02.13.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 13:33:22 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 21:33:22 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia0304e5ef5f8a553262a32d78ed21577973ee2e9
X-Gerrit-Change-Number: 2093
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2093?usp=email>
X-Gerrit-Commit: e9ecd3c6ded76c03b9d74c1b37c87a07b54e10e6
In-Reply-To: <gerrit.1793636884000.Ia0304e5ef5f8a553262a32d78ed21577973ee2e9@gerrit.openvpn.net>
References: <gerrit.1793636884000.Ia0304e5ef5f8a553262a32d78ed21577973ee2e9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjM2ODg0MDAwLklhMDMwNGU1ZWY1ZjhhNTUzMjYyYTMyZDc4ZWQyMTU3Nzk3M2VlMmU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4cf96887aa1e32a37bdc483f1ee858a40345c799-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNzej-000000005h5-3vKs
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: close socket
 in Haiku get_default_gateway()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6898962108358089427=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6898962108358089427==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tc3jCph4cdM="; charset=UTF-8

--tc3jCph4cdM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2093?usp=3Demail )

Change subject: route: close socket in Haik=
u get_default_gateway()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

route: close socket in Haiku get_default_gateway()

The socket u=
sed for the routing table ioctls was never closed=2E Close
it on the early =
returns and right after the last ioctl=2E

Broken since 7da14925 ("Haiku: A=
dd calls to manage routing table")=2E

Change-Id: Ia0304e5ef5f8a553262a32d7=
8ed21577973ee2e9
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Ack=
ed-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2093
Message-Id: <20261102165927=2E110589-1-=
frank@lichtenheld=2Ecom>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/202=
61102165927=2E110589-1-frank@lichtenheld=2Ecom
Signed-off-by: Gert Doering =
<gert@greenie=2Emuc=2Ede>
---
M src/openvpn/route=2Ec
1 file changed, 5 ins=
ertions(+), 1 deletion(-)




diff --git a/src/openvpn/route=2Ec b/src/open=
vpn/route=2Ec
index 0bce966=2E=2Ee8de2d5 100644
--- a/src/openvpn/route=2Ec=

+++ b/src/openvpn/route=2Ec
@@ -3719,12 +3719,14 @@
     if (ioctl(sockfd,=
 SIOCGRTSIZE, &config, sizeof(struct ifconf)) < 0)
     {
         msg(M_ER=
RNO, "%s: Error getting routing table size", __func__);
+        close(sock=
fd);
         return;
     }
 
     uint32 size =3D (uint32)config=2Eifc_va=
lue;
     if (size =3D=3D 0)
     {
+        close(sockfd);
         return=
;
     }
 
@@ -3733,7 +3735,9 @@
 
     config=2Eifc_len =3D size;
     con=
fig=2Eifc_buf =3D buffer;
-    if (ioctl(sockfd, SIOCGRTTABLE, &config, siz=
eof(struct ifconf)) < 0)
+    int ret =3D ioctl(sockfd, SIOCGRTTABLE, &conf=
ig, sizeof(struct ifconf));
+    close(sockfd);
+    if (ret < 0)
     {
  =
       free(buffer);
         return;

-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2093?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: Ia0304e5ef5f8a553262a32d78ed21577973ee2e9
Gerrit-Change-N=
umber: 2093
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--tc3jCph4cdM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2093?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">route: close socket in Haiku get_d=
efault_gateway()<br><br>The socket used for the routing table ioctls was ne=
ver closed=2E Close<br>it on the early returns and right after the last ioc=
tl=2E<br><br>Broken since 7da14925 (&quot;Haiku: Add calls to manage routin=
g table&quot;)=2E<br><br>Change-Id: Ia0304e5ef5f8a553262a32d78ed21577973ee2=
e9<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked=
-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2093<br>Message-Id: &lt;2026110216592=
7=2E110589-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://lore=2Ekernel=2Eor=
g/openvpn-devel/20261102165927=2E110589-1-frank@lichtenheld=2Ecom<br>Signed=
-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openv=
pn/route=2Ec<br>1 file changed, 5 insertions(+), 1 deletion(-)<br><br></pre=
>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><=
span>index 0bce966=2E=2Ee8de2d5 100644</span><br><span>--- a/src/openvpn/ro=
ute=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -371=
9,12 +3719,14 @@</span><br><span>     if (ioctl(sockfd, SIOCGRTSIZE, &amp;c=
onfig, sizeof(struct ifconf)) &lt; 0)</span><br><span>     {</span><br><spa=
n>         msg(M_ERRNO, &quot;%s: Error getting routing table size&quot;, _=
_func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cl=
ose(sockfd);</span><br><span>         return;</span><br><span>     }</span>=
<br><span> </span><br><span>     uint32 size =3D (uint32)config=2Eifc_value=
;</span><br><span>     if (size =3D=3D 0)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        close(sockfd);</span><=
br><span>         return;</span><br><span>     }</span><br><span> </span><b=
r><span>@@ -3733,7 +3735,9 @@</span><br><span> </span><br><span>     config=
=2Eifc_len =3D size;</span><br><span>     config=2Eifc_buf =3D buffer;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ioctl(sockfd, SIOC=
GRTTABLE, &amp;config, sizeof(struct ifconf)) &lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int ret =3D ioctl(sockfd, SIOCGRTTABL=
E, &amp;config, sizeof(struct ifconf));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    close(sockfd);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span>     {</span><br><sp=
an>         free(buffer);</span><br><span>         return;</span><br></pre>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/209=
3?usp=3Demail">change 2093</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2093?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: Ia0304e5ef5f8a553262a32d78ed21577973ee2e9 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2093 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--tc3jCph4cdM=--


--===============6898962108358089427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6898962108358089427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6898962108358089427==--

