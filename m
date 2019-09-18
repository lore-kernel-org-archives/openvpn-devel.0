MIME-Version: 1.0
References: <961fb2b3-ca10-1549-3ec8-a408e0072e2f@...515...>
 <CAEsd45T29O1Te-XY04DRZxe7D3Ew8v6k6m-2Q6+O2_Td+JJusA@...278...>
In-Reply-To: <CAEsd45T29O1Te-XY04DRZxe7D3Ew8v6k6m-2Q6+O2_Td+JJusA@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 18 Sep 2019 06:57:26 -0400
Message-ID: <CAEsd45S0D7ew4yJzbxFUOOVjtqdqYe=bsd5-2s+SGd4o+SWCDA@...278...>
Subject: Re: [Openvpn-devel] Removing --disable-server option from OpenVPN
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Oops.

On Wed, Sep 18, 2019 at 6:54 AM Jonathan K. Bullard <jkbullard@...277...> w=
rote:
>
> Hi,
>
> On Wed, Sep 18, 2019 at 6:38 AM Samuli Sepp=C3=A4nen <samuli@...515...> w=
rote:
> >
> > Hi,
> >
> > We are considering removing the --disable-server option from OpenVPN in=
 2.5.
> >
> > Do you use (and need) it, or know of somebody using (and needing) it?
>
> As far as I know, it is not used by any Tunnelblick users.
>
> Also, note that it doesn't appear on the 2.4 man page [1]. (Even
> substituting "=E2=80=93" for "--".)
>
> Best regards,
>
> Jon Bullard
>
> [1] https://openvpn.net/community-resources/reference-manual-for-openvpn-=
2-4/

I misunderstood -- it's a compile-time option, not an OpenVPN option.
Tunnelblick doesn't use it for our builds.

Sorry for the noise.

Jon Bullard

