Message-ID: <4FED9331.5080601@...1227...>
Date: Fri, 29 Jun 2012 13:36:17 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <4FEC9804.2070805@...1227...> <4FECB181.4070105@...1114...>
	<4FECCAF7.9060000@...1227...> <4FED5E04.10404@...1114...>
In-Reply-To: <4FED5E04.10404@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Fix --management-external-key in
	2.3alpha
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 29.06.12 09:49, schrieb David Sommerseth:
> On 28/06/12 23:21, Arne Schwabe wrote:
> >> But ... is it expected to pass --key if you use
> >> --management-external-key? I probably don't know enough about
> >> this --management-external-key feature, so I might be wrong.
>
> > No. --key is not passed but --managment-external-key sets --key
> > filename to EXTERNAL_KEY (like inline TAG for files).
>
> Ahh, okay, that makes sense. Should we consider to make --key and
> --management-external-key exclusive? So they it will choke if both is
> used? Just to make the usage a bit clearer.
Yes. I will prepare a new patch.

Arne
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/tkzEACgkQe8+cMNS4zRfExwCfY2YGdAHW7zCYcbCZ0P66buQO
/cgAoLtWhsorAvh1HhBNS+qE3/3sLn7t
=7tId
-----END PGP SIGNATURE-----


