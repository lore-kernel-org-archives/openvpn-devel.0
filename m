MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10857D3DCD@...2294...>
References: <99D61A626FDA8A4B90A270669121BE10857D3DCD@...2294...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 10 Oct 2017 18:09:38 +0500
Message-ID: <CAFHpkQGZuQUZBqPmsZkBDx1CPiG5KmKKi1Kn_pL9JqwiiQcOaA@...278...>
Content-Type: multipart/alternative; boundary="001a1143e546037e7e055b3105b4"
Subject: Re: [Openvpn-devel] openvpnserv building under MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel (openvpn-devel@lists.sourceforge.net)" <openvpn-devel@lists.sourceforge.net>

--001a1143e546037e7e055b3105b4
Content-Type: text/plain; charset="UTF-8"

wow.

did you try to build it on App Veyor ? (I tried, no success)

2017-10-10 17:22 GMT+05:00 Simon Rozman <simon@...2293...>:

> Hi!
>
> It's me again - author of the eduVPN client for Windows. This time I have a
> new problem. And, a solution I'd like to share with OpenVPN community.
>
> I am considering bundling openvpn.exe, openvpnserv.exe, and standard TAP
> drivers with eduVPN client to allow some degree of independence from stock
> OpenVPN installations.
>
> However, our version of openvpnserv.exe should have some modifications
> (different named pipe, different registry key) to avoid collision with
> stock
> OpenVPN installation. But that's our long term goal.
>
> Unfortunately, maintaining a mingw build environment for our own OpenVPN
> binaries is an overkill. Therefore, in the first stage, I have updated the
> Microsoft Visual Studio C++ project files to be able to compile
> openvpnserv.exe again:
> - Project files were updated to Microsoft Visual Studio C++ 2017 Community
> Edition.
> - Some minor updates were made to .h/.c files to compile using MSVC again.
> - Support for x64 platform was added.
> - All MSVC warnings were addressed and fixed.
>
> Can I deliver the patches for above?
>
> Best regards,
> Simon Rozman
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--001a1143e546037e7e055b3105b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>wow.<br><br></div>did you try to build it on App Veyo=
r ? (I tried, no success)<br></div><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">2017-10-10 17:22 GMT+05:00 Simon Rozman <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...=
</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi!<br>
<br>
It&#39;s me again - author of the eduVPN client for Windows. This time I ha=
ve a<br>
new problem. And, a solution I&#39;d like to share with OpenVPN community.<=
br>
<br>
I am considering bundling openvpn.exe, openvpnserv.exe, and standard TAP<br>
drivers with eduVPN client to allow some degree of independence from stock<=
br>
OpenVPN installations.<br>
<br>
However, our version of openvpnserv.exe should have some modifications<br>
(different named pipe, different registry key) to avoid collision with stoc=
k<br>
OpenVPN installation. But that&#39;s our long term goal.<br>
<br>
Unfortunately, maintaining a mingw build environment for our own OpenVPN<br>
binaries is an overkill. Therefore, in the first stage, I have updated the<=
br>
Microsoft Visual Studio C++ project files to be able to compile<br>
openvpnserv.exe again:<br>
- Project files were updated to Microsoft Visual Studio C++ 2017 Community<=
br>
Edition.<br>
- Some minor updates were made to .h/.c files to compile using MSVC again.<=
br>
- Support for x64 platform was added.<br>
- All MSVC warnings were addressed and fixed.<br>
<br>
Can I deliver the patches for above?<br>
<br>
Best regards,<br>
Simon Rozman<br>
<br>------------------------------<wbr>------------------------------<wbr>-=
-----------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>_________=
_____________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
<br></blockquote></div><br></div>

--001a1143e546037e7e055b3105b4--

