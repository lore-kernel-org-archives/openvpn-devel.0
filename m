Date: Wed, 28 Dec 2016 20:37:48 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161228203748.3ef54708@...1799...>
In-Reply-To: <20161228185700.GJ78624@...1296...>
References: <20161228130721.683-1-list@...1798...>
	<20161228185700.GJ78624@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/ddY0z2c4DdtMLpSpzRojDtn";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH 1/1] fix timeout in non-TLS mode with
 systemd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Christian, OpenVPN Development <openvpn-devel@lists.sourceforge.net>, Hesse <mail@...1798...>

--Sig_/ddY0z2c4DdtMLpSpzRojDtn
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Gert Doering <gert@...1296...> on Wed, 2016/12/28 19:57:
> Hi,
>=20
> On Wed, Dec 28, 2016 at 02:07:21PM +0100, Christian Hesse wrote:
> > @@ -73,6 +77,21 @@ tunnel_point_to_point(struct context *c)
> >          return;
> >      }
> >=20=20
> > +#ifdef ENABLE_SYSTEMD
> > +    /* In non-TLS configuration we wait for the remote peer to connect
> > +     * before issuing "Initialization Sequence Completed". So prevent =
to
> > +     * time out by telling systemd service manager we are ready for no=
w.
> > +     * Status will be "Non-TLS mode, ready for now. Waiting for peer..=
."
> > +     * and changes once the remote peer connects. */
> > +    if (c->options.tls_client =3D=3D false
> > +        && c->options.tls_server =3D=3D false)
> > +    {
> > +        sd_notifyf(0, "READY=3D1\n"
> > +                   "STATUS=3DNon-TLS mode, ready for now. Waiting for
> > peer...\n"
> > +                   "MAINPID=3D%lu", (unsigned long) getpid());
> > +    }
> > +#endif=20=20
>=20
> We definitely need a better approach than "litter ENABLE_SYSTEMD all
> over the code".

Well, openvpn supports a number of modes of operation... Some of these have
other requirements than others.

In general we have three options:

1. Use Type=3Dforking in unit files. We decided not to go this way.

2. Use Type=3Dnotify and tell systemd we are ready about when we would have
   forked. This works as well as Type=3Dforking does, but has some unhandled
   corner cases.

3. Use Type=3Dnotify and "litter ENABLE_SYSTEMD all over the code". This
   provides the best error handling.

(There is Type=3Dsimple, but that is just fire-and-forget - could not be wo=
rse.)

IMHO we should go with option three. Given the number of #ifdefs all over t=
he
code - is this really an issue? My patch increases the number of sd_notify()
calls from four to five.

For informational purpose we could add even more calls. That would allow to
set intermediate status message, something like: "Up and running, currently
serving 25 client connections."

> (Also, this is the wrong check anyway.  p2p mode can go along with
> TLS just fine - what you need to check for is --server or --client,
> which is something else than --tls-server / --tls-client)

No, the check is correct.

In server move openvpn reports ready when it finally is ready to handle
incoming connections. That is fine.

In TLS client mode openvpn reports ready when it connected to a server
successfully. It fails if it can not connect. That is the desired behavior.
So that is fine as well.

The patch handles non-TLS P2P mode: Two nodes have a shared secret (or
connect unencrypted in pure tunnel mode) and connect to each other.
The culprit: There is no node that is ready all the time. As we do not want
to bail out before the other is connects we have to report ready after
initialization but before the remote connects. This really is about non-TLS,
not client/server. No?
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/ddY0z2c4DdtMLpSpzRojDtn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlhkFIwACgkQiUUh18yA
9HY2wwgAopiq5tJ6yRnENnVGiowool5F6ap4WzB0cHiNP9UlXISgMt/mo7uk5hHS
XFcc8EvTuarlhkr7D68GDx2985NwXhV3Y7+lRMXFSSp80ZuWFaqet9vXrrYMce43
tg6vqi4Q5rDhqkfalHNxbY7WYRbuZR8MfmP3Gc4PKgnBWBR4MIclO2w0slgKkY39
R7EM1YC70yqoV3UkldWRiwwaEd7btTG7WHGiZowAMTGG9f1UDp4/V6WhFIH1B7Zd
pD2Id3WakAF5T5goaJBAaGGnqHF8T7pN45msqp1YZu7+B/kS8yckXX/eg0/xSzOU
o9i4W+GuaksKXULlj+4tXWGGrtTpHA==
=oCOB
-----END PGP SIGNATURE-----

--Sig_/ddY0z2c4DdtMLpSpzRojDtn--

