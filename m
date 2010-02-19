Date: Fri, 19 Feb 2010 17:06:12 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <1266620250-10045-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1266620250-10045-1-git-send-email-openvpn.list@...1114...>
	(from openvpn.list@...1114... on Fri Feb 19 16:57:30 2010)
Message-Id: <1266620772.31441.17@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] Do not randomize resolving of IP
 addresses in getaddr()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On 02/19/2010 04:57:30 PM, David Sommerseth wrote:

Am I wrong or does using --disable-depr-random-resolv
not remove the random choice?


> From: David Sommerseth <dazo@...384...>

> For now this feature is enabled by default, but can be disabled by
> running
> ./configure with --disable-depr-random-resolv.  In the future this
> will be
> changed to being disabled by default before getting removed.


> diff --git a/socket.c b/socket.c
> index fecc398..c963a21 100644
> --- a/socket.c
> +++ b/socket.c
> @@ -205,6 +205,10 @@ getaddr (unsigned int flags,
>  	{
>  	  if (h->h_addr_list[1]) /* more than one address returned */
>  	    {
> +#ifdef DEPRECATED_RANDOM_RESOLV
> +#warning
> +#warning **** DEPRECATED FEATURE ****   DEPRECATED_RANDOM_RESOLV is
> enabled
> +#warning
>  	      int n =3D 0;
>=20=20
>  	      /* count address list */
> @@ -212,12 +216,16 @@ getaddr (unsigned int flags,
>  		++n;
>  	      ASSERT (n >=3D 2);
>=20=20
> -	      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to
> %d addresses, choosing one by random",
> -		   hostname,
> -		   n);
> +	      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to
> %d addresses, choosing one by random."
> +                   " [DEPRECATED FEATURE]", hostname, n);
>=20=20
>  	      /* choose address randomly, for basic load-balancing
> capability */
>  	      ia.s_addr =3D *(in_addr_t *) (h->h_addr_list[get_random
> () % n]);
> +
> +#else /* preferred solution */
> +	      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to
> more than one IP address, will "
> +                   "use the first resolved address", hostname);
> +#endif /* ENABLE_RANDOM_RESOLV */
>  	    }
>  	}
>=20=20
> --=20
> 1.6.6
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
>=20




Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


