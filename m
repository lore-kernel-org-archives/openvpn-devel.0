References: <efe4c17a-1d4d-d20f-cc77-cf7564ea1184@...2080...>
	<1472133483.61594.587.camel@...1866...>
	<8e9eb1dd-2505-7414-4828-6d6b6d1e25f0@...2080...>
	<CAKuzo_j0XwQ7OR8E-wGcTQDwEjdRbTZZy84wK68qgZLS30sT7g@...278...>
	<edab23db-978e-ec86-c9c2-5768b468cbdd@...2080...>
	<CAKuzo_iF5TsPDgVrjTfKfRWJp=1T=ZuejazTwK0OQpBWTbuwnw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ab877ea0-9ad8-3afc-f62f-ab8c26cc4868@...2080...>
Date: Thu, 25 Aug 2016 19:38:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iF5TsPDgVrjTfKfRWJp=1T=ZuejazTwK0OQpBWTbuwnw@...278...>
Subject: Re: [Openvpn-devel] [RFC] - Enable 2FA to be used with
	renegotiations
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 25/08/16 18:53, Selva Nair wrote:
> As for caching, either the token will have to be cached unless 
> management is in use in which case the UI/GUI can remember the
> token and supply it during reneg.

Right, but I think we both agree that caching a temporary token which
is valid for only a single session is far better than actually caching
the users password ;-)

- -- 
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXvy0UAAoJEIbPlEyWcf3y6fYQAKoKGrGv2v+VgBGNM5BRLGEw
8jIJ1waE0qyFlLXKb6WX6mXzw/oZQVmVx5ldBp7dnTrfoGTP9FTAUDAkMoMdFU6M
g/9DjW9iL1f8azgUNY1frHOSaoXtfFCTKJQ0HFzcYFXlzv4QY8fYVnacuzkbbBZu
8y9XcDR6jvCFz5hAozeGjbv+Yqf2uY5C8VCRASqyfhVjZGrKz309dldAjNuoMRJz
VM32ImicvZOSuRr3ln9jGbqHKHovq8FuU6DrhnYCg52VYAiOYyWvJgjeiC5aI0WG
cgIrIeZUW89KkOndDJquRLcSE1ZoNVhw7QcHLm/XakGn1+n2BVrRsOt+1REo62Bh
hFtXVX6iWCYNKZldf8Lf5/KnYeECpFehH65B1gGfjAIVDXrrme399u4Ue+CIKpkh
CfO+vhTjFdTIuvMQruyk6vpgHh+6E4MAJATSrerzI2dxiztLlteczj+VHWjLn9tF
ViNRQ8PYBKhR8qoVoERQtLm6K3OxcwQz4VO8b9n+o5BWIIfGVq+OR7n2F6OJjyrz
BW1dppOkpTcyIyHo6K4B8gMsQ6xl9jj8dsz/+44jOehztl+OthljQIPYsPdA5kOQ
7ep2unfjh38o5o6V078++3w2s4P+8a3ju6aEjaMJSx1l0wpyXpdPt0DLjN6mNyy3
hb9XeQ07cfnyNHGi2ksi
=kOcn
-----END PGP SIGNATURE-----

