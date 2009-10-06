Date: Tue, 6 Oct 2009 13:33:48 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20091006113348.GF3183@...30...>
References: <7bb795fd0910050745i6ea96b75t6e9e0fcd5da385e5@...278...>
MIME-Version: 1.0
In-Reply-To: <7bb795fd0910050745i6ea96b75t6e9e0fcd5da385e5@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn over ipv6 support v0.4.9,
 rebased on 2.1_rc20 [was: 	v0.4.6]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Mon, Oct 05, 2009 at 04:45:24PM +0200, JuanJo Ciarlante wrote:
> Hi
>=20
> On Mon, Oct 5, 2009 at 4:11 PM, Marcel Pennewi=DF
> <mailinglists@...1145...> wrote:
> > On Wednesday 30 September 2009 19:41:01 Marcel Pennewi=DF wrote:
> >> On Friday 25 September 2009 23:36:19 JuanJo Ciarlante wrote:
> >> > Hi,
> >> >
> >> > I'm(back) working on openvpn/ipv6 endpoint support, aka udp6/tcp6,
> >> > please refer to README.ipv6[1] and TODO.ipv6[2] for more details.
> >>
> >> OpenVPN 2.1-rc19 crashs on Gentoo (Xen DomU, AMD64( using tcp6-server =
with
> >> and segfaulted using "tcp-server"
> >
> > Both problems fixed in 0.4.8-patch. big thx to JuanJo.
>=20
> Thank you Marcel for the invaluable debugging and re-patching.
>=20
> FYI I rebased my current tree onto 2.1_rc20, git-push'd[1]
> and uploaded rc20 diffs [2].

Hi All!

I just included the patch on the official Debian package. It will enter
the Sid repository today, hopefully a bunch of new people will test it
now. :)

Regards,

Alberto

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

