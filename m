MIME-Version: 1.0
In-Reply-To: <CAKuzo_hVKtfdkncmqg5hKX18WYGpFWu1GRxD6dnM=3PfHnQiLw@...278...>
References: <1465871689-13533-1-git-send-email-selva.nair@...277...>
	<20160614071342.GR62247@...1296...>
	<CAKuzo_hVKtfdkncmqg5hKX18WYGpFWu1GRxD6dnM=3PfHnQiLw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 5 Jul 2016 20:06:13 -0400
Message-ID: <CAKuzo_g9GzeE7yVD6G3vsGx7u7nt=3-_nVmXM-O9SG9Gi56jHg@...278...>
Content-Type: multipart/alternative; boundary=001a11409f26987fcc0536ec576c
Subject: Re: [Openvpn-devel] [PATCH] Promptly close the netcmd_semaphore
 handle after use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11409f26987fcc0536ec576c
Content-Type: text/plain; charset=UTF-8

On Tue, Jun 14, 2016 at 11:40 PM, Selva Nair <selva.nair@...277...> wrote:

>
>
>> But I'm open to "semaphores are cheap, we can just open/lock/release/
>> close
>> it on every call" arguments :-)
>>
>
> Very unlikely to be a drag on performance -- I think createprocess will be
> where time is spent [*].
>
> That said, calling semaphore_close() inside netcmd_semaphore_unlock() is
> not a style to be proud of.  So I'm kind of inclined to do a version 2
> along the lines you suggested but some testing will be needed to get it
> right.


After looking into this further, I find redoing the patch along those lines
is not ideal. A semaphore_close() has to be inserted before any possible
long waits such as management-hold, pull-filter reject, or any other
restart loops, which is going to be ugly and fragile.

The cleanest way is to close the semaphore soon after releasing it. Version
1 does that and I do not think there is any performance penalty involved.
Logically, a more correct approach may be to replace all calls to
netcmd_semaphore_release()
by netcmd_semaphore_close() but that involves more pervasive edits.

Having said that, I'm open to other suggestions.

Selva

--001a11409f26987fcc0536ec576c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jun 14, 2016 at 11:40 PM, <span tabindex=3D"-1" id=3D":8l6.1" style=
=3D"" class=3D"">Selva</span> Nair <span dir=3D"ltr">&lt;<a href=3D"mailto:=
selva.nair@...277..." target=3D"_blank"><span tabindex=3D"-1" id=3D":8l6.2"=
 style=3D"" class=3D"">selva</span>.<span tabindex=3D"-1" id=3D":8l6.3" sty=
le=3D"" class=3D"">nair</span>@gmail.com</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex"><div class=3D"gmail_quote"><div><br></div><span class=
=3D""><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><div>
<br>
But I&#39;m open to &quot;semaphores are cheap, we can just open/lock/relea=
se/<span class=3D"il">close</span><br>
it on every call&quot; arguments :-)</div></blockquote></span></div><br>Ver=
y unlikely to be a drag on performance -- I think createprocess will be whe=
re time is spent [*].<br><br>That said, calling semaphore_close() inside ne=
tcmd_semaphore_unlock() is not a style to be proud of.=C2=A0 So I&#39;m kin=
d of inclined to do a version 2 along the lines you suggested but some test=
ing will be needed to get it right.</blockquote></div><br></div><div class=
=3D"gmail_extra">After looking into this further, I find redoing the patch =
along those lines is not ideal. A semaphore_close() has to be inserted befo=
re any possible long waits such as management-hold, pull-filter reject, or =
any other restart loops, which is going to be ugly and fragile.<br><br></di=
v><div class=3D"gmail_extra">The cleanest way is to close the semaphore soo=
n after releasing it. Version 1 does that and I do not think there is any p=
erformance penalty involved. Logically, a more correct approach may be to r=
eplace all calls to <span tabindex=3D"-1" id=3D":8l6.4" style=3D"" class=3D=
"">netcmd</span>_semaphore_release() by <span tabindex=3D"-1" id=3D":8l6.5"=
 style=3D"" class=3D"">netcmd</span>_semaphore_close() but that involves mo=
re pervasive edits.<br><br>Having said that, I&#39;m open to other suggesti=
ons.<br><br></div><div class=3D"gmail_extra"><span tabindex=3D"-1" id=3D":8=
l6.6" style=3D"" class=3D"">Selva</span><br></div></div>

--001a11409f26987fcc0536ec576c--

