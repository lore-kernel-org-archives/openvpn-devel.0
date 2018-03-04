References: <CAKuzo_hZJzm+=s=ci50aDrtFOWFxOgw7TpDR9Epa89dyAAF18g@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <585fc96b-a276-1800-3f58-10b3c66c7cd9@...515...>
Date: Sun, 4 Mar 2018 10:05:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hZJzm+=s=ci50aDrtFOWFxOgw7TpDR9Epa89dyAAF18g@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Trac tickets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Il 03/03/2018 17:58, Selva Nair ha scritto:
> Hi,
>=20
> These days many (all?) trac tickets appears with an owner set. When I
> see an owner it gives the impression that person is looking into it
> and makes me less inclined to investigate.
>=20
> But it looks like this is automatically assigned and in many cases the
> so-called owner is MIA. It only gives a wrong impression that the
> ticket is being handled.
>=20
> Selva
>=20

I see you point. I think a better approach would be to automatically CC
the owner of the "component" (e.g. crypto, packaging):

https://trac-hacks.org/wiki/DefaultCcPlugin

The owner would get a notification email but the ticket would not be
automatically assigned to him/her.

Thoughts?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

