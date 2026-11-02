Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C9606C572
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZmgbotZe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NXmqP6OT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AFy31BPv;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PnQajscL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qbupaamntLiKT72KHows5i8GdyamsYKk4kv29TWI+vc=; b=ZmgbotZe/HlmZzQoj4BPKchZ1V
	J2pJsYqKdaLJeIIC+kP6KkUWgncewRJWoTo+4Mx4W2xSwqzi5JoH5N6lgP9HfAYkC5HRuSh/bsqbJ
	b82wIEMWIkwpgrvXG+pwWnMoN/81181G9tTGxTmmp0ZPXPZYk0bqkZbIAPMEc9dI8X0A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNtI3-000000005uj-0OJs;
	Mon, 02 Nov 2026 14:45:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNtI0-000000005uc-3pjc
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:45:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4TYHOq/MHlkYN162h6rhr8m9y4SCZi1mv/mV0uOe97A=; b=NXmqP6OT25NVrc2qG3mscQE8uf
 7P+ycT8FM1akPiORLqrISWasOGNBNDbnxCaq5GWZ34X5rztWisy5iA/YWi9cJHFCp81zad4lq6/VJ
 Ebr1oTZ1BGdPEDfV2o8Rbu/3rbmLOhijz+nM6ZBfQBIWrK9S0oo8VUNsGH6jfKjqo940=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4TYHOq/MHlkYN162h6rhr8m9y4SCZi1mv/mV0uOe97A=; b=AFy31BPvvZr0wYOChK4OjYnO3S
 PwjTRZrFfjbG0MUEiCN7sXgsICBqFIX1jvtv4fP58SCQ6e9rMG9u2O6uTN7rqumPCL2M59twoeKLj
 X1HHzk3IqykVvZNIyULU5+m/w3eM4O9GGKLe/JvNRhCT28l2xISWUnc2wv1lHsfSRENE=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNtHz-0000000028c-20gf for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:45:36 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so31864845e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 06:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793630729; x=1794235529; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4TYHOq/MHlkYN162h6rhr8m9y4SCZi1mv/mV0uOe97A=;
 b=PnQajscLxmWwIttT9gwRK7L7GGMSeuXX+/8CIzWQcWn8eUcl7JbW2xVuuN3JjC7QyX
 H0LXdbpnlveDQXlwxRvq53xRtRoWowaPF86MPG2wj7hpx0nWoTKL1hsyJoljnuTv0Nvk
 a3Spb5xRWxL0LfEqYskX8tewObC+4BzDLhUIbR4MKuy8f0EEEiDw5iLVeXeiBaZnG20j
 SnKCjTFw+wABeLzD9w5mZ5KUNnu6+qAkiOKy7LbDwaEYJSC9ES+D7boyXwhaqsetL6kQ
 8RcT5ugtjqgabvhOE010J0ty6DPget4nPIvGymkikw5aU9UYiUmDhj1L6QgWodp1C+5O
 FNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793630729; x=1794235529;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4TYHOq/MHlkYN162h6rhr8m9y4SCZi1mv/mV0uOe97A=;
 b=gd8VW8lzEs0zZPHotOP9lVLkWtTHw2Nb5NQW3Tyc7l2Qd0wr8eTj/8+l6Kb0ebA/eu
 P21Vh4KD9MhOwVee8Nb4JqWHW/+8UrblsG/Dd23TIXTXhbnmGIFhS1ZK1Y/EcO20AAGc
 pxWzuVY2h5Nq/5GxqSBtb2TSrwkVTq3Ha1pHmX+aetveSrouj2ebJsibJUkg9VPUErsi
 sihuoVmcIVnsG3yDXYwuRWsf7FgN8/CE2rOWfH5IbppVsnx5m2EgGDQ24/aIcoanRPJU
 2O/g/S6il7P+WuUu5taPybAUWdz4Pxolm6q49Uh4U1lXaZZh8Osk4G+j48G29aBZKM7x
 sl4g==
