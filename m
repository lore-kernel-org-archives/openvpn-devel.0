Message-ID: <4C2CD683.1040600@...1114...>
Date: Thu, 01 Jul 2010 19:55:15 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4C2B07C1.9050500@...515...>
	<20100701145951.GI4340@...1276...>
	<4C2CB283.4000408@...1114...>
	<20100701152855.GJ4340@...1276...>
In-Reply-To: <20100701152855.GJ4340@...1276...>
Subject: Re: [Openvpn-devel] Packaging OpenVPN for various platforms?
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
To: Till Maas <opensource@...519...>
Cc: openvpn-devel@lists.sourceforge.net, Steven Pritchard <steve@...610...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/07/10 17:28, Till Maas wrote:
> On Thu, Jul 01, 2010 at 05:21:39PM +0200, David Sommerseth wrote:
> 
>> But, I do see one big advantage of building packages via Koji (Fedora's
>> building system which uses mock), if possible.  That will put these
>> packages into a yum repository almost instantly, which can be useful to
>> make the packages more easily available.
> 
> Using koji is a bit of overkill. There is a small perl wrapper that can
> be used to easily build a src.rpm for different archs and distributions
> called smock:
> 
> http://git.annexia.org/?p=fedora-mingw.git;a=history;f=smock;hb=966f55f8692da3f842da077e57c22ff501e380e1
> 
> It also creates yum repos with the resulting RPMs.
> 

Ahh, I didn't know about smock, that might as well be an alternative.

Yeah, I can agree that koji itself is probably overkill for this kind of
routine task.  It was more if there were some kind of interfaces we
could use.  Just to avoid setting up a separate build slave for
Fedora/EPEL builds but use what's already publicly available.  But I'm
advocating for the simplest solution for all of us :)


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkws1oIACgkQDC186MBRfrqYPACgm9rzl0tw2HRR8g1VdXWjJjLw
AzoAn3rNifpzOr7ymk3iYtJLJEWRabWn
=8Af4
-----END PGP SIGNATURE-----

