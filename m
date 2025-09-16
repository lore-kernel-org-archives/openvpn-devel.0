Message-ID: <8ac71781-d3dd-4f42-b9bc-611f9bb9de39@...2108...>
Date: Tue, 16 Sep 2025 11:22:24 +0200
MIME-Version: 1.0
References: <CAH+fs=9O0-SdY=A3ujsV+bmcG2m64jeJ-rbCKqzGNuWp-d5rFw@...278...>
 <d1d2c3a1.AVIAAHqfjCYAAAAAAAAAAazlIakAAYCsnhYAAAAAABXTlQBoyCqt@...2677...>
 <CAH+fs=9KC4xV=ZQuYA-vC=5x8m6p1w6OEXAzkMwnFeGhMJVD_Q@...278...>
From: David Sommerseth <dazo+openvpn@...2108...>
Content-Language: en-US, nb-NO
In-Reply-To: <CAH+fs=9KC4xV=ZQuYA-vC=5x8m6p1w6OEXAzkMwnFeGhMJVD_Q@...278...>
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
To: Marc Leeman <marc.leeman@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 16/09/2025 10:41, Marc Leeman wrote:
>>> FYI, i've received a couple bugs wrt GCC15. For gdbuspp, I'll demote
>>> the free-no-heap error atm, still need to look into the second error.
>>>
>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1114118
>>
>> I will need to look deeper into this one.  There are some odd things
>> happening here. In my own Debian Sid test container, it builds find via
>> meson ... but not when using the c++ command line from the log.  The
>> local Meson configure adds -Wno-free-nonheap-object, which is probably
>> avoiding this issue.
>>
>> This needs more investigation.
> 
> With `trixie`, I started using sbuild more instead pbuilder/cowbuilder
> setups, just running, `sbuild` in the source tree triggered it for me
> (it defaults to unstable).

Okay, I found out why I had the -Wno-free-nonheap-object argument in my
local meson build.  I had a hunch I had been fighting this one before.
And I did my test builds from git master, where this commit is present:
<https://codeberg.org/OpenVPN/gdbuspp/commit/165de7488cb976e7cad00dceb7bae413272529ba>

This is more or less a workaround for this issue, but it is considered
safe as it's only used by the test programs.  And it may very well be a
false-positive from the GCC-15 compiler - but I need to dig deeper into
this to conclude either way.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


