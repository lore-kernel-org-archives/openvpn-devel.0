MIME-Version: 1.0
In-Reply-To: <20130401111231.GD428@...1296...>
References: <1364762609-30320-1-git-send-email-arne@...1227...>
	<20130401111231.GD428@...1296...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 1 Apr 2013 09:26:04 -0400
Message-ID: <CAEsd45RW-ueAjEJS5PkecX=MuxLdBXA3uJceyVL6=wrvE9xoeA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add support of utun devices under Mac
	OS X
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
To: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Apr 1, 2013 at 7:12 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Sun, Mar 31, 2013 at 10:43:29PM +0200, Arne Schwabe wrote:
>> Mac OS X 10.7+ natively supports tun devices (called utun). The "standard" utun.ko driver is sometimes problematic (e.g. VmWare Fusion 5 and tun.ko do not work together).
>>
>> When OpenVPN is compiled with utun support it will if no dev-node is given first try to use utun and if that is not available will try the traditional tun devices


The "utun" stuff is new to me; all I can find is the source code for
it. Is this one of the "hidden features" of iOS that that OpenVPN for
iOS app uses, and that is also in OS X 10.7 and up?

Most configuration files I've seen do not include a dev-node option.
Does a "dev tun" option in the file imply, for this purpose, "dev-type
tun"?

If I understand this correctly, a user who updates to 10.7+ will be
using utun instead of tun. That may be problematic (I don't know).

Wouldn't it be better to use the legacy tun if it exists, and if not,
then use the utun? That would be backward-compatible with such
configuration files.

>
> I'm not fully sure whether I like this or not, but I can see the necessity
> if tun.ko is just not working in certain circumstances.
>
> I'd very much like to hear from "GUI authors" for MacOS X about this,
> though - copying Jonathan: what do you think is the way forward here,
> and should this go into a soon-to-be-released 2.3.2, or is this "long-term
> future" material for 2.4?

I don't have an opinion about including it in 2.3.2 vs. 2.4 -- I still
can't get anything after 2.3alpha1 to build properly for Tunnelblick!
I gave up on that several months ago, but last week someone else
started working on it and is making progress.

>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //www.muc.de/~gert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...

