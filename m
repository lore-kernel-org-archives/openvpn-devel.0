MIME-Version: 1.0
In-Reply-To: <20101112201802.GZ258@...1296...>
References: <4CDD641F.30408@...515...> <20101112163620.27677.qmail@...1287...>
	<4CDD704B.7080505@...1114...>
	<20101112201802.GZ258@...1296...>
Date: Sat, 13 Nov 2010 08:39:34 +0200
Message-ID: <AANLkTimvA=HCWt7h_O+CFJwSxUY_SXJcMayszR=StRVk@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Removed hardcoded signtool dependency
 from win/build_all.py
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hello,

This again, raises the modulation of openvpn project.
*NOBODY* wants/needs to modify the driver, most people lacks the
skills and interest. Usually people wants to patch openvpn userspace
components.

The driver should come in its own .msi signed (msi + driver).

OpenVPN installation should embed the driver msi within it.

For signing OpenVPN, this should be optional, as Windows does not force it.

I use osslsigncode[1] with patches[2][3] to allow signing using a
cross compiler.

Alon.

[1] http://sourceforge.net/projects/osslsigncode/
[2] http://sourceforge.net/tracker/?func=3Ddetail&aid=3D3018894&group_id=3D=
129143&atid=3D713908
[3] http://sourceforge.net/tracker/?func=3Ddetail&aid=3D3018895&group_id=3D=
129143&atid=3D713908


On Fri, Nov 12, 2010 at 10:18 PM, Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Fri, Nov 12, 2010 at 05:50:19PM +0100, David Sommerseth wrote:
> > If I've understood it correctly, this is related to signing the Windows
> > TUN/TAP driver. =C2=A0So if you don't have a signing key/tool available=
, it
> > is still possible to build the rest of OpenVPN. =C2=A0You might even ma=
nage
> > to install the unsigned TUN/TAP driver with some tweaking.
>
> Isn't the openvpn.exe signed as well?
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //www.muc.de/~gert/
> Gert Doering - Munich, Germany =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gert@...1296...
> fax: +49-89-35655025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gert@...1297...
>
> -------------------------------------------------------------------------=
-----
> Centralized Desktop Delivery: Dell and VMware Reference Architecture
> Simplifying enterprise desktop deployment and management using
> Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
> client virtualization framework. Read more!
> http://p.sf.net/sfu/dell-eql-dev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

