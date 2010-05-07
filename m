Message-ID: <4BE3DDE5.2000205@...1114...>
Date: Fri, 07 May 2010 11:31:17 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BE303D1.5070902@...1270...>
In-Reply-To: <4BE303D1.5070902@...1270...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig534F868CFD11B603C90F635D"
Subject: Re: [Openvpn-devel] [Openvpn-users] Assertion failed at ping.c:81
Reply-To: Openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Yevgeny Kosarzhevsky <yevg@...1270...>
Cc: Openvpn-devel@lists.sourceforge.net, openvpn-users List <openvpn-users@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig534F868CFD11B603C90F635D
Content-Type: multipart/mixed; boundary="------------070309050700000100040108"

This is a multi-part message in MIME format.
--------------070309050700000100040108
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 06/05/10 20:00, Yevgeny Kosarzhevsky wrote:
> Hi,
>=20
> I get the following issue here which I don't know how to address.=20
> Removing 'no-reply' 'no-iv' 'auth none' 'cipher none' solves that.
>=20
> Server.log:
[...snip...]

Moving this one over to the development list.

You have indeed found a bug here.  I've dug a little bit into it, and
I've attached your slightly modified config files with example
certificates and keys for others who want to dig into this as well.
(password for client certficate is: 1234)

To use the config files, extract them into a temporary directory and run
in two different terminals:

   $ sudo openvpn --config server.conf
   $ sudo openvpn --config client.conf



What I've found out ... I added this simple debug code just before the
assertion happens:

static void debug_buf_safe (const struct buffer *buf, int len)
{
  printf("---> %ld :: %ld :: %ld :: %ld <=3D %ld\n",
	 buf->offset,
	 buf->len,
	 len,
	 buf->offset + buf->len + len,
	 buf->capacity);
}

This is called from ping.c:81 as

  debug_buf_safe(&c->c2.buf, MAX_RW_SIZE_TUN (&c->c2.frame));

When this code path is hit, I get this result:

---> 44 :: 0 :: 1532 :: 1576 <=3D 1574

So something goes wrong when buf is prepared.  For comparison, I removed
"auth none", "cipher none" and "no-iv" from both config files.  And it
does indeed not cause an assertion in this case.  The debug line then shows:

---> 80 :: 0 :: 1532 :: 1612 <=3D 1646

It is buf_safe() (buffer.h:353) which returns false which causes the
assertion.  This is due to buf->capacity being smaller when no
encryption is not used.  It is only buf->offset and buf->capacity which
are different in situations with and without encryption enabled.

I have not investigated why buf->capacity is too low in this situation.
 But this was intended to give some lead clues on where things fail.
Unless someone is quicker than me to dig up the real cause of this
error, I'll dig further in the weekend.


kind regards,

David Sommerseth

--------------070309050700000100040108
Content-Type: application/x-gzip;
 name="assert-bug-config.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="assert-bug-config.tar.gz"

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
--------------070309050700000100040108--

--------------enig534F868CFD11B603C90F635D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvj3ecACgkQDC186MBRfrpmlQCfZVNf4YXXaIMV1/EMBFjKQUrZ
fLIAninhgpC3aKW/4aqXdWmvsnD1SDSm
=oS1h
-----END PGP SIGNATURE-----

--------------enig534F868CFD11B603C90F635D--

