Message-ID: <4D1CAE99.4050406@...68...>
Date: Thu, 30 Dec 2010 17:08:57 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <4D177C14.4040300@...1030...>
In-Reply-To: <4D177C14.4040300@...1030...>
Subject: Re: [Openvpn-devel] [OpenVPN 2.1.4 BUG]: hard-coded values in
 Makefiles for down-root and auth-pam plugins prevent cross compilation
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
Cc: David Sommerseth <dazo@...384...>

Am 26.12.2010 18:32, schrieb Mr Dash Four:
> Due to the fact that I have spent the last two and a half hours trying 
> to find a place where to submit a bug report via the Trac system 
> (https://community.openvpn.net/openvpn) - and failing, miserably so - I 
> am submitting it here!
> 
> In this version of OpenVPN, the Makefiles for the above plugins contain 
> hard-coded compile/link parameters, which prevent cross compilation.
> 
> For example, during building openvpn-down-root.so the value of the c/c++ 
> compiler is assumed to be gcc, along with various other settings (CLFAGS 
> being set as "-O2 and -Wall" and LDFLAGS as "-shared -Wl,-soname"), 
> disregarding the rest, therefore ruining any possibility of cross 
> compilation as the file produced will have the same attributes as the 
> build system!
> 
> If I build OpenVPN on x86_64-based machine to be executed on i686 the 
> two Makefiles will produce code for x86_64, despite the openvpn 
> executable being produced, correctly, for the i686 host system. Thus, 
> the produced 'package' will introduce at least 2 additional - and highly 
> undesired - dependencies, namely: glibc (x86_64) and libpam (x86_64).
> 
> To prevent that I am enclosing a patch, which although fixes this 
> problem I am of the opinion that it could be optimised further to 
> co-exist with the rest of the build system and be auto-generated, though 
> I will leave that with the developers to decide what is the best way to 
> proceed and fix this bug.

I think it would be good to integrate this with automake if the whole setup is
to be integrated and these plugins are supposed to be built more or less officially.

I can take a stab at it if desired, drop me a note with a Cc: to my personal
address.  If desired, I can also look at libtool although I have no relevant
experience with that yet, but I do have substantial experience with
autoconf/automake.

Best
Matthias

