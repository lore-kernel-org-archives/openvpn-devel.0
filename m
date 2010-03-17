From: <openvpn@...1315...>
Date: Wed, 17 Mar 2010 17:54:44 -0500
Message-id: <1268866484706506500@...1315...>
In-reply-to: <201003172238.23604.dave_br@...1278...>
References: <1268855205316802500@...1315...>
	<201003172238.23604.dave_br@...1278...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=4750486675558971044774438364566234181202=axigen==="
Subject: Re: [Openvpn-devel] Bytecount Reporting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=4750486675558971044774438364566234181202=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Davide,

=20

Yes, that makes sense - and I was going to do that originally, but I figure=
d the real-time bytecount would result in less traffic (and text parsing). =
One question though ... you say "status file". Do you really mean a file? I=
 can execute the status command over the Management Interface, but it's rea=
lly a telnet type response, not in a file.

=20

Thanks,

... Russell


On Wed, Mar 17, 2010 05:38 PM, Davide Brini <dave_br@...1278...> wrote:


>=20
On Wednesday 17 March 2010, openvpn@...1315... wrote:
>=20
> > I am trying to write an application that monitors traffic over an OpenV=
PN
> > link - by using bytecount information from the management interface.
> > However, after I telnet in, and enter "bytecount 1" (for 1 second
> > updates), I find that the real-time bytecount updates are not really ev=
ery
> > second. They seem to be initially, but soon slow down (to an update eve=
ry
> > 5-10 seconds).
>=20
> Sorry for avoiding a direct answer to the question (David has already=20
> addressed that quite well), but I just wanted to tell you that you can ge=
t=20
> byte counts from OpenVPN's status file, ie the one you specify with "--
> status". I used that in the past to monitor clients and traffic (it was=20
> actually a Munin plugin that read the file and collected the data).
> That said, it might not suit your requirements, but I thought I mentioned=
 that=20
> just in case.
>=20
> --
> D.
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

--===axigen=4750486675558971044774438364566234181202=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><P>Hi Davide,</P>
<P>&nbsp;</P>
<P>Yes, that makes sense - and I was going to do that originally, but I fig=
ured the real-time bytecount would result in less traffic (and text parsing=
). One question though ... you say "status file". Do you really mean a file=
? I can execute the status command over the Management Interface, but it's =
really a telnet type response, not in a file.</P>
<P>&nbsp;</P>
<P>Thanks,</P>
<P>... Russell</P>
<P><BR><BR>On Wed, Mar 17, 2010 05:38 PM, Davide&nbsp;Brini&nbsp;&lt;dave_b=
r@...1278...&gt; wrote:<BR></P>
<BLOCKQUOTE style=3D"BORDER-LEFT: rgb(0,0,204) 2px solid; PADDING-LEFT: 4px=
; MARGIN-LEFT: 16px">
<DIV style=3D"FONT-FAMILY: monospace; FONT-SIZE: 10pt">On Wednesday 17 Marc=
h 2010,<A href=3D"mailto:%20openvpn@...1315..." target=3D_blank> openvpn@...1186...=
.1315...</A> wrote:<BR><BR>&gt; I am trying to write an application that mo=
nitors traffic over an OpenVPN<BR>&gt; link - by using bytecount informatio=
n from the management interface.<BR>&gt; However, after I telnet in, and en=
ter "bytecount 1" (for 1 second<BR>&gt; updates), I find that the real-time=
 bytecount updates are not really every<BR>&gt; second. They seem to be ini=
tially, but soon slow down (to an update every<BR>&gt; 5-10 seconds).<BR><B=
R>Sorry for avoiding a direct answer to the question (David has already <BR=
>addressed that quite well), but I just wanted to tell you that you can get=
 <BR>byte counts from OpenVPN's status file, ie the one you specify with "-=
-<BR>status". I used that in the past to monitor clients and traffic (it wa=
s <BR>actually a Munin plugin that read the file and collected the data).<B=
R>That said, it might not suit your requirements, but I thought I mentioned=
 that <BR>just in case.<BR><BR><FONT color=3D#999999>--<BR>D.<BR><BR>------=
------------------------------------------------------------------------<BR=
>Download Intel&amp;#174; Parallel Studio Eval<BR>Try the new software tool=
s for yourself. Speed compiling, find bugs<BR>proactively, and fine-tune ap=
plications for parallel performance.<BR>See why Intel Parallel Studio got h=
igh marks during beta.<BR><A href=3D"http://server:8080/redir.hsp?url=3D%68=
%74%74%70%3A%2F%2F%70%2E%73%66%2E%6E%65%74%2F%73%66%75%2F%69%6E%74%65%6C%2D=
%73%77%2D%64%65%76" target=3D_blank>http://p.sf.net/sfu/intel-sw-dev</A><BR=
>_______________________________________________<BR>Openvpn-devel mailing l=
ist<BR><A href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D_bla=
nk>Openvpn-devel@lists.sourceforge.net</A><BR><A href=3D"http://server:8080=
/redir.hsp?url=3D%68%74%74%70%73%3A%2F%2F%6C%69%73%74%73%2E%73%6F%75%72%63%=
65%66%6F%72%67%65%2E%6E%65%74%2F%6C%69%73%74%73%2F%6C%69%73%74%69%6E%66%6F%=
2F%6F%70%65%6E%76%70%6E%2D%64%65%76%65%6C" target=3D_blank>https://lists.so=
urceforge.net/lists/listinfo/openvpn-devel</A><BR></FONT></DIV></BLOCKQUOTE=
></body></html>=

--===axigen=4750486675558971044774438364566234181202=axigen===--


