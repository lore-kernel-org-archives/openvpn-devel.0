From: "Doncho N. Gunchev" <mr700@...184...>
Reply-To: mr700@...184...
Subject: Re: [Openvpn-devel] compiling statically - how?
References: <411111B9.2000405@...259...> <twig.1091682930.49808@...41...>
In-Reply-To: <twig.1091682930.49808@...41...>
MIME-Version: 1.0
Message-Id: <200408122031.28230@...187...>
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
Date: Thu Aug 12 10:32:19 2004
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thursday 05 August 2004 08:15, James Yonan wrote:
> Matthias Andree <matthias.andree@...68...> said:
> 
> > On Wed, 04 Aug 2004, Tomasz Chmielewski wrote:
> > 
> > > I was thinking of an option like ./configure --compile-statically - and 
> > > with such compiled binary, I wouldn't have to install compilers, compile 
> > > OpenVPN, deinstall compilers on every machine I want it to run.
> > 
> > My first attempt would probably be ./configure CC="gcc -static" - it's
> > untested and may require the installation of static libraries on some
> > systems.
> 
> I've had success with 'gcc -static' when static libraries are present, as they
> are by default on Gentoo Linux.
> 
> James
> 
    I compiled it statically on FC3t1 with this change in the openvpn.spec file:
--- cut ---
%configure \
        --enable-lzo \
        --enable-crypto \
        --enable-ssl \
        --enable-pthread \
        --enable-iproute2 \
        --enable-strict \
        --disable-profiling \
        --enable-mtu-dynamic \
        --enable-strict-options \
        --disable-dependency-tracking

# <Hack_for_static_build>
perl -i -p -e 's/^LDADD =/LDADD = -static -lssl -lcrypto -lkrb5 -lk5crypto -lresolv -lcom_err/' Makef
ile
# </Hack_for_static_build>
%{__make} %{?_smp_mflags}
--- cut ---
    It worked (openvpn --test-crypto --secret mysecret) on FC3t1, FC2, FC1 and Mandrake 8.2.

-- 
Regards,
  Doncho N. Gunchev    Registered Linux User #291323 at counter.li.org
  GPG-Key-ID: 1024D/DA454F79                        http://pgp.mit.edu
  Key fingerprint = 684F 688B C508 C609 0371  5E0F A089 CB15 DA45 4F79

