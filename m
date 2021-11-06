Date: Sat, 6 Nov 2021 20:12:45 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YYbTrRCSGFrPIoEJ@...1296...>
References: <20210610153011.1730670-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Y/SOfSOeeCfoXEEC"
Content-Disposition: inline
In-Reply-To: <20210610153011.1730670-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid resending reset reply more than
 once per client packet
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--Y/SOfSOeeCfoXEEC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 10, 2021 at 05:30:11PM +0200, Arne Schwabe wrote:
> For the second reply of a OpenVPN we have no completed the three
> way handshake yet and the client IP address is still untrusted.
> When retransmitting the reset packet multiple times when timing
> out for an ACK response to it, we send the packet multiple
> times to an untrusted IP which is nowadys considered bad in a
> protocol.

For the record: we have decided at the hackathon to drop this patch
for the time being, because we (Arne, Steffan and Max) came up with
a better approach.  Instead of "keep state after the first packet"
we want to move towards a syn-cookie like approach where the packet
is answered, and forgotten (=3D no re-sent because we do not even know
there was a packet).  Only the 3rd packet in the handshake causes
state on the server - and that confirms that the client IP+Port is
not spoofed.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Y/SOfSOeeCfoXEEC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhhtOtAAoJEB2Cnv7KVigST4gMAJwNHP+x1dCFVHJkbO7TUmew
8QZyv4uzkepMZJb8KvTJHVKUNK/g9RYsWlJgu71XupsL80SWb6wD56Tij17Qvu1y
XGLricLhzppKHxEQEnrbL60yxzYEE9Mf28/2CdSYIE0APOWEUs53n18dlPq0Cnox
W/w9/+FFvjXBmdMNmU9pQ2oHZpW7YHz0Rvgotgk6hA3dC/SvxGdhhNHRhiYnxPJF
NLRc88Sc4aFFCD/snSUw3RcmNIfMEhnFtnkY+rHS9oBBi+/XpanMBzjeYWd1l7lQ
4w5UXx3ZHsdAAw7dasZIlBovHE3fQRQDskP94TpPwy7RDQC3QrmMvFTQaRF5IHPo
x19AShziZj9xoYbnq5z4mBPAoxuZrvff8AxXMtOxJl7boro7TZZZQd62rLU5OrYJ
s7sFuqHEfakS+WnmQJeizFv0vKCWhvXt62jYfSrRQsU70P8UGeMI0GFAwxl6gi8n
dgB6ZxMEEda90PFQjobsYrsbuggnrlsCDXqP7EnpwQ==
=Dgwo
-----END PGP SIGNATURE-----

--Y/SOfSOeeCfoXEEC--

