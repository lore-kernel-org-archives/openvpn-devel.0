Message-ID: <4D264928.3010701@...68...>
Date: Thu, 06 Jan 2011 23:58:48 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <jb2PkGhmqClC.rQXy2JmT@...1444...>
	<4D260407.9090004@...1030...> <4D260739.1030201@...68...>
	<4D262940.5020104@...1030...> <4D262C21.6080905@...68...>
	<4D263D2C.2090708@...1030...>
In-Reply-To: <4D263D2C.2090708@...1030...>
Subject: Re: [Openvpn-devel] bugfix2.1: automake support for plugin build
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
To: Mr Dash Four <mr.dash.four@...1030...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 06.01.2011 23:07, schrieb Mr Dash Four:
> 
>> This has gone wrong.  The plugins should be built from the top-level
>> directory instead (see below how it works for me), with the regular
>> "make" that also builds openvpn, so the "for plugin in ... make -C
>> $plugin ..." is no longer needed for these two guys.
>>
>> "make install" should load the material where it belongs, namely into
>> libdir/packagename, i. e. /usr[/local]/lib/openvpn/*.so
>>
>> But I should possibly remove the Makefiles that are no longer needed.
>>
>> My log excerpt is given below.
>>   
> So, should I remove the for loop then? Would that be enough?

If the patch is applied, the libtoolize tool has populated m4/* and you've
regenerated the aclocal.m4 with aclocal, the configure and Makefile.in, then it
should suffice, yes.

> I don't know if it is clear to you, but I am not building OpenVPN to 
> install it on a local machine - I am doing cross-compilation build to 
> end up with rpm, which is for a different architecture to be installed 
> on a completely different machine (my build machine is x86_64, host 
> machine is i686).

That's what I understood, however this is an easy case as most x86_64 build
systems I know can support i686 executables if the necessary libraries are
installed, and I found this particular situation (build for i686 on x86_64) to
be particularly convenient on Fedora.

> So, I am not using ./configure, make and then make install in a sense - 
> I am running "rpmbuild -bb" (which in itself runs configure and make) 
> with a custom-designed openvpn.spec file - this is also where I apply 
> your patches.

I think you could. ./configure CC="gcc -m32" would normally do, but I haven't
gotten around to test drive things on F14.

Well, for patch testing that's the thing.  For the next releases, we'll have to
wait what James, David, Samuli decide.

HTH

Best regards

-- 
Matthias Andree

