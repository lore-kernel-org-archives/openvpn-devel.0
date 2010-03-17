From: <openvpn@...1315...>
Date: Wed, 17 Mar 2010 17:01:02 -0500
Message-id: <1268863262384008500@...1315...>
In-reply-to: <4BA1511E.5060202@...1114...>
References: <1268855205316802500@...1315...>
	<4BA1433A.8090808@...1114...> <1268862004900065500@...1315...>
	<4BA1511E.5060202@...1114...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=8758003141573323283412822654342878303751=axigen==="
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
--===axigen=8758003141573323283412822654342878303751=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

=20

All very good questions! Some thoughts, below.

=20

Thanks for all your help!

=20

... Russell


On Wed, Mar 17, 2010 05:01 PM, David Sommerseth <openvpn.list@...1114...> w=
rote:


>=20
On 17/03/10 22:40, openvpn@...1315... wrote:
> > Hi,
> >=20
> >=20
> >=20
> > I'm running OpenVPN (client) on Windows - connecting to a Linux Server.=
=20
>=20
> I'm presuming you're connecting to the management interface on the Linux
> server.
>> Russell: No, on the local client (i.e. on Windows). This avoids having t=
o send information over the link (=3Dwasted bandwidth, and lower speed).
>=20
>=20
> > I am wondering if a value isn't reported if there is no traffic - that =
could be part of this=20
>=20
> I have a feeling this is the reality. As I don't see any timer alarms
> scheduled in the management part of the code. So I need to see this
> more in connection with the main part of the event loop code. But I
> believe this is the case.
>> Russell: Understood - if it is please just let me know.
>=20
> > (though it would be better to report information anyways).
> >=20
> > Make sense?
>=20
> Yeah, I can see your point. But isn't the information going to be
> rather useless if it hasn't changed? If there is no change, no need to
> dump the same info once again. What do you think?
>> Russell: I understand your point, but I'm also wanting to show transfer =
rate, and plot the data (which would be easiest if the data arrives uniform=
ly). Not a huge issue, but I would to at least like to understand why this =
is the case. I guess if this is the way it works it should at least be capt=
ured in the documentation for the Management Interface, right?
>=20
>=20
> kind regards,
>=20
> David Sommerseth
>=20
>=20
>=20
> > On Wed, Mar 17, 2010 04:01 PM, David Sommerseth <openvpn.list@...1332...=
.> wrote:
> >=20
> >=20
> >>
> > On 17/03/10 20:46, openvpn@...1315... wrote:
> >>> Hi,
> >>>
> >>> I am trying to write an application that monitors traffic over an Ope=
nVPN link - by using bytecount information from the management interface. H=
owever, after I telnet in, and enter "bytecount 1" (for 1 second updates), =
I find that the real-time bytecount updates are not really every second. Th=
ey seem to be initially, but soon slow down (to an update every 5-10 second=
s).
> >>>
> >>> Is this expected, or a known issue?
> >>
> >> Hi,
> >>
> >> I'd say this is probably unexpected. But I'd like to know a little bit
> >> more about your setup. What kind of OS are you running OpenVPN?
> >>
> >> It sounds like your OpenVPN process get lower priority somehow. But it
> >> could also be that it is dependent on the amount of traffic passing ov=
er
> >> the tunnel. I'll dig more into the code to see if there are some
> >> oddities there before concluding.
> >>
> >>
> >> kind regards,
> >>
> >> David Sommerseth
> >>
>=20
>=20=

--===axigen=8758003141573323283412822654342878303751=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><P>Hi,</P>
<P>&nbsp;</P>
<P>All very good questions! Some thoughts, below.</P>
<P>&nbsp;</P>
<P>Thanks for all your help!</P>
<P>&nbsp;</P>
<P>... Russell</P>
<P><BR><BR>On Wed, Mar 17, 2010 05:01 PM, David&nbsp;Sommerseth&nbsp;&lt;op=
envpn.list@...1114...&gt; wrote:<BR></P>
<BLOCKQUOTE style=3D"BORDER-LEFT: rgb(0,0,204) 2px solid; PADDING-LEFT: 4px=
; MARGIN-LEFT: 16px">
<DIV style=3D"FONT-FAMILY: monospace; FONT-SIZE: 10pt">On 17/03/10 22:40,<A=
 href=3D"mailto:%20openvpn@...1315..." target=3D_blank> openvpn@...1315...<=
