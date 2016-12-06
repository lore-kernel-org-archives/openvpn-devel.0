References: <20161206091059.y3dzup635wvzkw6y@...30...>
	<1481027162-12165-1-git-send-email-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <da199ee2-77b1-50ce-5b07-64044af47ba3@...1227...>
Date: Tue, 6 Dec 2016 13:36:04 +0100
MIME-Version: 1.0
In-Reply-To: <1481027162-12165-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3] Refactor setting close-on-exec for
 socket FDs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 06.12.16 um 13:26 schrieb Gert Doering:
> The existing code can leak socket FDs to the "--up" script, which is
> not desired.  Brought up by Alberto Gonzalez Iniesta, based on debian
> bug 367716.
> 
> Since different sockets get create at different times, just moving the
> set_cloexec() to link_socket_init_phase1() is not good enough - so move
> the call into create_socket_<family>(), so we will catch ALL socket
> creations, no matter when or under which conditions they will be
> created (SOCKS proxy socket, listening socket, ...).

Patch looks good. ACK from me. I also looked at the port-share code path
but that part isn't touched by this commit.

Arne


