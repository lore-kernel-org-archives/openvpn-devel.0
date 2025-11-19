Date: Wed, 19 Nov 2025 16:12:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <aR3ecLldIl2ObLpS@...1296...>
References: <CAOh3LPOnR5qbF-8xRuJFfZhWW25wNXBK3cUwC710cK4kRcSVpA.ref@...278...>
 <CAOh3LPOnR5qbF-8xRuJFfZhWW25wNXBK3cUwC710cK4kRcSVpA@...278...>
 <aR3XmaUlPlK-pDqB@...1296...>
 <CAOh3LPMP0U+AmA0OneDXBre2Q4Ow4v4pyunx41jxWMxxojioBA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mTecpET4t1JSmGmH"
Content-Disposition: inline
In-Reply-To: <CAOh3LPMP0U+AmA0OneDXBre2Q4Ow4v4pyunx41jxWMxxojioBA@...278...>
Subject: Re: [Openvpn-devel] Old/New IP - Logic Redo
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jon Chiappetta <root@...2904...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--mTecpET4t1JSmGmH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 19, 2025 at 09:54:30AM -0500, Jon Chiappetta wrote:
> Yes, that is correct, it does impact the multi-threaded operation, howeve=
r,
> the older logic has a strcmp between the old IP and the new IP before
> performing the learn and unlearn logic in the update_vhash function which
> is what SHOULD happen, this is important and correct. Why would you want =
to
> waste cycles and operations doing that when the IPs haven't even changed =
or
> differed in value? It doesn't make any logical sense either way even in
> single threaded operation...

The operational model underlying here is "you send an update when you
want to change something", so spending brain & code on "verify that there
is an actual change, and skip the update if not" is not effort well spent
(also, the client does a full tun restart, which takes much longer than
the server side - this is what would need optimizing first ;-) ).

The code, as it is now, is nice and compact, easy to read, and does what
is supposed to do.

We can come back to this in the "after 2.7.0 release" timeframe when
we open the tree for "refactor and improve code style and details" changes
again - right now, we need to focus on actual bugfixes.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--mTecpET4t1JSmGmH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJpHd5wAAoJEB2Cnv7KVigSz4ML/3iVbT2cxFgk27fbA3Gv1CGb
uMeHO07wcPW4bgEwrEvlHg0hrOtAecWSBl6CWoY88idrdDKZc9lbrOJ65Xs7F/H+
6SEfEPNM27EynC5tvfWguBkLf6SWVvChM+22i9SmrmFCQ4Q65DvADiQcA+P4i5PN
29X8AVu6nx1jz28YGluzKzfE1KbouaR//USnQmXvyD3u49e8mJMG61GWiMxPhSiN
PqIz8SjFdk1EZUnTSkqzAxU3Q+fjk6lp/sE3pgZgqUxUVB3nOgnFwS1fMpPDkapN
Xl0NUnBfCsHYocuvD7t0eH4X8+kpn22dQu4TWe+IWEgFKX5jncxmIGAhDpcOuuuR
l4Lkz8Ip96dsSkpf3gPxYiVq7nNdOd2ZcpN//GBEUfLe7eImDc6lblEIHcbRu95I
ZuOiGYAcZxk/n3s1kLshkzn1ID0CEs8SXjXxVXJix5yPzMj0pweTDHj1nE6L3FNe
coIzKbzj9Fl17epNlszJTld/ljfWJ0C36ws2KRHAYA==
=ahN0
-----END PGP SIGNATURE-----

--mTecpET4t1JSmGmH--

