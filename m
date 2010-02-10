Message-ID: <4B728FDE.1080200@...1114...>
Date: Wed, 10 Feb 2010 11:52:14 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20100209132645.GX9430@...1302...>
	<20100210091020.GA3373@...1276...>
In-Reply-To: <20100210091020.GA3373@...1276...>
Subject: Re: [Openvpn-devel] Openvpn on Symbian?
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
To: Till Maas <opensource@...519...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/02/10 10:10, Till Maas wrote:
> On Tue, Feb 09, 2010 at 02:26:45PM +0100, Ruben Puettmann wrote:
> 
>> I will ask you if there is any work in progress porting openvpn to
>> symbian os. Since 4.Feb 2010 the source code from is free available see
>> http://www.symbian.org. It would be very nice to see openvpn on my E71
>> running.
> 
> Do you know for sure, that the source code for the symbian OS on an E71
> is released? When I swept over the site, it looked like only the new
> symbian ^3 or similiar was released. But there was no clear information,
> whether it is now possible to compile symbian locally and install it on
> an E71.

You are right, it's the Symbian^3 which has been open sourced.  Even
though, with that source available it is still possible to better
understand the platform, also for the pre-Symbian^3 releases.  But of
course, there are differences.

In regards to building and installing, I found these references.  TBH,
I'm not a Symbian user, and don't have too much interest in the core
details here (but I do pay attention to the general things that's
happening) - so my findings might not be accurate.

<http://developer.symbian.org/wiki/index.php/Foundation_Builds_Quick_Start>

<http://developer.symbian.org/wiki/index.php/Platform_Opening/FAQ#How_do_I_build_the_platform.3F__What_else_must_I_do.3F>

<http://developer.symbian.org/wiki/index.php/Platform_Opening/FAQ#Can_I_reprogram_my_existing_phone_with_Symbian.5E3.3F>

<http://developer.symbian.org/wiki/index.php/Platform_Opening/FAQ#Development_Q.26As>


I hope this gave a little bit clearer answers.

When it comes to the need for a tun/tap device: I believe that this will
be easier to implement, also on the older Symbian versions.  The
Symbian^2 and earlier vs Symbian^3 are gradual upgrades.  Some tweaking
will most probably be needed.  But the general framework around it is
most probably quite close to Symbian^3.  Now it's up to the guys deeply
understands the tun/tap drivers and networking in kernel space to catch
the ball and bring it further.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEUEARECAAYFAktyj9UACgkQDC186MBRfrrRAwCdEzZY6E7MLRAhKL0HbN28i93e
ubUAlitj/c299V7yleW65o+Ro94haLw=
=la09
-----END PGP SIGNATURE-----