X-Gm-Message-State: AFq9FYJq86o7FJ2YQTajAV7pL22oeuWSKJCpc/MyGwHNp1u8PX97b2Mn
 FF/3E9c//1bFxCwteVK3ICDuWO7nGkdxCRh03qbQux25B8top/dnLs3e6gj+6tJrHv6Ew6IoQr0
 6f0AHw4nP7V5MSeeoK8wSc6/ZnzTMPRjdn6AISDoFzIphPSGOjf3PnMeMGuWTrg2PO+zk
X-Gm-Gg: AYBFou3BhC7N4UFUvqZHpmEZBnATPI4BTAJJCzC2WDQzjKELlwVsjpdiuaf+rV9vm/h
 Bd5/WXSDLv39oKl6A9QZy8aKupHwU4Bw5ZWWigHlRr3Dkl2PyhhNOjmKjXhQ9Yckr3p0X/WIkfj
 SKomtrwB1lXyQrpeE52frhwWl8jP/KERp6O/Z/KcWCSe37EEXsckObJ/BVPzb++pve+MCgLlEIV
 GwbbzeSqWZst1o528qwL0Za2OvLDgjtu0ZccVVMz1aK7UiMkthJyqiaGzqYjKrwJrc1qybWUf5C
 lrVCptOBTVC3/p2igoNKjsVgIPDnrWJi3eVL+6xPdXPheFfQR3qyABTcxYw3ta/z7QZ+ZzpB7Xl
 nAfkrKzisRv3dwvPxi9UMFrT+dkAAt9BTZ/b3cqqIcKgxs8UbsJjckXkH54Npg4GLIkIpcj0Iua
 gBKLYUK3sI6Vl8oV081Wnrs2H7O1YBk8B5VdIZW7J5JBinBeNhj4WshUdYBHhDaA9v6Bpg+JfFm
 iKO2LirvBcgjEmDUtjBNRhA4nEM+HJ7YGRwHUDWWnJZv6YOjSK8yf3d266yXN2ABzIGPuAr8K0o
 8UB4jbvMwiJNO6Lzas72DcZaywaCZnPgmRhZHfER9/j4d8UMVPkkorG4K8fHoKJYaelyYsV+Yv7
 Dwo4ogeHk8y/+XbXndunhLhSXv+s9K+Amy1SCztZQSwv/iR16p+k/CGofuIDwVAE9KZqhCwYEls
 0JOJOgkr4TzUY1ui4=
X-Received: by 2002:a05:600c:628d:b0:4a1:f7f4:7ced with SMTP id
 5b1f17b1804b1-4ac185bd243mr237988385e9.17.1793630728680; 
 Mon, 02 Nov 2026 06:45:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22866733f8f.6.2026.11.02.06.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 06:45:27 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 14:45:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I80b9969f555d670bc101635318d245d1b2de8ec5
X-Gerrit-Change-Number: 2092
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2092?usp=email>
X-Gerrit-Commit: 5d99227da88a5465d1e523b974104e88c599ccb9
In-Reply-To: <gerrit.1793629964000.I80b9969f555d670bc101635318d245d1b2de8ec5@gerrit.openvpn.net>
References: <gerrit.1793629964000.I80b9969f555d670bc101635318d245d1b2de8ec5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjI5OTY0MDAwLkk4MGI5OTY5ZjU1NWQ2NzBiYzEwMTYzNTMxOGQyNDVkMWIyZGU4ZWM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6407702b12054e2750c6f3573a49a608089afe0b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNtHz-0000000028c-20gf
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: free gc arena
 in windows_set_mtu()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3916903679978595882=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3916903679978595882==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0FpwAu2EUYE="; charset=UTF-8

--0FpwAu2EUYE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, R=C4=83zv=
an Cojocaru=2E

Hello Arne Schwabe, Gert Doering, 

I'd like you to reexami=
ne a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2092?usp=3Demail

