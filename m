Date: Thu, 14 Dec 2017 11:33:07 +0200
From: Borodin Oleg <borodin@...2368...>
Message-ID: <20171214113307.05fc8f5c@...2368...>
In-Reply-To: <20171214111203.3a954204@...2368...>
References: <20171212134648.286e2416@...2368...>
 <fee81d29-13f8-a3a1-ef95-5ec1fdf2e479@...515...>
 <20171214111203.3a954204@...2368...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] openvpn web frontend, vpnsw
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Samuli =?UTF-8?B?U2VwcMOkbmVu?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 14 Dec 2017 11:12:03 +0200
Borodin Oleg <borodin@...2368...> wrote:

> On Thu, 14 Dec 2017 10:41:37 +0200
> Samuli Sepp=C3=A4nen <samuli@...515...> wrote:
>=20
> > Il 12/12/2017 13:46, Borodin Oleg ha scritto:=20=20
> > >=20
> > > Hi!
> > >=20
> > > I wrote a small web interface for managing openvpn services and obtai=
ning detail network information.=20
> > > http://wiki.unix7.org/vpnsw
> > >=20
> > > I wrote it to replace a legacy corporate vpn-crutch.=20
> > > It is already quite working, we manage more 400 tunnels/1200 workplac=
es.
> > >=20
> > > I have a question: how interesting this product is for continue devel=
oping?=20
> > > As opensource, of course.
> > >=20
> > > [Sorry, I sent this also to openvpn-users@]=20=20=20=20
> >=20
> > Hi,
> >=20
> > What is the use-case for vpnsw? Is this meant for managing client
> > connections on an OpenVPN server?
> >=20=20=20
>=20
> Hi, Samuli!
>=20
> We use it to disable/enable and monitor user/workstation/branch office gr=
oups.
> One VPN service on VPN concentrator related to 5-30 VPN "users", total to=
 one
> VPNc ~ 100-300, total to company workstation uses VPN direct or indirect ~
> 1400. Disconnection use for routine maintenance (synchronization/exchange=
 of
> application/corporate databases "into night" =3D) or urgently needed, and=
 yet
> etc).
>=20
> I can of course write a control of each user but so far there was no such
> purpose. I also can write to show tail of any service log in runtime.=20
> That's why I'm asking if there is an interest in development.
>=20
>=20

PS

For management of certificates for OpenVPN services I wrote yet one applica=
tion - MiniCA,
it implements a full X.509 cycle from creation of CA keys-certificates to c=
reating revocation lists.
Used for management more 2500 certificates.
http://minica.unix7.org

May be we can use this project/X509 model of the project to manage VPN, in =
future.

--=20
With best regards,
Oleg Borodin
+7-952-058-72-64
borodin@...2368...
onborodin@...277...

