Message-ID: <4C9C4DA9.9080108@...1147...>
Date: Fri, 24 Sep 2010 09:05:13 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4C9C1BB0.7000304@...1299...>
In-Reply-To: <4C9C1BB0.7000304@...1299...>
Subject: Re: [Openvpn-devel] proper "logout" support for the server?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Jason Haar <Jason.Haar@...1299...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Jason Haar wrote:
>  Hi there
>
> Minor feature request. When a user ends their openvpn client session,
> shouldn't it be possible to send one last command to the server - a
> "logout" command? That way the server can clean up the session much
> faster than waiting for a keepalive timeout cycle...
>
> (the problem I see is that we make extensive use of "--up"/etc scripts
> and a user can sometimes do several "up->down->up" in a row - which
> leads to "flapping" checks. If the server was told the client was
> leaving, this would reduce these issues).
>
>   
it's already available:
  --explicit-exit-notify
this is needed only for UDP based connections, as the server will know 
when a TCP connection has ended.

HTH,

JJK



