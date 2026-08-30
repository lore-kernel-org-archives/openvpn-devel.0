Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0722EC61DD9
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 18:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=DpxxwfPO+eW8xNggvWj3QD7JnXgdivQtO/O0dX4XpZk=; b=Hk/A4ggBm82ESa
	GCsjYoqHo7dLWW68qd/SdaFyc6DMS+bDF9QCqMj4IeH6CyRcI/8/udl/ewE/A9lzQ8fwfoBYuNYBU
	Jf4o1OKeNjwiPyHOVNfjMx+KT6jKWqrBRQq3lsStZUwge36ZndoRnnSnQugIQ5AVk7/CvYxqO78ym
	60w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0k1H-0002Tf-NI;
	Sun, 30 Aug 2026 18:12:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0k1G-0002TZ-S0
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 18:12:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v2bavqip8qHuQd7S8Vg9EL2/vM+gZ/5f160aj5UEVOM=; b=EAhoY4D2jpaJJa+yDR7Ar972qa
 LZ0PPcs6vKinwj0fSMCCvhyQtgjTTMBb11N/Xzekav7hKw1gQoWC95SvIRwH6DKmuEG82pWboXj/h
 Ob3vyYSxXQmQSvUHxnBiWmiGQkmdJEuRek5mlKkz34xPHFdE8lJCsPIehcK00gjxwqyI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=v2bavqip8qHuQd7S8Vg9EL2/vM+gZ/5f160aj5UEVOM=; b=K
 bWAoTmAR81j7SAiobWEIJ/faQhDOcrvVu6+8BHSO2WL3m7WGRHXzXTPsanlzwxQRDrrNTtiVn0Xnu
 y8AOlYVRyBpTc28zfVN+EEdh60EhwUI8cE7aJjorD5n2rxxApQJ9CTmGurrjcUiQ4k68Z4TwlAKbL
 31uPg4SFbYk6rlSU=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0k1D-0005FB-DC for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 18:12:36 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso22917585e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788113549; x=1788718349; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=v2bavqip8qHuQd7S8Vg9EL2/vM+gZ/5f160aj5UEVOM=;
 b=AfSmjq4EHxCpXSOHFoere82xJkcntdm7V48mmxQPHY+blTLJ1ZbBuNyb/Whd+bWYsp
 ca9UYqQliEib9muZXlFmjVC495lImPZKsRcVe1Hjex8xtMadXNM7/n2E+8L5B26ngitk
 E6GL/0eRLZ8E4fQ5bWCV4yB7wqL050G90mkGKaOCu9ecz/Iyov+m26NoRKor4yaY80um
 yYFeDGeDjbzaqCTm9A2M3K7ftw6QKfhyDr2kXGvTK39PAnLH+UCGy4t+SE/Wn8JyCbPN
 ZiQmHJ43Vsk3KvG4/BpUQHSRTOHwniPc0dl4e+czbjWfAQWYnyDWwcq7QLc/Er9cDeZC
 +3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788113549; x=1788718349;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v2bavqip8qHuQd7S8Vg9EL2/vM+gZ/5f160aj5UEVOM=;
 b=rmdr6MRTeiTa0Dc8DUP6ibEVyAETVzqnNo1txf3/B0qEojLkNZ3J7LpwQIHbQgkt5Y
 62VuY6z+w8FFI/e084sksQ0jKKx7lrtTpCEEhBB02OMNg8wjS01Qio6QL2KqY9Ws0C8q
 Wm44b5KAJW1Dfy5DjObA2Tjw8b/yUfdzOL5Qpi/DFCLak/xl4QE/oZSngiLnZQs0Ofj8
 KGIVuhXV7Yl8yxyXbUsNHic2/fNverr2uLEK+QrRB1O8m6D5+FAsN+Ivq4NaQk89HQy2
 c2NHy7o35qgdDu1fv3Alf3NU1xCYe8JyOd3ShhmyB87UxkbxgMkQnC6LBkm2WgpLpP/V
 k6zw==
X-Gm-Message-State: AFuF++loqJhxclGGJBCyg+K487RW4PxCaFopBKSd6uj1xIOhRP70IN/7
 xg7jQ3bFwQ5J5+15Xof/voh4AjX58jo6/x907DdDM/s2kIDB3LwAHbRWf41WgXvC02rWDqQ7v5b
 BxZ+zpUfdSH7XskOfgDkUwdE/uxXcJjgbO1Cr7MB7zRr4HHPeiGbflNKPjefrd0HT64ukLGg1IC
 GYbmlqAw==
