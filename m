Message-ID: <4B22D2C8.5020703@...41...>
Date: Fri, 11 Dec 2009 16:16:24 -0700
From: James Yonan <jim@...41...>
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
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Karl O. Pinc" <kop@...1206...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Karl O. Pinc wrote:
> On 12/10/2009 04:39:57 AM, Samuli Sepp=E4nen wrote:
>> David Sommerseth ha scritto:
>=20
>>> I believe James have received several patches in the past from
>> people on
>>> the mailing list - or directly.=20
>=20
>>> They will either include patches into their own source
>> trees, or
>>> kick them back to be reworked or cancelled completely.
>>>
>>> Patches which are accepted will then be sent to James for a final
>> review
>>> and inclusion.  If James don't like it, it must be discussed on the
>>> mailing list so that everyone can see and understand why it was
>> rejected
>>> and how to make it more acceptable for inclusion.  If James can=20
>> take
>> the
>>> time to bring this discussion on the mailing list directly himself
>> in
>>> these cases, that would bring the needed transparency.  Further, it
>>> should hopefully not happen too often, as James' "inner circle"
>> should
>>> already have made sure it is suitable for inclusion.
>=20
> Via public discussion.  Who wants to submit a patch when it
> just disappears without comment.  Public discussion has been
> sorely lacking in the past.
>=20
>>>  Even
>> patches
>>> these people write themselves should be posted to the openvpn-devel
>> list
>>> (or other another more suitable one).  That way, more eyes can pay
>>> attention and raise awareness if something seems to be wrong or
>> needs to
>>> be discussed.
>=20
> Absolutely.  Public discussion of all submitted patches is essential.
>=20
> When you can commit to public discussion of submitted patches
> then I'll re-send at least one.  (Something very minor.)
>=20
>>> Another topic which is needed to be included is documentation.=20=20
>> This
>>> would be to organise the documentation and make sure all features
>> are
>>> documented, review documentation to make sure it works as expected
>> etc,
>>> etc.  This part do not necessarily require any coding skills at=20
>> all.
>=20
> However, it _could_ be a requirement that all patches be submitted
> with documentation.  If not, I can't see how you'd want to
> include any functional changes without also having documentation
> so somebody else would have to be gotten to document the patch.
> This is obviously up to whomever reviews the patches.
>=20
>=20
>>> What I do see as much more urgent is actually a better distributed
>>> VCS/RCS.  I believe SVN is used now - but I don't recall where I
>> found
>>> the URL for it (and I have lost now, I believe).  There's also a
>> rather
>>> outdated CVS tree on sourceforge.net.  This needs to be cleaned up,
>> and
>>> a publicly available source tree must be made available.
>=20
>>> David Sommerseth
>=20
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
>=20
> Are you saying that there has been no development on OpenVPN since
> 2009-11-20, approximately 20 days ago?  That seems a long time
> for James to have done no work on the code or documentation.
>=20
> A public revision control repository means that the public gets
> to see all the changes as they are committed.  It does not mean
> that we get to see the code only at arbitrary release points.
>=20
> There are 2 reasons for this.  The first is trust and transparency.
> We want to see where the code is going as it gets there so
> we can make our plans.  The second is to assist the people who
> review submitted patches.  Submitted patches should, by
> strong preference, be against the very latest version
> of the code.  This keeps merge conflicts, and related bugs,
> to a minimum and makes the job of reviewing patches much
> easier.
>=20
> If you don't have a public version of the latest development
> code you can't be said to be running an open project.
>=20
> FWIW using a good (rather than merely adequate) revision control
> system makes it much easier to keep the very latest code
> on-line and still perform regression tests, keep separate
> code branches for feature development, and so forth.
>=20
> What's the real policy regards the SVN repository and
> what are the concerns that have driven this policy?

I wanted to respond to some of the points brought up, as they are good=20
points.

First of all, the patch policy: fundamentally, we have to balance two=20
conflicting goals:

One the one hand people expect OpenVPN to be rock-solid in both=20
stability and security.  In order to maintain this standard of quality,=20
there needs to be a rigorous process of patch vetting.  On the other=20
hand, as an open source project, OpenVPN needs to be transparent and=20
open to contributions from the community.

It can be a challenge to balance these goals.  And certainly in the=20
lead-up to the release of 2.1 there was a long period of time that we=20
had to lean strongly towards (1) to ensure that 2.1 final would be solid.

I think it's great that Samuli Sepp=E4nen has come forward to serve as the=
=20
OpenVPN Community Manager -- one of our key goals here is to create a=20
community structure around the patch discussion and approval process=20
that removes myself as a bottleneck.

Re: the SVN repository.

The policy on the SVN repository is the same as that of most open source=20
projects: the repository is world-readable, and writable by trusted=20
members of the development team.

The repository change history is fully transparent.  You can use this=20
command to see every commit made to the repository since the OpenVPN=20
project inception in 2002.

   svn log http://svn.openvpn.net/projects/openvpn/branches/BETA21

(note that now that 2.1 is final, this branch will be renamed to=20
http://svn.openvpn.net/projects/openvpn/trunk in the near future)

James

