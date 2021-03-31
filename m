Date: Wed, 31 Mar 2021 20:25:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210331182555.GE976@...1296...>
References: <E1lRfR7-0007jN-Go@...2479...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1/OLoKNDcmqALr/E"
Content-Disposition: inline
In-Reply-To: <E1lRfR7-0007jN-Go@...2479...>
Subject: Re: [Openvpn-devel] [PATCH 0/1] reliable: retransmit if 3 follow-up
 ACKs are received
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

--1/OLoKNDcmqALr/E
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 31, 2021 at 08:03:22PM +0200, Max Fillinger wrote:
> This is my second attempt at sending this patch, this time without
> mixing up commit message and cover letter, and from an account that
> (I hope) doesn't hate mailing lists.

It works :-)

(I would have managed to merge the other patch as well - I have a=20
pre-push hook now that refuses push if "openvpn-devel" is listed as
Author... - and your patch had Steffan's "From:" anyway)

Anyway, this is definitely interesting, but I did not have time to=20
dig into understanding the reliable layer yet...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--1/OLoKNDcmqALr/E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgZL6yAAoJEB2Cnv7KVigSQmEL/0VBPiwg40KOf9BPvpPPtPfb
04frI8WV4nRKB7Lay22MM8UkPkml56tDmFDTrghxZBS1uIWDwc38dZgPu2A3IWiS
Gh60hgS3N81v6Bvm/FmSvPMpb5dNyBFhmbuMgTQUyiF7OdHhcy5K0FIBsz8xuIf7
QfPvtmxJK4z+0g/PDoLcGTynhK/ojZWNaP3mVmTzNOQU8srD+ZuBGQmGKRmR8/yI
uAAyTJz5dthVW/lGiKuZFa9d7Z4R76U3YOFmxJ3G2kuGJ9Zq6ywT0VRh/PFU/4J8
mo4bIka0kobV8bDqWgTSy7rSLns+FjpAzFMbASpIjaY8itT8cve5o48+teHbsrEp
gjScByswK6CVXe4hjTCIndx+ktmylduY3sLe0AG2kdVSEUW397cDGLalBc+326TG
J/5u06GPbfOyMsZ/cSOskVdz1FTE6rihsswZtByR3B6+sSc+tatDbV8Zu+qMlRMY
xXzNiO2obADNMmtHyv3fE6r5qBKVMbVwYRNRdfGUyA==
=JrvS
-----END PGP SIGNATURE-----

--1/OLoKNDcmqALr/E--

