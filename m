Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF6CCCF2D6
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+xspnBqbcHtV1979fXjNNoDa+o7LnLNZJJ+Ahrdhd48=; b=I7GFQZD4ni9jhG/tqmwvSewjBO
	W+1xT1U0zTUdz6n48lxREk8mjh2oMpIiTpPyxj7WnNT1btAUx+CSZ5js5nyhqDZ5JJ2c8aEQSRjeu
	PFGB+seJZ4AtKmPiRWjYiAPhUF6wjSmX0dvl07bVzdn1qsbMlfTs1FtYvhLtMIPwX5F4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xImof-0003yv-FW;
	Mon, 19 Oct 2026 12:50:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xImoe-0003yo-65
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 12:50:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ypedi1wtKuLiT6RfHpVrxerSD+F4Thm7QEhKbDljnw8=; b=I1I94+c5PWgh3uckWuqHfnuqyg
 rkKgbdpe3rtsDIMpMXXEGVF1jZiGBhbN2zhMpPE96DfBVUSmma77eqepKFnn2TJhXMMvBc8DTRvwV
 uJnKVOjy9cwUReTl7hld02jYuJzDiaAcE8MDqU3ELZ5qcvbK0gndiJcCEm1Fptcq2tWw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ypedi1wtKuLiT6RfHpVrxerSD+F4Thm7QEhKbDljnw8=; b=l
 59xytRBq+PLEdWm7nvE6jt0b9E3qlofES8K1BhipbDHJY7Y/iBB03V4KfXkRGJprIdz7K5aXY/oAr
 RV6vz70naWdx93DaUOd8K969z/eWn35UY7uEv9eQk3BXjxwKFg5uFQ5HWiw7J/yXNxRaJzHcJW4mD
 RadWbgaxHhrq3x48=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xImob-0007At-3h for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 12:50:12 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1dfd49525so12010255e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 05:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792414202; x=1793019002; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ypedi1wtKuLiT6RfHpVrxerSD+F4Thm7QEhKbDljnw8=;
 b=Fviy5uZU6iVyyDINA/etQobIPvyV3kCW5ix5BV6ozJtrQbUPJ7WT4PMYASQl+sW2sS
 cTwV0iqu4YfAEhBVicRygFuK6gOTqjioqHjusPbVoYe3C5A8s4N+5m21aca+osrtEm0N
 cnxnB9ElWWrAt/6Ux4ayZrRtUfy5e1yqyfXd9Xbj/Gvks582ohxC9FFFUMs9YbtFC+kS
 94/T5RIVe4I3yaCZiHK+RPeAvfBHe42u3Kaz1ViFBeb0DpG71YA/jSH+n48C5cJB5oBj
 Rv2hHr0C2I1NQlNti9W5bROF33eH03iwDwbsQXuhVwRFt/929VHFn5KD8g66/20a0U+0
 oXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792414202; x=1793019002;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ypedi1wtKuLiT6RfHpVrxerSD+F4Thm7QEhKbDljnw8=;
 b=vkZO1ognM+DDOQds5Way35YiPipfHUrdqkVZpj5w33KtNxmf81soQstuce1Qf78ynb
 JZ+6pn+TZZKMAdMyWovdX2VO+CeUpNlVRjf2nuuNwla2OokQlX3qi68oI1lN2cxYIrEr
 I5lvmRoUlGeuNRtBKWias8qdQHquXtP/odAQU7ZhKdiKb6kqb/EKoe3FAAKullnAvhj3
 IoMOOSc+v1jM6Tn13huFvOnGRcz0prR+39wN9tapeAP3DxmDwD6doXAV+ZxNKlzJ3nTm
 Y3LVTuIXtXtjpud3IUPKNUNnbt+PI8JYEq7uo4Z+TTjoTP4JOI0+++P/0teOGH3Jzc6V
 0jfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBylqlgGmc/OknKYZ74UuknQGNf8UgmsdXhjyI0QQBRaM2zrnI4fHT860qSFvui1rR81n2TqPASVoq3Ax/Uc@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKHEUyhYzOOMVJLrDUg0Ej+8FgiTkJiaFDFy6KliMepNuaxiqLd
 sbmqlKCTIPjoYK+kqfkFoaUKlEgusyVn1HvUin1ocLiOfk9ummiTMuDa2xPggzy4JcsbYviol0B
 STYD5+VIbQ+9+jGOWyc9/PgzsBrpQ/9D0tS6OhKxaOJ4nV5oNgTfAtzFzOyPAKhT8a6bO
