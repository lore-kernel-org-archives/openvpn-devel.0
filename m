Date: Mon, 26 Sep 2022 08:39:07 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YzFJCxQ1pDGuMG+g@...1296...>
References: <20220818084825.187755-1-a@...2181...>
 <20220918220618.31112-1-a@...2181...>
 <YyntXHQMcmih8aLE@...1296...>
 <32aae0d4-d225-a5c1-3ee2-2b03b184d324@...2181...>
 <CAKuzo_gyYS=_cfV9QYi+UbpZbRuKdpJJjuCq3jFdhmNna2=2rg@...278...>
 <1edc266d-09e7-40b6-5b73-6998a3548d45@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="C6SNes4Ua8wundyw"
Content-Disposition: inline
In-Reply-To: <1edc266d-09e7-40b6-5b73-6998a3548d45@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v4] push-peer-info: rearrange function
 generating peer info
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--C6SNes4Ua8wundyw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 26, 2022 at 12:13:57AM +0200, Antonio Quartulli wrote:
> For now I will just remove the brackets from case 2, where they are not=20
> needed.

TBH, I think we should just not use switch/case here.

It might seem elegant, to do this with a fall-through switch/case, but
it turns out to be not very elegant due to the restrictions on local
variables.   Also, if someone ends up setting push-peer-info to 4,
they will get "nothing at all" now, instead of "everything".

To keep to your idea of doing this in blocks "3", "2+3", "1+2+3" one
could do

   int detail =3D session->opt->push_peer_info_detail;
   if (detail >=3D 3)
   {
       ...
   }
   if (detail > 2)
   {
       ...
   }
   if (detail > 1)
   {
       ...
   }

so it has less twisted conditions.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--C6SNes4Ua8wundyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjMUkLAAoJEB2Cnv7KVigSPSQMAIWNDtidj0gr7eybuH3a97WM
ehNNKT2Qa0TKWS/DhmE3J4Mq9FMXEOFngXwB8ykbt8mjqi4okxF3Wtr5tl09CC6A
B7GhrZL1Fw+SGlF1DcvvpncricTbmf1gZ4P34rgfFWs++SwcXs4p8dIwseJsul5s
lp1RDmnNI6rVmnuBSNGTvVKWNAXGwJsH7Cl0oPRlORaNh61A6RrP+AiwPVkQY30A
At067shlUtarbG9lxpVIqb3euHwscuwm9O4pPet1ZhVbs8FlL86+CAe4RxXX29RQ
xn5WMFUqntc2y7+gpN9VDEoCbrpjenmU7Iboe1rnIklbMOwfII2gwpqpjAbDxaQN
P4epoTboslHdn+V+2oKFJkHqBiwIMtWTvV0+rm+2TfQtFWTceMa9OtBBr1QkGSmI
N9g8Bp8+GcX/d9OTldLSnyY6PRddCCfrSga/SgRgNsBJgWrCb3yayJL1iOV5y/v7
KyA5N3BC9RFaH+2cqK5/dK8WN1/rDffbks9CoRSQHQ==
=XPwO
-----END PGP SIGNATURE-----

--C6SNes4Ua8wundyw--

