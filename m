From: <openvpn@...1315...>
Date: Wed, 17 Mar 2010 16:40:04 -0500
Message-id: <1268862004900065500@...1315...>
In-reply-to: <4BA1433A.8090808@...1114...>
References: <1268855205316802500@...1315...>
	<4BA1433A.8090808@...1114...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=7822106090276041392190221487081704366054=axigen==="
Subject: Re: [Openvpn-devel] Bytecount Reporting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=7822106090276041392190221487081704366054=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

=20

I'm running OpenVPN (client) on Windows - connecting to a Linux Server. I a=
m wondering if a value isn't reported if there is no traffic - that could b=
e part of this (though it would be better to report information anyways).

=20

Make sense?

=20

Thanks!

=20

... Russell


On Wed, Mar 17, 2010 04:01 PM, David Sommerseth <openvpn.list@...1114...> w=
rote:


>=20
On 17/03/10 20:46, openvpn@...1315... wrote:
> > Hi,
> >=20
> > I am trying to write an application that monitors traffic over an OpenV=
PN link - by using bytecount information from the management interface. How=
ever, after I telnet in, and enter "bytecount 1" (for 1 second updates), I =
find that the real-time bytecount updates are not really every second. They=
 seem to be initially, but soon slow down (to an update every 5-10 seconds).
> >=20
> > Is this expected, or a known issue?
>=20
> Hi,
>=20
> I'd say this is probably unexpected. But I'd like to know a little bit
> more about your setup. What kind of OS are you running OpenVPN?
>=20
> It sounds like your OpenVPN process get lower priority somehow. But it
> could also be that it is dependent on the amount of traffic passing over
> the tunnel. I'll dig more into the code to see if there are some
> oddities there before concluding.
>=20
>=20
> kind regards,
>=20
> David Sommerseth
>=20=

--===axigen=7822106090276041392190221487081704366054=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><P>Hi,</P>
<P>&nbsp;</P>
<P>I'm running OpenVPN (client) on Windows - connecting to a Linux Server. =
I am wondering if a value isn't reported if there is no traffic - that coul=
d be part of this (though it would be better to report information anyways)=
.</P>
<P>&nbsp;</P>
<P>Make sense?</P>
<P>&nbsp;</P>
<P>Thanks!</P>
<P>&nbsp;</P>
<P>... Russell</P>
<P><BR><BR>On Wed, Mar 17, 2010 04:01 PM, David&nbsp;Sommerseth&nbsp;&lt;op=
envpn.list@...1114...&gt; wrote:<BR></P>
<BLOCKQUOTE style=3D"BORDER-LEFT: rgb(0,0,204) 2px solid; PADDING-LEFT: 4px=
; MARGIN-LEFT: 16px">
<DIV style=3D"FONT-FAMILY: monospace; FONT-SIZE: 10pt">On 17/03/10 20:46,<A=
 href=3D"mailto:%20openvpn@...1315..." target=3D_blank> openvpn@...1315...<=
/A> wrote:<BR>&gt; Hi,<BR>&gt; <BR>&gt; I am trying to write an application=
 that monitors traffic over an OpenVPN link - by using bytecount informatio=
n from the management interface. However, after I telnet in, and enter "byt=
ecount 1" (for 1 second updates), I find that the real-time bytecount updat=
es are not really every second. They seem to be initially, but soon slow do=
wn (to an update every 5-10 seconds).<BR>&gt; <BR>&gt; Is this expected, or=
 a known issue?<BR><BR>Hi,<BR><BR>I'd say this is probably unexpected. But =
I'd like to know a little bit<BR>more about your setup. What kind of OS are=
 you running OpenVPN?<BR><BR>It sounds like your OpenVPN process get lower =
priority somehow. But it<BR>could also be that it is dependent on the amoun=
t of traffic passing over<BR>the tunnel. I'll dig more into the code to see=
 if there are some<BR>oddities there before concluding.<BR><BR><BR>kind reg=
ards,<BR><BR>David Sommerseth<BR></DIV></BLOCKQUOTE></body></html>=

--===axigen=7822106090276041392190221487081704366054=axigen===--