/A> wrote:<BR>&gt; Hi,<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; I'm running OpenV=
PN (client) on Windows - connecting to a Linux Server. <BR><BR>I'm presumin=
g you're connecting to the management interface on the Linux<BR>server.</DI=
V>
<DIV style=3D"FONT-FAMILY: monospace; FONT-SIZE: 10pt">&gt;&gt; Russell: No=
, on the local client (i.e. on Windows). This avoids having to send informa=
tion over the link (=3Dwasted bandwidth, and lower speed).<BR><BR><BR>&gt; =
I am wondering if a value isn't reported if there is no traffic - that coul=
d be part of this <BR><BR>I have a feeling this is the reality. As I don't =
see any timer alarms<BR>scheduled in the management part of the code. So I =
need to see this<BR>more in connection with the main part of the event loop=
 code. But I<BR>believe this is the case.</DIV>
<DIV style=3D"FONT-FAMILY: monospace; FONT-SIZE: 10pt">&gt;&gt; Russell: Un=
derstood - if it is please just let me know.</DIV>
<DIV style=3D"FONT-FAMILY: monospace; FONT-SIZE: 10pt"><BR><BR>&gt; (though=
 it would be better to report information anyways).<BR>&gt; <BR>&gt; Make s=
ense?<BR><BR>Yeah, I can see your point. But isn't the information going to=
 be<BR>rather useless if it hasn't changed? If there is no change, no need =
to<BR>dump the same info once again. What do you think?</DIV>
<DIV style=3D"FONT-FAMILY: monospace; FONT-SIZE: 10pt">&gt;&gt; Russell: I =
understand your point, but I'm also wanting to show transfer rate, and plot=
 the data (which would be easiest if the data arrives uniformly). Not a hug=
e issue, but I would to at least like to understand why this is the case. I=
 guess if this is the way it works it should at least be captured in the do=
cumentation for the Management Interface, right?<BR><BR><BR>kind regards,<B=
R><BR>David Sommerseth<BR><BR><BR><BR>&gt; On Wed, Mar 17, 2010 04:01 PM, D=
avid Sommerseth &lt;<A href=3D"mailto:openvpn.list@...1114..." target=3D_bl=
ank>openvpn.list@...1114...</A>&gt; wrote:<BR>&gt; <BR>&gt; <BR>&gt;&gt;<BR=
>&gt; On 17/03/10 20:46,<A href=3D"mailto:%20openvpn@...1315..." target=3D_=
blank> openvpn@...1315...</A> wrote:<BR>&gt;&gt;&gt; Hi,<BR>&gt;&gt;&gt;<BR=
>&gt;&gt;&gt; I am trying to write an application that monitors traffic ove=
r an OpenVPN link - by using bytecount information from the management inte=
rface. However, after I telnet in, and enter "bytecount 1" (for 1 second up=
dates), I find that the real-time bytecount updates are not really every se=
cond. They seem to be initially, but soon slow down (to an update every 5-1=
0 seconds).<BR>&gt;&gt;&gt;<BR>&gt;&gt;&gt; Is this expected, or a known is=
sue?<BR>&gt;&gt;<BR>&gt;&gt; Hi,<BR>&gt;&gt;<BR>&gt;&gt; I'd say this is pr=
obably unexpected. But I'd like to know a little bit<BR>&gt;&gt; more about=
 your setup. What kind of OS are you running OpenVPN?<BR>&gt;&gt;<BR>&gt;&g=
t; It sounds like your OpenVPN process get lower priority somehow. But it<B=
R>&gt;&gt; could also be that it is dependent on the amount of traffic pass=
ing over<BR>&gt;&gt; the tunnel. I'll dig more into the code to see if ther=
e are some<BR>&gt;&gt; oddities there before concluding.<BR>&gt;&gt;<BR>&gt=
;&gt;<BR>&gt;&gt; kind regards,<BR>&gt;&gt;<BR>&gt;&gt; David Sommerseth<BR=
>&gt;&gt;<BR><BR></DIV></BLOCKQUOTE></body></html>=

--===axigen=8758003141573323283412822654342878303751=axigen===--


