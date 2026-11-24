Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31461606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UfjySvMS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cCRzjx2T;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mlLC4zco;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fwIVCPD4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IXJH0c1EPoyY2Y4xAQCznfPzI1p3I9lh2C6g6hUcUQM=; b=UfjySvMSOLY4Lr
	qrFUTK1VXxd2buJjbdADeviLi09xz/C9PZtjAjGDbzKNxRmJJ2Z/jxc8Xtba6wgTlrCE+gyMZlUUv
	7+XO5C7HXR7EhDb7SXpApY9cyr7gJoylFRocGYMLxuYIahB9T7YWXkqsL6zw7/YtKBfrjK0IDbUsS
	k+c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVsFg-000000005ep-2qTe;
	Tue, 24 Nov 2026 15:16:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <kirthikaditya@gmail.com>) id 1xVsFf-000000005ed-2GDB
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 15:16:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Cc:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XdsFX2jkxfp3y0aqI/9oYHu5zCiylixu3ZxDWJPGIqQ=; b=c
 CRzjx2TQBS8iR9pNGw6HNk3YaB+O80diMcKd7VKxXoArsX1fUtgXv3SEH6rJgJ1jS1qnGOD0dmFHP
 EAL851h8mxaTzUms3n/PySIsw6L0Lh1QBeJ3CIeAFruLO6ZjI8F5sRwrgCFHEfhSXAG/MsnNgfchG
 ooxU19jpeO24GF7o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XdsFX2jkxfp3y0aqI/9oYHu5zCiylixu3ZxDWJPGIqQ=; b=mlLC4zco8hTCMxqj1XS+D2v8sJ
 hrq8ftQe2EXAUV8xJb2ETFB96ZJEiUxqaVUPXubM+HqDCNE+DdEO4j+m4yr0K8+us1lCX0U7NbOAY
 Z/Be1wEK6mQG/h9ox80IU+Ej2rHiSC2UsllbFHcqE83VxOQHGCbiq/j0jregiKaD4kW0=;
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVsFd-0000000066E-2af7 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 15:16:11 +0000
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6b86fcbd647so7311260a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 07:16:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795533363; cv=none;
 d=google.com; s=arc-20260327;
 b=RbviUIz7io3QeI20ClEbEK9wYv7VCT0uXpJe3kbkbNRnq0okrECJeW9ieaChSNKU1a
 FPB0siPl0mvbkBaXlWwqQeMCfHJsJYRs8XMvB1ntsAfKrCTakfHAh0iv680rv5xOhVal
 wH7Yfi6AxR6y4TkhiW6z6X7d8XWIcZo5ind3gBV+mHuvtXgJWVoyFxQUe48rFiVVOg1h
 fiRIr9JNEzYxtBCtDGolmRuGj0D6MS95IBdWZgwm3NJ6qRS7HTRWxN6gDYgx14gUhUU9
 ga3rd3K1GlRVKQfgQ6u+VmSAolhNIm/vC3OviUNppeddaNl3D7CguzqDNnTbWIlLjJTF
 yWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=XdsFX2jkxfp3y0aqI/9oYHu5zCiylixu3ZxDWJPGIqQ=;
 fh=4NbAC/LsuMLI0S0hprUlLSLCiHwg6SCAifhH718Jh0Q=;
 b=Yzxl5zUJWqhPmfi/hyHSCschFKx7fMjvRGM7k3ipMmH8YiISffhX8AXyluP2452z18
 7wD046rOj/9RNw1rdk4knVpWw+JVksUoYODGtvU6KpVYRZwA/QTyl+w4jjDCmXml13rU
 4S+i+Xm82bfLXzliAbLZcBn1n43gWJpKHP5bYzaDwWUHblyRHk+d+qlguRwqaU4kYrTS
 0lFGggkXaJTIdX+DjU2hlNGwXSSo0sW3q3nV5LO36LsTEEM7vQucIhPHqImer/+lfZ7D
 Way84cfAxZsJtU4lxG7wRR6fby1zZFwcmV49UaBSd/ymfHUw1drNiDiDjjiB/6RJF9Z8
 CN3g==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795533363; x=1796138163; darn=lists.sourceforge.net;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XdsFX2jkxfp3y0aqI/9oYHu5zCiylixu3ZxDWJPGIqQ=;
 b=fwIVCPD4iirxhzraks92kY5uAnPfdWVeEZfcO0Q0ZAdEyza9Z6zQ2QyvVhDcBe8E1y
 R021KaXxd17P0Gzro7J58+17QDbL835o9wKOGnsQBJ0S489e6+xEG6m3Kr45cdEJ803f
 SiHBRuwmCsPqwyPIpeUvs/oXIeWVvtx89SphmmG49bVt8eG9pp6YdNaT9WfVKLSQEAil
 GarnxtUPtR4TRwH5C9CGUt+yf+A7UWYxTUwrl7lJLKFJhNqTDakUYK2vsyhvyqHtsYnk
 5yVVzwEAlt0tNfKaWwSFmHMNWhG2Nuyt/XJbf20XYT2e6Nx1jUmPU68jtnzBLJqDL+mN
 cMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795533363; x=1796138163;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XdsFX2jkxfp3y0aqI/9oYHu5zCiylixu3ZxDWJPGIqQ=;
 b=wpbicggLWS5sRN8L+bldovywpiLLEtN9z28fMnXFbAhfFjFF7Mlg9oIbUE7QzE1cKT
 EXjnrcuDvP6/AWEtiRmXysuPONzQ2PMq9LF4xB7FgAwsLxxruGXTz/xlPMSeXl36qxNY
 jVmFA/wPMiWUkL+wXljHr5cDp7RuxY/uUwtyzO+PVTiGvKqrb3jcTAp2eE6WSZJck2tO
 ZKIHmw4jbLeqv2alrQMSIWFfRpIaCIhz0StCurenkDhUp1UcrHqqK3QHIW1UKmq57iRl
 tkkZ6kp48G35e42cdg8hpw5nVednkZYoSw7PzRnfNIuD6yhxJDGkdHz8Ypzpz4f8JgLx
 6jdg==
