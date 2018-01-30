Date: Tue, 30 Jan 2018 21:58:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180130205821.GS69387@...1296...>
References: <6a3cabee-e9ea-bea6-cca7-d3f9672f292f@...515...>
 <CAKuzo_jTyA42EJtwcr5xsRRVbMy5WzPibbZHSPEa9piBJ14ozg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3l764Q7zY5HuAgsB"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jTyA42EJtwcr5xsRRVbMy5WzPibbZHSPEa9piBJ14ozg@...278...>
Subject: Re: [Openvpn-devel] Topics for the community meeting (Wed,
 31st Jan 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3l764Q7zY5HuAgsB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 30, 2018 at 12:21:58PM -0500, Selva Nair wrote:
> A quick comment regarding item 2 in topics:
> > 2 mgmt version 2 / pk-sign and 2.4
> >  Is this something we want in 2.4? If not, how's the GUI going to deal =
with 2.4 and master being different?"
>=20
> Unless 2.4 is getting EC cert external signing support, we do not need
> this in there, do we?
>
> I think it shouldn't be a problem for UI's as the master will behave
> the same way as 2.4 towards old UI's. New/updated UI's are expected to
> first check the management version of the daemon, then optionally
> announce version 2 support, and be prepared to handle old and
> new-style requests.

This is the part I was missing - that the GUI knows what version the
openvpn.exe process can handle.  So a "master GUI" would send "version 2",
while a "2.4 GUI" would see "openvpn.exe can only do 1" and send "version".

Good - that basically concludes the topic for tomorrow :-) (unless someone
convinces me that we want EC cert external signing in 2.4)

> Anyway, "The Windows GUI" doesn't care as it does not handle signature
> requests. Jonathan said the same about Tunneblick.

Oh?  I missed that part.  So who is using --management-external-key, then,
if neither of the "two main GUIs" are doing it?

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--3l764Q7zY5HuAgsB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJacNxsAAoJEB2Cnv7KVigSnQ0L/ji2to+p44mm4NiUns35BJDR
L3i+c5dQGbxqPGlIsAaCWnzjojmXXb9kOaHvjag5Vv0Dm/TH8IpBw8lU8UTEbmTW
+8GcmRxE6M0Yzx+o0yx/CkvipoZhfzia7Sux95chsWcYDzTs0ky6iU1AVEQUWUnM
AnftAu3GEjGqOmJPPQ03FIgMRkkxthPGnNeidcj3O+w+4ti9uL3VYvZVtFYhIbsp
LZMtrX3BcPqL8Kkm1aWGwyy1IfNQLJKtP0hwdTxoBGJhcGJdY9kdtIcY7cemwX1E
+/i9OO5RYW+A4j8puh5coFxkgDlcJJNB3R6WOXgf0ziqlFebGi7OPfctGrlLZ/KF
33st6V/6Va6TolAamMRX9J3IdKZvC9VwtFB0cQp3fp5DIDypoR0KhzO0aDnhHQoH
xyE063xfoRPGyM6XMHOBTAO9DHQ8GFSERGJyQuuMHsRcDj9VtuMePx4nfWiCpqty
YZiiO/TZEE9vbFOmWTXYPghcRQgCdMXiUzmfFiEeZQ==
=aOc3
-----END PGP SIGNATURE-----

--3l764Q7zY5HuAgsB--

