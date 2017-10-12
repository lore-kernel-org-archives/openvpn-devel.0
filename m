MIME-Version: 1.0
In-Reply-To: <20171010231130.6832-6-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-6-simon@...2293...>
From: Selva <selva.nair@...277...>
Date: Thu, 12 Oct 2017 11:56:23 -0400
Message-ID: <CAKuzo_jwyz+AgUmcXi-bCdxiCLzb4YD2uF6AV=oxTPxvm6SwAA@...278...>
Content-Type: multipart/alternative; boundary="001a114794e4377fc8055b5b9683"
Subject: Re: [Openvpn-devel] [PATCH 06/13] openvpnserv.vcxproj project file
 recreated using Visual Studio 2017
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114794e4377fc8055b5b9683
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Oct 10, 2017 at 7:11 PM, <simon@...2293...> wrote:

> From: Simon Rozman <simon@...2293...>
>
> 1. The project file was created from scratch.
> 2. XML nodes were reordered to match old project order for easier diff-ing.
> 3. All non-essential settings reset to MSVC defaults.
> 4. .h/.c file list updated.
> 5. Missing /I include paths added.
> 6. List of required .lib files updated.
>
> The openvpnserv.exe compiles now. Warnings will be addressed in future
> patches.
>

Though we do not have a patch allocation policy, as I have responded to 1
to 5
I might have become the de-facto reviewer of this patch set. So this is
just to say
patches 6 to 13 (except 9 and 12) are VS project files and related stuff
that I
have no idea about and will be hard for me to review. Hope someone else take
a look at those.

Patches 9 and 12 are not Windows specific and so hopefully someone will get
to
those before I may find time..

Thanks,

Selva

--001a114794e4377fc8055b5b9683
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Tue, Oct 10, 2017 at 7:11 PM,  <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:simon@...2293..." target=3D"_blank">simon@...2293...</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">From: Simon Rozman &lt;<a href=3D"m=
ailto:simon@...2293..." target=3D"_blank">simon@...2293...</a>&gt;<br>
<br>
1. The project file was created from scratch.<br>
2. XML nodes were reordered to match old project order for easier diff-ing.=
<br>
3. All non-essential settings reset to MSVC defaults.<br>
4. .h/.c file list updated.<br>
5. Missing /I include paths added.<br>
6. List of required .lib files updated.<br>
<br>
The openvpnserv.exe compiles now. Warnings will be addressed in future patc=
hes.<br></blockquote><div><br></div><div>Though we do not have a patch allo=
cation policy, as I have responded to 1 to 5</div><div>I might have become =
the de-facto reviewer of this patch set. So this is just to say</div><div>p=
atches 6 to 13 (except 9 and 12) are VS project files and related stuff tha=
t I</div><div>have no idea about and will be hard for me to review. Hope so=
meone else take</div><div>a look at those.</div><div><br></div><div>Patches=
 9 and 12 are not Windows specific and so hopefully someone will get to</di=
v><div>those before I may find time..</div><div><br></div><div>Thanks,</div=
><div><br></div><div>Selva</div></div></div></div>

--001a114794e4377fc8055b5b9683--

