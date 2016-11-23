References: <1479936104-4045-1-git-send-email-steffan@...1856...>
	<201611232216.uANMGwWk061543@...2054...>
	<20161123223257.GC28918@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <01253b2e-82aa-54e1-71e5-0bcd97b0c833@...1856...>
Date: Wed, 23 Nov 2016 23:58:49 +0100
MIME-Version: 1.0
In-Reply-To: <20161123223257.GC28918@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1OFMWi1p8kTNoaVXfRUUdHpLL3RNseRT3"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Poor man's NCP for non-NCP
 peers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1OFMWi1p8kTNoaVXfRUUdHpLL3RNseRT3
Content-Type: multipart/mixed; boundary="c55RtAJcqBjkV1hd6aVamifW17ddgkcDI";
	protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <01253b2e-82aa-54e1-71e5-0bcd97b0c833@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Poor man's NCP for non-NCP
	peers
References: <1479936104-4045-1-git-send-email-steffan@...1856...>
	<201611232216.uANMGwWk061543@...2054...>
	<20161123223257.GC28918@...1296...>
In-Reply-To: <20161123223257.GC28918@...1296...>

--c55RtAJcqBjkV1hd6aVamifW17ddgkcDI
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 23-11-16 23:32, Gert Doering wrote:
> On Wed, Nov 23, 2016 at 11:16:58PM +0100, Gert Doering wrote:
>> ACK.  We made it :-)
>=20
> I *did* find a way to break it, I think - haven't tested, need to sleep -
> just copying what I wrote to IRC just now since everyone is asleep=20
> already...
>=20
> 23:30 <@cron2> syzzer: I *do* have a potential way to use this to break t=
hings
> 23:30 <@cron2> server with NCP enabled, --cipher foo
> 23:30 <@cron2> client with NCP disabled, --cipher bar
> 23:30 <@cron2> server will now use "cipher bar", while client will do "ci=
pher=20
>                foo"...
> 23:31 <@cron2> so I think we should do a "v6a amendment" which disables t=
his on=20
>                the client if --ncp-disable is set (so 2.4 to 2.4 will eit=
her do=20
>                *real* NCP, or *no* NCP, but no half-assed two-way poorman)
> 23:31 <@cron2> this makes testing more annoying because you can't talk to=
 a 2.4=20
>                server to test the client side :-) - but it's *meant* to b=
e a=20
>                2.3<->2.4 migration feature

This will end up with the server and client using cipher bar (if the
server has --ncp-ciphers <somehting>:bar).  The client-side poor-man's
NCP is already guarded by "if (c->options.ncp_enabled)" (in
do_deferred_options()).

-Steffan


--c55RtAJcqBjkV1hd6aVamifW17ddgkcDI--

--1OFMWi1p8kTNoaVXfRUUdHpLL3RNseRT3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYNh89AAoJEJgCyj0AftKIDIAH/inx7PJPoq1OV4Vf2eord2HH
riwo/swl29hJCbo5jCan6YjFtMsVr07I8BxnILI903SOA3hoi09ITE2h6nHA3if+
wQqotKufXMpq1ttINsq8i0Fomi03yDSTNpQtLP3yTbNeAg8rTeiXaaifTkCFuCgx
VfJvX9HYiXQQZ0cr55vz9psrQVynmbW4zJKIvGvEzMYV7tD5phHYHHXQsRrTbGon
+0XHYDap1fiyYZGaIiRsGxmJmtcxsJXw63jfNNUVR5ztexGcDhzjmc6GC8bGAUIM
dAGgg6FweN4NZTSrblArsdU0yU5eURnvhT/hCnROvTl+psOCJZTRGLIgPcTmwok=
=83Aj
-----END PGP SIGNATURE-----

--1OFMWi1p8kTNoaVXfRUUdHpLL3RNseRT3--

