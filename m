Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3408C5B572
	for <openvpn-devel@archiver.kernel.org>; Sat, 22 Aug 2026 22:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=iZghcLmAM7k7OEqPqf15hg1YbiK0bX5jthOm+PpWaWk=; b=KXAJPfsPcpHnJr
	GsppB1w6BdWfcbYtVP48VrD/gqQOcc1+328J9ex4dCzBYDPrbVebmoBILGp+9c8YXXatUNleyInMg
	7XD6vu/eqkBl1GLz4gO+CAtrHzL9hHORaAYmm4s9yKs8SqaddUDFWTuNIf+lpXnSaywZp3gFuJ5nA
	Noc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxuW5-0004Ti-GA;
	Sat, 22 Aug 2026 22:48:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxuW4-0004TV-6R
 for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 22:48:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ViBJIp1030aW5T/f66MRdIqWkncUkrl3Rd83zuEQa5g=; b=BO2eV9JrsIuPBBnKwwuL8MlOhH
 FgWiB5ARcfTnSXJQMbvMLZ2Ogd8eidlPqWh9rg9MW/V2bm2gzqJ6n3sDmI1ZvHqaTpFk/vxQiFVQE
 PdkPhzFXJ0GZifgtvGg5TH49BI4ZJndWkDqXMdB0wRU9ZqsBqawJbhGwJBVncKpuWiRU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ViBJIp1030aW5T/f66MRdIqWkncUkrl3Rd83zuEQa5g=; b=L
 hg3kRDY7pJ6ZtUfGk8lXu/5fjhdama21p/ZnVyxOxBEkgaJK8otFCvsXHWjyZ8xdE/pDjaOBtTi8t
 iBNxvVDSZ/1Ekihfx0XRsdw8IRLuI7Nz8CPgsaE0k6E1veUwmt+jfexShqB8Sss3EtDk1C/WJtH2W
 Ta5RXJOTTLh+pNBk=;
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxuW3-0003lv-Q5 for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 22:48:44 +0000
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6a051904222so2811667a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 22 Aug 2026 15:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787438917; x=1788043717; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ViBJIp1030aW5T/f66MRdIqWkncUkrl3Rd83zuEQa5g=;
 b=ebZ2kLyfMwBTE0w8p/Fh+5w1equ6vEKz2fcTGDvhhJTJKHEd19Im0Sgi2Dh+s4U6zy
 3PQRbT9cP2mZEJ4EWSr7Ecjw9ZBqv6yWX09EN7FvHDmFVIwTd1wxFVaBSfovUGl6ioZk
 PmAkD/KzfSEFY3gMH7wBiUEeDS6DA9RtH5maMDnDMYUmjUFuCdAriu5VufNAnK/SaEvn
 w4bfNxxDWIfULMx0znAZqhY1+k9dsK22gqjvFnzp6ZoI0QG2OD1VuhNpWMYz2cHgPZt2
 22Vm29vn0fj8nsfkQnYniLdff8qYwmfOdoZrKrKQ4KihSpAzOQYkgwhQkT05spfr5FvE
 NUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787438917; x=1788043717;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ViBJIp1030aW5T/f66MRdIqWkncUkrl3Rd83zuEQa5g=;
 b=IyxxBykLW5BTBA/rViRqTMSXR4EgpptZolIF9xLUWNF11W/Nv2m/pPoOVDs2DUXJpl
 5oSBinsSc7rMaqb+WdEYahVYyJeqe8iivC5x79ZR0r7veyYunQS7T3VdS3kblIzOBjCp
 0PixZOUhtffxDoQZcYGJ0/pbAarwSvSrl7AasUMxRTmwalQymaASftk+NPv8EQTtOymk
 TbYlWYX2VSxhy5jn1wnTi8yMF2S6iqQvGu6Y6kCd9rMORSWmuCnGL1nq/INNX7P+BxGU
 yDJ6+iMCK7HABOyJwYQCjf7t0TK7rqDqENZDOu7Q5m0x3Ni2amBugtG3zoRE9QfYuLDS
 b/FA==
