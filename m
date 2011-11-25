Message-ID: <4ECFC290.8030106@...1114...>
Date: Fri, 25 Nov 2011 17:30:08 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4e6f25dc2a58c3.42657146@...1498...> <4E801FAE.5010700@...515...>
	<4E806C6A.9090907@...515...>
	<201109261437.45686.heiko.hund@...1489...>
	<4EBA6F45.2030006@...515...>
	<20111124195128.GE2555@...1296...>
	<20111124201109.GR8496@...1296...>
In-Reply-To: <20111124201109.GR8496@...1296...>
Subject: Re: [Openvpn-devel]
 Snapshot	openvpn-2.x-20110909-master-install.exe fails
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

On 24/11/11 21:11, Gert Doering wrote:
> Hi,
> 
> On Thu, Nov 24, 2011 at 08:51:28PM +0100, Gert Doering wrote:
>> So here's the patch - it compiles (MSVC on Win7), the resulting 
>> binary works on WinXP, and it's not too ugly - actually it removes 
>> more #ifdef's that it adds...
>> 
>> Let me know your comments.
> 
> So David found it confusing, and I agree to some extend :-) - it's 
> easier to see what is happening if we declare our replacement 
> functions as openvpn_inet_ntop() and openvpn_inet_pton() right away, 
> instead of having the preprocessor #define rename them on the fly.
> 
> new patch.

ACK.  Applied to master branch in -testing and -stable.


commit 53fb2c5c465ea97fccdc8be1823fff2616f08b50
Author: Gert Doering <gert@...1296...>
Date:   Thu Nov 24 21:09:36 2011 +0100

    work around inet_ntop/inet_pton problems for MSVC builds on WinXP

    always use our built-in replacement functions now, even if building
    on Win7 (which has inet_ntop/inet_pton in the system libraries) because
    the resulting binary will then fail on WinXP.

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7PwpAACgkQDC186MBRfrrb9ACcCYMVyBpIJUwsF5SzdAUZurpU
KJAAoKayma19gm4jwJgAykjkvXaZX0Tq
=L43N
-----END PGP SIGNATURE-----