X-Gm-Gg: AR+sD11M8wT7uDGO0FEUyEdY/olExTKWDWhMMtzyoHpgz8t5uagzd+aSYChaWbS0eiV
 tmG923Vt89DTB6lGz8HMQLkqFs0SP7Qo0/BR9ilcaWLEs6My6gTvLI+Z47lMfbJunJtHypL/DWo
 ChfkLWGDTsjZOTcXpqxkcldjgh9gqepyYEa/LdLL9M/IrzetVqeka6SAapBCusifaF45qjl+zLl
 z6HKilYRmeNJMvsyXTq6b8VeeQiXxVHh2HimUB3q876C8PJtSFCp8r5p09Xq/Ndzmy7HylKHCHc
 JRWdVnfNNi1UnV3lmgecYWhbKck93meNBBS6hhgt+PcecJWSFyRYTlLXdgrc0kvDBxWaJyIU2j8
 ImOLeV1MQ+H1l03H8oKZtLTchEeA7lazFvfUPcpOAA73zk7HttsGoqdVe3aU7dRXgzz2xYbN8AI
 KcnZOPmJHpv4HpFCsRNCWvxR46bGFGEkCTg32V0gDvS5hqkIGUe+v+RmYZsxjBRgO4aOY7kd5UC
 LJAnE82OKoe7569lDkgllLeqn58NCjwGM4z9SldgUf80r9Ea7tXgWwDMzx7ja4fLKebbws4U0Wl
 JmprxfCh6R9KHjTxZLxJicVo3zUroxtZZU019FIWu0jNzxEJ0nk=
X-Received: by 2002:a05:600c:870f:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49cd538cb5fmr68560245e9.3.1788113539649; 
 Sun, 30 Aug 2026 11:12:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49c44feb966sm199554245e9.6.2026.08.30.11.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 11:12:19 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 18:12:19 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ica5d43989b441d4377a3908f811a2953b7a9d45a
X-Gerrit-Change-Number: 1883
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1883?usp=email>
X-Gerrit-Commit: 5df16c3a170e08f59f94b7c36b73d5c84883148f
References: <gerrit.1788113537000.Ica5d43989b441d4377a3908f811a2953b7a9d45a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTEzNTM3MDAwLkljYTVkNDM5ODliNDQxZDQzNzdhMzkwOGY4MTFhMjk1M2I3YTlkNDVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e3c473e5e35e458759cd6d92c8cc12af2a35089b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0k1D-0005FB-DC
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: openvpnserv:
 detect sibling dirs in CheckConfigPath
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8910461042270948257=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8910461042270948257==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0SXvcCyjpfk="; charset=UTF-8

--0SXvcCyjpfk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos=2E

Hello plaisthos,=


I'd like you to do a code review=2E
Please visit

    http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1883?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: detect sibling dirs in CheckConfigPath
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: det=
ect sibling dirs in CheckConfigPath

If the config_dir value in the registr=
y has no trailing backslash the
check doesn't actually guarantee that a fil=
e is located within
config_dir, because a sibling dir with the same prefix,=
 e=2Eg=2E 'config'
and 'config-evil' will match and produce a positive verd=
ict=2E

By also checking that there is a path separator after config_dir
pr=
events this attack=2E

Reported-By: Harshit Varu <harshitvaru666@gmail=2Eco=
m>
Tested-By: Harshit Varu <harshitvaru666@gmail=2Ecom>
CVE: 2026-81830
Git=
hub: OpenVPN/openvpn-private-issues#166
Change-Id: Ica5d43989b441d4377a3908=
f811a2953b7a9d45a
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
=
---
M src/openvpnserv/validate=2Ec
1 file changed, 14 insertions(+), 3 dele=
tions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/83/1883/1

diff --git a/src/openvpnserv/validate=2Ec b/src/openvpnserv/=
validate=2Ec
index 770a7a0=2E=2Eb0fb6b85 100644
--- a/src/openvpnserv/valid=
ate=2Ec
+++ b/src/openvpnserv/validate=2Ec
@@ -56,7 +56,9 @@
 
 /*
  * Chec=
k workdir\fname is inside config_dir
- * The logic here is simple: we may r=
eject some valid paths if =2E=2E\ is in any of the strings
+ * The logic he=
re is simple:
+ *      we may reject some valid paths if "=2E=2E" is in the=
 filename
+ *      or if there's no "\" after the config directory
  */
 st=
atic BOOL
 CheckConfigPath(const WCHAR *workdir, const WCHAR *fname, const =
settings_t *s)
@@ -82,9 +84,18 @@
     }
 
     config_dir =3D s->config_di=
r;
+    size_t config_dir_len =3D wcslen(config_dir);
 
