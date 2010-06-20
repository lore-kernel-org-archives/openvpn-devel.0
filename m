Message-ID: <4C1DA808.3030903@...1114...>
Date: Sun, 20 Jun 2010 07:32:56 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1276383776-15751-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1276383776-15751-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Fixed client hang when server don't
 PUSH (aka the NO_SOUP_FOR_YOU patch)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/06/10 01:02, David Sommerseth wrote:
> From: David Sommerseth <dazo@...384...>
> 
> Solves bug ticket 13
> <https://community.openvpn.net/openvpn/ticket/13>
> 
> When the client sends PUSH_REQUESTS, it waits until the server sends PUSH_REPLY.
> If the server do not have anything to push to the client nothing happens.  The
> client will then regularly send new PUSH_REQUESTS until it gets an answer, which
> results in not completing the connection negotiation.
> 
> This patch makes the server send an empty PUSH_REPLY when it has nothing to more
> to push to the client.
> 
> Signed-off-by: David Sommerseth <dazo@...384...>

Acked by James Yonan in the IRC meeting June 17.

Commit cb56a3ebe65871ae37894503e35c0b3703ee17a5, applied to bugfix2.1
and merged into allmerged.


Kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkwdqAgACgkQDC186MBRfrplPACgqn/6hqvvQYWqi2Ebmhw9GzgC
+eAAmwcQK7TsTr0mxvRL8GB37ZmuNEzY
=mWyI
-----END PGP SIGNATURE-----

