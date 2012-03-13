MIME-Version: 1.0
In-Reply-To: <CAOazyz1vHGfX-M+h7LEgXDA=1d0f_stRqvH08U9b++5gddWAPg@...278...>
References: <CABT9mj_+3KRELoLQBGK5B14Q=Y_HGGjS48E6bEWnDPuCwBXgtw@...278...>
	<CAOazyz0zS1WjVrLv1u22ZN+cr18ewuzeZnc-5PrSHjss1Cn=ew@...278...>
	<CABT9mj9Xjs6T_hCA-pcEPUaoCe4ZxZ8-yGHB_MeDReM=wHBa8Q@...278...>
	<CABT9mj96OXMejAXm3bp3SxY-OHespaPV_tdiYcpCk01BoC94xg@...278...>
	<CAOazyz1vHGfX-M+h7LEgXDA=1d0f_stRqvH08U9b++5gddWAPg@...278...>
Date: Tue, 13 Mar 2012 20:59:09 +0200
Message-ID: <CABT9mj97qvvdif9wJw4iUZ+514_Xxo1ZUD=MtbZKB11PXpXYxg@...278...>
From: Athanasios Douitsis <aduitsis@...277...>
Content-Type: multipart/alternative; boundary=0015174c10e037e66b04bb2474aa
Subject: Re: [Openvpn-devel] mingw32-built openvpn-2.3-alpha1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--0015174c10e037e66b04bb2474aa
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Mar 13, 2012 at 7:51 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:

> On Tue, Mar 13, 2012 at 7:27 PM, Athanasios Douitsis <aduitsis@...277...>
> wrote:
> >
> > Hi again,
> >
> > Some more feedback.
> >
> > 1.Trying to use MSVC2010 (or later I suppose) to build the project using
> > the new method outlined in your link, I noticed that 'vcbuild' has been
> > removed after vc2008. They recommend using msbuild, whatever that is,
> which
> > requires different cli parameters  and also requires that the project be
> > converted accordingly. You may want to note this for future reference. I
> > haven't been able to compile, currently trying to find a VC2008
> installation
> > to try again.
>
> Thanks!
> I will try MSVC2010... need to find time to install that.
> However, please note that the mingw is the configuration that is most
> flexible and probably be maintained....
>


A question then: The generic method is supposed to be invoked from cmd or
from the cygwin shell? Because I suspect the cygwin bash shell dislikes the
carriage returns in the build script so naturally one must convert the
files before running it. Even after converting, I saw further errors, but I
want to view them carefully before reporting.

Kind Regards,
Athanasios




>
> >
> > 2.Sometimes the script fails to download the parts that are hosted on
> > github, I suspect because github emits a 302.
>
> All?
> This is strange....
> The script tries to redirect by location response header...
> Can you please add WScript.Echo(location) after the var location= so
> we can what we get?
> And maybe add WScript.Echo(http.GetAllReponseHeaders());
>
> Thanks!
>



-- 
Athanasios Douitsis

--0015174c10e037e66b04bb2474aa
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, Mar 13, 2012 at 7:51 PM, Alon Ba=
r-Lev <span dir=3D"ltr">&lt;<a href=3D"mailto:alon.barlev@...277...">alon.b=
arlev@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On Tue, Mar 13, 2012 at 7:27 PM, Athanasios Douitsis &lt;=
<a href=3D"mailto:aduitsis@...277...">aduitsis@...277...</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi again,<br>
&gt;<br>
&gt; Some more feedback.<br>
&gt;<br>
&gt; 1.Trying to use MSVC2010 (or later I suppose) to build the project usi=
ng<br>
&gt; the new method outlined in your link, I noticed that &#39;vcbuild&#39;=
 has been<br>
&gt; removed after vc2008. They recommend using msbuild, whatever that is, =
which<br>
&gt; requires different cli parameters=A0 and also requires that the projec=
t be<br>
&gt; converted accordingly. You may want to note this for future reference.=
 I<br>
&gt; haven&#39;t been able to compile, currently trying to find a VC2008 in=
stallation<br>
&gt; to try again.<br>
<br>
</div>Thanks!<br>
I will try MSVC2010... need to find time to install that.<br>
However, please note that the mingw is the configuration that is most<br>
flexible and probably be maintained....<br></blockquote><div><br><br>A ques=
tion then: The generic method is supposed to be invoked from cmd or from th=
e cygwin shell? Because I suspect the cygwin bash shell dislikes the carria=
ge returns in the build script so naturally one must convert the files befo=
re running it. Even after converting, I saw further errors, but I want to v=
iew them carefully before reporting.=A0 <br>
<br>Kind Regards,<br>Athanasios<br><br><br>=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<div class=3D"im"><br>
&gt;<br>
&gt; 2.Sometimes the script fails to download the parts that are hosted on<=
br>
&gt; github, I suspect because github emits a 302.<br>
<br>
</div>All?<br>
This is strange....<br>
The script tries to redirect by location response header...<br>
Can you please add WScript.Echo(location) after the var location=3D so<br>
we can what we get?<br>
And maybe add WScript.Echo(http.GetAllReponseHeaders());<br>
<br>
Thanks!<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Athanasios Douitsis<br>=
<br><br><br>

--0015174c10e037e66b04bb2474aa--

