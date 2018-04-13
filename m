Date: Fri, 13 Apr 2018 17:37:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180413153706.GP69387@...1296...>
References: <20180413152915.7940-1-simon@...2293...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kNwp1Ad8laGYkdQl"
Content-Disposition: inline
In-Reply-To: <20180413152915.7940-1-simon@...2293...>
Subject: Re: [Openvpn-devel] [PATCH] Add missing (but optional) escape
 backslash to sed replace string
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

--kNwp1Ad8laGYkdQl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 13, 2018 at 05:29:15PM +0200, Simon Rozman wrote:
>  #ifdef NEED_COMPAT_LZ4
>  EOF
> -    sed 's/\"lz4\.h\"/\"compat-lz4.h"/' "$LZ4_C"
> +    sed 's/\"lz4\.h\"/\"compat-lz4.h\"/' "$LZ4_C"

TBH, I think all the backslashes before a double quote (") should *go*.

Nothing special about a " inside(!) ''... - neither the shell cares
nor sed (unlike '.').

So, NAK.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--kNwp1Ad8laGYkdQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJa0M6hAAoJEB2Cnv7KVigS7ekMAKpfg8DMrgqpXwl/I7iZDCEM
jYmG7daV2KNF5E5s3S0B0gKkJx4EkWG6S0PT8J1ueUR+GsEcYs8oTxzGcn5d2knx
ffvgp4pK3l8ICtD+U5L4tZ7TPK9aSFGiXwl9FIFwKQBmG2G2qQZz2IWy7GKliCMR
x39QYkyQ9gNHxfpN/tcb+MITs/iYI+k2v7tWRTGqYvU1khIHWWle9Xz+JFAuTaoC
AIrt17qewtmlJIaveSZRAyawexG3ESKFLFnPeTW5NJ6ZU44LKETUzn1OQupslj9v
ONMeEhXXrO/kGnqLePo3WOtefVtfxeEsVxm6Ri0YaU3LSXvYco6DEWbCxAAjp66x
sd/zdW1hsfb2qLYh3J8KgeJJtlLpYz5gON+IgNt0FY3bJO5GmpIZ5BKhVZ07YNQA
8sepCC/FdkoHAMrcWogo8QoALYVZrudrCzMnsWTWjR6XLojuhDSP1ns0Bn7gof8S
qiwFX7J/TWB+3zu3rfYmYAhJpJFAWE0GVCv825KnVg==
=BX5r
-----END PGP SIGNATURE-----

--kNwp1Ad8laGYkdQl--

