Message-ID: <553E4C46.8050809@...1114...>
Date: Mon, 27 Apr 2015 16:48:38 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1429036445-17223-1-git-send-email-yegorslists@...1030...>	<552E1111.6010201@...68...>
	<20150415120704.GI382@...1296...>
In-Reply-To: <20150415120704.GI382@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] m4: enable silent build
Reply-To: openvpn-devel@lists.sourceforge.net
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
To: Yegor Yefremov <yegorslists@...1030...>
Cc: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 15/04/15 14:07, Gert Doering wrote:
> Hi,
> 
> On Wed, Apr 15, 2015 at 09:19:45AM +0200, Matthias Andree wrote:
>> - it changes policy through the [yes] argument to
>> AM_SILENT_RULES(). This flips the switch for the default without
>> good reason, and that makes debugging harder - this is a policy
>> decision, not mechanism.
> 
> Indeed, this we don't want.
> 
> Having "V=0" or "--enable-silent-rules" is fine for me, but
> changing the defaults to hide even more detail is not (annoying
> enough that recent autoconfs hide the detailed results from "make
> test")

Just tested a ./configure (used automake 1.13.4 on RHEL7) with
- --enable-silent-rules.  That worked like a charm out-of-the-box
without any patching.

I do understand people wanting less output when compiling (which has
been a Linux kernel compile feature for a very long time too, and many
other projects as well).  And I don't think that we loose that much
information building it this way.  In fact we can actually more easily
see compiler warnings - which I would say is a good thing.  If you
need the full compile command line, it is available using 'V=1'.

But I don't think we should make this behaviour the default yet, and
at least not if that require dependencies to specific automake
versions, especially when we know that RHEL5 (the oldest supported
distro) runs a far older automake.  I think it is best if the default
behaviour is consistent across all distributions.

Having this said, if you do builds on systems with a more modern
automake, I do want to encourage people to run 'make V=0' or use
./configure --enable-silent-rules.  This will ensure we can capture
compiler warnings far easier.  For now I do consider this fine, as you
do this explicitly - a different behaviour should be expected when
using explicit options.

When the oldest distro we need to support have a modern enough
automake, we should revisit this topic of making the 'silent rules'
the default behaviour - being consistent across all distros.


- -- 
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlU+TEYACgkQDC186MBRfroooACgrl7YapqCtq4NbtNAGRogEHpn
2zUAnRnyLDgDVMYzXF5DCXEy/ds583yL
=QNhv
-----END PGP SIGNATURE-----

