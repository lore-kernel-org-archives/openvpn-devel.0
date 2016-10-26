References: <20161026120631.15946-1-a@...2181...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <30247351-24a3-4314-40c5-bfb5e82f84b0@...1435...>
Date: Wed, 26 Oct 2016 14:29:19 +0200
MIME-Version: 1.0
In-Reply-To: <20161026120631.15946-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] don't mix settings when crl-verify
 option appears more than once
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

On 26-10-16 14:06, Antonio Quartulli wrote:
> clr-verify can be specified multiple times in the config file and the
> expected behaviour is that the last occurrence should be used.
>=20
> Therefore, reset the optional flags everytime a new crl-verify
> option is found.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/options.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 281ef0b..5192198 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -6966,6 +6966,14 @@ add_option (struct options *options,
>  		  || (p[2] && streq (p[1], INLINE_FILE_TAG) ) || !p[2]) && !p[3])
>      {
>        VERIFY_PERMISSION (OPT_P_GENERAL);
> +      /*
> +       * If crl-verify appears more than once in the config file, we hav=
e to
> +       * to keep settings belonging to the last occurrence only.
> +       * Reset optional settings each time.
> +       */
> +      options->ssl_flags &=3D ~SSLF_CRL_VERIFY_DIR;
> +      options->crl_file_inline =3D NULL;
> +
>        if (p[2] && streq(p[2], "dir"))
>  	options->ssl_flags |=3D SSLF_CRL_VERIFY_DIR;
>        options->crl_file =3D p[1];

Feature-ACK.  I think this is a great idea.  This allows us to do an
if(inline_file), instead of doing a strcmp against the 'magic inline
string' everywhere.

However, I think it would be better to keep all inline file handling
consistent.  So I would prefer a patch that does this for all inline
options, and replaces the strcmp()s at various places with if(inline).

(Thinking about refactoring this, wouldn't it be even prettier to change
crl_file_inline to a bool, indicating whether crl_file contains a file
path or the file contents?  Might be a matter of style though, so feel
free to ignore if you disagree.)

-Steffan

