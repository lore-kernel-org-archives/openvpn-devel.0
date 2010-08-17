Message-ID: <4C6AE7AD.9020804@...1114...>
Date: Tue, 17 Aug 2010 21:49:01 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20100808194847.GN740@...1296...>
	<20100810105733.GY740@...1296...>
In-Reply-To: <20100810105733.GY740@...1296...>
Subject: Re: [Openvpn-devel] RFD: VPN client test framework
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

On 10/08/10 12:57, Gert Doering wrote:
> Hi,
> 
> On Sun, Aug 08, 2010 at 09:48:47PM +0200, Gert Doering wrote:
>> as discussed in one of the previous the IRC meetings, I've been working
>> on a test framework to enable full "fire up openvpn client, establish
>> VPN connection, run ping tests, clean up, verify cleanup" automated 
>> tests.
> 
> I got some feedback from Waldner on IRC, and had to make it work on
> Solaris (broken /bin/sh) - so this is now built using "configure",
> knows how to find "ip", "ifconfig" and "netstat" (configure does the
> work :-) ), *and* has been tested on Solaris (works!).
> 
> The patch goes on top of the previous one.  Pushed to my git repo.
> 
> gert

ACK

commit 0df01a3eb7ef21de7a18a32457ddb39084baead7
Author: Gert Doering <gert@...1296...>
Date:   Tue Aug 10 12:39:28 2010 +0200

    Build t_client.sh by configure at run-time.

    This is now built using "configure", knows how to find "ip",
    "ifconfig" and "netstat" (configure does the work :-) ), *and* has
    been tested on Solaris (works!).

    extend configure.ac to find "netstat" binary and to chmod +x
    "t_client.sh"

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <dazo@...384...>
    Signed-off-by: David Sommerseth <dazo@...384...>


Applied to bugfix2.1, merged into allmerged and beta2.2.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxq560ACgkQDC186MBRfroG0ACff1TvvG7YPltJc8ji/Bfkz0Cv
z4QAn0zTgtVKkCpANdnLUl+mw00HyNTX
=UjWX
-----END PGP SIGNATURE-----

