MIME-Version: 1.0
In-Reply-To: <CAEsd45Qs7RvuOVP7iZLTZ1bOuZQcW7QKmnT+q8GYW8t2jiTQbQ@...278...>
References: <CAKuzo_hFT3vXnNn46ubhQiV0zwjg_0uyyMyVtNq2OZeYsq3TuQ@...278...>
	<08d5f483-cc64-b708-a54c-29cfb2c7880e@...277...>
	<CAKuzo_jFHw1k0M0WfU8WsiTaZDYNE9+K=2=41g_oHqLikydo1w@...278...>
	<ad8c62af-5534-79d7-11ff-56cf51888615@...277...>
	<CAKuzo_iBnazFOMGaCDO-ga_ONCN=wb6818syt+S66S_OKZDoCw@...278...>
	<CAEsd45Qs7RvuOVP7iZLTZ1bOuZQcW7QKmnT+q8GYW8t2jiTQbQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 11 Dec 2016 22:56:14 -0500
Message-ID: <CAKuzo_gj8Fb81kravS=fOSFifrm5CufHsDz5jPxZEygsRMLvog@...278...>
Content-Type: multipart/alternative; boundary=001a11376232fe753305436e16b2
Subject: Re: [Openvpn-devel] On saving passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11376232fe753305436e16b2
Content-Type: text/plain; charset=UTF-8

On Sun, Dec 11, 2016 at 9:50 PM, Jonathan K. Bullard <jkbullard@...277...>
wrote:

But seeing this thread, I am considering having Tunnelblick block
> saving/retrieving of the username or password if --auth-nocache is
> specified in the configuration file. That should make it easier for
> admins because they wouldn't have to set the Tunnelblick preferences.
> I would probably keep the existing mechanism so an admin could allow
> __OpenVPN__ to cache the username/password but not allow the __user__
> to store them.
>

What I've in mind for Windows GUI is to just interpret --auth-nocache to
mean do not save passwords. But if you already have an option to disable it
independently, makes sense to keep it and add this in addition to it.

 Question: Can --auth-nocache be pushed by the server


> If so, is there some way that the management interface specifies that
> --auth-nocache is active when asking for a username/password?


No it cannot be pushed.

If it ever becomes pushable, we should add a don't-cache (and/or
don't-save) hint to the password prompt. Similar to how challenge response
echo directive could be embedded in the prompt. The alternate of parsing
the log for pushed options would be a major pain.. Such a hint or directive
in the prompt is something I would like to have even otherwise.

Selva

--001a11376232fe753305436e16b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sun, Dec 11, 2016 at 9:50 PM, Jonathan K. Bullard <span dir=3D"ltr">&lt;=
<a href=3D"mailto:jkbullard@...277..." target=3D"_blank">jkbullard@...1663...=
.</a>&gt;</span> wrote: <br><br><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">But seeing this thread, I am considering having Tunnelblick block<br>
saving/retrieving of the username or password if --auth-nocache is<br>
specified in the configuration file. That should make it easier for<br>
admins because they wouldn&#39;t have to set the Tunnelblick preferences.<b=
r>
I would probably keep the existing mechanism so an admin could allow<br>
__OpenVPN__ to cache the username/password but not allow the __user__<br>
to store them.<br></blockquote><div><br></div><div>What I&#39;ve in mind fo=
r Windows GUI is to just interpret --auth-nocache to mean do not save passw=
ords. But if you already have an option to disable it independently, makes =
sense to keep it and add this in addition to it.<br></div><br></div><div cl=
ass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=
=A0Question: Can --auth-nocache be pushed by the server</blockquote><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
If so, is there some way that the management interface specifies that<br>
--auth-nocache is active when asking for a username/password? </blockquote>=
<div><br>No it cannot be pushed. <br><br>If it ever becomes pushable, we sh=
ould add a don&#39;t-cache (and/or don&#39;t-save) hint to the password pro=
mpt. Similar to how challenge response echo directive could be embedded in =
the prompt. The alternate of parsing the log for pushed options=20
would be a major pain.. Such a hint or directive in the prompt is something=
 I would like to have even otherwise.<br><br></div><div>Selva<br></div></di=
v></div></div>

--001a11376232fe753305436e16b2--

