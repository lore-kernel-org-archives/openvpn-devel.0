MIME-Version: 1.0
References: <20211207121137.3221-1-a@...2181...>
In-Reply-To: <20211207121137.3221-1-a@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 8 Dec 2021 09:49:42 +0200
Message-ID: <CAGyAFMVNJAALnsO0RAbo7s+pQ01=w6D4Y1JpHmdSzuquscq6TA@...278...>
Subject: Re: [Openvpn-devel] [RFC 0/8] Introduce ovpn-dco(-win) support
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

1) 7/8 should be squashed into 6/8, because 6/8 "ovpn-dco-win:
introduce windows data-channel offload support" breaks mingw i686
build, which 7/8 "ovpn-dco-win: fix mingw i686 build" fixes.

2)  Patch 6/8 "ovpn-dco-win: introduce windows data-channel offload
support" has commented out certain msvc defines - this was needed
because back then (when patch was originally written) MSVC didn't
support lzo/pkcs11, but now everything is supported
(we build releases with MSVC) and those defines needed to be brought
back. I have fixed that in my branch:
https://github.com/lstipakov/openvpn/commit/5f09bce8a50778fca9904f916f5b1073046aee84
and this needs to be squashed into 6/8

3) At the moment this doesn't compile with GitHub actions because of
a) missing ovpn-dco-win vcpkg port and b) "generic" build system code
has a bug in regards to ovpn-dco-win support. This is the fix for
MSVC/vcpkg: https://github.com/lstipakov/openvpn/commit/96a38f88254ae6ffee1cc262a295e62edecb213a
and this is for generic build system:
https://github.com/lstipakov/openvpn/commit/3058675e63a84e93bd5612238ecbd41cca463a0a
As before they needed to be squashed into "feature" commits and not
added separately as "fixes"

All those fixes are in my repo and GitHub Actions are green:
https://github.com/lstipakov/openvpn/actions/runs/1551278629

-Lev

