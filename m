MIME-Version: 1.0
References: <4B3OgL3j077iDP_MhneRo1v3CxM7prwXD2RgkpFEKEK5OUPBRPTsT2E6lJDmOzUw2Vf_T5FtOtUUnMzBh06X0L7z3zl00BgZP_a01CXQkh0=@protonmail.com>
 <ed2ca789-8501-f54b-3fe1-03039d456b93@...1227...>
In-Reply-To: <ed2ca789-8501-f54b-3fe1-03039d456b93@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 23 Jul 2020 20:35:07 -0400
Message-ID: <CAKuzo_gF00xHdDK++Bj-KpBEeVHb9meq=tAEu=FMfnTovjqE7Q@...278...>
Subject: Re: [Openvpn-devel] Regarding deprecation of --route-nopull
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
To: Arne Schwabe <arne@...1227...>
Cc: =?UTF-8?B?QW5kcsOp?= <pippin1st+devel@...2282...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi

On Thu, Jul 23, 2020 at 4:50 PM Arne Schwabe <arne@...1227...> wrote:
>
> Am 23.07.2020 um 20:14 schrieb Andr=C3=A9 via Openvpn-devel:
> > Hi,
> >
> > Regarding,
> >  https://community.openvpn.net/openvpn/wiki/DeprecatedOptions#Option:--=
route-nopull
> >  "Openvpn devs would like to know if you use this option".
> >
> > Many pfSense users use this option to policy route.
>
> I would also vote for keeping this option. Yes you can emulate the
> option by using a number of pull-filter lines but that feels like not a
> good user experience.

That's because route-nopull is not what it appears to be. A single
line of "pull-fliter ignore route" will do exactly what one would
think "route-nopull" should do, but the latter does more. It's poorly
named and now we have better ways to control pulled options, so I have
no love for it.

> Also route-pull works in both OpenVPN 2.x and 3.x
> clients while pull-filter is currently 2.x only.

Actually pull-filter cannot be compared with route-nopull as the
former is customizable. The real question is whether there is any
compelling reason to use it other than lack of alternatives in 2.3 and
older. I didn't know 3.x does not support pull-filter. Why? It's easy
to code (at least I know that for sure) so that can't be the reason.

Selva