X-Gm-Gg: AYBFou1DgimywIoC6Kinae4NmYuv1HVOuR/0y92rgSnRESCuIupKIz5xWjnwTpXgutv
 1Per3J7cGz/2rvsi0NQPu98/ScV4J5QBfTdR2F1FVGVVyFemASXUA0I7zvIbveXTelQ4u2id47L
 SeviodKFYDpLE7lYRCAhb3G5YAGECjVw/svolBRkAwIOndySyh/OHM3uV909F3I9EQl5m1m09vj
 2e/MG/e8RYGv1CwxWTwqS0RzJzXUhzhRMqkoUcsg/XhMO+rpKBXKR1dw5V+LyF1P87HGHbKEv5u
 C9fKkbp/VtLaPzRoL/vmxKOwe7fXDkWHlhzt3m0CkTp3iJpwye34PX4a/Gq+sZWzVmd5YWyULLz
 Pb9J1cX8bhM3UUrlCnuZDK/iGLPi0mc8CsVSIjfSBnE6uFK7QB9X3BBQduid9nZnGMV5FQV/1Eh
 YgcpA56zNvGg9ah0iGDh+yLFS9dQq5he/6dSmK1izgyM6wFLS31j3xOg9m0lWpUBsHmE9ict9Ku
 Jvzn/98gn813/PO2Wb1XCDcCiw/PH0G/ZxORYNrxyK8iqexCwBe1BkcONV/wS6w63hd2JxQlq2E
 AvUWvQHUSPZSR8bT9Z2USgW+alEN8OHQS1JXwWWc71eafuJHG1wZKujlYc8d
X-Received: by 2002:a05:600c:c16a:b0:4a1:acab:234c with SMTP id
 5b1f17b1804b1-4a1d75f23a1mr158298945e9.10.1792414202408; 
 Mon, 19 Oct 2026 05:50:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471b06sm25619017f8f.5.2026.10.19.05.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 05:50:02 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 19 Oct 2026 12:50:01 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c
X-Gerrit-Change-Number: 2005
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2005?usp=email>
X-Gerrit-Commit: 4562a9e5953eda34ce8540814be797dc1407676f
In-Reply-To: <gerrit.1792255622000.I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c@gerrit.openvpn.net>
References: <gerrit.1792255622000.I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLkk2YjAzYmE5MzkzODdjMmE4NzMxMDVmNmI2Y2Q1ZjE4ZWZiZjRkZDRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <88ecec3078e81d7ab64c37387f8944abf6948411-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xImob-0007At-3h
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: Avoid
 conversion warnings in send_push_options
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4743590477836569954=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4743590477836569954==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IDFqBV1PsFQ="; charset=UTF-8

--IDFqBV1PsFQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2005?usp=3Demail )

Change subject: push: Avoid conversion warn=
ings in send_push_options
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

push: Avoid conversion warnings in send_push_options

Make su=
re we have a sane length and convert it to int=2E

Change-Id: I6b03ba939387=
c2a873105f6b6cd5f18efbf4dd4c
Signed-off-by: Frank Lichtenheld <frank@lichte=
nheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2005
Message-Id: <20261018154151=2E23586-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg40021=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/push=2Ec
1 file changed, 8 insertions(+), 12=
 deletions(-)




diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
=
index 8dfe0d5=2E=2Ead95a0f 100644
--- a/src/openvpn/push=2Ec
+++ b/src/open=
vpn/push=2Ec
@@ -733,11 +733,6 @@
     }
 }
 
