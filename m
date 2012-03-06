From: Russell Morris <openvpn@...1315...>
Date: Tue, 06 Mar 2012 11:42:40 -0600
Message-id: <1331055760398534500@...1315...>
In-reply-to: <CAOazyz0K7NONN9uFsqD5_uF_xmApF7BUmE8Wg_tarejrf5aVbw@...278...>
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
	<319492303.20120228213418@...449...>	<1331052472905814500@...1315...>
	<CAOazyz0K7NONN9uFsqD5_uF_xmApF7BUmE8Wg_tarejrf5aVbw@...278...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=4586090461220235815383999149195155746659=axigen==="
Subject: Re: [Openvpn-devel] OpenVPN Management Interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: =?utf-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>, openvpn-devel@lists.sourceforge.net

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=4586090461220235815383999149195155746659=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

=20

That makes sense - thanks! I'm not a security expert by any means, so the t=
hread lost me when it diverged into this area ... :-(.

=20

At the risk of asking a stupid question (but that is my specialty ... :-)) =
- is there a conclusion of how to deal with this?

=20

Thanks again,

... Russell

=20

=20


On Tue, 03/06/2012 11:12 AM, Alon Bar-Lev <alon.barlev@...277...> wrote:


>=20
This exactly what we discuss at the privilege separation thread...
> Currently to change configuration you need to start a process.
>=20
> 2012/3/6 Russell Morris <openvpn@...1315...>:
> > Hi,
> >
> >
> >
> > Taking off from the thread below - is it possible in Windows to start
> > openvpn, but only as a sort of local server (for lack of a better term)=
? I
> > would like to start it up, and then be able to initiate connections, te=
ar
> > them down, change proxy, etc. - all via the mangement interface.
> >
> >
> >
> > Is this possible?
> >
> >
> >
> > Thanks!
> >
> >
> >
> > ... Russell
> >
> >
> >
> >
> >
> > On Tue, 02/28/2012 02:34 PM, Carsten Kr=C3=BCger <C.Krueger@...448...> =
wrote:
> >
> > Hello Alon,
> >
> >> This is *THE* missing functionality in Windows environment.
> >> It seems that nobody interested in developing proper UI using
> >> management interface for Windows.
> >> Same goes to proper smartcard support.
> >
> > I found that openvpn management interface works as I'd like it.
> >
> > Add the following lines to client.ovpn
> > --------------------------------
> > management localhost 1000
> > management-query-passwords
> > auth-retry interact
> > management-hold
> > --------------------------------
> > and start the service.
> >
> > Use putty to connect to localhost port 1000, format RAW
> >
> > |>INFO:OpenVPN Management Interface Version 1 -- type 'help' for more i=
nfo
> > |>HOLD:Waiting for hold release
> > |hold release
> > |SUCCESS: hold release succeeded
> > |>PASSWORD:Need 'Auth' username/password
> > |username Auth here_comes_my_username
> > |SUCCESS: 'Auth' username entered, but not yet verified
> > |password Auth here_comes_my_mypassword
> > |SUCCESS: 'Auth' password entered, but not yet verified
> >
> > et voila openvpn connects.
> >
> > I'd like to cry, how long did this works?
> >
> > I found this in changelog:
> > 2004.11.28 -- Version 2.0-beta18
> >
> > * Added management interface. See new --management-*
> > options or the full management interface documentation
> > in management/management-notes.txt in the tarball.
> >
> >
> > greetings
> > Carsten
> >
> >
> > -----------------------------------------------------------------------=
-------
> > Keep Your Developer Skills Current with LearnDevNow!
> > The most comprehensive online learning library for Microsoft developers
> > is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> > Metro Style Apps, more. Free future releases when you subscribe now!
> > http://p.sf.net/sfu/learndevnow-d2d
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >
> >
> > -----------------------------------------------------------------------=
-------
> > Keep Your Developer Skills Current with LearnDevNow!
> > The most comprehensive online learning library for Microsoft developers
> > is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> > Metro Style Apps, more. Free future releases when you subscribe now!
> > http://p.sf.net/sfu/learndevnow-d2d
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >
>=20=

