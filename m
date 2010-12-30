Message-ID: <4D1CA723.8060001@...1114...>
Date: Thu, 30 Dec 2010 16:37:07 +0100
From: David Sommerseth <openvpn.list@...1114...>
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
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Mr Dash Four <mr.dash.four@...1030...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26/12/10 18:32, Mr Dash Four wrote:
| Due to the fact that I have spent the last two and a half hours trying
| to find a place where to submit a bug report via the Trac system
| (https://community.openvpn.net/openvpn) - and failing, miserably so - I
| am submitting it here!
|
| In this version of OpenVPN, the Makefiles for the above plugins contain
| hard-coded compile/link parameters, which prevent cross compilation.
|
| For example, during building openvpn-down-root.so the value of the c/c++
| compiler is assumed to be gcc, along with various other settings (CLFAGS
| being set as "-O2 and -Wall" and LDFLAGS as "-shared -Wl,-soname"),
| disregarding the rest, therefore ruining any possibility of cross
| compilation as the file produced will have the same attributes as the
| build system!
|
| If I build OpenVPN on x86_64-based machine to be executed on i686 the
| two Makefiles will produce code for x86_64, despite the openvpn
| executable being produced, correctly, for the i686 host system. Thus,
| the produced 'package' will introduce at least 2 additional - and highly
| undesired - dependencies, namely: glibc (x86_64) and libpam (x86_64).
|
| To prevent that I am enclosing a patch, which although fixes this
| problem I am of the opinion that it could be optimised further to
| co-exist with the rest of the build system and be auto-generated, though
| I will leave that with the developers to decide what is the best way to
| proceed and fix this bug.

Thank you very much for your patch!  This seems reasonable and I am almost
giving it an ACK immediately.  There are just a one thing I am less convinced
about.

Your patch removes -Wall completely.  I am really not sure that's a good
practice.  I see no harm of compiling with -Wall or other warnings enabled by
default.  In fact, that might help discover issues otherwise not seen.  AFAIK,
- -Wall should not cause any cross-compilation issues.

So, I'd prefer that you don't remove CFLAGS completely, but rather append the
build platform CFLAGS with -Wall.  So you can then do it like this:

~  CLFAGS="$(CFLAGS) -Wall -DDLOPEN_PAM=$(DLOPEN_PAM)"

This will be a smaller and easier patch, which will provide the features
you're looking for.  Removing -O2 is less of an issue as that one should more
be defined by the build platform, and that one can cause more issues with
cross-compilation.

Unfortunately this patch is arriving too late to get accepted for the OpenVPN
2.2 release we're putting together nowadays, but we will be able to get an
adjusted patch into the development tree for the next version.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0cpyMACgkQDC186MBRfrqYLACcCO51oYXUJ4QsnsMQlwfq9At+
cp8AnAyDZEk2lDjnSLJ02B/yi2f/W1B/
=cVLV
-----END PGP SIGNATURE-----

