In-Reply-To: <Pine.LNX.4.58.0412092259480.3257@...41...>
References: <loom.20041210T063317-259@...171...> <Pine.LNX.4.58.0412092259480.3257@...41...>
Mime-Version: 1.0 (Apple Message framework v619)
Message-Id: <0C02273F-4A76-11D9-BB44-000D9335B6B6@...325...>
From: Steven Palm <n9yty@...325...>
Subject: Re: [Openvpn-devel] GUI for MacOS X
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
Date: Thu Dec  9 22:39:02 2004
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: James Yonan <jim@...41...>

On Dec 10, 2004, at 12:22 AM, James Yonan wrote:
> That sort of already happens now if you use 
> --management-query-passwords
> -- though I agree it would be useful to have a more generic mechanism 
> for 
> starting OpenVPN in a hibernated state until it receives a "start" 
> message
> from the mangagement interface.

  Ah... My testing initially is done using un-protected key files, so 
I've
not tried any of the password stuff. I thought I would add that later 
when
I knew all the other stuff was basically working. I'll look into that, 
though,
but would welcome the "start hibernated until given a go" idea. :-)

> Cool, are you going to focus on the client side only, or make the GUI
> capable of driving an OpenVPN server daemon as well?  (The management
> interface supports both).

  Well, I work for a non-profit organization and my immediate need is to 
make
this work for our overseas travellers who are frustrated with the IPSec 
stuff
not working in too many places due to odd firewalls/etc. Their needs are
entirely client-side, although I suppose a server-side implementation 
isn't
all that much different, just the config stuff up front, the back-end 
is much
the same.

  I also didn't realize work was already underway on a MacOS GUI. :-)  I 
just
saw something about it, and sent a note to the developer. My need is 
for our
users first and foremost, but I'm very open and willing to share what 
I've
got and collaborate to make it better.

  Thanks for a great program to build a GUI around. Your team already 
did the
hard part, the GUI is easy. ;-)

  Steve



