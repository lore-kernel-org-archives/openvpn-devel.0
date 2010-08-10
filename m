Date: Tue, 10 Aug 2010 12:57:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100810105733.GY740@...1296...>
References: <20100808194847.GN740@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gJNQRAHI5jiYqw2y"
Content-Disposition: inline
In-Reply-To: <20100808194847.GN740@...1296...>
Subject: Re: [Openvpn-devel] RFD: VPN client test framework
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--gJNQRAHI5jiYqw2y
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Aug 08, 2010 at 09:48:47PM +0200, Gert Doering wrote:
> as discussed in one of the previous the IRC meetings, I've been working
> on a test framework to enable full "fire up openvpn client, establish
> VPN connection, run ping tests, clean up, verify cleanup" automated=20
> tests.

I got some feedback from Waldner on IRC, and had to make it work on
Solaris (broken /bin/sh) - so this is now built using "configure",
knows how to find "ip", "ifconfig" and "netstat" (configure does the
work :-) ), *and* has been tested on Solaris (works!).

The patch goes on top of the previous one.  Pushed to my git repo.

gert

--gJNQRAHI5jiYqw2y--
