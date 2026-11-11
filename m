Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FA6606A324
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HKOSXFYa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YKOENhii;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LigOAewb;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GybZHg7B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kaJpn30M3N3OlBmJhQJ5U8P8tlYc4ZwofNQm3f86huw=; b=HKOSXFYazUs/JTJhIrmx+8ZQfH
	h+XPkQIHmiSkyJ1BioSLCs1pUIMSFXYRQtR8P/2puWbmVemqLByojZ8zto+XO3yAHRnYTZTJvgDD8
	lDFRwaSXpsWrR51tR8EfiDfOPlu11duSa1MGjsWoa1MQPXjvEvD9u7yPIGHWZ8RV/cbY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR5Nh-0000000050R-1Mk6;
	Wed, 11 Nov 2026 10:16:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR5Ne-0000000050K-40hP
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:16:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=puDobus2KsHgbEYw0I7cGLilgVoANJKKDAa6KJ0kjQI=; b=YKOENhiiHZdKqMc0oCOAWSYgS5
 Ge/B8B4R8JlH2G3kcl577YKOqTJ6JHZ1hBc0gn9cM8DFiVICnQxONoAugHwv8NGxbWu9Cv8qx3Pp4
 eK2b3CBb5hfriYLwuERvkW4Lzef5bXrXcFqXyeJa+0XgIIx1eG+XTMezVLVq7+jml+rY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=puDobus2KsHgbEYw0I7cGLilgVoANJKKDAa6KJ0kjQI=; b=LigOAewbSBNX4vFG6CwYKeMSgT
 rthK/9JNpqI5ayWaooC4pMnblXINMGhV/xs0g3PbNHoXbO8u7ltsW1bWfOROQ2Y2SsLNz6T2t6fl8
 ehK0jD+yVfiaBUkMejNmZ75XLoukCmEEGYkv07+TlRDhj7I/nWqhjsnDqOHBuhR0vUIU=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR5Ne-000000002Bq-0uWs for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:16:38 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so36372785e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 02:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794392192; x=1794996992; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=puDobus2KsHgbEYw0I7cGLilgVoANJKKDAa6KJ0kjQI=;
 b=GybZHg7BG8/FF8aJMtD3coPAVN7nHFiQlxDx51mpB3di1Gtgno0LwcWxA6jf1Ia3rS
 HAKC5GmtZvFeigCw8R0pwjc7TCs3QlPx5HkESv3ceIj2OBJLgaXHLaw1hAmzEj5KY9XX
 vI6fPX8dE4MhzutkzZlDt7YbilMlg5u1HZsuspPCZ2kxtlP8hUmq3s+3SEjvpanQEzlp
 8BS/33N744NvZlqOMmi5ULhlBjq53u2O2XIhYyO6AUbkYobrb5v3rM02klFEpjz1yQCO
 xHIBb0e0tFyVrbWoHVSGiQ72Ow6Bm1TrU1e8Z1PfstlR7BFYvbbB6/SkAd28lcWsGrCG
 Yqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794392192; x=1794996992;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=puDobus2KsHgbEYw0I7cGLilgVoANJKKDAa6KJ0kjQI=;
 b=CceWNtb5X5rqK+GOICs+ziC9xx+FB7MUWlwBarKI8jLzt/my3fOp3681BPMD3ZuA8s
 9ab10ugI4cCqfhV0frKGWngdo9K46aZV9IPkCUgIlq+xgX4KQeUXtv/IN2O4j3PGNyJc
 Y2XBnYcCoqF/GlIH97+ddyjzzVdRIq/dD6fWhMD0iahztDn6q0KpDgBpskM2e+jCEpB7
 +g2Hcp3+5guab+QKPmhwihQyExsiRxiq7C4miW1uMdKupaKuAcqDOTE/my9GVsRk8ecq
 vG1aGDyhOJzEOlX9g8pqAesD9dgJRRVBywNO3Wk7PeBHT7aPaWGcl7SYgWQ5UUZkJbdm
 qfvQ==
X-Gm-Message-State: APuU4Z+fmiN/Y6fuTlJNhHlqpIBPqFiAoMuPB7efkgBDir+E6SEPSnpD
 ibwNkH4WjHtIS9/9WN0idWfclr/P3Dn1BK9JVhsuKQdnSwnAkZjHRpDn/lqk7wWBzIqDgTmIfDq
 cuSSMiZU+2u9rgbLFkbClUQTtOEvK2xw4yr94ejkTId+sz/uxbqfdhf4E8OhOZPUSALYx
