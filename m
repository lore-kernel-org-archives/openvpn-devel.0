Date: Tue, 26 Nov 2024 15:32:33 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Z0XcAeifefZ_Ko9c@...1296...>
References: <20241126142639.67446-1-alex@...2837...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rwpP+PeKGRq6F1KM"
Content-Disposition: inline
In-Reply-To: <20241126142639.67446-1-alex@...2837...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Haiku: Introduce basic platform
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alexander von Gluck <alex@...2837...>
Cc: openvpn-devel@lists.sourceforge.net, Alexander von Gluck IV <kallisti5@...2838...>

--rwpP+PeKGRq6F1KM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

this is great, but alas...

On Tue, Nov 26, 2024 at 02:26:52PM +0000, Alexander von Gluck via Openvpn-d=
evel wrote:
> +#el
> if defined(TARGET_HAIKU)
...
> +#if defined(TARGET_H
> AIKU)

... your mail program is wrapping the lines in weird ways.

Can you please send with git-send-email or push to our gerrit?

(https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Patchsub=
missionviaGerrit)

> +        // Need to add ifconfig_remote_netmask since right now it is jus=
t NULL

... and while at it: no // comments, please.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--rwpP+PeKGRq6F1KM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnRdwBAAoJEB2Cnv7KVigS/AIL/3BMla8brTCY8yKPISM1kFmz
jlXSZzMgWd8M1bCouT13ur9iUoRqZKfFRdHCy4PllLjZA52R2E+uoNdCS5CIz8j5
EYEMGIt9tDiK1C02ACBIDTx6AsxvCs9CuhY20sTdrkwXjUgL5mQ2bwi8tBllmULY
9TnJDgOZSQ+lkPhCZV6O6fLle5Ci5VA1SldkBKkZZzNoZBCVv79efyQtn3r1FQzX
XcyXaxbkuZz867q9LhvYsUoxZIBxBQJ9KIkj/ZJljPfwRq/8KSpQ1+/sND79kztz
azsiGWxicQizecywJPuGVpFW+jS65+9/GSdd0DwOguReT+yv8p3tocT6hTqtAtH0
isBkVpVwgiODRFAqu0U9tf66xecBTNYnQLVuIUr+ME+aZ8Gq5LrS/Z+4WDtjn5pF
PWFYv6n85xmuYc8h/AZW12qhXWrkkFn0KYUZkkfD5vZCLFMwi0m/l3GadvvYZFAh
8R166OC5bfU71XtJlaTeYICaRHIynrPNMAf6t+W6QQ==
=M04E
-----END PGP SIGNATURE-----

--rwpP+PeKGRq6F1KM--

