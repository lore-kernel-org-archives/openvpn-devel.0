Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B04606A32D
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SO38ZvtF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Up0POy4A;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=P6CTeC6f;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XXSrT2wy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+QHhHMErriKu7B9aOUH5424xY1i3qpuRjkUElflfdZs=; b=SO38ZvtFfjV0TJjB/M0lyUeL/w
	y1nyxx8MexVLAbnIs2DxQb2iuTTR/SJH7Q1CfKaqgoYo05pk1QO28+Xvr/K18um9jJOaJDeGKiJF3
	vHLwM1//Jp86TUJ9EJBElV1Ui56oJT9tBTSDDZ+NnjvpgyyyjY75N/eqIOEzmVOk9TFI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRubI-000000006Im-1ufH;
	Fri, 13 Nov 2026 16:58:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRubH-000000006If-200e
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 16:58:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sH0Lb4hw2aofyVjkSy8pgJP1h4pFGge+40C2SfJvk3Y=; b=Up0POy4ATFMG+qkpQnmtnZnAJ8
 VXzfaQ0+wpDfXU9Wau0SmnKRoi5282zDxNvsvGz2LNrCe5VpgqHq7zXaQ28y4hSdTwyK1I1RW5OQr
 QYOs3cjkdtcrbp/M1GPOPqZfEfLIZ5s4PxiosBRqF5hhsHVfohCOcvYU6Ge1g5WZtyeI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sH0Lb4hw2aofyVjkSy8pgJP1h4pFGge+40C2SfJvk3Y=; b=P6CTeC6fkg7tuf5YGhSVcZpOXj
 n6wK357YUamPhK7+0Ys+mCgCZAXE619DYuCVsDPbJcWlGD+Bq/hQtvuLL7Z56B3oRxHlEBJUOCsqY
 F9USFabPMf1rvZhr/jZk+fGcQU6HSjhJzDbWv4ao1sy+kkKtK5UHlOyljvmLof6hQPaU=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRubG-000000001KI-1NG2 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 16:58:07 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1379524f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 08:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794589080; x=1795193880; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sH0Lb4hw2aofyVjkSy8pgJP1h4pFGge+40C2SfJvk3Y=;
 b=XXSrT2wy4xV81XYC5KW/DaV8sgPwAu2tzsYQ66nWgaNy1Tzo1biiDwD7NdNANSrgAz
 n5l8Xu0snN5R+SUpgGvrbM+2A198IKEOdrjGTPrraMu5lWWPLIVAtSUVyCSE79QMJyAP
 1RMqxIHnREjs/iHPgEiGLqRDZEz1lmDU6eMj7bCFDeONKQv7gAqG5hQPRvDoUYstgyoF
 P/r+rUNP1bYVmp80AE3RjJdfRZcRCL+/ZMVuVG+g7w+MX7EzKbNlBjMGTXvR93JYvEEK
 82AEkNe3RuxWqf7KPyp6gbqvWnttdvQrqTuys+5ARuLZYkYA51EUjOsnaxtu4zt87o4n
 9pEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794589080; x=1795193880;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sH0Lb4hw2aofyVjkSy8pgJP1h4pFGge+40C2SfJvk3Y=;
 b=D6f/yFaBqaSQh6ZqCRdTh1wGuhc+Sj54vZPDBDSnbBm1hevRM8SzRZV8w1z81qNH5b
 l6JtHDZipT0ku7ampW/WV2/M3V+yA8dWlsRpVJGtoXABZmkiYWqGrG0Rt+SfROWxfjj7
 uGsD7bBgGgNv1FCt4caRG+d2V/hHNAWQzOpBrsOp8cBoLXo4OV6xgcAfdNpaIUM30WeP
 6cU+np7PnTsgZayC+/vBC329TSmcZ0iE9G4BGxwZTGmIgGUYOJKUhay5duar0b8Pd0oH
 QRHrOjlvTrv0GR52hLClSqdMf684IznVXOKMNmzfAY5r3Es4ZUfbbSJ9sOvydQZBzY4b
 wfcw==
