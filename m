MIME-version: 1.0
Date: Thu, 12 Nov 2009 12:51:08 +0100
From: Till Maas <opensource@...519...>
Message-id: <20091112115108.GA5230@...1276...>
References: <20091110161632.GA31301@...1276...>
	<4AFA789B.4070607@...1114...>
	<20091111102515.GA19782@...1066...>
	<4AFA9AA7.4030600@...260...> <4AFAAD5C.4070303@...1114...>
Content-type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary=pf9I7BMVVzbSWLtt
Content-disposition: inline
In-reply-to: <4AFAAD5C.4070303@...1114...>
Subject: Re: [Openvpn-devel] Script interface to trigger events depending	on
 the validity of a certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 11, 2009 at 01:26:04PM +0100, David Sommerseth wrote:

> 1) The certificate is first dumped to file.  Would it be possible to
> pass it only via environment table, to avoid the file stage?  The reason
> for this is primarily security (not to write more to disk than what you
> really need on disk), and secondarily - SELinux - avoiding writing data
> to disk you are more sure that SELinux or other MACs will not interfere
> and deny the write requests.  This is especially crucial if OpenVPN is
> run in as a contained user (which most daemons really do)

As far as I understand the tls-verify option, the script will be run
once for every certificate in the chain. Therefore just passing the
cert to stdin of the script should be a feasible solution.

> 2) If an attacker sends a certificate with his certificate and 999 CA
> certificates in a chain, what will happen?  What happens if the disk
> goes full or the certificate cannot be written?

According to the manpage, the tls-verify script won't be executed,
because the attacker already need to have passed all other verifications
steps except the check against the CRL list.

Regards
Till

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAEBCgAGBQJK+/anAAoJEGo6ELMcEJUX2y4P/R08OMSXM0Sm43pgltB33aT/
m7Va0Fo7+42wqixLJE+oOXjAiVaIdmfccqskhSlTtmVZJui13LE8AY3YDYm6kAZ8
doYAcBj/k46ocOjrWUIoMSd8M76ev1a/3It2jjeH9RCFeC1YxQlYr64gSBC2eqSK
ur+VMQPKxW1tqXNPXz+LtfPYBvd8gCabs+m9lFrpLzQXp+412yzK+LMVdwnIIbA3
yaX17jnUHd9WPf/0rE1uXKgqC1RtyLY/z5024tBx+8ikgzzpmY9IKz62KQiXmswC
HIIlBCw+4Uwu/1RL1jOk45DGF0sT6fafLPnzEe0MBxjPRQ9D9ala3BKcF92Q5Cew
oBmhAPSl0NYA7ekMNJZh9MLfI3QIPdKnTvHgWpr/sT9rwb1jsHhXNwfqTq7qMzF4
1MeNaylxJfJcFe5Ame08qlEwCEbFwor4ISwUwNmDT0oXh9ptZm14g+39heahSL5A
3nk3H+ktq5IuEkjbbgO+EpVryg0z38HarQBkCGny/h/CVWnQlaac2bfOj5tYq0qo
KEJXyPtd8+aezAaNjIVjTPDNx3MzY9Au4BNw2XLHA/ksQGqNae4YrWMa5Ara5Ite
XswnV1BfCqwW9BxTkOQcHFMdqx1aRD0FHsCxFd0QOOcb4f6oBtdcuFtlrPRLfccq
pnhPTq0u4yZIs4TxWUTP
=4siJ
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--


