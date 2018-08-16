Date: Thu, 16 Aug 2018 13:37:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180816113743.GV74536@...1296...>
References: <20180815061240.5027-1-a@...2181...>
 <28816122-839b-fc8d-4953-1b4b7e2883f3@...68...>
 <ca006e8a-2bdb-7fd6-70a0-9e15bb2cf330@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XLsjFikA86nwwlhe"
Content-Disposition: inline
In-Reply-To: <ca006e8a-2bdb-7fd6-70a0-9e15bb2cf330@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] ssl_verify: define label only when
 required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

--XLsjFikA86nwwlhe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 16, 2018 at 07:17:09PM +0800, Antonio Quartulli wrote:
> I totally agree with you that more ifdefs are just ugly and make the
> code worse. However this "new" ifdef is just part of some logic that is
> already there (a few lines above).

It is a new #ifdef, two more lines of code, breaking the flow of
reading.  So I tend to agree with Mathias that this might not be the
best approach here.

> This said, in the past months we have tried moving towards a
> 0-warnings-tolerance, so that we could catch as many bugs as possible
> hidden by "just annoying warnings".
> For this reason using "-Wno-unused-label" is not an option (especially
> in CI/automated build tests where this was spotted).

I see "unused label" as a minor nuisance (unlike other warnings there
is nothing like "it could be an integer overflow" or "watch out for
the signs of your variables" here), so -Wno-unused-label would work
for me...

Warnings are generally good, but adding extra lines just to silence
the compiler in a specific combination of flags for a warning that is
otherwise harmless is not always a good way forward.

> Imho we should just get this patch through and then try to get rid of
> the whole #ifdef PLUGIN_DEF_AUTH logic at once.

If the idea is to get rid of PLUGIN_DEF_AUTH, then let's do so, not
add extra #ifdef  :-)


Anyway.  Trying to understand the logic here - PLUGIN_DEF_AUTH is always
defined if ENABLE_DEF_AUTH is set, which seems to be the default setting.

So, questions
=20
 - is there actually some benefit in --disable-def-auth?  code size,=20
   performance, platform compatibility?

 - why do we have it in the first place?

 - can we get rid of it?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--XLsjFikA86nwwlhe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbdWIGAAoJEB2Cnv7KVigS6f4L/00khyzqNcWieNMHKd8frJCZ
wbBVhMRAiJWBBF58InMGLMdPshllkZFZc2SSIv73N3yIf36nlgphrS8oX1i8Q6h8
vfNBdcOzLnkddkBLc9X+dT1LjmfyY9SN/+6u0gYfHK1+auqDvJ0J9UU2XcQxyrlI
0pxCvAh8FZB+uobwOSk9zDXNFueY9YMP966094V6CqfXQ7AzlUamz2Usj++u/Wc0
LeyowOF22oRVzEs1xXKQcT948P+cVYb2PZOPNKhnTFiUEi58LNFIpR3bNf7voWhr
2LteYw4X6wbmEu4CxrL+gBX8lvFekd3jzpIyoK76LhEnQHTsGZbhHtf5LeTxNgZ+
MEOAhMZPAOnt2inCHDkjSpYt+8ifaWel9btTAxvKPoY731QxS8ols2cMZv5fLscG
lHwvsN1dhj8Kgcsv/QU6c75Z+Ab+oDSe80C3ZU4Baih0ceDO6GLYqIl5hzuRzlG7
fAoiUrOXtPdgFb/kP43R9CCqE09DgkkDcJi1saRDxg==
=61hQ
-----END PGP SIGNATURE-----

--XLsjFikA86nwwlhe--