X-Gm-Message-State: APuU4Z/84JYbtPYZb9iNU5j3Y9eyvTB0HNiaIjxdPsxquq995ZQaSwgz
 34+LsaAvgNIjU9b/laTBHrHQNsN8ODVc4o55Iu1fU4xLPhJV6/a3CO6k0w1hus0+rOTxJolCpFk
 GGouoKgambEqWUIDObb2EmA3y/moVPqE22qhmHqc=
X-Gm-Gg: AZFdTZcW5cEbzHpuUE78UzDyrsMP+KyxhTchjCFe8yeFgNhJo+y4Gt3T+eSVhNXlAe4
 6XcREbxtq1A9ovQJ+Oo8mgpok5V4fyoLCn9NORKJTn7t5nPB1wFmThql7LKd6fHaCRKTViHEOnz
 Y8clI4QSxEy7QXhA+JeXdi4aPGKjqjHe73zsakzcZEFaapQk4Z92CxvAQBry/lXc7GH28Z/40MV
 gt5Wmg4f6rV3aBShxGX654FLKwdFUbxmjFvnvfSD3qJKJZvQlta9I0Tt5ThCzf+qK0Tt1bCzAcu
 0VspjVUrrtUGbKAGDIKF0MXXHqNlqNUAprhnK5jHpusp6qEFLt3Apdak3Zzl6hlDD3Gio69RXvi
 d3ghu9r/AX849ioxOw/ekAi7GUAb5Fs9CE5+QtpfGGzbxxkP1QHKZUwHRaQ==
X-Received: by 2002:a05:6402:1f13:b0:6bb:1300:89fe with SMTP id
 4fb4d7f45d1cf-6bb13009288mr537110a12.11.1795533362841; Tue, 24 Nov 2026
 07:16:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124074641.24803-1-kirthikaditya@gmail.com>
In-Reply-To: <20261124074641.24803-1-kirthikaditya@gmail.com>
From: KIRTHIK ADITYA <kirthikaditya@gmail.com>
Date: Tue, 24 Nov 2026 20:45:51 +0530
X-Gm-Features: Aa3M54p72FfvMr3A7oVASvbOswnovJdBc2LhOaZJcQAEOCwQQxmqmdWwOpI8BF0
Message-ID: <CAGz9tZ7ctGSiYr0HAxzz0S8A9A5TrHxBxLzOGDXjOUyNZvUciw@mail.gmail.com>
To: openvpn-devel@lists.sourceforge.net
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xVsFd-0000000066E-2af7
Subject: Re: [Openvpn-devel] [PATCH] multi: send RESTART,
 [P]: on restart when auth-gen-token is used
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

