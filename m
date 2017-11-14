Date: Tue, 14 Nov 2017 09:31:34 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171114083134.GV958@...1296...>
References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
 <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
 <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
 <4717a1f2-b8c6-26ae-2cf4-42ae5f34c3eb@...1435...>
 <6ad9db3e-63b5-78fe-0105-81c92746feb2@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="f/EACO4z5I3O9Pl6"
Content-Disposition: inline
In-Reply-To: <6ad9db3e-63b5-78fe-0105-81c92746feb2@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--f/EACO4z5I3O9Pl6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 13, 2017 at 01:16:46PM +0100, David Sommerseth wrote:
> But we should consider if we want to make use of a JSON library
> producing the JSON streams.  The reason is to ensure the output is
> according to the specification and that escaping if contents is
> consistent and proper.  Imagine if someone puts a double-quote into the
> CN field of a certificate?
>=20
>  CN=3D"} Lets explode things, O=3DHacktivist0
>=20
> Or other characters which needs escaping.

I'm not convinced we want to import a new library dependency and a heap
of #ifdef for this.

Escaping on *output* is pretty trivial ("characters from <this set>=20
need to be encoded <like this>") - and as long as we do not need to parse=20
*incoming* JSON, a full-blown new library is mainly adding complications
(like, configure flags, #ifdefs, library version dependencies, ...).

But you knew that this response would be coming :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--f/EACO4z5I3O9Pl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaCqnlAAoJEB2Cnv7KVigSUfAL/jcebl758D5kialLZ0o5k/LI
Hlr2lggBINmRO4XXJOLGqp22gr1bhYtDn+az6NLMnHZ7RSUKq+rtkTLRZV9JGXV7
QPvEOf6j3vlIMsfdVs9+NR01XjisvlRwJU5kVhPIjro2FP33XwR3hR+1kzxIAe5a
vmkZesv6dOSM1pfs7nSOd94ccN7cx54tWlfDr0MfiefPWYLm+t4kIJCrF1ZFQA/Q
X2AxPMggjSRHIWxYXrSq5vnAGwGhpoJHibNA12HAzBK0UvvBw7vZeTXaDGdZa8ih
FRwiDWR9a1dNATwZZPov0L9gGeN1Ls23fx+CWTA33Q0Z20yIPcknlBGeG2MQffdK
T42BxOZMCOg2baUPoxtBEaijFbu5qvh8OIsPA1XTw+FVWO3VMKJsUVn8PTowLoTU
89Fy+w98HnsAjm0BJqNQ/m1LAY1CkARCztkYG5jYiDEKcc4nnc2AxqGN7xuqvbRW
eK6Msq89Dx6TfTG6etjC5VMU0qhKlk5eAuL6XNtJMg==
=059+
-----END PGP SIGNATURE-----

--f/EACO4z5I3O9Pl6--

