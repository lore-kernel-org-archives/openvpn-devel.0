Message-ID: <20101112171304.32055.qmail@...1287...>
Date: Fri, 12 Nov 2010 18:13:04 +0100
From: Peter Stuge <peter@...1287...>
References: <4CDD641F.30408@...515...> <20101112163620.27677.qmail@...1287...>
	<4CDD704B.7080505@...1114...>
	<20101112165541.29963.qmail@...1287...>
	<4CDD7309.3030808@...1114...>
MIME-Version: 1.0
In-Reply-To: <4CDD7309.3030808@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Removed hardcoded signtool
	dependency	from win/build_all.py
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

David Sommerseth wrote:
> >> So if you don't have a signing key/tool available, it is still
> >> possible to build the rest of OpenVPN.
> > 
> > Fine, but this is not really acceptable when James&co builds OpenVPN,
> > so I am requesting a solution that allows them to specify to the
> > build process that they want a fatal error if signing is not
> > possible.
> 
> That's a good point!  I didn't think about this one.
> 
> What about that the build script stops up and asks if it should
> continue without signing?

Kinda nice to keep everything non-interactive if possible..


> And in addition having a command line argument accepting building
> without signing?

I like that idea a lot! Possibly it could be the other way around
(argument leads to error if no sign possible) in order to optimize
for community builds, but there's also a good point to having the
default (no argument given) be more picky about when it succeeds.


//Peter

