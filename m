Subject: Re: [Openvpn-devel] patch for iproute
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1074376758.95918@...41...>
In-Reply-To: <400836F1.1000804@...157...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Jan 17 14:00:00 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Martin Hejl <martin@...157...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Martin,

Thanks for the patch -- it looks good and I expect to merge it.  I see that
you hardwire the choice for iproute2 vs. vanilla ip route + ifconfig at build
time.  Do you think that makes sense, or would it be better to have an
--iproute2 run time flag?

James

Martin Hejl <martin@...157...> said:

> Hi everybody,
> 
> I am part of the LEAF project - a small distro for embedded environments 
> - at http://leaf.sourceforge.net (I'm actually only part of the "Bering 
> uClibc" branch, to be precise).
> 
> Since LEAF does not provide ifconfig and route by default (just 
> iproute2) I created a patch that allows using OpenVPN on LEAF boxes 
> without the need for ifconfig and route.
> 
> I would be very happy to see this integrated into OpenVPN at some point 
> (there's no hurry - we have a mostly automated build environment, so 
> applying the patch is no big deal).
> 
> I've tested the patch using a LEAF box plus a regular Fedora box (both 
> tun and tap devices) and everything seems to be working nicely.
> 
> If the patch doesn't make it onto the list (the LEAF lists trim all 
> attachments), it can also be found at:
>
http://cvs.sourceforge.net/viewcvs.py/leaf/src/bering-uclibc/apps/openvpn/iproute.patch
> 
> Let me know if you have any questions.
> 
> Martin
> 



-- 




