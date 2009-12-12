Message-ID: <4B237608.6030109@...515...>
Date: Sat, 12 Dec 2009 12:52:56 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1260552743.31755.0@...1207...>
In-Reply-To: <1260552743.31755.0@...1207...>
Subject: Re: [Openvpn-devel] OpenVPN project organization [WAS: Introducing
 OpenVPN Community Manager]
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Via public discussion.  Who wants to submit a patch when it
> just disappears without comment.  Public discussion has been
> sorely lacking in the past.
>=20=20=20
I can't comment on how patches have been handled in the past, but not
discussing and including them is a sure way to demotivate people.
>>>  Even
>>>=20=20=20=20=20=20=20
>> patches
>>=20=20=20=20=20
>>> these people write themselves should be posted to the openvpn-devel
>>>=20=20=20=20=20=20=20
>> list
>>=20=20=20=20=20
>>> (or other another more suitable one).  That way, more eyes can pay
>>> attention and raise awareness if something seems to be wrong or
>>>=20=20=20=20=20=20=20
>> needs to
>>=20=20=20=20=20
>>> be discussed.
>>>=20=20=20=20=20=20=20
>
> Absolutely.  Public discussion of all submitted patches is essential.
>
> When you can commit to public discussion of submitted patches
> then I'll re-send at least one.  (Something very minor.)
>=20=20=20
I agree that all developers should be treated equal and use the same
tools for their work. I don't personally like when people do things=20
behind my back. Especially when the actions affects me somehow or when
it's clear I could have provided useful feedback. In the long run this
behavior leads to mistrust - "them" and "us" mentality. This is harmful
in any social relations, not just in OSS projects.
>> The SVN repository URL's are here:
>>
>> http://www.openvpn.net/index.php/open-source/documentation/
>> miscellaneous/subversion-repository.html
>>
>> I checked the logs and last update in 2.1 branch was from 2009-11-20,
>> so
>> it's probably 100% up-to-date. I agree with you for the most part.
>> Beaker sounds interesting, as I guess OpenVPN probably lends itself
>> well
>> to automated testing.=20
>>=20=20=20=20=20
>
> Are you saying that there has been no development on OpenVPN since
> 2009-11-20, approximately 20 days ago?  That seems a long time
> for James to have done no work on the code or documentation.
>=20=20=20
I have to admit I do not know. I do know that James is swamped with work
and hence is unable to pay enough attention to the project. This is
something I'll be discussing with him. And the primary reason I
initiated this discussion. I'll try to help him out of his deadlock
situation which is hurting everybody.
> A public revision control repository means that the public gets
> to see all the changes as they are committed.  It does not mean
> that we get to see the code only at arbitrary release points.
>=20=20=20
Agreed. However, if you take a look at the SVN logs each atomic change
(not just release points) is listed.
> There are 2 reasons for this.  The first is trust and transparency.
> We want to see where the code is going as it gets there so
> we can make our plans.  The second is to assist the people who
> review submitted patches.  Submitted patches should, by
> strong preference, be against the very latest version
> of the code.  This keeps merge conflicts, and related bugs,
> to a minimum and makes the job of reviewing patches much
> easier.
>=20=20=20
I agree. Discussing and merging patches in a timely manner is essential.
As is an up-to-date development tree.
> If you don't have a public version of the latest development
> code you can't be said to be running an open project.
>
> FWIW using a good (rather than merely adequate) revision control
> system makes it much easier to keep the very latest code
> on-line and still perform regression tests, keep separate
> code branches for feature development, and so forth.
>=20=20=20
Any suggestion which VCS would do the best job?

> What's the real policy regards the SVN repository and
> what are the concerns that have driven this policy?
>=20=20=20
I'd guess the decision was not driven by any conscious policy.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc




