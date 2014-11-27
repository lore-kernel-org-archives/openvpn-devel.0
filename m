Date: Thu, 27 Nov 2014 15:22:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20141127142228.GA17158@...1296...>
References: <1416755831-21250-1-git-send-email-lstipakov@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jB+02Y6wHc2pEa2x"
Content-Disposition: inline
In-Reply-To: <1416755831-21250-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Peer-id patch v7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--jB+02Y6wHc2pEa2x
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 23, 2014 at 05:17:11PM +0200, Lev Stipakov wrote:
> Changes in v7:
> A few nitpicks.

Went in, and has just been pushed.  Time for your dance now :-)

Question to you:

> @@ -75,6 +101,16 @@ multi_get_create_instance_udp (struct multi_context *=
m)
>  		    {
>  		      hash_add_fast (hash, bucket, &mi->real, hv, mi);
>  		      mi->did_real_hash =3D true;
> +
> +		      for (i =3D 0; i < m->max_clients; ++i)
> +			{
> +			  if (!m->instances[i])
> +			    {
> +			      mi->context.c2.tls_multi->peer_id =3D i;
> +			      m->instances[i] =3D mi;
> +			      break;
> +			    }
> +			}

Is this code "safe"?  That is, if max_clients is set too low, and you have
more than this number of clients trying to connect, what will happen?

Will the server check this case before this loop, or will it just "not
find a free instance" and leave peer_id as "0"?

Maybe we should add an ASSERT() here, to be sure that whatever other pieces
of the code do, this will always end up in a defined state  (as a separate
patch).



Second, question to the group.  Right now, this code is active unconditiona=
lly
on the server side - what if someone does not want this behaviour, for
whatever reason?  Shall we make it depend on --float (which right now=20
doesn't do anything for a --server OpenVPN server)?

This should be a fairly small change, I think, just never send the client
a "peer-id <n>" push-reply (so it won't use T_PACKET_V2), and check=20
"if (options.float)" before checking whether it's a floated client...=20=20
so the question is more along the line "is this a useful thing to do,=20
nor not?".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jB+02Y6wHc2pEa2x
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVHczo6kuBuNlUUl1AQLr7gP/Y0RPsMAqGj2V2f7IoCSEknoTm+fArhRE
5eGomvsL0RnWyecm/9krf2p1mFSHQ3K8xRV3AWoxuXoPo5KgRy32ZrgSCXgr6e2b
eRiLBRKkOkIhfUuuuUMvIU7cic7PFZLeCWU07MENNa0Bh0bBcvAXQuVkRxMmZ8RC
xKYxY7MFpQE=
=IJMh
-----END PGP SIGNATURE-----

--jB+02Y6wHc2pEa2x--

