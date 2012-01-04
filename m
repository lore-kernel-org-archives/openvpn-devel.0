Message-ID: <4F043F78.8080806@...1114...>
Date: Wed, 04 Jan 2012 13:00:56 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20111230204838.GJ5060@...1296...>
In-Reply-To: <20111230204838.GJ5060@...1296...>
Subject: Re: [Openvpn-devel] range-checking bug in route.c
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 30/12/11 21:48, Gert Doering wrote:
> Hi,
> 
> when implementing the missing helpers for saving/restoring ipv6 route 
> option lists, I noticed that the existing code has safeguards against 
> buffer overruns, but they do not work in all circumstances.
> 
> Imagine:
> 
> - source list: capacity = 20, n = 5 (only 5 items in there) -
> destination list: capacity = 10
> 
> the check was "src->n > dst->capacity", which is OK, but then the
> full source list of "20 items" is copied over to dst - overrunning the
> memory.
> 
> Change to compare src->capacity to dst->capacity.  (We could change 
> the logic to copy only src->n items instead, and restore
> dst->capacity later on, but that's just another way to fix things :)
> ).
> 
> Applies to master, on top of the previous patch.
> 
> gert

ACK.  Applied to master on -testing and -stable trees.

commit 6abb6cdd46e50b61452b1b2d3d796ab0061e9128
Author: Gert Doering <gert@...1296...>
Date:   Fri Dec 30 21:42:13 2011 +0100

    Fix list-overrun checks in copy_route_[ipv6_]option_list()

    The old code checks how many items are in use(!) in the source
    list, but then copies the full list over the destination memory
    arena.  Check the source list *capacity*.

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8EP3gACgkQDC186MBRfrrLOACfXyrGjwgP/fSzL4eTXwWdEpXy
P4kAoIX1H8HSV5lXw+wd3JCifUP/+ko8
=yjMx
-----END PGP SIGNATURE-----

