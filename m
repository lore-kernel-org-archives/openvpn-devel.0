Message-ID: <4D34BF3E.4000108@...68...>
Date: Mon, 17 Jan 2011 23:14:22 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <20110117213043.GH12114@...1296...> <4D34B911.6000700@...68...>
	<20110117220032.GJ12114@...1296...>
In-Reply-To: <20110117220032.GJ12114@...1296...>
Subject: Re: [Openvpn-devel] configure not finding lzo (Solaris, NetBSD)
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
To: openvpn-devel@lists.sourceforge.net

Am 17.01.2011 23:00, schrieb Gert Doering:
> Yes, if building from pkgsrc, the caller takes care to make sure 
> "everything works".
> 
> It's just if I grab the tarball and run "configure" that it doesn't find
> lzo - even if it's in "the standard place for that OS".

That's because NetBSD and FreeBSD for instance don't include /usr/local in their
system compilers' default paths.  Not OpenVPN's fault.  Sure you can script
around that but it's never complete (there's always one more system with one
more installation location that we won't cover) and gets ugly quite quickly.
Look at how fetchmail tries to hunt down the various Kerberos, GSSAPI, SSL
libraries, their individual dependencies and inter-dependencies and everything.
It's a mess.  pkg-config could help here, but ISTR that LZO doesn't install a
.pc file.

Possibly check the autoconf macro archives if they have a lzo helper .m4 file,
point me to it and I may have another look.

>> Unless you install from Blastware, or Sunfreeware, or Pkgsrc, or OpenPKG, or...
>> (you name it) -- each with its own default directories.
> 
> Yeah, sure.  But especially /usr/local/<stuff> seems to be something
> that normally "just works" (being $prefix/<stuff> by default), but 
> doesn't seem to in OpenVPN

It just works on Linux AFAIR, but not the BSDs I've tried.  Check the compiler's
default include and library paths...

>> Until that time, passing CPPFLAGS and LDFLAGS on the ./configure command line
>> like ./configure CPPFLAGS=-I/usr/local/include LDFLAGS=-L/usr/local/lib would do
>> the trick.
> 
> Well, I know how to do that, of course :-) - there's even
> "--with-lzo-header=..." and "--with-lzo-lib=..." - but I still wonder if
> life shouldn't be easier for the 95%-case on a given distribution.

The 95% case on a given distribution is that the distributor packages OpenVPN
and the user doesn't care beyond that point.

> "If other packages can get this automatically, why do we need switches
> for OpenVPN"?

Document that and be done.  It helps the user much more than convenience hacks.

-- 
Matthias Andree

