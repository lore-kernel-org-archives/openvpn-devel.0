MIME-Version: 1.0
References: <8d6cbe40-bbc0-ddd4-ed5b-1acb9b6967fb@...277...>
In-Reply-To: <8d6cbe40-bbc0-ddd4-ed5b-1acb9b6967fb@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 18 Feb 2021 14:13:55 -0500
Message-ID: <CAKuzo_hxUNby2-PSV+eJwDs0gvaePzs9tjTx9LGEXxwM2ye1nA@...278...>
Content-Type: multipart/alternative; boundary="000000000000fbe15b05bba12324"
Subject: Re: [Openvpn-devel] [Openvpn-devel/users] Debugging Windows based
 server scripts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincanteksup <tincanteksup@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

--000000000000fbe15b05bba12324
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Feb 17, 2021 at 5:38 PM tincanteksup <tincanteksup@...277...> wrote:

> Hi,
>
> due to not being allowed to have scripts "echo data" to the log file
> under Windows, debugging scripts is next to impossible.
>
> I presume there are no compile time options to enable "echo" under Windows
> ?
>
> Could anybody provide me with a patch to enable "echo" just for the
> purpose of debugging ?
>
> I would like the patch to work for Openvpn 2.5
>
> I understand the risks and I am not distributing OpenVPN binaries.
>
> As justification I make these points:
>
> * Any large distributor of Openvpn binaries could make the change to
> enable "echo" under Windows.
>
> * That distributor could then abuse it as they please.
>
> * I am simply asking for help for the purpose of debugging Open Source
> Software made for the community.


If it's for debugging, why not redirect the output of the scripts? There
are several ways of doing this like:

(i) replace the script by a wrapper

@echo off
rem this wrapper calls the actual up_script_orig.bat
call up_script_orig.bat >up_script.log 2>&1
exit /b

(ii) move the script to a function and call it, redirecting o/p

@echo off
call :do_work >up_script.log 2>&1
exit /b

:do_work
@echo on
@rem the original script follows..
....
....
@rem end of script
@echo off
exit /b

Selva

--000000000000fbe15b05bba12324
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Feb 17, 2021 at 5:38 PM tincanteksup &lt;<=
a href=3D"mailto:tincanteksup@...277..." target=3D"_blank">tincanteksup@...493...=
277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Hi,<br>
<br>
due to not being allowed to have scripts &quot;echo data&quot; to the log f=
ile <br>
under Windows, debugging scripts is next to impossible.<br>
<br>
I presume there are no compile time options to enable &quot;echo&quot; unde=
r Windows ?<br>
<br>
Could anybody provide me with a patch to enable &quot;echo&quot; just for t=
he <br>
purpose of debugging ?<br>
<br>
I would like the patch to work for Openvpn 2.5<br>
<br>
I understand the risks and I am not distributing OpenVPN binaries.<br>
<br>
As justification I make these points:<br>
<br>
* Any large distributor of Openvpn binaries could make the change to <br>
enable &quot;echo&quot; under Windows.<br>
<br>
* That distributor could then abuse it as they please.<br>
<br>
* I am simply asking for help for the purpose of debugging Open Source <br>
Software made for the community.</blockquote><div><br></div><div>If it&#39;=
s=C2=A0for debugging, why not redirect the output of the scripts? There are=
 several ways of doing this like:</div><div><br></div><div>(i) replace the =
script by a wrapper</div><div><br></div><div>@echo off<br></div><div>rem th=
is wrapper calls the actual up_script_orig.bat</div><div>call up_script_ori=
g.bat &gt;up_script.log 2&gt;&amp;1</div><div>exit /b</div><div><br></div><=
div>(ii) move the script to a function and call it, redirecting o/p</div><d=
iv><br></div><div>@echo off<br></div><div>call :do_work &gt;up_script.log 2=
&gt;&amp;1</div><div>exit /b</div><div><br></div><div>:do_work</div><div>@e=
cho on<br></div><div>@rem the original script follows..</div><div>....</div=
><div>....</div><div>@rem=C2=A0end=C2=A0of script</div><div>@echo off<br></=
div><div>exit /b</div><div><br></div><div>Selva</div></div></div>

--000000000000fbe15b05bba12324--

