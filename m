From: Adriaan de Jong <dejong@...1435...>
Date: Tue, 22 Jan 2013 08:44:32 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B90133FB45DE2@...1436...>
References: <1358774007-4881-1-git-send-email-steffan.karger@...1435...>
	<1358774007-4881-2-git-send-email-steffan.karger@...1435...>
	<20130121202321.GH22465@...1296...>
In-Reply-To: <20130121202321.GH22465@...1296...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 1/3] Improve
	PolarSSL	key_state_read_{cipher, plain}text messages
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
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan.karger@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> -----Original Message-----
> From: Gert Doering [mailto:gert@...1296...]
> Sent: maandag 21 januari 2013 21:23
> To: Steffan Karger
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [PATCH 1/3] Improve PolarSSL
> key_state_read_{cipher, plain}text messages
>=20
> Hi,
>=20
> On Mon, Jan 21, 2013 at 02:13:25PM +0100, steffan.karger@...1435...
> wrote:
> > +#ifdef POLARSSL_ERROR_C
> > +  char error_message[1024];
> > +#endif
>=20
> What condition does that #ifdef depend on?  Will this function not
> always be available in Polar 1.2.3 and up?
>=20
> "We're trying to get rid of #ifdefs, not add more"
>=20

Hi,

PolarSSL can be made really small, by disabling modules. For example, detai=
led error reporting can be disabled with that flag in <polarssl/config.h>. =
We can always say that we demand error.c to be enabled, but I'm not sure ho=
w happy embedded developers would be with that decision. I'm pretty much am=
bivalent in this discussion and will follow the general opinion :).

Adriaan

