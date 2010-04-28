From: <openvpn@...1315...>
Date: Wed, 28 Apr 2010 09:12:29 -0500
Message-id: <1272463949884053500@...1315...>
In-reply-to: <4BD83FC0.5090607@...515...>
References: <4BD83FC0.5090607@...515...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=8964960892123299284241925086544265090032=axigen==="
Subject: Re: [Openvpn-devel] Any volunteer Windows devs to change OpenVPN
 proxying code to use "new" InternetQueryOption API?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?utf-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=8964960892123299284241925086544265090032=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Samuli,

=20

Very interesting timing! Just last night I was poking about about this a bi=
t, and I'm not so sure that the proxy approach noted so far is the best / r=
ight way to do this. Rather, to be able to handle dynamic (not just static)=
 proxy configurations the WinHTTP API looks to me to be the way to do this =
(see http://msdn.microsoft.com/en-us/library/aa384097(v=3DVS.85).aspx for a=
n example).

=20

I hope this helps!

=20

... Russell

=20

=20


On Wed, Apr 28, 2010 09:01 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wrot=
e:


>=20
Hi all,
>=20
> A while back a user noticed that OpenVPN still uses old IE4 API to
> detect proxy settings (e.g. in proxy.c and ieproxy.c). This apparently
> causes problems with IE's proxy detection on some Windows installations.
> A "new" InternetQueryOption API was introduced in IE5, so this part of
> OpenVPN would benefit from an upgrade anyways. Would somebody be
> interested in taking up this task? We seem to have a shortage of Windows
> devs, so any help would be most welcome!
>=20
> For more information about this issue can be found from here:
>=20
> * http://thread.gmane.org/gmane.network.openvpn.devel/3446
> * http://support.microsoft.com/kb/226473
>=20
> If I've misunderstood the problem, please send clarifications - proxy
> usage in OpenVPN is still pretty vague to me :)
>=20
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>=20
> irc freenode net: mattock
>=20
>=20
> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=

--===axigen=8964960892123299284241925086544265090032=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><P>Hi Samuli,</P>
<P>&nbsp;</P>
<P>Very interesting timing! Just last night I was poking about about this a=
 bit, and I'm not so sure that the proxy approach noted so far is the best =
/ right way to do this. Rather, to be able to handle dynamic (not just stat=
ic) proxy configurations the WinHTTP API looks to me to be the way to do th=
is (see <A href=3D"http://msdn.microsoft.com/en-us/library/aa384097(v=3DVS.=
85).aspx">http://msdn.microsoft.com/en-us/library/aa384097(v=3DVS.85).aspx<=
/A>&nbsp;for an example).</P>
<P>&nbsp;</P>
<P>I hope this helps!</P>
<P>&nbsp;</P>
<P>... Russell</P>
<P>&nbsp;</P>
<P>&nbsp;</P>
<P><BR><BR>On Wed, Apr 28, 2010 09:01 AM, Samuli&nbsp;Sepp=C3=A4nen&nbsp;&l=
t;samuli@...515...&gt; wrote:<BR></P>
<BLOCKQUOTE style=3D"BORDER-LEFT: rgb(0,0,204) 2px solid; PADDING-LEFT: 4px=
; MARGIN-LEFT: 16px">
<DIV style=3D"FONT-FAMILY: monospace; FONT-SIZE: 10pt">Hi all,<BR><BR>A whi=
le back a user noticed that OpenVPN still uses old IE4 API to<BR>detect pro=
xy settings (e.g. in proxy.c and ieproxy.c). This apparently<BR>causes prob=
lems with IE's proxy detection on some Windows installations.<BR>A "new" In=
ternetQueryOption API was introduced in IE5, so this part of<BR>OpenVPN wou=
ld benefit from an upgrade anyways. Would somebody be<BR>interested in taki=
ng up this task? We seem to have a shortage of Windows<BR>devs, so any help=
 would be most welcome!<BR><BR>For more information about this issue can be=
 found from here:<BR><BR>* <A href=3D"http://server:8080/redir.hsp?url=3D%6=
8%74%74%70%3A%2F%2F%74%68%72%65%61%64%2E%67%6D%61%6E%65%2E%6F%72%67%2F%67%6=
D%61%6E%65%2E%6E%65%74%77%6F%72%6B%2E%6F%70%65%6E%76%70%6E%2E%64%65%76%65%6=
C%2F%33%34%34%36" target=3D_blank>http://thread.gmane.org/gmane.network.ope=
nvpn.devel/3446</A><BR>* <A href=3D"http://server:8080/redir.hsp?url=3D%68%=
74%74%70%3A%2F%2F%73%75%70%70%6F%72%74%2E%6D%69%63%72%6F%73%6F%66%74%2E%63%=
6F%6D%2F%6B%62%2F%32%32%36%34%37%33" target=3D_blank>http://support.microso=
ft.com/kb/226473</A><BR><BR>If I've misunderstood the problem, please send =
clarifications - proxy<BR>usage in OpenVPN is still pretty vague to me :)<B=
R><BR><FONT color=3D#999999>--<BR>Samuli Sepp=C3=A4nen<BR>Community Manager=
<BR>OpenVPN Technologies, Inc<BR><BR>irc freenode net: mattock<BR><BR><BR>-=
---------------------------------------------------------------------------=
--<BR>_______________________________________________<BR>Openvpn-devel mail=
ing list<BR><A href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=
=3D_blank>Openvpn-devel@lists.sourceforge.net</A><BR><A href=3D"http://serv=
er:8080/redir.hsp?url=3D%68%74%74%70%73%3A%2F%2F%6C%69%73%74%73%2E%73%6F%75=
%72%63%65%66%6F%72%67%65%2E%6E%65%74%2F%6C%69%73%74%73%2F%6C%69%73%74%69%6E=
%66%6F%2F%6F%70%65%6E%76%70%6E%2D%64%65%76%65%6C" target=3D_blank>https://l=
ists.sourceforge.net/lists/listinfo/openvpn-devel</A><BR></FONT></DIV></BLO=
CKQUOTE></body></html>=

--===axigen=8964960892123299284241925086544265090032=axigen===--


