Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392B0606A330
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PAE0T6IJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Z6MWYChE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cqTmpYHN;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XOnynekD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=W6k8AehUBcplFvaEov9DzW1EVj0BQM+K/6z0d9KxMUU=; b=PAE0T6IJY43kPKbk07irk83kI0
	+ShXLbmY04RPmfBmlHqabxmkFcx5HlwXI8K0oUydChAE6NR2JUQvF6jhI12dKKl6Cimq8OV0vRRJ8
	EvApnEiNSj/4Xw6GsOu0GvD3oix8Ye6bHnbLAlQwmJFc8qn5hup/kqOVDgvug3EY9nLU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSaoX-000000007h5-3FEx;
	Sun, 15 Nov 2026 14:02:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSaoV-000000007gh-35OR
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 14:02:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q7KaDJXbWwpEW3HiwD10RFKcOl18oW18OAm4rNWvg4g=; b=Z6MWYChEQ35kDVCAoEzDM/cy1e
 8q0Q26AZC+wpXADP7VA2tN1xipcDY52DgSlNP+8z7qrolR/JcBs0hyATImg9JNKjXf72sdwCrQk+X
 38P5ieXHKAdJMuhFhFvWKPibH5XrzVsNYWOgvQMI2Xfu41Yu+yZNpnnQuzj9sEyw0Fic=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q7KaDJXbWwpEW3HiwD10RFKcOl18oW18OAm4rNWvg4g=; b=cqTmpYHNcCwXI8WjcuM2FGid7M
 Eet9+8zL3v6LMt+XF+WtCUmTE37x9+f6SRbRkg8KgF3GC2YIe/kYNiy6pXliyuupqiT8gqyLRFoOz
 3nkN2hefvEmgS8+OHjc9/9y7PWmzAzX55wQk6NxoEyCjsmKVZGVl4la+gR9Uc8aaQeqg=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSanz-000000000RA-2y9a for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 14:02:06 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso1707004f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 06:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794751317; x=1795356117; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q7KaDJXbWwpEW3HiwD10RFKcOl18oW18OAm4rNWvg4g=;
 b=XOnynekDG91P/qrE/uT9lXUIWgvSw/Q2iCiO0clTsiXhv3bZWpiaZPoa6uSkYUO9/i
 tpCrC01Jh7woM75+PM86kVZJyfGfVZ14kIVvFHH5stMTIxavpgyxDbkgmCTmJxCg0FD0
 O4yP32id8sq/Q0oOC27bpMmJfp+EKgLQVr5X9Bj8Cn8J3ymyz5eIgERjBuBqsBJITDZs
 SKONr7juZIi5Hwiud4UZje5LYW4ioZ3DhnK/F4iywrnUdlm1cvsUnmnqIBvKej7kpG2n
 f1UREbln/axHsHTq5730QFfMcn+9HBKaehMjCa+8t8WBwh3TUpdDE+lugauPN2nD0fVf
 +Xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794751317; x=1795356117;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=q7KaDJXbWwpEW3HiwD10RFKcOl18oW18OAm4rNWvg4g=;
 b=tEu9MQPM9EkB2N4L1QCer03XCqSpH9lQ+LPK1QHG++wqRwv62zGSwMgZVyDe+MXA/u
 PyuD8kvAWq00gJIdq4r8zxrrO24qXTD9SSwEsiiUzum2ltwXzOk38gID/fNudaEsdGBE
 CKfkZbbE9ZsjWwyNOwI0Gmy9F31XdPfKD+3dunhqG1jgn+qdGLKt13UZjxz0N1n+hiZa
 BI2kgG0J5uZTzNDxGJ5LkEWLIGKI69bBHCf2pcXpCK1YqMRKdAhIMr8r+0t2/RlEw1Db
 ROJ2fcGQhvdGCm2hqdPzJqgvnyH58upl8tEGfetZaQXucIMg8MIngYA8OwMow+yf9BVF
 Lxmg==
X-Forwarded-Encrypted: i=1;
 AL+hErG5lxzD2zfWVle6xKohs9FCOtGDsFRjmEXdZF8iT6dIjWefVLf958GOT+Q/loso5+Idl3hYX5+9JKYQfOv1@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8/+8oyiUze1kHxLYpm8RdEml220Xv4d/fckex3j8seE84ESYEn
 K2cI3MSV4hs6fpwroCxiT4nG9wyo7vh6VpU5GzEoz1XfC/+1DFKmjJnxVz64Ly/phsASoKQkp7e
 h0If/MtO7ZrUvFQ0vGsgAjDg5i42LJIoWElq8XnNoXfEqjCvcjFTS6HcJnkGT0b3+Oqru
