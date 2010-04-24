Date: Sat, 24 Apr 2010 11:45:35 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <1272119686837120500@...1315...>
In-Reply-To: <1272119686837120500@...1315...> (from openvpn@...1315... on
	Sat Apr 24 09:34:46 2010)
Message-Id: <1272127535.1115.0@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Status Message Missing IP Address
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
Content-Disposition: inline
To: openvpn@...1315...
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

On 04/24/2010 09:34:46 AM, openvpn@...1315... wrote:
>=20
>=20
> Hi,
>=20
> This makes sense to me on the server side, but I'm running the
> management interface on the client ... why would it not know (or at
> least report) it's IP address?

Because it's not OpenVPN's IP address it's the client OS's
IP address.  OpenVPN is acting as a virtual wire.  The
client is obtaining it's IP as it usually does, just from
a server on the other end of the wire.  At least if I'm
understanding your configuration.



Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


