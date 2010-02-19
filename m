MIME-Version: 1.0
In-Reply-To: <4B7E72B0.3070701@...1114...>
References: <4B7AE8D6.3020304@...1114...>
	<7bb795fd1002170946u40bb0ea7rea4bbf710eaa0daa@...278...> 
	<7bb795fd1002181345t20918e0fqbecb14fe92835094@...278...> 
	<4B7E72B0.3070701@...1114...>
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Fri, 19 Feb 2010 12:29:39 +0100
Message-ID: <7bb795fd1002190329r7fba94fcnfba4453b9e22b2c1@...278...>
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

Hey David,

On Fri, Feb 19, 2010 at 12:14 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 18/02/10 22:45, JuanJo Ciarlante wrote:
>> On Wed, Feb 17, 2010 at 6:46 PM, JuanJo Ciarlante <jjo+ml@...410...> wro=
te:
>>> > Hi David,
>>> >
>>> > On Tue, Feb 16, 2010 at 7:49 PM, David Sommerseth
>>> > <openvpn.list@...1114...> wrote:
>>
>> Greetings all!
>>
>> I am now announcing the openvpn-testing.git tree as open. =A0Gert has
>> already been announcing the availability as a response to some merge
>> conflicts. =A0Anyhow, those issues are solved.
>>>> >
>>>> > \o/ !
>>>> >
>>
>> The tree is also tagged with all 2.1 releases and RC releases. =A0I have
>> not bothered with tagging the 2.1 beta or any 2.0 releases at all. =A0If
>> somebody finds it useful and wants it, please generate a list of tag
>> names and commit ID's and I'll update the tree.
>>
>>
>> What's next:
>>
>> - JuanJo Ciarliante's IPv6 patches for the transport layer.
>> =A0There are some merge conflicts here as well, which we need to solve.
>> =A0It's most probably due to different merge roots between our copies of
>> =A0the SVN tree. =A0I hope JJO and I can solve this soon, then it will go
>> =A0into the allmerged branch immediately.
>>>> >
>>>> > Cool, thanks a lot for the heads-up.
>>>> >
>>>> > I'll try to solve this before by next week,
>>> I've just did a cut+merge, fyi I had to use:
>>> =A0 git-format-patch -k --stdout stock..master |git-am -3 -k
>>> =A0 =A0 (stock: my svn-import'd tree, master: my local head)
>>> , worked fine (b/c of the different svn-import history(?),
>>> git could not find a common ancestor, then the need
>>> to fallback to "diff | patch").
>>> It also successful passes my tests as stated in README.ipv6.
>>
>>> I've pushed this to my github repo, so something in the
>>> lines of:
>>> =A0 git-remote add -f -t openvpn-testing-master+jjo-ipv6 \
>>> =A0 =A0 =A0jjo-ipv6 git://github.com/jjo/openvpn-ipv6
>>
>>> +merge should be able to fast-forward your master
>>> head.
>>
>>> I still need to do some touches for allmerged, as
>>> we conflict w/ Gert's IPv6 patch on a mroute.c chunk
>>> IIRC.
>>
>
> Great! =A0Thank you for your work here!
>
> I've created an feat_ipv6_transport branch where I'll track your
> patches. =A0Gert's IPv6 patches are in feat_ipv6_payload (which are also
> merged into the allmerged branch). =A0I've started the discussion about
> the merge conflict in another mail thread.

Coooool ! , tnx a lot.

>
> It's all pushed out to the openvpn-testing.git, so please feel free to
> update me when you have solved these issues or have other updates!

I expect to find time during the weekend to resolve the small conflict
and be able to inject-da-zing into allmerged.

>
>
> kind regards,

Cheers,

>
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAkt+crAACgkQDC186MBRfroDNgCgsZwPBeAFzR44FB34Xv0HInAr
> 46EAoKZtDgoSvqQIzpQu5XNEygaA7ccs
> =3DrqXo
> -----END PGP SIGNATURE-----
>



--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

