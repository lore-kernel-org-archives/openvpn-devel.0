MIME-Version: 1.0
In-Reply-To: <CAP+U6tK5a-QFW1+=B-6AOTa3nqHheETs9mSuLMGmUQ5WS+c3vw@...278...>
References: <4FAAE0A1.2080808@...1227...> <4FAAF945.8070005@...1227...>
	<CAOazyz12Rw0kOSS+siU7tLP4eXO5XkhexjVLn+uC97s4K1Z8EQ@...278...>
	<4FAAFCB4.8040606@...1227...>
	<CAOazyz2wP2ms7HC31LPp3VzFRBu+S3zURZm1ozz0MzjmhQv07g@...278...>
	<4FAB0556.50903@...1227...>
	<CAOazyz2pdJysuaEhoDL8O=S=CdEfW8XCuB6n8YrnKjOBqstTPA@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8A98@...1436...>
	<CAOazyz0Qb8xa-FUqQcMDX=w+=Vb3J8sQ2R8GAxNtfWxT-4DNkw@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AB9@...1436...>
	<CAOazyz3xObLvBubo4E6vSmepj-8AkGd6P4k-6VXYpvsSm-vs3A@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AD6@...1436...>
	<4FAB8EEE.8020607@...1114...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8D08@...1436...>
	<CAOazyz1u-WhMYD5VykW2nzLyJzWr8-8wJ3pqwCMBwqggkpbLiA@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8D3E@...1436...>
	<CAOazyz30FaAPsha7hyD9cAwvRWkq_4i9Cme0mFJDpX0VdSb7=w@...278...>
	<4FABDBF7.406@...1114...>
	<CAP+U6tK5a-QFW1+=B-6AOTa3nqHheETs9mSuLMGmUQ5WS+c3vw@...278...>
Date: Fri, 11 May 2012 07:05:14 +0300
Message-ID: <CAOazyz0QghwU6hswGqhQ-8L4CY74xwPSNwdXBn_AzHTEtOREHQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
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
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Fri, May 11, 2012 at 12:11 AM, Fabian Knittel
<fabian.knittel@...1547...> wrote:
> Hi,
>
> 2012/5/10 David Sommerseth <openvpn.list@...1114...>:
>> On 10/05/12 16:50, Alon Bar-Lev wrote:
>>> Why? plugin is adding a custom logic, and you need custom logic. As
>>> I wrote it does not imply that you implement your JNI there.
>>
>> Okay ... fine ... there are plenty of big visions for a future version
>> of OpenVPN, and it will become more modular, yes. =C2=A0I think we all
>> agree there.
>>
>> What is far more important now is the review the *current* patch, this
>> review process have so far derailed completely. =C2=A0Lets put this curr=
ent
>> discussion aside. =C2=A0Later on we will discuss this how to modularise
>> OpenVPN anyway.
>
> To allow OpenVPN to be properly refactored afterwards, the important
> part is probably to get the external interfaces correct (which never
> works in practice, but it would be nice to get close...).
>
> The main undecided points regarding the interface side of things appear t=
o be:
> * How to pass the fds back and forth: Special-case the management
> =C2=A0interface for unix domain sockets or use a dedicated unix domain
> =C2=A0socket for special operations. Could this potentially be the same
> =C2=A0interface that was discussed for some of the windows privilege
> =C2=A0separation approaches?

Again, this is not the case of privileged separation as the process
*IS* privileged to do the networking setup.
People, don't get confused between running under root or not with privilege=
s!
Regular user can have privileges like creating tun and modify network
setting without being root, as in this case, this is not privilege
separation!

And again, these UI specific issues should should be modularize and
not go into mainline as-is.

> * How to call OpenVPN from Java. Via thin JNI wrapper or as a regular
> =C2=A0executable.

Again, this is not the question.
The question is do we want to make a library out of VPN with some
interface such as openvpn_main() or not, the JNI question is totally
unrelated to the mainline project.

> * The precise names of the newly introduced management commands.

If we provide plugin interface to management interface this can be a
contract between the UI and the plugin, so that mainline should not be
changed every time there is a special UI need.

If we provide tun engine implementation that supports the management
interface, all platforms can benefit from this change.

>
> Anything else?
>
> Cheers
> Fabian

