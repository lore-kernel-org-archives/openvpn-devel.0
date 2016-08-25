Date: Thu, 25 Aug 2016 22:21:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160825202125.GV78279@...1296...>
References: <1456993146-63968-10-git-send-email-james@...515...>
	<1472152522-22431-1-git-send-email-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UrcmHL2XoDAE6/CM"
Content-Disposition: inline
In-Reply-To: <1472152522-22431-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] Bind to local socket before
 dropping privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: james@...515..., openvpn-devel@lists.sourceforge.net

--UrcmHL2XoDAE6/CM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 25, 2016 at 09:15:22PM +0200, David Sommerseth wrote:
> ACK.  Tested both master and release/2.3 branches with and without this
> patch.  On master this patch was needed to allow --lport 443 together
> with --user openvpn --group openvpn.  On release/2.3 this patch was
> not needed.
>=20
> Your patch has been applied to the master branch

Uh.  I'm not sure what happened here, but this patch breaks all (most?) TCP
client connections for me.  Across the board, all buildslaves (BSD and
Solaris) have issues connecting via TCP, and my linux client fails as well:

Thu Aug 25 22:07:29 2016 Attempting to establish TCP connection with [AF_IN=
ET]199.102.77.82:51194 [nonblock]
Thu Aug 25 22:07:29 2016 TCP: connect to [AF_INET]199.102.77.82:51194 faile=
d: Connection timed out
Thu Aug 25 22:07:29 2016 SIGUSR1[connection failed(soft),init_instance] rec=
eived, process restarting
Thu Aug 25 22:07:29 2016 Restart pause, 5 second(s)

seems that the patch interferes with the new timeout logic, and a=20
"sudden death" timeout of 0 seconds strikes because something is not
initialized yet.

David, please test the stuff you commit a bit more thoroughly, with a full=
=20
set of t_client tests (udp, tcp, tun+tap) at least.  *Especially* those=20
"harmless looking" patches that have lingered around for a bit while other=
=20
serious code changes have happened.

Please revert.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--UrcmHL2XoDAE6/CM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV79TRakuBuNlUUl1AQI5DgP+Ln1xDBKx+sgr9dvbRGdUp5ksgmk1aT8K
ayy5ei1oZboEbEnSpBaAs6KJGjVykI8q3L4jALLUtPAM+5llx56empg9rJWDrHAv
nXDNETIhfq9OXAUdBP2RXHDtlUsvoO1mQzaMEgM1Bo83LLvl/qmcMWVI/eYdBE+m
JH4bj5huOZU=
=2i4C
-----END PGP SIGNATURE-----

--UrcmHL2XoDAE6/CM--

