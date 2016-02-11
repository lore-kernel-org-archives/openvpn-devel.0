Date: Thu, 11 Feb 2016 11:59:59 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@...124...>
Message-ID: <20160211095959.GE2461@...1281...>
References: <56B86D5C.5070506@...515...> <20160211082842.GD2461@...1281...>
	<20160211085953.GI24952@...1296...>
MIME-Version: 1.0
In-Reply-To: <20160211085953.GI24952@...1296...>
Subject: Re: [Openvpn-devel] OpenVPN installers with openvpn-gui pull
 request #13's code included
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Thu, Feb 11, 2016 at 09:59:53AM +0100, Gert Doering wrote:
> Hi,
>=20
> On Thu, Feb 11, 2016 at 10:28:42AM +0200, Pasi K=E4rkk=E4inen wrote:
> > Do you know if it's now possible to have also the OpenVPN config files =
and certs in user's profile directory
> > (not on system-wide c:\windows\program files\openvpn\config\) ?=20
>=20
> The intention is to make this configurable at installation time ("only
> admin-provided openvpn profiles" vs. "user-installable profiles").
>=20
> Details to be solved.
>=20
> (Background: if you permit user configs for unprivileged users, you permit
> unprivileged users to mess with routing, and potentially "steal traffic"
> by redirecting traffic into a malicious VPN server - so this needs to be
> a conscious decision by the admin at installation time)
>

Yeah, makes sense. Thanks for the update.

=20
> gert
>=20

-- Pasi


