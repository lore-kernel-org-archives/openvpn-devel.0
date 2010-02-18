MIME-Version: 1.0
In-Reply-To: <7bb795fd1002170946u40bb0ea7rea4bbf710eaa0daa@...278...>
References: <4B7AE8D6.3020304@...1114...>
	<7bb795fd1002170946u40bb0ea7rea4bbf710eaa0daa@...278...>
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Thu, 18 Feb 2010 22:45:14 +0100
Message-ID: <7bb795fd1002181345t20918e0fqbecb14fe92835094@...278...>
Subject: Re: [Openvpn-devel] openvpn-testing tree available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: Openvpn-devel@lists.sourceforge.net, James Yonan <jim@...41...>

On Wed, Feb 17, 2010 at 6:46 PM, JuanJo Ciarlante <jjo+ml@...410...> wrote:
> Hi David,
>
> On Tue, Feb 16, 2010 at 7:49 PM, David Sommerseth
> <openvpn.list@...1114...> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>
>> Greetings all!
>>
>> I am now announcing the openvpn-testing.git tree as open. =A0Gert has
>> already been announcing the availability as a response to some merge
>> conflicts. =A0Anyhow, those issues are solved.
>
> \o/ !
>
>>
>> The tree is also tagged with all 2.1 releases and RC releases. =A0I have
>> not bothered with tagging the 2.1 beta or any 2.0 releases at all. =A0If
>> somebody finds it useful and wants it, please generate a list of tag
>> names and commit ID's and I'll update the tree.
>>
>>
>> What's next:
>>
>> - - JuanJo Ciarliante's IPv6 patches for the transport layer.
>> =A0There are some merge conflicts here as well, which we need to solve.
>> =A0It's most probably due to different merge roots between our copies of
>> =A0the SVN tree. =A0I hope JJO and I can solve this soon, then it will go
>> =A0into the allmerged branch immediately.
>
> Cool, thanks a lot for the heads-up.
>
> I'll try to solve this before by next week,

I've just did a cut+merge, fyi I had to use:
  git-format-patch -k --stdout stock..master |git-am -3 -k
    (stock: my svn-import'd tree, master: my local head)
, worked fine (b/c of the different svn-import history(?),
git could not find a common ancestor, then the need
to fallback to "diff | patch").
It also successful passes my tests as stated in README.ipv6.

I've pushed this to my github repo, so something in the
lines of:
  git-remote add -f -t openvpn-testing-master+jjo-ipv6 \
     jjo-ipv6 git://github.com/jjo/openvpn-ipv6

+merge should be able to fast-forward your master
head.

I still need to do some touches for allmerged, as
we conflict w/ Gert's IPv6 patch on a mroute.c chunk
IIRC.

Cheers,

> it's
> sooo great to see all the community contributed bits
> being taken good care =A0 :)))
>
>>
>> - - Go through the mailing list to pick up branches which has not been
>> =A0included into the the OpenVPN SVN tree. =A0I will probably not go much
>> =A0further than the last 9-12 months. =A0If you have a patch you want to
>> =A0be sure gets into the tree, please raise the attention by sending an
>> =A0e-mail to this mailing list. =A0I don't intend to deliberately ignore
>> =A0patches.
>>
>> =A0James: Do you have an overview over patches you have included already?
>> =A0And patches you've received which has not been processed yet?
>>
>> - - The eurephia patch got a review, with one comment I'd like to
>> =A0investigate a little bit more (If ctx->current_cert->sha1_hash is
>> =A0always valid). =A0When this is done, the feat_eurephia branch will be
>> =A0merged into the allmerged branch.
>>
>> - - Update the developers documentation on the wiki, with some
>> =A0"requirements" to get patches included. =A0For already submitted patc=
hes
>> =A0I will be a little bit nicer. =A0Patches after this mail should strive
>> =A0to follow the guidelines found in the mail discussion here [1]. =A0All
>> =A0patches are *expected* to apply cleanly against the latest SVN
>> =A0BETA21/openvpn branch or the git master branch.
>>
>> The next big test for this is when James does some more commits, and to
>> see how smoothly it will merge in those changes.
>>
>>
>> For those wanting to contact me, I'm available on e-mail:
>> <dazo@...384...> or on IRC (freenode, #openvpn-devel)
>>
>> The git tree is available here:
>> <git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn-testing.git>
>>
>> Web view of the git tree can be found here:
>> <http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-t=
esting.git>
>>
>>
>>
>> kind regards,
>
> Cheers,
>
>>
>> David Sommerseth
>>
>>
>> [1]
>> <http://sourceforge.net/mailarchive/message.php?msg_name=3D4B6A9823.8010=
800%40topphemmelig.net>
>>
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.4.10 (GNU/Linux)
>> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>>
>> iEYEARECAAYFAkt66NMACgkQDC186MBRfrp4KACfQpqkUvcbB2GLxiBUx/ETX1Xw
>> 0ZwAoIbajA0Q5/Rm7cP+AUGgNPezlEwg
>> =3DMvpN
>> -----END PGP SIGNATURE-----
>>
>
>
>
> --
> --JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'
>



--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

