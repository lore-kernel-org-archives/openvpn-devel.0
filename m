Message-ID: <4BD61B96.3050005@...1114...>
Date: Tue, 27 Apr 2010 01:02:46 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1272309086.19417.1@...1207...>
In-Reply-To: <1272309086.19417.1@...1207...>
Subject: Re: [Openvpn-devel] Unpackaged Windows binaries (Was: Re:
 [Openvpn-users] [ANN] OS X packages - OpenVPN 2.1.1)
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net, Peter Stuge <peter@...1287...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26/04/10 21:11, Karl O. Pinc wrote:
> On 04/26/2010 11:53:19 AM, Peter Stuge wrote:
>> Karl O. Pinc wrote:
[...snip...]
> IMO people who don't rely on their distro for systems integration
> and security patches are asking for trouble.  There are of course
> always reasons to make specific exceptions, RH comes to mind. :)
> 
> Is OpenVPN in RHEL6?)

Yes, I'm pretty sure it is.  RHEL5 even shipped OpenVPN 2.1_rc15 for a
long time as a stable release until OpenVPN released 2.1.1.  In
RHEL5.4/CentOS5.4, I'm pretty sure 2.1.1 is standard by now.

Those releases are also pretty much in sync with the upstream OpenVPN
release.  No extra security fixes which is not in OpenVPN - as it should
be, IMHO.  From what I've seen in the Fedora builds, it's mostly
distro-specific adjustments added on top of the OpenVPN 2.1.1 tarball.

But I agree that using a distro-based installation, gives you the
upgrades in a very convenient way.  Automatically - and you get a
reminder regularly.

>>> and it now talking about doing the same for OS/X binaries.
>>
>> Recently discussed work for contrib/ produces a .dmg, very much a
>> package in my view.
> 
> Ok.  I don't know much about .dmg.  I thought they were basically
> tarballs by another name in that they just stick stuff somewhere.
> My Mac usage is sporadic, sorry.
>
>>
>>> There's clear utility.
>>
>> I guess it depends. I'm not sure that I agree that compilation is a
>> much bigger bother than (cross-)compiling the NSIS installer..
> 
> On Debian all I had to do was "aptitude install nsis" and then
> run it to make MS Windows installers.  Plug and play, no 
> compiling necessary.
> 

Just a little nitpick, when you run makensis, that's actually
compilation of the installer - even when you're doing it on Linux.  You
get a Windows binary as the result.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvWG5YACgkQDC186MBRfro2bQCfX3H740h3QErt8+fzPlwVNekk
btIAn3RMwwuLQCfrrfe29SSW46nZP9Tp
=XOWD
-----END PGP SIGNATURE-----

