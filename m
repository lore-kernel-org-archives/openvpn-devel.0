From: <openvpn@...1315...>
Date: Thu, 04 Mar 2010 17:21:43 -0600
Message-id: <1267744903417725500@...1315...>
In-reply-to: <20100304213523.GF25238@...1296...>
References: <6c75f86b.6552e8f7.4b8bad61.2e7bd@...1309...>
	<4B8BB647.2020804@...1114...>	<23627cf8.610acd4b.4b8bc540.d2023@...1309...>
	<eba800c91003011101v61fb1415l68146f00916b1c7@...278...>
	<7cd17813.52db77fa.4b901800.4e59d@...1309...>
	<20100304213523.GF25238@...1296...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=4422174404120835483677277868000591429813=axigen==="
Subject: Re: [Openvpn-devel] Openvpn 2.1.1 bad tcp performance but
	good	pingwhen -l 1472 (with packet size = MTU)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=4422174404120835483677277868000591429813=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

=20

I just tried this, and at least for my data throughput test it didn't seem =
to help ... buy maybe I have this wrong.

=20

I did this in the client configuration file ... is this right? I checked th=
e OpenVPN web site, and it may be that I need this on the server side inste=
ad. Please clarify and I'll try it again (if I need to).

=20

Thanks!


On Thu, Mar 4, 2010 03:35 PM, Gert Doering <gert@...1296...> wrote:


>=20
Hi,
>=20
> On Thu, Mar 04, 2010 at 09:28:48PM +0100, booyakasha wrote:
> > magic number 2952 (ping ?l 2952). It wasn?t only the 1472 ping
> > packet which worked OK. All packets over 2952 are OK !!! I am
> > waiting for your opinions why packets from 1 byte to 2952 bytes
> > (without 1472 byes package) are going extremely slowly and others not.
>=20
> TCP_NODELAY
>=20
> David has already suggested that you should try setting
>=20
> "socket-flags TCP_NODELAY"
>=20
> - did you?
>=20
> gert
> --
> USENET is *not* the non-clickable part of WWW!
> //http://www.muc.de/~gert/
> Gert Doering - Munich, Germany gert@...1296...
> fax: +49-89-35655025 gert@...1297...
>=20
> -------------------------------------------------------------------------=
-----
> Download Intel=C2=AE Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=

--===axigen=4422174404120835483677277868000591429813=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><P>Hi,</P>
<P>&nbsp;</P>
<P>I just tried this, and at least for my data throughput test it didn't se=
em to help ... buy maybe I have this wrong.</P>
<P>&nbsp;</P>
<P>I did this in the client configuration file ... is this right? I checked=
 the OpenVPN web site, and it may be that I need this on the server side in=
stead. Please clarify and I'll try it again (if I need to).</P>
<P>&nbsp;</P>
<P>Thanks!</P>
<P><BR><BR>On Thu, Mar 4, 2010 03:35 PM, Gert&nbsp;Doering&nbsp;&lt;gert@...1186...=
.1296...&gt; wrote:<BR></P>
<BLOCKQUOTE style=3D"BORDER-LEFT: rgb(0,0,204) 2px solid; PADDING-LEFT: 4px=
; MARGIN-LEFT: 16px">
<DIV style=3D"FONT-FAMILY: monospace; FONT-SIZE: 10pt">Hi,<BR><BR>On Thu, M=
ar 04, 2010 at 09:28:48PM +0100, booyakasha wrote:<BR>&gt; magic number 295=
2 (ping ?l 2952). It wasn?t only the 1472 ping<BR>&gt; packet which worked =
OK. All packets over 2952 are OK !!! I am<BR>&gt; waiting for your opinions=
 why packets from 1 byte to 2952 bytes<BR>&gt; (without 1472 byes package) =
are going extremely slowly and others not.<BR><BR>TCP_NODELAY<BR><BR>David =
has already suggested that you should try setting<BR><BR>"socket-flags TCP_=
NODELAY"<BR><BR>- did you?<BR><BR>gert<BR><FONT color=3D#999999>--<BR>USENE=
T is *not* the non-clickable part of WWW!<BR>//<A href=3D"http://server:808=
0/redir.hsp?url=3D%68%74%74%70%3A%2F%2F%77%77%77%2E%6D%75%63%2E%64%65%2F%7E=
%67%65%72%74%2F" target=3D_blank>http://www.muc.de/~gert/</A><BR>Gert Doeri=
ng - Munich, Germany<A href=3D"mailto:%20%20%20%20%20%20%20%20%20%20%20%20%=
20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20gert@...1296..." target=
=3D_blank> gert@...1296...</A><BR>fax: +49-89-35655025<A href=3D"mailto:%20=
%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20gert@...220...=
..1297..." target=3D_blank> gert@...1297...</A><BR><BR>--------------------=
----------------------------------------------------------<BR>Download Inte=
l&amp;#174; Parallel Studio Eval<BR>Try the new software tools for yourself=
. Speed compiling, find bugs<BR>proactively, and fine-tune applications for=
 parallel performance.<BR>See why Intel Parallel Studio got high marks duri=
ng beta.<BR><A href=3D"http://server:8080/redir.hsp?url=3D%68%74%74%70%3A%2=
F%2F%70%2E%73%66%2E%6E%65%74%2F%73%66%75%2F%69%6E%74%65%6C%2D%73%77%2D%64%6=
5%76" target=3D_blank>http://p.sf.net/sfu/intel-sw-dev</A><BR>_____________=
__________________________________<BR>Openvpn-devel mailing list<BR><A href=
=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D_blank>Openvpn-dev=
el@lists.sourceforge.net</A><BR><A href=3D"http://server:8080/redir.hsp?url=
=3D%68%74%74%70%73%3A%2F%2F%6C%69%73%74%73%2E%73%6F%75%72%63%65%66%6F%72%67=
%65%2E%6E%65%74%2F%6C%69%73%74%73%2F%6C%69%73%74%69%6E%66%6F%2F%6F%70%65%6E=
%76%70%6E%2D%64%65%76%65%6C" target=3D_blank>https://lists.sourceforge.net/=
lists/listinfo/openvpn-devel</A><BR></FONT></DIV></BLOCKQUOTE></body></html=
>=

--===axigen=4422174404120835483677277868000591429813=axigen===--


