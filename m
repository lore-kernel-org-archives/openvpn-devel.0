Message-ID: <4B98179E.9020904@...1114...>
Date: Wed, 10 Mar 2010 23:05:18 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1267391523-1123-1-git-send-email-openvpn.list@...1114...>	<201002282326.32573.dave_br@...1278...>	<4B97BE9C.4010203@...1114...>
	<201003101634.58839.dave_br@...1278...>
In-Reply-To: <201003101634.58839.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] bash->bourne script cleanup
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
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/03/10 17:34, Davide Brini wrote:
>> > >>The only scripts that actually require bash are
>> > >> contrib/pull-resolv-conf/client.{up,down} ; they use the ${!var}
>> > >> variable indirection feature.
>>>
>>> > > Not only that, they also use arrays, which are not part of standard sh.
>>> > >
>>> > > For a POSIX-sh compliant solution thad does mostly the same thing (and
>>> > > handles multiple DOMAIN options as well, which client.{up,down} doesn't
>>> > > support), I suggest  you look into the Gentoo-provided {up,down}.sh
>>> > > scripts (though they contain some Gentoo-specific parts, but those are
>>> > > easily removed).
>> > 
>> > Agreed!  If you have time to look at a patch for it, I'd appreciate
>> > that.  It will go in as a separate patch, to keep the patch flow as
>> > simple as possible.
>> >
> Well, I was actually going to write a patch, but shortly after starting I 
> found out that it would end up being essentially the same as Gentoo's scripts.
> Would it be worth separately maintaining something that has already been 
> written somewhere else?

I would say that if there are things which are distro related, they
should either be found only in that distribution or we can consider (if
it is considered important by more people) to put distro specific stuff
into a separate folder in the OpenVPN source tree.

If it is possible to get some up/down scripts which are generic for the
vast majority of POSIX sh based distributions, that would be the
preferred approach.  If not, then we are back to where we started :)

Did that answer your question?


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuYF54ACgkQDC186MBRfrqHwACgpMmlJ9ZQU/CvppJ+3pq1s/ql
IqwAoJEk28vBEMeJn44K8sLoJ33h/rqs
=eOoy
-----END PGP SIGNATURE-----