to look at the new patch set (#2)=2E

The following appr=
ovals got outdated and were removed:
Code-Review-1 by Gert Doering


Change=
 subject: tun: free gc arena in windows_set_mtu()
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tun: free gc arena in windows_set_mtu=
()

The arena used for strerror_win32() was never freed=2E Allocate it
only=
 on the error path, where it is used=2E

Broken since 0213f80e ("Set the co=
rrect mtu on windows based systems")=2E

Change-Id: I80b9969f555d670bc10163=
5318d245d1b2de8ec5
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
-=
--
M src/openvpn/tun=2Ec
1 file changed, 2 insertions(+), 1 deletion(-)


 =
 git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/92/2092/2=


diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index fdd13ae=2E=
=2E58f4750 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -5=
203,7 +5203,6 @@
 windows_set_mtu(const int iface_index, const short family=
, const int mtu)
 {
     DWORD err =3D 0;
-    struct gc_arena gc =3D gc_ne=
w();
     MIB_IPINTERFACE_ROW ipiface;
     InitializeIpInterfaceEntry(&ipi=
face);
     const char *family_name =3D (family =3D=3D AF_INET6) ? "IPv6" :=
 "IPv4";
@@ -5228,8 +5227,10 @@
 
     if (err !=3D NO_ERROR)
     {
+     =
   struct gc_arena gc =3D gc_new();
         msg(M_WARN, "TUN: Setting %s m=
tu failed: %s [status=3D%lu if_index=3D%d]", family_name,
             stre=
rror_win32(err, &gc), err, iface_index);
+        gc_free(&gc);
     }
    =
 else
     {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2092?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8=
0b9969f555d670bc101635318d245d1b2de8ec5
Gerrit-Change-Number: 2092
Gerrit-P=
atchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert=
 Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>

--0FpwAu2EUYE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, R=C4=83zvan Cojocaru=2E <=
/p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #2</strong> to this =
change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review-1 by Gert Doering</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">tun: free gc =
arena in windows_set_mtu()<br><br>The arena used for strerror_win32() was n=
ever freed=2E Allocate it<br>only on the error path, where it is used=2E<br=
><br>Broken since 0213f80e (&quot;Set the correct mtu on windows based syst=
ems&quot;)=2E<br><br>Change-Id: I80b9969f555d670bc101635318d245d1b2de8ec5<b=
r>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M =
src/openvpn/tun=2Ec<br>1 file changed, 2 insertions(+), 1 deletion(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/92/2092/2</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/tun=2Ec b/src/openvp=
n/tun=2Ec</span><br><span>index fdd13ae=2E=2E58f4750 100644</span><br><span=
>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span>=
<br><span>@@ -5203,7 +5203,6 @@</span><br><span> windows_set_mtu(const int =
iface_index, const short family, const int mtu)</span><br><span> {</span><b=
r><span>     DWORD err =3D 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    struct gc_arena gc =3D gc_new();</span><br><span>     MIB_IPINT=
ERFACE_ROW ipiface;</span><br><span>     InitializeIpInterfaceEntry(&amp;ip=
iface);</span><br><span>     const char *family_name =3D (family =3D=3D AF_=
INET6) ? &quot;IPv6&quot; : &quot;IPv4&quot;;</span><br><span>@@ -5228,8 +5=
227,10 @@</span><br><span> </span><br><span>     if (err !=3D NO_ERROR)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        struct gc_arena gc =3D gc_new();</span><br><span>         msg(M_WAR=
N, &quot;TUN: Setting %s mtu failed: %s [status=3D%lu if_index=3D%d]&quot;,=
 family_name,</span><br><span>             strerror_win32(err, &amp;gc), er=
r, iface_index);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     gc_free(&amp;gc);</span><br><span>     }</span><br><span>     else</sp=
an><br><span>     {</span><br></pre><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2092?usp=3Demail">change 2092</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I80b9969f555=
d670bc101635318d245d1b2de8ec5 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2092 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </=
div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--0FpwAu2EUYE=--


--===============3916903679978595882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3916903679978595882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3916903679978595882==--

