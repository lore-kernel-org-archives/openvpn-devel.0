Date: Wed, 15 Mar 2017 19:41:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170315184148.GS93896@...1296...>
References: <CAFHpkQGseLH-+NFRxgrF7KNdZ8Fc4A4HQGBOTEktwABW9ZALTw@...278...>
	<20170315152840.GR93896@...1296...>
	<CAFHpkQGKV3pAeTjabYbyP4LwwDqUa7Atuuqh0qyQ95DTdL39dA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uK5R2a4OYMA55GL9"
Content-Disposition: inline
In-Reply-To: <CAFHpkQGKV3pAeTjabYbyP4LwwDqUa7Atuuqh0qyQ95DTdL39dA@...278...>
Subject: Re: [Openvpn-devel] why "ifconfig" is required during build ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--uK5R2a4OYMA55GL9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 15, 2017 at 08:37:12PM +0500, ???????? ?????????????? wrote:
> well, what if I will not change current (i.e. default behaviour), but
> instead I will add a possibility to specify ifconfig explicitly ?

What for?

(If the build fails if ifconfig cannot be found, one could print a warning
instead, and defaul to "/sbin/ifconfig" - which catches most platforms
nicely)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--uK5R2a4OYMA55GL9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYyYrsAAoJEB2Cnv7KVigSrIEL/1DoH7MtCvmC174tRUQxnau4
1qOzFcMbshines4k42JIYFWUtjOW7w2+ZfqTfRqom0k0haEO+ajAgi+M7D0HTbzL
BfTaTe+/kYQQKOQmOx/vI82rlhuLEMri/ermV5mQHX93LlXvkE5fR+fqV5U9R8lA
YP+uF2x9BemPEwq4mqiKX1LcE3NvanDTI/yQqZrKQeNUgClPjo4BmQX+0rhDTIXb
mioQpia7vAnm4uQnEuaUvo+eW2JjkXHmWz7Yt1Jk4iR9oTukwScFt39SMNCqVMBy
uPnwbp9FW1+RPG98k+1Dk/LedYodDdBdEZ5CXBwtAo0Q0O1ss3hofxCd/yhNje99
2c4F5wZchTXhp/ZAOTwrLvV4Ch4Prq/DbDh3MFwKfZEhe/2zvze8Jtky0mWsNRqS
WZzjbDe5alYzrlmznHdILSo16bciRAOYcHy8f/mOUa2r3Lyj3WzPjtqEXxBEiT4I
bcKcEYOAfMImvLfZQFjFuyDxMWkaFsVfv2tGW2AP9Q==
=ova7
-----END PGP SIGNATURE-----

--uK5R2a4OYMA55GL9--

