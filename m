Message-ID: <4009B51C.7090801@...157...>
From: Martin Hejl <martin@...157...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] patch for iproute
References: <twig.1074376758.95918@...41...>
In-Reply-To: <twig.1074376758.95918@...41...>
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
Date: Sat Jan 17 14:21:01 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi James,

> Thanks for the patch -- it looks good and I expect to merge it.  
Thanks - sounds good to me.

> I see that
> you hardwire the choice for iproute2 vs. vanilla ip route + ifconfig at build
> time.  Do you think that makes sense, or would it be better to have an
> --iproute2 run time flag?
Two reasons, basically. First of all, I'm lazy, so I wanted the patch to 
be as short as possible (and a runtime option probably would have meant 
having to make more changes than a define). It was simply very straight 
forward to add the code and then add the options to configure.ac
Besides, a run-time option would have meant having to "disturb" much 
more code - and I wanted to keep the change as isolated as possible. 
Easier to test if things still work, and less chances that I've screwed 
up something else.

And second, my guess is that at the moment, a plattform with only 
iproute2 is still pretty exotic (so the option would not be needed for 
most people) - and the plattforms that only have iproute2 (like LEAF) 
are focusing on minimizing the size of all packages - so I didn't want 
to increase the size of the binary if I could.

I know, both reasons aren't terribly good - if you feel that it would 
make life for you or package maintainers easier if it's a runtime 
option, feel free to change it (I know that compile time options are a 
pain for packagers). I guess for somebody familiar with the code, it 
should be rather simple (but I won't pretend I'm familiar with the 
OpenVPN sources - it was easy enough to find the places I needed to 
change that I didn't dig around in the other modules too much).

Martin