X-Gm-Gg: AYBFou1o5cGTLFdXvu29UJ5OrbQs+XMH0dwb90ufP/kvIRNdqjiv+0v5Pz5N/sFKD7z
 k2sbfVUHCR7rCJ94Q1/f+zYtrN+UO+yzU4OUZpJdshD97hL1yPshuKvrMInwGK88iLAJTfn4+lx
 0a2qQf29P8x/3tfwa93Waj39KlbcHXyLTWUFd+XmgzZrAON9MQGGbS00ZEYMm90SGPhyu4kuMRh
 z+e6QEkM6DJUenMqfBcHx807Lphwep3QD/Pah6wNa5ocZ3JXnQX1TPu3Ct9Zcu8PNmH46p+s3cy
 xLGJ7dnmyqMvSp/kBAB0KKNu/yvhrjA6/wsbVz4BbeuVPj+GhMHz0DApGehr2UlBOumxaqtZFJ0
 4bxb6IbW+SuKbfB1L25eNjpXU6MFrOL68Lmuv8bcb9nPw+MiEXNCWjXUjQOpP0RfnoYh/KQes6i
 Nwvl+m6TQoEuCUrohXhsttWvW4GxddA5FdjyS6rc5F/6TjXVU+fMxE9eecz2qLis3D9h3pL+PmN
 RU887J15S3AVrEDA2ma2XQvI22N4pwo+fyrvAeTwQwpaQgxJcSS30EJnb4xXuZFHdk85Gc2gK/f
 /1fRBytHGqn66qlFf00WZsUkRJGdvDtMaPB9uv8+NXotzgSCIq1UNYvFjYMOJopO47VW8ffquOj
 F83aBvh6I6xAWYbNBOsjI0ci7j3i5BDauXRHMMEUss5cO0HA1yKT5cOqjtVyuLy6aAqZtM/9PJO
 YuGjtVp0owiRftWBM=
X-Received: by 2002:adf:e18d:0:b0:48c:67d6:a87a with SMTP id
 ffacd0b85a97d-49c70a0f020mr16475209f8f.32.1794751316915; 
 Sun, 15 Nov 2026 06:01:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49dc430fa15sm10517265f8f.13.2026.11.15.06.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 06:01:56 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 14:01:56 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1295d911c993a02397565e26cece0f0861a2e5f8
X-Gerrit-Change-Number: 2171
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2171?usp=email>
X-Gerrit-Commit: 85b913866cc27c05a2b7565b36ccbad11333918a
In-Reply-To: <gerrit.1794384773000.I1295d911c993a02397565e26cece0f0861a2e5f8@gerrit.openvpn.net>
References: <gerrit.1794384773000.I1295d911c993a02397565e26cece0f0861a2e5f8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzg0NzczMDAwLkkxMjk1ZDkxMWM5OTNhMDIzOTc1NjVlMjZjZWNlMGYwODYxYTJlNWY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7292d405ab65c145b623348f814fbd7b1949d66f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSanz-000000000RA-2y9a
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: init: free
 actual_name when replacing the Android tuntap
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4483838452632150282=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4483838452632150282==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J/GaXlFPgr0="; charset=UTF-8

--J/GaXlFPgr0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2171?usp=3Demail )

Change subject: init: free actual_name when=
 replacing the Android tuntap
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

init: free actual_name when replacing the Android tuntap

=
With --persist-tun, do_open_tun() frees the old tuntap struct but
not its a=
ctual_name, leaking it on every reconnect=2E

Change-Id: I1295d911c993a0239=
7565e26cece0f0861a2e5f8
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Acked-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2171
Message-Id: <20261113192654=2E11=
321-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg41281=2Ehtml
Signed-off-by: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
1 file changed, 1 i=
nsertion(+), 0 deletions(-)




diff --git a/src/openvpn/init=2Ec b/src/ope=
nvpn/init=2Ec
index cb89627=2E=2Ee1052c5 100644
--- a/src/openvpn/init=2Ec
=
+++ b/src/openvpn/init=2Ec
@@ -1816,6 +1816,7 @@
         if (c->c1=2Etunta=
p)
         {
             oldtunfd =3D c->c1=2Etuntap->fd;
+            fr=
ee(c->c1=2Etuntap->actual_name);
             free(c->c1=2Etuntap);
       =
      c->c1=2Etuntap =3D NULL;
             c->c1=2Etuntap_owned =3D false;=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2171?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1295d911c993a02397=
565e26cece0f0861a2e5f8
Gerrit-Change-Number: 2171
Gerrit-PatchSet: 2
Gerrit=
-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Anton=
io Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>

--J/GaXlFPgr0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2171?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">init: free actual_name when replac=
ing the Android tuntap<br><br>With --persist-tun, do_open_tun() frees the o=
ld tuntap struct but<br>not its actual_name, leaking it on every reconnect=
=2E<br><br>Change-Id: I1295d911c993a02397565e26cece0f0861a2e5f8<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Antonio Q=
uartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2171<br>Message-Id: &lt;20261113192654=2E11321-1-ge=
rt@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg41281=2Ehtml<br>Signed-off-by: Gert Doer=
ing &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/init=2Ec<br>1 f=
ile changed, 1 insertion(+), 0 deletions(-)<br><br></pre>
<pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/s=
rc/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index cb89627=2E=
=2Ee1052c5 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><spa=
n>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -1816,6 +1816,7 @@</span><b=
r><span>         if (c-&gt;c1=2Etuntap)</span><br><span>         {</span><b=
r><span>             oldtunfd =3D c-&gt;c1=2Etuntap-&gt;fd;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            free(c-&gt;c1=2Etuntap-=
&gt;actual_name);</span><br><span>             free(c-&gt;c1=2Etuntap);</sp=
an><br><span>             c-&gt;c1=2Etuntap =3D NULL;</span><br><span>     =
        c-&gt;c1=2Etuntap_owned =3D false;</span><br></pre><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2171?usp=3Demail">c=
hange 2171</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2171=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I1295d911c993a02397565e26cece0f0861a2e5f8 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 2171 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></htm=
l>
--J/GaXlFPgr0=--


--===============4483838452632150282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4483838452632150282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4483838452632150282==--

