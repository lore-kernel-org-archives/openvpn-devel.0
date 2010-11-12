Message-ID: <20101112165541.29963.qmail@...1287...>
Date: Fri, 12 Nov 2010 17:55:41 +0100
From: Peter Stuge <peter@...1287...>
References: <4CDD641F.30408@...515...> <20101112163620.27677.qmail@...1287...>
	<4CDD704B.7080505@...1114...>
MIME-Version: 1.0
In-Reply-To: <4CDD704B.7080505@...1114...>
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
> >> Modified win/build_all.py so that build does not fail even if
> >> the optional signtool python class is not available.
> > 
> > What is it needed for? Is it really *always* optional?
> 
> If I've understood it correctly, this is related to signing the Windows
> TUN/TAP driver.

Right.


> So if you don't have a signing key/tool available, it is still
> possible to build the rest of OpenVPN.

Fine, but this is not really acceptable when James&co builds OpenVPN,
so I am requesting a solution that allows them to specify to the
build process that they want a fatal error if signing is not
possible.


//Peter

