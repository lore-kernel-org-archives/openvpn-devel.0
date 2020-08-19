MIME-Version: 1.0
References: <20200818063212.GW75094@...1296...>
 <CAKuzo_jEGvTnkbsgJVm5beW5SapWoy_xLk_LA+-N59oa6SbbkA@...278...>
 <81A6F618-2F74-417F-A476-BF290CCFF143@...277...>
 <20200818181820.GZ75094@...1296...>
 <2F7C4631-7E3C-47FB-BC8E-E4271F38AD9F@...277...>
 <20200818192104.GB75094@...1296...>
 <CAKuzo_h2hLeQodHsJ7uzetq_XeGPJiu3i-o2tXuL29HbJcG6bA@...278...>
 <20200818194248.GC75094@...1296...>
 <CAKuzo_jG-NOqD4wHZ1SL-2Ti5NgocUDzSOpV5yqMaTXZ2UXVrA@...278...>
 <CAAWBBYPby1vNtcmqy32=jJbVO=vxaZuHphjR4UxJfS9pOAMc-Q@...278...>
 <20200819060327.GE75094@...1296...>
 <DC25B829-92E2-4052-AFDF-CC3F90BE4286@...277...>
In-Reply-To: <DC25B829-92E2-4052-AFDF-CC3F90BE4286@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 19 Aug 2020 09:57:42 +0300
Message-ID: <CAGyAFMUD6xFrOXjRgfsh4v=H069dV28HWD9Jdu1EBDgjB9hP+w@...278...>
Subject: Re: [Openvpn-devel] 2.5-beta-1 Wintun requires SYSTEM privileges
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
To: Marvin Adeff <volleynbike@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

As Gert mentioned, OpenVPN will set what is needed when connection is
established - just double-checked that this is indeed the case.

> So it didn=E2=80=99t read the .ovpn (to select dhcp) and it didn=E2=80=99=
t have anything to populate the IP/subnet/dns etc.  This can=E2=80=99t be r=
ight.  At the least it should be set to dhcp by default with static IPs add=
ed later if necessary.  Or am I doing something wrong?

Apart from missing values when the adapter is not connected, do you
experience any other issues?

-Lev