X-Gm-Message-State: AFuF++nSloffa+2UO2+Ve55Ofw6JVTEfpHXIkoLCM7Mxj9kCn7hssRTw
 a4WED7P4RQcP6zvXZCvmnHZ8HdJniW8HRh/i+BHLaFZ9hiKhATNDH9U63iR/BuDZMfRUE2DmlV/
 8Oo5e30KjH3tLTSv92wScNofgKQ4a2jQcXoAHIIRez0XQPiQP3B8AQ/MdPXNQQrSFCb3/AimNDq
 xVqotxbw==
X-Gm-Gg: AR+sD116Yx2VB24PenzEZUB82Pt3ky7T2zT3RmVESGGec3q5VP1i/hhGwW/402DHq7v
 QVebO6HWL/ooDj3XSNU29U3ewb6pcAQhOUi8JYg4HAZGM/UGn30nJta5ILrwkJBrtpdbBA8AXkE
 y/SfedcypprFhnutN9vs2lZ7nQv+M1PjIpw9Jjst6IKXpz1txvYxcYxshDYuqm7hkx1lzQySDIw
 wmBqoCzYX7twJUnSMoNlku2O5VpV2EQ5JlV2iewc4vBA2J+6OyjHpgLuKu/AiAiSFp1b2Htj/rm
 CyurPDXCFUQft9urn1HmwOIG2UKLEDYIW+rtp7/6IrZDiLonzkBDwdkpfuqOgBiNzan18Y2PpZa
 zUjXOuWXT4RZ7bTg5ECCubfhtvvU7R6/bs2Zl3QAyHyKoKauNnRV9decbqezy8VGsk+kPs0fU7N
 QLs/JNqv9bLq+pxZDzIYMYjzPUmQ6P6ypNIpBtumkyKFt0opGPwzmSG6PzoHb6rvYjMmJihyppY
 hHuHCB2XJPZu/UdQuwSl9erIInL8HBXZDEg+iqV51yGYd3Avb9Uxu5+6QyNN989n+vRC8tpnQOk
 EDZsJ94UzgyYaPxs3oXvWgnwIMHY0gLkvi3Kcy5oImBdYbEqrn8=
X-Received: by 2002:a05:6402:2187:b0:6a3:95bd:143c with SMTP id
 4fb4d7f45d1cf-6a42f154b80mr18603234a12.5.1787438917103; 
 Sat, 22 Aug 2026 15:48:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e1d741asm35964a12.27.2026.08.22.15.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 15:48:36 -0700 (PDT)
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 22 Aug 2026 22:48:36 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iec392a47123d618c0dbc3a5241c39da4ac83d880
X-Gerrit-Change-Number: 1861
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1861?usp=email>
X-Gerrit-Commit: 4cccdf6e27b97d01e33a9b95ddc6ea1f1252dc24
References: <gerrit.1787438913000.Iec392a47123d618c0dbc3a5241c39da4ac83d880@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NDM4OTEzMDAwLkllYzM5MmE0NzEyM2Q2MThjMGRiYzNhNTI0MWMzOWRhNGFjODNkODgwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4fe1be8f564675064bccff519b2d795ffcda6cea-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxuW3-0003lv-Q5
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: fix log
 lines format string
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
From: "d12fk \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "d12fk \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3349546926422464675=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3349546926422464675==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BM4vMeTYB4I="; charset=UTF-8

--BM4vMeTYB4I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1861?usp=3Demail

to review the following change=2E


Chang=
e subject: openvpnserv: fix log lines format string
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: fix log lines format =
string

The interface name is UTF-8 encoded=2E In order to log it correctly=
,
it needs to be converted to UTF-16 first=2E

Change-Id: Iec392a47123d618c=
0dbc3a5241c39da4ac83d880
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=
=2Enet>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 9 insertions(=
+), 3 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/61/1861/1

diff --git a/src/openvpnserv/interactive=2Ec b/src=
/openvpnserv/interactive=2Ec
index 32c1b9c=2E=2Eb120fa2 100644
--- a/src/op=
envpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -1224,19=
 +1224,25 @@
     err =3D InterfaceLuid(itf_name, &luid);
     if (err)
   =
  {
-        MsgToEventLog(M_ERR, L"%S: failed to convert itf alias '%s'", =
__func__, itf_name);
+        PWSTR wide_name =3D utf8to16(itf_name);
+    =
    MsgToEventLog(M_ERR, L"%S: failed to convert itf alias '%s'", __func__,=
 wide_name);
+        free(wide_name);
         goto out;
     }
     err =
