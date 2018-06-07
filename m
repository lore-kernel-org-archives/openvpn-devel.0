Date: Thu, 7 Jun 2018 19:42:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180607174234.GQ57262@...1296...>
References: <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
 <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
 <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
 <CAKuzo_gp9jcVocxgf79TNQpgP-ScioC1pM_3oTq9+SHHAhEonw@...278...>
 <665fcdae-dad7-b6c8-14ee-512ff7992963@...2181...>
 <CAKuzo_jLhL=pLrkRoqWXHPRLzBGBiUCgq20Wzxd+DiidoAmOJA@...278...>
 <20180607165705.GP57262@...1296...>
 <CAKuzo_j23Y5Q367cug-usSheh5h6WXUqswOqNBVS3073rMesVw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="p609JBPwWeYlfsbE"
Content-Disposition: inline
In-Reply-To: <CAKuzo_j23Y5Q367cug-usSheh5h6WXUqswOqNBVS3073rMesVw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--p609JBPwWeYlfsbE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 07, 2018 at 01:05:19PM -0400, Selva Nair wrote:
> It happens because the patch skips CONFIG_TUN ioctl when v4 address is
> not set. I think that skips some initialization steps. I had expected
> the patch to setup the driver using 0/0/0 as the addres/mask/net as we
> discussed earlier. Fixing that should make the tap driver talk back to
> us and v6 work.

Oh, indeed.  That will be needed.

(I "assumed" - which I shouldn't do - that this is already happening)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--p609JBPwWeYlfsbE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbGW6JAAoJEB2Cnv7KVigSP+ML/jqPdsPPchj96KUDpq+6li5b
8CJGis/aUU0xOeM5vB9JE99fcfol5S0lWdddlPpE2jFnuW0wqmBEl+S8yLEoyc/L
A+5necvD9FvBF5Txmq6pxmXjrimat10aobWP485Syaaqrq0L/ig/57Z+aDkYF/LY
TuBBeQZ20UP2wPDb4m/4pCI1xgocoII5iyIO1cabxLiyGLNHaXx9KkfS8z+yHBYu
IN0wNAu0/2GVmCpqUyN4PFqUqDtK8uYRNwaUDxRfNcGac7LjweyEj/hZiGyLODZx
VqMMOrxYb/zpn9FpJnkNfTZBPncp6PzqwzjrlhZVPUXjTLvC49+VW28umoHrfhvz
bFaYmNudRLbVLxBEQ5BniZ1dk3ORJ0uX4AiwXQdewvIDCifPSgts/ZQeYiFFqSWR
oVYuG+VbBXdEZq+2fYmW7bnpivrRHePcWI8i4D75EpPjz2eQlS2XOgHTUttvLezY
c5xKjfC4fuQblDs/3bDwuKd35U6Sl8C85TMyHSC0ZQ==
=Zywa
-----END PGP SIGNATURE-----

--p609JBPwWeYlfsbE--

