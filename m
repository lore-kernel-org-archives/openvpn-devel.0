Message-ID: <4F9A80E5.8030707@...1114...>
Date: Fri, 27 Apr 2012 13:20:05 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz0nDj78COr6sd4FAMPz3sML0+-5ZNOx7s_62qtk12tnag@...278...>
	<1333879485-2417-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1333879485-2417-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] crash: packet_id_debug_print: sl may be
 null
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/04/12 12:04, Alon Bar-Lev wrote:
> Program received signal SIGSEGV, Segmentation fault. 
> packet_id_debug_print (msglevel=1174405255, p=0xa36bd0718, 
> pin=0x3de5feec1b0, message=0xa330dde80 "PID_TEST", value=0) at 
> ../../../src/openvpn/packet_id.c:504 504       for (i = 0; i <
> sl->x_size; ++i)
> 
> (gdb) print sl $2 = (const struct seq_list *) 0x0
> 
> Reported in the past[1].
> 
> [1] http://thread.gmane.org/gmane.network.openvpn.devel/5466
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- 
> src/openvpn/packet_id.c |   16 ++++++++++------ 1 files changed, 10
> insertions(+), 6 deletions(-)

Applied to master branch on -testing and -stable trees.


commit 4e846b39a35b5f9501e4283be0af620d7c9c8b5c
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Sun Apr 8 13:04:45 2012 +0300

    crash: packet_id_debug_print: sl may be null

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: James Yonan <james@...515...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+agOMACgkQDC186MBRfroQyQCfTE02eg99CsUB3Ced4A+iKZGW
7sUAn19wsDC5soQ1n6krB8slxztICHxM
=beGW
-----END PGP SIGNATURE-----

