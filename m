Message-ID: <e60dc71e-b4ff-4c62-8778-857ad1fdfa78@...2108...>
Date: Mon, 15 Sep 2025 17:02:45 +0200
MIME-Version: 1.0
References: <CAH+fs=9O0-SdY=A3ujsV+bmcG2m64jeJ-rbCKqzGNuWp-d5rFw@...278...>
From: David Sommerseth <dazo+openvpn@...2108...>
Content-Language: en-US, nb-NO
In-Reply-To: <CAH+fs=9O0-SdY=A3ujsV+bmcG2m64jeJ-rbCKqzGNuWp-d5rFw@...278...>
Subject: Re: [Openvpn-devel] GCC15 errors
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Marc Leeman <marc.leeman@...277...>, openvpn-devel@lists.sourceforge.net

On 15/09/2025 13:33, Marc Leeman wrote:
> FYI, i've received a couple bugs wrt GCC15. For gdbuspp, I'll demote
> the free-no-heap error atm, still need to look into the second error.
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1114118

I will need to look deeper into this one.  There are some odd things
happening here. In my own Debian Sid test container, it builds find via
meson ... but not when using the c++ command line from the log.  The
local Meson configure adds -Wno-free-nonheap-object, which is probably
avoiding this issue.

This needs more investigation.

> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1114248

This one will need an upgrade of the OpenVPN 3 Core library.  In the
openvpn3-linux repository, commit 8f7fddbf91f40fcf [1] pulls in that update.

If you want to cherry-pick just this Core library update, have a look at
commit 166f110f453bfd [2] in the openvpn3.git repository

[1]
<https://codeberg.org/OpenVPN/openvpn3-linux/commit/8f7fddbf91f40fcfb328915e74414f4596786aab>
[2]
<https://github.com/OpenVPN/openvpn3/commit/166f110f453bfd421eabc0b0e36455fee845dd3e>

And a heads-up in regards to the openvpn3-service-aws add-on, there is a
bug there which will be fixed in the openvpn3-linux v26 release - which
is also fixed via a Core Library update.  The issue is related to errors
when pushing IPv6 routes to the AWS VPC.

You need two commits from the Core library fix this issue:
<https://github.com/OpenVPN/openvpn3/commit/5a77f05b68be54351b6fc36396930fb2ce54702b>
<https://github.com/OpenVPN/openvpn3/commit/bb120dafb16bc9ee6f4f61c40f12d0054f8700f3>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