X-Gm-Gg: AYBFou24n8ypusnCIaGGQOvOc4cQBv+OyVcWr94xDDX1fOwkDjSCKzs/xiZLWvUeSbX
 TwrpaDCorCqrRppkC4RZ4paMvFc4UbTTeOTgflWYy59t868qZ3s9RHZ6cszknIBSxR0wghElYPF
 KyD5W3ME8DCrdOT4Vq7QKB8eG0Or21O1dlQEAJGSr+W2YA1IzEbq5nLZq5pPflEfCExIsrMfj6e
 qPgV+a8dwdC4hs/6HhDZ1QEXyqTEjUqkO2pUEECn+286yrRhrCG3G6OK9K0kB6mS0epqjfsCKnx
 iiY15u/u0MRg64H1o+XyYyCHW+FkaLeB2531hv2YdH4cnBWXe2F1i6vhWjU5LW+q1AkL4dHNNia
 6pDpG9wbwLo5CIV8yzzZT9jTNbSuizX7vqEQflssZjpGshwZsnMdgEjYiPBg+esLF27yR2RWjYd
 AzdniT3pFyF59TM06sppkgE5zwZKVqsVJ0lmmy1TdT4PFy2YpK8dBADstWp7rHJzNs0Sz5uLdfM
 gquoWdTUH/5Mp5BOs+COmbDDB3dnZ114OWZGG3z+8QB4617+9ncCKrJqLj+hqn+1wPyBAMGWFtq
 ceQD8L6+KZVb5IgptNT8BU/xBO+9w45///UTvWh+2EQNwMDd9zp0ckxOFbswsAoq4jtBNx8IanZ
 3f3btbjLcn1d+rt4r9lbPoN7pfKB0Y/katMt8DbgJviAvF0/6H9rOpO65+c9LFRRADnqtk1qp97
 0S+mjeadc/2g/WPwE=
X-Received: by 2002:a05:600c:19d0:b0:4b5:d95c:2380 with SMTP id
 5b1f17b1804b1-4ba09375b5amr31861745e9.11.1794392191403; 
 Wed, 11 Nov 2026 02:16:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a4238sm10518665f8f.54.2026.11.11.02.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:16:31 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 10:16:29 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4
X-Gerrit-Change-Number: 2161
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2161?usp=email>
X-Gerrit-Commit: 193f1deedeb81851852f64a578c1e8518fd05343
In-Reply-To: <gerrit.1794301782000.I7ffae4da3b29521844a31d234fe6a9dd08954cf4@gerrit.openvpn.net>
References: <gerrit.1794301782000.I7ffae4da3b29521844a31d234fe6a9dd08954cf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAxNzgyMDAwLkk3ZmZhZTRkYTNiMjk1MjE4NDRhMzFkMjM0ZmU2YTlkZDA4OTU0Y2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bd0e8db527f01c76bf16e32d5c51479b1178bc93-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR5Ne-000000002Bq-0uWs
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: only
 remove search domains that were added
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0982394522704784070=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0982394522704784070==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E27WW+Y1Lr4="; charset=UTF-8

--E27WW+Y1Lr4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, R=C4=
=83zvan Cojocaru=2E

Hello Antonio Quartulli, Arne Schwabe, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2161?usp=3Demail