--===axigen=4586090461220235815383999149195155746659=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><P>Hi,</P>
<P>&nbsp;</P>
<P>That makes sense - thanks! I'm not a security expert by any means, so th=
e thread lost me when it diverged into this area ... :-(.</P>
<P>&nbsp;</P>
<P>At the risk of asking a stupid question (but that is my specialty ... :-=
)) - is there a conclusion of how to deal with this?</P>
<P>&nbsp;</P>
<P>Thanks again,</P>
<P>... Russell</P>
<P>&nbsp;</P>
<P>&nbsp;</P>
<P><BR>On Tue, 03/06/2012 11:12 AM, Alon&nbsp;Bar-Lev&nbsp;&lt;alon.barlev@=
...277...&gt; wrote:<BR></P>
<BLOCKQUOTE style=3D"BORDER-LEFT: rgb(0,0,204) 2px solid; PADDING-LEFT: 4px=
; MARGIN-LEFT: 16px">
<DIV style=3D"FONT-FAMILY: Arial; FONT-SIZE: 10pt">This exactly what we dis=
cuss at the privilege separation thread...<BR>Currently to change configura=
tion you need to start a process.<BR><BR>2012/3/6 Russell Morris &lt;<A hre=
f=3D"mailto:openvpn@...1315..." target=3D_blank>openvpn@...1315...</A>&gt;:=
<BR>&gt; Hi,<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt; Taking off from the thread bel=
ow - is it possible in Windows to start<BR>&gt; openvpn, but only as a sort=
 of local server (for lack of a better term)? I<BR>&gt; would like to start=
 it up, and then be able to initiate connections, tear<BR>&gt; them down, c=
hange proxy, etc. - all via the mangement interface.<BR>&gt;<BR>&gt;<BR>&gt=
;<BR>&gt; Is this possible?<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt; Thanks!<BR>&gt;=
<BR>&gt;<BR>&gt;<BR>&gt; ... Russell<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt=
;<BR>&gt; On Tue, 02/28/2012 02:34 PM, Carsten&nbsp;Kr=C3=BCger&nbsp;&lt;<A=
 href=3D"mailto:C.Krueger@...448..." target=3D_blank>C.Krueger@...448...</A=
