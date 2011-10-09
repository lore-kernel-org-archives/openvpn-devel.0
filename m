Message-ID: <4E918726.9090908@...1114...>
Date: Sun, 09 Oct 2011 13:36:06 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <C8EBC1CC-8304-4A97-A2C6-DE114CB05EFF@...1502...>
	<B96E3F2E-F1EF-41B4-9342-16AE68F53A8D@...1502...>
	<49806E1A-9928-4272-8EF5-55943866941D@...1502...>
	<4E8587EC.1020201@...1114...>
	<20111008103117.GG8496@...1296...>
In-Reply-To: <20111008103117.GG8496@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Client's routes ageing timer
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/10/11 12:31, Gert Doering wrote:
| Hi,
|
| On Fri, Sep 30, 2011 at 11:12:12AM +0200, David Sommerseth wrote:
|> On 15/09/11 23:42, Davide Guerri wrote:
|>> Please find attached a patch for a new stale-routes-check (and remove)
|>> option.
|>
|> Applied to the master branch in testing and stable trees.
|
| The way this is currently implemented breaks compilation with
| --disable-crypto --disable-ssl (glad we have buildbot to test this :) ),
| because in that case, P2MP_SERVER is not enabled, and
| options->stale_routes_ageing_time and options->stale_routes_check_interval
| are not defined.
|
| The patch below moves the block inside the #ifdef P2MP_SERVER block
| inside options.c - the code is not changed, just moved elsewhere.
|
| Smoke-tested on FreeBSD 8.2 (just compilation, not even started).
|
| Please verify, ACK, and commit :-)

Applied to master branches in testing and stable.
Commit 32ab329bc69c6292c205d4f33a4b8069341798d3

~    Signed-off-by: Gert Doering <gert@...1296...>
~    Acked-by: Davide Guerri <d.guerri@...1502...>
~    Signed-off-by: David Sommerseth <dazo@...384...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk6RhyYACgkQDC186MBRfrpUhQCglzfsZwAJpPLgGP8pC4T9cFev
/8oAoKrVgg7IjXNqhACSHp9qJciBB6qS
=R7tm
-----END PGP SIGNATURE-----

