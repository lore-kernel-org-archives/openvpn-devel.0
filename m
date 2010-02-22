Message-ID: <4B828F96.1080605@...1114...>
Date: Mon, 22 Feb 2010 15:07:18 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B7EBE5C.60702@...1114...>
In-Reply-To: <4B7EBE5C.60702@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] verb 5 logging wrongly reports received
	bytes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 19/02/10 17:37, David Sommerseth wrote:
> With --verb 5, openvpn logs a single letter (rwRW) for each package
> received or sent. I recently ran into a problem with the tun device on
> Linux where the read from that device returned 0. Unfortunately this was
> also logged as "r", which made me assume that openvpn had received
> something, while it actually hadn't.
> 
> (See https://dev.openwrt.org/ticket/6650 for the bug that made me find out
> about this problem with openvpn.)
> 
> I'm attaching a patch which prevents openvpn from logging "r" or "R"
> when it didn't actually read anything. This is against openvpn 2.1-rc20,
> but probably still applies to the most recent version.
> 
> This patch was received anonymously via the sf.net bug tracker:
> <http://sourceforge.net/tracker/?func=detail&atid=454719&aid=2951003&group_id=48978>
> 
> Signed-off-by: David Sommerseth <dazo@...384...>
> ----------------------------------------------------------------------
> 
> ACK
> 
> Patch looks sensible, and applies cleanly to the master branch.
> 
> David S.

Applied to bugfix2.1 branch, merged into allmerged.

commit 228c8b0f1e843e799251adb744f7066d983b2385
Acked-by: David Sommerseth <dazo@...384...>
Acked-by: Gert Doering <gert@...1296...>


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuCj5IACgkQDC186MBRfrranwCaAjRQiSB/Jq53EIFH7nuvq1nq
CgQAoILKL8eG9garRXj/vqp4617kHQnc
=AKOc
-----END PGP SIGNATURE-----

