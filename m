MIME-Version: 1.0
References: <CAAWBBYMnFOBo4pp_iZ-KnYu7pHbiLqYQJ3rKO1RF+yXcvivgYg@...278...>
 <20200831132357.GZ75094@...1296...>
 <CAAWBBYNLPWmjJ3whY6FAj2G8tT_qkPWZR-gUsKFHe1memta2Og@...278...>
 <CAAF3xa8T=mmZUQdyF3=AZMZZf46TJ85zH=WwAm7ORZiiGGWqZg@...278...>
 <CAKuzo_iTQWBA3t=to4sKdt21pxotNECVfTMFP_fhrEeQ3ejnQQ@...278...>
 <CAAF3xa_Jz1bjw52zBLLdXjgMymk8q+47kt9R8bP8K9Fpt8+s3g@...278...>
 <CAKuzo_jj0SXCVLrthzeCJddK2iKKXAAg4SGTA_pNRXYqcJfTQw@...278...>
 <CAAF3xa-fQ_m=Tow44wqf3DMqWEq9z90n+6Xgg6NvW-UdTaVjHQ@...278...>
 <CAKuzo_gEfixxkFVz3H4myjX9tQAXgGBMpKMJH4fWF2PesHDKDA@...278...>
 <21A02C2A-4FB5-4E3E-9D9C-B09253C9EBD9@...277...>
 <20200910073321.GR75094@...1296...>
In-Reply-To: <20200910073321.GR75094@...1296...>
From: Marvin <volleynbike@...277...>
Date: Thu, 10 Sep 2020 18:10:17 -0700
Message-ID: <CAAF3xa9CHb_xe0fn5tdiYRx-Bp3gpTfTL-KfHKqMEMdxe+XFkQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000a7a86a05aeff5919"
Subject: Re: [Openvpn-devel] problem with beta3 and wintun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>, Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Rafael Gava de Oliveira <gava100@...277...>

--000000000000a7a86a05aeff5919
Content-Type: text/plain; charset="UTF-8"

To All 3,
Thank you with your help I found the issue. UAC was disabled in the
registry on this image.  IIRC we had trouble updating some software by
automated script and turning UAC off was required.

After re-enabling UAC, wintun started normally.

On Thu, Sep 10, 2020 at 12:33 AM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Thu, Sep 10, 2020 at 12:10:25AM -0700, Marvin Adeff wrote:
> > Please allow me to back up a moment and restate this:
>
> As a matter of mailing list etiquette - could you please not post
> this with
>
>   Subject: Re: [Openvpn-devel] [PATCH] Fix client's poor man NCP fallback
>
> I do try to figure out what is "patch related" and what is "new problems",
> and *this* is certainly not related to the NCP PATCH.
>
>
> > 1.  I installed the beta3 msi from the web site logged in as a user that
> has admin privileges.  But no elevation was used to install it, just
> double-click on the file.
> > 2.  I only used the GUI as installed, with no elevation, to start
> OpenVPN.
> > 3.  With TAP selected in my .ovpn config file, everything works
> normally.
> > 4.  I am reporting that (from the same login) if I change the .ovpn to
> use wintun (all edits done through the GUI selection), it fails with the
> error I showed below.
>
> Is the interactive service running?
>
> If tap is used, do you see "routes installed using service" or do you
> see netsh commands in the openvpn log?
>
> > Is 4. what you are saying is not supported?  In our use, as we have done
> for the past decade, the client boxes are used for M2M monitoring.  OpenVPN
> has to connect on bootup (.ovpn config file contains inline certificates)
> regardless if there is a user logged in or not as M2M monitoring occurs in
> the background.  And if a user does login, most often it is with
> credentials that have admin privileges.  I am trying to understand if what
> you???re telling me is that this will no longer work, or if we will need to
> do something different now?  My testing used the GUI to see how things will
> work with wintun so we can continue testing.
> >
> > Do I need to NOT use the GUI to get wintun to work?
>
> Wintun needs SYSTEM privileges.
>
> To get such, you either need to run OpenVPN "at boot" via openvpnsrv2
> (which has SYSTEM privileges), *or* you need to use the interactive service
> via the GUI.
>
> Due to some Vista-related quirks in the GUI, the GUI will not use the
> iservice if it's run elevated (run-as-admin).  If I understand Selva
> right, it *should* work if you "just run it", even if the user has
> admin privs, as long as UAC is active (as Win10 runs user processes
> unprivileged, even if the user is part of the Admin group).
>
>
> The error message you have posted hints at "the interactive service is
> not being used" - which could be due to "it is not running" or "GUI is
> running elevated".
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
>