>&gt; wrote:<BR>&gt;<BR>&gt; Hello Alon,<BR>&gt;<BR>&gt;&gt; This is *THE* =
missing functionality in Windows environment.<BR>&gt;&gt; It seems that nob=
ody interested in developing proper UI using<BR>&gt;&gt; management interfa=
ce for Windows.<BR>&gt;&gt; Same goes to proper smartcard support.<BR>&gt;<=
BR>&gt; I found that openvpn management interface works as I'd like it.<BR>=
&gt;<BR>&gt; Add the following lines to client.ovpn<BR>&gt; ---------------=
-----------------<BR>&gt; management localhost 1000<BR>&gt; management-quer=
y-passwords<BR>&gt; auth-retry interact<BR>&gt; management-hold<BR>&gt; ---=
-----------------------------<BR>&gt; and start the service.<BR>&gt;<BR>&gt=
; Use putty to connect to localhost port 1000, format RAW<BR>&gt;<BR>&gt; |=
&gt;INFO:OpenVPN Management Interface Version 1 -- type 'help' for more inf=
o<BR>&gt; |&gt;HOLD:Waiting for hold release<BR>&gt; |hold release<BR>&gt; =
|SUCCESS: hold release succeeded<BR>&gt; |&gt;PASSWORD:Need 'Auth' username=
/password<BR>&gt; |username Auth here_comes_my_username<BR>&gt; |SUCCESS: '=
Auth' username entered, but not yet verified<BR>&gt; |password Auth here_co=
mes_my_mypassword<BR>&gt; |SUCCESS: 'Auth' password entered, but not yet ve=
rified<BR>&gt;<BR>&gt; et voila openvpn connects.<BR>&gt;<BR>&gt; I'd like =
to cry, how long did this works?<BR>&gt;<BR>&gt; I found this in changelog:=
<BR>&gt; 2004.11.28 -- Version 2.0-beta18<BR>&gt;<BR>&gt; * Added managemen=
t interface. See new --management-*<BR>&gt; options or the full management =
interface documentation<BR>&gt; in management/management-notes.txt in the t=
arball.<BR>&gt;<BR>&gt;<BR>&gt; greetings<BR>&gt; Carsten<BR>&gt;<BR>&gt;<B=
R>&gt; --------------------------------------------------------------------=
----------<BR>&gt; Keep Your Developer Skills Current with LearnDevNow!<BR>=
&gt; The most comprehensive online learning library for Microsoft developer=
s<BR>&gt; is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3=
, MVC3,<BR>&gt; Metro Style Apps, more. Free future releases when you subsc=
ribe now!<BR>&gt; <A href=3D"http://server.home:8080/redir.hsp?url=3D%68%74=
%74%70%3A%2F%2F%70%2E%73%66%2E%6E%65%74%2F%73%66%75%2F%6C%65%61%72%6E%64%65=
%76%6E%6F%77%2D%64%32%64" target=3D_blank>http://p.sf.net/sfu/learndevnow-d=
2d</A><BR>&gt; _______________________________________________<BR>&gt; Open=
vpn-devel mailing list<BR>&gt;<A href=3D"mailto:%20Openvpn-devel@...1439...=
ceforge.net" target=3D_blank> Openvpn-devel@lists.sourceforge.net</A><BR>&g=
t; <A href=3D"http://server.home:8080/redir.hsp?url=3D%68%74%74%70%73%3A%2F=
%2F%6C%69%73%74%73%2E%73%6F%75%72%63%65%66%6F%72%67%65%2E%6E%65%74%2F%6C%69=
%73%74%73%2F%6C%69%73%74%69%6E%66%6F%2F%6F%70%65%6E%76%70%6E%2D%64%65%76%65=
%6C" target=3D_blank>https://lists.sourceforge.net/lists/listinfo/openvpn-d=
evel</A><BR>&gt;<BR>&gt;<BR>&gt; ------------------------------------------=
------------------------------------<BR>&gt; Keep Your Developer Skills Cur=
rent with LearnDevNow!<BR>&gt; The most comprehensive online learning libra=
ry for Microsoft developers<BR>&gt; is just $99.99! Visual Studio, SharePoi=
nt, SQL - plus HTML5, CSS3, MVC3,<BR>&gt; Metro Style Apps, more. Free futu=
re releases when you subscribe now!<BR>&gt; <A href=3D"http://server.home:8=
080/redir.hsp?url=3D%68%74%74%70%3A%2F%2F%70%2E%73%66%2E%6E%65%74%2F%73%66%=
75%2F%6C%65%61%72%6E%64%65%76%6E%6F%77%2D%64%32%64" target=3D_blank>http://=
p.sf.net/sfu/learndevnow-d2d</A><BR>&gt; __________________________________=
_____________<BR>&gt; Openvpn-devel mailing list<BR>&gt;<A href=3D"mailto:%=
20Openvpn-devel@lists.sourceforge.net" target=3D_blank> Openvpn-devel@...1697...=
.sourceforge.net</A><BR>&gt; <A href=3D"http://server.home:8080/redir.hsp?u=
rl=3D%68%74%74%70%73%3A%2F%2F%6C%69%73%74%73%2E%73%6F%75%72%63%65%66%6F%72%=
67%65%2E%6E%65%74%2F%6C%69%73%74%73%2F%6C%69%73%74%69%6E%66%6F%2F%6F%70%65%=
6E%76%70%6E%2D%64%65%76%65%6C" target=3D_blank>https://lists.sourceforge.ne=
t/lists/listinfo/openvpn-devel</A><BR>&gt;<BR></DIV></BLOCKQUOTE></body></h=
tml>=

--===axigen=4586090461220235815383999149195155746659=axigen===--