-#if defined(__GNUC__) || def=
ined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignore=
d "-Wconversion"
-#endif
-
 static bool
 send_push_options(struct context *=
c, struct buffer *buf, struct push_list *push_list, int safe_cap,
         =
          bool *push_sent, bool *multi_push)
@@ -748,8 +743,13 @@
     {
  =
       if (e->enable)
         {
-            const int l =3D strlen(e->opt=
ion);
-            if (BLEN(buf) + l >=3D safe_cap)
+            const size=
_t l =3D strlen(e->option);
+            if (!buf_size_valid(l))
+         =
   {
+                msg(M_WARN, "--push option is too long");
+          =
      return false;
+            }
+            if (BLEN(buf) + (int)l >=3D=
 safe_cap)
             {
                 buf_printf(buf, ",push-continuat=
ion 2");
                 {
@@ -764,7 +764,7 @@
                     buf_pr=
intf(buf, "%s", push_reply_cmd);
                 }
             }
-       =
     if (BLEN(buf) + l >=3D safe_cap)
+            if (BLEN(buf) + (int)l >=
=3D safe_cap)
             {
                 msg(M_WARN, "--push option is=
 too long");
                 return false;
@@ -776,10 +776,6 @@
     retur=
n true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diag=
nostic pop
-#endif
-
 void
 send_push_reply_auth_token(struct tls_multi *mu=
lti)
 {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2005=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6b03ba93938=
7c2a873105f6b6cd5f18efbf4dd4c
Gerrit-Change-Number: 2005
Gerrit-PatchSet: 2=

Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <g=
ert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--IDFqBV1PsFQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2005?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">push: Avoid conversion warnings in=
 send_push_options<br><br>Make sure we have a sane length and convert it to=
 int=2E<br><br>Change-Id: I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c<br>Sign=
ed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: R=
azvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2005<br>Message-Id: &lt;20261018154151=2E23586-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg40021=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/push=2Ec<br>1 file changed=
, 8 insertions(+), 12 deletions(-)<br><br></pre>
<pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 8dfe0d5=2E=2Ead95a0=
f 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/s=
rc/openvpn/push=2Ec</span><br><span>@@ -733,11 +733,6 @@</span><br><span>  =
   }</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic igno=
red &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> static bool</span><br><span> send_push_options(struct context *c,=
 struct buffer *buf, struct push_list *push_list, int safe_cap,</span><br><=
span>                   bool *push_sent, bool *multi_push)</span><br><span>=
@@ -748,8 +743,13 @@</span><br><span>     {</span><br><span>         if (e-=
&gt;enable)</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            const int l =3D strlen(e-&gt;option);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            if (BLEN(buf) + l =
&gt;=3D safe_cap)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          const size_t l =3D strlen(e-&gt;option);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if (!buf_size_valid(l))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                msg(M_WARN, &quot;=
--push option is too long&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (BLEN(buf) + (int)l &gt;=3D safe_cap)</spa=
n><br><span>             {</span><br><span>                 buf_printf(buf,=
 &quot;,push-continuation 2&quot;);</span><br><span>                 {</spa=
n><br><span>@@ -764,7 +764,7 @@</span><br><span>                     buf_pr=
intf(buf, &quot;%s&quot;, push_reply_cmd);</span><br><span>                =
 }</span><br><span>             }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            if (BLEN(buf) + l &gt;=3D safe_cap)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (BLEN(buf) + (int)l =
&gt;=3D safe_cap)</span><br><span>             {</span><br><span>          =
       msg(M_WARN, &quot;--push option is too long&quot;);</span><br><span>=
                 return false;</span><br><span>@@ -776,10 +776,6 @@</span><=
br><span>     return true;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC=
 diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> voi=
d</span><br><span> send_push_reply_auth_token(struct tls_multi *multi)</spa=
n><br><span> {</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2005?usp=3Demail">change 2005</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2005?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: I6b03ba939387c2a87310=
5f6b6cd5f18efbf4dd4c </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 2005 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--IDFqBV1PsFQ=--


--===============4743590477836569954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4743590477836569954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4743590477836569954==--