-    if (wcsncmp(co=
nfig_dir, config_file, wcslen(config_dir)) =3D=3D 0
-        && wcsstr(conf=
ig_file + wcslen(config_dir), L"=2E=2E") =3D=3D NULL)
+    /* check for a p=
ath separator after config_dir */
+    if (config_dir_len && config_dir_len=
 < wcslen(config_file)
+        && config_dir[config_dir_len - 1] !=3D L'\\=
'
+        && config_file[config_dir_len] !=3D L'\\')
+    {
+        retur=
n FALSE;
+    }
+
+    if (wcsncmp(config_dir, config_file, config_dir_len)=
 =3D=3D 0
+        && wcsstr(config_file + config_dir_len, L"=2E=2E") =3D=
=3D NULL)
     {
         return TRUE;
     }

-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1883?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: release/2=2E6
Gerrit-Change-Id: Ica5d43989b441d4377a3908f811a2953b7a9d4=
5a
Gerrit-Change-Number: 1883
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@=
greenie=2Emuc=2Ede>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Attention: d12fk <heiko@openvpn=2Enet>

--0SXvcCyjpfk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, plaisthos=2E </p>
<p>cron2 would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1883?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">openvpnserv: detect sibling dirs in CheckConfigPath<br><br>If the conf=
ig_dir value in the registry has no trailing backslash the<br>check doesn&#=
39;t actually guarantee that a file is located within<br>config_dir, becaus=
e a sibling dir with the same prefix, e=2Eg=2E &#39;config&#39;<br>and &#39=
;config-evil&#39; will match and produce a positive verdict=2E<br><br>By al=
so checking that there is a path separator after config_dir<br>prevents thi=
s attack=2E<br><br>Reported-By: Harshit Varu &lt;harshitvaru666@gmail=2Ecom=
&gt;<br>Tested-By: Harshit Varu &lt;harshitvaru666@gmail=2Ecom&gt;<br>CVE: =
2026-81830<br>Github: OpenVPN/openvpn-private-issues#166<br>Change-Id: Ica5=
d43989b441d4377a3908f811a2953b7a9d45a<br>Signed-off-by: Heiko Hund &lt;heik=
o@ist=2Eeigentlich=2Enet&gt;<br>---<br>M src/openvpnserv/validate=2Ec<br>1 =
file changed, 14 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/1883/1</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpnserv/validate=2Ec b/src/openvpnserv/validate=
=2Ec</span><br><span>index 770a7a0=2E=2Eb0fb6b85 100644</span><br><span>---=
 a/src/openvpnserv/validate=2Ec</span><br><span>+++ b/src/openvpnserv/valid=
ate=2Ec</span><br><span>@@ -56,7 +56,9 @@</span><br><span> </span><br><span=
> /*</span><br><span>  * Check workdir\fname is inside config_dir</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * The logic here is simple: we=
 may reject some valid paths if =2E=2E\ is in any of the strings</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * The logic here is simple:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      we may reject=
 some valid paths if &quot;=2E=2E&quot; is in the filename</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *      or if there&#39;s no &quot;\=
&quot; after the config directory</span><br><span>  */</span><br><span> sta=
tic BOOL</span><br><span> CheckConfigPath(const WCHAR *workdir, const WCHAR=
 *fname, const settings_t *s)</span><br><span>@@ -82,9 +84,18 @@</span><br>=
<span>     }</span><br><span> </span><br><span>     config_dir =3D s-&gt;co=
nfig_dir;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t=
 config_dir_len =3D wcslen(config_dir);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (wcsncmp(config_dir, config_file=
, wcslen(config_dir)) =3D=3D 0</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        &amp;&amp; wcsstr(config_file + wcslen(config_dir), L&quot=
;=2E=2E&quot;) =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* check for a path separator after config_dir */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (config_dir_len &amp;&amp;=
 config_dir_len &lt; wcslen(config_file)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        &amp;&amp; config_dir[config_dir_len - 1] !=3D=
 L&#39;\\&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   &amp;&amp; config_file[config_dir_len] !=3D L&#39;\\&#39;)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return FALSE;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (wcsncmp(config_dir, config_file, config_dir_len) =3D=3D 0</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; wcsstr(config=
_file + config_dir_len, L&quot;=2E=2E&quot;) =3D=3D NULL)</span><br><span> =
    {</span><br><span>         return TRUE;</span><br><span>     }</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1883?usp=3Demail">change 1883</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1883?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E=
6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ica5d43989b441d4377=
a3908f811a2953b7a9d45a </div>
<div style=3D"display:none"> Gerrit-Change-Nu=
mber: 1883 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<d=
iv style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@op=
envpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 d12fk &lt;heiko@openvpn=2Enet&gt; </div>

</body></html>
--0SXvcCyjpfk=--


--===============8910461042270948257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8910461042270948257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8910461042270948257==--

