Message-ID: <5006B987.2060305@...1114...>
Date: Wed, 18 Jul 2012 15:26:31 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAEsd45Rh9zu=FC_Qdt4KiUfGayMqRzshF4OpxsHcszVH+8vBHw@...278...>
	<CAOazyz1+Px-wFYd3DVdm-1Sxponr0xsp2w4m8Mum+HTDyMtovg@...278...>
	<CAEsd45R3Or3izDGLamLOoft=xSNBNH8Qq8ztWb+N5Um4nitdJg@...278...>
In-Reply-To: <CAEsd45R3Or3izDGLamLOoft=xSNBNH8Qq8ztWb+N5Um4nitdJg@...278...>
Subject: Re: [Openvpn-devel] New build system questions
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
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/07/12 15:00, Jonathan K. Bullard wrote:
> On Mon, Jul 16, 2012 at 12:45 PM, Alon Bar-Lev
> <alon.barlev@...277...> wrote:
>> (3) I want to build "compat" as a static library. How can I do
>> that? <snip> You don't need the above... just add
>> LDFLAGS="-static", I guess.
> 
> That doesn't work -- it doesn't make compat static. I still get the
> same "Warning: Linking the shared library libcompat.la" message,
> and no libcompat.a is produced.

Which compiler tool chain are you using?  And do you have a recent
enough libtool installed?

> I've fiddled around and haven't been able to get it to build as
> static, so I'll just move compat/*.* into src/openvpn and not have
> a compat library at all. compat seems to be needed only by openvpn
> and openvpnserv, apparently, but not by the down-root plugin. Since
> I'm not using openvpnserv, I don't need it as a separate library.

Okay, here's some confusion about the libcompat.a ... It built as a
static library (hence the .a).  But the linker will extract the needed
bits and pieces from those static libraries when it bundles and
prepares the final openvpn executable.  It even means the linker will
only extract the functions needed, even if one of the source files
contains many other functions as well.

This is pure linker magic, and should end up with exactly the same
result as you're doing by copying C files into src/openvpn and such.
In fact, libcompat.a is statically linked also when not compiling as
static.

So I would expect this to be related to the compiler tool chain,
especially since this works on our buildslaves - which builds on
several Linux distros, FreeBSD, OpenBSD, NetBSD and some Solaris
flavour.  But I presume the common thing on these boxes are that
they're using the GNU GCC compiler chain with GNU libtool.

>> To compile static, you need to build openvpn without plugins 
>> (--disable-plugins) and all dependencies such as openssl the
>> same.
> 
> This seems like an unnecessary restriction and breaks what can be
> done now. The plugins should always be dynamic, but there is no
> reason I shouldn't be able to static-link OpenVPN with OpenSSL and
> LZO. I do that now, and OpenVPN builds with plugin support. Then I
> build the plugin separately. It all works.

Agreed, this sounds like a feature regression.

Dynamic loading requires dlopen() and such (provided by libdl) and
when compiled non-static, all this dlopen() stuff happens
automatically, as the linker have instructed the binary what to load
and which symbols to prepare for.

However, when building statically, I presume you need to explicit link
in libdl, to get those support functions - all the symbol lookup
anyway needs to be tackled by the application.  But static builds
should not exclude the plug-in feature.

> (I had been hoping to be able to use something like 
> xxx_LIBTOOLSFLAGS="-static" for libraries I want to be static,
> letting the other(s) default to shared. That way one build would
> generate an OpenVPN binary with everything statically linked into
> it and a down-root plugin as a shared library. That's was my goal
> until another comment mentioned that pkcs11-helper can't be static.
> It's been static for years in Tunnelblick, but that's a whole other
> issue that I will have to address.)

Alon is deeply involved in the pkcs11-helper, so I trust his knowledge
here.

> All this plugin stuff is moot if plugin paths can no longer be
> absolute paths, so I'll wait and if that ends up being the case
> (and it looks like it will), I will drop plugin support from
> Tunnelblick.

There are quite some ways how this can be abused to run code with
escalated privileges.  I see you've replied to Alon's patch [1] where
we're looking into tightening this further, so I will respond to
potential issues there

> However, the same problem apparently exists for pkcs11-helper -- it
> must be shared. So I may drop support for that in Tunnelblick as
> well, although I'll probably leave it in for earlier versions of
> OpenVPN. (Tunnelblick contains multiple versions of OpenVPN and
> lets the user select which one to use.)

Is there a reason you cannot package and ship pkcs11-helper as part of
OpenVPN?


kind regards,

David Sommerseth




[1] <http://thread.gmane.org/gmane.network.openvpn.devel/6801>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAGuYUACgkQDC186MBRfrp4NgCdHn77A3WVfK74WEXXbXAtecTM
7OEAn2H4/c2Jodqao+0jt+MxOvo5hswN
=ibZB
-----END PGP SIGNATURE-----

