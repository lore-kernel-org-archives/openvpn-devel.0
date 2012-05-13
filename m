MIME-Version: 1.0
In-Reply-To: <20120513093551.GI1359@...1296...>
References: <CAOazyz2FzRu8y6FR1xiygh=KCBB=q-N5HrjLLzn5q1_AgL_3ig@...278...>
	<4FA77AB9.7090001@...1114...>
	<CAOazyz3QDHLxY51u0Ya9PscD8Q5+VqqrSn6M6=XpVUiFJY_ENw@...278...>
	<4FA8D931.70107@...515...>
	<CAOazyz2N744s+VJekGJNK4sqHCONLCzMtsiJyRTkgrpO4RWHzw@...278...>
	<363B57F6-F3E8-4C7D-A19D-0E08541233BD@...1286...>
	<20120513090153.GG1359@...1296...>
	<CAOazyz1FB+JU7QRmeMuxMX7-6fAN28VH1-6ApJnOu7eHDq9jUA@...278...>
	<20120513092355.GH1359@...1296...>
	<CAOazyz0=+ZE6+n-KqyzZSJhbweHb236LjwefvV6BtMvfbh37mQ@...278...>
	<20120513093551.GI1359@...1296...>
Date: Sun, 13 May 2012 14:00:32 +0300
Message-ID: <CAOazyz0bEZMBYcKGvKTux=+7XE43=-4Aw02HGVCNHPoO35wAWg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [RFC] Split plugins into their own repositories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Sun, May 13, 2012 at 12:35 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Sun, May 13, 2012 at 12:30:37PM +0300, Alon Bar-Lev wrote:
>> An healthy community dealing with openvpn need to gather all resources
>> that are acting at that niche.
>> There is no reason why we should not invite these maintainer to be
>> part of the openvpn project, on the contrary, we gain more resources,
>> more professionals.
>
> And how exactly will "fragment the openvpn source tree into many small
> packages" invite more contribution?
>
> I, for one, will think twice about contributing to a project where I have
> to figure out which of the 470 packages I need to download before I can
> even *start* looking at things.
>
>> Why should we define the scope of the openvpn project based on the
>> legacy james svn tree?
>
> Why not?
>
>> Can't we progress?
>
> Why is that progress?
>
> Change always has drawbacks. =C2=A0If the plus sides outweighs the drawba=
cks,
> change is good. =C2=A0Change for change's sake, "just because you can cha=
nge
> it", is not.

Yes, but still from your responses I don't see any drawback... maybe I
am slow learner...
I try to summarize people view and get:

1. it is hard to push changes to specific git repository... it is not
actually hard though.

2. it is hard to maintain several packages at distro level, well, as
shown in the other examples and plugins it is not the case.

3. it will grow to 500 packages like xorg, while it is not the case
even in nightmares... and we are talking about pure optional
components.

>
>> I would like to see this community growing... all UI/management/plugin
>> developers working under the same roof.
>>
>> It is healthy to the project =3D more resources.
>> It is healthy to the users =3D one stop shop, better integration.
>
> *one stop*. =C2=A0Thanks for saying that. =C2=A0This is a strong argument=
 against
> fragmenting our source tree.
>
> (I see you coming up with "why not have the different platform backends
> in their own repositories each, because a FreeBSD developer would not
> need the source files for Linux" next - and there is madness, not sanity)

Well, not for now.... :)
Although the thought came to mind when evaluating the polarssl implementati=
on...

Alon.

