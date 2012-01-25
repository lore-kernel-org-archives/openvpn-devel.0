MIME-Version: 1.0
In-Reply-To: <1327405130-22393-1-git-send-email-davids@...1347...>
References: <1327405130-22393-1-git-send-email-davids@...1347...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 25 Jan 2012 11:08:42 -0500
Message-ID: <CAEsd45R22XK71TEfe8rVCooQ65XsKDTCW_QB9p06VuQmQK0C3g@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add
 --route-pre-down/OPENVPN_PLUGIN_ROUTE_PREDOWN script/plug-in hook
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi.

On Tue, Jan 24, 2012 at 6:38 AM, David Sommerseth <davids@...1347...> wrote:
>
> This patchs adds a script/plug-in hook which is called right before the
> network routes are taken down. =A0This is give external processes a
> possibility to tear down communication over the VPN before the VPN
> disappears.
>
> One use case can be to mount a networked file system over the VPN via
> --route-up. =A0And then to unmount this file system via --route-pre-down


This is great. Two comments:

1. Is the man page (i.e., the page shown at
http://openvpn.net/index.php/open-source/documentation/manuals/openvpn-22.h=
tml)
part of the source code repository? If so, shouldn't patches that
change the interface include appropriate changes to the man page? If
not, wouldn't that be a good idea?

2. Can this be used to release a DHCP lease? That would be wonderful!

