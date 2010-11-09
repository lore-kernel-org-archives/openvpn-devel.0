References: <4CD42604.9060104@...515...>
	<4BECF8F2CDD74E4A8127421DB201BA2B0C234B@...1429...>
	<20101108130908.GX10703@...1296...>
In-Reply-To: <20101108130908.GX10703@...1296...>
From: =?iso-8859-2?Q?David=20Bala=BEic?= <david.balazic@...1379...>
Date: Tue, 9 Nov 2010 10:53:06 +0100
Message-ID: <4BECF8F2CDD74E4A8127421DB201BA2B0C25F0@...1429...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] Preview of OpenVPN 2.1.4 Debian and Ubuntu
	packages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Gert Doering wrote:

> On Mon, Nov 08, 2010 at 11:14:55AM +0100, David Bala?ic wrote:
> > PS: Who must I sleep with to accept a patch?
>=20
> Which patch is that?

For the "redirect-gatewy not working when using PPP" problem (Linux only, I=
 think),
reported by some users. It has a long history...
I sent a patch for 2.0 (IIRC), then for 2.1-dev, then I did
some git stuff when OpenVPN started to use git.

The gist of it is:

# for redirect-gateway
IF gateway is device
THEN # this is new
  route add ... dev pppX
ELSE # same as existing code
 route add ... via 1.2.3.4

The patch involves changing the route command (2 types, Linux only),
detecting the gateway type and passing the data from one part of
code to other (detecting to setting).

It is trivial (if I could do it... ;) ).

Regards,
David

