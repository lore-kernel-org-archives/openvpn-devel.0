Date: Thu, 26 Nov 2020 11:06:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20201126100626.GN976@...1296...>
References: <a2152b6e-1429-6637-aef8-7eaf527316e3@...2181...>
 <CAAUX2SWEOk5TC1J9jBoiS6=chMbY_6DTMvPV1J07d3L26k9b0A@...278...>
 <228b401e-e700-447c-4c30-29d28cb22585@...2181...>
 <CAAUX2SX-90sKC-+MBQ9ycimK0YvHZC0rMjVKMKH_oFSDW=x5Tw@...278...>
 <8a1dc0cf-61d4-2ded-1c51-ccb755ba7ef9@...2181...>
 <CAAUX2SUqFRWcP+aTXUaW2+5zK6AGcAO51-rbcikexKXVPsc84g@...278...>
 <f34acee4-d928-509e-5bb3-9900c1578d5b@...2181...>
 <CAAUX2SXreiLnX5z0X9-oiKPJXT75=VjkdKsEb_taPHBGsP-39Q@...278...>
 <20201126085648.GM976@...1296...>
 <CAAUX2SVsOOfk0Z7rB5Z8SqUuU7d1+9AJFDqjJgJKLHxEDcAXDQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bzsITjXzOHWzfP2T"
Content-Disposition: inline
In-Reply-To: <CAAUX2SVsOOfk0Z7rB5Z8SqUuU7d1+9AJFDqjJgJKLHxEDcAXDQ@...278...>
Subject: Re: [Openvpn-devel] [ovpn-dco] Is cbc-hmac supported?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tony He <huangya90@...277...>
Cc: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>, lev@...515..., openvpn-devel@lists.sourceforge.net

--bzsITjXzOHWzfP2T
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 26, 2020 at 05:04:45PM +0800, Tony He wrote:
> Because there is HW crypto engine in some  embedded devices, the crypto
> engine maybe only supports hmac-sha256-cbc-aes.

OK, I was not aware that there is such special-case hardware.  Thanks
for the explanation.

Yes, in that case it might be nice to add support for these crypto=20
modes to DCO later, when the initial feature set is done, well tested
and properly shaken down.=20=20

For the initial feature set, DCO needs to focus on a subset of features=20
that benefit most users - and that's AES-GCM and CHACHA.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--bzsITjXzOHWzfP2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfv34hAAoJEB2Cnv7KVigSkGIL+wfRsoXBX1aMqrwtHmspKWLw
G0R7WKfUXnCb1HlhIg8R33KNZGwAKN4iGnsPGRHfJDnftWgVtuioXVjIo5qlmvfK
+IdLX/ywEXYIxfF5wLPt5+hHar3WPHUxScQJpYX3jQnsdv/IiYFl6KTfLFlnRSY9
Em31UxgWLM/1FJ9ID3EscFQKjJ48IKubnWoj1SSTMwHz495EK6kwvR48TIYyKu+v
CJlxGI29vZVfqpv6ZgH16ibfF0mW0y+FlOZrK572F+fTtfg5ogsO8WoYypCF6m6+
N7ata3qiWSR+JgWGw2Z08IvY/CK5ncitE7chIHG/B6JBD1Sak2pWzskpnYw3hkT4
zdn/44r+SIHnAyWqHVt8ZGOrjN6cW3txCrD/p9rbPIRD6qPaCHV5lNDq3qcFImKY
Znitz8wbPOzgJpAM34pSj5O1Wz/8YRN7bASby/alPhFuXD5tmKODPPUl1jVVZv84
aqRH7sBWlvE6n2KAUGYYU68Pyr9sWxo97dog7kI2bA==
=jB8m
-----END PGP SIGNATURE-----

--bzsITjXzOHWzfP2T--

