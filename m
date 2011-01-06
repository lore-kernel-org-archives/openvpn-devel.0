Message-ID: <4D264964.4050602@...1030...>
Date: Thu, 06 Jan 2011 22:59:48 +0000
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <jb2PkGhmqClC.rQXy2JmT@...1444...>
	<4D260407.9090004@...1030...> <4D260739.1030201@...68...>
	<4D262940.5020104@...1030...> <4D262C21.6080905@...68...>
In-Reply-To: <4D262C21.6080905@...68...>
Subject: Re: [Openvpn-devel] bugfix2.1: automake support for plugin build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Matthias Andree <matthias.andree@...68...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> This has gone wrong.  The plugins should be built from the top-level
> directory instead (see below how it works for me), with the regular
> "make" that also builds openvpn, so the "for plugin in ... make -C
> $plugin ..." is no longer needed for these two guys.
>   
I just removed the loop to see if it works - NO! The source for the 2 
plugins won't even compile and make install obviously fails.