--000000000000a7a86a05aeff5919
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">To All 3,<div>Thank you with your help I found the issue. =
UAC was disabled in the registry on this image.=C2=A0 IIRC we had trouble u=
pdating some software by automated script and turning UAC off was required.=
</div><div><br></div><div>After re-enabling UAC, wintun started normally.</=
div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Thu, Sep 10, 2020 at 12:33 AM Gert Doering &lt;<a href=3D"mailto:ger=
t@...1296...">gert@...1296...</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Hi,<br>
<br>
On Thu, Sep 10, 2020 at 12:10:25AM -0700, Marvin Adeff wrote:<br>
&gt; Please allow me to back up a moment and restate this:<br>
<br>
As a matter of mailing list etiquette - could you please not post<br>
this with<br>
<br>
=C2=A0 Subject: Re: [Openvpn-devel] [PATCH] Fix client&#39;s poor man NCP f=
allback<br>
<br>
I do try to figure out what is &quot;patch related&quot; and what is &quot;=
new problems&quot;,<br>
and *this* is certainly not related to the NCP PATCH.<br>
<br>
<br>
&gt; 1.=C2=A0 I installed the beta3 msi from the web site logged in as a us=
er that has admin privileges.=C2=A0 But no elevation was used to install it=
, just double-click on the file. <br>
&gt; 2.=C2=A0 I only used the GUI as installed, with no elevation, to start=
 OpenVPN. <br>
&gt; 3.=C2=A0 With TAP selected in my .ovpn config file, everything works n=
ormally. <br>
&gt; 4.=C2=A0 I am reporting that (from the same login) if I change the .ov=
pn to use wintun (all edits done through the GUI selection), it fails with =
the error I showed below. <br>
<br>
Is the interactive service running?<br>
<br>
If tap is used, do you see &quot;routes installed using service&quot; or do=
 you<br>
see netsh commands in the openvpn log?<br>
<br>
&gt; Is 4. what you are saying is not supported?=C2=A0 In our use, as we ha=
ve done for the past decade, the client boxes are used for M2M monitoring.=
=C2=A0 OpenVPN has to connect on bootup (.ovpn config file contains inline =
certificates) regardless if there is a user logged in or not as M2M monitor=
ing occurs in the background.=C2=A0 And if a user does login, most often it=
 is with credentials that have admin privileges.=C2=A0 I am trying to under=
stand if what you???re telling me is that this will no longer work, or if w=
e will need to do something different now?=C2=A0 My testing used the GUI to=
 see how things will work with wintun so we can continue testing. <br>
&gt; <br>
&gt; Do I need to NOT use the GUI to get wintun to work?=C2=A0 <br>
<br>
Wintun needs SYSTEM privileges.<br>
<br>
To get such, you either need to run OpenVPN &quot;at boot&quot; via openvpn=
srv2<br>
(which has SYSTEM privileges), *or* you need to use the interactive service=
<br>
via the GUI.<br>
<br>
Due to some Vista-related quirks in the GUI, the GUI will not use the<br>
iservice if it&#39;s run elevated (run-as-admin).=C2=A0 If I understand Sel=
va<br>
right, it *should* work if you &quot;just run it&quot;, even if the user ha=
s<br>
admin privs, as long as UAC is active (as Win10 runs user processes<br>
unprivileged, even if the user is part of the Admin group).<br>
<br>
<br>
The error message you have posted hints at &quot;the interactive service is=
<br>
not being used&quot; - which could be due to &quot;it is not running&quot; =
or &quot;GUI is<br>
running elevated&quot;.<br>
<br>
gert<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
</blockquote></div>

--000000000000a7a86a05aeff5919--

