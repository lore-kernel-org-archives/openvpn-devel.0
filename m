MIME-Version: 1.0
In-Reply-To: <4F797A66.8050502@...1114...>
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
	<CAOazyz0MDBg75y+CRdYNEOdYBE83B_pYfZ3pz+JLyUdAyF6xgQ@...278...>
	<CAP+U6tK3UHd=KR1th0vxdLnRUsZm47qKgk=BeNgzSmvYUFMdvw@...278...>
	<4F797A66.8050502@...1114...>
Date: Mon, 2 Apr 2012 13:25:43 +0300
Message-ID: <CAOazyz0uhi_ao2SN3Moi+tXRVhaJPd-O1eam0tqLo_6rehVREg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/6] Added support for new PolarSSL 1.1
	RNG
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

No no no....
I did not imply that this will be dynamic interface.
Nor that there is a use case.

The current state of the code (even before the merge of polarssl) was
very complex.
Now it is even more complex, with none clean/strict separation between
the common crypto code and the library specific crypto code... Yes, I
know these resides in different sources, but it is more similar to
what we call "spaghetti" programming.

What I suggest of doing is to create static callback structure which
is the interface of crypto library used by openvpn. This is *STATIC*
linkage.

For example:
typedef struct {
    result_t
    (*x509_get_username) (char *cn, int cn_len,
    char *x509_username_field, x509_cert *cert)
   ...
} openvpn_crypto_enigne_t;

I guess you understand how this struct will look like.

Now, a nice side effect would be the ability to have both libraries
linked against openvpn, while choosing the engine at configuration...
Of course there is no real world use for this, except for build (one
build checks both libraries) and test (we can use test one build for
both).

The main mission is to clean up the code, reducing the complexity,
making sure we can follow each crypto call to either common,
crypto-library-atom, or openvpn specific.

Is that more clear?

Alon.

On Mon, Apr 2, 2012 at 1:07 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 02/04/12 11:55, Fabian Knittel wrote:
>
>
> The only advantage I see at runtime switching, is that it's easier for
> distributors to support both SSL/crypto library platforms. =C2=A0Except of
> that, I don't see much benefits of it.
>
> And f.ex. in the use case of OpenVPN-NL, I doubt this will be
> considered interesting at all, as they do static linking against the
> SSL/crypt libraries - to ensure that the libraries Fox-IT have
> reviewed and certified for governmental usage are used, and not a
> potentially compromised or weakened third-party library.
>
> To be very honest, I don't think it's worth the effort of adding
> dynamic loading of SSL/crypto libraries at run time. =C2=A0Having it at
> compile-time provides the needed flexibility. =C2=A0Yes, distribution can
> benefit from it, but is that burden so big we need to modify OpenVPN
> for it? =C2=A0Let's rather stay cool now and rather discuss and consider
> such a move for OpenVPN 2.4. =C2=A0Then we will know more what distributo=
rs
> thing about it.
>
>
> kind regards,
>
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk95elsACgkQDC186MBRfrpVfACdEJgl6vYDeGH3DxL1foYET118
> u5gAn2mA6Zy5TIhtqYnV8qCP2XTJiyyr
> =3DK25q
> -----END PGP SIGNATURE-----

