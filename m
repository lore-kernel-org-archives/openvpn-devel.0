Message-ID: <4C2CB283.4000408@...1114...>
Date: Thu, 01 Jul 2010 17:21:39 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4C2B07C1.9050500@...515...>
	<20100701145951.GI4340@...1276...>
In-Reply-To: <20100701145951.GI4340@...1276...>
Subject: Re: [Openvpn-devel] Packaging OpenVPN for various platforms?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Till Maas <opensource@...519...>, Steven Pritchard <steve@...610...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


(Adding the Fedora OpenVPN package maintainer, Steven Pritchard, on Cc.)

On 01/07/10 16:59, Till Maas wrote:
> On Wed, Jun 30, 2010 at 12:00:49PM +0300, Samuli Seppänen wrote:
> 
>> - write packaging instructions to our Trac wiki
>> (https://community.openvpn.net/openvpn/wiki)
>> - convert the instructions into BuildBot code (BuildSteps)
>>
>> After this is done, we can provide the latest version of OpenVPN for
>> various platforms with minimal manual effort. This helps developers as
>> well as users: having the development code in wider circulation helps
>> spot problems faster resulting in faster release cycle.
> 
> I am a Fedora package maintainer, but not one of OpenVPN. I CC'ed them
> in case they did not notice this.
> 
> The Fedora package scripts are currently available here:
> http://cvs.fedoraproject.org/viewvc/rpms/openvpn/devel/
> 
> In the not so far future this URL will not be valid, because Fedora
> switches to git.
>
> Packages for Fedora are usually build within a chroot using a helper
> tool called mock[0] and I do not know how well it works on other
> distributions except Fedora or RHEL/CentOS. There are also scripts
> developed to easily build new rpms from SCM and afaik currently only git
> is supported (I do not know what OpenVPN currently uses, but I suspect
> it's SVN):

The openvpn-testing repository is git based, but the coming beta2.2 will
be primarily SVN where the -testing repository will mirror the SVN
branch.  All community patches will go in to the SVN tree via the git tree.

> https://fedorahosted.org/fedora-packager/ticket/8
> 
> Adding support for SVN or other SCMs should not be that hard. I will try
> to write something up how to put all this together to easily build new
> OpenVPN Packages for Fedora using a SCM checkout.

As the building in this context is mostly oriented around the -testing
tree, I think you don't need to think too much about SVN support now.
The git support should be sufficient.

We're looking for a way how to provide openvpn-testing packages for a
vast majority of distributions and OSes, to check that it compiles well
and to provide binaries for those wanting to be experimental.

But, I do see one big advantage of building packages via Koji (Fedora's
building system which uses mock), if possible.  That will put these
packages into a yum repository almost instantly, which can be useful to
make the packages more easily available.

Steven: I'd like to hear your thoughts on this as well!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkwssoAACgkQDC186MBRfrq6uwCdFCtKQQWKoHG5PxouIqkZZvaK
Si4An0uK61otB9SuPRiGKKRRY5imId3y
=eMvc
-----END PGP SIGNATURE-----

