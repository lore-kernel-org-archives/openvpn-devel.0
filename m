References: <25534afb-4dfc-fe21-6498-dc4aac20246f@...277...>
	<CAKuzo_gkTEh+-=z=dHm+sfHGqcHYwhCsOUvT=knNgj+X-B3HnA@...278...>
	<82c751dd-095d-cd1c-1422-24a443f1f1d0@...277...>
	<5c4e3f93-c584-4a19-4081-9bf4adaf417a@...277...>
	<502e093a-cb39-c76d-27b5-ab86fd4bcfd6@...515...>
	<73352d7f-521e-b968-2990-8783955da5c9@...2080...>
	<04516948-204e-57c2-fb57-f355157ed5af@...515...>
	<CAKuzo_gRDm566EwD_qtrYNM5AOYHF8xgCzsi1FQ3emjYGDeGmw@...278...>
	<43094758-efda-c613-c51d-e7980dfa6b24@...2080...>
	<CAKuzo_iaEhhrVhRr_zPATsFHinFi=ECtDFofEB2_8zP7Z2+zSg@...278...>
	<90baad6a-25c5-2ecc-1ea8-b5a1febf1521@...2080...>
	<cadcd4fa-701e-2d35-4fe0-66707dae8b5b@...277...>
	<9ba106aa-7dc7-753b-d662-6a75c6d16314@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <224b7dd3-6953-c47c-155d-6f9cae398d25@...515...>
Date: Tue, 1 Nov 2016 11:07:49 +0200
MIME-Version: 1.0
In-Reply-To: <9ba106aa-7dc7-753b-d662-6a75c6d16314@...2080...>
Subject: Re: [Openvpn-devel] trac 757 --auth-user-pass up + GUI 2.3 vs 2.4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net, debbie10t <debbie10t@...277...>

Il 01/11/2016 00:55, David Sommerseth ha scritto:
> On 31/10/16 23:25, debbie10t wrote:
>>
>>
>> On 31/10/16 21:30, David Sommerseth wrote:
>>
>>> So let's try to aim at pleasing the end user than being picky about the
>>> wording of a track ticket.  Because most users will be thankful for a
>>> related feature than no feature at all.
>>>
>>> Which is also why this core feature was added to the core OpenVPN 2.3
>>> branch.  It wasn't important *how* this was solved.  It was important
>>> that it was solved in *some* way; for non-Windows having a single line
>>> auth-pass file was the solution.   For Windows the solution might need
>>> to be different, just for the similar reasons we don't support bash
>>> scripts on Windows - but we provide support for alternatives.
>>>
>>> Of course the contra argument is that 2.4 have this support.  But should
>>> we start recommending users to upgrade to 2.4_alpha in production?  I
>>> don't think so - as then we could have jumped straight to the final
>>> release instead.  It will be a while until the final 2.4 version is
>>> released.
>>>
>>>
>>
>> I believe the *vast* majority of people would prefer to see an Official
>> Release of 2.4 take precedence over 'adding a /convenience/ feature' for
>> a user-base that can/have/will:- not upgrade their operating system.
>>
>> <redacted>
>>
>> Anything else would be a waste of time.
>
> How long will users be willing to wait?  I'd be really surprised if 2.4
> is out the door before Christmas 2016.  When also considering we've said
> that 2.4_alpha was soon ready for about 1 year or so before it really
> got released, I'd even say I am overly optimistic.
>
> I'm just trying to be realistic.
>

In my opinion Trac 757[*] is not the key here. Instead, we should=20
definitely have a high-level discussion of our support policy again,=20
because opinions there seem to differ a bit.

If I recall correctly, our policy for 2.3.x has been to include

- Security fixes
- Long-term compatibility features
- Trivial/safe fixes (e.g. documentation, minor fixes)

Is there something else?

At this point I would concentrate our efforts into getting 2.4.0 out,=20
instead of (arguably) wasting time backporting useful, but not critical=20
features to 2.3.x. Your estimate for 2.4.0 release seem reasonable, as=20
in "doable" and "not too far away for users" imho.

Moreover, if I understood Selva correctly, the problem in Trac 757 can=20
be solved by the user himself/herself by using OpenVPN-GUI v11 instead=20
of the one (v10) bundled in OpenVPN 2.3.x installers.

I would also argue that part the complaints is due to confusing=20
documentation on the man-page:

--auth-user-pass [up]

   Authenticate with server using username/password.  up is a file
   containing username/password on 2 lines.  If  the  password line is
   missing, OpenVPN will prompt for one.

Simply noting what is already said in Trac 757 would help reduce the=20
number of complaints.

My proposal:

a) Improve the man-page
    - Tell that OpenVPN-GUI v11 will allow caching of the username
    - Explain the limitations of --auth-user-pass

b) Make sure that OpenVPN-GUI v11 can be downloaded/installed separately

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[*] <https://community.openvpn.net/openvpn/ticket/757>

