From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] [PATCH]: small tweaks to beta16
In-Reply-To: <20041117235828.GA27761@...33...>
Message-ID: <Pine.LNX.4.58.0411180429160.6079@...41...>
References: <41935EF5.4070907@...292...> <Pine.LNX.4.58.0411110700410.7012@...41...>
 <20041117235828.GA27761@...33...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Nov 18 03:35:04 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Matthias Andree <matthias.andree@...68...>
Cc: Peter 'Luna' Runestig <peter+openvpn@...292...>, openvpn-devel@lists.sourceforge.net

On Thu, 18 Nov 2004, Matthias Andree wrote:

> On Thu, 11 Nov 2004, James Yonan wrote:
> 
> > On Thu, 11 Nov 2004, Peter 'Luna' Runestig wrote:
> > 
> > > --- openvpn-2.0_beta16.orig/makefile.w32	2004-11-07 10:27:36.000000000 +0100
> > > +++ openvpn-2.0_beta16/makefile.w32	2004-11-10 22:27:42.796479300 +0100
> > > @@ -50,7 +50,7 @@
> > > 
> > >  LIBS_DMALLOC = ${LIBS} -ldmalloc
> > > 
> > > -LIB_DIRS = -L${OPENSSL}/out -L${LZO}/src/.libs
> > > +LIB_DIRS = -L${OPENSSL}/out -L${LZO}
> > > 
> > >  LIB_DIRS_DMALLOC = ${LIB_DIRS} -L${DMALLOC}
> > > 
> > > 
> > > I'm using lzo-1.08, and the "liblzo.a" file was created in the
> > > base directory there, and the "src/.libs" subdir doesn't even
> > > exist. Or is it just me?
> > 
> > That's strange because when I build lzo-1.08, it puts the .a file in 
> > src/.libs.
> 
> The software that builds the LZO archive and shared library (liblzo.a
> and .so) in src/.libs is libtool, and libtool should then be used to
> either _install_ or _link_ against the LZO library. (Libtool stores
> information that describes the .a and .so files in its .la files.)
> 
> Is libtool used for Windows builds?

Right now the Windows build is statically linking with the LZO lib, just 
as is specified in the makefile.w32.  libtool is used to make the library, 
but not to link against it.  Is there a problem with this?

James


