From: "Dave" <dev@...575...>
Date: Sat, 27 Sep 2008 10:59:22 -0500
Message-ID: <8610CCA6A30F43DD8EA2002E9C6F1BAD@...576...>
MIME-Version: 1.0
In-Reply-To: <750B64C66078B34D918257A1AC004DB2054440@...1132...>
Subject: Re: [Openvpn-devel] [PATCH v4] Use CryptoAPI CA store (was
	Re:[PATCH v3] Use CryptoAPI CA store)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "'Jason R. Coombs'" <jaraco@...1130...>, 'Alon Bar-Lev' <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

...
> Alon,
> 	I've started working on (1) and (2).  Attached is the=20
> updated cryptoapi.c.  Would you prefer a patch when changes=20
> involve a single file?  Can you tell me what you think (is=20
...
> 	As for (3), where is the SSL role defined?  Or,=20
> alternatively, what is the procedure when cryptoapi isn't=20
> used to verify the certificate is in the correct role?
...
> Jason
...

Oh, Happy Day!  Now I don't have to do it.  I've wanted this for some time,
and forgot that someone had already started working on it a year ago.

The ssl server role is controlled by the options --tls-server and
--tls-client (these are also set internally by the various 'helper' macros
like --client and --server).  So, if you have the 'options' object, then the
member

    options->tls_server

will indicate if you are in server mode.  It is only used in an interesting
way in ssl.c, as far as I can see.  There is also a --tls-client, but I
don't see it being used in an interesting way anyway.  (Interesting =3D=3D
something other than setting the value or printing output).


As far as dynamically loading the crypto api dll; the comments state this is
a hack to work around MingW's incompleteness?  Implying that -- barring
incompleteness -- the dll would have otherwise been loaded implicitly?  If
so then I would suggest loading it on application startup and unloading on
shutdown.  This is analogous to things like 'WSAStartup' and 'OleInit'.  On
the other hand, the 'load' function looks idempotent, so it can be called
safely as many times as you like.  Just make sure to call it before you need
it.  Also, it is not strictly necessary to call 'unload' unless you are
really wanting to truly unload for some technical reason, or just like to be
tidy like that.  The OS will happily 'unload' it upon process shutdown.

I can't comment on 'code cleanup' because that is subjective.

-Dave


