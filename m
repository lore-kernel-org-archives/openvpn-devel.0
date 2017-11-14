Date: Tue, 14 Nov 2017 12:02:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171114110244.GW958@...1296...>
References: <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
 <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
 <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
 <4717a1f2-b8c6-26ae-2cf4-42ae5f34c3eb@...1435...>
 <6ad9db3e-63b5-78fe-0105-81c92746feb2@...2080...>
 <20171114083134.GV958@...1296...>
 <10ef4327-7cc1-9bd7-7307-af8b90c66962@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SJBlQl/PP8ECuS+e"
Content-Disposition: inline
In-Reply-To: <10ef4327-7cc1-9bd7-7307-af8b90c66962@...2080...>
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

--SJBlQl/PP8ECuS+e
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 14, 2017 at 11:56:10AM +0100, David Sommerseth wrote:
> And to me this feels like it actually contradicts our netlink discussion
> on the Hackathon, where you initially wanted to use an external library
> ... ;-)

It's a matter of complexity.   Netlink is binary, complex, and hard to
verify (unless you write your own decoder, which might have bugs on its
own).

JSON is very trivial to produce (unlike XML, or netlink).  The escaping
rules on producing are also very easy - basically, encode things in double
quotes, and escape the set of { BS, FF, NL, CR, Tab, Backslash, Quote }
with a single backslash before the corresponding character.

https://stackoverflow.com/questions/19176024/how-to-escape-special-characte=
rs-in-building-a-json-string


For *parsing*, I'd agree with you...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--SJBlQl/PP8ECuS+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaCs1UAAoJEB2Cnv7KVigSQT8L/iISB88arDd4DkeZN+2W0bHs
TD5hwtnkv3GiT85LAuWyFN5J7LFpcO94W2Hs4MF/2va+ys+ipdCweAJzonm1dTnu
SSoHuLCjkp+o7wjZyDRIf+wxQIoz/dCSsvjSUO0d91X7nMZhRyB3Mbc9zIjE7ZMQ
vRwqy59BXbJX5SVmscrJnPYh/fWdukEJ6Ir8EeDzI5Orsf4nasaqlohgMwxVpHCK
I25kC7yACx5w0CT+jvunz7OKOaxx6pcjyT3y10F+AJ6MjPqGyPXYq5MJd6LDevhF
cd01IwSgy2rcjzxfpOiDCNjHbhi8qm9IhcrBQZRhPBfvJ5nqIHC8l7xhYPfc1U+T
yMW+WaSswkNYH3HADHRv1s0CJgDImSb59TBohe8ZXDbwZlORzADSdosRaoQWsGZI
bV/lh89QMIFnfybu1xAPzS0s5oi+jp6uFaQhz6AhjmyhXtvlhH2eUgna9JrfSPmL
F0qu3itArGghULbCWIPE4I8/TWF9RBUwixcu1/I00w==
=/0Rp
-----END PGP SIGNATURE-----

--SJBlQl/PP8ECuS+e--

