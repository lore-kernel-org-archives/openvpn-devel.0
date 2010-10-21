Date: Thu, 21 Oct 2010 12:56:23 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20101021105623.GF2571@...1330...>
References: <4CBC6CD4.7000103@...1418...>
	<20101018164138.GB16573@...1330...>
	<20101020193135.GE10703@...1296...>
	<20101021083852.GK10703@...1296...>
MIME-Version: 1.0
In-Reply-To: <20101021083852.GK10703@...1296...>
Subject: Re: [Openvpn-devel] Errors adding routes on Windows 7 with OpenVPN
 2.1.3
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

On Thu, Oct 21, 2010 at 10:38:52AM +0200, Gert Doering wrote:
> Hi,
>=20
> On Wed, Oct 20, 2010 at 09:31:35PM +0200, Gert Doering wrote:
> > I think the patch below should fix this, but have not tested this at all
> > (neither with nor without the patch).  Applies to tag v2.1.3
>=20
> David suggested to use CLEAR() to make easier-understandable code and
> more thorough clearing.  Patch (goes on top of the last patch) below.
>=20
> Agi, either patch should work, but if you haven't tested the other one
> yet, please test this one.
>=20

Hi,

I tested the patch successfully. It works for me(tm). OpenVPN stopped
adding those random routes, while it added the right one for the
"remote_host".

Thanks,

Alberto

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

