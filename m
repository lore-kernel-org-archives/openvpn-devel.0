Date: Mon, 15 Aug 2022 12:48:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YvokdcW8oF9ur/mm@...1296...>
References: <20220514103717.235-1-timo@...2669...>
 <202208111003.27BA3jBP091528@...2054...>
 <YvoXzZNWGa49RJ6D@...1296...>
 <41d3a297-83f3-5b13-49f7-dd70b0d8daee@...2669...>
 <YvogFJdhB+8n3qrK@...1296...>
 <e7ad101d-4a46-72b2-7eec-5be5e8d636f4@...2669...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="C/S/adhmZDLc4BPh"
Content-Disposition: inline
In-Reply-To: <e7ad101d-4a46-72b2-7eec-5be5e8d636f4@...2669...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: platform: Retain
 CAP_NET_ADMIN when dropping privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timo Rothenpieler <timo@...2669...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net, berni@...376...

--C/S/adhmZDLc4BPh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 15, 2022 at 12:40:55PM +0200, Timo Rothenpieler wrote:
> Add checks for ifconfig-noexec + route-noexec being set, and either only=
=20
> warn in that case,=20

... this is what I suggested two mails upthread :-)

> or don't even try to retain capabilities, since=20
> they're not needed either way. I'd prefer the later, since fewer=20
> capabilities is generally better.

I could see arguments for "we want to do the ifconfig/route setup in
an --up script" - for example to do VRF/NetNS stuff that OpenVPN can not
do itself.  So for these scenarios having the capability around would
be useful (=3D thus, try-and-warn)...

Different scenario, same options.  We don't always know what users want.

> implementing them. Shouldn't be that hard, given the config is already=20
> there.
> I don't have a NM setup to test that on though.

Sending to the debian bug report referenced upthread and asking them
to test might be an option here.  Or ask David.

I do not use NM either.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--C/S/adhmZDLc4BPh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi+iR1AAoJEB2Cnv7KVigSlgYL/jzlW5vafIwy6dp7IeP+Rb7w
wnbMXJ09pMX2CJ4zojx261UJzCjE091TIkxTS7lNNBRmnZAHeYLCrrM7cMTYsmjf
zL1sC0U9+QP3z/AmgL6U5XeLqhte9w5hW+a8312+Ja05atFKzfHx4JF/lG7diEY0
M1bx1leFHJ6nS6j5MlbxQv7FHid1O38wunlV45HNPzErJLT/QuLGgtHsGcNZkgYa
4/I1sI2vMwzb6IalE9xNlx57vIqgbHFposu4+4y238jlb8hJlRR7+Ocab5+v1I1B
FnO9tiipF3dTwjvGkwPMUOZ8aWqA3qlGnjM5YX8MN3nnpGENBSZ3/tXVUAydnbXl
AZ+watCQSzUWPjKjRaX7BSSYgd3nVmDDoEuc9oUKlIrMnucz2OeBpDhuguSs5iWI
he7qHTCS/6B9tOK7rOqxJstwEgGiVjfzie9gv04iSnRdwAecMOcda+mkz2dP+kNM
sSL4pgHXWp19NVz0eQQ4YtiJHymQcdFTQJEjJeaZDA==
=XBnW
-----END PGP SIGNATURE-----

--C/S/adhmZDLc4BPh--