=3D ConvertInterfaceLuidToGuid(&luid, &guid);
     if (err)
     {
-       =
 MsgToEventLog(M_ERR, L"%S: Failed to convert itf '%s' LUID", __func__, itf=
_name);
+        PWSTR wide_name =3D utf8to16(itf_name);
+        MsgToEven=
tLog(M_ERR, L"%S: Failed to convert itf '%s' LUID", __func__, wide_name);
+=
        free(wide_name);
         goto out;
     }
 
     if (StringFromIID=
(&guid, &iid_str) !=3D S_OK)
     {
-        MsgToEventLog(M_ERR, L"%S: Fai=
led to convert itf '%s' IID", __func__, itf_name);
+        PWSTR wide_name=
 =3D utf8to16(itf_name);
+        MsgToEventLog(M_ERR, L"%S: Failed to conv=
ert itf '%s' IID", __func__, wide_name);
+        free(wide_name);
        =
 err =3D ERROR_OUTOFMEMORY;
         goto out;
     }

-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1861?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: Iec392a47123d618c0dbc3a5241c39da4ac83d88=
0
Gerrit-Change-Number: 1861
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@=
openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--BM4vMeTYB4I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>d12fk would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1861?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">op=
envpnserv: fix log lines format string<br><br>The interface name is UTF-8 e=
ncoded=2E In order to log it correctly,<br>it needs to be converted to UTF-=
16 first=2E<br><br>Change-Id: Iec392a47123d618c0dbc3a5241c39da4ac83d880<br>=
Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M =
src/openvpnserv/interactive=2Ec<br>1 file changed, 9 insertions(+), 3 delet=
ions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/61/1861/1</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/int=
eractive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 32c1b9=
c=2E=2Eb120fa2 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec=
</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -=
1224,19 +1224,25 @@</span><br><span>     err =3D InterfaceLuid(itf_name, &a=
mp;luid);</span><br><span>     if (err)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_ERR, L&quo=
t;%S: failed to convert itf alias &#39;%s&#39;&quot;, __func__, itf_name);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        PWSTR wide_n=
ame =3D utf8to16(itf_name);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        MsgToEventLog(M_ERR, L&quot;%S: failed to convert itf alias=
 &#39;%s&#39;&quot;, __func__, wide_name);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        free(wide_name);</span><br><span>         go=
to out;</span><br><span>     }</span><br><span>     err =3D ConvertInterfac=
eLuidToGuid(&amp;luid, &amp;guid);</span><br><span>     if (err)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        M=
sgToEventLog(M_ERR, L&quot;%S: Failed to convert itf &#39;%s&#39; LUID&quot=
;, __func__, itf_name);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        PWSTR wide_name =3D utf8to16(itf_name);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, L&quot;%S: F=
ailed to convert itf &#39;%s&#39; LUID&quot;, __func__, wide_name);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        free(wide_name);</s=
pan><br><span>         goto out;</span><br><span>     }</span><br><span> </=
span><br><span>     if (StringFromIID(&amp;guid, &amp;iid_str) !=3D S_OK)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        MsgToEventLog(M_ERR, L&quot;%S: Failed to convert itf &#39;%s&#39; =
IID&quot;, __func__, itf_name);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        PWSTR wide_name =3D utf8to16(itf_name);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, L&quot=
;%S: Failed to convert itf &#39;%s&#39; IID&quot;, __func__, wide_name);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(wide_name=
);</span><br><span>         err =3D ERROR_OUTOFMEMORY;</span><br><span>    =
     goto out;</span><br><span>     }</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1861?usp=
=3Demail">change 1861</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1861?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Iec392a47123d618c0dbc3a5241c39da4ac83d880 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1861 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--BM4vMeTYB4I=--


--===============3349546926422464675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3349546926422464675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3349546926422464675==--

