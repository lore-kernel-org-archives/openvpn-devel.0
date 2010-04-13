MIME-Version: 1.0
In-Reply-To: <4BC4766A.3040601@...1114...>
References: <1269951178-30419-1-git-send-email-dazo@...384...>
	<4BBE3205.1040303@...1114...>
	<p2w9e0cf0bf1004100005u819d4b3l97c269272e2604ab@...278...>
	<h2z9e0cf0bf1004100035rc34e5c17rb7cb8554ba64509@...278...>
	<4BC4766A.3040601@...1114...>
Date: Tue, 13 Apr 2010 17:27:45 +0300
Message-ID: <k2v9e0cf0bf1004130727i3e5e7805g6413b9043728127@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Add comile time settings from
	./configure to --version
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

Again,
Hacking the config.log is a hack, none documented structure that may
change from one version to another.
You should not do this if yo care about backward/forward compatibility.
Also analyzing config.h is inappropriate.

If you don't want to do this as I suggested you can write m4 macro such as:

AC_DEFUN([MY_AC_ARG_WITH],[
   AC_ARG_WITH([$1],[$2],[$3],[$4])
   ---- do something ----
])

This will enable you to do some procedural work without using hacks.

On Tue, Apr 13, 2010 at 4:49 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> On 10/04/10 09:35, Alon Bar-Lev wrote:
>> Also there is no proper dependency for configure.h in Makefile.am so
>> it won't be built.
>> Proper way to do so is like I done for OpenSC [1], look for OPENSC_FEATU=
RES.
>>
>> [1] http://www.opensc-project.org/opensc/browser/trunk/configure.ac#L613
>
> Thank you for catching this one. =C2=A0I've obviously been too sloppy with
> 'make distcheck', which would have detected this one.
>
> Even though I see you build up a string in configure.ac with enabled
> features in your example [1], I personally feel that approach is less
> flexible. =C2=A0When this feature was implemented I considered that appro=
ach
> as well, but I found it would require much more changes to configure.ac.
> =C2=A0It would also make it possible to skip listing enabled features, ju=
st
> by forgetting to add the feature to the feature list.
>
> The awk approach has the advantage of dynamically building up a list of
> features found in ./config.h. =C2=A0And in addition, the current
> implementation also show which arguments was used with ./configure.
>
> I've attached three patches, which cleans up this feature further.
>
>
> kind regards,
>
> David Sommerseth
>
>
>> On Sat, Apr 10, 2010 at 10:05 AM, Alon Bar-Lev <alon.barlev@...277...> w=
rote:
>>> Highly none standard autotools usage.
>>> Also requires awk which may not be available.
>>> Please REVERT.
>>>
>>> On Thu, Apr 8, 2010 at 10:44 PM, David Sommerseth
>>> <openvpn.list@...1114...> wrote:
>> On 30/03/10 14:12, David Sommerseth wrote:
>>>>>> This patch will create ./configure.h which will contain two new #def=
ine
>>>>>> strings. =C2=A0CONFIGURE_DEFINES will contain all USE, ENABLED, DISA=
BLED and
>>>>>> DEPRECATED defines from ./config.h. =C2=A0CONFIGURE_CALL will contai=
n the
>>>>>> complete ./configure line which was used when configuring the package
>>>>>> for building.
>>>>>>
>>>>>> Signed-off-by: David Sommerseth <dazo@...384...>
>>>>>> ---
>>>>>> =C2=A0Makefile.am =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A07 +++++++
>>>>>> =C2=A0configure_h.awk =C2=A0 | =C2=A0 39 +++++++++++++++++++++++++++=
++++++++++++
>>>>>> =C2=A0configure_log.awk | =C2=A0 36 ++++++++++++++++++++++++++++++++=
++++
>>>>>> =C2=A0options.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A03 +++
>>>>>> =C2=A04 files changed, 85 insertions(+), 0 deletions(-)
>>>>>> =C2=A0create mode 100644 configure_h.awk
>>>>>> =C2=A0create mode 100644 configure_log.awk
>>
>> Applied to the openvpn-testing.git feat_misc branch. =C2=A0To be merged =
into
>> allmerged soon.
>> Commit f27bf509315a48b0070294c3993a718df0c2626c
>>
>>
>> kind regards,
>>
>> David Sommerseth
>>>>
> -------------------------------------------------------------------------=
-----
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>>
>>>
>
>

