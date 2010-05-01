From: Davide Brini <dave_br@...1278...>
Date: Sat, 1 May 2010 18:42:29 +0100
References: <4BDAD39A.1030906@...515...>
	<20100430181202.GG12312@...1296...>
	<201004301928.47595.dave_br@...1278...>
In-Reply-To: <201004301928.47595.dave_br@...1278...>
MIME-Version: 1.0
Message-Id: <201005011842.30097.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [TESTING NEEDED] Using --inactive and --ping
	seems to defeat each other
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Friday 30 April 2010, Davide Brini wrote:

> Well, the obvious (and probably wrong, probably inefficient) way could
> be to just check if the packet at hand is a ping message, and if it is
> do not record it as "activity", eg
>
> if (! is_ping_msg (&c->c2.buf))
>    register_activity (c, size);

How was that expression? "Complex problems have simple, easy to understand 
wrong answers". It seems this is one of those.

The problem with the above approach is that c->c2.buf at the time 
is_ping_msg() is called is potentially compressed (if compression is used, 
that is, almost always), so is_ping_msg() cannot detect a ping message.

Now, another approach could be to have a flag (a single byte) in the c2 
context whose only function in life is to be 1 is the message is a ping 
message, and 0 otherwise (or true/false, as seems to be preferred in the 
OpenVPN code). That way, one could test it (also potentially more efficiently) 
eg

if (! c->c2.is_ping))
   register_activity (c, size);

or something similar. What do people think? Does that look like a waste of 
space? Other ideas?

-- 
D.

