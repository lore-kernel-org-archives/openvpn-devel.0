MIME-Version: 1.0
References: <CAH+fs=9O0-SdY=A3ujsV+bmcG2m64jeJ-rbCKqzGNuWp-d5rFw@...278...>
 <d1d2c3a1.AVIAAHqfjCYAAAAAAAAAAazlIakAAYCsnhYAAAAAABXTlQBoyCqt@...2677...>
In-Reply-To: <d1d2c3a1.AVIAAHqfjCYAAAAAAAAAAazlIakAAYCsnhYAAAAAABXTlQBoyCqt@...2677...>
From: Marc Leeman <marc.leeman@...277...>
Date: Tue, 16 Sep 2025 10:41:09 +0200
Message-ID: <CAH+fs=9KC4xV=ZQuYA-vC=5x8m6p1w6OEXAzkMwnFeGhMJVD_Q@...278...>
Subject: Re: [Openvpn-devel] GCC15 errors
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: David Sommerseth <dazo+openvpn@...2108...>
Cc: openvpn-devel@lists.sourceforge.net

> > FYI, i've received a couple bugs wrt GCC15. For gdbuspp, I'll demote
> > the free-no-heap error atm, still need to look into the second error.
> >
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1114118
>
> I will need to look deeper into this one.  There are some odd things
> happening here. In my own Debian Sid test container, it builds find via
> meson ... but not when using the c++ command line from the log.  The
> local Meson configure adds -Wno-free-nonheap-object, which is probably
> avoiding this issue.
>
> This needs more investigation.

With `trixie`, I started using sbuild more instead pbuilder/cowbuilder
setups, just running, `sbuild` in the source tree triggered it for me
(it defaults to unstable).

-- 
g. Marc

GPG: 827C FD74 BA46 8152 A041 F3A0 7A6A 4F17 5995 A65B

