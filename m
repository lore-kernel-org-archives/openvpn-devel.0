MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <1333820440-9573-1-git-send-email-alon.barlev@...277...>
References: <1333820440-9573-1-git-send-email-alon.barlev@...277...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Thu, 26 Apr 2012 14:39:44 +0200
Message-ID: <CAP+U6tLODQB+38V-6cy+p9XUMX4MXkpTWUgj=yhyJ+XK5W4HHA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup: plugin: support C++ plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Alon,

2012/4/7 Alon Bar-Lev <alon.barlev@...277...>:
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
> =C2=A0include/openvpn-plugin.h | =C2=A0 =C2=A08 ++++++++
> =C2=A01 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/include/openvpn-plugin.h b/include/openvpn-plugin.h
> index f82f61f..1c80eec 100644
> --- a/include/openvpn-plugin.h
> +++ b/include/openvpn-plugin.h
> @@ -43,6 +43,10 @@ typedef X509 openvpn_x509_cert_t;
> =C2=A0#endif
> =C2=A0#endif
>
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> =C2=A0/*
> =C2=A0* Plug-in types. =C2=A0These types correspond to the set of script =
callbacks
> =C2=A0* supported by OpenVPN.
> @@ -724,4 +728,8 @@ OPENVPN_PLUGIN_DEF openvpn_plugin_handle_t OPENVPN_PL=
UGIN_FUNC(openvpn_plugin_op
> =C2=A0OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_func_v1)
> =C2=A0 =C2=A0 =C2=A0(openvpn_plugin_handle_t handle, const int type, cons=
t char *argv[], const char *envp[]);
>
> +#ifdef __cplusplus
> +}
> +#endif
> +
> =C2=A0#endif /* OPENVPN_PLUGIN_H_ */

ACK. (Although I haven't tried compiling a C++ plugin, the change looks fin=
e.)

Cheers
Fabian