X-Gm-Message-State: APuU4Z9KFnBepdTwCh/KYskQrYUMNkGBWdtnfWBMTGZjjdNuuiEgMBMa
 yn3qi1YOVclbG+YlqC7mlrA/aWS6poLpSOOZZcogjvAO64LXHCDWZ4l5oTclMGDe83Cr9E4lebO
 8sJ5te3mz5VtG9upi6oao6AwPfOjIMIn+bxQV4WHUON4al98fNIt3gLsOhn5dperZivk/
X-Gm-Gg: AYBFou2Izk3cfxpVsLVDPeqUQKxhLWcGS5fFZqMK25R+m+nGTjxl+Qd95MsNCA9FkuQ
 2xU+pFRhdnysRjUz8fqZbrt4KA+mJf2amVPpk8FhTw5UNnKV6HYt3ElfwM4j9KkT5a9UMJeANnO
 x1e3KTmu1gG2ygWcvJaeMI6eeGg2XVlumz/RKl/jQJzv3rvrxASdrd6c/wOFi+FVDYbufrnZfH6
 B3oxfMXNVGyKtHWzg/dmp7ec8CiEMEWAHkTyvNWsJS+fjkD5kTBaaqxLKatsjCzKuAZfrL18j5v
 5xDy5xbM90c47pIeE/A6O9/8By+8zy5D4khgCrQi81GO2LdY21CXqbt3rj7f+4+B7hNv+8oueRH
 FxSTTeynKU1Wd0BBi90dP9Z42GHXmiolWHvA7Q697+Spleqx5b/Vr6MHfQC+rOuo73CfR2+vvJd
 6m3woVUQUQ09pYq/1/Xz2XY+5opw8A15ZzOWsl6y3tWtKiasPchjJZJE0pkA8eZIrsOCXwQM+kd
 JMKiSc8j5a/n2z3cNiDiy+XRM/JBHt/fuzt/ILTf05ZvLo+PtuXO9XqK0ETnySR7vpC234aF8UY
 YxgUgDAHL7RDUkgKAqs3vh2p4OqmSmh22wYrLA+hCogvROPVQ2Zl7xwJ1JLl4YjLRMjpFo4hxSy
 YXVpgE7awcUmv7xxJosVgZJx0/x9+98ZFfxyIN4+PS1whiYsrw5JQF+gN/kLp2Uch47kS9+KSC4
 Y72ZBQI9k72xT9i/P1
X-Received: by 2002:a05:6000:2411:b0:48f:f26d:c5c with SMTP id
 ffacd0b85a97d-49c70b051d1mr6805722f8f.9.1794589079423; 
 Fri, 13 Nov 2026 08:57:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49dc430fa15sm314036f8f.13.2026.11.13.08.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 08:57:58 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 16:57:57 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4
X-Gerrit-Change-Number: 2161
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2161?usp=email>
X-Gerrit-Commit: 09c4f4a189c989fe6aa9ba59237b3440d4619af9
In-Reply-To: <gerrit.1794301782000.I7ffae4da3b29521844a31d234fe6a9dd08954cf4@gerrit.openvpn.net>
References: <gerrit.1794301782000.I7ffae4da3b29521844a31d234fe6a9dd08954cf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAxNzgyMDAwLkk3ZmZhZTRkYTNiMjk1MjE4NDRhMzFkMjM0ZmU2YTlkZDA4OTU0Y2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1371635bfc048d0170644265043594b6e3a20ff7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRubG-000000001KI-1NG2
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net,
 antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3359784897585973387=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3359784897585973387==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ltp8Lv53F8k="; charset=UTF-8

--ltp8Lv53F8k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2161?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Antonio Quartulli, Code-Review+2 by Heiko Hund


Change =
subject: openvpnserv: only remove search domains that were added
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: only remo=
ve search domains that were added

When AddDnsSearchDomains() failed, SetDn=
sSearchDomains() still called
RemoveDnsSearchDomains() with the new domains=
, which removes matching
domains already in the search list, e=2Eg=2E ones =
configured before the
VPN connected=2E Record the undo data first, as done =
for NRPT rules, and
drop it if adding the domains fails=2E

Broken since ae=
90cbad ("dns: support multiple domains without DHCP")=2E

Change-Id: I7ffae=
4da3b29521844a31d234fe6a9dd08954cf4
Signed-off-by: Razvan Cojocaru <razvanc=
@mailbox=2Eorg>
Acked-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Acked=
-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2161
Message-Id: <20261112063232=2E23999-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg41181=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 1=
0 insertions(+), 4 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/61/2161/3

