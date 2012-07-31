From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 31 Jul 2012 15:42:41 +0200
Message-ID: <1536595.V6KPfBiJ0b@...1526...>
In-Reply-To: <5017CC12.9000709@...1114...>
References: <1343666121-19765-1-git-send-email-heiko.hund@...1489...>
	<1738242.yJcaVCkhX0@...1526...> <5017CC12.9000709@...1114...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [RFC] give plugins a method to pass log lines
	to openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Tuesday 31 July 2012 14:14:10 David Sommerseth wrote:
> - From another point of view, an evil plug-in would have to know/figure
> out the address to x_msg() ... so that would require a bit more work,
> at least to work against different distro/compiler/linker
> combinations, as it's not given the address will be the same.
> However, it's not necessarily hard to figure it out, but requires more
> work.  And an evil plug-in would anyway need to first be installed
> somehow too.  So I consider this attack vector less attractive.

All the symbols are exported to plugins, so it's just a matter of adding the 
function prototype and flag values, if you do care at all.
 
> And, AFAIK, you can't use dlsym() without a handle to a shared lib
> opened with dlopen().  And I don't think you can't export the log
> function in the openvpn-plugin.h file as an external function, as the
> plug-in would fail to link (I would expect the linker wouldn't find
> the required symbol) ... which then brings us back to the point where
> you need to send a pointer to the log function to the plug-in ...
> That's basically how I came to this conclusion.

The dynamic linker resolves undefined symbols in the plugin automagically, so 
there's no need to get the address by hand. Haven't tested on Windows, but the 
symbols are there as well.

We could limit the exported functions by hand, but then plugins should not be 
considered evil. We kind of had the discussion during the interactive service 
privilege escalation discussion a while ago. If you let someone into your 
home, you better make sure you trust him anyway. =)

Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


