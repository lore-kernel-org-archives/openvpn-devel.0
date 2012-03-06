From: Russell Morris <openvpn@...1315...>
Date: Tue, 06 Mar 2012 10:47:52 -0600
Message-id: <1331052472905814500@...1315...>
In-reply-to: <319492303.20120228213418@...449...>
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
	<319492303.20120228213418@...449...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=1070460259142808048429791988536062562288=axigen==="
Subject: [Openvpn-devel] OpenVPN Management Interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?utf-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>
Cc: openvpn-devel@lists.sourceforge.net

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=1070460259142808048429791988536062562288=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

=20

Taking off from the thread below - is it possible in Windows to start openv=
pn, but only as a sort of local server (for lack of a better term)? I would=
 like to start it up, and then be able to initiate connections, tear them d=
own, change proxy, etc. - all via the mangement interface.

=20

Is this possible?

=20

Thanks!

=20

... Russell

=20



On Tue, 02/28/2012 02:34 PM, Carsten Kr=C3=BCger <C.Krueger@...448...> wrot=
e:


>=20
Hello Alon,
>=20
> > This is *THE* missing functionality in Windows environment.
> > It seems that nobody interested in developing proper UI using
> > management interface for Windows.
> > Same goes to proper smartcard support.
>=20
> I found that openvpn management interface works as I'd like it.
>=20
> Add the following lines to client.ovpn
> --------------------------------
> management localhost 1000
> management-query-passwords
> auth-retry interact
> management-hold
> --------------------------------
> and start the service.
>=20
> Use putty to connect to localhost port 1000, format RAW
>=20
> |>INFO:OpenVPN Management Interface Version 1 -- type 'help' for more info
> |>HOLD:Waiting for hold release
> |hold release
> |SUCCESS: hold release succeeded
> |>PASSWORD:Need 'Auth' username/password
> |username Auth here_comes_my_username
> |SUCCESS: 'Auth' username entered, but not yet verified
> |password Auth here_comes_my_mypassword
> |SUCCESS: 'Auth' password entered, but not yet verified
>=20
> et voila openvpn connects.
>=20
> I'd like to cry, how long did this works?
>=20
> I found this in changelog:
> 2004.11.28 -- Version 2.0-beta18
>=20
> * Added management interface. See new --management-*
> options or the full management interface documentation
> in management/management-notes.txt in the tarball.
>=20
>=20
> greetings
> Carsten
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Keep Your Developer Skills Current with LearnDevNow!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> Metro Style Apps, more. Free future releases when you subscribe now!
> http://p.sf.net/sfu/learndevnow-d2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=

--===axigen=1070460259142808048429791988536062562288=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><P>Hi,</P>
<P>&nbsp;</P>
<P>Taking off from the thread below - is it possible in Windows to start op=
envpn, but only as a sort of local server (for lack of a better term)? I wo=
uld like to start it up, and then be able to initiate connections, tear the=
m down, change proxy, etc. - all via the mangement interface.</P>
<P>&nbsp;</P>
<P>Is this possible?</P>
<P>&nbsp;</P>
<P>Thanks!</P>
<P>&nbsp;</P>
<P>... Russell</P>
<P>&nbsp;</P>
<P><BR><BR>On Tue, 02/28/2012 02:34 PM, Carsten&nbsp;Kr=C3=BCger&nbsp;&lt;C=
.Krueger@...448...&gt; wrote:<BR></P>
<BLOCKQUOTE style=3D"BORDER-LEFT: rgb(0,0,204) 2px solid; PADDING-LEFT: 4px=
; MARGIN-LEFT: 16px">
<DIV style=3D"FONT-FAMILY: Arial; FONT-SIZE: 10pt">Hello Alon,<BR><BR>&gt; =
This is *THE* missing functionality in Windows environment.<BR>&gt; It seem=
s that nobody interested in developing proper UI using<BR>&gt; management i=
nterface for Windows.<BR>&gt; Same goes to proper smartcard support.<BR><BR=
>I found that openvpn management interface works as I'd like it.<BR><BR>Add=
 the following lines to client.ovpn<BR>--------------------------------<BR>=
management localhost 1000<BR>management-query-passwords<BR>auth-retry inter=
act<BR>management-hold<BR>--------------------------------<BR>and start the=
 service.<BR><BR>Use putty to connect to localhost port 1000, format RAW<BR=
><BR>|&gt;INFO:OpenVPN Management Interface Version 1 -- type 'help' for mo=
re info<BR>|&gt;HOLD:Waiting for hold release<BR>|hold release<BR>|SUCCESS:=
 hold release succeeded<BR>|&gt;PASSWORD:Need 'Auth' username/password<BR>|=
username Auth here_comes_my_username<BR>|SUCCESS: 'Auth' username entered, =
but not yet verified<BR>|password Auth here_comes_my_mypassword<BR>|SUCCESS=
: 'Auth' password entered, but not yet verified<BR><BR>et voila openvpn con=
nects.<BR><BR>I'd like to cry, how long did this works?<BR><BR>I found this=
 in changelog:<BR>2004.11.28 -- Version 2.0-beta18<BR><BR>* Added managemen=
t interface. See new --management-*<BR>options or the full management inter=
face documentation<BR>in management/management-notes.txt in the tarball.<BR=
><BR><BR>greetings<BR>Carsten<BR><BR><BR>----------------------------------=
--------------------------------------------<BR>Keep Your Developer Skills =
Current with LearnDevNow!<BR>The most comprehensive online learning library=
 for Microsoft developers<BR>is just $99.99! Visual Studio, SharePoint, SQL=
 - plus HTML5, CSS3, MVC3,<BR>Metro Style Apps, more. Free future releases =
when you subscribe now!<BR><A href=3D"http://server.home:8080/redir.hsp?url=
=3D%68%74%74%70%3A%2F%2F%70%2E%73%66%2E%6E%65%74%2F%73%66%75%2F%6C%65%61%72=
%6E%64%65%76%6E%6F%77%2D%64%32%64" target=3D_blank>http://p.sf.net/sfu/lear=
ndevnow-d2d</A><BR>_______________________________________________<BR>Openv=
pn-devel mailing list<BR><A href=3D"mailto:Openvpn-devel@...290...=
net" target=3D_blank>Openvpn-devel@lists.sourceforge.net</A><BR><A href=3D"=
http://server.home:8080/redir.hsp?url=3D%68%74%74%70%73%3A%2F%2F%6C%69%73%7=
4%73%2E%73%6F%75%72%63%65%66%6F%72%67%65%2E%6E%65%74%2F%6C%69%73%74%73%2F%6=
C%69%73%74%69%6E%66%6F%2F%6F%70%65%6E%76%70%6E%2D%64%65%76%65%6C" target=3D=
_blank>https://lists.sourceforge.net/lists/listinfo/openvpn-devel</A><BR></=
DIV></BLOCKQUOTE></body></html>=

--===axigen=1070460259142808048429791988536062562288=axigen===--


