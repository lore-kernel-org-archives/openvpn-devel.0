Mime-Version: 1.0 (1.0)
From: Marvin Adeff <volleynbike@...277...>
In-Reply-To: <20200818181820.GZ75094@...1296...>
Date: Tue, 18 Aug 2020 12:09:11 -0700
Message-Id: <2F7C4631-7E3C-47FB-BC8E-E4271F38AD9F@...277...>
References: <CAAWBBYPw=TZg1wftWZL5ABKVWkp7=6hpdaumLN2D24Cgr-E4pQ@...278...>
 <20200818062335.GV75094@...1296...>
 <20200818063212.GW75094@...1296...>
 <CAKuzo_jEGvTnkbsgJVm5beW5SapWoy_xLk_LA+-N59oa6SbbkA@...278...>
 <81A6F618-2F74-417F-A476-BF290CCFF143@...277...>
 <20200818181820.GZ75094@...1296...>
Subject: Re: [Openvpn-devel] 2.5-beta-1 Wintun requires SYSTEM privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Gert,

I=E2=80=99m sorry for the confusing response.=20=20

Our systems do M2M monitoring and need to run OpenVPN even without a user l=
ogged in.  In previous versions we created a script run as a service (as SY=
STEM) that started OpenVPN (using certificates for authentication).  It als=
o monitored tunnel status and restarted OpenVPN if necessary.  We never use=
d the GUI.=20

So we are watching how v2.5 develops to know how we will need to implement =
the new version.  We are also very interested in seeing what speed improvem=
ents wintun will offer.=20

I hope that is clearer.=20

Marvin=20

> On Aug 18, 2020, at 11:18 AM, Gert Doering <gert@...1296...> wrote:
>=20
> Hi,
>=20
> On Tue, Aug 18, 2020 at 08:55:31AM -0700, Marvin Adeff wrote:
>>> An additional check in openvpn.exe whether it's started as SYSTEM could=
 be
>>> useful as well, but less critical, IMO.
>> Yes Please!  We run 2500+ systems that run it this way as SYSTEM.=20=20
>=20
> "this way" is quite a bit unclear here - in the thread context,
> "this way" would be "run from the GUI", which never runs as SYSTEM.
>=20
> Can you elaborate a bit more how you run OpenVPN?
>=20
> gert
>=20
> --=20
> "If was one thing all people took for granted, was conviction that if you=
=20
> feed honest figures into a computer, honest figures come out. Never doubt=
ed=20
> it myself till I met a computer with a sense of humor."
>                             Robert A. Heinlein, The Moon is a Harsh Mistr=
ess
>=20
> Gert Doering - Munich, Germany                             gert@...1296...

