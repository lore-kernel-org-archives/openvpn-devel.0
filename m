MIME-Version: 1.0
Date: Mon, 26 Mar 2012 15:31:35 +0200
Message-ID: <CAOazyz065tGCsmMkqCy57+jHcBLFCuOTBfbtFaeiQYBg5Ye15w@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: [Openvpn-devel] [DISCUSS] OpenVPN public repositories at github.com
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hello All,

github.com provides a great service for open source project.

It allows to create organizations that may be maintained by several
people, allowing to easily create/delete repositories, and manage per
repository permissions.

It allows access repository via git, ssh, HTTP protocols (sourceforge
does not allow HTTP).
Its availability is much better than sourceforge, it sometime takes
about ~50 attempts for successful connection to sourceforge.

github provides great interface for viewing repositories, branches and diffs.

A basic ticketing system is also provided, not sure it is that far
from trac features... not a must.

It wiki is better than track as people can subscribe for changes,
hence cooperate much better than current state.

It also provides the ability to cooperate using repository fork, and
pull requests, not that it should be used, but much easier to
cooperate if we support pull process.

Each push to repository can be configured to send diff to mailing
list, so people can keep track on changes.

What do you think of moving the repositories to github.com?

We don't need to use all features, but at least move the repositories.

Keep in mind that we now have at least three repositories:

1. OpenVPN.
2. Easy-RSA.
3. TAP-Windows.

Regards,
Alon.