diff --git a/src/openvpnserv/interacti=
ve=2Ec b/src/openvpnserv/interactive=2Ec
index 81205d6=2E=2E5d2abeb 100644
=
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec=

@@ -1823,13 +1823,19 @@
         strncpy_s(undo_data->itf_name, sizeof(und=
o_data->itf_name), itf_name, _TRUNCATE);
         undo_data->domains =3D wi=
de_domains;
 
-        if (AddDnsSearchDomains(list_key, have_list, wide_do=
mains) =3D=3D FALSE
-            || AddListItem(&(*lists)[undo_domains], un=
do_data) !=3D NO_ERROR)
+        /* Add undo information first in case ther=
e's no heap left */
+        if (AddListItem(&(*lists)[undo_domains], undo_=
data) !=3D NO_ERROR)
         {
-            RemoveDnsSearchDomains(list_ke=
y, wide_domains);
             free(wide_domains);
             free(undo_d=
ata);
-            undo_data =3D NULL;
+            goto out;
+        }
+
=
+        if (!AddDnsSearchDomains(list_key, have_list, wide_domains))
+    =
    {
+            RemoveListItem(&(*lists)[undo_domains], CmpAny, NULL);
+=
            free(wide_domains);
+            free(undo_data);
             =
goto out;
         }
     }

-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2161?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4
Gerrit-Change-Number=
: 2161
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerr=
it-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Hei=
ko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>

--ltp8Lv53F8k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2161?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Antonio Quartulli, Code-Review+2 =
by Heiko Hund</p><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">openvpnserv: only remove search domains that=
 were added<br><br>When AddDnsSearchDomains() failed, SetDnsSearchDomains()=
 still called<br>RemoveDnsSearchDomains() with the new domains, which remov=
es matching<br>domains already in the search list, e=2Eg=2E ones configured=
 before the<br>VPN connected=2E Record the undo data first, as done for NRP=
T rules, and<br>drop it if adding the domains fails=2E<br><br>Broken since =
ae90cbad (&quot;dns: support multiple domains without DHCP&quot;)=2E<br><br=
>Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4<br>Signed-off-by: Raz=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Antonio Quartulli &=
lt;antonio@mandelbit=2Ecom&gt;<br>Acked-by: Heiko Hund &lt;heiko@ist=2Eeige=
ntlich=2Enet&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2161<br>Message-Id: &lt;20261112063232=2E23999-1-gert@greenie=2Emuc=2Ede&gt=
;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforg=
e=2Enet/msg41181=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, =
10 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/61/2161/3</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</=
span><br><span>index 81205d6=2E=2E5d2abeb 100644</span><br><span>--- a/src/=
openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interacti=
ve=2Ec</span><br><span>@@ -1823,13 +1823,19 @@</span><br><span>         str=
ncpy_s(undo_data-&gt;itf_name, sizeof(undo_data-&gt;itf_name), itf_name, _T=
RUNCATE);</span><br><span>         undo_data-&gt;domains =3D wide_domains;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (AddDnsSearchDomains(list_key, have_list, wide_domains) =3D=3D FALSE=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            || AddLis=
tItem(&amp;(*lists)[undo_domains], undo_data) !=3D NO_ERROR)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* Add undo information fi=
rst in case there&#39;s no heap left */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (AddListItem(&amp;(*lists)[undo_domains], un=
do_data) !=3D NO_ERROR)</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            RemoveDnsSearchDomains(list_key, w=
ide_domains);</span><br><span>             free(wide_domains);</span><br><s=
pan>             free(undo_data);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            undo_data =3D NULL;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            goto out;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (!AddDnsSearchDomains(list_key, have_list, wide_domains))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            RemoveListItem(&amp;(*lists=
)[undo_domains], CmpAny, NULL);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            free(wide_domains);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            free(undo_data);</span><br><span>      =
       goto out;</span><br><span>         }</span><br><span>     }</span><b=
r></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2161?usp=3Demail">change 2161</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2161?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954=
cf4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2161 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;an=
tonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--ltp8Lv53F8k=--


--===============3359784897585973387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3359784897585973387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3359784897585973387==--

