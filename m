Message-ID: <535B762A.8050200@...1790...>
Date: Sat, 26 Apr 2014 11:02:34 +0200
From: Tore Anderson <tore@...1790...>
MIME-Version: 1.0
References: <1398452943-18426-1-git-send-email-gert@...1296...>
	<535B6F81.8030005@...1790...>
In-Reply-To: <535B6F81.8030005@...1790...>
Subject: Re: [Openvpn-devel] [PATCH] Rewrite manpage section about
	--multihome
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

* Tore Anderson
> The patches will eventually make it into the previous LTS release
> 12.04 =ABPrecise=BB too, as part of the upcoming 12.04.5 point release
> (expected in August).

Just a little followup here to clarify in case you decide to add this
info to the documentation. The 12.04.5 =ABPrecise=BB fixes will come about
by importing a collection of packages from 14.04. They call this a
Hardware Enablement Stack (the purpose is to bring support for modern
hardware and its drivers to the older but still-supported releases):

https://wiki.ubuntu.com/Kernel/LTSEnablementStack

Anyway, what I wanted to clarify is that if a user is installing 12.04.5
from scratch, then it should default to using the kernel package from
14.04, and the IPv6 multihoming fixes should be there out of the box.
However if the user is on <=3D12.04.4, doing a distribution upgrade is not
sufficient, he would also need to manually install the kernel from the
14.04 Hardware Enablement Stack to get the required fixes. This is done
by installing the package "linux-generic-lts-trusty".

Here's some suggested text:

  The fixes are also present in Ubuntu 12.04.5 =ABPrecise=BB (kernel
  package "linux-generic-lts-trusty" required) and in Ubuntu 14.04
  =ABTrusty=BB.

Tore

