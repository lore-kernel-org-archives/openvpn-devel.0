Message-ID: <4F55E3AA.3020409@...515...>
Date: Tue, 06 Mar 2012 12:15:06 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-7-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-7-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 06/52] cleanup: remove redundant ';'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>


> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  misc.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/misc.h b/misc.h
> index bdada42..dd6bd5a 100644
> --- a/misc.h
> +++ b/misc.h
> @@ -145,7 +145,7 @@ openvpn_run_script (const struct argv *a, const struc=
t env_set *es, const unsign
>=20=20
>    openvpn_snprintf(msg, sizeof(msg), "WARNING: Failed running command (%=
s)", hook);
>    return openvpn_execve_check(a, es, flags | S_SCRIPT, msg);
> -};
> +}
>=20=20
>  #ifdef WIN32
>  FILE * openvpn_fopen (const char *path, const char *mode);

Seems like an anomaly. ACK.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


