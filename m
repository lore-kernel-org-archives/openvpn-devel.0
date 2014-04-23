Date: Wed, 23 Apr 2014 18:38:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140423163811.GK16637@...1296...>
References: <53572C4E.7010701@...1901...> <20140423081058.GJ16637@...1296...>
	<53579C5D.5000902@...1435...> <5357DDFC.2010401@...1901...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6LixLYjhSYvZLG6t"
Content-Disposition: inline
In-Reply-To: <5357DDFC.2010401@...1901...>
Subject: Re: [Openvpn-devel] Progress on Version negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timothe Litt <litt@...1901...>
Cc: openvpn-devel@lists.sourceforge.net

--6LixLYjhSYvZLG6t
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 23, 2014 at 11:36:28AM -0400, Timothe Litt wrote:
> Just to confirm that the issue is 1.2, not the negotiation:
>=20
> I added an unconditional
>       sslopt |=3D SSL_OP_NO_TLSv1_2;
>  in tls_ctx_set_options.
>=20
> With this (and the context initialized to SSL_v23_*_method, so we=20
> negotiate), the tunnel comes up.
> Without it, the tunnel does not come up.
>=20
> So it is the use of 1.2 that is the issue, not how it is selected.

Thinking through this, while cycling home from $paidwork, I remembered
something I saw when debugging something similar ("if I enable TLS1.2,
things explode") last time.
--6LixLYjhSYvZLG6t--
