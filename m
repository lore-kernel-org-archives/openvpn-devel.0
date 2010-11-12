Message-ID: <4CDDAA2E.7060300@...1114...>
Date: Fri, 12 Nov 2010 21:57:18 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <AANLkTiko6XdjTaNL_y5=+mAXUjHE4A22tPQcc14tqu-s@...278...>	<20101029122554.GQ10703@...1296...>
	<20101030191532.GX10703@...1296...>
In-Reply-To: <20101030191532.GX10703@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] TAP driver for Solaris patch
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Kazuyoshi Aizawa <admin2@...628...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 30/10/10 21:15, Gert Doering wrote:
> Hi,
> 
> back to the list after some private e-mails...
> 
> On Fri, Oct 29, 2010 at 02:25:54PM +0200, Gert Doering wrote:
>> On Mon, Sep 06, 2010 at 11:13:09PM +0900, Kazuyoshi Aizawa wrote:
>>> I attached a patch for OpenVPN 2.1.3 to support TAP driver for Solaris.
>>> Also, you can find the patch as well as TAP driver here.
>>>      http://www.whiteboard.ne.jp/~admin2/tuntap/
>>
>> One oddity remains: "--mode tun" + "--topology subnet" (not using 
>> point-to-point but "broadcast" tun interfaces) does not work.  I'm not 
>> sure whether this is a known limitation of the Solaris tun drivers, or 
>> of the way we currently access the interface - but it would be great 
>> if that could made to work - it's part of my set of regression tests...  
>> (this is *not* a problem introduced by your patch, it does not work for 
>> stock 2.2-beta3 either).
> 
> This works now, thanks to Kazuyoshi-san figuring out how to do "ifconfig"
> in this case, and for adding the metric setting on Solaris.
> 
> I have patched 2.2-beta3 with the patch appended below, and successfully
> tested the following cases on OpenSolaris/i386:
> 
>   - point-to-multipoint tun via UDP and TCP, "topology net30"
>   - point-to-multipoint tun "topology subnet" (*new*)
>   - point-to-multipoint tap (*new*)
> 
> all test cases pass, including fragmented large packets (fping).  I have
> appended OpenVPN.log files for "topology subnet" and "tap" cases.
> 
> Since it works on OpenSolaris, doesn't break existing functionality, and
> does not touch code for other platforms at all, I'd consider this a 
> useful addition to OpenVPN 2.2.  ACK from me for Kazuyoshi-san's changes,
> and if someone else would want to review and ACK this for "obvious" 
> errors (mem leakage, etc), you're welcome, of course.
> 
> David: patches below for integration into the "2.2beta" branch.
> 
> gert

Applied to the feat_misc branch, to be merged into allmerged and
beta2.2.  The ACK came privately to Gert and I got a private forward of
that ACK.


commit f0eac1a5979096c671b3674f9d80871f496d1da8
Author: Gert Doering <gert@...1296...>
Date:   Sat Oct 30 21:03:16 2010 +0200

    Make "topology subnet" work on Solaris (ifconfig + route metric
changes by Kazuyoshi Aizawa, adding of local "connected subnet" route by me)

    Tested on OpenSolaris/i386, no impact for other TARGETs.

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: Kazuyoshi Aizawa <admin2@...628...>
    Signed-off-by: David Sommerseth <dazo@...384...>

commit 121755c2cb4891f8963ebcab5d61bc09dadf457c
Author: Gert Doering <gert@...1296...>
Date:   Fri Oct 29 17:41:53 2010 +0200

    Integrate support for TAP mode on Solaris, written by Kazuyoshi
Aizawa <admin2@...628...>.

    See also http://www.whiteboard.ne.jp/~admin2/tuntap/

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: Kazuyoshi Aizawa <admin2@...628...>
    Signed-off-by: David Sommerseth <dazo@...384...>



kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkzdqi4ACgkQDC186MBRfro69gCfUjWlWdqfnZ1KOfmOOztw2pmz
WQEAoLGENi88dlUjeZpLi2L0BcGCR15u
=+mN9
-----END PGP SIGNATURE-----