to look at the new patch set (#2)=2E

The foll=
owing approvals got outdated and were removed:
Code-Review+2 by Antonio Qua=
rtulli

The change is no longer submittable: Code-Review and checks~ChecksS=
ubmitRule are unsatisfied now=2E


Change subject: openvpnserv: only remove=
 search domains that were added
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

openvpnserv: only remove search domains that were added=


When AddDnsSearchDomains() failed, SetDnsSearchDomains() still called
Rem=
oveDnsSearchDomains() with the new domains, which removes matching
domains =
already in the search list, e=2Eg=2E ones configured before the
VPN connect=
ed=2E Record the undo data first, as done for NRPT rules, and
drop it if ad=
ding the domains fails=2E

Broken since ae90cbad ("dns: support multiple do=
mains without DHCP")=2E

Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954c=
f4
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn=
serv/interactive=2Ec
1 file changed, 10 insertions(+), 4 deletions(-)


  g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/61/2161/2

=
diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=
=2Ec
index 81205d6=2E=2E5d2abeb 100644
--- a/src/openvpnserv/interactive=2E=
c
+++ b/src/openvpnserv/interactive=2Ec
@@ -1823,13 +1823,19 @@
         st=
rncpy_s(undo_data->itf_name, sizeof(undo_data->itf_name), itf_name, _TRUNCA=
TE);
         undo_data->domains =3D wide_domains;
 
-        if (AddDnsSea=
rchDomains(list_key, have_list, wide_domains) =3D=3D FALSE
-            || =
AddListItem(&(*lists)[undo_domains], undo_data) !=3D NO_ERROR)
+        /* =
Add undo information first in case there's no heap left */
+        if (Add=
ListItem(&(*lists)[undo_domains], undo_data) !=3D NO_ERROR)
         {
-   =
         RemoveDnsSearchDomains(list_key, wide_domains);
             free(=
wide_domains);
             free(undo_data);
-            undo_data =3D NUL=
L;
+            goto out;
+        }
+
+        if (!AddDnsSearchDomains(li=
st_key, have_list, wide_domains))
+        {
+            RemoveListItem(&(=
*lists)[undo_domains], CmpAny, NULL);
+            free(wide_domains);
+   =
         free(undo_data);
             goto out;
         }
     }

-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7ffae4da3b29521844a31d=
234fe6a9dd08954cf4
Gerrit-Change-Number: 2161
Gerrit-PatchSet: 2
Gerrit-Own=
er: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Q=
uartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Ge=
rrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attenti=
on: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--E27WW+Y1Lr4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, R=C4=83zvan Cojocaru=
=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #2</strong> to =
this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2161?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by Antonio Quartulli</p><p>The change is =
no longer submittable: Code-Review and checks~ChecksSubmitRule are unsatisf=
ied now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">openvpnserv: only remove search domains that we=
re added<br><br>When AddDnsSearchDomains() failed, SetDnsSearchDomains() st=
ill called<br>RemoveDnsSearchDomains() with the new domains, which removes =
matching<br>domains already in the search list, e=2Eg=2E ones configured be=
fore the<br>VPN connected=2E Record the undo data first, as done for NRPT r=
ules, and<br>drop it if adding the domains fails=2E<br><br>Broken since ae9=
0cbad (&quot;dns: support multiple domains without DHCP&quot;)=2E<br><br>Ch=
ange-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4<br>Signed-off-by: Razvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpnserv/interac=
tive=2Ec<br>1 file changed, 10 insertions(+), 4 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/61/2161/2</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/ope=
nvpnserv/interactive=2Ec</span><br><span>index 81205d6=2E=2E5d2abeb 100644<=
/span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b=
/src/openvpnserv/interactive=2Ec</span><br><span>@@ -1823,13 +1823,19 @@</s=
pan><br><span>         strncpy_s(undo_data-&gt;itf_name, sizeof(undo_data-&=
gt;itf_name), itf_name, _TRUNCATE);</span><br><span>         undo_data-&gt;=
domains =3D wide_domains;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (AddDnsSearchDomains(list_key, have_list, =
wide_domains) =3D=3D FALSE</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            || AddListItem(&amp;(*lists)[undo_domains], undo_data) !=
=3D NO_ERROR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /* Add undo information first in case there&#39;s no heap left */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (AddListItem(&am=
p;(*lists)[undo_domains], undo_data) !=3D NO_ERROR)</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            Remove=
DnsSearchDomains(list_key, wide_domains);</span><br><span>             free=
(wide_domains);</span><br><span>             free(undo_data);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            undo_data =3D NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto out;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (!AddDnsSearchDomains(list_key, have_li=
st, wide_domains))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 RemoveListItem(&amp;(*lists)[undo_domains], CmpAny, NULL);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            free(wide_domains);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            free(undo_d=
ata);</span><br><span>             goto out;</span><br><span>         }</sp=
an><br><span>     }</span><br></pre><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3Demail">change 2161</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7ffae4da3b2=
9521844a31d234fe6a9dd08954cf4 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2161 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </=
div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--E27WW+Y1Lr4=--


--===============0982394522704784070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0982394522704784070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0982394522704784070==--

