From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] openvpn server in client-to-client mode
In-Reply-To: <000f01c4e62e$4e5eb450$0200080a@...333...>
Message-ID: <Pine.LNX.4.58.0412200900150.19152@...41...>
References: <000f01c4e62e$4e5eb450$0200080a@...333...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Dec 20 08:15:02 2004
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?Tor_H=E5kon_Gjerde?= <thgjerde@...332...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 20 Dec 2004, [iso-8859-1] Tor H=E5kon Gjerde wrote:

> Hi
> I would like to run an openvpn server on a shell account without root.
> A server that does only client-to-client, with no interface on the server=
=20
> itself.
> But openvpn says it needs an tun or tap device.
> I understand this might require the tun or tap device itself to be emulat=
ed.

It's possible but would require a patch.

Essentially you would use a normal server configuration, but then use "dev=
=20
null" rather than tun or tap.  It should be possible to run from a=20
non-root shell since no tun/tap device needs to be opened.

Right now the OpenVPN server mode only supports "dev tap" or "dev tun" so=20
someone would need to go through to the code to add support for "dev null"=
=20
as well.

"dev null" is presently only supported in point-to-point mode.

James


