Message-ID: <4D1CBCA8.4050203@...1114...>
Date: Thu, 30 Dec 2010 18:08:56 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4D177C14.4040300@...1030...> <4D1CAE99.4050406@...68...>
In-Reply-To: <4D1CAE99.4050406@...68...>
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
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 30/12/10 17:08, Matthias Andree wrote:
| Am 26.12.2010 18:32, schrieb Mr Dash Four:
[...snip...]
|>
|> To prevent that I am enclosing a patch, which although fixes this
|> problem I am of the opinion that it could be optimised further to
|> co-exist with the rest of the build system and be auto-generated, though
|> I will leave that with the developers to decide what is the best way to
|> proceed and fix this bug.
|
| I think it would be good to integrate this with automake if the whole setup is
| to be integrated and these plugins are supposed to be built more or less
officially.

That's a very good point!  And I think this makes even more sense.

| I can take a stab at it if desired, drop me a note with a Cc: to my personal
| address.  If desired, I can also look at libtool although I have no relevant
| experience with that yet, but I do have substantial experience with
| autoconf/automake.

If you have time and are willing to do so, that would be great!  I see most
Linux distroes installs these plug-ins under /usr/lib{,64}/openvpn/plugin/ ...
depending on 32/64 bit arch.  So if we could even get some of these plug-ins
installed there, that would probably ease the packaging for most distroes.

Currently only auth-pam and down-root are the ones being interesting, IMHO.
The defer plug-in is yet another example (and could probably be moved into
examples/), and the plug-ins in examples/ are less useful in a production
environment as well.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0cvKgACgkQDC186MBRfrobVQCeNe4F7bHmmHilW3bqSAuOoUUk
x28AnjhHzSGKFJwptLNp9A8GypyPBEWA
=89bY
-----END PGP SIGNATURE-----

