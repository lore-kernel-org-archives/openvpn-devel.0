MIME-Version: 1.0
In-Reply-To: <534B8BF9.2060405@...1147...>
References: <1397366216-657-1-git-send-email-cernekee@...277...>
	<20140413104705.GL16637@...1296...>
	<CAJiQ=7DYg6PnTJ0piiUDKaT5wefVBxvPH3ZPHANQxOgWeDHjPg@...278...>
	<534AAAEC.7050105@...1227...>
	<CAJiQ=7COCWVzV1pq+ek8zimj65CdB0UM8S+1om1k8p_75yDjRA@...278...>
	<534B8BF9.2060405@...1147...>
From: Kevin Cernekee <cernekee@...277...>
Date: Mon, 14 Apr 2014 09:15:51 -0700
Message-ID: <CAJiQ=7Betr-bq68_1yKCufkqgrDj+RBxM482isuAxkqzPoeVxQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 0/3] Support non-root operation using
	ocproxy
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Apr 14, 2014 at 12:19 AM, Jan Just Keijser <janjust@...1147...> wrote:
> I'd vote against enabling TARGET_ANDROID by default

This would not be my first choice either, but it would allow non-root
processes to set up a fully functional VPN connection on Linux hosts
without a special build.

If I'm going to have to make a special build anyway, I'll just apply
my three patches locally.  It's working for me now and I posted
packages in my Ubuntu PPA.  But that is somewhat inconvenient to
maintain, and it doesn't benefit other OpenVPN users (almost all of
whom are using binaries built from the official sources).

> there's a reason the code is split into
> TARGET_LINUX
> TARGET_FREEBSD
> TARGET_SOLARIS
> etc and I'd say you're asking for trouble if you enable two TARGETs on
> one platform.

Yes, the way the code is currently written, enabling more than one
TARGET_* option is a problem.

But, stepping back a bit, does Android really need its own TARGET?  Or
can it be treated as a special operating mode on a standard
TARGET_LINUX build?  Any Linux host, Android or PC, should be able to
pass its traffic over either tunX or over a file descriptor passed in
from outside.  It would be nice if this choice was available at
runtime.

> I do like the idea of not needing root access to run openvpn - esp windows
> users could benefit from this, as they're not always allowed to install the
> tap-win adapter.

There are also a number of cases where it is useful to have
fine-grained control over which applications use the VPN connection,
e.g.

https://pay.reddit.com/r/techsupport/comments/22x2oo/routing_clients_through_vpn_connected_through/

I don't know if my solution is necessarily the best option for this
user, but it's something to consider at least...

> Then again, it goes against the UNIX/Linux philosophy that
> each tool (e.g. openvpn) should do one thing and it should do it well. By
> adding patches like this left and right we're steering away from that
> philosophy.

We could always split {route,tun,lladdr}.c into a separate program and
invoke it with "openvpn --dev '|tunhelper'".  :-)