please disregard this patch. As discussed in
https://github.com/OpenVPN/openvpn/issues/1099 the different behaviour
is in the OpenVPN 3 client, which purges the auth-token on a bare
RESTART while OpenVPN 2.x keeps it. I'll work on a fix for OpenVPN 3
instead.

Thanks,
Kirthik


On Tue, 24 Nov 2026 at 13:16, Kirthik Aditya <kirthikaditya@gmail.com> wrote:
>
> When a UDP server using --explicit-exit-notify restarts (SIGUSR1/SIGHUP)
> or exits, it sends a bare RESTART to connected clients. OpenVPN 3
> clients treat this as a request to discard their auth-token, so users
> relying on SSO have to authenticate again, even when the server can
> still validate their token using --auth-gen-token-secret.
>
> When --auth-gen-token is enabled, send RESTART,[P]: instead to ask
> clients to keep their auth-token across the restart. OpenVPN 3 only
> recognises this exact prefix. The next-server case ([N]) is left
> unchanged because OpenVPN 3 does not support it.
>
> If the token is no longer valid after the restart, the client receives
> AUTH_FAILED and falls back to normal authentication.
>
> GitHub: closes OpenVPN/openvpn#1099
>
> Signed-off-by: Kirthik Aditya <kirthikaditya@gmail.com>
> ---
> Discussion: https://github.com/OpenVPN/openvpn/issues/1099
> Branch: https://github.com/spryzz3n/openvpn/tree/restart-preserve-auth-token
> Tested with OpenVPN 2.x client on localhost; not yet with OpenVPN Connect.
>
>  Changes.md                          |  8 ++++++++
>  doc/man-sections/client-options.rst |  6 ++++++
>  src/openvpn/multi.c                 | 15 +++++++++++++--
>  3 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/Changes.md b/Changes.md
> index 89a72fe4..54c6385c 100644
> --- a/Changes.md
> +++ b/Changes.md
> @@ -2,6 +2,14 @@
>
>  ## User-visible Changes
>
> +* **`explicit-exit-notify` preserves auth-tokens on server restart**
> +
> +  When a UDP server with `--explicit-exit-notify 1` and `--auth-gen-token`
> +  restarts or exits, it now sends `RESTART,[P]:` instead of a bare `RESTART`.
> +  This lets OpenVPN 3 based clients (e.g. OpenVPN Connect) reconnect with
> +  their auth-token instead of asking the user to authenticate again.
> +  OpenVPN 2.x clients now also keep their cached username/password.
> +
>  * **Parsing Distinguished Names in certificates**
>
>    (OpenSSL backend:) OpenVPN now rejects certificates that have a null-byte
> diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
> index 16309f90..c8596c41 100644
> --- a/doc/man-sections/client-options.rst
> +++ b/doc/man-sections/client-options.rst
> @@ -285,6 +285,12 @@ configuration.
>    reconnect to the same server, with ``n`` = :code:`2` client will advance
>    to the next server.
>
> +  If ``--auth-gen-token`` is also used and ``n`` = :code:`1`, the server
> +  sends :code:`RESTART,[P]:` instead, asking clients to keep their cached
> +  credentials and auth-token. Clients can then reconnect with the token
> +  without user interaction, provided the token is still valid after the
> +  restart (see ``--auth-gen-token-secret``).
> +
>    OpenVPN will not send any exit notifications unless this option is
>    enabled.
>
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 900b5a3b..c6dc932b 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -3926,14 +3926,25 @@ is_exit_restart(int sig)
>  static void
>  multi_push_restart_schedule_exit(struct multi_context *m, bool next_server)
>  {
> +    /* Preserve auth-token on restart for OpenVPN 3 clients.
> +     * Keep the next-server case unchanged for compatibility. */
> +    const char *restart_msg = "RESTART";
> +    if (next_server)
> +    {
> +        restart_msg = "RESTART,[N]";
> +    }
> +    else if (m->top.options.auth_token_generate)
> +    {
> +        restart_msg = "RESTART,[P]:";
> +    }
> +
>      /* tell all clients to restart */
>      for (uint32_t i = 0; i <= m->max_peerid; i++)
>      {
>          struct multi_instance *mi = m->instances[i];
>          if (mi && !mi->halt && proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto))
>          {
> -            send_control_channel_string(&mi->context, next_server ? "RESTART,[N]" : "RESTART",
> -                                        D_PUSH);
> +            send_control_channel_string(&mi->context, restart_msg, D_PUSH);
>              multi_schedule_context_wakeup(m, mi);
>          }
>      }
> --
> 2.43.0
>


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
